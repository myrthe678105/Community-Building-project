<template>
  <footer class="bg-[#5B61B2] text-[#EEE2DF] py-6 font-serif">
    <div class="container mx-auto px-4">
      <div class="flex flex-col md:flex-row justify-between items-center">
        <!-- Left side -->
        <div class="mb-4 md:mb-0 text-center md:text-left text-sm uppercase tracking-widest">
          &copy; {{ new Date().getFullYear() }} Myrthe
        </div>

        <!-- Right side -->
        <div class="flex flex-wrap justify-center md:justify-end space-x-4 text-sm uppercase tracking-widest">
          <a href="#" class="hover:text-[#6DA0E1] transition">Privacy Policy</a>
          <a href="#" class="hover:text-[#2F80E4] transition">Terms of Service</a>
          <a href="#" class="hover:text-[#6DA0E1] transition">Contact</a>
        </div>
      </div>
    </div>
  </footer>
</template>
