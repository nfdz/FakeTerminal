// class NfdzCommand extends Command {
//   static NfdzCommand? _instance;

//   factory NfdzCommand() {
//     if (_instance == null) {
//       _instance = NfdzCommand._();
//     }
//     return _instance!;
//   }

//   NfdzCommand._() : super(kCmdNfdz, kCmdNfdzManEntry);

//   @override
//   void execute(
//       List<String> args, List<TerminalLine> output, List<String> history) {
//     if (args.length < 2) {
//       output.insert(0, ResultLine(kCmdInvalidArgs + cmd));
//     } else {
//       if (args.length > 2) {
//         output.insert(0, ResultLine(kCmdIgnoredArgs));
//       }
//       String nfdzArg = args[1];
//       switch (nfdzArg) {
//         case kCmdNfdzAboutArg:
//           output.insert(0, ResultLine(kCmdNfdzAboutOutput));
//           break;
//         case kCmdNfdzEducationArg:
//           output.insert(0, ResultLine(kCmdNfdzEducationOutput));
//           break;
//         case kCmdNfdzExperienceArg:
//           output.insert(0, ResultLine(kCmdNfdzExperienceOutput));
//           break;
//         case kCmdNfdzHelloArg:
//           output.insert(0, ResultLine(kCmdNfdzHelloOutput));
//           break;
//         case kCmdNfdzObjectivesArg:
//           output.insert(0, ResultLine(kCmdNfdzObjectivesOutput));
//           break;
//         case kCmdNfdzSkillsArg:
//           output.insert(0, ResultLine(kCmdNfdzSkillsOutput));
//           break;
//         case kCmdNfdzVersionArg:
//           output.insert(0, ResultLine(kCmdNfdzVersionOutput));
//           break;
//         default:
//           output.insert(0, ResultLine(kCmdInvalidArg + cmd));
//       }
//     }
//   }
// }

const String kCmdNfdz = "nfdz";
const String kCmdNfdzManEntry = """
NFDZ(1)

NAME
       nfdz - Processes the json files with information about me.

SYNOPSIS
       nfdz [OPTION]

OPTIONS
       about      - Know about me.
       education  - Know about my education.
       experience - Know about my work experience.
       hello      - Not greeting is unpolite.
       objectives - Know about my professional goals.
       skills     - Know about my professional skills.
       version    - the current operational version.""";

const String kCmdNfdzAboutArg = "about";
const String kCmdNfdzAboutOutput = """
---------
About me
---------
I am a cheerful, reliable, team player and communicative person. My passions include technological challenges and constantly improving myself through my own motivation to learn as well as from those around me. 

I am a software engineer and developer with a varied background. My experience pulls from studying and working in a lot of different fields. 

There is nothing in this world I admire more than the ability to beat the security of the known and go beyond the comfort. Over the past few years, business culture has grown in importance and new approaches to work have developed. Through my experience and determination, I know I can contribute to any company.""";

