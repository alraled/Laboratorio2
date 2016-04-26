using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;

namespace Laboratorio3.VisualWebPart1
{
    public partial class VisualWebPart1UserControl : UserControl
    {
        DataTable dtable;


        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected override void OnPreRender(EventArgs e)
        {
            SPQuery query = new SPQuery();
            query.Query = @"
            <Where>
              <Eq>
            <FieldRef Name = 'Estado'></FieldRef>
            <Value Type = 'Choice'>Pendiente</Value>
              </Eq>
            </Where>
            
            ";
            query.ViewFields = @"
            <FieldRef Name =  'ID'/>
            <FieldRef Name =  'Title'/>
            <FieldRef Name =  'Peticion'/>
            <FieldRef Name =  'Realizado_x0020_Por'/>
            <FieldRef Name =  'Fecha'/>
            <FieldRef Name =  'Importe'/>
            
            ";

            var web = SPContext.Current.Web;
            var list = web.Lists["Presupuesto Material"];
            var items = list.GetItems(query);
            lstExpenses.DataSource = items.GetDataTable();
            lstExpenses.DataBind();
            //ContentIterator iterator = new ContentIterator();
            //iterator.ProcessListItems(list, query, ProcessError, ProcessItem);
            //lstExpenses.DataSource = dtable;
            //lstExpenses.DataBind();
        }

        private static bool IsChecked(ListViewDataItem item)
        {
            var checkBox = item.FindControl("chkUpdate") as CheckBox;
            return checkBox.Checked;
        }

        private void UpdateItems(bool isApproved)
        {
            string status = isApproved ? "Aprobado" : "Rechazado";
            // Retrieve the selected items from the lstExpenses control.

            var selectedItems = from item in lstExpenses.Items
                where IsChecked(item)
                select item;
            // TODO: Ex 2 Task 1 Update the status of the list items

            var web = SPContext.Current.Web;
            var list = web.Lists["Presupuesto Material"];

            foreach (var selectedItem in selectedItems)
            {
                // Get the unique identifier for each list item.

                var hiddenField = selectedItem.FindControl("hdCodigo") as HiddenField;
                int itemID;
                if (int.TryParse(hiddenField.Value, out itemID))
                {
                    SPListItem item = list.GetItemById(itemID);
                    item["Estado"] = status;
                    item.Update();
                }
            }
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            UpdateItems(false);
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            dtable = new DataTable();
            dtable.Columns.Add("ID");
            dtable.Columns.Add("Title");
            dtable.Columns.Add("Peticion");
            dtable.Columns.Add("Realizado_x0020_Por");
            dtable.Columns.Add("Fecha");
            dtable.Columns.Add("Importe", typeof(Decimal));


        }

        private bool ProcessError(SPListItem item, Exception e)
        {
            throw new Exception("Error procesando" , e);
        }

        private void ProcessItem(SPListItem item)
        {
            string uniqueld = item["ID"].ToString();
            string title = item["Title"].ToString();
            string peticion = item["Peticion"].ToString();
            string realizada = item["Realizado_x0020_Por"].ToString();
            string fecha = item["Fecha"].ToString();
            decimal importe = Decimal.Parse(item["Importe"].ToString());
            dtable.Rows.Add(uniqueld, title, peticion, realizada, fecha, importe);
        }

    }

}
