<div class="user-box">
    <span class="name">
        Welcome<br/>
        <%
            map.User u = null;
            if (user != null) {

                org.hibernate.Session s = com.HibernateUtil.getSessionFactory().openSession();
                u = (map.User) s.load(map.User.class, user.getIduser());
                out.write(u.getUsername());
            }
        %>
    </span>
    <span class="status">
        <i class="fa fa-circle"></i> Online
    </span>
</div>