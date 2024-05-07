import React from "react";
import Download from "./components/Download";
import Info from "./components/Info";

export default function Home() {
  return (
    <div className="flex justify-between flex-col">
      <Download />
      <div className="  flex-1 relative flex justify-center items-center min-h-fit">
      <Info />
      </div>
    </div>
  );
}
