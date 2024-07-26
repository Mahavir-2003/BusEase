import "./globals.css";
import { Inter } from "next/font/google";
import Head from "next/head";

const inter = Inter({ subsets: ["latin"] });

// Explicit types for metadata properties
type OpenGraph = {
  title: string;
  description: string;
  type: string;
  url: string;
  countryName: string;
  locale: string;
  determiner: string;
  emails: string[];
};

type CustomMetadata = {
  title: string;
  description: string;
  openGraph: OpenGraph;
};

export const metadata: CustomMetadata = {
  title: "BusEase",
  description:
    "BusEase is a revolutionary mobile application designed to transform the way people travel by bus in the Indian state of Gujarat, specifically catering to the Gujarat State Road Transport Corporation (GSRTC). This cutting-edge app offers a seamless and convenient experience for both students and passengers, addressing the challenges faced in traditional bus travel. For students, BusEase introduces a digital bus pass application process, allowing them to submit their requests directly to universities and receive digital passes upon approval, eliminating the need for paperwork and lengthy queues. Passengers can also book bus tickets with ease through the app, skipping the hassle of visiting counters and standing in long lines. BusEase incorporates QR code technology for efficient ticket verification and real-time bus information access, ensuring a smooth travel experience. The integration of popular UPI payment options further enhances convenience by enabling secure and hassle-free transactions. Additionally, the real-time bus tracking feature empowers users to plan their journeys effectively by monitoring the live location of buses. With BusEase, the future of public transportation in Gujarat has arrived, offering a user-friendly and technologically advanced solution for seamless bus travel. Available on both Google Play Store and Apple App Store, download BusEase today and experience the revolution in bus travel.",
  openGraph: {
    title: "BusEase",
    description:
      "BusEase is a revolutionary mobile application designed to transform the way people travel by bus in the Indian state of Gujarat, specifically catering to the Gujarat State Road Transport Corporation (GSRTC). This cutting-edge app offers a seamless and convenient experience for both students and passengers, addressing the challenges faced in traditional bus travel. For students, BusEase introduces a digital bus pass application process, allowing them to submit their requests directly to universities and receive digital passes upon approval, eliminating the need for paperwork and lengthy queues. Passengers can also book bus tickets with ease through the app, skipping the hassle of visiting counters and standing in long lines. BusEase incorporates QR code technology for efficient ticket verification and real-time bus information access, ensuring a smooth travel experience. The integration of popular UPI payment options further enhances convenience by enabling secure and hassle-free transactions. Additionally, the real-time bus tracking feature empowers users to plan their journeys effectively by monitoring the live location of buses. With BusEase, the future of public transportation in Gujarat has arrived, offering a user-friendly and technologically advanced solution for seamless bus travel. Available on both Google Play Store and Apple App Store, download BusEase today and experience the revolution in bus travel.",
    type: "website",
    url: "https://busease.vercel.app/",
    countryName: "India",
    locale: "en_IN",
    determiner: "auto",
    emails: ["patelmahavir2003@gmail.com"],
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <Head>
        <meta name="google-site-verification" content="MCCP3vhLhrI2FN53psNET5d6gZjkohu7RZmY7fzB3h0" />
        <title>{metadata.title}</title>
        <meta name="description" content={metadata.description} />
        <meta property="og:title" content={metadata.openGraph.title} />
        <meta
          property="og:description"
          content={metadata.openGraph.description}
        />
        <meta property="og:url" content={metadata.openGraph.url} />
        <meta property="og:type" content={metadata.openGraph.type} />
        <meta property="og:locale" content={metadata.openGraph.locale} />
        <meta
          property="og:determiner"
          content={metadata.openGraph.determiner}
        />
        <meta
          property="og:country_name"
          content={metadata.openGraph.countryName}
        />
        {metadata.openGraph.emails.map((email, index) => (
          <meta key={index} property="og:email" content={email} />
        ))}
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <body className={inter.className}>{children}</body>
    </html>
  );
}
