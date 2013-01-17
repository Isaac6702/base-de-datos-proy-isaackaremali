using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.OracleClient;

namespace pruebaViewGrid
{
    class Conexion
    {
        private OracleConnection conexion;

        public bool AbrirConexion(string usuario, string clave)
        {
            try
            {
                conexion = new OracleConnection("Data Source=XE; User Id=" + usuario + "; Password=" + clave + ";");
                conexion.Open();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public OracleDataReader EjecutarSelect(string sql)
        {

            OracleCommand cmd = new OracleCommand(sql);
            cmd.Connection = conexion;
            cmd.CommandType = CommandType.Text;
            OracleDataReader reader = null;

            try
            {
             
                reader = cmd.ExecuteReader();

                //while (reader.Read())
                //{
                //    //Esto hay que ver como modificarlo para que retorne la tabla
                //    Console.WriteLine(Convert.ToString(reader["id"]));
                //}
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                cmd.Dispose();
            }
            return reader;
        }


        public int EjecutarInsert(string sql)
        {

            OracleCommand cmd = new OracleCommand(sql);
            cmd.Connection = conexion;
            cmd.CommandType = CommandType.Text;
            try
            {

                return cmd.ExecuteNonQuery();

                //while (reader.Read())
                //{
                //    //Esto hay que ver como modificarlo para que retorne la tabla
                //    Console.WriteLine(Convert.ToString(reader["id"]));
                //}
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                cmd.Dispose();
            }

            return 0;
        }

        public bool Ejecutar(string sql)
        {

            OracleCommand command = new OracleCommand(sql);
            command.Connection = conexion;

            try
            {
                command.ExecuteNonQuery();
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return false;
            }
        }


        public DataTable  procemiento(string nombre)
        {
            OracleCommand cmd = new OracleCommand(nombre, conexion);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("REC_CUR", OracleType.Cursor).Direction = ParameterDirection.Output;
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            dt.Load((OracleDataReader) cmd.Parameters["REC_CUR"].Value);
            return dt;
        }
    }
}
