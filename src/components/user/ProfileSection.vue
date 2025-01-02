<template>
  <div class="col-md-8">
    <div class="profile-section">
      <h3 class="mb-4">Profil Saya</h3>
      <div class="row">
        <div class="col-lg-6">
          <!-- Flash message placeholder -->
        </div>
      </div>
      <div class="card shadow-sm profile-card">
        <div class="card-body">
          <div class="row">
            <div class="col-md-4">
              <img
                src="@/assets/img/default-profile.png"
                class="img-fluid img-thumbnail"
                alt="Profile"
              />
            </div>
            <div class="col-md-8">
              <div class="profile-info">
                <div class="section-title">
                  <h3 class="title">Informasi Pengguna</h3>
                </div>
                <div class="profile-info-item">
                  <span class="profile-label">Username</span>
                  <span class="profile-value">{{ userInfo.username }}</span>
                </div>
                <div class="profile-info-item">
                  <span class="profile-label">Email</span>
                  <span class="profile-value">{{ userInfo.email }}</span>
                </div>
                <div class="profile-info-item">
                  <span class="profile-label">Pengguna sejak</span>
                  <span class="profile-value">{{ userInfo.created_at }}</span>
                </div>
              </div>
              <hr />
              <div class="address-card">
                <div class="section-title">
                  <h3 class="title">Alamat Pengiriman</h3>
                </div>
                <div class="address-details">
                  <p>
                    <strong>Nama Penerima:</strong>
                    {{ userAddress.recipients_name }}
                  </p>
                  <p><strong>Nomor Telepon:</strong> {{ userAddress.phone_number }}</p>

                  <p>
                    <strong>Alamat:</strong>
                    {{ userAddress.street_address }}
                  </p>
                  <p><strong>Kota:</strong> {{ userAddress.city }}</p>
                  <p><strong>Provinsi:</strong> {{ userAddress.state }}</p>
                  <p><strong>Negara:</strong> {{ userAddress.country }}</p>
                  <p>
                    <strong>Kode Pos:</strong> {{ userAddress.postal_code }}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "ProfileSection",
  props: {
    userInfo: {
      type: Object,
      required: true,
    },
    userAddress: {
      type: Object,
      required: true,
    },
  },
};
</script>

<style scoped>
.profile-section {
  display: flex;
  flex-direction: column;
  gap: 20px;
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