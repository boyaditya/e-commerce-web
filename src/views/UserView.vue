<template>
  <div>
    <HeaderPage />
    <div id="breadcrumb" class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <h3 class="breadcrumb-header">Account</h3>
          </div>
        </div>
      </div>
    </div>

    <div class="container mb-12">
      <div class="row">
        <div class="col-md-4 mb-5">
          <div class="menu-wrapper shadow-sm p-3 bg-light rounded">
            <ul class="nav flex-column">
              <li class="nav-item">
                <router-link
                  to="/user/profile"
                  class="nav-link"
                  :class="{ active: $route.path === '/user/profile' }"
                >
                  <i class="fa fa-fw fa-user"></i>
                  &nbsp; My Profile
                </router-link>
              </li>
              <li class="nav-item">
                <router-link
                  to="/user/edit"
                  class="nav-link"
                  :class="{ active: $route.path === '/user/edit' }"
                >
                  <i class="fa fa-fw fa-pencil-square"></i>
                  &nbsp; Edit Profile
                </router-link>
              </li>
              <li class="nav-item">
                <router-link
                  to="/user/bookings"
                  class="nav-link"
                  :class="{
                    active:
                      $route.path === '/user/bookings' ||
                      $route.path === '/user/booking-details' ||
                      $route.path === '/user/testimonial',
                  }"
                >
                  <i class="fa fa-fw fa-list-alt"></i>
                  &nbsp; My Bookings
                </router-link>
              </li>
              <li class="nav-item">
                <router-link
                  to="/user/changepassword"
                  class="nav-link"
                  :class="{ active: $route.path === '/user/changepassword' }"
                >
                  <i class="fa fa-fw fa-key"></i>
                  &nbsp; Change Password
                </router-link>
              </li>
              <li class="nav-item">
                <a
                  href="#"
                  class="nav-link"
                  :class="{ active: $route.path === '/logout' }"
                  @click.prevent="handleLogout"
                >
                  <i class="fa fa-fw fa-warning"></i>
                  &nbsp; Logout
                </a>
              </li>
            </ul>
          </div>
        </div>

        <router-view></router-view>
      </div>
    </div>
    <FooterPage />
  </div>
</template>

<script>
import HeaderPage from "@/components/templates/HeaderPage.vue";
import FooterPage from "@/components/templates/FooterPage.vue";

export default {
  name: "AccountView",
  components: {
    HeaderPage,
    FooterPage,
  },
  methods: {
    handleLogout() {
      const confirmed = confirm("Apakah Anda yakin ingin logout?");
      
      if (confirmed) {
        this.$router.push('/logout');
      }
    }
  }
};
</script>

<style scoped>
.menu-wrapper {
  background-color: #f8f9fa;
  border-radius: 5px;
  padding: 15px;
  border: 1px solid #dee2e6;
}

.nav-link {
  color: #333;
  font-weight: 500;
  padding: 10px 15px;
  border-radius: 5px;
  transition: background-color 0.3s, color 0.3s;
}

.nav-link:hover {
  background-color: #e9ecef;
  color: #d90a34;
  border: 1px solid #dee2e6;
}

.nav-link.active {
  background-color: #d90a34;
  color: #fff;
}

.nav-link i {
  margin-right: 10px;
}

h4 {
  font-weight: 700;
  color: #333;
}

hr {
  border-top: 1px solid #dee2e6;
}

.container {
  max-width: 960px;
}

.shadow-sm {
  box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
}
</style>