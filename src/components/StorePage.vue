<template>
  <!-- SECTION -->
  <div class="section">
    <!-- container -->
    <div class="container">
      <!-- row -->
      <div class="row">
        <!-- ASIDE -->
        <div id="aside" class="col-md-3">
          <!-- aside Widget -->
          <div class="aside">
            <h3 class="aside-title">Categories</h3>
            <div class="checkbox-filter">
              <div class="input-checkbox">
                <input type="checkbox" id="category-1" />
                <label for="category-1">
                  <span></span>
                  Laptops
                  <small>(120)</small>
                </label>
              </div>

              <div class="input-checkbox">
                <input type="checkbox" id="category-2" />
                <label for="category-2">
                  <span></span>
                  Smartphones
                  <small>(740)</small>
                </label>
              </div>

              <div class="input-checkbox">
                <input type="checkbox" id="category-3" />
                <label for="category-3">
                  <span></span>
                  Cameras
                  <small>(1450)</small>
                </label>
              </div>

              <div class="input-checkbox">
                <input type="checkbox" id="category-4" />
                <label for="category-4">
                  <span></span>
                  Accessories
                  <small>(578)</small>
                </label>
              </div>

              <div class="input-checkbox">
                <input type="checkbox" id="category-5" />
                <label for="category-5">
                  <span></span>
                  Laptops
                  <small>(120)</small>
                </label>
              </div>

              <div class="input-checkbox">
                <input type="checkbox" id="category-6" />
                <label for="category-6">
                  <span></span>
                  Smartphones
                  <small>(740)</small>
                </label>
              </div>
            </div>
          </div>
          <!-- /aside Widget -->

          <!-- aside Widget -->
          <div class="aside">
            <h3 class="aside-title">Price</h3>
            <div class="price-filter">
              <div id="price-slider"></div>
              <div class="input-number price-min">
                <input id="price-min" type="number" />
                <span class="qty-up">+</span>
                <span class="qty-down">-</span>
              </div>
              <span>-</span>
              <div class="input-number price-max">
                <input id="price-max" type="number" />
                <span class="qty-up">+</span>
                <span class="qty-down">-</span>
              </div>
            </div>
          </div>
          <!-- /aside Widget -->
        </div>
        <!-- /ASIDE -->

        <!-- STORE -->
        <div id="store" class="col-md-9">
          <!-- store top filter -->
          <div class="store-filter clearfix">
            <div class="store-sort">
              <label>
                Sort By:
                <select class="input-select">
                  <option value="0">Popular</option>
                  <option value="1">Position</option>
                </select>
              </label>

              <label>
                Show:
                <select class="input-select">
                  <option value="0">20</option>
                  <option value="1">50</option>
                </select>
              </label>
            </div>
            <!-- <ul class="store-grid">
              <li class="active"><i class="fa fa-th"></i></li>
              <li>
                <a href="#"><i class="fa fa-th-list"></i></a>
              </li>
            </ul> -->
          </div>
          <!-- /store top filter -->

          <!-- store products -->
          <div class="row">
            <!-- products -->
            <ProductItem
              v-for="product in allProducts"
              :key="product.id"
              :imgSrc="product.image_url || 'default-image.jpg'"
              :imgAlt="product.name"
              :saleLabel="'-30%'"
              :newLabel="'NEW'"
              :category="product.category.name"
              :productName="product.name"
              :productLink="product.id"
              :productPrice="product.price"
              :addCartItemHandler="addCartItemHandler"
              :colClass="'col-md-3'"
            />
            <!-- /products -->
          </div>
          <!-- /store products -->

          <!-- store bottom filter -->
          <div class="store-filter clearfix">
            <span class="store-qty">Showing 20-100 products</span>
            <ul class="store-pagination">
              <li class="active">1</li>
              <li><a href="#">2</a></li>
              <li><a href="#">3</a></li>
              <li><a href="#">4</a></li>
              <li>
                <a href="#"><i class="fa fa-angle-right"></i></a>
              </li>
            </ul>
          </div>
          <!-- /store bottom filter -->
        </div>
        <!-- /STORE -->
      </div>
      <!-- /row -->
    </div>
    <!-- /container -->
  </div>
  <!-- /SECTION -->
</template>

<script>
// import ShopItem from "@/components/shop_item/ShopItem.vue";
import ProductItem from "@/components/shop_item/ProductItem.vue";
// import ProductWidget from "@/components/shop_item/ProductWidget.vue";
import { fetchAllProducts } from "@/api/api";

export default {
  name: "StorePage",
  components: {
    ProductItem,
  },
  data() {
    return {
      allProducts: [],
    };
  },
  methods: {
    async fetchAllProducts() {
      try {
        this.allProducts = await fetchAllProducts();
        console.log("jawa");
        console.log(this.allProducts);
      } catch (error) {
        console.error(error);
      } finally {
        this.loadingCart = false;
      }
    },
  },
  created() {
    this.fetchAllProducts();
  },
};
</script>

<style>
</style>