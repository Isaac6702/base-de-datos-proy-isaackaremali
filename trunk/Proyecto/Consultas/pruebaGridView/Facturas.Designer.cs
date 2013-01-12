namespace pruebaGridView
{
    partial class Facturas
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle5 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle6 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle7 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle8 = new System.Windows.Forms.DataGridViewCellStyle();
            this.tabla = new System.Windows.Forms.DataGridView();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.nombreReporte = new System.Windows.Forms.Label();
            this.LBNroFactura = new System.Windows.Forms.Label();
            this.LBFecha = new System.Windows.Forms.Label();
            this.LBNombres = new System.Windows.Forms.Label();
            this.LBNroId = new System.Windows.Forms.Label();
            this.LBTotal = new System.Windows.Forms.Label();
            this.LBDireccion = new System.Windows.Forms.Label();
            this.LBTelefono = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.TBBuscar = new System.Windows.Forms.TextBox();
            this.BTBuscar = new System.Windows.Forms.Button();
            this.shapeContainer1 = new Microsoft.VisualBasic.PowerPacks.ShapeContainer();
            this.lineShape1 = new Microsoft.VisualBasic.PowerPacks.LineShape();
            ((System.ComponentModel.ISupportInitialize)(this.tabla)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // tabla
            // 
            dataGridViewCellStyle5.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            dataGridViewCellStyle5.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            dataGridViewCellStyle5.SelectionForeColor = System.Drawing.Color.Black;
            this.tabla.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle5;
            this.tabla.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.tabla.AutoSizeRowsMode = System.Windows.Forms.DataGridViewAutoSizeRowsMode.AllCells;
            this.tabla.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.tabla.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.tabla.CellBorderStyle = System.Windows.Forms.DataGridViewCellBorderStyle.None;
            this.tabla.ColumnHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle6.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle6.BackColor = System.Drawing.SystemColors.ButtonShadow;
            dataGridViewCellStyle6.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle6.ForeColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle6.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle6.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle6.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.tabla.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle6;
            this.tabla.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridViewCellStyle7.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle7.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle7.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle7.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle7.SelectionBackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle7.SelectionForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle7.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.tabla.DefaultCellStyle = dataGridViewCellStyle7;
            this.tabla.ImeMode = System.Windows.Forms.ImeMode.On;
            this.tabla.Location = new System.Drawing.Point(141, 166);
            this.tabla.MultiSelect = false;
            this.tabla.Name = "tabla";
            this.tabla.ReadOnly = true;
            this.tabla.RowHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle8.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle8.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle8.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle8.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle8.SelectionBackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle8.SelectionForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle8.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.tabla.RowHeadersDefaultCellStyle = dataGridViewCellStyle8;
            this.tabla.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.AutoSizeToDisplayedHeaders;
            this.tabla.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.tabla.ShowCellErrors = false;
            this.tabla.ShowCellToolTips = false;
            this.tabla.ShowEditingIcon = false;
            this.tabla.ShowRowErrors = false;
            this.tabla.Size = new System.Drawing.Size(834, 353);
            this.tabla.TabIndex = 0;
            this.tabla.TabStop = false;
            this.tabla.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.tabla_CellContentClick);
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
            this.nombreReporte.Location = new System.Drawing.Point(473, 9);
            this.nombreReporte.Name = "nombreReporte";
            this.nombreReporte.Size = new System.Drawing.Size(114, 28);
            this.nombreReporte.TabIndex = 3;
            this.nombreReporte.Text = "Facturas";
            // 
            // LBNroFactura
            // 
            this.LBNroFactura.AutoSize = true;
            this.LBNroFactura.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.LBNroFactura.Location = new System.Drawing.Point(846, 91);
            this.LBNroFactura.Name = "LBNroFactura";
            this.LBNroFactura.Size = new System.Drawing.Size(88, 16);
            this.LBNroFactura.TabIndex = 4;
            this.LBNroFactura.Text = "Nro Factura: -";
            // 
            // LBFecha
            // 
            this.LBFecha.AutoSize = true;
            this.LBFecha.Location = new System.Drawing.Point(846, 107);
            this.LBFecha.Name = "LBFecha";
            this.LBFecha.Size = new System.Drawing.Size(46, 13);
            this.LBFecha.TabIndex = 5;
            this.LBFecha.Text = "Fecha: -";
            this.LBFecha.Click += new System.EventHandler(this.LBFecha_Click);
            // 
            // LBNombres
            // 
            this.LBNombres.AutoSize = true;
            this.LBNombres.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.LBNombres.Location = new System.Drawing.Point(141, 104);
            this.LBNombres.Name = "LBNombres";
            this.LBNombres.Size = new System.Drawing.Size(144, 16);
            this.LBNombres.TabIndex = 6;
            this.LBNombres.Text = "Nombres y Apellidos: -";
            // 
            // LBNroId
            // 
            this.LBNroId.AutoSize = true;
            this.LBNroId.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.LBNroId.Location = new System.Drawing.Point(565, 104);
            this.LBNroId.Name = "LBNroId";
            this.LBNroId.Size = new System.Drawing.Size(135, 16);
            this.LBNroId.TabIndex = 7;
            this.LBNroId.Text = "Nro de Identificador: -";
            // 
            // LBTotal
            // 
            this.LBTotal.AutoSize = true;
            this.LBTotal.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.LBTotal.Location = new System.Drawing.Point(846, 537);
            this.LBTotal.Name = "LBTotal";
            this.LBTotal.Size = new System.Drawing.Size(62, 18);
            this.LBTotal.TabIndex = 8;
            this.LBTotal.Text = "Total: -";
            // 
            // LBDireccion
            // 
            this.LBDireccion.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.LBDireccion.Location = new System.Drawing.Point(141, 131);
            this.LBDireccion.Name = "LBDireccion";
            this.LBDireccion.Size = new System.Drawing.Size(418, 32);
            this.LBDireccion.TabIndex = 9;
            this.LBDireccion.Text = "Direccion: -";
            // 
            // LBTelefono
            // 
            this.LBTelefono.AutoSize = true;
            this.LBTelefono.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.LBTelefono.Location = new System.Drawing.Point(565, 131);
            this.LBTelefono.Name = "LBTelefono";
            this.LBTelefono.Size = new System.Drawing.Size(69, 16);
            this.LBTelefono.TabIndex = 10;
            this.LBTelefono.Text = "Telefonos";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(726, 51);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(63, 13);
            this.label1.TabIndex = 11;
            this.label1.Text = "Nro Factura";
            // 
            // TBBuscar
            // 
            this.TBBuscar.Location = new System.Drawing.Point(792, 48);
            this.TBBuscar.Name = "TBBuscar";
            this.TBBuscar.Size = new System.Drawing.Size(100, 20);
            this.TBBuscar.TabIndex = 12;
            this.TBBuscar.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.textBox1_KeyPress);
            // 
            // BTBuscar
            // 
            this.BTBuscar.Location = new System.Drawing.Point(898, 46);
            this.BTBuscar.Name = "BTBuscar";
            this.BTBuscar.Size = new System.Drawing.Size(63, 23);
            this.BTBuscar.TabIndex = 13;
            this.BTBuscar.Text = "Buscar";
            this.BTBuscar.UseVisualStyleBackColor = true;
            this.BTBuscar.Click += new System.EventHandler(this.BTBuscar_Click);
            // 
            // shapeContainer1
            // 
            this.shapeContainer1.Location = new System.Drawing.Point(0, 0);
            this.shapeContainer1.Margin = new System.Windows.Forms.Padding(0);
            this.shapeContainer1.Name = "shapeContainer1";
            this.shapeContainer1.Shapes.AddRange(new Microsoft.VisualBasic.PowerPacks.Shape[] {
            this.lineShape1});
            this.shapeContainer1.Size = new System.Drawing.Size(974, 581);
            this.shapeContainer1.TabIndex = 14;
            this.shapeContainer1.TabStop = false;
            // 
            // lineShape1
            // 
            this.lineShape1.BorderColor = System.Drawing.SystemColors.ButtonFace;
            this.lineShape1.Name = "lineShape1";
            this.lineShape1.X1 = 137;
            this.lineShape1.X2 = 971;
            this.lineShape1.Y1 = 78;
            this.lineShape1.Y2 = 78;
            // 
            // Facturas
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.ClientSize = new System.Drawing.Size(974, 581);
            this.Controls.Add(this.BTBuscar);
            this.Controls.Add(this.TBBuscar);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.LBTelefono);
            this.Controls.Add(this.LBDireccion);
            this.Controls.Add(this.LBTotal);
            this.Controls.Add(this.LBNroId);
            this.Controls.Add(this.LBNombres);
            this.Controls.Add(this.LBFecha);
            this.Controls.Add(this.LBNroFactura);
            this.Controls.Add(this.nombreReporte);
            this.Controls.Add(this.tabla);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.pictureBox2);
            this.Controls.Add(this.shapeContainer1);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(990, 620);
            this.MinimumSize = new System.Drawing.Size(990, 620);
            this.Name = "Facturas";
            this.Text = "Facturas";
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
        private System.Windows.Forms.Label LBNroFactura;
        private System.Windows.Forms.Label LBFecha;
        private System.Windows.Forms.Label LBNombres;
        private System.Windows.Forms.Label LBNroId;
        private System.Windows.Forms.Label LBTotal;
        private System.Windows.Forms.Label LBDireccion;
        private System.Windows.Forms.Label LBTelefono;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox TBBuscar;
        private System.Windows.Forms.Button BTBuscar;
        private Microsoft.VisualBasic.PowerPacks.ShapeContainer shapeContainer1;
        private Microsoft.VisualBasic.PowerPacks.LineShape lineShape1;
    }
}

