<template>
  <div class="font-sans min-h-screen" style="background: repeating-radial-gradient(circle, #DEC1DB, #2F80E4 20%, #6DA0E1 40%);">
    <!-- Hero Section -->
    <section class="py-16" style="background: repeating-radial-gradient(circle, #DEC1DB, #2F80E4 20%, #6DA0E1 40%) text-white shadow-md">
      <div class="container mx-auto px-8 lg:px-20 flex flex-col lg:flex-row items-center animate-fade-in">
        <div class="lg:w-1/2 text-center lg:text-left mb-10 lg:mb-0">
          <h1 class="text-4xl lg:text-6xl font-extrabold leading-tight mb-4 drop-shadow-lg">
            Welcome to Our Building Community Portal
          </h1>
          <p class="text-lg lg:text-xl opacity-90 mb-6">
            Stay connected with your neighbors, submit complaints, and manage events easily.
          </p>
          <div class="flex flex-col sm:flex-row justify-center lg:justify-start space-y-4 sm:space-y-0 sm:space-x-4">
            <router-link 
              to="/login"
              class="px-6 py-3 bg-white text-[#2F80E4] font-semibold rounded-full shadow-md hover:bg-[#2F80E4] hover:text-white transition duration-300"
            >
              Sign In
            </router-link>
            <router-link 
              to="/register"
              class="px-6 py-3 bg-[#6DA0E1] text-white font-semibold rounded-full shadow-md hover:bg-[#2F80E4] transition duration-300"
            >
              Create Account
            </router-link>
          </div>
        </div>
        <div class="lg:w-1/2">
          <img src="../components/building.jpg" alt="Community Building" class="rounded-xl shadow-xl animate-float" />
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section class="py-16 bg-white">
      <div class="container mx-auto px-6 lg:px-20">
        <h2 class="text-3xl lg:text-4xl font-extrabold text-[#2F80E4] mb-12">
          What You Can Do On This Platform:
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <FeatureCard
            title="Manage Events"
            description="Stay up-to-date with community events and RSVP to join your neighbors."
            bg="green"
          />
          <FeatureCard
            title="Neighbourhood Recommendations"
            description="Read and submit recommendations of nice locations."
              :bg="'indigo'"
          />
          <FeatureCard
            title="Submit Complaints"
            description="Report issues and track resolutions. Stay informed on maintenance updates."
              :bg="'pink'"
          />
          <FeatureCard
            title="Parking Management"
            description="Register vehicles, reserve spaces, and manage visitor parking with ease."
             :bg="'yellow'"
          />
        </div>

      </div>
    </section>

    <!-- CTA Section -->
    <section class="py-16" style="background: repeating-radial-gradient(circle, #5B61B2 5%, #2F80E4 20%) text-white text-center shadow-inner">
      <div class="container mx-auto px-6 lg:px-20">
        <h2 class="text-3xl lg:text-4xl font-extrabold mb-6 drop-shadow-lg">
          Ready to Get Started?
        </h2>
        <p class="text-lg lg:text-xl opacity-90 max-w-2xl mx-auto mb-8">
          Join our community portal today and stay connected with your neighbors.
        </p>
        <router-link 
          to="/register" 
          class="px-6 py-3 bg-white text-[#2F80E4] font-semibold rounded-full shadow-md hover:bg-[#2F80E4] hover:text-white transition duration-300 inline-block"
        >
          Create Your Account
        </router-link>
      </div>
    </section>
  </div>
</template>

<script setup>
import FeatureCard from "@/components/featurecard.vue";
</script>

<style scoped>
@keyframes float {
  0% { transform: translatey(0px); }
  50% { transform: translatey(-10px); }
  100% { transform: translatey(0px); }
}
.animate-float {
  animation: float 3s ease-in-out infinite;
}
.animate-fade-in {
  animation: fadeIn 1.2s ease-out;
}
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>
