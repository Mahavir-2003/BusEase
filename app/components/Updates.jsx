import React from "react";
import Marquee from "react-fast-marquee";

const Updates = () => {
  return (
    <div className="flex flex-row w-full h-12 bg-[#ffc600] text-black justify-center items-center text-base font-light space-x-4">
      <Marquee gradient={false} speed={50}>
        <div>
          <div className="avail-ping mx-3"></div>
        </div>
        <p className="release">
          <span className="font-bold"> ( v2.0.2 ) </span> Beta is in Development
        </p>
      </Marquee>
    </div>
  );
};

export default Updates;
