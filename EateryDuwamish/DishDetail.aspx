<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Site.Master"   Inherits="EateryDuwamish.DishDetail" CodeBehind="DishDetail.aspx.cs" %>
<%@ Register Src="~/UserControl/NotificationControl.ascx" TagName="NotificationControl" TagPrefix="uc1" %>
 
 <asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
       <%--Datatable Configuration--%>
   <script type="text/javascript">
       function ConfigureDatatable() {
           var table = null;
           if ($.fn.dataTable.isDataTable('#htblDish')) {
               table = $('#htblDish').DataTable();
           }
           else {
               table = $('#htblDish').DataTable({
                   stateSave: false,
                   order: [[1, "asc"]],
                   columnDefs: [{ orderable: false, targets: [0] }]
               });
           }
           return table;
       }
   </script>
   <%--Checkbox Event Configuration--%>
   <script type="text/javascript">
       function ConfigureCheckboxEvent() {
           $('#htblDish').on('change', '.checkDelete input', function () {
               var parent = $(this).parent();
               var value = $(parent).attr('data-value');
               var deletedList = [];

               if ($('#<%=hdfDeletedDishes.ClientID%>').val())
                   deletedList = $('#<%=hdfDeletedDishes.ClientID%>').val().split(',');

               if ($(this).is(':checked')) {
                   deletedList.push(value);
                   $('#<%=hdfDeletedDishes.ClientID%>').val(deletedList.join(','));
               }
               else {
                   var index = deletedList.indexOf(value);
                   if (index >= 0)
                       deletedList.splice(index, 1);
                   $('#<%=hdfDeletedDishes.ClientID%>').val(deletedList.join(','));
               }
           });
       }
   </script>
   <%--Main Configuration--%>
   <script type="text/javascript">
       function ConfigureElements() {
           ConfigureDatatable();
           ConfigureCheckboxEvent();
       }
   </script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
         <ContentTemplate>
        <script type="text/javascript">
            $(document).ready(function () {
                ConfigureElements();
            });
            <%--On Partial Postback Callback Function--%>
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_endRequest(function () {
                ConfigureElements();
            });
        </script>

        <uc1:NotificationControl ID="notifDish" runat="server" />
        <div class="page-title">Dish Details</div><hr style="margin:0"/>
        
        <%--FORM DISH--%>
        <asp:Panel runat="server" ID="pnlFormDish" Visible="true">
             <div class="form-slip">
                <div class="form-slip-header">
                    <div class="form-slip-title">
                        <asp:Label ID="lblDishName" runat="server" Text="Dish Name:"></asp:Label>
                        <asp:Literal runat="server" ID="litFormType"></asp:Literal>
                    </div>
                    <hr style="margin:0"/>
                </div>
                <div class="form-slip-main">
                    <div>
                       <%--Recipe Name Field--%>
                        <div class="col-lg-6 form-group">
                            <div class="col-lg-4 control-label">
                                Recipe Name*
                            </div>
                            <div class="col-lg-6">
                                  <asp:TextBox ID="txtRecipeName" CssClass="form-control" runat="server"></asp:TextBox>
                                  <%-- Validator for recipe name--%>
                                  <asp:RequiredFieldValidator ID="rfvRecipeName" runat="server" ErrorMessage="Please fill this field"
                                      ControlToValidate="txtRecipeName" ForeColor="Red" 
                                      ValidationGroup="InsertUpdateDishDetail" Display="Dynamic">
                                  </asp:RequiredFieldValidator>
                                <%--End of Validator--%>
                            </div>
                        </div>
                        <%--End of Recipe Name Field--%>    

                        <%-- DishID hidden field --%>
                        <asp:HiddenField ID="hdfDishID" runat="server" Value="0"/>

                        <%--End of Dish ID Field--%>   
                         <%--DishDetailID hidden Field --%>
                        <asp:HiddenField ID="hdfDishDetailID" runat="server" Value="0"/>
                        <%--End of DishDetailID Field--%> 

                         <%--RecipeDescription hidden Field --%>
                        <asp:HiddenField ID="hdfRecipeDescription" runat="server" Value="0"/>
                        <%--End of RecipeDescription Field--%> 
                    </div>
                    <div class="col-lg-12">
                        <div class="col-lg-2">
                        </div>
                        <div class="col-lg-2">
                            <asp:Button runat="server" ID="btnSave" CssClass="btn btn-primary" Width="100px"
                                Text="SAVE" OnClick="btnSave_Click" ValidationGroup="InsertUpdateDishDetail">
                            </asp:Button>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <%--END OF FORM DISH--%>

        <%-- REPEATER --%>
        <div class="row">
            <div class="table-header">
                <div class="table-header-button">
                    <asp:Button ID="btnDelete" runat="server" Text="DELETE" CssClass="btn btn-danger" Width="100px"
                        OnClick="btnDelete_Click" />
                </div>
            </div>
        </div>

        <div class="row">
         <div class="table-main col-sm-12">
            <asp:HiddenField ID="hdfDeletedDishes" runat="server" />
            <asp:Repeater ID="rptDishDetail" runat="server" OnItemDataBound="rptDishDetail_ItemDataBound" OnItemCommand="rptDishDetail_ItemCommand">
                <HeaderTemplate>
                <table id="htblDish" class="table">
                    <thead>
                        <tr role="row">
                            <th aria-sort="ascending" style="" colspan="1" rowspan="1"
                                tabindex="0" class="sorting_asc center">
                            </th>
                            <th aria-sort="ascending" style="" colspan="1" rowspan="1" tabindex="0"
                                class="sorting_asc text-center">
                                Recipe Name
                            </th>
                             <th aria-sort="ascending" style="" colspan="1" rowspan="1" tabindex="0"
                                 class="sorting_asc text-center">
                                 Recipe Details
                             </th>
                        </tr>
                    </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tbody>
                    <tr class="odd" role="row" runat="server" onclick="">
                        <td>
                            <div style="text-align: center;">
                                <asp:CheckBox ID="chkChoose" CssClass="checkDelete" runat="server">
                                </asp:CheckBox>
                            </div>
                        </td>
                         <td>
                            <asp:LinkButton ID="lbRecipeName" runat="server" CommandName="EDIT"></asp:LinkButton>
                        </td>
                        <td>
                            <asp:HyperLink ID="hlDishRecipe" runat="server" Text="details" ></asp:HyperLink>
                        </td>
                    </tr>
                    </tbody>
                </ItemTemplate>
            </asp:Repeater>
        </div>
         </div>
     
        </ContentTemplate>
    </asp:UpdatePanel>
 </asp:Content>
