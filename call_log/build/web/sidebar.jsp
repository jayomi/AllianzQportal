

<div class="collapse navbar-collapse navbar-ex1-collapse" id="sidebar-nav">
    <ul class="nav nav-pills nav-stacked">
        <%  if (u.getType().equals("Admin")) {%>
        <li>
            <a href="master.jsp">
                <i class="fa fa-fax"></i>
                <span>Master Detail Report</span>

            </a>
        </li>
        <%}%>
        <li>
            <a href="detail.jsp">
                <i class="fa  fa-file-text"></i>
                <span>Detail Report</span>

            </a>
        </li>
        <li>
            <a href="monitor.jsp">
                <i class="fa fa-dashboard"></i>
                <span>Live Monitor</span>

            </a>
        </li>

        <li>
            <a href="call_sum.jsp">
                <i class="fa fa-calendar-o"></i>
                <span>Call Summery</span>

            </a>
        </li>
        <li>
            <a href="hourly.jsp">
                <i class="fa fa-file-text-o"></i>
                <span>Hourly Summery</span>

            </a>
        </li>
        <li>
            <a href="weekly.jsp">
                <i class="fa fa-file"></i>
                <span>Weekly Summery</span>

            </a>
        </li>
        <li>
            <a href="monthly.jsp">
                <i class="fa fa-calendar"></i>
                <span>Monthly Call Summery</span>

            </a>
        </li>
        <li>
            <a href="call_cost.jsp">
                <i class="fa fa-money"></i>
                <span>Call Cost Summery</span>

            </a>
        </li>
        <%  if (u.getType().equals("Admin") || u.getType().equals("System Admin")) {  %>
        <%  if (u.getType().equals("Admin")) {%>
        <li>
            <a href="pin.jsp">
                <i class="fa fa-reorder"></i>
                <span>PIN Management</span>

            </a>
        </li>
        <%}%>

        <li>
            <a href="directory.jsp">
                <i class="fa  fa-book"></i>
                <span>Internal Directory Management</span>

            </a>
        </li>

        <li>
            <a href="branch.jsp">
                <i class="fa  fa-bank"></i>
                <span>External Directory Management</span>

            </a>
        </li>

        <li>
            <a  class="dropdown-toggle">
                <i class="fa fa-users"></i>
                <span>Users Management</span>
                <i class="fa fa-chevron-circle-right drop-icon"></i>
            </a>


            <ul class="submenu">
                <li>
                    <a href="users.jsp">
                        Active
                    </a>
                </li>
                <li>
                    <a href="pending.jsp">
                        Pending
                    </a>
                </li>

            </ul>
        </li>
        
        <li>
            <a  class="dropdown-toggle">
                <i class="fa fa-folder" aria-hidden="true"></i>
                <span>Directory Management</span>
                <i class="fa fa-chevron-circle-right drop-icon"></i>
            </a>


            <ul class="submenu">
                
                <li>
                    <a href="manageHeadDepartments.jsp">
                        Head Departments 
                    </a>
                </li>                
<!--                <li>
                    <a href="manageSubDepartments.jsp">
                        Sub Departments 
                    </a>
                </li>-->
                <li>
                    <a href="manageBranches.jsp">
                        Branch
                    </a>
                </li>

            </ul>
        </li>
         <li>
            <a  class="dropdown-toggle">
                <i class="fa fa-phone" aria-hidden="true"></i>
                <span>Extension Management</span>
                <i class="fa fa-chevron-circle-right drop-icon"></i>
            </a>
            <ul class="submenu">
                
                <li>
                    <a href="manageExts.jsp">
                        Extensions 
                    </a>
                </li>                
            </ul>
        </li>
        
        <%}%>

        <%  if (u.getType().equals("Operator")) {%>
        <li>
            <a href="directory.jsp">
                <i class="fa  fa-book"></i>
                <span>Directory Management</span>

            </a>
        </li>

        <li>
            <a href="branch.jsp">
                <i class="fa  fa-bank"></i>
                <span>External Directory Management</span>

            </a>
        </li>
        <%}%>
    </ul>

</div>