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
              <a href="#" @click.prevent="navigateToCategory">{{ categoryName }}</a>
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
    categoryId: {
      type: Number,
      required: true,
    },
    productName: {
      type: String,
      required: true,
    },
  },
  methods: {
    navigateToCategory() {
      this.$router.push({ path: "/store", query: { category: this.categoryId } });
    },
  },
};
</script>

<style scoped>
</style>