﻿namespace pruebaGridView
{
    partial class Reservas
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
            this.tabla = new System.Windows.Forms.DataGridView();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.nombreReporte = new System.Windows.Forms.Label();
            this.BTBuscar = new System.Windows.Forms.Button();
            this.TBIdReserva = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.TBIdUsuario = new System.Windows.Forms.TextBox();
            this.LBnombre = new System.Windows.Forms.Label();
            this.TBNombre = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.TBApellido = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.TBOpera = new System.Windows.Forms.TextBox();
            this.LBFechaReserva = new System.Windows.Forms.Label();
            this.TBFechaReserva = new System.Windows.Forms.TextBox();
            this.LBFechaOpera = new System.Windows.Forms.Label();
            this.TBFechaOpera = new System.Windows.Forms.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this.tabla)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // tabla
            // 
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.Color.Black;
            this.tabla.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            this.tabla.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.tabla.AutoSizeRowsMode = System.Windows.Forms.DataGridViewAutoSizeRowsMode.AllCells;
            this.tabla.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.tabla.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.tabla.CellBorderStyle = System.Windows.Forms.DataGridViewCellBorderStyle.None;
            this.tabla.ColumnHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.ButtonShadow;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.tabla.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle2;
            this.tabla.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle3.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle3.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle3.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle3.SelectionBackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle3.SelectionForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.tabla.DefaultCellStyle = dataGridViewCellStyle3;
            this.tabla.ImeMode = System.Windows.Forms.ImeMode.On;
            this.tabla.Location = new System.Drawing.Point(141, 88);
            this.tabla.MultiSelect = false;
            this.tabla.Name = "tabla";
            this.tabla.ReadOnly = true;
            this.tabla.RowHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle4.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle4.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle4.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle4.SelectionBackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle4.SelectionForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle4.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.tabla.RowHeadersDefaultCellStyle = dataGridViewCellStyle4;
            this.tabla.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.AutoSizeToDisplayedHeaders;
            this.tabla.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.tabla.ShowCellErrors = false;
            this.tabla.ShowCellToolTips = false;
            this.tabla.ShowEditingIcon = false;
            this.tabla.ShowRowErrors = false;
            this.tabla.Size = new System.Drawing.Size(834, 492);
            this.tabla.TabIndex = 0;
            this.tabla.TabStop = false;
            // 
            // pictureBox2
            // 
            this.pictureBox2.Image = global::pruebaGridView.Properties.Resources.black;
            this.pictureBox2.Location = new System.Drawing.Point(-2, 0);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(137, 580);
            this.pictureBox2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox2.TabIndex = 2;
            this.pictureBox2.TabStop = false;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::pruebaGridView.Properties.Resources.roh_red;
            this.pictureBox1.Location = new System.Drawing.Point(12, 12);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(106, 153);
            this.pictureBox1.TabIndex = 1;
            this.pictureBox1.TabStop = false;
            // 
            // nombreReporte
            // 
            this.nombreReporte.AutoSize = true;
            this.nombreReporte.Font = new System.Drawing.Font("Arial Rounded MT Bold", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.nombreReporte.Location = new System.Drawing.Point(448, 9);
            this.nombreReporte.Name = "nombreReporte";
            this.nombreReporte.Size = new System.Drawing.Size(249, 28);
            this.nombreReporte.TabIndex = 3;
            this.nombreReporte.Text = "Reservas realizadas";
            // 
            // BTBuscar
            // 
            this.BTBuscar.Location = new System.Drawing.Point(899, 59);
            this.BTBuscar.Name = "BTBuscar";
            this.BTBuscar.Size = new System.Drawing.Size(63, 23);
            this.BTBuscar.TabIndex = 4;
            this.BTBuscar.Text = "Buscar";
            this.BTBuscar.UseVisualStyleBackColor = true;
            this.BTBuscar.Click += new System.EventHandler(this.BTBuscar_Click);
            // 
            // TBIdReserva
            // 
            this.TBIdReserva.Location = new System.Drawing.Point(227, 62);
            this.TBIdReserva.Name = "TBIdReserva";
            this.TBIdReserva.Size = new System.Drawing.Size(100, 20);
            this.TBIdReserva.TabIndex = 5;
            this.TBIdReserva.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.TBIdReserva_KeyPress);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(163, 65);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(61, 13);
            this.label1.TabIndex = 6;
            this.label1.Text = "ID Reserva";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(360, 40);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(57, 13);
            this.label2.TabIndex = 8;
            this.label2.Text = "ID Usuario";
            // 
            // TBIdUsuario
            // 
            this.TBIdUsuario.Location = new System.Drawing.Point(420, 38);
            this.TBIdUsuario.Name = "TBIdUsuario";
            this.TBIdUsuario.Size = new System.Drawing.Size(100, 20);
            this.TBIdUsuario.TabIndex = 7;
            this.TBIdUsuario.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.TBIdUsuario_KeyPress);
            // 
            // LBnombre
            // 
            this.LBnombre.AutoSize = true;
            this.LBnombre.Location = new System.Drawing.Point(543, 41);
            this.LBnombre.Name = "LBnombre";
            this.LBnombre.Size = new System.Drawing.Size(44, 13);
            this.LBnombre.TabIndex = 10;
            this.LBnombre.Text = "Nombre";
            // 
            // TBNombre
            // 
            this.TBNombre.Location = new System.Drawing.Point(590, 38);
            this.TBNombre.Name = "TBNombre";
            this.TBNombre.Size = new System.Drawing.Size(100, 20);
            this.TBNombre.TabIndex = 9;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(733, 40);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(44, 13);
            this.label3.TabIndex = 12;
            this.label3.Text = "Apellido";
            // 
            // TBApellido
            // 
            this.TBApellido.Location = new System.Drawing.Point(780, 37);
            this.TBApellido.Name = "TBApellido";
            this.TBApellido.Size = new System.Drawing.Size(100, 20);
            this.TBApellido.TabIndex = 11;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(551, 65);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(36, 13);
            this.label4.TabIndex = 14;
            this.label4.Text = "Opera";
            // 
            // TBOpera
            // 
            this.TBOpera.Location = new System.Drawing.Point(590, 62);
            this.TBOpera.Name = "TBOpera";
            this.TBOpera.Size = new System.Drawing.Size(100, 20);
            this.TBOpera.TabIndex = 13;
            // 
            // LBFechaReserva
            // 
            this.LBFechaReserva.AutoSize = true;
            this.LBFechaReserva.Location = new System.Drawing.Point(337, 65);
            this.LBFechaReserva.Name = "LBFechaReserva";
            this.LBFechaReserva.Size = new System.Drawing.Size(80, 13);
            this.LBFechaReserva.TabIndex = 16;
            this.LBFechaReserva.Text = "Fecha Reserva";
            // 
            // TBFechaReserva
            // 
            this.TBFechaReserva.Location = new System.Drawing.Point(420, 62);
            this.TBFechaReserva.Name = "TBFechaReserva";
            this.TBFechaReserva.Size = new System.Drawing.Size(100, 20);
            this.TBFechaReserva.TabIndex = 15;
            // 
            // LBFechaOpera
            // 
            this.LBFechaOpera.AutoSize = true;
            this.LBFechaOpera.Location = new System.Drawing.Point(708, 65);
            this.LBFechaOpera.Name = "LBFechaOpera";
            this.LBFechaOpera.Size = new System.Drawing.Size(69, 13);
            this.LBFechaOpera.TabIndex = 18;
            this.LBFechaOpera.Text = "Fecha Opera";
            // 
            // TBFechaOpera
            // 
            this.TBFechaOpera.Location = new System.Drawing.Point(780, 62);
            this.TBFechaOpera.Name = "TBFechaOpera";
            this.TBFechaOpera.Size = new System.Drawing.Size(100, 20);
            this.TBFechaOpera.TabIndex = 17;
            // 
            // Reservas
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.ClientSize = new System.Drawing.Size(974, 581);
            this.Controls.Add(this.LBFechaOpera);
            this.Controls.Add(this.TBFechaOpera);
            this.Controls.Add(this.LBFechaReserva);
            this.Controls.Add(this.TBFechaReserva);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.TBOpera);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.TBApellido);
            this.Controls.Add(this.LBnombre);
            this.Controls.Add(this.TBNombre);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.TBIdUsuario);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.TBIdReserva);
            this.Controls.Add(this.BTBuscar);
            this.Controls.Add(this.nombreReporte);
            this.Controls.Add(this.tabla);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.pictureBox2);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(990, 620);
            this.MinimumSize = new System.Drawing.Size(990, 620);
            this.Name = "Reservas";
            this.Text = "Reservas realizadas";
            ((System.ComponentModel.ISupportInitialize)(this.tabla)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView tabla;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.PictureBox pictureBox2;
        private System.Windows.Forms.Label nombreReporte;
        private System.Windows.Forms.Button BTBuscar;
        private System.Windows.Forms.TextBox TBIdReserva;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox TBIdUsuario;
        private System.Windows.Forms.Label LBnombre;
        private System.Windows.Forms.TextBox TBNombre;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox TBApellido;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox TBOpera;
        private System.Windows.Forms.Label LBFechaReserva;
        private System.Windows.Forms.TextBox TBFechaReserva;
        private System.Windows.Forms.Label LBFechaOpera;
        private System.Windows.Forms.TextBox TBFechaOpera;
    }
}

