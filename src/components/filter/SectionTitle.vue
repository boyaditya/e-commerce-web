<template>
  <div class="col-md-12">
    <div class="section-title">
      <h3 class="title">{{ title }}</h3>
      <div class="section-nav">
        <ul class="section-tab-nav tab-nav">
          <li v-for="(tab, index) in tabs" :key="index" :class="{ active: tab.active }">
            <a :href="tab.href" data-toggle="tab">{{ tab.label }}</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'SectionTitle',
  props: {
    title: {
      type: String,
      required: true
    },
    tabs: {
      type: Array,
      required: true,
      default: () => []
    }
  }
};
</script>

<style scoped>
/* Add your styles here */
</style>