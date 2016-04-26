<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VisualWebPart1UserControl.ascx.cs" Inherits="Laboratorio3.VisualWebPart1.VisualWebPart1UserControl" %>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>

        <asp:ListView ID="lstExpenses" runat="server">
            <LayoutTemplate>
                <table ID="tblExpenses" runat="server" cellpadding="2">
                    <thead>
                    <tr>
                        <th></th>
                        <th>Titulo</th>
                        <th>Peticion</th>
                        <th>Realizado Por</th>
                        <th>Fecha</th>
                        <th>Importe</th>
                    </tr>
                    </thead>
                    <tr runat="server" ID="itemPlaceholder"></tr>
                </table>
                <asp:DataPager runat="server" ID="DataPager" PageSize="10">
                    <Fields>
                        <asp:NumericPagerField ButtonCount="10" PreviousPageText="<--" NextPageText="-->"/>
                    </Fields>
                </asp:DataPager>
            </LayoutTemplate>
            <ItemTemplate>
                <tr runat="server">
                    <td runat="server">
                        <asp:CheckBox ID="chkUpdate" runat="server"/>
                        <asp:HiddenField ID="hdCodigo" runat="server" Value='<%# Eval("ID") %>'/>
                    </td>
                    <td runat="server">
                        <asp:Label ID="lblTitulo" runat="server" Text='<%# Eval("Title") %>'/>
                    </td>
                    <td runat="server">
                        <asp:Label ID="lblPeticion" runat="server" Text='<%# Eval("Peticion") %>'/>
                    </td>
                    <td runat="server">
                        <asp:Label ID="lblRealizada" runat="server" Text='<%# Eval("Realizado_x0020_Por") %>'/>
                    </td>
                    <td runat="server">
                        <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("Fecha") %>'/>
                    </td>
                    <td runat="server">
                        <asp:Label ID="lblImporte" runat="server" Text='<%# Eval("Importe") %>'/>
                    </td>
                </tr>

            </ItemTemplate>
        </asp:ListView>
    </ContentTemplate>
</asp:UpdatePanel>
<br/>
<asp:Button ID="btnApprove" runat="server" Text="Aprobar" Width="100" OnClick="btnApprove_Click"/>
&nbsp;
<asp:Button ID="btnReject" runat="server" Text="Rechazar" Width="100"  />


