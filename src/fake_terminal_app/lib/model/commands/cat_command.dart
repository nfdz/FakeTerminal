import 'package:fake_terminal_app/model/command.dart';
import 'package:fake_terminal_app/model/terminal_content.dart';
import 'package:fake_terminal_app/utils/constants.dart';

class CatCommand extends Command {
  static CatCommand? _instance;

  factory CatCommand() {
    if (_instance == null) {
      _instance = CatCommand._();
    }
    return _instance!;
  }

  CatCommand._() : super(kCmdCat, kCmdCatManEntry);

  @override
  void execute(
      List<String> args, List<TerminalLine> output, List<String> history) {
    if (args.length < 2) {
      output.insert(0, ResultLine(kCmdInvalidArgs + cmd));
    } else {
      if (args.length > 2) {
        output.insert(0, ResultLine(kCmdIgnoredArgs));
      }
      String file = args[1];
      file = file.replaceFirst("./", "");
      switch (file) {
        case kCmdCatAboutFile:
          output.insert(0, ResultLine(kCmdCatAboutFileContent));
          break;
        case kCmdCatEducationFile:
          output.insert(0, ResultLine(kCmdCatEducationFileContent));
          break;
        case kCmdCatObjetivesFile:
          output.insert(0, ResultLine(kCmdCatObjetivesFileContent));
          break;
        case kCmdCatSkillsFile:
          output.insert(0, ResultLine(kCmdCatSkillsFileContent));
          break;
        case kCmdCatExperienceFile:
          output.insert(0, ResultLine(kCmdCatExperienceFileContent));
          break;
        default:
          output.insert(
              0, ResultLine(kCmdCatInvalidFile.replaceFirst("{file}", file)));
      }
    }
  }
}

const String kCmdCat = "cat";
const String kCmdCatManEntry = """
CAT(1)

NAME
       cat - concatenate files and print on the standard output

SYNOPSIS
       cat [FILE]

DESCRIPTION
       Concatenate FILE(s) to standard output.

EXAMPLES
       cat ./about_me.json
              Output content of 'about.json'.""";