const String kCmdNfdzEducationArg = "education";
const String kCmdNfdzEducationOutput = """
---------
Education
---------
I am open to receiving new knowledge, it is one of the things I like most . I have learned to, not only, appreciate those who teach and have taught me, but to also take initiative and self-teach. I like new leaning style like MOOCs (for example Udacity Associate Android Developer) and old ones like books (for example Clean Code). Following, a temporary line with my certified education:

  2019 - Flutter App Development Bootcamp
  |      --------------------------------
  |      App Brewery in collaboration with Google Flutter Team
  |      has created The Complete Flutter App Development Bootcamp 
  |      with Dart. Covering all the fundamental concepts for Flutter
  |      development, this is the most comprehensive Flutter course 
  |      available online. I really recommend this course, I have 
  |      learned to use this platform, to learn to love it and learn 
  |      new things every day for myself. I have already started 
  |      using it in my projects as a freelance. 
  |
  2018 - Kotlin for Android Developers
  |      -----------------------------
  |      Interesting course for those who want to land on this 
  |      language supported by Google to develop Android Apps. 
  |      I recommend this course if you are an Android developer 
  |      and already have some basic knowledge of Kotlin. 
  |      Congratulations to Antonio Leiva, for his natural vocation 
  |      to teach with such dedication and enthusiasm.
  |
  2017 - Associate Android Developer
  |      ---------------------------
  |      The content of this Udacity program is the perfect 
  |      introduction to the world of Android for someone with my 
  |      background. It has an estimated duration of four months 
  |      and is oriented to be examined at the end to achieve a 
  |      certification. It has individual tutors and several very 
  |      interesting projects. 
  |
  2015 - CITIUS Program
  |      --------------
  |      Autonomous University of Madrid. 
  |      The main objective of the CITIUS program is to complete 
  |      the training of recent university graduates. It is focused
  |      on providing useful transverse skills in the business 
  |      world. I did this program while working full-time, so I was
  |      able to apply my new knowledge in my work environment. 
  |      It has several subjects available, each one of three 
  |      weeks duration. I chose the following:
  |       * Leadership Skills (Psychology and Sociology faculty): 
  |         focused on improving leadership skills as a factor of 
  |         integration and cohesion of the force.
  |       * Successful Presentations - The Art of Public Speaking 
  |         (Psychology and Sociology faculty): focused on improving 
  |         the skills related to the art of public speaking.
  |       * Team Management - The Coach Leader 
  |         (Psychology and Sociology faculty): focused on improving 
  |         leadership skills and coaching. 
  |
  2014 - Degree in Telecommunications Engineering
  2010   ----------------------------------------
  |      Bachelor degree at the University of Granada. With the 
  |      mention in the telematics specialty. I highlight the great 
  |      vision that provides from the engineering point of view, 
  |      providing me with a great knowledge from electronic to software.      
  |
  2010 - High school     
  2008   -----------
  |      I went to high school in my town. I had very good teachers 
  |      who helped me to orient my future. The type of program 
  |      that I chose was technological that gives me knowledge 
  |      like technical drawing, physics, electronic and software.
  |
  *""";

