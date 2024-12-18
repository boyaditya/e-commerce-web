<template>
  <!-- BREADCRUMB -->
  <div id="breadcrumb" class="section">
    <!-- container -->
    <div class="container">
      <!-- row -->
      <div class="row">
        <div class="col-md-12">
          <ul class="breadcrumb-tree">
            <li><router-link to="/">Home</router-link></li>
            <li>
              <a href="#">{{ categoryName }}</a>
            </li>
            <li class="active">{{ productName }}</li>
          </ul>
        </div>
      </div>
      <!-- /row -->
    </div>
    <!-- /container -->
  </div>
  <!-- /BREADCRUMB -->
</template>

<script>
export default {
  name: "BreadCrumbPage",
  props: {
    categoryName: {
      type: String,
      required: true,
    },
    productName: {
      type: String,
      required: true,
    },
  },
};
</script>
  <style scoped>
/* Add relevant styles here */
</style>
  