const String kCmdCatInvalidFile = "cat: {file}: No such file or directory";
const String kCmdCatAboutFile = "about.json";
const String kCmdCatAboutFileContent = """
{
  "who_am_i": "I am a cheerful, reliable, team player and communicative person. My passions include technological challenges and constantly improving myself through my own motivation to learn as well as from those around me. I am a software engineer and developer with a varied background. My experience pulls from studying and working in a lot of different fields. There is nothing in this world I admire more than the ability to beat the security of the known and go beyond the comfort. Over the past few years, business culture has grown in importance and new approaches to work have developed. Through my experience and determination, I know I can contribute to any company."
}""";
const String kCmdCatEducationFile = "education.json";
const String kCmdCatEducationFileContent = """
{
  "intro": "I am open to receiving new knowledge, it is one of the things I like most. I have learned to, not only, appreciate those who teach and have taught me, but to also take initiative and self-teach. I like new leaning style like MOOCs (for example Udacity Associate Android Developer) and old ones like books (for example Clean Code). Following, a temporary line with my certified education:",
  "timeline": {
    "2019_flutter_app_development_bootcamp": "App Brewery in collaboration with Google Flutter Team has created The Complete Flutter App Development Bootcamp with Dart. Covering all the fundamental concepts for Flutter development, this is the most comprehensive Flutter course available online. I really recommend this course, I have learned to use this platform, to learn to love it and learn new things every day for myself. I have already started using it in my projects as a freelance. Check out the content of the course here: https://www.appbrewery.co/p/flutter-development-bootcamp-with-dart",
    "2018_kotlin_for_android_developers": "Interesting course for those who want to land on this language supported by Google to develop Android Apps. I recommend this course if you are an Android developer and already have some basic knowledge of Kotlin. Congratulations to Antonio Leiva, for his natural vocation to teach with such dedication and enthusiasm. Check out the content of the course here: https://antonioleiva.com/online-course/",
    "2017_associate_android_developer": "The content of this Udacity program is the perfect introduction to the world of Android for someone with my background. It has an estimated duration of four months and is oriented to be examined at the end to achieve a certification. It has individual tutors and several very interesting projects. Check out my Associate Android Developer Certification by Google: https://www.credential.net/c22yg4nt",
    "2015_CITIUS_program": "Program at the Autonomous University of Madrid. The main objective of the CITIUS program is to complete the training of recent university graduates. It is focused on providing useful transverse skills in the business world. I did this program while working full-time, so I was able to apply my new knowledge in my work environment. It has several subjects available, each one of three weeks duration. I chose the following: Leadership Skills (Psychology and Sociology faculty): focused on improving leadership skills as a factor of integration and cohesion of the force. Successful Presentations - The Art of Public Speaking (Psychology and Sociology faculty): focused on improving the skills related to the art of public speaking. Team Management - The Coach Leader (Psychology and Sociology faculty): focused on improving leadership skills and coaching.",
    "2010-2014_degree_in_telecommunications_engineering": "Bachelor degree at the University of Granada. With the mention in the telematics specialty. I highlight the great vision that provides from the engineering point of view, providing me with a great knowledge from electronic to software. You can check the curriculum of the program: http://grados.ugr.es/telecomunicacion/pages/infoacademica/estudios",
    "2008-2010_highschool": "I went to high school in my town. I had very good teachers who helped me to orient my future. The type of program that I chose was technological that gives me knowledge like technical drawing, physics, electronic and software."
  }
}""";
const String kCmdCatObjetivesFile = "objetives.json";
const String kCmdCatObjetivesFileContent = """
{
  "professional_objectives": "As a developer, not only do I aim to strengthen my projects, but also my abilities in general, taking every opportunity to learn and grow personally and professionally. I am always thinking mind-boggling ideas. However, an idea is worthless if I am not able to execute it correctly. That is why balance between theory and practice is very important for me. Recently, I was able to specialize in Android, Flutter, Kotlin and Python. However, throughout my career I have touched the entire Full-Stack, I like the idea of being able to create a complete product on my own. I was given management tasks in which I was responsible for small projects and delegating work to my team. I was able to use agile methodologies, such as scrum. I have been recently more involved with engineering duties, but I am open to return to the management role as knowing both worlds is crucial for future growth and improvement of myself and the company."
}""";
const String kCmdCatSkillsFile = "skills.json";
const String kCmdCatSkillsFileContent = """
{
  "intro": "I have skills and experience in a lot of different areas of the development process. Here are some of the most important ones for me:",
  "skills": {
    "programming_languages": "Kotlin, Java, Dart, Python, Go, C, C++, SQL. (I have some experience in many more languages)",
    "platforms_frameworks_and_libraries": "Android, Flutter, Realm, JUnit, Mockito, Firebase, Facebook, Protocol buffers, Spring Boot, Micronaut, HornetQ, RabbitMQ, OpenDDS, RMI, CORBA, SWT, JavaFX, Eclipse RCP. (I have used a lot of libraries and frameworks",
    "software_engineering_knowledge": "continuous integration and delivery (Github, Bamboo, Jenkins and Visual Studio Team Services suite), specification of requirements, design patterns, source code control systems (git, svn), clean code ♥ and agile software development methodologies."
  },
  "highlight": [
    "Being a team player.",
    "Being communicative.",
    "Being ethical and professional.",
    "Having habits of thought.",
    "Having personal work habits."
  ]
}""";
const String kCmdCatExperienceFile = "experience.json";
const String kCmdCatExperienceFileContent = """
{
  "intro": "I have worked on many interesting projects where I have learned a lot since I was in high school. Professionally, I have been working for more than 4 years. Following, I have highlighted my most interesting experiences:",
  "timeline": {
    "2018_freelance": "I am confident to face specific projects alone and with remote groups. I have used several online platforms and my networking in my city to get new projects. I have done three projects related to the development of applications so far. These applications needed the development of a backend (Python) and a backendless solution (Firebase). It is especially important for me to take care of the first stage of planning and details to approach the project. It is important that the client can see and understand the different stages of production and the time of each stage. The first project was for a non-profit cultural association. We developed a platform to manage events, people and loyalty. After finish and persuade the admin team, I published the code under an open license in my Github in order to show a nice Kotlin App and Firebase. Of course, I would love that any association uses the platform. Another project that I would like to highlight is a tourism platform that I have developed using Flutter framework. The development of apps for Android and iOS using Flutter is amazing. I enjoyed the easy domain language every day and I save a lot of important time in development and maintenance for this type of projects. This project uses the Firebase suite as backend solution. Unfortunately I cannot provide the code since it is a private project but you can check the project its website and download the app in your app store: https://evive.es/",
    "2017-2018_trainingym": {
      "title": "Android software engineer",
      "intro": "I was involved in several projects of the company. One of them was a very large legacy project with hundreds of derived applications in Google Play and millions of users around the world. Another was a new product to take care and improve people health who do not exercise often by proposing trainings at their level in their smartphone automatically. I was in charge of the development and implementation of the bluetooth protocol of the first wearable designed in Spain, implementing an isolated development kit, as well as its integration into the company's products such as the ones I mentioned before. This time I also was the team leader of several interns who helped us a lot and we had a good time. I highlight the following tasks and responsibilities:",
      "responsibilities": [
        "Design and implementation of continuous integration and continuous delivery system for Google Play with VSTS. Adding instrumented and unit tests to the pipe. All of this was for a complex scenario with a large legacy project with more than two hundred derived applications.",
        "Integration and synchronization of several Google services like Google Fit.",
        "Firebase Analytics integration.",
        "Migration of Fabric to Firebase Crashlytics.",
        "Design, development and integration of smartband SDK (full synchronization of data in local realm database and in our own cloud).",
        "Integration of NFC reader to read gym user cards.",
        "Modularization and refactoring of legacy projects into smaller projects (linking libraries using git submodules).",
        "Integration of Facebook services.",
        "Design and implementation of a push notification service with Firebase and Azure Notifications Hub.",
        "Design and implementation of a distributed communication system for thousands of devices connected at the same time with Azure IoT Hub (using MQTT beneath).",
        "Development of applications for tablets kiosks."
      ]
    },
    "2015-2017_gmv": {
      "title": "Satellite ground control software developer",
      "content": "I was able to work on the development of a new and very innovative product from scratch. I learned a lot with my workmates and team leader, whom I appreciate very much and I thank him for all the time he dedicated to me. Over time, more and more responsibilities were delegated to me, such as the control of the schedule, meeting of clients, documentation, user training, deliveries, management of people in my charge, specification of new requirements and features, choice of technologies and development lines. As a multinational company, I had workmates and customers from the whole world and the documentation and code followed international standards. The sector is a critical infrastructure and the product is expected to have the highest quality. Therefore, an important part of my work was to ensure the quality of software with unit tests, continuous integration, design patterns, simulation and validation environments. The technologies mainly involved were Java, Eclipse RCP, Python, Protocol buffers, CORBA, HornetQ, C++, JUnit."
    },
    "2014-2015_ixion": "Autonomous mobile robotics software developer. I got an internship to work in the development of an UGV: https://vimeo.com/175511126 . The mission board system was a real-time linux and the programming language was mainly C and C++ for some specific features. Some of my tasks were: Implementation of new features. Maintenance and support. Integration with simulation systems. Implementation of new unit tests.",
    "2013_university_of_granada": "Teaching innovation project software developer. This was my first professional experience with timing, remuneration and final users. I was still studying my university degree. The teachers designed the project idea and my job was to carry it out completely. Leaving me freely, I designed and developed the technical solution and the user experience. I was the leader of a team of two students. It was a web application and the technologies involved were PHP/MySQL for the backend and HTML/CSS/Javascript for the frontend."
  }
}""";