const String kCmdNfdzExperienceArg = "experience";
const String kCmdNfdzExperienceOutput = """
---------------
Work Experience
---------------
I have worked on many interesting projects where I have learned a lot since I was in high school. Professionally, I have been working for more than 4 years. Following, I have highlighted my most interesting experiences:
  
  2018 - Freelance
  |      ---------
  |      I am confident to face specific projects alone and with 
  |      remote groups. I have used several online platforms and 
  |      my networking in my city to get new projects. I have done 
  |      three projects related to the development of applications 
  |      so far. These applications needed the development of a 
  |      backend (Python) and a backendless solution (Firebase).
  |
  |      It is especially important for me to take care of the 
  |      first stage of planning and details to approach the 
  |      project. It is important that the client can see and 
  |      understand the different stages of production and the 
  |      time of each stage.
  |
  |      The first project was for a non-profit cultural 
  |      association. We developed a platform to manage events, 
  |      people and loyalty. After finish and persuade the 
  |      admin team, I published the code under an open license 
  |      in my Github in order to show a nice Kotlin App and 
  |      Firebase. Of course, I would love that any association 
  |      uses the platform.
  |
  |      Another project that I would like to highlight is a 
  |      tourism platform that I have developed using 
  |      Flutter framework. The development of apps for Android and 
  |      iOS using Flutter is amazing. I enjoyed the easy domain 
  |      language every day and I save a lot of important time in 
  |      development and maintenance for this type of projects. 
  |      This project uses the Firebase suite as backend solution. 
  |      Unfortunately, I cannot provide the code since it is a 
  |      private project but you can check the project its website 
  |      and download the app in your app store. https://evive.es
  |
  2018 - Trainingym: Android software engineer
  2017   -------------------------------------
  |      I was involved in several projects of the company. One of 
  |      them was a very large legacy project with hundreds of 
  |      derived applications in Google Play and millions of users 
  |      around the world. Another was a new product to take care 
  |      and improve people health who do not exercise often by 
  |      proposing trainings at their level in their smartphone 
  |      automatically. I was in charge of the development and 
  |      implementation of the bluetooth protocol of the first 
  |      wearable designed in Spain, implementing an isolated 
  |      development kit, as well as its integration into the 
  |      company's products such as the ones I mentioned before. 
  |      This time I also was the team leader of several interns 
  |      who helped us a lot and we had a good time.
  |
  |      I highlight the following tasks and responsibilities:
  |       * Design and implementation of continuous integration and 
  |         continuous delivery system for Google Play with VSTS. 
  |         Adding instrumented and unit tests to the pipe. 
  |         All of this was for a complex scenario with a large 
  |         legacy project with more than two hundred derived apps.
  |       * Integration and synchronization of several Google 
  |         services like Google Fit.
  |       * Firebase Analytics integration.
  |       * Migration of Fabric to Firebase Crashlytics.
  |       * Design, development and integration of smartband SDK 
  |         (full synchronization of data in local realm database 
  |         and in our own cloud).
  |       * Integration of NFC reader to read gym user cards.
  |       * Modularization and refactoring of legacy projects into 
  |         smaller projects (linking libraries using git submodules).
  |       * Integration of Facebook services.
  |       * Design and implementation of a push notification service 
  |         with Firebase and Azure Notifications Hub.
  |       * Design and implementation of a distributed communication 
  |         system for thousands of devices connected at the same 
  |         time with Azure IoT Hub (using MQTT beneath).
  |       * Development of applications for tablets kiosks.
  |
  2017 - GMV: Satellite ground control software developer
  2015   ------------------------------------------------
  |      I was able to work on the development of a new and very 
  |      innovative product from scratch. I learned a lot with my 
  |      workmates and team leader, whom I appreciate very much and 
  |      I thank him for all the time he dedicated to me. Over time, 
  |      more and more responsibilities were delegated to me, such as 
  |      the control of the schedule, meeting of clients, 
  |      documentation, user training, deliveries, management of 
  |      people in my charge, specification of new requirements and 
  |      features, choice of technologies and development lines.
  |
  |      As a multinational company, I had workmates and customers 
  |      from the whole world and the documentation and code followed 
  |      international standards. The sector is a critical 
  |      infrastructure and the product is expected to have the 
  |      highest quality. Therefore, an important part of my work 
  |      was to ensure the quality of software with unit tests, 
  |      continuous integration, design patterns, simulation and 
  |      validation environments. The technologies mainly involved 
  |      were Java, Eclipse RCP, Python, Protocol buffers, CORBA, 
  |      HornetQ, C++, JUnit.
  |
  2015 - IXION: Autonomous mobile robotics software developer
  2014   ----------------------------------------------------
  |      I got an internship to work in the development of an UGV. 
  |      The mission board system was a real-time linux and the 
  |      programming language was mainly C and C++ for some specific 
  |      features. Some of my tasks were:
  |       * Implementation of new features.
  |       * Maintenance and support.
  |       * Integration with simulation systems.
  |       * Implementation of new unit tests.
  |
  2013 - University of Granada: Teaching project software developer
  |      ----------------------------------------------------------
  |      This was my first professional experience with timing, 
  |      remuneration and final users. I was still studying my 
  |      university degree. The teachers designed the project idea 
  |      and my job was to carry it out completely. Leaving me 
  |      freely, I designed and developed the technical solution 
  |      and the user experience. I was the leader of a team of
  |      two students. It was a web application and the technologies 
  |      involved were PHP/MySQL for the backend and 
  |      HTML/CSS/Javascript for the frontend.
  |
  *""";

