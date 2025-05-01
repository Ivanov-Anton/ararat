import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  /* config options here standalone/export */
  output: 'export',
  distDir: 'dist',
  images: {
    unoptimized: true
  },
};

export default nextConfig;
