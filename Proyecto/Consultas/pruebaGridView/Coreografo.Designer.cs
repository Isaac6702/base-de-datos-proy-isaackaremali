namespace pruebaGridView
{
    partial class Coreografo
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Coreografo));
            this.tabla = new System.Windows.Forms.DataGridView();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.nombreReporte = new System.Windows.Forms.Label();
            this.LBPrimerApellido = new System.Windows.Forms.Label();
            this.TBNombes = new System.Windows.Forms.TextBox();
            this.LBSegundoApellido = new System.Windows.Forms.Label();
            this.TBApellidos = new System.Windows.Forms.TextBox();
            this.LBIdentificador = new System.Windows.Forms.Label();
            this.TBIdentificador = new System.Windows.Forms.TextBox();
            this.BTBuscar = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.TBNacionalidad = new System.Windows.Forms.TextBox();
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
            this.tabla.Size = new System.Drawing.Size(940, 492);
            this.tabla.TabIndex = 0;
            this.tabla.TabStop = false;
            // 
            // pictureBox2
            // 
            this.pictureBox2.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox2.Image")));
            this.pictureBox2.Location = new System.Drawing.Point(-2, 0);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(137, 580);
            this.pictureBox2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox2.TabIndex = 2;
            this.pictureBox2.TabStop = false;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
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
            this.nombreReporte.Location = new System.Drawing.Point(486, 12);
            this.nombreReporte.Name = "nombreReporte";
            this.nombreReporte.Size = new System.Drawing.Size(237, 28);
            this.nombreReporte.TabIndex = 3;
            this.nombreReporte.Text = "Datos  Coreografos";
            // 
            // LBPrimerApellido
            // 
            this.LBPrimerApellido.AutoSize = true;
            this.LBPrimerApellido.Location = new System.Drawing.Point(285, 67);
            this.LBPrimerApellido.Name = "LBPrimerApellido";
            this.LBPrimerApellido.Size = new System.Drawing.Size(49, 13);
            this.LBPrimerApellido.TabIndex = 9;
            this.LBPrimerApellido.Text = "Nombres";
            // 
            // TBNombes
            // 
            this.TBNombes.Location = new System.Drawing.Point(338, 64);
            this.TBNombes.Name = "TBNombes";
            this.TBNombes.Size = new System.Drawing.Size(100, 20);
            this.TBNombes.TabIndex = 8;
            // 
            // LBSegundoApellido
            // 
            this.LBSegundoApellido.AutoSize = true;
            this.LBSegundoApellido.Location = new System.Drawing.Point(458, 67);
            this.LBSegundoApellido.Name = "LBSegundoApellido";
            this.LBSegundoApellido.Size = new System.Drawing.Size(49, 13);
            this.LBSegundoApellido.TabIndex = 11;
            this.LBSegundoApellido.Text = "Apellidos";
            // 
            // TBApellidos
            // 
            this.TBApellidos.Location = new System.Drawing.Point(511, 64);
            this.TBApellidos.Name = "TBApellidos";
            this.TBApellidos.Size = new System.Drawing.Size(100, 20);
            this.TBApellidos.TabIndex = 10;
            this.TBApellidos.TextChanged += new System.EventHandler(this.TBApellidos_TextChanged);
            // 
            // LBIdentificador
            // 
            this.LBIdentificador.AutoSize = true;
            this.LBIdentificador.Location = new System.Drawing.Point(838, 68);
            this.LBIdentificador.Name = "LBIdentificador";
            this.LBIdentificador.Size = new System.Drawing.Size(65, 13);
            this.LBIdentificador.TabIndex = 13;
            this.LBIdentificador.Text = "Identificador";
            // 
            // TBIdentificador
            // 
            this.TBIdentificador.Location = new System.Drawing.Point(904, 65);
            this.TBIdentificador.Name = "TBIdentificador";
            this.TBIdentificador.Size = new System.Drawing.Size(100, 20);
            this.TBIdentificador.TabIndex = 12;
            this.TBIdentificador.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.TBIdentificador_KeyPress);
            // 
            // BTBuscar
            // 
            this.BTBuscar.Location = new System.Drawing.Point(1013, 62);
            this.BTBuscar.Name = "BTBuscar";
            this.BTBuscar.Size = new System.Drawing.Size(63, 23);
            this.BTBuscar.TabIndex = 14;
            this.BTBuscar.Text = "Buscar";
            this.BTBuscar.UseVisualStyleBackColor = true;
            this.BTBuscar.Click += new System.EventHandler(this.BTBuscar_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(641, 67);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(69, 13);
            this.label1.TabIndex = 16;
            this.label1.Text = "Nacionalidad";
            // 
            // TBNacionalidad
            // 
            this.TBNacionalidad.Location = new System.Drawing.Point(712, 64);
            this.TBNacionalidad.Name = "TBNacionalidad";
            this.TBNacionalidad.Size = new System.Drawing.Size(100, 20);
            this.TBNacionalidad.TabIndex = 15;
            // 
            // Coreografo
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.ClientSize = new System.Drawing.Size(1083, 581);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.TBNacionalidad);
            this.Controls.Add(this.BTBuscar);
            this.Controls.Add(this.LBIdentificador);
            this.Controls.Add(this.TBIdentificador);
            this.Controls.Add(this.LBSegundoApellido);
            this.Controls.Add(this.TBApellidos);
            this.Controls.Add(this.LBPrimerApellido);
            this.Controls.Add(this.TBNombes);
            this.Controls.Add(this.nombreReporte);
            this.Controls.Add(this.tabla);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.pictureBox2);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(1099, 620);
            this.MinimumSize = new System.Drawing.Size(1099, 620);
            this.Name = "Coreografo";
            this.Text = "Datos Coreografos";
            this.Load += new System.EventHandler(this.Coreografo_Load);
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
        private System.Windows.Forms.Label LBPrimerApellido;
        private System.Windows.Forms.TextBox TBNombes;
        private System.Windows.Forms.Label LBSegundoApellido;
        private System.Windows.Forms.TextBox TBApellidos;
        private System.Windows.Forms.Label LBIdentificador;
        private System.Windows.Forms.TextBox TBIdentificador;
        private System.Windows.Forms.Button BTBuscar;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox TBNacionalidad;
    }
}

