<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<footer id="footer-bar" class="row">
    <p id="footer-copyright" class="col-xs-12">
        &copy; <% SimpleDateFormat sdf= new SimpleDateFormat("yyyy"); out.write(sdf.format(new Date()));%> Powered by Allianz IT Team.
    </p>
</footer>