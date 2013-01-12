using pruebaViewGrid;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.OracleClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace pruebaGridView
{
    public partial class Menu : Form
    {
        DataTable tablaAux = new DataTable();
        public Menu()
        {
            InitializeComponent();
        }

        public void llenarTabla(OracleDataReader tablaBD)
        {

            
           
        }

        private void nombreReporte_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Trabajador trab = new Trabajador();
            trab.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Cargos cargo = new Cargos();
            cargo.Show();

        }

        private void button3_Click(object sender, EventArgs e)
        {
            Musico musico = new Musico();
            musico.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Bailarines b = new Bailarines();
            b.Show();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            MusicoInvitado mi = new MusicoInvitado();
            mi.Show();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            BailarinesInvitados bi = new BailarinesInvitados();
            bi.Show();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            Cantante1 c = new Cantante1();
            c.Show();
        }

        private void button9_Click(object sender, EventArgs e)
        {
            Coreografo co = new Coreografo();
            co.Show();
        }

        private void button10_Click(object sender, EventArgs e)
        {
            DirectorMusical dm = new DirectorMusical();
            dm.Show();
        }

        private void button11_Click(object sender, EventArgs e)
        {
            DirectorObra d = new DirectorObra();
            d.Show();
        }

        private void button12_Click(object sender, EventArgs e)
        {

        }

        private void button13_Click(object sender, EventArgs e)
        {
           // Autor1 a = new Autor1();
            //a.show();

        }

        private void button15_Click(object sender, EventArgs e)
        {
            Facturas f = new Facturas();
            f.Show();
        }

        private void button16_Click(object sender, EventArgs e)
        {
            Calendario cal = new Calendario();
            cal.Show();
        }

        private void button17_Click(object sender, EventArgs e)
        {
            EntradasVendidas ev = new EntradasVendidas();
            ev.Show();

        }

        private void button18_Click(object sender, EventArgs e)
        {
            VentaEntradas ve = new VentaEntradas();
            ve.Show();
        }

        private void button8_Click(object sender, EventArgs e)
        {

        }

        private void Menu_Load(object sender, EventArgs e)
        {

        }




   }

     

     

    }
