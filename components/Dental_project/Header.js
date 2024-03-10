import React from 'react';
import { Link } from 'react-router-dom';
import './Header.css'   
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faInstagram } from '@fortawesome/free-brands-svg-icons';  // Assuming faInstagram is a brand icon
import Home from './Home';

function Header() {
  return (
    <>
      <nav className="navbar">
        <h1 className='logo'>Be Well Dental <span>Aesthetic care</span></h1>
        <ul>
          <li>
            <Link to='/' >Home</Link>
          </li>
          <li>
            <Link to="/about">About</Link>
          </li>
          <li>
            <Link to="/service">Service</Link>
          </li>
          <li>
            <Link to="/contact" className='cont'>Contact us</Link>
          </li>
          <li className='logo_icon'>
          <FontAwesomeIcon icon={faInstagram}/>
          <span> Instagram</span>
          </li>
        </ul>
      </nav>
    </>
    
  );
}

export default Header;
