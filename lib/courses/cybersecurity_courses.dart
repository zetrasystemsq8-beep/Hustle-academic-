// GENERATED FILE - DO NOT EDIT BY HAND
// Produced by generate_cybersecurity_courses.py

import 'package:flutter/material.dart';
import '../models/course_models.dart';

final List<AppCourse> cybersecurityCourses = [
  AppCourse(
    id: 'start-your-cyber-security-journey',
    title: '''Start Your Cyber Security Journey''',
    description: '''Learn Start Your Cyber Security Journey in plain, everyday language. This course has 3 short lessons covering Start Your Cyber Security Journey (Part 1), Start Your Cyber Security Journey (Part 2), Start Your Cyber Security Journey (Part 3).''',
    instructor: '''Hustle Academy''',
    duration: '3 min',
    difficulty: 'Beginner',
    category: '''Cybersecurity''',
    icon: Icons.security,
    color: Colors.deepOrange,
    lessons: [
      AppLesson(
        title: '''Start Your Cyber Security Journey (Part 1)''',
        body: '''Start Your Cyber Security Journey – TryHackMe Summary
This document outlines the essential concepts and skills acquired from the introductory rooms in the TryHackMe Cyber Security 101 path. These modules provide a foundational understanding of both offensive and defensive security, as well as effective information gathering techniques.

Offensive Security Intro
Overview: Offensive security involves simulating hacker techniques to identify and attack weaknesses within systems, aiming to strengthen overall security posture..

Key Learnings: Understanding Offensive Security: Recognizing the importance of adopting a hacker\'s mindset to proactively discover and address security weaknesses.

Practical Application: Engaged in a simulated environment by targeting a mock banking website, using tools like gobuster to uncover hidden directories and perform actions mimicking real-world attacks..

Tool Familiarization: Gained hands-on experience with gobuster, understanding its role in directory enumeration and the significance of wordlists in brute-force attacks..

Defensive Security Intro
Overview: Defensive security focuses on protecting systems from cyber threats through prevention, detection, and response strategies.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Start Your Cyber Security Journey (Part 2)''',
        body: '''Key Learnings: Blue Team Roles: Explored the responsibilities of defensive security teams, including monitoring, incident response, and implementing security measures.

Security Operations Center (SOC): Understood the function of SOCs in continuously monitoring networks, analyzing threats, and coordinating responses.

Digital Forensics and Incident Response (DFIR): Learned about the processes involved in investigating security incidents, preserving evidence, and mitigating impacts.

Preventative Measures: Emphasized the importance of user education, regular system updates, asset management. And the deployment of security tools like firewalls and intrusion prevention systems..

Search Skills
Overview: Effective information gathering is crucial in cybersecurity for tasks such as weakness assessment, threat intelligence, and research.

Key Learnings: Evaluating Information Sources: Developed the ability to assess the credibility and relevance of information found online. Advanced Search Techniques: Learned to refine search queries using operators like filetype:pdf to locate specific document types and site: to search within particular domains..

Specialized Search Engines: Explored tools beyond traditional search engines, such as Shodan, for discovering internet-connected devices and services.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Start Your Cyber Security Journey (Part 3)''',
        body: '''Understanding Technical Documentation: Recognized the value of official documentation and resources in gaining accurate and detailed information about tools and protocols..

Key Takeaways
A balanced understanding of both offensive and defensive security is essential for a comprehensive cybersecurity skill set. Hands-on experience with tools and real-world scenarios enhances learning and prepares for practical challenges..

Effective research and information evaluation are foundational skills that support all areas of cybersecurity.''',
        codeSnippet: '''''',
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'linux-fundamentals',
    title: '''Linux Fundamentals''',
    description: '''Learn Linux Fundamentals in plain, everyday language. This course has 2 short lessons covering Linux Fundamentals (Part 1), Linux Fundamentals (Part 2).''',
    instructor: '''Hustle Academy''',
    duration: '2 min',
    difficulty: 'Beginner',
    category: '''Cybersecurity''',
    icon: Icons.security,
    color: Colors.deepOrange,
    lessons: [
      AppLesson(
        title: '''Linux Fundamentals (Part 1)''',
        body: '''Linux Fundamentals – TryHackMe Summary
This document outlines the essential concepts and commands acquired from the TryHackMe Linux Fundamentals series, comprising three parts. These modules provide a foundational understanding of Linux, crucial for any aspiring cybersecurity professional.

Part 1: Introduction to Linux
Background: Linux, introduced in 1991, is an open-source, secure, and versatile operating system. Basic Commands:

echo: Displays a line of text. whoami: Shows the current user. ls: Lists directory contents. cd: Changes the current directory. pwd: Prints the current working directory.

cat: Concatenates and displays file content. File Operations:
: Redirects output to a file, overwriting existing content. : Appends output to a file.

grep: Searches for patterns within files. Process Management: &: Runs a command in the background. Part 2: Intermediate Linux Concepts
Remote Access:

ssh: Securely connects to remote machines. Command Enhancements: Flags and arguments: Modify command behavior (e.g., ls -l). man: Displays manual pages for commands.

File System Navigation: cp: Copies files or directories. mv: Moves or renames files or directories. rm: Removes files or directories. Permissions:''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Linux Fundamentals (Part 2)''',
        body: '''chmod: Changes file permissions. chown: Changes file ownership. ls -l: Displays detailed file information, including permissions. Part 3: Advanced Tools and Utilities
Text Editors:

nano: User-friendly command-line text editor. vim: Advanced text editor with powerful features. Package Management: apt: Handles package installation and management.

System Monitoring: ps: Displays current processes. top: Real-time system monitoring. journalctl: Views system logs. Automation: cron: Schedules recurring tasks.

crontab: Edits the cron schedule. Key Takeaways
Understanding Linux\'s structure and command-line interface is vital for cybersecurity tasks.

Proficiency in file permissions and user management enhances system security. Familiarity with system monitoring tools aids in identifying and responding to potential threats.''',
        codeSnippet: '''''',
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'windows-and-ad-fundamentals',
    title: '''Windows and AD Fundamentals''',
    description: '''Learn Windows and AD Fundamentals in plain, everyday language. This course has 3 short lessons covering Windows and AD Fundamentals (Part 1), Windows and AD Fundamentals (Part 2), Windows and AD Fundamentals (Part 3).''',
    instructor: '''Hustle Academy''',
    duration: '3 min',
    difficulty: 'Beginner',
    category: '''Cybersecurity''',
    icon: Icons.security,
    color: Colors.deepOrange,
    lessons: [
      AppLesson(
        title: '''Windows and AD Fundamentals (Part 1)''',
        body: '''Windows and Active Directory Fundamentals – TryHackMe Summary
This document outlines the essential concepts and skills acquired from the TryHackMe modules focusing on Windows operating systems and Active Directory. These modules provide a foundational understanding crucial for cybersecurity professionals, especially those interested in system administration and network security.

Windows Fundamentals Part 1
Overview: An introduction to the Windows operating system, covering its interface, file system, and essential tools.

Key Learnings: Windows Editions: Understanding different versions of Windows and their use cases. File System: Exploration of NTFS, system folders like System32. And user directories..

User Account Control (UAC): Insights into how UAC helps prevent not allowed changes to the system. Control Panel & Task Manager: Navigating system settings and monitoring applications and processes..

Windows Fundamentals Part 2
Overview: Delving deeper into Windows system configurations, security settings, and administrative tools. Key Learnings:

System Settings: Using tools like msconfig and msinfo32 to manage startup processes and view system information. User Account Control Settings: Adjusting UAC settings to balance security and usability..''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Windows and AD Fundamentals (Part 2)''',
        body: '''Resource Monitoring: Employing tools like Resource Monitor and Task Manager to oversee system performance. Windows Registry: Understanding the structure and significance of the Windows Registry in system settings..

Windows Fundamentals Part 3
Overview: Focusing on Windows security features and tools that protect the system from threats. Key Learnings: Windows Updates: The importance of keeping the system updated to patch weaknesses..

Windows Security: Exploring built-in security tools like Windows Defender and A security guard for your network. BitLocker: Understanding how BitLocker encrypts drives to protect data..

Volume Shadow Copy Service: Learning about system restore points and backup mechanisms. Active Directory Basics
Overview: An introduction to Active Directory (AD), its components. And its role in network management..

Key Learnings: Active Directory Structure: Understanding domains, trees. And forests in AD. Domain Controllers: Recognizing the role of domain controllers in managing network security and resources..

Users and Groups: Managing user accounts and grouping them for efficient permission management. Group Policy Objects (GPOs): Implementing policies across the network to enforce security settings and configurations..''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Windows and AD Fundamentals (Part 3)''',
        body: '''Key Takeaways
A solid grasp of Windows operating systems and Active Directory is essential for managing and securing enterprise environments.

Familiarity with Windows administrative tools enhances the ability to troubleshoot and maintain systems effectively. Understanding Active Directory\'s structure and functions is crucial for network administration and implementing security policies..''',
        codeSnippet: '''''',
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'command-line',
    title: '''Command Line''',
    description: '''Learn Command Line in plain, everyday language. This course has 2 short lessons covering Command Line (Part 1), Command Line (Part 2).''',
    instructor: '''Hustle Academy''',
    duration: '2 min',
    difficulty: 'Advanced',
    category: '''Cybersecurity''',
    icon: Icons.security,
    color: Colors.deepOrange,
    lessons: [
      AppLesson(
        title: '''Command Line (Part 1)''',
        body: '''Command Line Fundamentals – TryHackMe Summary
This document highlights the essential commands and concepts learned from the TryHackMe Command Line module, covering Windows Command Prompt, PowerShell. And Linux shell. These skills are fundamental for navigating and managing systems, performing gathering information about a target. And executing security tasks, making command-line proficiency a core requirement for cybersecurity professionals.

Key Learnings:
Windows Command Prompt (CMD)
Mastered basic navigation commands (cd, dir, type, copy, move, del). Learned how to view and manage processes (tasklist, taskkill) and network connections (netstat).

Practiced manipulating files and directories efficiently to perform gathering information about a target and system management tasks. Windows PowerShell
Explored PowerShell cmdlets (Get-Process, Get-Service, Stop-Process, Start-Service).

Learned to retrieve system and network information using commands like Get-NetIPConfiguration and Test-Connection. Understood how PowerShell scripting can be used to automate repetitive administrative and security-related tasks. Linux Shell (Bash)
Gained confidence in navigating Linux file systems using ls, cd, pwd. And manipulating files with cat, nano, grep. And find.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Command Line (Part 2)''',
        body: '''Learned how to manage processes (ps, kill, top) and inspect network configurations (ifconfig, netstat, ping). Practiced file permission management with chmod and chown, crucial for securing Linux environments. Security Relevance
Understood the importance of command-line proficiency in penetration testing and incident response.

Learned how the people trying to break in and defenders both use command-line tools for enumeration, privilege escalation. And system forensics. Key Takeaways
Proficiency in navigating and managing both Windows and Linux command lines is essential for effective system administration and security tasks. Understanding core commands in CMD, PowerShell, and Bash enables efficient file manipulation, process management, and network troubleshooting. Knowledge of PowerShell scripting enhances automation capabilities for repetitive and complex security operations. Command-line skills are critical for both the people trying to break in and defenders in activities like gathering information about a target, privilege escalation. And forensic analysis. Overall, mastering command-line fundamentals lays a strong foundation for practical cybersecurity work and incident response.''',
        codeSnippet: '''''',
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'networking',
    title: '''Networking''',
    description: '''Learn Networking in plain, everyday language. This course has 3 short lessons covering Networking (Part 1), Networking (Part 2), Networking (Part 3).''',
    instructor: '''Hustle Academy''',
    duration: '3 min',
    difficulty: 'Advanced',
    category: '''Cybersecurity''',
    icon: Icons.security,
    color: Colors.deepOrange,
    lessons: [
      AppLesson(
        title: '''Networking (Part 1)''',
        body: '''Networking Fundamentals – TryHackMe Summary
This document summarizes key networking concepts and tools learned from the TryHackMe Networking module, including core protocols, secure communication standards. And practical packet analysis using Wireshark, TCPDump. And Nmap. A solid understanding of networking is critical for identifying weaknesses, analyzing traffic, and performing effective penetration testing or incident response.

Key Learnings:
Networking Concepts & Essentials
Understood OSI and TCP/IP models, data encapsulation, and packet flow across layers. Learned about IP addressing (IPv4/IPv6), subnetting, and CIDR notation for efficient network design.

Explored common network topologies, NAT, and DHCP operations. Core Networking Protocols
Studied the functionality and security considerations of protocols like ARP, ICMP, DNS, HTTP, and HTTPS.

Understood how the people trying to break in attack weaknesses in protocols (e.g., ARP spoofing, DNS poisoning). Secure Networking Protocols
Learned the importance of TLS, SSH, and IPSec in protecting data in transit.

Differentiated between secure and insecure protocols (e.g., HTTPS vs. HTTP, SFTP vs. FTP). Wireshark: The Basics
Captured and analyzed network traffic to identify source/destination IPs, ports, and protocols.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Networking (Part 2)''',
        body: '''Learned to filter packets using display filters (ip.addr, tcp.port, http.request). Identified suspicious traffic patterns useful in threat hunting and incident response. TCPDump: The Basics
Performed live packet captures directly from the command line.

Used essential TCPDump filters (tcp, udp, port, host) to focus on specific traffic. Understood how TCPDump complements Wireshark in CLI-based forensic investigations. Nmap: The Basics
Learned active network gathering information about a target techniques including host discovery, port scanning, and service enumeration.

Practiced common Nmap scans: -sS (SYN scan) for stealth scanning -sV (Service/Version detection) -O (OS detection) Understood how the people trying to break in use Nmap for footprinting and how defenders can detect such activity. Security Relevance
Networking knowledge is critical for identifying weaknesses, spotting anomalous traffic, and conducting effective penetration testing and defensive monitoring.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Networking (Part 3)''',
        body: '''Hands-on experience with Wireshark, TCPDump. And Nmap strengthened my ability to perform basic network forensics and gathering information about a target. Key Takeaways
A strong understanding of networking models, IP addressing, and protocols is vital for analyzing and securing network communications. Familiarity with both insecure and secure protocols equips you to identify weaknesses and set up proper protections. Hands-on practice with tools like Wireshark and TCPDump enhances skills in packet capture and traffic analysis, essential for threat detection and incident response. Using Nmap for network gathering information about a target builds critical abilities in identifying live hosts, open ports. And running services. Overall, networking fundamentals are indispensable for penetration testing, weakness assessment, and effective cybersecurity defense.''',
        codeSnippet: '''''',
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'cryptography',
    title: '''Cryptography''',
    description: '''Learn Cryptography in plain, everyday language. This course has 3 short lessons covering Cryptography (Part 1), Cryptography (Part 2), Cryptography (Part 3).''',
    instructor: '''Hustle Academy''',
    duration: '3 min',
    difficulty: 'Beginner',
    category: '''Cybersecurity''',
    icon: Icons.security,
    color: Colors.deepOrange,
    lessons: [
      AppLesson(
        title: '''Cryptography (Part 1)''',
        body: '''Cryptography Fundamentals – TryHackMe Summary
This document outlines the key concepts and tools learned from the TryHackMe Cryptography module. It covers the fundamentals of scrambling data so others can\'t read it, public key cryptography, hashing, and password-cracking techniques. These concepts form a crucial part of understanding how data is secured and how the people trying to break in attack weak cryptographic implementations, making it essential knowledge for any aspiring cybersecurity professional.

Key Learnings:
Cryptography Basics
Learned the difference between symmetric and asymmetric scrambling data so others can\'t read it and their real-world use cases. Understood key cryptographic terms like plaintext, ciphertext, keys, and ciphers.

Explored the importance of cryptography in ensuring confidentiality, integrity, and proving who you are in secure communications. Public Key Cryptography (PKI) Basics
Studied how public and private key pairs are used for secure communication and digital signatures.

Learned the role of certificates and Certificate Authorities (CAs) in establishing trust over the internet. Understood the working of protocols like SSL/TLS in securing data in transit. Hashing Basics
Learned how hashing provides integrity verification for files and passwords.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Cryptography (Part 2)''',
        body: '''Explored common hashing algorithms such as MD5, SHA-1, and SHA-256 along with their security weaknesses. Understood the concept of salting to protect against rainbow table attacks. John the Ripper: Basics
Used John the Ripper for password-cracking demonstrations, learning how the people trying to break in recover weakly hashed passwords.

Practiced dictionary-based and brute-force attacks against simple password hashes. Understood the defensive takeaway: why enforcing strong passwords and proper hashing algorithms is essential. Security Relevance
Gained insight into how cryptography underpins modern cybersecurity, from secure proving who you are to data scrambling data so others can\'t read it.

Learned how the people trying to break in attack weak algorithms and misconfigured hashing to break into systems, reinforcing the importance of strong cryptographic practices.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Cryptography (Part 3)''',
        body: '''Key Takeaways
Grasping the principles of symmetric and asymmetric scrambling data so others can\'t read it is essential for understanding data confidentiality and secure communications. Knowledge of public key infrastructure and SSL/TLS protocols helps in appreciating how trust and scrambling data so others can\'t read it are maintained online. Understanding hashing algorithms and techniques like salting is critical for protecting data integrity and defending against password attacks. Hands-on experience with tools like John the Ripper highlights the importance of strong password policies and robust cryptographic implementations. Overall, strong cryptographic practices form the backbone of cybersecurity, making them indispensable for protecting systems from the people trying to break in exploiting weak or outdated algorithms.''',
        codeSnippet: '''''',
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'exploitation-basics',
    title: '''Exploitation Basics''',
    description: '''Learn Exploitation Basics in plain, everyday language. This course has 2 short lessons covering Exploitation Basics (Part 1), Exploitation Basics (Part 2).''',
    instructor: '''Hustle Academy''',
    duration: '2 min',
    difficulty: 'Advanced',
    category: '''Cybersecurity''',
    icon: Icons.security,
    color: Colors.deepOrange,
    lessons: [
      AppLesson(
        title: '''Exploitation Basics (Part 1)''',
        body: '''Attack Basics – TryHackMe Summary
This document summarizes the key attack techniques and tools learned from the TryHackMe Attack Basics module. The module introduced weakness attack fundamentals, including CVE attack, Metasploit framework usage, and post-attack with Meterpreter. Understanding these concepts is crucial for penetration testers and security professionals to identify, attack, and remediate system weaknesses.

Key Learnings:
Moniker Link Attack (CVE-2024-21413)
Learned about the Microsoft Outlook weakness (CVE-2024-21413). Which allows the people trying to break in to bypass security restrictions via a harmful moniker link.

Understood how the people trying to break in craft harmful payloads to attack insecure link handling. Recognized a way to reduce the risk strategies, including patch management and strict email security policies. Metasploit: Introduction
Explored the Metasploit Framework, a powerful tool for weakness scanning, attack, and post-attack.

Learned the structure of Metasploit modules: exploits, payloads, auxiliaries, post modules. Metasploit: Attack
Practiced selecting, configuring, and executing attack modules to break into at risk targets.

Learned to identify compatible payloads and run successful attacks in controlled environments. Metasploit: Meterpreter
Gained hands-on experience with Meterpreter, Metasploit’s post-attack tool.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Exploitation Basics (Part 2)''',
        body: '''Learned commands for system enumeration, privilege escalation, file transfer, and persistence techniques. Understood the importance of proper incident response and detection to counter post-attack activities. Blue (EternalBlue Attack)
Exploited a at risk Windows system using EternalBlue (MS17-010) through Metasploit.

Learned how the people trying to break in use SMB weaknesses for remote code execution. Understood how patching, network segmentation, and disabling SMBv1 help prevent such attacks.

Key Takeaways
Understanding how weaknesses like CVEs can be exploited is fundamental for effective penetration testing. Proficiency with the Metasploit Framework streamlines the process of scanning, exploiting, and managing post-attack activities. Hands-on experience with Meterpreter enhances skills in system enumeration, privilege escalation, and maintaining access. Recognizing common attack vectors such as EternalBlue helps in applying appropriate defense strategies like patching and network segmentation.''',
        codeSnippet: '''''',
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'web-hacking',
    title: '''Web Hacking''',
    description: '''Learn Web Hacking in plain, everyday language. This course has 2 short lessons covering Web Hacking (Part 1), Web Hacking (Part 2).''',
    instructor: '''Hustle Academy''',
    duration: '2 min',
    difficulty: 'Beginner',
    category: '''Cybersecurity''',
    icon: Icons.security,
    color: Colors.deepOrange,
    lessons: [
      AppLesson(
        title: '''Web Hacking (Part 1)''',
        body: '''Web Hacking – TryHackMe Summary
This document summarizes the foundational concepts and tools covered in the TryHackMe Web Hacking module. The module introduced essential web application security topics including web fundamentals, client- and server-side scripting, database interactions, and common weaknesses. Mastering these areas is critical for aspiring penetration testers and security professionals aiming to identify, attack. And defend against web-based threats.

Key Learnings: Web Application Basics
Learned about the core structure of web applications including client-server communication, HTTP methods. And request-response cycles. Understood how these components interact and where security weaknesses often arise.

JavaScript Essentials
Explored fundamental JavaScript concepts relevant to web security. Gained insight into how scripts run on the client side and how the people trying to break in attack client-side weaknesses like Cross-Site Scripting (XSS).

SQL Fundamentals
Studied SQL query language to understand how web apps communicate with databases. Learned to recognize and attack SQL Injection weaknesses by crafting harmful queries.

Burp Suite: The Basics
Practiced intercepting and modifying HTTP traffic using Burp Suite. Learned to analyze web requests and responses to discover weaknesses such as parameter tampering and injection points.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Web Hacking (Part 2)''',
        body: '''OWASP Top 10 - 2021
Reviewed the most critical web application security risks identified by OWASP. Focused on common weaknesses including Injection, Broken Access Control. And Security Misconfiguration, gaining strategies for testing and a way to reduce the risk.

Key Takeaways
A solid grasp of web application architecture and HTTP fundamentals is essential for identifying security flaws. Knowledge of JavaScript and SQL empowers testers to uncover client-side and database weaknesses effectively. Hands-on experience with tools like Burp Suite enhances the ability to analyze and manipulate web traffic for security testing. Awareness of the OWASP Top 10 risks helps prioritize and focus efforts on the most critical web application weaknesses.''',
        codeSnippet: '''''',
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'offensive-security-tooling',
    title: '''Offensive Security Tooling''',
    description: '''Learn Offensive Security Tooling in plain, everyday language. This course has 2 short lessons covering Offensive Security Tooling (Part 1), Offensive Security Tooling (Part 2).''',
    instructor: '''Hustle Academy''',
    duration: '2 min',
    difficulty: 'Advanced',
    category: '''Cybersecurity''',
    icon: Icons.security,
    color: Colors.deepOrange,
    lessons: [
      AppLesson(
        title: '''Offensive Security Tooling (Part 1)''',
        body: '''Offensive Security Tooling – TryHackMe Summary
This document summarizes the core offensive security tools covered in the TryHackMe Offensive Security Tooling module. The module introduced powerful utilities used for password cracking, directory brute forcing, shell access, and automated SQL injection detection. Mastery of these tools is essential for penetration testers to efficiently discover and attack weaknesses in target systems.

Key Learnings: Hydra
Learned to perform fast and flexible brute-force attacks against various protocols such as FTP, SSH, and HTTP. Understood how to configure username and password lists for effective credential stuffing.

Gobuster: The Basics
Explored directory and file brute forcing techniques to discover hidden resources on web servers. Practiced using wordlists and tuning scan options for optimized gathering information about a target.

Shells Overview
Studied different types of shells, including reverse shells and bind shells. Learned the role of shells in gaining and maintaining remote access during penetration tests.

SQLMap: The Basics
Gained experience with SQLMap to automate SQL injection detection and attack. Understood how to use SQLMap for database enumeration, data extraction, and bypassing proving who you are.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Offensive Security Tooling (Part 2)''',
        body: '''Key Takeaways
Proficiency with tools like Hydra and Gobuster enhances the ability to discover hidden resources and crack your username and password efficiently. Understanding different shell types is crucial for establishing reliable remote access during security assessments. Automating SQL injection testing with SQLMap streamlines identifying and exploiting database weaknesses. Overall, these offensive security tools are vital components in a penetration tester’s toolkit for thorough and effective assessments.''',
        codeSnippet: '''''',
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'defensive-security',
    title: '''Defensive Security''',
    description: '''Learn Defensive Security in plain, everyday language. This course has 2 short lessons covering Defensive Security (Part 1), Defensive Security (Part 2).''',
    instructor: '''Hustle Academy''',
    duration: '2 min',
    difficulty: 'Beginner',
    category: '''Cybersecurity''',
    icon: Icons.security,
    color: Colors.deepOrange,
    lessons: [
      AppLesson(
        title: '''Defensive Security (Part 1)''',
        body: '''Defensive Security – TryHackMe Summary
This document outlines the essential concepts and practices covered in the TryHackMe Defensive Security module. The module introduced core principles of defending systems and networks, including Security Operations Center (SOC) functions, digital forensics, incident response processes. And log management. These skills are critical for security professionals to detect, investigate, and respond effectively to cyber threats.

Key Learnings: Defensive Security Intro
Gained an overview of defensive security strategies focused on protecting assets and minimizing risk. Understood the importance of proactive defense alongside reactive incident handling.

SOC Fundamentals
Learned the role of a Security Operations Center in continuous monitoring and threat detection. Explored common SOC tools and workflows for analyzing security alerts and coordinating responses.

Digital Forensics Fundamentals
Studied forensic principles and methodologies used to collect and preserve digital evidence. Understood how forensic investigations support incident analysis and legal processes.

Incident Response Fundamentals
Learned the stages of incident response: preparation, identification, containment, eradication, recovery, and lessons learned. Practiced methods for timely and effective handling of security incidents.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Defensive Security (Part 2)''',
        body: '''Logs Fundamentals
Explored the importance of logging for security monitoring and auditing. Learned how to interpret various log types to detect suspicious activity and support investigations.

Key Takeaways
Defensive security requires a blend of proactive monitoring, rapid incident response, and thorough investigation to protect organizational assets. Understanding SOC operations is key to effective threat detection and coordination of security efforts. Digital forensics provides critical evidence for understanding and mitigating cyber incidents. Proper log management is indispensable for identifying attacks and conducting detailed security analyses. Mastering these fundamentals strengthens the ability to defend systems and respond decisively to cybersecurity threats.''',
        codeSnippet: '''''',
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'security-solutions',
    title: '''Security Solutions''',
    description: '''Learn Security Solutions in plain, everyday language. This course has 2 short lessons covering Security Solutions (Part 1), Security Solutions (Part 2).''',
    instructor: '''Hustle Academy''',
    duration: '2 min',
    difficulty: 'Intermediate',
    category: '''Cybersecurity''',
    icon: Icons.security,
    color: Colors.deepOrange,
    lessons: [
      AppLesson(
        title: '''Security Solutions (Part 1)''',
        body: '''Security Solutions – TryHackMe Summary
This document summarizes key concepts and tools covered in the TryHackMe Security Solutions module. The module introduced essential security technologies including SIEM systems, firewalls, intrusion detection systems (IDS), and weakness scanners. Understanding these solutions is crucial for building effective defense mechanisms and maintaining a secure network environment.

Key Learnings: Introduction to SIEM
Learned about Security Information and Event Management (SIEM) systems and their role in aggregating and analyzing security data from multiple sources. Explored how SIEM helps in real-time threat detection, correlation of events, and compliance reporting.

A security guard for your network Fundamentals
Studied how firewalls enforce network security policies by filtering inbound and outbound traffic. Understood different types of firewalls (packet filtering, stateful, proxy) and common settings techniques.

IDS Fundamentals
Explored Intrusion Detection Systems and their purpose in monitoring network or host activity for harmful behavior. Learned the difference between Network-based IDS (NIDS) and Host-based IDS (HIDS).''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Security Solutions (Part 2)''',
        body: '''Weakness Scanner Overview
Gained insight into automated tools that scan systems and networks to identify security weaknesses. Learned about common scanners, their reporting features, and how to prioritize remediation efforts.

Key Takeaways
SIEM platforms are vital for centralized security monitoring and incident detection across complex environments. Firewalls serve as the first line of defense by controlling network traffic based on security policies. Intrusion Detection Systems provide critical visibility into suspicious activity and potential breaches. Weakness scanners help proactively identify and address security gaps before the people trying to break in can attack them. Together, these security solutions form the foundation of a robust cybersecurity posture.''',
        codeSnippet: '''''',
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'defensive-security-tooling',
    title: '''Defensive Security Tooling''',
    description: '''Learn Defensive Security Tooling in plain, everyday language. This course has 2 short lessons covering Defensive Security Tooling (Part 1), Defensive Security Tooling (Part 2).''',
    instructor: '''Hustle Academy''',
    duration: '2 min',
    difficulty: 'Beginner',
    category: '''Cybersecurity''',
    icon: Icons.security,
    color: Colors.deepOrange,
    lessons: [
      AppLesson(
        title: '''Defensive Security Tooling (Part 1)''',
        body: '''Defensive Security Tooling – TryHackMe Summary
This document highlights key defensive security tools introduced in the TryHackMe Defensive Security Tooling module. The module covered practical utilities for data analysis, harmful software analysis. And incident investigation, empowering defenders to detect, analyze. And respond to threats effectively.

Key Learnings: CyberChef: The Basics
Learned to use CyberChef for versatile data transformations and decoding tasks. Practiced operations like encoding/decoding, hashing, and extracting information from complex data formats.

CAPA: The Basics
Explored CAPA (Code Analysis Pipeline for Automated harmful software analysis) for identifying capabilities in executable files. Understood how CAPA helps analysts quickly recognize harmful behaviors and harmful software functionality.

REMnux: Getting Started
Familiarized with REMnux, a Linux toolkit for reverse-engineering and harmful software analysis. Learned how REMnux provides a comprehensive suite of tools for static and dynamic analysis of suspicious files.

FlareVM: Arsenal of Tools
Discovered FLARE VM, a Windows-based security distribution packed with analysis and forensic tools. Understood how FLARE VM supports incident responders and harmful software analysts in performing thorough investigations.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Defensive Security Tooling (Part 2)''',
        body: '''Key Takeaways
Mastering tools like CyberChef enhances data decoding and analysis efficiency in investigations. CAPA streamlines the identification of harmful software capabilities, speeding up analysis workflows. REMnux and FLARE VM provide specialized environments packed with powerful tools critical for harmful software and forensic analysis. These defensive tooling platforms are essential for security professionals to detect, dissect, and respond to cyber threats effectively.''',
        codeSnippet: '''''',
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'readme',
    title: '''README''',
    description: '''Learn README in plain, everyday language. This course has 6 short lessons covering 🛡️ TryHackMe: Cyber Security 101 Path, 🧠 Path Overview, 📁 Room Progress, and 3 more.''',
    instructor: '''Hustle Academy''',
    duration: '6 min',
    difficulty: 'Beginner',
    category: '''Cybersecurity''',
    icon: Icons.security,
    color: Colors.deepOrange,
    lessons: [
      AppLesson(
        title: '''🛡️ TryHackMe: Cyber Security 101 Path''',
        body: '''Welcome to my learning journal for the Cyber Security 101 path on TryHackMe. This beginner-friendly path is designed to build a solid foundation in multiple areas of cybersecurity including networking, cryptography, system fundamentals, offensive/defensive tooling. And career awareness. I\'ve documented my progress here for both personal reference and to showcase my hands-on learning.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''🧠 Path Overview''',
        body: '''Cyber Security 101 Path
This beginner-friendly path aims to give a solid introduction to the different areas in computer security. It covers fundamental concepts and applications in:
Computer networking and cryptography
MS Windows, Active Directory. And Linux basics
Offensive security tools and system attack
Defensive security solutions and tools
Cyber security career paths.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''📁 Room Progress''',
        body: '''Room Title   Status   Topics Covered 01   Start Your Cyber Security Journey    Completed   What is cyber security, key domains, mindset
  02   Linux Fundamentals    Completed   Shell basics, permissions, user management
  03   Windows and AD Fundamentals    Completed   Windows basics, Active Directory, users/groups
  04   Command Line    Completed   Bash, PowerShell, useful commands
  05   Networking    Completed    TCP/IP, ports, protocols, OSI model
  06   Cryptography    Completed    Scrambling data so others can\'t read it types, hashing, encoding
  07   Attack Basics    Completed    Weaknesses, CVEs, privilege escalation
  08   Web Hacking    Completed    HTTP, forms, cookies, XSS, SQLi
  09   Offensive Security Tooling    Completed    Nmap, Hydra, Burp Suite, basic recon
  10   Defensive Security    Completed    Threat detection, monitoring basics
  11   Security Solutions    Completed    Firewalls, AV, IDS/IPS, endpoint tools
| 12 | Defensive Security Tooling |  Completed  | SIEMs, EDR, threat intelligence tools.

Each markdown file contains key takeaways, tools used, commands learned, and personal insights from each module.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''📸 Example Topics Covered''',
        body: '''How to use Nmap for port scanning
Analyzing packets using Wireshark
Writing and using basic Bash commands
Simulating brute-force attacks with Hydra
Understanding Active Directory structure
Exploring scrambling data so others can\'t read it methods and hashes
Using SIEMs for log analysis and detection.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''🧑💻 About Me''',
        body: '''I recently completed my Master’s degree in Cyber Security Technology and have built a strong practical skill set through hands-on labs in incident response, threat detection. And both offensive and defensive security tooling. MSc Cyber Security (Northumbria University, London)
 LinkedIn
 GitHub''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''🚀 What\'s Next?''',
        body: '''After completing this path, I’ll be diving into:
Cyber Defence Path
Hands-on labs with SIEMs, Splunk. And Microsoft Sentinel
Real-world Blue Team projects and GitHub documentation.

Stay tuned!''',
        codeSnippet: '''''',
        hasImage: false,
      )
    ],
  )
];
