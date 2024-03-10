import { useEffect } from "react";
import { useLocation } from "react-router-dom";

export default function ScrollToTop() {
  const About = useLocation();

  useEffect(() => {
    window.scrollTo(0, 0);
  }, [About]);

  return null;
}
