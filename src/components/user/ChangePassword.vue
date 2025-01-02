<template>
  <div class="col-md-8">
    <div class="profile-section">
      <h3 class="mb-4">Ubah Password</h3>
      <div class="card shadow-sm profile-card">
        <div class="card-body">
          <form @submit.prevent="changePassword">
            <div class="col">
              <div class="col">
                  <div class="mb-3">
                    <label for="password" class="form-label">Ubah Password</label>
                    <input
                      type="password"
                      class="form-control"
                      id="password"
                      v-model="userInfo.password"
                    />
                  <button type="submit" class="btn-login">Simpan Perubahan</button>
                </div>
              </div>
            </div>
            </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "EditProfile",
  props: {
    userInfo: {
      type: Object,
      required: true,
    },
  },
};
</script>

<style scoped>

.form-label {
  font-weight: bold;
  display: flex;
}

.form-control:focus {
  box-shadow: 0 0 0 0.2rem rgba(208, 3, 54, 0.5);
  border-color: rgb(208, 3, 54);
}

.btn-login {
  background-color:rgb(208, 3, 54);
  padding: 1.3em 3em;
  font-size: 12px;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: 500;
  color: #000;
  background-color: #fff;
  margin-top: 5%;
  border:solid 1px #e3e3e3cb;
  width: 100%;
  border-radius: 4px;
  box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease 0s;
  cursor: pointer;
  outline: none;
}

.btn-login:hover {
    /* background-color: #0056b3; */
    background-color:rgb(196, 2, 50);
    box-shadow: 0px 15px 20px rgba(181, 0, 42, 0.57);
    color: #fff;
    transform: translateY(-7px);
}

.btn-login:active {
    transform: translateY(-1px);
}

.profile-section {
  margin-top: 20px;
}

.profile-card {
  border: 1px solid #dee2e6;
  border-radius: 10px;
  margin-bottom: 20px;
}

.card-body {
  padding: 20px;
}

.card-title {
  font-size: 1.25rem;
  font-weight: bold;
}

.card-text {
  margin-bottom: 10px;
}

.img-thumbnail {
  border-radius: 10px;
}

.profile-info {
  display: flex;
  flex-direction: column;
}

.profile-info-item {
  display: flex;
  justify-content: flex-start;
  margin-bottom: 10px;
}

.profile-label {
  font-weight: bold;
  margin-right: 10px;
  width: 120px; /* Adjust the width as needed */
}

.profile-value {
  flex: 1;
}
</style>