const String kCmdNfdzHelloArg = "hello";
const String kCmdNfdzHelloOutput = """
                              :yyyyyyyyyyyyyyyyssssssssssssssssssssssssss+-   
                            .hs                                         `-sh. 
                           `m/                                             sh`
                           N:                                              .M+
                          `M.                                               Ms
                          -M    yy    :m. smssss: yy     :m-     /yyssy+    Ny
                          -M    mm    /M- hN````  mm     /M:    oN-   .my   my
                          -M    mNsssshM- hMssss. mm     /M:    dm     hN   mh
                          -M    mm    /M- hN      mm     /M:    +N/   :Ns   mh
                          .M`   ss    -h. +hssss: shyyyy.-hyyyy/ :ssoss:    Ny
           ...--``````````.N-                                               Ms
        `.`                ys                                              /N/
      o`                    `+y                                         syhy+
     `y                       `///s/////////+hmo.-/shhso++++++++///:::///``  
     :myyyysssssssssssoooooooooooooooooh    -hdsshys/-`                        
     /NdmmmmmmmmmNNNmmNNNNNNNNNNNNNNmmmM.   mmyo/.`                            
    .h+:hmmmmmmmmmds.....-hNNNNNNNNms`oyo  :.`                                
   `yy//hMMMMMNdo:.`----::./hmMMMMMy+o+sd/                                         
   .sosd:+dhs/--/- ``     ` --/ohdo`/Nhoyh`                                        
    ohsNs`../oys:`          -ss+:..-dhd/m+                                         
   .ys+mMho+:.       ```      .-/++dMo:+oo.                                        
 ./://`sM:        `:sdmdho-`       +h` -/:::.                                      
 y-hNo `y`     `-smNNmddmmNd+`     `- /hNNo`o                                      
`syNhd+     ``/hmho:.    `-odd+`    `sdyN+`o-`                                     
 /y-hyd-``---...             .--:-` yhmd-  o/                                      
    /            .+hMMMN/o.            /                                          
    +    -/oo:` -:sMMMMMm`+`.oys:`     .                                          
    -:- +/:MMMd:oyMMMMMMMyo+MMMd +    -`                                             
       `-:syso//.-.:+++:--..//oys-.. /                                                        


Hello! Nice to meet you!

I hope that through this experiment you will discover interesting things about me and know me better. 

As you can see, I love to experiment with new technologies and use my knowledge in a creative way to have fun in the process.

If you are interested in seeing how this webapp works with the fresh and versatile Flutter web framework, check out the source code in the repository (feel free to use it wherever you want).""";

const String kCmdNfdzObjectivesArg = "objectives";
const String kCmdNfdzObjectivesOutput = """
-----------------------
Professional Objectives
-----------------------
As a developer, not only do I aim to strengthen my projects, but also my abilities in general, taking every opportunity to learn and grow personally and professionally.

I am always thinking mind-boggling ideas. However, an idea is worthless if I am not able to execute it correctly. That is why balance between theory and practice is very important for me.

Recently, I was able to specialize in Android, Flutter, Kotlin and Python. However, throughout my career I have touched the entire Full-Stack, I like the idea of being able to create a complete product on my own.

I was given management tasks in which I was responsible for small projects and delegating work to my team. I was able to use agile methodologies, such as scrum. I have been recently more involved with engineering duties, but I am open to return to the management role as knowing both worlds is crucial for future growth and improvement of myself and the company.""";

const String kCmdNfdzSkillsArg = "skills";
const String kCmdNfdzSkillsOutput = """
-------------------
Professional Skills
-------------------
I have skills and experience in a lot of different areas of the development process. Here are some of the most important ones for me:
 * Programming languages: Kotlin, Java, Dart, Python, Go, C, C++, SQL. (I have some experience in many more languages) 
 * Platforms, frameworks and libraries: Android, Flutter, Realm, JUnit, Mockito, Firebase, Facebook, Protocol buffers, Spring Boot, Micronaut, HornetQ, RabbitMQ, OpenDDS, RMI, CORBA, SWT, JavaFX, Eclipse RCP. (I have used a lot of libraries and frameworks)
 * Software engineering knowledge: continuous integration and delivery (Github, Bamboo, Jenkins and Visual Studio Team Services suite), specification of requirements, design patterns, source code control systems (git, svn), clean code ♥ and agile software development methodologies.

However, I believe that what really gives worth to an engineer are transverse skills such as:
 * Being a team player.
 * Being communicative.
 * Being ethical and professional.
 * Having habits of thought.
 * Having personal work habits.""";

const String kCmdNfdzVersionArg = "version";
const String kCmdNfdzVersionOutput = """
nfdz-v1.99-rolling""";
