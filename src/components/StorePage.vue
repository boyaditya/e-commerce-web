<template>
    <div>
      <!-- Konten halaman StorePage -->
      <ul>
        <!-- Daftar produk atau konten lainnya -->
      </ul>
      <span class="copyright">
        Copyright &copy; {{ currentYear }} All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
      </span>
      
      <!-- jQuery Plugins
      <script src="@/assets/js/jquery.min.js"></script>
      <script src="@/assets/js/bootstrap.min.js"></script>
      <script src="@/assets/js/slick.min.js"></script>
      <script src="@/assets/js/nouislider.min.js"></script>
      <script src="@/assets/js/jquery.zoom.min.js"></script>
      <script src="@/assets/js/main.js"></script> -->
    </div>
  </template>
  
  <script>
/* eslint-disable */
  export default {
    data() {
      return {
        currentYear: new Date().getFullYear(), // Mengambil tahun saat ini
      };
    },
    mounted() {
      // Memanggil script di sini setelah komponen dimount
      this.loadScripts();
    },
    methods: {
      loadScripts() {
        // Menggunakan jQuery setelah load
        // const scripts = [
        //   'jquery.min.js',
        //   'bootstrap.min.js',
        //   'slick.min.js',
        //   'nouislider.min.js',
        //   'jquery.zoom.min.js',
        //   'main.js',
        // ];
  
        scripts.forEach(script => {
          const s = document.createElement('script');
          s.src = require(`@/assets/js/${script}`);
          s.async = true;
          document.body.appendChild(s);
        });
      },
    },
  };
  </script>
  
  <style scoped>
  /* Gaya untuk StorePage */
  </style>
  