import React from 'react'
import './About.css'
import { Link } from 'react-router-dom'
import Service from './Service'

function About() {
  return (
    <>
    <div className='main'>
        <div className='main_content'>
        <h2>About us</h2><br/>
        <p>Welcome To 360 Dental & Aesthetic Center, Where We Fuse The Craft of Dentistry And Medical Cosmetology To Redefine Aesthetics And Unveil Your Finest. Discover Our Array Of Services And Begin A Voyage To Revitalize Your Smile And Look.</p><br/>
        <p>We Embrace A Comprehensive Method To Beauty And Wellness. Our Group Of Proficient Dentists And Medical Cosmetologists Work Together To Deliver Inclusive Treatments That Elevate Both Your Smile And General Appearance. </p><br/>
        </div><br/>
        <ul>
        </ul>

    </div>
    <Service/>
    </>
  )
}

export default About
