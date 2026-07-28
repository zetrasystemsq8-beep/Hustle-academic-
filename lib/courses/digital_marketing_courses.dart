import 'package:flutter/material.dart';
import '../models/app_course.dart';

final digitalMarketingCourses = <AppCourse>[

AppCourse(
  id: "marketing_1",
  title: "Authentication",
  description: "Authentication",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "1 Lessons",
  lessons: [
    AppLesson(
      title: "Authentication",
      body: r"""Authentication

Mautic uses basic authentication for Users, however there is the ability to integrate with a SAML SSO - Single Sign-On - provider.


SAML Single Sign On


SAML is a single sign on protocol that allows single sign on and User creation in Mautic using a third party User source called an identity provider (IDP).

Turning on SAML
To turn on SAML support in Mautic, you first need the IDP's metadata XML which they provide. If it's a URL, browse to the URL then save the content into an XML file.

1. Click the settings wheel in the top right corner to open the **Settings** menu.

2. Navigate to **Configuration** > **User/Authentication** Settings.

  :width: 800
  :alt: Screenshot of SAML SSO Settings

3. Upload this file as the Identity Provider Metadata file.

4. It's recommended to create a non-Admin Role as the default Role for created Users. Select this Role in the '**Default Role for created Users**' dropdown. For more information, see :doc:`Users and Roles</users_roles/managing_users>`.

  :width: 800
  :alt: Screenshot of the User Role Permission


Configuring the IDP


The IDP may ask for the following settings:


#. **Entity ID** - This is the site URL, displayed at the top of **User/Authentication Settings**. Copy this exactly as is to the IDP.

   .. note::

      If you use a custom domain, set the site URL in **Configuration** > **System Settings** to match it. This keeps your SAML setup working correctly.

#. **Service Provider Metadata** - If the provider requires a URL, use ``https://example.com/saml/metadata.xml``. If it needs a file instead of a URL, open the URL in a browser and save the content as an XML file.
#. **Assertion Consumer Service** - Use ``https://example.com/s/saml/login_check``.
#. **Issuer** - It should come from the IDP but is often configurable. If it's a URL, be sure that the scheme - ``http://`` or ``https://`` - isn't part of it.
#. **Verify request signatures or an SSL certificate** - If the IDP supports encrypting and validating request signatures from Mautic to the IDP, generate a self-signed SSL certificate. Upload the certificate and private key through Mautic's **Configuration** > **User/Authentication Settings** under the \"**Use a custom X.509 certificate and private key to secure communication between Mautic and the IDP**\" section. Then upload the certificate to the IDP.
#. **Custom attributes** - Mautic requires three custom attributes in the IDP responses - email, first name, and last name - and can optionally include a username. Configure the attribute names used by the IDP in Mautic's **Configuration** > **User/Authentication Settings** under the \"**Enter the names of the attributes the configured IDP uses for the following Mautic User fields**\" section.



Example - Azure SAML SSO

#. Register a new application by going to **Enterprise Applications**, clicking **Create your own application**, and selecting **Integrate any other application you don't find in the gallery (Non-gallery)**.
#. Go to the **Single sign-on** menu.
#. **Entity ID** - This is the site URL, displayed at the top of **User/Authentication Settings**. Copy this exactly as is to the IDP.
#. **Reply URL (Assertion Consumer Service URL)** - Use ``https://example.com/s/saml/login_check``.
#. In the **SAML Certificates** section, download the **Federation Metadata XML**.
#. Upload the downloaded **Federation Metadata XML** file to the **Identity provider metadata file** field in Mautic, and leave the **X.509 Certificate** field blank.
#. Use the following for the custom attributes fields:

   * **E-Mail**: ``http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress``
   * **First Name**: ``http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname``
   * **Last Name**: ``http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname``
   * **Username (optional)**: ``http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name``


Logging in

Once configured with the IDP and the IDP with Mautic, Mautic redirects all logins to the IDP's login. ``/s/login`` is still available for direct logins but you have to access it directly.

Login to the IDP, which then redirects you back to Mautic. If the exchange is successful Mautic creates a User if it doesn't already exist, and logs the User into the system.


Managing passwords for SAML-authenticated Users



Mautic hides the password fields on the Account page and User edit form for SAML-authenticated Users. SAML-authenticated Users log in through the identity provider, so they manage their passwords there, not in Mautic.


Recovering from a login error


A SAML login can fail if the session expires or if Mautic receives an unexpected response from the IDP, such as the intermittent 'Unknown Response' error. When this happens, Mautic clears the session and shows a retry screen. Select the login button to try again. If the error keeps happening, contact your administrator.


Turning off SAML

To turn off SAML, click the Remove link to the right of the Identity provider metadata file label.

  :width: 800
  :alt: Screenshot of the authentication settings section""",
    ),

  ],
),

AppCourse(
  id: "marketing_2",
  title: "Builders",
  description: "Builders",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "2 Lessons",
  lessons: [
    AppLesson(
      title: "Creating Themes",
      body: r"""Creating Themes



Why use email Themes?

Purpose of a Theme


The GrapesJS builder makes it possible to insert HTML code and edit it in a 'What You See Is What You Get' (WYSIWYG) environment.

A Theme can feature a wide variety of predefined blocks and sections reflecting the desired Email design - a template from which to start.

By choosing a Theme, you can create beautiful Emails very efficiently.


Modifying legacy Themes


The GrapesJS Builder checks the Theme configuration file before listing the available Themes, to determine which are compatible with the Builder.

Since :xref:`Mautic 3` a new line defines the compatible Builders:

File name: config.json


    {
        \"name\": \"Great Theme\",
        \"author\": \"Mr. Robot\",
        \"authorUrl\": \"https://mautic.org\",
        \"builder\": \"grapesjsbuilder\",
        \"features\": [
            \"email\"
        ]
    }

With the builder/s defined, the Theme shows in the Theme selection page.

If you wish to support more than one Builder, specify them in an array: ``\"builder\": [\"legacy\", \"grapesjsbuilder\"],``


Creating a Theme from scratch


HTML markup

It's possible to use HTML for Themes, and the GrapesJS builder offers basic WYSIWYG editing capabilities.

Once converted into HTML, however, the structure is table based, and the blocks are hard to move around. For this reason, MJML Themes are preferable.

MJML markup

The MJML language allows the creation of blocks which can be freely moved around in the editor, changing the layout fundamentally without coding.

In order to harness the power of MJML, you must code the whole Theme in MJML.

The best place to do so is the online editor at :xref:`MJML`.

Documentation on using sections, columns, and blocks is available in the :xref:`MJML Documentation`


Head Components


Mautic processes the ``<mj-head>`` components, including ``<mj-attributes>``.

With ``<mj-attributes>``, you can define default styling for Builder blocks. When you drag blocks into the Email editor, they inherit the Theme's colors, fonts, and spacing rather than generic defaults. The Brienz Theme demonstrates this approach.

**Tested elements** include: ``mj-attributes``, ``mj-breakpoint``, ``mj-font``, ``mj-html-attributes``, ``mj-style``, ``mj-title``, and ``mj-preview``.


Body Components


At present, Mautic processes most ``<mj-body>`` components.

**Tested elements** are: mj-button, mj-column, mj-divider, mj-image, mj-navbar, mj-section, mj-spacer, mj-text


Image Asset relative URLs


Images have to refer to the Themes folder the following way:

``<mj-image src=\"{{ getAssetUrl('Themes/'~Theme~'/assets/imagename.ext', null, null, true) }}\" alt=\"logo\" align=\"center\" width=\"105px\" padding=\"10px 0\"></mj-image>``

File structure


    name.zip
    ├── assets
    │   ├── image1.ext
    │   └── image2.ext
    ├── html
    │   ├── email.html.twig
    │   ├── email.mjml.twig
    │   ├── base.html.twig
    │   └── message.html.twig
    ├── config.json
    └── thumbnail.png

Steps to save the Theme package

Once you have finalized your design in MJML, go through the following steps to create the Theme package:

* Save your images in the Assets folder.

* Save your MJML in the ``html`` folder as ``email.mjml.twig`` **and** ``email.html.twig``.

* Use the ``base.html.twig`` and ``message.html.twig`` files from the basic Theme or make your changes there.

* Save your ``config.json`` as described previously

* Create a thumbnail -  use the dimensions of 400px wide, 600px high.

* Compress the contents of the folder as a Zip file - ensure that the files and folders aren't within a sub-folder in the Zip file.""",
    ),

    AppLesson(
      title: "Email Landing Page",
      body: r"""Email & Landing Page Builder


Since :xref:`Mautic 3`, Mautic has shipped with an updated, modern Builder for creating Emails and Landing Pages.
In :xref:`Mautic 4` it's the default Builder.


    To use your existing templates with the new Builder, you need to add one line to your configuration file. Read on for further details.


About GrapesJS



GrapesJS is an open source, multi-purpose, Web Builder Framework which combines different tools and features with the goal to help build HTML templates without any knowledge of coding.


Available end-user features

Drag & drop built-in blocks


GrapesJS comes with a set of built-in blocks, in this way you're able to build your templates faster. If the default set isn't enough you can always add your own custom blocks.

Limitless styling

GrapesJS implements a simple and powerful Style Manager module which enables independent styling of any Component inside the canvas. It's also possible to configure it to use any of the CSS properties.

Responsive design

GrapesJS gives you all the necessary tools you need to optimize your templates to look awesomely on any device. In this way you're able to provide various viewing experiences. In case you require more device options, you can easily add them to the editor.

The structure always under control

You can nest Components as much as you can but when the structure begins to grow the Layer Manager comes very handy. It allows you to manage and rearrange your elements extremely fast, focusing always on the architecture of your structure.

The code is there when you need it

You don't have to care about the code, but it's always there, available for you. When it's done, you can grab it and use it wherever you want. Developers could also implement their own storage interfaces to use inside the editor.

Asset manager

With the Asset Manager is easier to organize your media files and it's enough to double click the image to change it.

Editing text

GrapesJS uses inline text editing powered by CKEditor. Double click a text Component to open the inline editor and edit directly on the canvas.

The inline editor includes standard formatting options:

* Bold, italic, underline and strikethrough
* Font family, font color and font background color
* Text alignment
* Ordered and unordered lists
* Headings
* Links and anchors
* Tables
* Tokens for personalization

You can paste content from external sources like Microsoft Word or Google Docs. The editor keeps basic formatting and adapts it for Email and Landing Page layouts.


   Click outside the text Component to finish editing and return to the canvas.

About the builder

Enabling the builder

Since Mautic 3.3-RC1 the Builder is available to enable in the Plugins section of Mautic. Go to the Settings by clicking the cog wheel at the top right > Plugins > GrapesJS and click the GrapesJS icon. Change the slider to Yes.

Now you need to **clear your Mautic cache** located in ``var/cache`` and refresh the Landing Page before you can work with the new GrapesJS Builder. Some browsers may also require you to clear the browser cache.

By default, Mautic 4 activates the new Builder. Follow the previous steps to revert to the legacy Builder, remembering to clear the cache and reload the Landing Page.

Email builder overview

  :width: 800
  :alt: Screenshot of the editor overview

The functions of the Email Builder are as follows:

#. You can select different screen size to preview your Emails.

#. You have the ability to undo and redo your changes.

#. Editor functions from left to right: display grids, Full screen view, export MJML / HTML code, Edit code, display customization options, display blocks, close editor.

#. Layout sections. These objects function as the basic structure of your design. Create your Email structure from sections, and pull in the different blocks you want to use.

#. Content blocks. You can populate your newsletter with these content blocks. Each block has specific layout, settings and design.

Templates

To use your existing templates with the new Builder, you need to add one line to your configuration file in the template folder:

``\"builder\": [\"grapesjsbuilder\"],``

If you wish to use the Theme in multiple builders, you can use this syntax:

``\"builder\": [\"legacy\", \"grapesjsbuilder\"],``


  This syntax changed between Mautic 3.3.* and Mautic 4 to enable support for multiple Builders - if you have been testing in the beta phase you need to update your configuration files to avoid a 500 error.

The blank Theme contains an example of a full configuration file:


    {
      \"name\": \"Blank\",
      \"author\": \"Mautic team\",
      \"authorUrl\": \"https://mautic.org\",
      \"builder\": [\"legacy\", \"grapesjsbuilder\"],
      \"features\": [\"page\", \"email\", \"form\"]
    }

From the 3.3 General Availability release there are be three Email templates that support MJML.

Themes

If you search through the list of available Themes, the new MJML Themes ``Brienz``, ``Paprika`` and ``Confirm Me`` display only with the new Builder.

To learn more about creating Themes, see :doc:`/builders/creating_themes`.

Typography

The Style Manager includes a Typography section for styling text Components. Select a text Component on the canvas, then open the Style panel to reach these controls:

* **Font family** - choose from the available fonts
* **Font size** - set the text size in pixels
* **Font weight** - adjust the weight from light to bold
* **Letter spacing** - control the spacing between characters
* **Color** - set the text color
* **Line height** - adjust the vertical spacing between lines
* **Text align** - align text left, center, right, or justify
* **Text decoration** - apply none, underline, or strikethrough
* **Font style** - switch between normal and italic

Mautic resolves typography across three levels, where each level overrides the one before it:

#. **Theme defaults** - the base styles defined by the Theme.
#. **Component typography** - the Style Manager settings listed in this section, which apply to the selected Component.
#. **Inline editor** - the formatting you apply to individual characters or words with the CKEditor inline toolbar when you double click a text Component.

Use the Component typography controls to fine-tune headings, paragraphs, and other text elements in legacy Themes that lack modern styling flexibility.

Custom fonts

You can extend the **Typography** > **Fonts** list to include custom fonts.

  :width: 280
  :alt: Screenshot of the Fonts in Style Manager > Typography

You define options as elements of the ``'editor_fonts'`` array in the local configuration file - in most cases located in ``app/config/local.php``. The font should have a unique name and a valid CSS style URL. See example below:


    <?php
    // Example local.php
    'editor_fonts' => array(
        '0' => array(
            'name' => 'Smokum',
            'font' => 'Smokum, cursive',
            'url' => 'https://fonts.googleapis.com/css2?family=Smokum&display=swap'
        ),
        '1' => array(
            'name' => 'Sofia',
            'font' => 'Sofia, sans-serif',
            'url' => 'https://fonts.googleapis.com/css?family=Sofia'
        )
    ),


Reporting bugs

Known bugs / issues

Please use the issue queue on the :xref:`GitHub repository` to find the latest updates and Report bugs with the Plugin. Be sure to search first in case someone has already reported the bug.

Switching back to the legacy Builder

In case you aren't happy with the Plugin at the moment, you can easily switch back to the legacy Builder (original Mautic Builder). You can do so very quickly:

#. Go to Mautic Settings > Click the cogwheel on the right-hand top corner

#. Open the Plugins Directory > click \"Plugins\" inside the menu

#. Find the GrapesJs Plugin and click it > Click \"No\" and then \"Save and Close\"

#. Clear the cache and reload the Landing Page - you may also need to clear your browser cache.

After unloading GrapesJs Plugin, the legacy Builder becomes active again.

Thanks and credits


Thank you to everyone who contributed to this project. Special thanks to Adrian Schimpf from :xref:`Aivie` for all their hard work in leading the project, to :xref:`Webmecanik` for initializing this amazing new builder and to Joey from :xref:`Friendly Automate` for donating three Email Themes to the Community. Additional contributions: Alex Hammerschmied from :xref:`hartmut.io`, Dennis Ameling.


And of course a really big thank you to all the contributors who have helped to bring this project to this point.""",
    ),

  ],
),

AppCourse(
  id: "marketing_3",
  title: "Campaigns",
  description: "Campaigns",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "5 Lessons",
  lessons: [
    AppLesson(
      title: "Campaign Builder",
      body: r"""Using the Campaign Builder


The Campaign Builder provides a blank canvas on which you can build your Campaign workflow. The Campaign Builder allows the use of conditions, decisions, and actions. It enables you to create a simple workflow by dragging and dropping various decisions, actions, and conditions onto a canvas.


Getting started with Campaign Builder


To build your Campaign, perform the following steps:

#. Click **Launch the Campaign Builder** on the New Campaigns wizard. The Contact Sources menu appears as shown in the following image.

   |

   .. image:: images/campaign_sources.png
      :width: 400
      :align: center
      :alt: Screenshot of Campaign builder showing Contact sources

   |

   In this step, you specify the Contacts to include in your Campaign. It's possible to trigger a Campaign when Contacts join a Segment, submit a Form, or a combination of the two.

#. Select where your Campaign pulls the Contacts from:

   * **Contact Segments**: choose this option if you want to send your Campaign to a specific group of your Contacts that share certain attributes, for example, 'Located in the United States' or 'Visited Product A' and are in an existing Segment based on this criteria.

     Note that the Segment selection shows public Segments only. If you create a Segment marked as private, that Segment won't be available for use in Campaigns.

   * **Contact Forms**: choose this option if you want to start the Campaign when the Contact completes a specified Form. Forms are the primary point of gathering information about a Contact. It's possible to take action in a Campaign based on the values submitted in the Form Field.

   You can select a mix of both types of Contact sources for your Campaign. To use both, click the grey selector button on either the left or right side of the **Contact source** box to add whichever source type you didn't originally select.

   |

   .. image:: images/multi_source_campaign.png
      :width: 600
      :align: center
      :alt: Screenshot of Campaign builder showing multiple sources selected.

   |

#. After selecting one or more Contact sources, click the grey selector button to add at least one event to your Campaign. A Campaign event comprises of a combination of actions, decisions, and/or conditions as shown in the following image:

   |

   .. image:: images/campaign_events.png
      :width: 600
      :align: center
      :alt: Screenshot of Campaign builder showing the available Campaign events.

   |

  For more information about Campaign Actions, Decisions, and Conditions, see the following topics.

Actions

Campaign actions are events that you initiate on your Contacts or Contact records. These can represent sending communications to the Contact or may automate operational tasks to keep your marketing running. A single Campaign can include more than one action. When you create a Campaign, you select one of these actions to begin the workflow.

The actions that Mautic offers in a Campaign include:


   :header-rows: 1
   :widths: 30, 70

   * - Action
     - Description
   * - **Add Do Not Contact**
     - Adds the Contact to the Do Not Contact - DNC - list
   * - **Add to Company's score**
     - Adds or subtracts a designated number of Points to or from the score for all Companies associated with the Contact.
   * - **Add Company action**
     - Associates a Contact with a Company and sets the Company as the primary Company for the Contact.
   * - **Adjust Contact Points**
     - Adds or subtracts Points from the Contact’s Point total or Group.
   * - **Change Campaigns**
     - Removes a Contact from the existing Campaign, moves them into another Campaign, restarts the current Campaign or a combination of these. You must remove a Contact from a Campaign before restarting the Campaign.
   * - **Change Contact's Stage**
     - Moves a Contact to the specified Stage.
   * - **Delete Contact**
     - Permanently deletes the Contact record along with all the information about that Contact, including the Campaign event log record about that Contact. See the :doc:`Segment docs</segments/manage_segments>` about how to use this action to delete all Contacts in a Segment.
   * - **Jump to Event**
     - Moves Contacts from one point in a Campaign to another without rebuilding events. Use this action to send the Contact to a different path in the Campaign.
   * - **Modify Contact's Segments**
     - Adds or removes Contacts to/from Segments. When removing a Contact from a dynamic - filter-based - Segment via a Campaign action, they won't be re-added to the Segment based on meeting the filter criteria.
   * - **Modify Contact's tags**
     - Overwrites or appends Tags on a Contact record. You can add or remove Tags, or do both, in the same action.
   * - **Push Contact to Integration**
     - Sends the Contact record to the selected Integration, either creating a new Contact in the chosen Integration or updating the connected Contact record.
   * - **Remove Do Not Contact**
     - Removes the Contact from the Do Not Contact - DNC - list.
   * - **Send a Webhook**
     - Sends a Webhook to a defined URL, using the GET, POST, PUT, PATCH, or DELETE methods. Headers and data is customizable, and support the use of tokens, such as Contact fields and the Contact's IP address. For example, ``{contactfield=firstname}``
   * - **Send Email**
     - Sends a transaction or marketing Email to the selected Contact. You can send a transactional Email to the Contact multiple times. You can only send a marketing Email to the Contact  once across multiple sources. If the Contact has already received this Email from another source or the current Campaign, they aren't sent the Email again and the Contact progresses through the Campaign.
   * - **Send Email to User**
     - Sends an Email to an entity other than the Contact. This may be a Mautic User, the Contact's owner, or non-Users. Emails sent using this action don't generate any statistics for Contacts or Emails.
   * - **Send Marketing Message**
     - Sends a message using the Contact's preferred Channel.
   * - **Update Contact**
     - Updates the existing Contact's fields with the specified values. You can combine static values with Mautic variables like ``{contactfield=firstname}`` and date/time variables like ``now``, ``now+3hours`` in date/time fields or ``{datetime=now}`` in text fields.
   * - **Update Contact's primary Company**
     - Updates the existing Contact's primary Company fields with the specified value. See :doc:`documentation on Companies </companies/companies_overview>`.
   * - **Update Contact owner**
     - Updates the Contact's owner.



Notes on Campaign Actions


#. As the first step of your Campaign, you typically send out an Email to your Segments. When you add an Email to a Campaign, you can select a potential **delay** for Email delivery as shown in the following image.

   |

   .. image:: images/send_email_delay_options.png
      :width: 600
      :align: center
      :alt: Screenshot of Campaign builder showing the Email send delay options.

   |

   When attaching an Action to a decision's **non-action** initiated decision path, the delay becomes how long the Contact has to take action before the Campaign progresses down the non-action path. Image showing delayed actions on a non-action decision path in a Campaign.

#. The Delete Contact action also deletes the Campaign event log record about that Contact. Therefore, though this action might always display 0% progress on the Campaign detail overview, it could have deleted some Contacts.

   .. note::

      The Delete Contact action doesn't allow connection with other Campaign events. Since the Contact won't exist after triggering this action, Campaign events can't exist after this point.

After adding an action, you can place a decision on the Campaign.

Decisions

Campaign Decisions are actions that your Contacts initiate. Downloading an Asset, opening an Email, or visiting a Landing Page are examples of Decisions. These Decisions can be either directly initiated or implied based on non-action. The options for Decisions change based on the Campaign Actions that you select.

A decision usually has two paths denoted by the red and green icons on the decision tree.

Green paths

Green paths indicate positive or affirmative actions.

A Contact takes this path if the Contact has made a direct action such as opening an Email or submitting a Form. Execution of Actions that follow the green paths happen immediately - or scheduled immediately in the case of a delay on the following action - at the time the Contact takes the action.

Red paths

Red paths indicate non-action.

A Contact takes this path if a Contact hasn't taken the action. Use an action's delay settings to define at what point the Campaign should send the Contact to the following steps on this path.

Depending on meeting - or not meeting - the criteria for the decision, the Contact takes either the green or the red paths in the decision tree. For example, consider an instance where the decision is to visit a Landing Page. There can be two outcomes. If the Contact chooses to visit the Landing Page, then the green decision path connects to the next action in the Campaign workflow. If, however, the Contact doesn't visit the Landing Page, then the red decision path connects to a different action - for example a delay of 7 days then the marketer may send a follow up Email.

   :width: 600
   :align: center
   :alt: Screenshot showing Campaign decisions available in Mautic

|

Here are the decisions that Mautic offers in the Campaign Builder:


   :header-rows: 1
   :widths: 30, 70

   * - Decision
     - Description
   * - **Device visit**
     - Set the options to track whether your Contact visits your resources from a specific device type, brand, or operating system.
   * - **Downloads Asset**
     - Set the options to track whether your Contact downloads specified Asset/s.
   * - **Request Dynamic Content**
     - Set options to push Campaign-based Dynamic Content if you have a webpage or Landing Page where you want to add Dynamic Content.
   * - **Submits Form**
     - Set options to track whether the Contact has submitted any Mautic Forms. You can also limit this decision to track specific Forms.
   * - **Visits a page**
     - Specify one or multiple pages you want the Contact to visit. Can be Mautic Landing Pages or pages on your website.
   * - **Email-Related Decisions**
     - Some decisions in the Campaign Builder are available for use only if you select the Send Email Campaign action.


Here are the decisions that are Email-related:

   :header-rows: 1
   :widths: 30, 70

   * - Decision
     - Description
   * - **Opens Email**
     - Tracks whether the Contact opens the Email.
   * - **Clicks Email**
     - Tracks whether the Contact clicks a link within the sent Email. This infers that the Contact opened the Email.
   * - **Replies to Email**
     - Tracks if a Contact has replied to an Email that you sent. For more information, see Contact replies.

Conditions

Campaign conditions execute different actions based on a Contact's data. For example, to execute an action if a Contact has a valid Email address or do something else if they don't.

A condition has two paths, denoted by red and green icons as explained in the previous section.

Here are the different conditions that Mautic offers in the Campaign Builder:

   :header-rows: 1
   :widths: 30, 70

   * - Condition
     - Description
   * - **Contact Campaigns**
     - Checks if the Contact is a member of another Campaign.
   * - **Contact device**
     - Checks if the Contact has interacted with your Campaign from a specific device type, brand, or OS.
   * - **Contact field value**
     - Checks if the information matches the selected criteria on the Contact record, the Contact's primary Company, or UTM tags.
   * - **Contact owner**
     - Checks if the selected User is the Contact's owner.
   * - **Contact Segments**
     - Checks if the Contact is a member of selected Segments.
   * - **Contact Tags**
     - Checks if specified Tags are on the Contact record.
   * - **Contact Points**
     - Checks if the Contact has a certain number of Points or a Group score.
   * - **Form Field value**
     - Checks if values submitted for a selected field on a selected Form matches specified criteria.
   * - **Has active notification**
     - Checks if the Contact has an active web notification.
   * - **Has valid Email address**
     - Checks if the Contact's Email address has a valid syntax, for example name@example.com without spaces, other invalid characters or formats.

Notes on delayed conditions and dates

Mautic respects delays set on the condition itself before passing down to a delay on any connected action. For example, if you are coming from a negative path on 'Opens Email', you can set a condition of 'has active notification' with a relative date of 1 day, followed by 'Send Email' on the negative path with a relative date of 2 days. Mautic checks after 1 day if there is an active notification and if there isn't, schedules the Email for two days later.


Using a custom date field to trigger a Campaign


In the condition based on a Contact field value, select the required date field. Then select date as the operator and select the required value from the drop-down list.

In the Anniversary option, you can only enter the day and month values.

Mautic evaluates Campaign conditions immediately, therefore if the date in the field matches the condition, Mautic executes then the positive action. If the date doesn't match, Mautic executes the negative action. The Contact doesn't wait for the condition to be TRUE.

In order to run Campaigns based on a particular date where a Contact may or may not be \"included\" today:

* create a Segment with a filter where the date field = ``TODAY``.
* initiate the Campaign based on that Segment.
* as Contacts move in and out of the Segment, the Campaign runs.
* you can eliminate the condition since the Segment is changing daily.

This **doesn't work** for the Anniversary option.

If a Contact appears again at a later date in that Segment because the value of the date has changed, then the Contact passes through the Campaign only once, and hence isn't included in the Campaign again.

Smart event schedule

For the Send Email, Marketing Message, Push Contact to Integration and Send a Webhook actions, Mautic provides a smart event schedule option. This feature dynamically optimizes the timing of event execution based on individual Contact behaviors, increasing the likelihood of engagement.

**How it works:**

#. **Interaction data retrieval**: the system retrieves interaction data for the Contact, including Email reads, Landing Page hits and Form submissions, to analyze the Contact's engagement patterns.

#. **Minimum interactions requirement**: a Contact must have a minimum number of interactions for the system to calculate optimal timing. Each interaction type - Email open, website visit, Form submit - counts only once per hour. When a Contact doesn't have enough interaction data, default hour ranges and days adjust to the Contact's preferred timezone.

#. **Optimal time calculation - execute event within 24 hours**: based on the Contact's interaction data, the system calculates the optimal time for executing a Campaign event, considering the Contact's historical engagement patterns.

    * If the Contact is within the optimal window at that moment, the event executes immediately.
    * If the current time is before today's optimal window, the event schedules for the first hour of that window.
    * If the current time is after today's optimal window, the event schedules for the first hour of the next day's optimal window.

#. **Optimal date calculation - execute event within 7 days**: the system calculates the optimal time as in the previous option and additionally determines the best day of the week. By default, a Contact can have multiple optimal days.

    * If the Contact is within the optimal window at that moment, the event executes immediately.
    * If the current time and day are before the optimal window, it schedules for the first optimal hour of the next optimal day.


Triggering Campaign events


Actions and Decisions in Mautic require a :doc:`Cron job</configuration/cron_jobs>` which executes the following command at the desired interval:


   php /path/to/mautic/bin/console mautic:campaigns:trigger

If you want to execute the command at different intervals for specific Campaigns, you can pass the ``--campaign-id=ID`` option to the command.

If you want to ignore specific Campaigns, you can pass the ``--exclude=ID`` option to the command. Passing multiple options will ignore multiple Campaigns.


Cloning Campaign events


Since Mautic 5.1, the Campaign builder includes a feature that allows Users to clone - copy and paste - Campaign events, making it easier to replicate complex workflows or reuse specific actions, decisions, or conditions across different Campaigns. This feature supports cloning events within the same Campaign as well as between different Campaigns.

To clone an event:

#. Hover over the Campaign event that you want to clone and click the copy icon button to store the event in the clipboard.

   |

   .. image:: images/clone_campaign_event.png
      :width: 300
      :align: center
      :alt: Screenshot of hovering over a Campaign event to reveal the clone option

   |

#. Click on the anchor of the event after which you want to insert the cloned event. This opens up a modal window.

#. In the modal window, click the \"Insert\" button to paste the stored event.

   |

   .. image:: images/paste_cloned_event_modal.png
      :width: 600
      :align: center
      :alt: Screenshot of the modal window with the insert option to paste the cloned event

   |

The cloned event is now inserted in the Campaign workflow.""",
    ),

    AppLesson(
      title: "Campaigns Overview",
      body: r"""Campaigns overview

A Campaign is a marketing activity that aligns Components and the Channels through which you can publish your content in a coordinated, strategically timed approach to meet specific business objectives. After you add your Contacts and set up the required Channels, you can create Campaigns to build meaningful relationships with your Contacts.

Campaigns are useful for Contact management, marketing operations, and sales workflows. A Campaign can send tailored messages to all Contacts in the Segment, or a subset of Contacts that you specify. You can set the Campaign schedule to send the message once or at a recurring interval, such as once a week.

One of the main benefits of the Campaign workflow process is the ability to predefine these workflows and have them respond automatically to your Contacts and timelines. This automation minimizes the amount of time required for manual Contact activity and improves reliability of Contact nurturing.

Campaign types

Campaigns can be broadly categorized into three types:


Time driven Campaigns


Time driven Campaigns are the type of Campaigns that center around specific timed events. These events can be anything, but are usually Emails. For instance, you can choose to trigger such Email events after a delay of a predefined number of days or on a specific date in the future.


Contact driven Campaigns


Contact driven Campaigns can trigger events based on interactions with specific Contacts. These interactions can occur as a result of the Contact landing on a certain webpage or Landing Page, opening an Email, spending a specified amount of time on a website, or any other activities. Such Campaigns can respond to these actions typically by sending an Email to the Contact either immediately or at a
specific time in future.


Mixed Campaigns


Mautic allows you to create Campaigns which consist a mix of both time driven Campaigns as well as Contact driven actions. This powerful mixed Campaign strategy drives actions by both specific dates or after specific time frames, as well as actions taken by a Contact directly.

    Campaigns can trigger a variety of actions. Email actions mentioned in the preceding Campaign types are one example. The other actions that a Campaign can trigger include automatic assignment to a new Segment, assigning a new Point value, or pushing into an Integration, into a CRM or other systems.""",
    ),

    AppLesson(
      title: "Creating Campaigns",
      body: r"""Creating Campaigns


Creating Campaigns is a central part of the marketing automation process. When you create a new Campaign, you perform the basic administrative tasks such as choosing a name for the Campaign, creating a description, assigning a Category and defining activating information for the Campaign.

At the heart of any marketing automation Campaign is the Campaign Builder. This allows you to specify how Contacts enter the Campaign, and what happens at every point after they enter the workflow.

After establishing the basics, the Campaign Builder handles the finer details of building a Campaign workflow using Conditions, Decisions, and Actions.

Prerequisites

Before you start creating Campaigns, you must ensure that you have the
following set up:

#. Create a Contact Segment or a Form to initialize your Campaign. If you already have an existing Segment or Form to use, ensure that they're up-to-date.

#. Create any Custom Field that you need for your Contact profile.
#. Set up and configure any Integration that you intend to use in your Campaign.
#. Set up appropriate Channels such as Text Messages, Email, Focus Items to communicate with your Contacts.
#. Create Assets, Landing Pages, or other Components that you want to use for your Campaign. If using Assets, ensure that you upload them before creating your Campaign.

Although you can set up Channels and create Components during the process of creating the Campaign, it's ideal to have them ready beforehand as it makes the Campaign building process faster and more efficient.


Create your first Campaign


After you have the prerequisites in place, you are ready to create your
first Campaign.

To begin creating Campaigns, perform the following steps:


#. Launch your Mautic instance.
#. Click **Campaigns** in the left navigation menu. The Campaigns page appears.
#. Click **New** on the Campaigns page. The New Campaign wizard appears as shown in the following image. Screenshot of the New Campaign screen

   .. image:: images/new-campaign.png
      :width: 600
      :alt: Screenshot of the create a new Campaign interface

#. Enter a name and a brief description for your Campaign.
#. Optionally, you can set the following properties:

   *  **Category** - Choose a Category to assign your Campaign to. Categories help you organize your Campaigns. To learn more about creating and managing Categories, see :doc:`/categories/categories-overview`.
   *  **Allow Contacts to restart the Campaign** - Controls whether Contacts who have exited the Campaign can re-enter and go through the workflow again. Enable this option for recurring messages, such as birthdays or subscription renewals, or for transactional operations like activity notifications. When disabled, Contacts who exit the Campaign can't restart even if they later re-qualify for the source Segment or Form.
   *  **Campaign Reactivation Behavior** - Configure how scheduled events with relative delays should behave when you reactivate a deactivated Campaign. You can override the global default setting for this specific Campaign. See the :ref:`Campaign reactivation behavior` section for more information about the available options.
   *  **Active** - Click the toggle switch to turn the Campaign on or off. Ensure that you don't activate a Campaign until you're actually ready for it to go live. You can also schedule to activate or deactivate a Campaign at a future date by selecting a time and date.

#. Click **Launch Campaign Builder** to start building your Campaign, and add at least one event. For information about how to use the Campaign Builder, see :doc:`/campaigns/campaign_builder`.

#. After adding events to your Campaign, close the Campaign Builder and click **Save & Close** to save your changes.


Add or remove Contacts in batch

After creating your Campaign, you can add or remove Contacts in batch
for Campaigns using the following command:


   php /path/to/mautic/bin/console mautic:campaigns:update

See documentation on :doc:`/configuration/cron_jobs` for further
details.""",
    ),

    AppLesson(
      title: "Managing Campaigns",
      body: r"""Managing Campaigns


You can manage your Campaigns from the Campaigns overview.

Click any Campaign name on the Campaigns list to take you to the Campaign overview. Each tab displays details of your Campaign, including the number of Contacts added to the Campaign, the number of Emails sent, the number of page views resulting from the Campaign, and more.

Additional information includes a quick overview of what decisions and actions are available in the Campaign, as well as a grid layout overview of all the Contacts in the Campaign.

The following image shows a sample Campaign overview with its highlighted panels:

    :width: 600
    :alt: Screenshot showing the Campaign overview

The **Details** drop-down menu gives a quick overview of the most important information about your Campaign. This information includes the name of the User who created the Campaign, Category of the Campaign, creation date and time, activating date and time, Contact Segments in your Campaign and more.

The **Campaign Statistics** panel shows the number of Contacts added to the Campaign over the specified period of time in graphical format. To specify the time period, use the From and To date selectors, and click Apply.

The **Preview** tab displays a diagrammatic preview of your Campaign.

The **Decisions** tab displays a tabular list of all the decisions that you have added to your Campaign.

The **Actions** tab displays a tabular list of all the actions that you have added to your Campaign.

The **Conditions** tab displays a tabular list of all he conditions that you have added to your Campaign.

The **Contacts** tab displays a grid view of all the Contacts that you have added to your Campaign.

The **Recent Activity** panel on the right displays the recent activities that have taken place in the Campaign.


Campaign reactivation behavior


When you deactivate and then reactivate a Campaign, Mautic provides control over how scheduled events with relative delays - such as 'Send Email 5 days after joining' - should behave. This feature gives you flexibility in managing Campaign timing based on your specific use case.


   This setting only affects events that use relative delays - interval-based scheduling. Events with absolute dates aren't affected by this setting.

Configuring reactivation behaviour

You can configure the reactivation behaviour at two levels:

1. **Global default** - Set in **Configuration** > **Campaign Settings** > **Campaign Reactivation Behaviour**. This applies to all Campaigns unless overridden.
2. **Per Campaign** - Set when creating or editing a Campaign. This overrides the global default for that specific Campaign.

Reactivation behaviour options

There are three options available for how scheduled events should behave after reactivation:

Count delay regardless of activation state

This is the default behaviour. Mautic uses the original trigger date, and inactive time doesn't affect scheduling.

**Example scenario:**


* Campaign trigger date: January 1
* Event delay: 10 days
* Calculated event date: January 11
* Campaign deactivated: January 5
* Campaign reactivated: January 7


**Result:** the event still executes on January 11, as originally scheduled.

**When to use:** this option maintains the original scheduled timing, treating the Campaign's activation state as irrelevant to the delay calculation. Use this when you want consistency with the original schedule, or when temporarily deactivating a Campaign shouldn't affect when events execute.

Restart on reactivation

The delay counter resets completely when you reactivate the Campaign.

**Example scenario:**


* Campaign trigger date: January 1
* Event delay: 10 days
* Original calculated event date: January 11
* Campaign deactivated: January 5
* Campaign reactivated: January 7

**Result:** Mautic reschedules the event to execute 10 days after reactivation, on January 17.


**When to use:** this option is useful when you want to ensure all Contacts receive the full intended delay after any Campaign changes. For example, if you deactivate a Campaign to make significant updates and want everyone to experience the complete updated workflow timing.

Count delay only while active

Events only count days when the Campaign is active. Inactive periods don't count toward the delay.

**Example scenario:**


* Campaign trigger date: January 1
* Event delay: 10 days
* Original calculated event date: January 11
* Campaign deactivated: January 5 - after 4 days active
* Campaign reactivated: January 10 - after 5 days inactive

**Result:** Mautic reschedules the event to January 16. The 4 days of active status from January 1 to January 5 count toward the 10-day delay. After reactivation on January 10, the system adds the remaining 6 days to set the new event date for January 16.


**When to use:** this option is ideal when you want precise control over the actual time Contacts spend in an active Campaign state. Use this for compliance scenarios, trial periods, or when you need to pause Campaigns without affecting the intended engagement timeline.

Viewing last activation date


The Campaign details dropdown menu displays the **Last Publish Date**, which indicates when you most recently activated the Campaign. Mautic uses this date as the reference point for the **Restart on republish** option to recalculate scheduled event timings.



Activate and deactivate Campaigns


When you activate or deactivate a Campaign, Mautic displays a confirmation message that shows the current reactivation behaviour setting. This helps you understand what happens to scheduled events before you confirm the action.


For example: 'All scheduled events execute according to the reactivation behaviour setting. Currently set to: Count delay regardless of activation state'.



   When you deactivate a Campaign, all processing of Contacts and Campaign events - including scheduled events - stops immediately. Scheduled events remain in the queue but won't execute until you reactivate the Campaign.


   The Cron job recalculates scheduled events when it evaluates the Campaign event log, rather than at the moment you reactivate the Campaign. If a recalculated trigger date remains in the past during evaluation, the event executes immediately. If the date falls in the future, the Cron job reschedules the event accordingly.

Tracking rescheduled events

Mautic records all changes to scheduled event trigger dates in the ``campaign_lead_event_log.metadata`` column. This audit trail allows you to investigate when and why the system rescheduled events, providing transparency and helping with troubleshooting.

You can view this information in the Contact's timeline under **Campaign Event Scheduled** entries, where rescheduled events show the updated trigger date and the reason for the change.""",
    ),

    AppLesson(
      title: "Troubleshooting Campaigns",
      body: r"""Troubleshooting Campaigns


Page visits aren't recognized

To workaround this issue, try one of the following options:

#. Make sure that you aren't testing the Page visit while logged into Mautic. Mautic ignores activity from Mautic Administrators. So, it's suggested that you use an anonymous session, an incognito window, another browser, or log out of Mautic.

#. Ensure that the Contact getting tracked is in the Campaign. The easy way to test this is to review the timeline of the Contact for the page hit / inclusion into the Campaign.

#. Mautic executes Campaigns sequentially and won't repeat per Contact. If the Contact has already visited the Page while part of the Campaign and triggered the Visits a Page decision, then the Contact's subsequent visits won't re-trigger the actions associated with the decision.

#. Ensure that the URL in the Campaign action either matches exactly the URL visited, or use a wildcard. A URL can include the schema, host/domain, path, query parameters, and/or fragment. For example, if you have a URL of ``https://example.com`` and the page hit registers as ``https://example.com/index.php?foo=bar``, the Campaign decision won't trigger. However, if you use ``https://example.com*`` as the URL, it matches the rule and thus gets triggered.

Another example is if you want to associate different page hits with specific Campaigns. For example, if you have Campaign A and Campaign B and you want to use the same base URL and path for both Campaigns but differentiate with a query parameter. For Campaign A, you can define a Visits a Page decision with ``https://example.com/my-page?utm_campaign=A*`` and for Campaign B, ``https://example.com/my-page?utm_campaign=B*``. A Contact only triggers the specific Campaign desired. If the goal is to trigger both Campaigns regardless of the query parameters, use ``https://example.com/my-page*``.""",
    ),

  ],
),

AppCourse(
  id: "marketing_4",
  title: "Categories",
  description: "Categories",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "1 Lessons",
  lessons: [
    AppLesson(
      title: "Categories Overview",
      body: r"""Categories


Categories are a way to organize Mautic elements. They're available for Assets, Campaigns, Emails, Focus Items, Forms, Pages, Points, Social Monitoring and Stages. There are two ways to use Categories:

1. Create element-specific Categories for example only for Assets, Emails or Forms.
2. Create global Categories for all Mautic elements.


Creating and managing Categories


To create new Categories, go to settings menu in the top right corner of Mautic. There choose Categories.

  :width: 600
  :alt: Screenshot of create new Category


When creating a new Category you can select type, title, description, alias, color and availability status. The color will be helpful to quickly find Mautic elements by their appropriate Category when viewing other areas within Mautic.

Using Categories for Contacts


In addition to organizing various Mautic elements, Categories can help you organize Contacts. In Contact details use the Preference menu to open Contact Preference Center.

  :width: 600
  :alt: Screenshot of assigning Category to Contact

Mautic allows the assignment of Contact Categories in Segment and Dynamic Content filters.""",
    ),

  ],
),

AppCourse(
  id: "marketing_5",
  title: "Channels",
  description: "Channels",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "8 Lessons",
  lessons: [
    AppLesson(
      title: "Emails",
      body: r"""Emails

Mautic enables marketers to automatically send Emails directly to a group of Contacts in a Segment by using a Campaign, or send Emails on a one-time basis. Emails provide a means for direct interaction with potential customers, clients, and Contacts.

Email types

  :width: 400
  :alt: Screenshot showing the types of Emails that are available in Mautic

There are two types of Emails: template and Segment - broadcast - Emails.


Template Emails


Template Emails are transactional by default. They're used in Campaigns, Form submit actions, Point Triggers, etc. It's possible to send template Emails to the same Contact multiple times. You can't send template Emails to a Contact outside of another Mautic Component except when sending an Email directly to a Contact - in this case Mautic clones the content.

    For this reason, template Emails sent directly to a Contact aren't associated with the template Email itself and thus stats aren't tracked against it.


Segment (Broadcast) Emails


Segment Emails are marketing Emails by default. On creation the marketer assigns Segments to the Email. This determines which Contacts receive the communication. Note that each Contact can only receive the Email once - it's like a mailing list.

  :width: 400
  :alt: Screenshot showing selecting Email Segments in Mautic

This entry field is a multi-select which allows you to choose several Segments if necessary.


Excluding Segments


There is a multi-select field that allows excluding Contacts belonging given Segments.

  :width: 400
  :alt: Screenshot showing selecting Segments to exclude.

Mautic initiates the sending of these Emails with a :doc:`/configuration/cron_jobs` - see section on Send Scheduled Broadcasts - for example, Segment Emails - for more details on this.

Email formats

In Mautic, it's possible to create Emails in both full HTML as well as basic text format - delivered as necessary to Contacts based on what their client supports. This is an important part of creating a strong relationship with Contacts by providing relevant information in the correct format.


Managing Emails


Email overview

The Email overview allows at-a-glance information regarding the success or failure of a particular Email. You can quickly see relevant information in regards to opens, bounces, successful click-throughs and other important statistics.


Email Drafts

Creating a draft Email


Mautic allows the creation of Email Drafts using the 'Save as Draft' button in the Email editor.

This feature needs turning on by adding the configuration parameter ``email_draft_enabled`` to your ``local.php`` configuration file as detailed below.


  'email_draft_enabled' => 1

Once turned on, the 'Save as Draft' button appears on the Email edit interface.

  :width: 400
  :alt: Screenshot showing the 'Save as Draft' button on the email edit page.

Only one Draft at a time can exist for any given Email. When working with a Draft, the 'Save as draft' button instead displays two buttons, 'Apply Draft' and 'Discard Draft'.

  :width: 400
  :alt: Screenshot showing the 'Apply Draft' and 'Discard Draft' buttons on the Email edit interface.

An Email Draft allows changes to the content of the Email only. Changes to the Subject, Internal Name, selected Segment, etc. apply to the original Email even when editing a Draft version of it. The Draft content exists separately from the original Email.


Previewing a Draft Email


An Email Draft may be previewed by appending ``/draft`` to the end of the Email preview URL. If an Email has a Draft version, a Draft Preview URL will be present on the Email details page below the regular Preview URL.

  :width: 400
  :alt: Screenshot showing the Preview Draft URL link on the Email edit interface.


Translations

When creating the Email, there is an option to assign a language and a translation parent. By selecting a translation parent, the current item is then considered to be a translation in the selected language of that parent item. If a Contact has a preferred language set, they receive the translated version in their preferred language if it exists. Otherwise, they receive the parent in the default language.

It's also possible to have translations of A/B test variants.

From Mautic 5.1 it's possible to preview A/B and Translation variants:

  :width: 400
  :alt: Screenshot showing A/B and Translation preview


Cloning Emails


Cloning an Email creates an editable copy that you can adjust and save as a new Email. This is useful when you want to reuse the content and settings of an existing Email as a starting point.

There are two ways to clone an Email:

* **From the Email listing**:

  #. In the Email row, click the three-dots icon next to the checkbox to open the **Options** menu.
  #. Select **Clone**.

     |

     .. image:: images/emails/email_overview_clone.png
        :width: 800
        :align: center
        :alt: Options menu open on an Email row in the Email listing, with Clone highlighted.

     |

* **From the Email detail view**:

  #. Click the down arrow button next to **Edit** to open the **Options** menu.
  #. Select **Clone**.

     |

     .. image:: images/emails/email_clone.png
        :width: 800
        :align: center
        :alt: Expanded menu next to the Edit button on the Email detail view, with Clone highlighted.

     |

Either way, Mautic opens the copy in the Email editor with the original content and settings pre-populated. Adjust the copy as needed, then save it to create the new Email.


   Cloning requires permission to create Emails. If you don't have the permission, the **Clone** option doesn't appear.

Base64 encoded images

It's possible to encode all images in the Email text as base64. It attaches the image inside the Email body. It has several implications:

  :width: 400
  :alt: Screenshot showing Base64 settings for images in Emails

- The main idea with this option is that most of the Email clients display the images directly, without the need to allow images.
- Some Email clients like GMail require the approval to display Base64 encoded images due to the tracking pixel being an image, and won't display the Base64 encoded images as a result. See the next paragraph for possible solution.
- The Email body increases significantly if the Email contains many and/or large sized images. Some Email clients like GMail \"clip\" such messages and won't display it directly.

Tokens

Mautic allows the use of tokens in Emails which gives the marketer the possibility to integrate a number of Contact fields in your Emails. These can be easily placed within your Emails and are automatically replaced with the appropriate text once sent.

It's also possible to override the 'from' field in an Email with a token from your :doc:`/contacts/custom_fields` since Mautic 5.1.

Check the :doc:`/configuration/variables` documentation for a list of all the available default fields.

Default value

A token can have a default value for cases when the Contact doesn't have the value known. You must specify the default value after a ``|`` character, for example:


    Hello {contactfield=firstname|friend}

The ``|friend`` tells Mautic to use 'friend' if there is no first name present in the Contact field.

Encoded value

It's possible to encode values used in a token using the following syntax:


    Hello {contactfield=firstname|true}

The ``|true`` tells Mautic to encode the value used, for example in URLs.

Date formats

To use custom date fields in tokens, use the following format:


    {contactfield=DATEFIELDALIAS|datetime}
    {contactfield=DATEFIELDALIAS|date}
    {contactfield=DATEFIELDALIAS|time}

The date outputs in a human-readable format, configured in the settings in your Global Configuration > System Settings under 'Default format for date only' and 'Default time only format'.

Label modifier for select and boolean fields

For select and boolean field types, you can display the human-readable label instead of the stored value by using the ``|label`` modifier:


   {contactfield=select_alias|label}
   {contactfield=bool_alias|label}

This is particularly useful when these fields contain technical values, but you want to show user-friendly labels in your Emails. For instance:

* A country selection field storing ``us`` can display ``United States``
* A boolean field storing ``1`` can display ``Yes``

The modifier also works with Company fields:


   {contactfield=company_select_alias|label}
   {contactfield=company_bool_alias|label}

Contact replies

To make use of monitoring replies from Contacts, you must have access to an IMAP server **other than Google or Yahoo** as they overwrite the return path, which prevents this feature from working.

  To use the Monitored Email feature you must have the PHP IMAP extension enabled - most hosts already have this turned on.

#. Configure all Mautic sender/reply Email addresses to send a copy to one single inbox - most Email providers support this feature in their configuration panel.

  It's best to create an Email address specifically for this purpose, as Mautic reads each message it finds in the given folder.

#. Go to the Mautic configuration and set up the inbox to monitor replies.

  :width: 400
  :alt: Screenshot showing IMAP mailbox setting for reply monitoring

#. To fetch and process the replies, run the following Cron command:

``php path/to/mautic/bin/console mautic:email:fetch``

Usage
Contact replies within Campaigns function as decision after an Email Send action, to take further action based on whether the Contact has replied to the Email. Mautic tries to read the inbox, parse messages, and find replies from the specified Contact. The Contact, when matched with an incoming reply, proceeds down the positive path immediately after the reply detection.


  :width: 400
  :alt: Screenshot showing Contact replies Campaign action


Mailer as Owner


This feature allows Mautic to automatically personalize Emails sent to a Contact who has an owner (Mautic User) assigned to them. This feature changes the from Email, from name and signature by changing the default setting to the Mautic Contact owner's User setting.


Sending from the Contact owner


#. Open the Admin menu by clicking the cog icon in the top right corner.
#. Select the Configuration menu item.
#. Select the Email Settings tab.
#. Switch the Mailer is owner to Yes.
#. Save the configuration.

Overriding the mailer as owner setting
It's possible to override the global setting on a per-Email basis.

There is a switch under the advanced settings of the Email, which allows you to decide whether to take the global mailer as owner setting, or the specified from address, into account.

  :width: 400
  :alt: Screenshot showing mailer as owner switch

If set to Yes, the global setting takes precedence.

If set to No, Mautic uses the address and name supplied in the Email 'From' fields.

Signatures

Setting a signature happens in two places:

#. The default signature is in the Configuration > Email Settings tab. The default text is


  Best regards,<br/>|FROM_NAME|.

Mautic replaces the ``|FROM_NAME|`` token with the name which is also defined in the Email Settings tab.

Mautic uses this signature by default if the Contact doesn't have an owner assigned.

#. Every Mautic User can configure their own signature in their account settings. Mautic uses this signature by default if the Contact has an owner assigned to them.

  There are some exceptions where the Contact owner's signature isn't used, which is when a User sends an Email directly from a Contact's profile. In this case, Mautic uses the currently logged in User's signature, with the from name and Email specified in the Email send Form, and not the Contact owner. The values used are pre-filled with those of the currently logged in Mautic User.

  It doesn't matter if the Contact has another owner assigned or if it doesn't have an owner at all.

  Also, when sending a test Email this is also the case.



Using the Email signature


Marketers can place the signature into an Email using the ``{signature}`` token.


Tracking Opened Emails


Mautic automatically tags each Email with a tracking pixel image. This allows Mautic to track when a Contact opens the Email and execute actions accordingly. Note that there are limitations to this technology - the Contact's Email client supporting HTML and auto-loading of images, and not blocking the loading of pixels. If the Email client doesn't load the image, there's no way for Mautic to know the opened status of the Email.

By default, Mautic adds the tracking pixel image at the end of the message, just before the ``</body>`` tag. If needed, one could use the ``{tracking_pixel}`` variable within the body content token to have it placed elsewhere. Beware that you shouldn't insert this directly after the opening ``<body>`` because this prevents correct display of pre-header text on some Email clients.

It's possible to turn off the tracking pixel entirely if you don't need to use it, in the Global Settings.


Tracking links in Emails


Mautic tracks clicks of each link in an Email, with the stats displayed at the bottom of each Email detail view under the ``Click Counts`` tab.

You can turn off tracking for a certain link by adding the ``data-mautic-disable-tracking=\"true\"`` HTML attribute.

For example:


  <a href=\"https://mautic.example.com/\" data-mautic-disable-tracking=\"true\">Non tracked link</a>


   Use ``data-mautic-disable-tracking=\"true\"`` for all new Emails and templates, as Mautic has deprecated the ``mautic:disable:tracking`` attribute.

Unsubscribing

Mautic has a built in means of allowing a Contact to unsubscribe from Email communication. You can insert various tokens into your Email to provide unsubscribe options at your desired location:
- ``{unsubscribe_text}``: inserts a sentence with a link instructing the Contact to click to unsubscribe.
- ``{unsubscribe_url}``: inserts the URL to the preferences center when it's activated, or to the unsubscribe page if not.
- ``{resubscribe_url}``: inserts the URL to the resubscribe page regardless of whether there's a preference centre in use. It resubscribes the Contact. Useful for double opt out Campaigns.
- ``{dnc_url}``: inserts the URL to unsubscribe from all Marketing Messages when you activate the preference center.

The unsubscribe URL token inserts the URL into your custom written instructions.

For example:


        <a href=\"{unsubscribe_url}\" target=\"_blank\">Manage your email preferences</a>
        <a href=\"{dnc_url}\" target=\"_blank\">Unsubscribe from all emails</a>

You can find the configuration of the unsubscribe text in the global settings.

Online version

Mautic also enables the hosting of an online version of the Email sent. To use that feature, simply add the following as URL on text to generate the online version link ``{webview_url}``.

For example:


    <a href=\"{webview_url}\" target=\"_blank\">View in your browser</a>

Bounce management

Mautic provides a feature which allows monitoring of IMAP accounts to detect bounced Emails and unsubscribe requests.

Note that Mautic makes use of \"append\" Email addresses. The return-path or the list-unsubscribe header uses something like ``youraddress+bounce_abc123@example.com``. The bounce or unsubscribe allows Mautic to determine what type of Email it's when it examines the inbox through IMAP. The ``abc123`` gives Mautic information about the Email itself, for example which Contact it was it sent to, what Mautic Email address it originated from, etc.

Some Email services overwrite the return-path header with that of the account's Email (GMail, Amazon SES). In these cases, IMAP bounce monitoring won't work.

Elastic Email, SparkPost, Mandrill, Mailjet, SendGrid and Amazon SES support Webhook callbacks for bounce management. See below for more details.


Monitored inbox configuration


To use the Monitored Email feature you must have the PHP IMAP extension enabled (most shared hosts already have this turned on).  Go to the Mautic configuration and fill in the account details for the inbox(es) you wish to monitor.

  :width: 400
  :alt: Screenshot showing IMAP mailbox setting for reply monitoring

It's possible to use a single inbox, or to configure a unique inbox per monitor.

To fetch and process the messages, run the following command:


  php /path/to/mautic/bin/console mautic:email:fetch

Note that it's best to create an Email address specifically for this purpose, as Mautic reads each message it finds in the given folder.

If sending mail through GMail, the Return Path of the Email is automatically rewritten as the GMail address. It's best to use a sending method other than GMail, although Mautic can monitor a GMail account for bounces.

If you select an Unsubscribe folder, Mautic also appends the Email as part of the \"List-Unsubscribe\" header. It then parses messages it finds in that folder and automatically unsubscribe the Contact.

Webhook bounce management

Since Mautic 5 all the Email transports use the same Webhook - sometimes called callback - URL: ``https://mautic.example.com/mailer/callback``. Please follow the documentation for the specific Email transport you've installed to get more information about the Webhook configuration.



Create a Segment with bounced Emails


This isn't required, but if you want to be able to select the Contacts with bounced Emails easily - for example to delete all bounced Contacts - create a Segment with bounced Emails.

1. Go to Segments > New.
2. Type in the Segment name. For example Bounced Emails.
3. Select the Filters tab.
4. Create new Bounced Email equals Yes filter.
5. Wait for the ``bin/console mautic:segments:update`` command to be automatically triggered by a Cron job or execute it manually.
6. All Contacts with bounced Emails should appear in this Segment.

Troubleshooting Emails


Email open tracking

Mautic tracks Email opens using a tracking pixel. This is a 1 pixel GIF image in the source code of Email messages sent by Mautic.

When a Contact opens an Email using an Email client like Outlook, Thunderbird, or GMail, the client tries to load the images in it. The image load request is what Mautic uses to track the Email open action.

Some Email clients have auto loading images turned off, and Contacts have to selectively \"Load Images\" inside an Email message. Some automatically open all images before delivering the Email to the Contact.

If the images aren't loaded for this reason or another, or if they're opened automatically before sending the Email on to the Contact, Mautic doesn't know about the open action. Therefore, Email open tracking isn't very accurate.

Email link tracking

Before sending an Email, Mautic replaces all links in the Email with links back to Mautic including a unique key. If the Contact clicks on such a link, the link redirects the Contact to Mautic, which then tracks the click action and redirects the Contact to the original location. It's fast, so the Contact doesn't usually notice the additional redirect.

If the Email click doesn't get tracked, make sure that:

1. Your Mautic server is on an accessible URL.
2. You sent it to an existing Contact via a Campaign or a Segment Email. Emails sent by the Send Example link, direct Email from the Contact profile, or Form submission preview Emails won't replace links with trackable links.
3. Make sure the URL in the href attribute is absolute and valid. It should start with ``http://`` or ideally ``https://``.
4. You've opened the link in a incognito browser (not in the same session where you're logged into Mautic)
5. Check if Mautic replaced the link in the Email with a tracking link.

Unsubscribe link doesn't work
The unsubscribe link **doesn't work in test Emails**.

This is because Mautic sends test Emails to a Mautic User and not to a Mautic Contact.

Mautic Users can't unsubscribe and therefore the unsubscribe link looks like this: ``https://mautic.example.com/|URL|``. However, the link **does** work correctly when you send the Email to a Contact.

Best practice is to create a Segment with a small number of Contacts to receive test Emails - for example, yourself - which ensures that you can fully test features such as unsubscribe behaviour.""",
    ),

    AppLesson(
      title: "Focus Items",
      body: r"""Focus Items

Focus Items allow you to engage Users on your site through bars, modals, notifications, popups, and light boxes. It's possible to initiate Focus Items at different times and with different actions such as exit intent.

You can find Focus Items listed under the Channels menu.

Focus Item settings
There are several different types of Focus Items, and many ways to configure them to deliver your strategic marketing goals.

Types of Focus Item

There are three different types of Focus Item that you can create within Mautic. These allow you to achieve different marketing goals with your Focus Items. Select the appropriate option for your needs.

  .. image:: images/focus_items/focus_item_types.png
    :width: 400
    :alt: Screenshot showing the types of Focus Items.

- **Collect Data** - This option presents a Form - which must already exist - within the Focus Item. This allows you to gather more information about your website visitors. Mautic considers a successful conversion on this type of Focus Item when there is a submission of this Form. This option is great for capturing simple information - for example a newsletter registration Form.
- **Display a Notice** - This option presents a message to your visitors. There is no option for detecting a conversion with this type of Focus Item. This option is great for announcements and important messages.
- **Emphasize a link** - This option allows you to drive visitors to a specific link which might be a resource on your website, a Mautic Landing Page, or any other web-based resource. Mautic considers a link click to be a successful conversion with this Focus Item. This option is great for Landing Pages to highlight a promotion or a sale - it displays a button to click which directs the visitor to a given link.

Engagement options

For each type of Focus Item, there are settings to configure which control the triggering of the Focus Item, and how they interact with the visitor.

  .. image:: images/focus_items/focus_item_engagement.png
    :width: 400
    :alt: Screenshot showing the engagement settings for Focus Items.

- **Animate** - When set to Yes, this applies a slide-in animation to the Focus Item. When set to No, the item appears without any kind of sliding motion.
- **When to engage** - This setting controls the Focus Item shows. There are several options:
   - **Upon arrival** - As soon as a visitor lands on the page
   - **After slightly scrolling down** - Wait a little while until the visitor starts to scroll down the page
   - **After scrolling to the middle** - Wait until the visitor scrolls to the middle of the page
   - **After scrolling to the bottom** - Wait until the visitor scrolls right to the bottom of the page
   - **Visitor intends to leave** - If the visitor's cursor moves over the address bar, or from the page to the tabs - for example to close the tab or open a new tab
- **Timeout before engage** - This option allows you to set the delay in seconds after reaching the option selected in **When to engage**. For example, if the setting is **Upon arrival** and **Timeout before engage** is 2 seconds, the Focus Item appears two seconds *after* the visitor lands on the page.
- **How often to engage** - This option allows you to control how frequently the Focus Item displays to visitors. The options available include:
   - **Every page** - Show on every page the visitors engages with on your website
   - **Once per session** - Show once for each time that the visitor accesses your website
   - **Every 2 minutes** - Show the Focus Item every two minutes that the visitor is on your website
   - **Every 15 minutes** - Show the Focus Item every 15 minutes that the visitor is on your website
   - **Once per hour** -  Show the Focus Item once every hour that the visitor is on your website
   - **Once per day** - Show the Focus Item once per day that the visitor is on your website
- **Stop engaging after a conversion** - This option is only available for the types which track a conversion (Collect Data and Emphasize a Link).  If set to Yes, the Focus Item no longer displays if the visitor has either submitted the Form (Collect Data type) or clicked on the link (Emphasize a Link type).
- **Stop engaging after closing Focus** - This option is available for Focus Items and uses cookies. If set to Yes, the Focus Item no longer displays to the visitor after they have interacted with it, until they clear their cookies.

Styles

There are four styles to choose from when creating a Focus Item. Each style has different configuration options relevant to the layout they provide.

  .. image:: images/focus_items/focus_item_styles.png
    :width: 400
    :alt: Screenshot showing the styles for Focus Items.

Bar
The Bar style creates a line across the top or bottom of the page, which includes the content of your Focus Item.

- **Allow hide** - when set to Yes, website visitors have a small arrow to hide the bar. The arrow shows on the right hand side of the bar. Once clicked, the bar shrinks to hide the content but the arrow is still be visible in case they want to maximise it again with a single click. If set to No, the visitor can't hide the bar.
- **Push page down** - This option allows the bar to push the page content up or down under the bar if set to Yes. If set to No, the bar covers the content at the top or bottom of the page depending on placement setting.
- **Make sticky** - If set to Yes, the bar stays anchored in position even when the visitor scrolls the page. If set to No, the bar won't anchored and disappears as the visitor scrolls the page, and re-appears as they reverse the scroll.
- **Placement** - This option allows you to display the bar at the top or the bottom of the page.
- **Size** - This option allows you to specify the thickness of the bar, and the font size. The options include:
    - **Large** - 50px height and 17pt font
    - **Regular** - 30px height and 14pt font

Modal
The Modal style is probably the most popular style, and is often referred to as a pop-up or a light box.

Modals are small boxes which appear aligned horizontally centred on the page. The content behind the pop-up darkens when the Focus Item is active, which helps to draw attention - focus - to the pop-up.

- **Placement** - This option allows you to select whether you would like the Modal to appear at the top, middle or bottom of the page.

Notification

The Notification style is a small box which appears, sometimes referred to as a pop-up. Unlike with the Modal style, the pop-up shows in one of the four corners of the page, and the main content underneath the notification isn't darkened out behind the pop-up.

Visitors can choose to close this type of Focus Item with the *X* button in the top right corner of the notification.

- **Placement** - This option allows you to select the corner to display the notification.

Full page

The full page Focus Item completely takes over the whole page, hiding the page content until the visitor clicks the *X* button in the top right hand corner of the Focus Item.

There are no additional configuration options for this style of Focus Item.

Colors

By default, Mautic determines the top colors extracted from the snapshot. Four colors are currently supported. You can customize colors by using the color picker or entering a hex code.

- **Primary color**
  - For the Bar style, the primary color is the background color of the bar
  - For the Modal, Notification and full page styles, the primary color is the outline around the Focus Item with a thicker line on top than on the other three sides.
- **Text color** - The color of the headline text entered in the Content section of the Focus Item editor
- **Button color** - The background color for the button on the Collect Data and Emphasize Link Focus Item types. This option isn't available for the Display a notice Focus Item type.
- **Button text color** - The color for the button text on the Collect Data and Emphasize Link Focus Item types. This option isn't available for the Display Notice Focus Item type.

Content
There are three editing modes to choose from when customizing Focus Items.

  .. image:: images/focus_items/focus_item_content.png
    :width: 400
    :alt: Screenshot showing the content options for creating Focus Items.

Basic
This editor mode allows a simplified experience with a few fields - depending on the Focus Item type - with the content being automatically rendered on the Focus Item as it's created.

- **Headline** - This is the main text used on the Focus Item. The aim is to capture the visitor's interest and attention.
- **Tagline** - This option is only available for Emphasize a Link Focus Item types. It allows you to provide a second line of text to add more incentive for the visitor to click the link. This field is optional.
- **Font** - This option allows you to select from available fonts used in the Focus Item. The font list isn't customizable.
- **Select the Form to insert** - This option is only available for Collect Data Focus Item types. It allows you to select an existing Mautic Form to use with the Focus Item. For styling and formatting reasons, you may want to create a Form specifically for the Focus Item, adding styling attributes to the Attributes tab on the Form fields.
- **Link text** - This option is only available for Emphasize a Link Focus Item types. It allows you to specify the text used on the Focus Item's button.
- **Link URL** - This option is only available for Emphasize a Link Focus Item types. It allows you to specify the URL where you'd like to drive visitors with the Focus Item.
- **Open in a new window** - This option is only available for Emphasize a Link Focus Item types. If set to Yes, this ensures that the link opens in a new window. If set to No, the link opens in the current tab.

Editor
This allows the User to edit the content with the global editor available in Mautic.

HTML
This allows the User to enter HTML into a blank field for a fully customized Focus Item.

    If you decide to switch editing styles, ensure that you clear the data from the previous style, otherwise Mautic may not display the final intended content.


Creating a Focus Item

To create a new Focus Item, go to Channels > Focus Items and click the New button.

    Some websites won't allow the preview to display. For the preview to work, the site must use an SSL certificate, and it must not block iframe previews with the ``x-frame-options: SAMEORIGIN`` header. An error will be displayed in the Focus Item builder if these conditions are not met.

When creating a new Focus Item, you can set the following fields:

**Name** - A name used internally to identify the Focus Item

**Website** - A website you would like to use to preview the Focus Item as you are building it - see preceding note, some websites won't allow this feature. If this is a problem, leave the URL field blank.

**Category** - Assign a Category to help you organize your Focus Items.

**Active** - Whether the Focus Item is available for use - active - or not available - inactive.


**Activate at (date/time)** - This allows you to define the date and time at which this Text Message is available for sending to Contacts

**Deactivate at (date/time)** - This allows you to define the date and time at which this Text Message ceases to be available for sending to Contacts.


**Google Analytics UTM tags** - Mautic supports UTM tagging in Emails, Focus Items, and Landing Pages. Any UTM tags with values populated are automatically appended to the end of any links used in the Focus Item. See :doc:`/channels/utm_tags` for more information.

  .. image:: images/focus_items/focus_item_create.png
    :width: 400
    :alt: Screenshot showing the creation of a Focus Item.


Using the Focus Item builder


After you specify the general information for the Focus Item, click the builder option in the top right corner. If you've specified a URL in the Website field on the details page, the system displays a preview. If you don't see a preview, the website might block iframe previews. Hence, you may need to add the Focus Item to a development or staging environment without these security restrictions - if available - to see the preview.

    The preview of the website doesn't appear until you select a style from the options on the Focus Item Builder.

  .. image:: images/focus_items/focus_item_builder.png
    :width: 400
    :alt: Screenshot showing the Focus Item Builder

You can use the menu on the sidebar to configure the Focus Item to your liking. The preview area on the left allows you to see how it appears on your website. You can also use the mobile phone icon at the top right to switch to a responsive view. This is important to ensure that you aren't blocking key elements of the User Experience on mobile devices.

  .. image:: images/focus_items/focus_item_builder_responsive.png
    :width: 400
    :alt: Screenshot showing the Focus Item Builder in responsive mode.

Using Focus Items

Once you have created your Focus Item, you're ready to activate it to your website. If you're not quite ready for the Focus Item to go live but you need to get it set up on your website, set the Focus Item to inactive.

Deploying to a website

When you save the Focus Item, Mautic shows the code snippet required to display it on your website in a green box on the Focus Item overview.

  .. image:: images/focus_items/focus_item_embed.png
    :width: 400
    :alt: Screenshot showing the Focus Item code to embed within a website.

    You may need assistance from your web development team to implement the Focus Item tracking code on your website.

    You must also ensure that you have specified your website's domain where you expect to use the Focus Item in the CORS settings for your Mautic instance, otherwise it won't appear. To verify this, go to Settings > Configuration > System Settings > CORS Settings and set Restricted Domains to Yes. Ensure that you specify your domain in the relevant field. Alternatively (but not recommended, as this would allow other websites to display your Focus Items), set Restrict Domains to No and don't specify your domains.


Deploying through a Campaign


It's possible to trigger a Focus Item to appear as part of a Campaign workflow. This doesn't require you to paste the Focus Item code onto your website as it's delivered through the existing Mautic Tracking Code.

Within the Campaign, add a decision for ``Visits a Page``, and then select the Action of ``Show Focus Item``. Note that you must precede it by ``Visits a Page`` to trigger the Focus Item.

    Sometimes the Campaign Action can be unreliable and it's dependent on your Campaign steps, so it's recommended to use the direct embedding method in most cases.

Measuring success

When using the Emphasize a Link type, Mautic displays the link on the Focus Item overview where you can view the number of unique clicks.

If you change the link in a Focus Item after deployment, Mautic lists all links in the overview.

Additionally, Mautic applies UTM tags on Focus Items to both Form submissions and link clicks. If you are using a Focus Item to submit a Form, it's recommended that you have a Submit Action on the Form to record the UTM tags.""",
    ),

    AppLesson(
      title: "Marketing Messages",
      body: r"""Marketing Messages

What are Marketing Messages?

Located under the Channels section in Mautic, Marketing Messages is one of the Channels available to you through which you can optimize and personalize communication with your customers.

Marketing Messages allow you to empower the customer to decide how they prefer to receive the content you send, by setting the Channel they prefer.

  .. image:: images/marketing_messages/marketing-messages.png
    :width: 200
    :alt: Screenshot showing the Marketing Messages option in the main navigation menu of Mautic.

With Marketing Messages, you can create content and make it available through multiple Channels - Email, SMS, Browser Notification, Mobile Notification, Tweets, and any other Channel you decide to create using Mautic's extendable open architecture.

When using the 'Send Marketing Message' action in a Campaign, you can create the message in any or all of these Channels. If the Contact has a Channel preference set on their profile, Mautic sends the content on the preferred Channel. If they haven't specified a Channel, Mautic uses the default Channel - Email.

It's also possible for a Contact to specify their own frequency rules and pause communication all together on a Channel. When exceeding the defined limit and scheduling a Marketing Message, Mautic uses another Channel which has available frequency.


Creating a Marketing Message


To create a new Marketing Message, navigate to the Channels section and click Marketing Messages. Click on New.

Provide a name and description for the Marketing Message, then choose the Channels you wish to use.

    You must set up and configure the Channels before they become available - if you haven't set up Mobile Notifications or Text Messages, you won't see it as an option when creating a Marketing Message.

  .. image:: images/marketing_messages/create-marketing-message.png
    :width: 400
    :alt: Screenshot showing the creation of a new Marketing Message in Mautic.

To enable a Channel, click Yes on the slider, and select - or create - the message.""",
    ),

    AppLesson(
      title: "Push Notifications",
      body: r"""Mobile push notifications

Mobile notifications integrate your iOS and Android app with :xref:`OneSignal`. Using your own OneSignal account, you can now push a notification to your Contact's mobile device - with their permission. Enable the Plugin in Mautic's Plugin manager to see Mobile Notifications listed under Channels in the menu.

For more detailed information see the :xref:`OneSignal iOS` and :xref:`OneSignal Android` documentation.

Setup


iOS code for OneSignal integration

To enable Push Notifications in your iOS app, add the following code - or a variant of it - inside your ``application`` func of ``AppDelegate``. The code examples below use Swift 3.1. Please modify them to your needs if you are using C#.


    // Somehow determine the user email. If you have user accounts, it may be better to move
    // this outside of the `application` func of `AppDelegate` in order to determine the user email.
    // In this example, the address is hardcoded for ease of use.
    let userEmail = \"you@domain.com\"

    OneSignal.initWithLaunchOptions(launchOptions, appId: \"YOUR-ONE-SIGNAL-APP-ID\")
    OneSignal.syncHashedEmail(userEmail);

    OneSignal.idsAvailable({(_ userId, _ pushToken) in
        let pushId      = userId != nil ? userId : \"\"
        let pushEnabled = pushToken != nil ? true : false
        let userData    = UserData(email: userEmail, push_id: pushId!, enabled: pushEnabled)

        self.pushUserDataToMautic(userData, \"https://mautic.example.com/notification/appcallback\")
    });

For ease of use, we've created the following struct and func for sending user data to Mautic. Create this struct in your app, and import it where appropriate.

UserData struct


    struct UserData {
        var email   = String()
        var push_id = String()
        var enabled = Bool()

        static func toJSON(_ userData: UserData) -> String {
            let email   = userData.email
            let pushId  = userData.push_id
            let enabled = userData.enabled

            return \"{\\\"email\\\":\\\"\\(email)\\\",\\\"push_id\\\":\\\"\\(pushId)\\\",\\\"enabled\\\":\\(enabled)}\"
        }
    }

pushUserDataToMautic func

This is a basic function for pushing the UserData struct to your Mautic installation. It will push the User data, and then display the response from Mautic as an app alert. Modify to meet the needs of your app.


    func pushUserDataToMautic(_ userData: UserData, _ url: String) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = \"POST\"

        let postString = UserData.toJSON(userData)
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // check for fundamental networking error
                return
            }

            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                return
            }

            // Comment the next 4 lines to remove the alert
            let responseString = String(data: data, encoding: .utf8)
            let alert = UIAlertController(title: \"Response Data\", message: responseString, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: \"OK\", style: UIAlertActionStyle.default, handler: nil))
            self.window?.rootViewController?.present(alert, animated: true, completion: nil);
        }
        task.resume()
    }


Notification statistics

In addition to the UserData that gets pushed to Mautic, you can push open / interaction stats to Mautic by sending the UserData struct, with an appended stat JSON key.""",
    ),

    AppLesson(
      title: "Sms",
      body: r"""SMS Text Messages

With the SMS Channel it's possible to send text messages from Campaigns in Mautic.

    To use this Channel you must first set up an SMS transport, such as :doc:`/plugins/twilio`.


Type of Text Messages


Mautic allows you to create two types of Text Messages, in the same way as you can create different types of Emails.


Template Text Messages


A template Text Message is automatically sent by Campaigns, Forms, Point Triggers etc. You can edit Template Text Messages after creation, but they can't manually send them to a Contact list.


Segment Text Messages


A Segment Text Message can be manually sent to Contact lists - Segments - in Mautic. Once sent, you can't edit the Text Message, however you can send it to new Contacts as they join the associated Segment.

Note that these are marketing Text Messages by default, and each Contact can only receive the Text Message once - it's the same principle as a mailing list.

You must initiate the send of Segment Text Messages with the ``Send Scheduled Broadcast`` cron job. See :doc:`cron jobs documentation </configuration/cron_jobs>` for more information.


Creating a Text Message


To create a Text Message, navigate to Channels > Text Messages and click the 'New' button.

  .. image:: images/sms/sms-create-sms.png
    :width: 400
    :alt: Screenshot showing create new SMS button

Select whether you wish to create a Template or Segment Text Message, which presents the required fields.


Template Text Message fields


The following fields are available:

  .. image:: images/sms/sms-new-triggered-text-message-fields.png
    :width: 400
    :alt: Screenshot showing the fields required for a new Template Text Message

**Internal name** - This is the internal name used within Mautic when referring to this Text Message. For example Mautic uses this in dropdown selection lists in the Campaign Builder.


**Text Message** - This is the actual content of the Text Message which is sent to the Contact. There is a character count below the field which helps you to identify the required number of messages to send the full text. You may use tokens, such as ``{contactfield=firstname}``. To find the appropriate token, go to Settings > Custom Fields and use the field alias with the token format: {contactfield=fieldalias}.


**Category** - This allows you to select a Category to help you with organizing your Text Messages.

**Language** - This allows you to set the language of this Text Message.

**Published** - This allows you to set the published status of the Text Message. Unpublished Text Messages aren't sent.


Segment Text Message fields


The following fields are available:

  .. image:: images/sms/sms-new-segment-sms.png
    :width: 400
    :alt: Screenshot showing the fields required for a new Segment Text Message

**Internal name** - This is the internal name used within Mautic when referring to this Text Message. For example, Mautic uses this in dropdown selection lists in the Campaign Builder.


**Text Message** - This is the actual content of the Text Message sent to the Contact. There is a character count below the field which helps you to identify the required number of messages to send the full text. You may use tokens, such as ``{contactfield=firstname}``. To find the appropriate token, go to Settings > Custom Fields and use the field alias with the token format: {contactfield=fieldalias}.


**Category** - This allows you to select a Category to help you with organizing your Text Messages.

**Language** - This allows you to set the language of this Text Message.

**Published** - This allows you to set the published status of the Text Message. Unpublished Text Messages aren't sent.

**Contact Segment** - This allows you to define the Segment/s who should receive the Text Message.


**Publish at (date/time)** - This allows you to define the date and time at which this Text Message is available for sending to Contacts

**Unpublish at (date/time)** - This allows you to define the date and time at which this Text Message ceases to be available for sending to Contacts.

Creating Text Messages from Campaign Builder


It's also possible to create a Text Message from within the Campaign Builder. To do this, select the Campaign Action of Send Text Message and press the New Text Message button rather than selecting an existing Text Message in the dropdown.

  .. image:: images/sms/sms-send-sms-campaign.png
    :width: 400
    :alt: Screenshot showing the option to create an SMS from a Campaign

As you plan to use this Text Message within a Campaign, it's by default created as a Template Text Message and show the relevant fields accordingly.


Sending Text Messages as a Marketing Messages


Mautic allows you to create a single message - for example 'Red shoes on offer today!' - in multiple Channels, and have it delivered through the Channel which the Contact prefers. This means that they only receive the message once, and through their preferred Channel. You can create the messages under the :doc:`/channels/marketing_messages` section.

If a Contact's preferred Channel is Text Messages, Mautic delivers the message through the Text Message Channel when a Marketing Message includes a Text Message.

  .. image:: images/sms/sms-send-marketing-message.png
    :width: 400
    :alt: Screenshot showing the option to send a Text Message as a Marketing Message

Managing unsubscribes

    In order for Mautic to process Text Message replies for unsubscribes and replies to messages, you must first configure the Webhook. For more information review the :doc:`/plugins/twilio` documentation.

Contacts can unsubscribe from your Text Messages by replying with the word ``STOP``, or any of the accepted phrases (``STOP``, ``STOPALL``, ``UNSUBSCRIBE``, ``CANCEL``, ``END``, and ``QUIT``), to your SMS.  Once Mautic receives this SMS, Mautic flags the specific Contact as 'Do Not Contact' (DNC) for the SMS Channel, and won't allow messages again via this Channel unless the Contact manually re-subscribes at a later date.

You can also view SMS replies in the Contact timeline:

  .. image:: images/sms/sms-contact-reply.png
    :width: 400
    :alt: Screenshot showing the reply from SMS


Working with replies to Text Messages


In a Mautic Campaign, where Mautic has an active Text Message provider, there is a Campaign Action called 'Sends a Text Message' which allows you to monitor incoming replies for specific patterns and take action accordingly.

  .. image:: images/sms/sms-reply-campaigns.png
    :width: 400
    :alt: Screenshot showing the Campaign action 'Sends a Text Message'

This decision tracks replies to your messages and looks for specified patterns within a message. This isn't dependent on you first sending the Contact a message.

For example, you can specify 'red' in 'Pattern the reply should match'. If your message contains language, such as reply from the Contact using the word 'Red' to a question of their favourite shoe colour, Mautic looks for incoming Text Messages with that pattern. In this example, you may add an action on the decision's Yes path for adding a colour preference to the Contact's profile.

Important notes

- Contact phone numbers should be in the format +XXXXXXX including the + and with no spaces
- There must be a phone number in the Mobile Phone Contact field
- When configuring the Twilio Plugin, the sender number must be in the format +XXXXXXX and this number associated with the Twilio account""",
    ),

    AppLesson(
      title: "Social Monitoring",
      body: r"""Social Monitoring


It's possible to add Contacts to Mautic through monitoring Twitter for mentions and hashtags.

Requirements

- You must first configure the :doc:`/plugins/twitter` Plugin
- You must trigger the Social Monitoring :doc:`cron job </configuration/cron_jobs>` periodically.


Creating a Social Monitor


To create a new Social Monitor, go to Channels > Social Monitoring and click New.

Mautic offers two options when creating a Social Monitor:

- **Twitter mention** - Any time someone mentions a specified username, Mautic creates them as a Contact
- **Twitter hashtag** - Any time someone uses a specified hashtag in a tweet, Mautic creates them as a Contact.

  .. image:: images/social_monitoring/social_monitor.jpeg
    :width: 400
    :alt: Screenshot showing the creation of a new Social Monitor.

Social mentions

When selecting the Twitter Mention monitoring method, the following fields are available:

- **Twitter mention** - The Twitter handle you want to track mentions of. Don't include the @ symbol - for example ``mauticcommunity``.
- **Description** - A description to use internally within Mautic to tell the marketer what the monitor is tracking.
- **Match Contact names** - If set to Yes, Mautic tries to match the names of Contacts created from Twitter and associate the Twitter account with their existing Contact record. If set to No, this won't happen and you are likely to experience duplicated Contacts.

There are also the standard Mautic fields available:

**Active** - This allows you to set the activation status of the Social Monitor. Deactivated Social Monitors won't collect new Contacts.


**Activate at (date/time)** - This allows you to define the date and time at which this Social Monitor is monitoring for new Contacts. You might use this to coincide with an event, for example.

**Deactivate at (date/time)** - This allows you to define the date and time at which this Social Monitor is monitoring for new Contacts.


**Contact Segment** - This allows you to define the Segment/s in Mautic that the Contacts join if detected with this Social Monitor. This can be useful for identifying people who are talking about your brand, and directly add them to a Segment to take further action.

  .. image:: images/social_monitoring/social_monitoring_mentions.png
    :width: 400
    :alt: Screenshot showing the creation of a new Twitter Mentions Social Monitor.

Hashtags

When selecting the Twitter Hashtags monitoring method, the following fields are available:

- **Twitter hashtag** - The Twitter hashtag mentions you want to track. Don't include the # symbol - for example ``mautic``.
- **Description** - A description to use internally within Mautic to tell the marketer what the monitor is tracking.
- **Match Contact names** - If set to Yes, Mautic tries to match the names of Contacts created from Twitter and associate the Twitter account with their existing Contact record. If set to No, this won't happen and you are likely to experience duplicated Contacts.

There are also the standard Mautic fields available:

**Active** - This allows you to set the activation status of the Social Monitor. Deactivated Social Monitors won't collect new Contacts.


**Activate at (date/time)** - This allows you to define the date and time at which this Social Monitor is monitoring for new Contacts. This might be used to coincide with an event, for example.

**Deactivate at (date/time)** - This allows you to define the date and time at which this Social Monitor ceases to monitor for new Contacts.


**Contact Segment** - This allows you to define the Segment/s in Mautic that the Contacts join if detected with this Social Monitor. This can be useful for identifying people who are talking about your brand, and directly add them to a Segment to take further action.

  .. image:: images/social_monitoring/social_monitoring_hashtags.png
    :width: 400
    :alt: Screenshot showing the creation of a new Twitter Hashtags Social Monitor.""",
    ),

    AppLesson(
      title: "Utm Tags",
      body: r"""UTM tags

UTM tags are also known as parameters or short text codes. When adding these tags to URLs or links, marketers can track performance, create customised audiences, and analyze on website traffic from various sources. Marketers can also use UTM tags with Google Analytics to clearly understand the effectiveness of their marketing content and return on investment for marketing projects.

Key benefits of using UTM tags

With UTM tags, you can:

- Track the value of marketing projects and measure return on investment
- Get precise data about conversion and traffic sources
- Test the effectiveness of marketing content through A/B testing

Using UTM tags in Mautic

To use UTM tags with Google Analytics where they appear in your Google Analytics Dashboard, you must install your Google Analytics tracking code on the resource you are linking to. This synchronizes with your Google Analytics Dashboard and records the UTM tags.

If you use a Mautic Landing Page, you must go to Settings > Configuration > Tracking Settings, and add your Google Analytics ID.

  .. image:: images/utm_tags/add_google_analytics_id.png
    :alt: Screenshot showing the option to add your Google Analytics ID

If you use a non-Mautic Landing Page, you must manually embed the Google Analytics tracking script on the third-party Page.

Mautic Users can automatically append UTM tags to all links in an Email or Focus Item. For other Channels, you can make the link trackable by including UTM values in the URL address. When a Contact clicks a link in an Email or Focus Item, Mautic records UTM tags and stores them in the Contact record. You can find the details on the Contact Event History overview. After recording the UTM tags, you can use them as filters in Segments.

You can use UTM tags to track Contacts who convert from Dynamic Web Content slots in Emails, and determine the source in Google Analytics or Mautic Reports. You can also use them as columns in a Report by selecting UTM codes as the data source.

The following table lists the Google Analytics UTM tags:

   :widths: 50 50
   :header-rows: 1

   * - UTM tags
     - Description
   * - Campaign Source
     - The referring source of the web activity. It indicates the social network, search engine, newsletter name, or any other specific source driving the traffic.
        * Examples: ``facebook``, ``twitter``, ``blog``, ``newsletters``
        * UTM code: ``utm_source``
        * Sample code: ``utm_source=facebook``
   * - Campaign Medium
     - UTM tags - Mautic Documentation
         * Examples: ``cpc``, ``organic_social``
         * UTM code: ``utm_medium``
         * Sample code: ``utm_medium=paid_social``
   * - Campaign Name
     - The specific promotion or Campaign title that you want to track.
         * Examples: ``summer_sale``, ``free_trial``
         * UTM code: ``utm_campaign``
         * Sample code: ``utm_campaign=summer_sale``
   * - Campaign Content
     - The Assets within the messages. This non-configurable value auto-populates with the content Asset identifier associated with the specific Asset.
   * - Campaign Term
     - The keyword to search a Campaign. This non-configurable value auto-populates within the link text and tracks links within the messages.

    You don't need to fill all the options. You can use one, or a few, or all of them, as required.


Using UTM tags in Emails


Mautic supports UTM tagging in Emails. Mautic can automatically append UTM tags to all links in an Email by entering the appropriate Campaign values in the fields provided.

#. In Mautic, click Channels > Emails.
#. Create a new Email or edit an existing Email. If you choose to edit an existing Email, click the Email and then click Edit.
#. Locate the Google Analytics UTM tags section on the bottom right.
#. Enter the appropriate information in the fields.
#. Click Apply.

    * When adding links in Emails, use the edit link icon in the builder.
    * When adding links in Code Mode, use the <a href> tag.
    * All links must include a trailing slash. Otherwise, UTM codes aren't appended.

Using UTM tags in Focus Items

Mautic supports UTM tagging in :doc:`/channels/focus_items`.  Mautic can automatically append UTM tags to all links in a Focus Item by entering the appropriate values in the field provided.

#. Click Channels > Focus Items
#. Create a new Focus Item or open an existing one.
#. Locate the Google Analytics UTM tags section on the bottom right.
#. Enter the appropriate information in the fields.
#. Click Apply.""",
    ),

    AppLesson(
      title: "Web Notifications",
      body: r"""Web notifications

Web Notifications can be an extremely powerful tool for the marketer. Mautic integrated with :xref:`OneSignal` which allows you to push information to a Contact as they browse through web resources - including Mautic Landing Pages or your own website - giving you one more Channel that you can use to build a relationship with them.

Web notifications in Mautic use OneSignal by default. Using your own OneSignal account, you can now push a notification to your Contact's browser - with their permission. Enable the OneSignal Plugin in Mautic's Configuration to see Web Notifications listed under Channels in the menu.

For more information see the OneSignal :xref:`OneSignal web push` documentation.

Setup web notifications

Configuration

#. Create a OneSignal account and once logged in, create an App

#. Setup App Website Push Platforms in your OneSignal App

  .. image:: images/web_notifications/onesignal_add_app.png
    :width: 400
    :alt: Screenshot showing creating push platforms on OneSignal.

#. Select Typical Site and fill out the required fields.


#. Download the SDK files from the next screen, and upload them to the root of your Mautic installation - this must be accessible at `https://mautic.example.com/OneSignalSDKWorker.js`.


#. Get the keys from OneSignal under the Settings > Keys & IDs tab.
#. Enable the features you wish to use - for example, whether to enable notifications on mobile apps, Landing Pages, tracked resources on your website, and whether to show a welcome notification after they subscribe. You can also specify a subdomain name, and if you're using iOS and Android notifications you can also enable these options - see :doc:`/channels/push_notifications`.

Sending notifications
There are two ways to send website notifications to the Contact:

1. Send with a Campaign Action
2. Send via a :doc:`/channels/marketing_messages`""",
    ),

  ],
),

AppCourse(
  id: "marketing_6",
  title: "Companies",
  description: "Companies",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "1 Lessons",
  lessons: [
    AppLesson(
      title: "Companies Overview",
      body: r"""Companies

Companies are a way to group Contacts based on association with organizations.

  :width: 600
  :alt: Mautic Company Overview

Engagements/Points chart

Engagements shown on the chart include any tracked action the Contacts made. Some examples might include page hits, Form submissions, Email opens and so on. The engagements line chart displays how active the Contacts of the Company were in the past 6 months. The chart displays also the sum of Points the Contacts received.


List of Contacts assigned


You can find a table with the list of the assigned Contacts displaying the date of their last activity, preceding the information of the Company which includes the Company name, address, and all the custom Company fields, and the engagement chart. This is good way to have a view of the recent activity of the Contacts you know in this Company.

Company duplicates
The Company name field is a unique identifier by default. You can choose any other Company field as unique identifier in the **Custom Fields** section.

In *Configuration > Company Settings* you can choose the operator used when merging Companies with multiple identifiers - either **AND** or **OR**.

  :width: 600
  :alt: Setup operator for find duplications algorithm

These settings allow  Mautic to find and merge duplicate Companies during the import, using the Integrations Framework and in other parts of Mautic.

Company actions


Merging Companies


When editing a Company, you can merge this Company into another existing Company by using the **Merge** button.

Search for the Company you wish to merge into, then click to start the merge. Contacts associated with the merged Companies now become associated with the remaining Company.

After completion of the merge process, Mautic redirects you to the remaining Company, as the old Company no longer exists.


Company Custom Fields


By default, a set of fields exist for Companies, but you can customize these fields to meet your needs.

#. Go to **Custom Fields** and create a new field

#. Change the dropdown select box from Contact to Company objects

#. Save the Custom Field


Company Segments


You can create a Segment based on a Company record. Select any Company field to filter with and the matching criteria for it, and Mautic lists any Contacts that match the selected fields in the Segment.


Identifying Companies


Mautic identifies Companies strictly through a matching criteria based on **Company Name**, **City**, **Country or State**. If  a city or a country isn't delivered as an identifying fields to identify a Contact, the Company won't match.


Company actions in Campaigns


It's possible to add a Contact to a new Company based on a Campaign action.


Creating and managing Companies


To create or manage Companies, go to the Companies menu identified by the building icon in the left hand navigation. In this area you can create, edit, or delete Companies.


Assigning Companies to Contacts


There are different ways to assign a Company to a Contact as explained below:

Contact profile

You can assign a Contact to Companies in the Contact's profile, while creating or editing an existing Contact. Mautic considers the latest Company assigned as the primary Company for the Contact.

Contacts list view

You can batch assign Companies to selected Contacts in the Contact's list view.


Via a Campaign


You can assign a Company to identify Contacts through a Campaign by selecting the **Assign Contact to Company** action.


Through a Form


When identifying a Contact through a Form, you can also associate an existing Company or create a new one if:

- The Form includes Company name as a Form Field - mandatory for Company matching/creation,
- The Form includes City as a Form Field - mandatory for Company matching/creation,
- The Form includes Country as a Form Field - mandatory for Company matching/creation,
- The Form includes State as a Form Field - optional for Company matching/creation.

Company scoring

It's possible to change the Company score through a Campaign action or a Form action. When using these actions, it's necessary to identify the Contact first, and then alter the score of the Companies assigned to that Contact.

#. Select the **Change Company score** action in either a Form or a Campaign
#. Once submitted or triggered, Mautic identifies Companies in the Campaign or Form to change their score.


Setting the primary Company


You can set the primary Company through the Contact details interface.

  :width: 600
  :alt: Screenshot showing setting the primary Company""",
    ),

  ],
),

AppCourse(
  id: "marketing_7",
  title: "Components",
  description: "Components",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "4 Lessons",
  lessons: [
    AppLesson(
      title: "Assets",
      body: r"""Assets

Assets are pieces of content you want to make available for your Contacts to access. You want to track and analyse  who is viewing or downloading your Assets. You also may want to personalize the Contact's journey based on what Assets they interacted with. You may also do scoring based on interaction with Assets.


Managing Assets

Asset Categories


Mautic allows you to organize Assets into Categories, which helps you easily locate resources. To create a new Category, review the :doc:`/categories/categories-overview` documentation.


Working with Assets


Before creating an Asset, first establish and publish any Categories required. It's not possible to assign Assets to unpublished Categories. If you wish to use an Integration such as the Amazon S3 Plugin to host your files, set this up before creating an Asset.


Creating a new Asset


Navigate to Components > Assets. Mautic lists any Assets you have previously created. Click New to begin creating an Asset.

You create Assets by uploading local resources on your computer, or by locating the Asset from a remote storage host such as Amazon S3. There are limitations by size due to the settings of your server - any such restriction may display as a warning message in the file upload section.


Add UTM codes to Asset


UTM parameters appended to the download link means that UTM data is available in the resource download Report.


  /asset/{id}:{name}?utm_source=test&utm_medium=test&utm_campaign=test&utm_id=test&utm_term=test&utm_content=test



Uploading an Asset


To upload an Asset, either drag the file into the box, or click in the box to open a file upload window. On selection of the file, it's automatically uploaded and appears in the boxed area.

By default Mautic allows the following file types:


  csv,doc,docx,epub,gif,jpg,jpeg,mpg,mpeg,mp3,odt,odp,ods,pdf,png,ppt,pptx,tif,tiff,txt,xls,xlsx,wav

If you need to add extra file types, configure the maximum size of upload or the Assets directory, navigate to Configuration > Asset Settings.

  :width: 600
  :alt: Screenshot of Asset settings

The following fields are available:

- **Title** - the title for the Asset
- **Alias** - used to create the slug on the download URL. Created from the title automatically if not provided.
- **Description** - an internally used description to inform other Mautic Users what the Asset is and/or where it's used.
- **Category** - used to organize resources - see :doc:`/categories/categories-overview` for more information
- **Language** - the language of this Asset - can be helpful in multilingual marketing Campaigns and for reporting purposes
- **Published** - Whether the Asset is available for use - published - or not available - unpublished


**Publish at (date/time)** - This allows you to define the date and time at which this Asset is available

**Unpublish at (date/time)** - This allows you to define the date and time at which this Asset ceases to be available


- **Block search engines from indexing this file** - If you don't want to index files like ``PDF``, ``DOCx`` and so forth, setting this switch to Yes sends the ``X-Robots-Tag no-index`` HTTP header. If set to No, the header isn't sent and your files could become indexed by search engines.

Depending on the type of file uploaded, a preview may display after the upload completes.

  :width: 600
  :alt: Screenshot of create new Asset interface


Using remote Assets


Instead of uploading a file from your computer, you can either provide a link to a file on a cloud storage provider or browse your integrated cloud storage provider - for example, an Amazon S3 bucket - by selecting the Remote tab, rather than Local.

**Optional remote URL validation:**

You can enable optional remote URL validation by adding ``'validate_remote_domains' => true`` to the ``config/local.php`` file.

When you enable this validation, Mautic only allows domains listed in **Configuration > System Settings > Miscellaneous Settings > Allowed remote domains**. The validation also considers the domain of your Mautic instance valid.


Viewing an Asset


Once you've uploaded an Asset, you'll want to make it available for your Contacts to access it. Using the Download URL from the Asset section in Mautic, you can track which Contacts are downloading or viewing the Assets.

Copy and paste the link into your website, on a Landing Page, or as a link in an Email.

    In a Mautic Email or Landing Page, append ``?stream=1`` to the end of the URL to open the Asset in a new tab.

Whether the Asset downloads or opens in a new tab depends on the Contact's browser settings. To gate an Asset by requiring them to submit some information before downloading, you may have a Form submit action to download an Asset.

To ensure that Contacts are providing you with valid Email addresses for high-value Assets, attach the Asset to an Email and use the send Email Form submit action rather than instantly downloading the Asset.


Editing an Asset


You can edit an Asset by clicking on the 'edit' button while viewing the Asset, or by selecting the arrow next to the checkbox for the Asset, and selecting 'edit'. The edit screens are the same as the view screens,with the saved content already populated in the fields.


Deleting an Asset


It's possible to delete an Asset by clicking on the 'delete' button while viewing the Asset, or by selecting the arrow next to the checkbox for the Asset, and selecting 'delete'. Mautic displays a confirmation screen, prompting confirmation that you wish to delete the Asset.

    Once deleted, you can't retrieve an Asset, and statistics relating to the number of downloads for that Asset are no longer be available. Contact Points accumulated as a result of accessing the resource remain. It's recommended where possible to unpublish Assets which are no longer in use - in future there may be an archive feature.

Display Assets directly in the browser

By default, Mautic supports the following file types for direct display in the browser:


- gif
- jpg
- jpeg
- mpg
- mpeg
- mp3
- pdf
- png
- wav


If you want to change this default behavior, you can modify the ``local.php`` file and set an array of extensions for the ``streamed_extensions`` parameter.""",
    ),

    AppLesson(
      title: "Dynamic Web Content",
      body: r"""Dynamic Web Content


Dynamic Web Content is one of several methods Mautic uses to personalize the web experience for Contacts. Marketers can display different content to different people in specific areas of a webpage. Mautic Users may want to personalize content based on data collected about the website visitor. Even anonymous Contacts may see Dynamic Content, if you've collected any information about them - such as location data.

Preparation

Before you consider using Dynamic Web Content, consider:

- where on your website would you include personalized content?
- What audience/s do you plan to personalize content for?
- Do you collect the information required to accurately filter your Contacts in this way?


Website configuration

Once you've decided where on your website to display the content, you must create an area to add the content. Mautic is platform-agnostic - you can add slots into any website you have created. To do this, create an HTML slot to display the Dynamic Web Content.

Change ``myslot`` in ``data-param-slot-name=\"myslot\"`` to the Requested Slot Name of your Dynamic Web Content item:


    <div data-slot=\"dwc\" data-param-slot-name=\"myslot\">
    <h1>Dynamic web content for myslot</h1>
    </div>

You can add your own default content between the ``<div>`` tags to ensure that content displays when the filters aren't matching - for example with new anonymous visitors or a Contact that doesn't match the criteria you have specified.

Content Management System Plugins for Mautic also have specific ways to embed the content, for example:

- **Joomla** - ``{mautic type=\"content\" slot=\"slotname\"} Insert default content {/mautic}``
- **WordPress** - ``[mautic type=\"content\" slot=\"slotname\"] Insert default content [/mautic]``

Mautic configuration

    It's important to ensure that you configure your CORS settings correctly when using Dynamic Web Content - if this isn't set up your content won't display. Read more in :ref:`CORS Settings`.


Creating Dynamic Web Content slots


Mautic provides both Campaign-based and filter-based Dynamic Web Content. To create either type:

#. Navigate to the Components > Dynamic Content section
#. Click New to create a new slot

  :width: 400
  :alt: Create a new Dynamic Web Content slot

The following values are available:

- **Internal name** - This is how the slot displays in your list of Dynamic Web Content slots. You should include information on what you're personalizing - for example, country - and the content in the slot - for example, United States. If you're creating a personalized slot for people in the United States, you can name the slot Country - United States. If you plan to have more than one personalized content slot for the same audience across your website, include the page title or other identifying information for the particular slot.


#. **Content** - Use the WYSIWYG editor to create the Dynamic Web Content slot. You may include images and videos. If you prefer HTML, click the ``</> Source`` icon in the toolbar to switch to the code view. Mautic's Dynamic Web Content supports tokens in the same way as Landing Pages or Emails. To add a token, start typing with the ``{`` character and available tokens are displayed. These include:

   *  Contact field: {contactfield=fieldalias}
   *  Landing page link: {pagelink=ID#}
   *  Asset link: {assetlink=ID#}
   *  Form: {form=ID#}
   *  Focus item: {focus=ID#}


**Category** - Assign a Category to help you organize your Dynamic Web Content items. See :doc:`/categories/categories-overview` for more information.

- **Language** - the language of this Dynamic Web Content - can be helpful in multilingual marketing Campaigns and for reporting purposes

- **Is a translation of** - If you're creating a slot in a second language translation - for example to use on a multilingual website - select the original base language Dynamic Web Content item which you're translating. The same slot displays the appropriate language based on the Campaign or filters set, but Mautic shows the translated content if a visitor is viewing the page in a different browser language.

- **Published** - Whether the Dynamic Web Content item is available for use - published - or not available - unpublished

- **Is Campaign based** - if set to Yes, Mautic pushes this Dynamic Web Content to Contacts through a Campaign. When set to No, you can specify filters for visitors to see the content.

- **Requested slot name** - shown if using non-Campaign based Dynamic Web Content, this allows you to specify the slot name on your website in which the Contact sees the content.


**Publish at (date/time)** - This allows you to define the date and time at which this Dynamic Web Content item is available for displaying to Contacts

**Unpublish at (date/time)** - This allows you to define the date and time at which this Dynamic Web Content item ceases to be available for displaying to Contacts.


**UTM tags** - Mautic can append UTM tags to any links and Form submissions. See :doc:`/channels/utm_tags` for more information.


Campaign-based Dynamic Web Content


Creating the request

Use a Campaign Decision for ``Request Dynamic Content`` to use Campaign-based Dynamic Content. The Campaign Decision checks if a Campaign member visits a page where a Dynamic Content slot is. Visitors to a page with a Dynamic Content slot receive the Dynamic Content.

The following fields are available:

- **Name** - the Campaign event. Start the name with something like ``Req-DWC``: so when you're looking at Campaign Reports, you can see the event type.

- **Requested Slot Name** - Mautic checks for the slot name. You can see how many Contacts got to the Campaign event where you're checking if their visits request the slot.

As an example, these two fields might look like: ``Req-DWC: Country-Header`` in the Contact history. The requested slot name is the slot Mautic looks for on the page. If it's on a 3rd-party page, it'll be in the code you use to add the Dynamic Content slot to your page. If it's on a Mautic Landing Page, define the slot name on the Landing Page.

- **Select Default Content** - choose the content which displays to visitors who don't meet the conditions set at the next step of the Campaign. Users may see the default content first, before Mautic pushes the Dynamic Content.

  :width: 400
  :alt: Create a new Dynamic Web Content request in a Mautic Campaign

Creating the filters

Once created, you can add filters on the affirmative path to determine which Contacts see the different variations. This happens with Conditions - read more in :doc:`/campaigns/creating_campaigns`.

As an example, you might use the condition of ``Country = United States of America`` to filter only people located in the country.

Pushing the Dynamic Web Content
Once the relevant filters are in place, you can add the Campaign action of 'Push Dynamic Content' which triggers Mautic to send the relevant content to the Contacts matching the filters.

  :width: 400
  :alt: Push Dynamic Web Content to Contact in a Mautic Campaign

With all this in place, it might look something like this:

  :width: 400
  :alt: Dynamic Web Content to Contact in a Mautic Campaign

You may wish to decide on a naming convention for your Campaigns, for example prefixing with ``DWC:`` when you're pushing Dynamic Web Content.


Filter-based Dynamic Web Content


Filters are often easier to work with and can be more reliable, as they don't rely on the triggering of a Campaign cron job.

Creating filters

#. When creating the Dynamic Web Content item, select No for the 'Is Campaign based' switch which displays the filters tab.

#. Use the filters to configure the criteria that Contacts must meet to see the Dynamic Web Content slot.

#. Provide the content in the slot within the text editor area. Mautic displays this content when the filters match.


Implementing Dynamic Web Content


Default content

Mautic displays the default content when the visitor doesn't match any of the filter criteria, or the visitor isn't a tracked/identified Contact. It's important to have something in the default content, rather than an empty space.

For Campaign-based Dynamic Web Content, you specify the default content when you configure the Request Dynamic Content decision. In filter-based Dynamic Web Content, you create the default content on the page where you are inserting the slot, and Mautic replaces it with the Dynamic Content if the filter match.

    If you're using Focus Items as your Dynamic Web Content and only showing specific Focus Items to specific audiences, you don't need to have any default content, as Focus Items don't physically take up space on your page.""",
    ),

    AppLesson(
      title: "Forms",
      body: r"""Forms

Mautic subscribers use Forms for lead generation and data collection. With Mautic Forms, marketers can convert anonymous web visitors to known Contacts and build a Contact's profile with progressive profiling. The more data you can gather without appearing intrusive or annoying, the more effective your personalization strategy.


Creating a new Form


To create a new Form, go to **Components > Forms** and click **New**.

    All Forms in Mautic can trigger Campaigns and have access to the full range of Form actions. You can use Forms as a Contact source in Campaigns to trigger workflows when Contacts submit them.

The following fields are available:

- **Category** - Assign a Category to help you organize your Forms.

- **Published** - Whether the Form is available for use - published - or not available - unpublished. Unpublished Forms won't be visible when you've added the Form using JavaScript. If you used the manual method to copy and paste the Form HTML, the Form remains visible but visitors **won't** be able to submit it - an error message prevents them from submitting if they try to submit an unpublished Form.

- **Publish at (date/time)** - This allows you to define the date and time at which this Form is available for submissions.

- **Unpublish at (date/time)** - This allows you to define the date and time at which this Form ceases to be available for submissions.

- **Disable search indexing** - If Yes, Mautic prevents search engines from finding and displaying the Form in search results by sending the ``noindex`` http header.

- **Kiosk mode** - If Yes, Mautic turns off tracking of Contacts created through the Form, so that the Form doesn't generate cookies or associate any IP address with the Contact record. Marketers may refer to this as 'data entry mode'. It's ideal for using at conferences or events where several Contacts may enter their information using the same device, as it prevents associating the activity on the device to Contacts.

- **Use Theme style** - If Yes, the Form displays with the styling from either the selected Mautic Theme or the Attributes tab of the Form Fields. When No, the Form adopts the styling of where it's embedded.

- **Theme** - Select a Mautic Theme which has styling for a Form. This dictates the styling of the Form when added to an external website or Application if 'Render style' is Yes.

    Not all Themes include Form styling. Check the Features column on your Themes listing in the Theme Manager to see which Themes include styling for Forms.


Configuring Forms


Once you have created a new Form, you have some additional options to set.

Details

   :width: 600
   :alt: New Form interface at Mautic

The available details fields are:

* **Name** - Title of your Form, including any terms you may want to use to search for the Form.
* **Description** - A description to describe the goal of the Form. It may help to include information such as the location where the Form appears.
* **Successful Submit Action** - Options include:

   .. vale off

   * **Remain at Form** - the Contact stays on the same page and the Form resets, allowing for another submission or continued browsing
   * **Redirect URL** - sends the Contact to a different website or a specific Mautic Landing Page after they click submit
   * **Display message** - shows a confirmation or thank you message on the screen after the Contact submits the Form

   .. vale on

* **Redirect URL/Message** - If you decide to use the **Successful Submit Action** of:

   * **Redirect URL**: paste the URL where you'd like to direct submitters
   * **Display message**: enter the message to display

  For these options, you can use placeholders to personalize the experience for your Contacts. Mautic automatically replaces these placeholders with specific details when the Contact submits the Form:

  .. vale off

  .. list-table::
   :widths: 25 25 50
   :header-rows: 1

   * - Placeholder
     - Replace with
     - How to find the value
   * - ``{contactfield=ALIAS}``
     - Replace ``ALIAS`` with a value from the Contact's field.
     - Refer to :doc:`/contacts/custom_fields` to find aliases in the Custom Fields.
   * - ``{formfield=ALIAS}``
     - Replace ``ALIAS`` with the Form's **Matching field**.
     - If not set yet, click the pencil icon on the field card to edit it, then select a field from the **Matching field** dropdown menu, under the :ref:`Mapped Field <Mapped field>` tab.

       Once updated, in the **Fields** tab, look at the bottom of the field's card. Use the lowercase version of the text shown after **contact:** for ``ALIAS``. For example, use ``timezone`` if the card shows ``contact: Timezone``.
   * - ``{pagelink=ID}``
     - Replace ``ID`` with the ID of a Mautic Landing Page.
     - Go to **Components > Landing Pages** and look at the **ID** column.


Fields

To control the maximum number of fields shown on a Form:

- **Maximum fields displayed at a time** - This setting applies progressive profiling across multiple Forms. Select the maximum number of fields to display on a single Form.

To add a new field to your Form:

#. Click the Add a new field dropdown and select the type of field you wish to use. Available fields include:

   - **CAPTCHA** - A basic tool for spam protection requiring the Form submitter to answer a question, or detecting when spambots try to submit data in a hidden CAPTCHA field - sometimes referred to as a honeypot. It's recommended to use some kind of CAPTCHA on every Form. It's also possible to support reCAPTCHA and other tools with third-party Plugins.

   - **Checkbox Group** - This field allows a visitor to select one or more options from a list using checkboxes. This field type can also provide a single checkbox - for example to gain consent to use cookies and send marketing Emails or other messages to the Contact.

   .. note::
      You can associate checkbox group fields with *boolean* and *select - multiple* fields, but not *select* fields.

   - **Date** - This field allows the visitor to select a date with a calendar picker. The formatting of the date applies the default setting in your Configuration.

   - **Date/time** - Similar to the date field, this allows the visitor to select both the date and the time using a calendar picker.

   - **Description** - A basic header field, most often used to provide a visual title for the Form. The header field acts as the field name or label. The description area - accessed under the Properties tab - is a free text WYSIWYG editor, where you can add a description of the Form. By default, the description shows immediately below the header field in paragraph text format.

   - **Email** - This field requires the visitor to provide a valid Email address using the correct syntax expected from an Email address - ``name@domain.com``. It's recommended to have at least one Email field on your Form, as by default the Email field is the default identifier of a Contact in Mautic.

   - **File** - This allows visitors to upload a file on the Form.

   .. warning::
      When using the file upload field there is a limit of 1,000 submissions using the same filename. Note that you can attach the submitted files in the \"Send Form result\" action.

   - **HTML area** - This field allows marketers to add custom HTML to their Form.

   - **Hidden** - This field won't be visible on the Form, but include default values, saved along with the Form submission, for reporting or internal tagging purposes.

   - **Select: Country** - This populates Mautic's default, non-editable country list. To use a custom list you should make use of the Select field type and manually enter the countries you would like to include.

   - **Page break** - This allows marketers to break up the Form into multiple parts or field groupings.

   - **Number** - This field validates that the entered values are digits. The field allows decimals and negative numbers, but no other non-numerical values - including commas. On a mobile device, the keyboard changes to a number pad when a visitor clicks into this field.

   - **Password** - This allows the visitor to create a password. Use this field if the Form creates an account and Mautic posts the results to another system/Form. You must not save the entered field value to the Contact profile for security reasons.

   - **Phone** - This field maps by default to the Phone field, and validates numbers using the international format for phone numbers. The validation requires a country code - for example +1 for the United States of America or +44 for the United Kingdom).

   - **Radio group** - This field provides a group of single-select options with a radio button, sometimes referred to as an option button group.

   - **Select: Single or multiple choices** - This option shows a dropdown list where a visitor may choose one option. This field also allows multiple selections, which changes the display to a box with the options listed. On a mobile device, a single select box shows a dialog box with radio buttons, and with checkboxes for a multi-select field.

   - **Slider** - This field provides an interactive slider control that allows visitors to select a numeric value from a predefined range by dragging a handle along a track. The slider displays the minimum and maximum values at each end and shows the current selected value as the visitor moves the handle.

   - **Social login** - This allows the visitor to connect their Twitter, Facebook or LinkedIn profiles with their Contact record. You must configure the Plugin for the social network before using this field.

   - **Text: Short answer** - This field shows a text box with 255 characters available. Common uses include specifying the visitor's first name, last name, city, and so forth.

   - **Text: Paragraph** - Similar to the text field, but without the 255 character limitation. The text area field has a character limit of 65,535 characters.

   - **URL** - This field validates the entry as being in the expected format for a URL, including ``https://`` or ``http://``

Field options

Based on the field selected, Mautic displays various tabs in the fields editor interface. The available tabs are:

- :ref:`General`
- :ref:`Mapped field`
- :ref:`Validation`
- :ref:`Properties`
- :ref:`Attributes`
- :ref:`Behavior`

General

- **Label** - This is the title of your field, telling the visitor what you'd like them to enter in the field. The label shows before the Form Field by default.

- **Show label?** - When No, Mautic won't display the label on the Form.

- **Save result** - When No, Mautic won't save the data entered in the Form to the Form submissions table. When Yes, the submissions  are accessible in the Form submission results. If mapped to a Contact field, Mautic still saves the data to that field.

- **Default value** - This allows the marketer to provide a default value for a field. The default value is useful when setting a value as a hidden field, or when you expect the visitor to enter a certain value. The Contact can change the default value when they complete the Form if the field is visible.

- **Help message** - This allows the marketer to add information for the visitor about what they should enter in the field, or why they should provide the information.

- **Input placeholder** - This allows the marketer to add text within the Form Field, which gives the visitor an idea of what they should enter. The text disappears as soon as they click into the field, whereas default values don't. This can be particularly helpful in prompting the visitor if you require the data in a particular format, for example ``@Twitter`` for a Twitter account, including the ``@`` symbol.

Mapped field

The mapped field tab allows the marketer to connect a field with an existing Contact or Company field in Mautic. This allows the data from the Form submission to automatically populate into the mapped field. Without the mapping, this information won't save in the Contact profile.

The data type for the Form Field should match the data type of the mapped field. For example, a date/time field should map to a Contact or Company field which uses the date/time field.

Validation

The validation tab allows you to set whether the field is mandatory or not. If the field is mandatory and it's not completed by the visitor, the Form displays an error and the visitor sees a message informing them that they must complete the field before submitting the Form.

Switch the slider to ``Yes`` to make the field mandatory.

  :width: 600
  :alt: Screenshot showing Form validation

It's also possible to add a validation message specific to this field, giving the visitor a prompt when they submit the Form and haven't included this field.

Properties

The properties tab won't show on every field type. Different field types have different associated properties to configure.

CAPTCHA

  :width: 600
  :alt: Screenshot showing CAPTCHA Form properties

With a CAPTCHA field, the answer field should be blank if you are using this as a honeypot to trap spam submissions. This hides the field, and spambots try to populate the field with data.

Mautic recognizes if there's data in a honeypot CAPTCHA field and understands that it can't be a human submitting the Form.

To have a human answer a basic question or statement - for example ``What's 2+2`` or ``Enter 'CAPTCHA' here`` - you would enter the expected input in the answer field, in this case, ``4`` or ``CAPTCHA``.  The field's label should be the question, or you can use the label CAPTCHA and then have the question as the input placeholder.

The custom error message allows you to display something which informs the human if they have entered the wrong information. The default message is ``The answer to \"{label}\" is incorrect. Please try again``.

Checkbox group, radio group and select

  :width: 600
  :alt: Screenshot showing checkbox field values with a mapped Custom Field

With the checkbox, radio box and select fields, the properties tab allows you to choose what should be available for the visitor to select.

If you have mapped the Form Field to a Custom Field in Mautic, there is also the option to use the values provided in the Custom Field rather than listing them separately. This helps to prevent duplication and errors in the Form options.

If you prefer to create your own field options, the ``Optionlist`` allows you to add options with a label and value pair.

The label field controls the display of the field to the visitor completing the Form, and the value field controls the data saved to the database and stored against the Contact record. While they often match this might not always be the case. For example with a GDPR checkbox, the label might be ``Yes I accept that I may receive Email communications from this Company`` whereas the value stored to the database may be ``Yes`` or ``1``.

In select fields, there are two additional settings to allow for setting the Empty Value - which serves the same purpose as the Input Placeholder and isn't saved to the database - and to determine whether to allow multiple values, which changes the field from ``Select`` to ``Select - Multiple``.

Description area

Use the text entry field in the properties tab of the Description field to enter the information you would like to show with the Form - for example why the visitor should complete the Form. Often this information might display on the website, but you can also include it in the Form itself with this field.

File

  :width: 600
  :alt: Screenshot showing file upload properties

When uploading a file within a Form there are several options under the properties tab:

- Allowed file extensions: it's possible to set the file extensions permitted by providing a comma separated list.
- Maximum file size: the maximum size of attachment - also limited by server settings.
- Public accessible link to download: can you access the file via a public link?
- Set as Contact profile image: set the image uploaded to be their Contact avatar

Attributes

   Attributes are CSS tags which change the styling of a particular Form.

   Setting the Render Style to No on the Form means that Mautic ignores the styling in these fields.

  :width: 600
  :alt: Screenshot showing the attributes for a checkbox group

- **Field HTML name**: this is the machine name of the field, populated automatically from the label. You can customise this field if the label is long. You reference this field is when connecting Mautic Forms to other Forms, or when using the Self-hosted function to manually add the Form to your website or app.
- **Label attributes**: this field changes the way the label text appears. You should use the format ``style=\"attribute: descriptor\"`` to change the style. For example, to change the label to red, use ``style=\"color: red\"`` or ``style=\"color: #ff0000\"``.
- **Input attributes**: changes the way any text inside the Form Field appears. This applies to the input placeholder text, text entered by the visitor submitting the Form, and the options for the select fields when Allow Multiple is Yes - including List - Country.
- **Field container attributes**: this changes the Form Field. Use this to change the size of the box, fill color, rounded edges, or any other properties of the actual field.
- **Radio/Check box label attributes**: similar to input attributes, when available this field allows you to customize the way that radio buttons and checkboxes appear.

Behavior

Text

The Behavior tab helps marketers to improve the experience for the visitor completing the Form. It also helps marketers implement progressive profiling, to gather more data from the Contact which helps in optimized personalization.

- **Show when value exists**: if Mautic knows the Contact and they're tracked, when a value exists for a field Mautic hides the field when this setting is No. This prevents the Contact answering the same question multiple times. You may want to display the field even if it's already known when you want to ensure you have the most up to date information about the Contact.
- **Show after X submissions**: this allows the marketer to show certain fields only when the Contact has submitted the Form a specified number of times. Enter a value between ``1`` and ``200``.  When left undefined, the field shows every time the Contact views the Form. The goal is to minimize the number of fields shown to the Contact, so it's recommended to hide fields if it's not necessary to verify the values.
- **Auto-fill data**: this allows you to pre-populate Contact data with known Contacts where the information exists in the Contact profile. Auto-fill works with Mautic Landing Pages, and data won't pre-populate when placing the Form anywhere else. Even if you're hiding this field, you may wish to turn on auto-fill to ensure saving of the information with the Form submission.
- **Read only**: activate this setting to lock auto-filled fields with existing Contact information, preventing any edits by Contacts. This ensures that the data submitted with the Form remains accurate and consistent, especially for critical details like Email addresses. Enable this option together with Auto-fill data to stop Contacts from changing essential information during Form submission.

Field order

To change the order of fields on your Form:

#. Click the field you would like to move
#. Drag the field to a new location


Progressive profiling

Progressive profiling is a powerful feature used to reduce the length of Forms by hiding all the fields that are already known. This prevents your Contacts from feeling overwhelmed by massive Forms and even reduces the time it takes to fill out a Form if fields are already known to your Mautic instance and thus hidden for the Contact.

Configuration of progressive profiling

There are two ways to configure a Form Field to only display when the asked values are unknown.

First, choose the Form that you want to use for progressive profiling. Go to the Form Fields and open the field configuration of the field you want to use for progressive profiling. Change to the Behavior tab. Here, you can configure the behavior of the fields.

  It's always recommended to use the Email field, even if it's already known, because Mautic uses the Email as a unique identifier for Contacts. Additionally, ensure the submit button field is always visible. Otherwise, the Contact can't submit the Form.

1. **Show when value exists**:
if set to 'No,' Mautic checks whether the value for this field exists in the database or if a previous Form submission provided it. If found, Mautic won't display the field in the Form. If set to 'Yes,' Mautic displays the field regardless of the existence of a value in the field. The default configuration for this option is 'Yes'.

2. **Display field only after X submissions**:
if you have a Form that you'd like to use multiple times, with more fields appearing the more times a Contact fills it out, while still using only a single Form, the option 'Display field only after X submissions' is what you're looking for. As the name suggests, the field appears only after the Form has received X submissions. This feature pairs well with the ability to hide fields if the value is already known.

For example, on the first time of completing the Form, it asks for the Email, first, and last name of a Contact. When the Contact fills out the Form a second time, it hides the first and last name fields, and instead, it prompts the Contact to fill in their Company and phone.


Limits of Progressive Profiling

**The search history limit**

Mautic Forms which don't use progressive profiling are as fast as they can be. The HTML of the Form renders once, gets stored, and Mautic uses this \"cached\" HTML  for the next Form load. When turning on progressive profiling for any of the Form Fields, the Form HTML might be different for each Contact. It can even change for each Contact after each submission. The impact of this is that you can't use Form-caching, and the Form load time is slower for a progressive profiling Form.

Mautic imposed a limit of 200 submissions from which it searches for existing Form values. This limit aims to prevent possible long Form loading times or hitting the server time or memory limits when a Contact has several thousand Form submissions. Exceeding this limit might cause Mautic to display/hide the wrong fields for a Contact.

**The embed type limit**

Progressive Profiling Forms don't function if you embed your Form as static HTML. However, they work on Form preview, Form public pages, Forms embedded via JS, and Forms embedded via iframes.

**The kiosk mode limit**

When you switch the Form to Kiosk Mode, the Progressive Profiling features are turn off. In Kiosk Mode, the Form always creates a new Contact upon each submission and doesn't track the device submitting the Form.

Form actions

You may want to trigger certain actions to happen immediately after Form submission - this is what Form actions are for. This might include communications with the Contact, tracking, internal notifications, or other Contact management tasks.

- **Add to Company's Score**: if a Contact associated with a Company record in Mautic has submitted the Form, you can add or subtract Points to the Company's overall score. Company scoring in Mautic doesn't aggregate Points for all its associated Contacts. Any actions that you want to contribute to a Company's score must be explicitly set. Negative numbers are valid if you want to subtract from a Company's score based on a Contact submitting a Form. If the Contact isn't tracked and the Form doesn't include a field mapped to Company or Company Name - on the Company object - the Company has no Points awarded.

  :width: 600
  :alt: Screenshot showing the add to Company score Form action.

- **Adjust Contact's Points**: this action allows you to add, subtract, multiply or divide a Contact's score. Select the operator and the amount to change the Points by - for example: add 10, subtract 5, multiply by 3, divide by 2. If the Form is collecting information which doesn't identify the Contact, Mautic saves the Points to the anonymous Contact record. If that anonymous Contact record converts to or merges with a know Contact record based on some identifying event such as a Form submission, the Points stay with the Contact.

  :width: 600
  :alt: Screenshot showing the adjust Contact score Form action.

- **Modify Contact's Segments**: this action allows you to change a Contact's Segment membership when they submit a Form. Type in the name of the Segment to add the Contact to or remove the Contact from. You can use both fields at the same time, and can include multiple Segments in either or both fields.

Dynamic Segments based on filters update based on information in the Contact record automatically - you don't need add them to the Segment in a Form action.

Typically you would use a Form action to populate static Segments - Segments which don't have any filters set. An example of when you might want to remove a Contact from a Segment in a Form action is for an event registration. You can build a filter-based Segment for the invitation Campaign, but once the Contact submits the registration Form you remove them from that Segment and added to a Segment for event attendees, so that they don't receive any more invitation Emails.

  :width: 600
  :alt: Screenshot showing the modify Contact's Segments Form action.

- **Modify Contact's Tags**: if you use Tags in Mautic, you might want to add or remove Tags from a Contact following a Form submission. To add or remove a Tag you have used before, select the Tag from the list displayed when clicking into the field. To find a Tag, start to type the name in the box. To add a new Tag, type the full name and press Enter on your keyboard to save the Tag.

  :width: 600
  :alt: Screenshot showing the modify Contact's Tags Form action.

- **Record UTM Tags**: if the page your Form is on has UTM tags, whether it's a Mautic Landing Page or an external website, Mautic can record those UTM Tags and save them to the Contact record for reporting. This is useful if you want to run Reports on where your new Contacts and Form submissions are originating from.

  :width: 600
  :alt: Screenshot showing the record UTM Tags Form action.


- **Remove Contact from Do Not Contact list**: this Form action allows you to remove a Contact from the Do Not Contact list when they submit a Form. Use this if a Contact has at some time unsubscribed from your Email list, and by filling out the Form, are giving you permission to Email them again.

  :width: 600
  :alt: Screenshot showing the remove from Do Not Contact list Form action.


- **Download an Asset**: this option triggers an immediate download of the selected file when the Contact submits the Form. If you use Categories to organize your Assets, you can elect to have them download the most recently published Asset in a selected Category. If you prefer, you can link to a specific Asset.

  :width: 600
  :alt: Screenshot showing the download an Asset Form action.

- **POST results to another Form**: use this option to connect your Mautic Form with some other Form. You may have Forms in other tools which you use for tracking and reporting, or back-end Forms triggering software instance creation.

Enter the URL where the Form should post to, and Email address/s for anyone who should receive error notifications. If the Form you are posting to is behind a firewall, also enter the authorization header. If the field aliases - machine names - for any fields don't match, enter the alias the other Form uses for any fields on the Mautic Form.

  :width: 600
  :alt: Screenshot showing the post to another Form action.

- **Push Contact to Integration**: once a Contact submits the Form, you may need to push them into another piece of software you are using for Contact management - such as a CRM. Ensure that the Plugin you want to use to push the Contacts is already configured and published, then select it in the dropdown field.

  :width: 600
  :alt: Screenshot showing the push to Integration Form action.

- **Send Email to Contact**: to directly Email the Contact after they submit the Form, use this option. Select a Template Email from the list, or click New Email to build a new one. After selecting an Email, you can also make edits to the Email in a popup window and preview the Email.

  :width: 600
  :alt: Screenshot showing the send Email to User Form action.

- **Send Email to User**: to Email an internal User of Mautic after a Contact submits a Form. Select the Mautic User from the dropdown. Similar to the Send Email to Contact option, select the Template Email or create a new one. Mautic replaces any tokens in the display with the data from the Contact, not the User.

  :width: 600
  :alt: Screenshot showing the send Email to User Form action.

- **Send Form results**: this feature is commonly used for the purposes of a notification when a Contact submits a Form. It can also send a notification to the Contact of the data provided. Be sure to customize the subject line to state which Form the submission relates to. The Reply to Contact option sets the ``reply-to`` address to the Contact's address, so that if the notification is sent to your team, replying will go to the Contact automatically.

If you have Contact Owners set in Mautic, you can also send the notification directly to the Contact's owner. It's also possible to send a copy of the Email to the Contact.

You can style the message itself as you like, and you can click to insert the submitted values from the Form using tokens. You must add the fields to the Form before creating the action. If adding new fields after creating the Form action, edit the Form action and add the new tokens to the Email.

  :width: 600
  :alt: Screenshot showing the send Form results action.


Adding Forms to Pages


There are several ways to add your Mautic Forms to Landing Pages or Websites.


Shortcodes


When working with Mautic Landing Pages or common Content Management Systems (CMS) including **Drupal**, **Joomla!** or **WordPress**, you can use a shortcode. In each case, replace ``ID#`` with the Mautic Form's ID number, found in the list of Forms or when viewing or editing a Form, the ID is at the end of the URL. This option uses JavaScript, which means that your embedded Form is always up to date with any changes made on your Mautic Form.

- **Mautic Landing Page**: ``{form= ID#}``
- **Drupal 7.x**: ``{mauticform id =ID# width=300 px height=300 px}`` - be sure to change the width and height to the appropriate size for your website.

  This shortcode doesn't work for Drupal 8.x - it's recommended to use the Embedded option instead.

- **Joomla!**: ``{mauticform ID#}``
- **WordPress**: ``[mautic type=\"form\" id=ID#]``

Embedded

  :width: 600
  :alt: Screenshot showing the options for embedding a Mautic Form.

The Embedded option for embedding Mautic Forms uses JavaScript and ensures that the Forms on your website are always up to date with what you have set in Mautic. If you make changes to the Form in Mautic, you don't have to worry about re-copying the Form code everywhere you use the Form. Features including auto-fill and progressive profiling **only** works with the Embedded option.

  Before copying the code to embed your Mautic Forms, ensure that you are on the correct domain name - not a staging area or internal reference for example - as the Form embed code references the URL.

Via JavaScript

Other than using shortcodes with a CMS Plugin, this is the recommended method for embedding your Mautic Forms. Copy the line of code in the box and paste it into your website where you want the Form to display.


Via IFrame


IFrames can be more difficult to use, and blocking by browsers is more likely, however there are sometimes where using an IFrame is preferable. Be sure to adjust the width and height for the space required to fit the Form. The visitor may need to scroll within the IFrame depending on the resolution of their browser. It's possible to display an error message in the event that the visitor's browser doesn't support IFrames, by editing the text between the ``<p>`` and ``</p>`` tags before copying the code and pasting it into your website.

Self-hosted

  :width: 600
  :alt: Screenshot showing the options for manually embedding a Mautic Form.

The Self-hosted option does provide more flexibility to extend Forms with JavaScript snippets and custom styling, however it's a manual process and any changes made within Mautic after copying the code won't be automatically reflected on your website unless you re-copy and paste the new HTML code.

  Before copying the code to embed your Mautic Forms, ensure that you are on the correct domain name - not a staging area or internal reference for example - as the Form embed code references the URL.

#. Copy the JavaScript code in the first box, and paste it into the head or body of your page. If you have multiple Mautic Forms on the same page, add this once only.
#. Copy the HTML code in the second box, and paste it where you wish to display the Form.
#. If you have Render Style set to Yes in the Form, the code includes the styling. If you have Render Style set to No, there is no styling included with the code, and the Form styling comes from the CSS from your website.


Creating conditional Form fields


Mautic allows you to create conditional fields within Forms. This allows you to manage a set of dependencies between fields, so that the fields display only with certain conditions.

To create conditional fields, you must first create any :doc:`/contacts/custom_fields` and use these fields within a Form.


Creating Custom Fields


Using an example of wanting to show specific types of car based on the manufacturer, you would create the following Custom Fields:

- **Car manufacturer**: this field should be of the Select data type. In this example, the options for this field are Ford, Nissan, Peugeot, and Fiat.
- **Ford cars**: this field should be of the Select - Multiple data type. In this example, the available options for this field are Focus, Mustang, Fiesta, and Galaxy.

Adding conditional fields to a Mautic Form

Once you have created the required Custom Fields, add the parent field to the Form as detailed previously, and add the relevant information in the tabs.

  When using conditional fields, only ``Select``, ``Select - Multiple`` and ``Boolean`` field types are valid as the parent field.

  :width: 600
  :alt: Screenshot showing the parent field for a conditional field on a Mautic Form

If you have defined the values in the Custom Field, turn the first switch to Yes to use those values. Otherwise, create the labels and values in the Properties tab. You can also associate the Form Field with a Contact field where appropriate.

  :width: 600
  :alt: Screenshot showing the configuration of a parent field

Once saved, an option displays to add a conditional field.

  :width: 600
  :alt: Screenshot showing option to add a field based on the value of an existing field

In this example, select the ``Checkbox Group`` option, and under the Condition tab, choose ``including`` and ``Ford``.

  :width: 600
  :alt: Screenshot showing selection of parent field

This means that when the visitor selects Ford, the Form displays this field.

There are two options:

- **including**: if you want the child field to appear only if the selected value on the Form for the parent field **does match** the value/s specified
- **excluding**: if you want the child field to appear only if the selected value on the Form for the parent field **doesn't match** the value/s specified

It's possible to set Any value to Yes, then the child field shows for any value of the parent field. This removes the filters to select an option.

Map the field to a Contact field as appropriate, and under the Properties tab, either select to use the options in the Custom Field, or specify labels and options.

Once saved, the Form displays the conditional field nested underneath the parent field.

  :width: 600
  :alt: Screenshot showing child field nested underneath the parent field

Blocking Form submissions from specified domains

Sometimes it's necessary to block certain domains from submitting Forms - for example to restrict access to proprietary content and reduce the volume of unqualified Contacts.

Configuring blocked domains

To configure globally blocked domains - applying to all Forms in your Mautic instance - go to the Forms section in :doc:`/configuration/settings`.

  :width: 600
  :alt: Screenshot showing global domain blocking

Specify domains, one per line, using either full Email addresses or entire domains using an asterisk before the domain name, which acts as a wildcard. Ensure you save your changes.


Applying domain name filtering to a Form

To apply domain name filtering on a Mautic Form, add an Email field to the Form - after setting up the domain exclusions in the previous step - and under the Validation tab, set the Domain name submission filter switch to Yes.

  :width: 600
  :alt: Screenshot showing domain blocking used in a Mautic Form

It's advised to provide a helpful message to display if the visitor tries to use an Email address from a blocked domain, to help them understand what the problem is.""",
    ),

    AppLesson(
      title: "Landing Pages",
      body: r"""Landing Pages


Customizing the Preference Center




Landing Page drafts

Creating a draft Landing Page


Mautic allows the creation of Landing Page Drafts using the 'Save as Draft' button in the Landing Page editor.

This feature needs turning on by adding the configuration parameter ``page_draft_enabled`` to your ``local.php`` configuration file as detailed below.


  'page_draft_enabled' => 1

Once turned on, the 'Save as Draft' button appears on the Landing Page edit interface.

  :width: 400
  :alt: Screenshot showing the 'Save as Draft' button on the Landing Page edit interface.

Only one Draft at a time can exist for any given Landing Page. When working with a Draft, the 'Save as Draft' button instead displays two buttons, 'Apply Draft' and 'Discard Draft'.

  :width: 400
  :alt: Screenshot showing the 'Apply Draft' and 'Discard Draft' buttons on the Landing Page edit interface.

You can only change the content of the Landing Page itself when it's in Draft. Changes to the Subject, Internal Name, selected Segment, etc. apply to the original Landing Page even when editing a Draft version of it. The Draft content exists separately from the original Landing Page.


Previewing a Draft Landing Page


You can preview a Landing Page Draft may by appending ``/draft`` to the end of the Landing Page preview URL. If an Landing Page has a Draft version, a Draft Preview URL is present on the Landing Page details overview, below the regular Preview URL.

  :width: 400
  :alt: Screenshot showing the Preview Draft URL link on the Landing Page edit interface.""",
    ),

  ],
),

AppCourse(
  id: "marketing_8",
  title: "Configuration",
  description: "Configuration",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "8 Lessons",
  lessons: [
    AppLesson(
      title: "Command Line Interface",
      body: r"""Command Line Interface (CLI) commands


Mautic may require you to use the command line (CLI). Listed below are the available CLI commands.


  You can find this list (and others - for example commands relating to Doctrine and other vendors) by running this command: ``bin/console``

  You must be in the Mautic root directory to run the CLI commands.

**Format**: command [options] [arguments]

Options


   :widths: 50 50
   :header-rows: 1

   * - Options
     - Description
   * - -h, \\--help
     - Display this help message
   * - -q, \\--quiet
     - Do not output any message
   * - | V, \\--version
       |  \\--ansi
       |  \\--no-ansi
     - | Display this app version
       | Force ANSI output
       | Disable ANSI output
   * - -n, \\--no-interaction
     - 	Do not ask any interactive question
   * - | -s, \\--shell
       |  \\--process-isolation
     - | Launch the shell.
       | Launch commands from shell as a separate process.
   * - | -e, \\--env=ENV
       |  \\--no-debug
     - | The Environment name. [default: \"prod\"]
       |  Switches off debug mode.
   * - | -v
       | -vv
       | -vvv
       |  \\--verbose
     - | Increase the verbosity of messages:
       | 1. for normal output,
       | 2. for more verbose output and
       | 3. for debug



Mautic commands
These are the commands you may need to use in relation to your Mautic instance. Add a ``bin/console`` before Mautic command.

**Example**


  bin/console mautic:segments:update


   :widths: 25 50 25
   :header-rows: 1

   * - Command
     - Description
     - Aliases
   * - ``mautic:assets:generate``
     - Combines and minifies Asset files (CSS/JS) from each bundle into single production files
     -
   * - ``mautic:broadcasts:send``
     - Process Contacts pending to receive a Channel broadcast.
     -
   * - ``mautic:campaigns:execute``
     - Execute specific scheduled events.
     -
   * - ``mautic:campaigns:rebuild``
     - Rebuild Campaigns based on Contact Segments.
     - ``mautic:campaigns:update``
   * - ``mautic:campaigns:trigger``
     - Trigger timed events for active Campaigns.
     -
   * - ``mautic:campaigns:validate``
     - Validate if a Contact has been inactive for a decision and execute events if so.
     -
   * - ``mautic:citrix:sync``
     - Synchronizes registrant information from Citrix products
     -
   * - ``mautic:cache:clear``
     - Clears Mautic cache, by using this command, you will erase the 10-minute Mautic cache, which contains things like segment counts and data for dashboard widgets.
     -
   * - ``mautic:contacts:deduplicate``
     - Merge Contacts based on same unique identifiers
     -
   * - ``mautic:contacts:scheduled_export``
     - Processes exports of Contacts to a CSV file and sends the results via Email.
     -
   * - ``mautic:custom-field:create-column``
     - Creates the actual column in the table if the `create_custom_field_in_background` config option is set to true.
     -
   * - ``mautic:custom-field:delete-column``
     - Deletes the actual column in the table if the `create_custom_field_in_background` config option is set to true.
     -
   * - ``mautic:email:fetch``
     - Fetch and process monitored Email.
     -
   * - ``messenger:consume email``
     - Processes mail queue
     -
   * - ``mautic:fields:analse``
     - Analyze Custom Fields table and return table or file with results. See :doc:`/contacts/custom_fields`.
     -
   * - ``mautic:import``
     - If the CSV import is configured to run in background then this command will pick up the pending import jobs and imports the data from CSV files to Mautic.
     -
   * - ``mautic:integration:fetchleads``
     - Fetch Contacts from Integration.
     - ``mautic:integration:synccontacts``
   * - ``mautic:integration:pipedrive:fetch``
     - Pulls the data from Pipedrive and sends it to Mautic
     -
   * - ``mautic:integration:pipedrive:push``
     - 	Pushes the data from Mautic to Pipedrive
     -
   * - ``mautic:integration:pushleadactivity``
     - Push Contact activity to Integration.
     - ``mautic:integration:pushactivity``
   * - ``mautic:install:data``
     - Installs data
     -
   * - ``mautic:iplookup:download``
     - Fetch remote datastores for IP lookup services that leverage local lookups.
     -
   * - ``mautic:maintenance:cleanup``
     - Cleans up older data.
     -
   * - ``mautic:remove:anonymous_contacts``
     - Removes all annonymous contacts from segment and campaign memberships.
     -
   * - ``mautic:messages:send``
     - Process sending of messages queue.
     - ``mautic:campaigns:messagequeue``, ``mautic:campaigns:messages``
   * - ``doctrine:migrations:generate``
     - Generate a blank migration class.
     -
   * - ``mautic:plugins:reload``
     - Install, reloads or updates Plugins.
     - ``mautic:plugins:install``, ``mautic:plugins:update``
   * - ``mautic:queue:process``
     - Process queues
     -
   * - ``mautic:reports:scheduler``
     - Processes scheduler for Report's export
     -
   * - ``mautic:segments:update``
     - Update Contacts in smart Segments based on new Contact data.
     - ``mautic:segments:rebuild``
   * - ``mautic:segments:stat``
     - Outputs table of all Segments and whether they are being used in Campaigns, Emails, other Segments, Form actions and SMS. Useful to detect Segments that can be deleted to save resources on rebuilds.
     -
   * - ``mautic:theme:json-config``
     - Converts Theme config to JSON from PHP
     -
   * - ``mautic:unusedip:delete``
     - Deletes IP addresses that aren't used in any other database table
     -
   * - ``mautic:update:apply``
     - Updates the Mautic app.
     -
   * - ``mautic:update:find``
     - Fetches updates for Mautic
     -
   * - ``mautic:webhooks:process``
     - Process queued Webhook payloads
     -
   * - ``social:monitor:twitter:hashtags``
     - Looks at the monitoring records and finds hashtags.
     -
   * - ``social:monitor:twitter:mentions``
     - Searches for mentioned tweets
     -


Doctrine commands

   :widths: 50 50
   :header-rows: 1

   * - Command
     - Description
   * - ``doctrine:fixtures:load``
     - Installs Mautic sample data, overwriting existing data.""",
    ),

    AppLesson(
      title: "Cron Jobs",
      body: r"""Cron jobs



    Mautic 3 introduced a new path for cron jobs ``bin/console`` - if you are using the legacy Mautic 2.x series you should replace this with the older version, ``app/console``

Mautic requires a few :xref:`cron jobs` to handle some maintenance tasks such as updating Contacts or Campaigns, executing Campaign Actions, sending Emails, and more.
You must manually add the required cron jobs to your server.
Most web hosts provide a means to add cron jobs either through SSH, cPanel, or another custom panel.
Please consult your host's documentation/support if you are unsure on how to set up cron jobs.

If you're new to Linux or Cron Jobs, then the Apache Foundation has :xref:`an excellent guide` which you should read before asking questions via the various support Channels.

When setting up cron jobs, you must choose how often you want the cron jobs to run. Many shared hosts prefer that you run scripts every 15 or 30 minutes and may even override the scheduled times to meet these restrictions. Consult your host's documentation if they have such a restriction.

**It's HIGHLY recommended that you stagger the following required jobs so as to not run the exact same minute.**

For instance:


    - 0,15,30,45 <— mautic:segments:update
    - 5,20,35,50 <— mautic:campaigns:update
    - 10,25,40,55 <— mautic:campaigns:trigger

Required

Mautic needs some mandatory cron jobs to run on a regular basis as follows:

Segment cron jobs

**To keep the Segments current:**


    php /path/to/mautic/bin/console mautic:segments:update

By default, the script processes Contacts in batches of 300. If this is too many for your server's resources, use the option ``--batch-limit=X`` replacing X with the number of Contacts to process each batch.

You can also limit the number of Contacts to process per script execution using ``--max-contacts`` to further limit resources used.


Campaign cron jobs


**To keep Campaigns updated with applicable Contacts:**


    php /path/to/mautic/bin/console mautic:campaigns:update

By default, the script processes Contacts in batches of 300. If this is too many for your server's resources, use the option ``--batch-limit=X`` replacing X with the number of Contacts to process each batch.

You can also limit the number of Contacts to process per script execution using ``--max-contacts`` to further limit resources used.

**To execute Campaigns events:**


    php /path/to/mautic/bin/console mautic:campaigns:trigger

By default, the script processes Contacts in batches of 100. If this is too many for your server's resources, use the option ``--batch-limit=X`` replacing X with the number of events to process each batch.

You can also limit the number of Contacts to process per script execution using ``--max-events`` to further limit resources used.

Since Mautic 5.1, Mautic triggers Campaigns in order from newest to oldest. This allows you to process newer Campaigns with higher priority.


**To send frequency rules rescheduled marketing Campaign messages:** Messages marked as *Marketing Messages* - such as Emails as part of a marketing Campaign - get held in a message queue IF frequency rules are setup as either system wide or per Contact. To process this queue and reschedule sending these messages, add this cron job:


``mautic:messages:send``


    that these messages are only added to the queue when frequency rules apply either system wide or per Contact.


Custom Field cron jobs


**To keep Contacts and Company Custom Fields updated**


    php /path/to/mautic/bin/console mautic:custom-field:create-column
    php /path/to/mautic/bin/console mautic:custom-field:delete-column

Optional

Depending on your server configuration, you can set up additional cron jobs that are optional for tasks such as sending Emails, importing Contacts, and more. The optional cron jobs are as follows:


Process Email queue cron job


If the system configuration queues Emails, a Cron job processes them. If you plan to run ``messenger:consume`` using a Cron job, you should include at least one of these parameters: ``--memory-limit``, ``--limit`` - the number of emails, or ``--time-limit``. This starts a long-lived process and continues to run without one of these parameters.


    php /path/to/mautic/bin/console messenger:consume email --time-limit=160


Fetch and process Monitored Email cron job


If you are using Bounce Management, set up the following command to fetch and process messages:


    php /path/to/mautic/bin/console mautic:email:fetch


Social Monitoring cron job


If you are using Social Monitoring, add the following command to your cron configuration:


    php /path/to/mautic/bin/console mautic:social:monitoring


Import Contacts cron job


To import an especially large number of Contacts or Companies in the background, use the following command:


    php /path/to/mautic/bin/console mautic:import

The time taken for this command to execute depends on the number of Contacts in the CSV file. However, on successful completion of the import operation, a notification appears on the Mautic dashboard.


Export Contacts cron job


To export Contacts to CSV - sending the results via Email - use the following command:


    php /path/to/mautic/bin/console mautic:contacts:scheduled_export

The time taken for this command to execute depends on the number of Contacts in the CSV file. However, on successful completion of the export operation, Mautic sends an email with the link to download the CSV.

Webhooks cron job

If the Mautic configuration settings include Webhook batch processing, use the following command to send the payloads:


    php /path/to/mautic/bin/console mautic:webhooks:process


Since Mautic 5.1 it's also possible to run the Webhooks cron job in 'range mode'. This allows you to specify a range of Webhook events to process in a single run. This can be useful if you have a large number of Webhook events to process and want to avoid running out of memory.

To use this mode, you can specify the ``--min-id`` and ``--max-id`` options. For example, to process events for a Webhook with ID of 5, you can specify to only process the events for that Webhook with IDs between 1000 and 2000 using the following command:


    bin/console mautic:webhooks:process --webhook-id=5 --min-id=1000 --max-id=2000



Update MaxMind GeoLite2 IP database cron job


Mautic uses :xref:`MaxMind's` GeoLite2 IP database by default.
The database license is :xref:`Creative Commons Attribution-ShareAlike 3.0 Unported License` and thus Mautic can't include it within the installation package.
It's possible to download the database manually through Mautic's Configuration or automatically using the following script. MaxMind updates their database the first Tuesday of the month.



    php /path/to/mautic/bin/console mautic:iplookup:download

Clean up old data cron job

Clean up a Mautic installation by purging old data. Note that you can't purge some types of data within Mautic.
Currently supported are audit log entries, visitors - anonymous Contacts - and visitor Landing Page hits. Use ``--dry-run`` to view the number of records impacted before making any changes.

Use the ``--gdpr`` flag to delete data to fulfill GDPR European regulation. This deletes Contacts that have been inactive for 3 years.

**This permanently deletes data. Be sure to verify database backups before using as appropriate.**


    php /path/to/mautic/bin/console mautic:maintenance:cleanup --days-old=365 --dry-run

MaxMind CCPA compliance cron job

MaxMind requires Users to keep a \"Do Not Sell\" list up to date, and remove all data relating to those IP addresses in the past from MaxMind.

See more details in the official :xref:`MaxMind website`.

It's recommended to run these two commands once per week, one after another.


    php /path/to/mautic/bin/console mautic:donotsell:download

This command downloads the database of Do Not Sell IP addresses from MaxMind.


    php /path/to/mautic/bin/console mautic:max-mind:purge

This command finds data in the database loaded from MaxMind's Do Not Sell IP addresses and deletes the data.


Send scheduled broadcasts (Segment Emails) cron job


Starting with Mautic 2.2.0, it's now possible to use cron to send scheduled broadcasts for Channel communications. The current only implementation of this is for Segment Emails. Instead of requiring a manual send and wait with the browser window open while AJAX batches over the send, it's possible to use a command to initiate the process.

The caveat for this is that the Email must have a published up date and be currently published - this is to help prevent any unintentional Email broadcasts. Just as it was with the manual/AJAX process the message is only sent to Contacts who haven't already received the specific communication. This command sends messages to Contacts added to the source Segments later, so if you don't want this to happen, set an unpublish date.


    php /path/to/mautic/bin/console mautic:broadcasts:send [--id=ID] [--channel=CHANNEL]

Command parameters:

- ``--channel=email`` what Channel to execute. Defaults to all Channels if none provided.

- ``--id=X`` is what ID of Email, SMS or other entity to send.

- ``--limit=X`` is how many Contacts to pull from the database for processing, set to 100 by default. Using this flag each time the cron fires, it processes X Contacts. The next time the cron job runs, it processes the following X Contacts, and so on.

- ``--batch=X`` controls how many Emails processed in each batch. This can be different for every provider. For example, Mautic has API connection to SparkPost. Their API can send - at present - 1000 Emails per call. Therefore the batch should be 1000 for the fastest sending speed with this provider. Many SMTP providers can't handle 1000 emails in one batch, so this would need to be lower.

- ``--min-contact-id`` and ``--max-contact-id`` allows the separation of Email sending by smaller chunks, by specifying contact ID ranges. If those ranges won't overlap, this allows you to run several broadcast commands in parallel.


Send scheduled Reports cron job


Starting with Mautic 2.12.0, it's now possible to use cron to send scheduled Reports.


    php /path/to/mautic/bin/console mautic:reports:scheduler [--report=ID]


    for releases prior to 1.1.3, it's required to append ``--env=prod`` to the cron job command to ensure commands execute correctly.


Configure Mautic Integration cron jobs


To perform synchronization of all Integrations and to manage Plugins, use the cron job commands in this section.

**To fetch Contacts from the Integration:**


    php /path/to/mautic/bin/console mautic:integration:fetchleads

or


    php /path/to/mautic/bin/console mautic:integration:synccontacts

**To push Contact activity to an Integration:**


    php /path/to/mautic/bin/console mautic:integration:pushactivity

or


    php /path/to/mautic/bin/console mautic:integration:pushleadactivity

These commands work with all available Plugins. To avoid performance issues when using multiple Integrations, you must specify the name of the Integration by adding the ``-integration`` suffix to the command. For instance, for integration of Mautic with HubSpot, use the following command:


    php /path/to/mautic/bin/console mautic:integration:fetchleads --integration=Hubspot
    php /path/to/mautic/bin/console mautic:integration:pushactivity --integration=Hubspot

**To install, update, turn on or turn off Plugins:**


    php /path/to/mautic/bin/console mautic:plugins:reload


    you can replace ``mautic:plugins:reload`` with ``mautic:plugins:install`` or ``mautic:plugins:update``.
    They're the same commands with different alias.

Exclude processed entities

This feature is particularly useful for managing data and ensuring that entities aren't processed multiple times unnecessarily. The ``--exclude`` option prevents the specified action from re-processing entities that it has already processed.. This option is available for the ``mautic:campaigns:trigger``, ``mautic:campaigns:rebuild``, and ``mautic:segments:update`` commands.


    php /path/to/mautic/bin/console mautic:campaigns:trigger --exclude


    This is particularly useful for scenarios where you want to avoid redundant processing of entities, such as preventing a Campaign or Segment action from executing multiple times for the same Contact.

Tips & troubleshooting

If your environment provides a command-line specific build of PHP, often called ``php-cli``, you may want to use that instead of ``php`` as it has a cleaner output. On BlueHost and probably some other PHP hosts, the ``php`` command might be setup to discard the command-line parameters to ``console``, in which case you must use ``php-cli`` to make the cron jobs work.

To assist in troubleshooting cron issues, you can pipe the output of each cron job to a specific file by adding something like ``>>/path/to/somefile.log 2>&1`` at the end of the cron job, then you can look at the contents of the file to see the output.

If an error is occurring when running run the cron job this file provides some insight, otherwise the file is empty or has some basic stats. The modification time of the file informs you of the last time the cron job ran. You can thus use this to determine whether the cron job is running successfully and on schedule.

In addition it's recommended to enable the non-interactive mode together with the no-ansi mode when you run your commands using cron. This way you ensure, that you have proper timestamps in your log and the output is more readable.

Example output


    php /path/to/mautic/bin/console mautic:segments:update --no-interaction --no-ansi
    [2016-09-08 06:13:57] Rebuilding contacts for segment 1
    [2016-09-08 06:13:57] 0 total contact(s) to be added in batches of 300
    [2016-09-08 06:13:57] 0 total contact(s) to be removed in batches of 300
    [2016-09-08 06:13:57] 0 contact(s) affected

If you have SSH access, try to run the command directly to Select for errors. If there is nothing printed from either in a SSH session or in the cron output, verify in the server's logs. If you see similar errors to ``'Warning: Invalid argument supplied for foreach()' in /vendor/symfony/console/Symfony/Component/Console/Input/ArgvInput.php:287``, you either need to use ``php-cli`` instead of ``php`` or try using ``php -d register_argc_argv=On``. `""",
    ),

    AppLesson(
      title: "Maxmind License",
      body: r"""MaxMind license

From the :xref:`2.16 release`, Mautic has supported using a license key to access the MaxMind IP lookup service.


    From the 3.2 release the format for the license key needs to be ``AccountID:Licensekey``. You can locate the Account ID directly preceding the license keys table.

Follow these steps to configure your Mautic instance to use the license key.

1. Create a MaxMind account by going to :xref:`MaxMind Signup`

2. After signing up, verify your Email and follow the steps to access your :xref:`MaxMind Account`.

3. Click the Contact icon at the top right of the menu to login

  :width: 600
  :alt: Screenshot of MaxMind Account

4. After logging in, under services click ``My License Key`` on the left hand side in the menu

  :width: 600
  :alt: Screenshot of MaxMind license key

5. Then, Click ``Generate new License Key``

  :width: 600
  :alt: Screenshot of MaxMind Generate key

6. Answer ``Will this key be used for GeoIP Update?`` with No and confirm

  :width: 600
  :alt: Screenshot of MaxMind confirm key

7. Copy the license key that you see on the screen and note down the Account ID preceding the license key table

  :width: 600
  :alt: Screenshot of MaxMind license key

8. Go to Mautic > Settings > Configuration > System Settings > Miscellaneous Settings and enter the license key into the \"IP lookup service authentication\" **field in the format** ``AccountID:Licensekey``.

  :width: 600
  :alt: Screenshot of MaxMind license key

9. Click ``Fetch IP Lookup Data Store``. This downloads the IP lookup database to your Mautic instance.

10. Set up the :ref:`cron jobs` to periodically download a fresh copy.""",
    ),

    AppLesson(
      title: "Settings",
      body: r"""Mautic configuration settings

Proper configuration is important for branding, performance, and the User experience for your team as they do their jobs.
These settings mostly don't need changing after initial configuration.

System settings

General settings

  :width: 600
  :alt: Screenshot showing General Settings Configuration in Mautic

* **Site URL** - This is where Mautic is physically installed. Set the URL for this site here. Cron jobs needs this to correctly determine absolute URLs when generating links for Emails, etc. It 's also called Mautic's 'base URL'.

* **Mautic's root URL** - When a User signs in to their Mautic instance, they go to ``mautic.example.com``. However, that Landing Page is also accessible to the public. If a Contact visits that address, they see the Mautic login page for that instance.

  To brand that Landing Page, create a Mautic Landing Page that you'd want to greet any Contacts who visit your root ``URL``. Once you've done that, Users can sign in into Mautic by visiting ``mautic.example.com/s/login``.

* **404 page** - Select the Landing Page that you want to use as the 404 Landing Page. If you don't want to use Mautic's default 404 error page, create a custom Landing Page and select that Landing Page here. If you don't select any page, Mautic uses the default error page.


* **Path to the cache, log, and images directory** - These are the file system paths where Mautic saves the cache, logs, and images.

System defaults

  :width: 600
  :alt: Screenshot showing System defaults Settings Configuration in Mautic


* **Default item limit per page** - The number of Contacts, Campaigns, Emails, Assets, and other items which display on each page when you go to an item section. The default is ``10``.

* **Default timezone** - The User's default time zone, typically set to the time zone of the Company headquarters. Mautic allows the User to set their own time zones via their profile. The default is ``UTC``.

  For example: headquarters is in Boston and Mautic's timezone is ``America/New York``. A User in San Francisco which is Pacific Time may set ``America/Los Angeles`` to use Pacific Time in the User interface.

* **Default language** - The initial language assigned to Users. Individual Users may select their own settings. Mautic uses ``English - United States`` by default.

* **Cached data timeout (minutes)** - Mautic caches data to speed up page loads. Update this setting to change how long Mautic caches the data for. Mautic uses ``10 minutes`` as the default.

* **Date Range Filter Default** - Sets the default for how far back from the current date Mautic looks for data in Reports including Campaign and Email snapshots charts on the item page. This setting allows you to control the default for how far back from the current date Mautic looks for data. If you've changed the setting on a Report, Mautic uses what you've entered. Mautic's default value is ``1 Month``.

* **Default format for full dates, date only, short dates, and time only** - The default setting uses the standard American time format. The letters in the boxes are PHP code. See the :xref:`PHP manual for date functions`.


CORS settings

Cross-Origin Resource Sharing - CORS - allows data to pass between your website and Mautic.

  :width: 600
  :alt: Screenshot showing CORS Settings Configuration in Mautic

* **Restrict Domains** - When set to No, any website can pass information to Mautic. Selecting ``Yes`` to limit communication with your Mautic instance to websites listed in Valid Domains is **strongly recommended**.

* **Valid Domains** - A list of domains allowed to communicate with your Mautic instance. In the text box, list the exact URL of the top level domain you want to allow, one per line. For example: ``http://www.example.com`` tracks any activity on non-secure example.com pages, but ``https://www.example.com`` won't because this is only tracking on a secure ``https://`` website.

* **Trusted hosts** - Explicitly allow hosts that can send requests to Mautic. Enter the domain name where you installed Mautic, such as ``mautic.example.com``. Separate multiple hosts with a comma. You can also use regular expressions for advanced matching, which Mautic encloses with ``/`` delimiters. For instance, ``.*\\.?example.com\$`` becomes ``/.*\\.?example.com\$/``. If left empty, Mautic responds to all hosts.

  Mautic validates your input during the save process. Invalid domain names or regular expression patterns trigger an error message.

  .. caution::

     Incorrect settings can prevent access to your Mautic instance. Getting locked out requires manually editing the database or configuration file to fix the setting.

* **Trusted proxies** - To configure the IP addresses that Mautic should trust as proxies. This setting is mandatory when using Mautic behind an SSL terminating proxy. Separate multiple IP addresses by a comma. i.e ``127.0.0.1, 10.0.0.0/8, fc00::/7``


  In the Valid Domains field, don't include a slash at the end. For example, use ``https://www.example.com`` instead of ``https://www.example.com/``.

Miscellaneous settings

  :width: 600
  :alt: Screenshot showing Miscellaneous Settings Configuration in Mautic

* **IP lookup service** - By default, Mautic uses :xref:`MaxMind's` database to identify the city of a website visitor, based on the location of the Internet Service Provider - ISP - for their IP address.

* **IP lookup service authentication** - To use any IP lookup service which requires authentication, enter your credentials.

* **List of IPs not to track Contacts with** - To turn off tracking for particular IP addresses, enter the addresses, one per line. Mautic doesn't recommend adding your office IP address. If you list your internal IP address, Mautic won't track clicks, page hits, etc., from that IP, **including when you are testing** which can cause difficulties.

* **List of known Bots** - Mautic has the feature to identify and turn-off tracking for several known bots. To track activity from those bots, remove them from this list. To turn off tracking for other bots, add them here - one per line.

* **URL Shortener** - If you use a URL shortening service like bit.ly for links in SMS messages, enter your access token here.


    For bit.ly, use the following URL structure: ``https://api-ssl.bitly.com/v3/shorten?access_token=[ACCESS_TOKEN]&format=txt&longUrl``

* **Item max lock time** - When a User edits a Campaign, Email, Landing Page, etc., Mautic locks the item to prevent simultaneous edits by other Users. When the initial User saves and closes or cancels out, the item may remain locked for this period of time. The default is ``0 seconds``.

* **Translate page titles** - To translate page titles in the Contact activity history from non-Latin characters to Latin - English - characters.


Update settings

  :width: 600
  :alt: Screenshot showing Update Settings Configuration in Mautic

* **Set the minimum stability level required for updates** - This allows you to receive notifications for early access releases. Always read the release notes before updating to an early access release. Set the minimum stability level required for updates.

* **Update Mautic through Composer [beta]**  - Set to 'Yes' if you update Mautic through Composer. This is a prerequisite if you want to install and update Plugins through the Marketplace. This becomes the default installation and update method in Mautic 5.

Theme settings

  :width: 600
  :alt: Screenshot showing Theme Settings Configuration in Mautic

* **Default Theme** - Applies a Theme to any Form which doesn't have a Theme already applied. If you don't have a Landing Page for your Preference Center, but have preference settings turned on in Email settings, Mautic creates a default Preference Center page using the Form styling from the Theme selected here.

API settings

  :width: 600
  :alt: Screenshot showing API Settings Configuration in Mautic

Complete API documentation is available on the :xref:`Mautic REST API` section in the Developer Documentation.

* **API enabled** - Select Yes to pass data in and out of Mautic through the API.

* **Enable http basic auth?** - Enables basic authentication for Mautic's API. It's recommended to only use this with secure sites (https).

* **Access token lifetime** - When authorizing a new app or Integration, this setting limits how long the access token is valid - in minutes. The default is ``60`` minutes.

  For example - You add a new Integration to your SaaS platform. Enter 30 here to limit the access token validity to ``30`` minutes. If you haven't completed the authentication in that period of time, you must revalidate.

* **Refresh token lifetime** - When using OAuth 2.0, the lifetime of the refresh token used to request a new access token once expired. Once the refresh token expires, you must reauthorize. The default is ``14`` days.

Asset settings

  :width: 600
  :alt: Screenshot showing Assets Settings Configuration in Mautic

* **Path to the Asset directory** - Set the absolute path to the Assets upload folder. In order to prevent the public from accessing Assets, use a directory outside of the public web root.

* **Maximum size Megabytes** - Set the maximum size of uploaded Assets in Megabytes.

* **Allowed file extensions** - Extensions of files separated by commas. You can only upload files with the specified file extensions.

Campaign settings

  :width: 600
  :alt: Screenshot showing Campaign Settings Configuration in Mautic

* **Wait time before retrying a failed action** - If for any reason a Campaign action doesn't execute, this is the length of time Mautic waits before trying again.

* **Use date range for all views** - When viewing a Campaign, the date range of actions, conditions, decisions, and Contacts displayed in the tabs, Mautic uses this date range by default.

* **Use summary statistics** - Improves performance when viewing a Campaign with thousands of events per day by using summarized data. When you first turn on this setting you need to run a :ref:`Cron job<Campaign Cron jobs>` to summarize existing data.

* **Campaign Reactivation Behavior** - Configure how Mautic handles scheduled events with relative delays in the middle of the workflow when you reactivate a Campaign after a period of deactivation. This setting provides a global default that you can override for an individual Campaign. This setting affects how the :ref:`Campaign Cron jobs<Campaign Cron jobs>` schedule events. See :ref:`Campaign reactivation behavior` section for more information.

  Available options:

  * **Count delay regardless of activation state** - Mautic uses the original trigger date. Events execute based on the calendar days in the original schedule, regardless of whether the Campaign was active or inactive during those days. This is the default behavior.

  * **Restart on reactivation** - The delay counter resets when you reactivate the Campaign. Mautic reschedules Events to execute the full delay period starting from the last activation date.

  * **Count delay only while active** - Events only count days when the Campaign remains active. If you deactivate the Campaign, those days don't count toward the delay. Mautic reschedules Events accordingly when you reactivate the Campaign.

Optimal for Contact event scheduler

  :width: 600
  :alt: Screenshot showing Optimal for Contact event scheduler settings configuration in Mautic

The optimal for Contact event scheduler settings allow you to configure the default timing and caching options used in the optimized event scheduler for Campaigns.

* **Default Optimal Start Hour** - Set the default start hour for the optimal interaction window when specific Contact data is unavailable.
* **Default Optimal End Hour** - Set the default end hour for the optimal interaction window when specific Contact data is unavailable.
* **Default Optimal Days** - Select the default days of the week considered optimal for interaction when specific Contact data is unavailable.
* **Interaction Data Cache Timeout** - Choose how long to cache the interaction data for.
* **Fetch Interactions From** - Select the time frame for fetching interaction data. This determines how far back to look for interactions.
* **Interaction Fetch Limit** - Set the maximum number of interactions of each type - for example: Page hits, Email reads, Form submits - to retrieve for timing optimization.

Email settings

Email transport settings

As Mautic uses the :xref:`Symfony Mailer` library since v5, it supports all Symfony Mailer core Plugins out of the box.

SMTP transport

The SMTP transport is the default transport used for sending Emails with Mautic. It's configured in the Mautic configuration under the Email Settings tab. The configuration is the same as in the :xref:`Symfony Mailer` documentation.

Mautic now uses a specific way of providing the connection details for Email transports to interpret, known as a Data Source Name, or DSN. This is the example Data Source Name configuration mentioned in the :xref:`Symfony Mailer` documentation for SMTP:


    smtp://user:pass@smtp.example.com:port

Mautic creates this automatically from the values entered in the Email configuration:

    :width: 400
    :alt: SMTP API DSN example

    :widths: 10 20 150
    :header-rows: 1
    :stub-columns: 1

    * - DSN part
      - Example
      - Explanation
    * - Scheme
      - ``smtp``
      - Defines which transport Plugin handles the Email sending. It also defines which other DSN parts must be present.
    * - User
      - ``john``
      - Some transport wants username and password to authenticate the connection. Some public or private key. Some just API key.
    * - Password
      - ``pa\$\$word``
      - As mentioned previously, read the documentation for your particular transport and fill in the fields it requires. For SMTP enter the password in this field.
    * - Host
      - ``smtp.mydomain.com``
      - For SMTP, this is the domain name where your SMTP server is running. Other transports may have the domain handled within the Plugin, so they may instruct you to enter ``default`` here.
    * - Path
      - ``example/path``
      - This is usually empty. For SMTP this may be the path to the SMTP server. For other transports this may be the path to the API endpoint. Enter according to the documentation for your transport.
    * - Port
      - ``465``
      - Important for SMTP. The port value defines the encryption used. This is usually ``465`` for SSL or ``587`` for TLS. Avoid using port 25 for security reasons. For other transports this may be the port to the API endpoint.
    * - Options
      - ``timeout=10``
      - This is optional. This may be the timeout for the connection or similar configuration. The configuration allows you to create multiple options.

  Use Mautic's global configuration to paste in the DSN information, especially the API keys and passwords. The values must be URL-encoded, and the configuration form does that for you. If you are pasting DSN settings directly into the ``config/local.php`` file, you must URL-encode the values yourself.



Example API transport installation


  Installing Symfony Transports is possible when you've :doc:`installed Mautic via Composer </getting_started/how_to_install_mautic>`.

If you want to use :xref:`SendGrid` API instead of SMTP to send Emails, for example, you can install the official Symfony SendGrid Transport by running the following command mentioned alongside others in the :xref:`Symfony Mailer` documentation.


    composer require symfony/sendgrid-mailer

After that, you can configure the transport in the Mautic configuration. The example DSN is again mentioned in the :xref:`Symfony Mailer` documentation along with other transports. In the example of using the SendGrid API, the DSN looks like this:


    sendgrid+api://KEY@default

This is how you would configure Mautic's Email configuration:

  .. image:: images/sendgrid-api-dsn.png
    :width: 400
    :alt: SendGrid API DSN example

To replace the SendGrid API key, add it to the relevant field in the Email configuration and save. Mautic now uses the SendGrid API to send Emails.

  It's a nice perk that Mautic can use any transport provided by Symfony Mailer. However, be aware that such transports from Symfony **don't support batch sending, even via API**. They only send one Email per request, as opposed to a thousand Emails per request as is the case with some Mautic transports, which can make them slow at scale. They also **don't support transport callback handling used for bounce management**. If you plan to send larger volumes of Emails or need to use features which require callback handling, please consider using Email transports built specifically for such use. These Plugins are available in the :doc:`Mautic Marketplace </marketplace/marketplace>`.

The table below lists available transport Plugins created for Mautic to include support for batch sending and callback handling.


   :widths: 40 60
   :header-rows: 1

   * - Link to Packagist
     - Command for installing
   * - :xref:`sparkpost-transport`
     - ``composer require ts-navghane/sparkpost-plugin``

Configuring the Queue

The system can either send Emails immediately or queue them for processing in batches by a :doc:`Cron job </configuration/cron_jobs>`. Documentation relating to configuring the queue is in the :doc:`queue </queue/queue>` section.

Immediate delivery

This is the default means of delivery. As soon as an action in Mautic triggers an Email to send, it's sent immediately. If you expect to send a large number of Emails, you should use the queue. Sending Email immediately may slow the response time of Mautic if using a remote mail service, since Mautic has to establish a connection with that service before sending the mail. Also attempting to send large batches of Emails at once may hit your server's resource limits or Email sending limits if on a shared host.

Queued delivery

Mautic works most effectively with high send volumes if you use the queued delivery method. Mautic stores the Email in the configured spool directory until the execution of the command to process the queue. Set up a :doc:`Cron job </configuration/cron_jobs>` at the desired interval to run the command:


    php /path/to/mautic/bin/console messenger:consume email

Some hosts may have limits on the number of Emails sent during a specified time frame and/or limit the execution time of a script. If that's the case for you, or if you just want to moderate batch processing, you can configure batch numbers and time limits in Mautic's Configuration. See the :doc:`Cron job documentation </configuration/cron_jobs>` for more specifics.


Mail send settings

  :width: 600
  :alt: Screenshot showing Mail Send Settings Configuration in Mautic

* **Name to send mail as** - The default name Emails come from. This is typically something like ``{YourCompany Marketing Team}`` or ``{YourCompany}``.

* **Email address to send mail from** - The Email address for the name you're sending mail from. The address displays in the ``From:`` field when your Contacts receive your Emails.


  Ensure that you configure your sender domain, ``DKIM``, bounce, and click tracking domains. For more information, see the :ref:`Email<emails>` documentation.

* **Reply to address** -  To have Contacts reply to a different address than the specified From address, add the desired address here. This is the default ``reply-to`` address where messages are sent from Mautic unless it is overridden in an individual Email. If this field is blank, Mautic uses the address specified in **Email address to send mail from**. The ``reply-to`` setting is useful if your configured sender domain - which you use in the from address - contains a subdomain that doesn't have MX records or is otherwise an address that can't receive Emails.

* **Custom return path (bounce) address** - Set a custom return path/bounce Email address for Emails sent from the system. Note that some mail transports, such as GMail, won't support this.

* **Email address length limit** - This setting determines the maximum allowed length for Email addresses, including the display name. The default value is 320 characters. If an Email address - including the display name - exceeds this limit, Mautic uses only the Email address without the display name when sending Emails. This helps prevent errors with Email servers that have strict length restrictions. You can adjust this value if you need to accommodate longer Email addresses or if you want to set a more restrictive limit.

* **Mailer is owner** - If Contacts in Mautic have owners, select Yes to use the Contact owner as the sender of Emails to any Contacts they're listed as the owner for.


    Mailer is owner overrides any other name or Email to send mail from, including the default and individual Emails. Every Contact owner's domain must have ``SPF`` and ``DKIM`` records. You can see this configuration for individual Emails, rather than globally.
    For more information see :doc:`Mailer is owner</channels/emails>`

* **Service to send mail through** - Select the Email service provider you use, and enter your credentials.

For information on configuring S/MIME Email signing to verify Email authenticity, see :doc:`/configuration/smime_email_signing`.

See :ref:`here<contact's unsubscribe email preferences>` to set the Contact's Email subscription preferences.

Default frequency rule

* **Do Not Contact more than <number> each <period>** - This limits the number of Marketing Messages a Contact receives in a certain period of time day, week, month. Transactional messages don't count towards this limit. You can adjust this at the individual Contact level, either manually or by Preference Center setting.

  :width: 600
  :alt: Screenshot showing Default Frequency Rule Configuration in Mautic


  More information is available in the :doc:`Default Frequency Rule documentation</contacts/frequency_rules>`.

Monitored inbox settings

  :width: 600
  :alt: Screenshot showing Monitored Settings Configuration in Mautic

* **Default Mailbox** - If your messages are going to bounce, this inbox is where you receive those bounce notifications.

* **Bounces** - A folder to monitor for new bounce messages or Emails.

* **Unsubscribe Requests** - A folder to monitor for new unsubscribe requests.

* **Contact Replies** - Similar to the monitored inbox for bounces, this is the inbox Mautic checks for Contact replies. Using :ref:`Replies to Email<email settings>` decisions in any Campaign requires configuration. With ``Use custom connection settings?`` set to ``no``, Mautic checks the default mailbox. If set to ``yes``, you may track a different mailbox for replies.

Message settings

  :width: 600
  :alt: Screenshot showing Message Settings Configuration in Mautic

* **Text for the** ``{webview_text``} **token** - The message indicating the reader can view the Email in their browser. The default is; ``Having trouble reading this Email? Click here``.

  To change the text, change the message between the ``<a href=\"|URL|\">`` and ``</a>`` tags. Don't change the ``|URL|`` text, because that's a token, which creates a unique URL for each Contact.

* **Default Email signature** - The signature for your default Emails, which pairs with the name & Email address in the **Mail Send** settings.

* **Append tracking pixel into Email body?** - To track Email opens, select **Yes**. Select **No** to prevent tracking, reporting on, and using decisions based on Email opens.

* **Convert embed images to Base64** - Select **Yes** to display embedded images in Emails using embedded base64 code rather than as embedded images.

* **Disable trackable URLs** - Removes tracking from URLs in your Emails. Select Yes to prevent tracking, reporting on, and using decisions based on link clicks. Some Email service providers don't like redirecting URLs. Using trackable URLs in your Emails may impact deliverability.

Unsubscribe settings

  :width: 600
  :alt: Screenshot showing Unsubscribe Settings Configuration in Mautic

* **Text for the {unsubscribe_text} token** -  Like the ``{webview_text}`` token,  this allows you to customize the **Unsubscribe** link.

  For example - Edit between the ``<a href=\"|URL|\">`` and ``</a>`` tags. Don't change the URL as it's tokenized. If you add ``{unsubscribe_url}`` as a token in the Email, you won't see this text.

* **Unsubscribed and resubscribed confirmation message** - If a Contact unsubscribes or resubscribes, this message displays on the page after the respective action. Don't edit the ``|EMAIL|`` or the ``|URL|`` token in the ``<a href>`` tag.

* **Show Contact preference settings** - Select **Yes** to direct the unsubscribe link to your configured Preference enter. If you haven't created a Preference Center, Mautic creates a default page based on the next 5 settings. The created page uses the default Theme for styling.

* **Show Contact Segment preferences** - Select **Yes** to allow a Contact to change which Segments they're part of on the Preference Center. Segments won't display on the Preference Center if they aren't active and public.

* **Show Contact frequency preferences** - Select **Yes** to allow an individual to limit the number of Marketing Messages they receive on each Channel from the Preference Center.

* **Show pause Contact preferences** - Select **Yes** to allow Contacts to turn-off messages from your Mautic account to their Email address for a specified date range. This action isn't a full unsubscribe action, and at the end of the date range, In this case, it sends the message again after the date range ends, as this isn't a full unsubscribe action.

* **Show Contact's Categories** - If you have Categories set for Contacts, Campaigns, Emails, etc., select Yes to allow the Contact to opt out of the Categories they choose from the Preference Center page.

* **Show Contact's preferred Channel option** - If you have multiple Channels available within your Mautic instance. For example; Email, ``SMS``, mobile push, web notifications, etc., Contacts can choose their preferred Channel. This can be useful if you are using the Marketing Messages feature of Mautic. More information about the Preference Center is available :doc:`here</contacts/preference_center>`.



How to track opened Emails


Mautic automatically tags each Email with a tracking pixel image. This allows Mautic to track when a Contact opens the Email and execute actions accordingly. Note that there are limitations to this technology - the Contact's Email client supporting HTML and auto-loading of images, and not blocking the loading of pixels. If the Email client doesn't load the image, there's no way for Mautic to know the opened status of the Email.

By default, Mautic adds the tracking pixel image at the end of the message, just before the ``</body>`` tag. If needed, one could use the ``{tracking_pixel}`` variable within the body content token to have it placed elsewhere. Beware that you shouldn't insert this directly after the opening ``<body>`` because this prevents correct display of pre-header text on some Email clients.

It's possible to turn off the tracking pixel entirely if you don't need to use it, in the Global Settings.


How to track links in Emails


Mautic tracks clicks of each link in an Email, with the stats displayed at the bottom of each Email detail view under the Click Counts tab.


Form settings

  :width: 600
  :alt: Screenshot showing Form Settings Configuration in Mautic

* **Do not accept submission from these domain names** - To block Contacts with specific Email domains from submitting your Forms, enter those domains in the dialog box. Select an option on each Form you want to apply this block to. You can restrict either specific Email aliases that belong to a domain or an entire domain. To block the entire domain, you can use wildcards (*).

Contact settings


Multiple Company management


   :width: 600
   :alt: Contact Settings section with the 'Enable Multiple Companies' toggle switch set to on.

This setting, when enabled, allows a Contact to link with more than one Company. It's beneficial for businesses that interact with clients across multiple Companies.
When you turn this off, a Contact can only link to one Company. This is ideal for businesses with simpler structures where each Contact only needs a single Company association.

Contact merge settings

  :width: 600
  :alt: Screenshot showing Contact Merge Settings Configuration in Mautic

* **Merge by unique fields with operator** - You can determine which operator to use when merging fields if there is more than one unique identifier.

Contact list settings

  :width: 600
  :alt: Screenshot showing Contact List Settings Configuration in Mautic

* **Columns** - Select from the left which fields appear on the Contact lists (when you go to Contacts in the Mautic and view the list).

To display the fields, select them from the left and move them to the right column, or remove from the right column if you don't want them to appear in the list.

Import settings

  :width: 600
  :alt: Screenshot showing Import Settings Configuration in Mautic

* **Automatically import in the background if the CSV has more rows than defined** - If there are more than the specified number of rows in an import file, the CSV automatically sets to import in the background which requires a :ref:`Cron job<import Contacts Cron job>` to trigger. Set to 0 if you want to always import files in the background recommended for performance optimization.

Export settings

  :width: 600
  :alt: Screenshot showing Export Settings Configuration in Mautic

* **Automatically export Contacts to CSV in the background** - If set to Yes, Mautic processes CSV exports of Contacts in the background and Mautic sends an Email with a link to download the file when it's processed.

Segment settings

  :width: 600
  :alt: Screenshot showing Segment Settings Configuration in Mautic

* **Show warning if Segment hasn't been rebuilt for X hours** - Every time a :ref:`Cron jobs<Segment Cron jobs>` runs, Segments are rebuilt. If there is an error that prevents a Segment from rebuilding, Mautic displays a warning message. This field allows you to configure the allowable length of time between rebuilds, after which the warning message appears.

Company settings

  :width: 600
  :alt: Screenshot showing Company Merge Settings Configuration in Mautic

* **Merge by unique fields with operator** - You can determine which operator to use when merging fields if there is more than one unique identifier.

Queue settings

Purpose of the queuing

Mautic can optionally use a queuing mechanism for sending Emails. This feature is essential when running Mautic **at large scale**. It's planned to extend the tasks that can utilize queuing in the future.

When you enable queuing, Emails are no longer sent immediately - for example, within the browser - but instead, Mautic places them in a queue and sends them later using queue consumers - also known as workers. Using consumers helps to offload the workload of your server, and allows easier scaling of your Mautic instance.

Mautic doesn't use queues by default

A fresh instance of Mautic has **the queuing feature turned off** (the queue DSN configuration is ``\"sync://\"``) as shown in the following screenshot.

  :width: 600
  :alt: Queue turned off

How to enable the queuing

First you need to decide on a queuing transport to drive your queue. There are several options available at the moment. It's up to you to choose which one fits your needs the best.

**Currently available transports:**

* :ref:`Doctrine`
* :ref:`Redis`
* :ref:`AMQP`
* :ref:`Beanstalkd`
* :ref:`Amazon SQS`

Doctrine
This transport is easy to setup as it doesn't require installing any additional extension.

It uses database table ``messenger_messages`` for storing messages - you can change the table name via options. The screenshot below shows the basic settings.

  :width: 600
  :alt: Example of Doctrine transport

See :xref:`queue-doctrine-transport` for the complete list of configuration options.

Redis
This transport requires the Redis PHP extension (>=4.3) and a running :xref:`Redis` server (^5.0). Once met, the typical configuration looks as follows.

  :width: 600
  :alt: Example of Redis transport

See :xref:`queue-redis-transport` for the complete list of configuration options.

AMQP
The AMQP transport requires the AMQP PHP extension and a running AMQP service like :xref:`RabbitMQ` and a Composer dependency installed via ``composer require symfony/amqp-messenger``. See the screenshot below for an example of the configuration.

  :width: 600
  :alt: Example of AMQP transport

See :xref:`queue-amqp-transport` for the complete list of configuration options.

Beanstalkd
The Beanstalkd transport requires a running :xref:`Beanstalkd` service and a Composer dependency installed via ``composer require symfony/beanstalkd-messenger``.
After installing the Composer dependency, you can fill in the configuration as follows.

  :width: 600
  :alt: Example of Beanstalkd transport



See :xref:`queue-beanstalkd-transport` for the complete list of configuration options.


Amazon SQS
The Amazon SQS transport is ideal when hosting your Mautic instance on AWS. You need to install a Composer dependency via ``composer require symfony/amazon-sqs-messenger``. See the example of the configuration below.

  :width: 600
  :alt: Example of Amazon SQS transport

See :xref:`queue-amazon-sqs` for the complete list of configuration options.

How to consume messages from the Queue

To start consuming the messages from the Queue, you need to run the following Symfony command.


    php bin/console messenger:consume email

If you don't use Kubernetes in your environment, use a process manager like ``Supervisor`` or ``systemd`` to keep your worker/s running. More on this at :xref:`queue-consuming-messages`

Advanced setting

Retry strategy

When the processing of a message fails, Mautic sends the message back to the queue for another try. You can adjust this behavior in this section.
See :xref:`queue-retries-failures` for more details.

The screenshot below shows the default values.

  :width: 600
  :alt: Retry strategy defaults

* **Max retries** - The maximum number of times Mautic retries a failed message before giving up. Set to ``0`` to turn off retries. Negative values aren't allowed. The default is ``3``.

* **Delay** - The initial delay in milliseconds before the first retry attempt. Negative values aren't allowed. The default is ``1000``, which is 1 second.

* **Multiplier** - The factor by which the delay increases after each retry attempt. For example, with a delay of 1000 ms and a multiplier of 2, the delays are 1000 ms, 2000 ms, 4000 ms, and so on. Values less than 1 aren't allowed. The default is ``2``.

* **Max delay** - The maximum delay in milliseconds between retry attempts. Set to ``0`` for no limit. Negative values aren't allowed. The default is ``0``.

Queue for failures

If a message fails all its retries, it's discarded by default. To avoid this happening, you can optionally configure a Queue for failures.

For more details see the documentation on :xref:`queue-saving-retrying-failed-messages`.

The screenshot below shows the example of configuring the failure queue using the Doctrine transport.

  :width: 600
  :alt: Example of failure configuration

Notification settings

  :width: 600
  :alt: Screenshot showing Campaign Notification Settings Configuration in Mautic

  :width: 600
  :alt: Screenshot showing Webhook Notification Settings Configuration in Mautic

If a Campaign or Webhook is automatically deactivated because of a high volume of errors, Mautic sends a notification alerting Users.

* **Send notification to author** - Set this field to Yes to send an Email notification to the User who created the deactivated Campaign or Webhook. Deleted Users don't receive notifications.


Landing Page settings


  :width: 600
  :alt: Screenshot showing Landing Page Settings Configuration in Mautic

* **Show Category in Page URL?** - If you use Categories, the Landing Page's associated Category displays in the URL if you select Yes.

* **Analytics script** - To track Landing Page visits and activity in other platforms such as Google Analytics, add those tracking scripts here.

Tracking settings

Mautic tracking settings

  :width: 600
  :alt: Screenshot showing Tracking Settings Configuration in Mautic

* **Tracking code** - Insert this code on any page you would like to have tracked in Mautic before the ending ``</body>`` tag.


    The default tracking code provided in a new instance updates and changes after you set up a new custom domain or when you make changes to an existing one. You must use the new tracking code that reflects the new or edited custom domain. If you are using the Plugin for WordPress, Drupal, or Joomla, re-enter your account information in the Plugin.

* **Anonymize IP** - Select **Yes** to not store full IP addresses for your visitors/Contacts. This setting aids customers in achieving General Data Protection Regulation compliance.

* **Identify visitors by IP** - Select **Yes** to use the IP address to identify Contacts. It's possible to track unidentified visitors with the same IP address as an existing Contact. This may result in undesirable outcomes with large Companies who use the same externally facing IP address.

* **Do Not Track 404 error for anonymous Contacts** - Select **Yes** to not track page hits on any 404 error page tracked by the tracking code. This option helps prevent filling your logs with hits from bots.

* **Append Segment IDs to Tracking URLs** - Select **Yes** to enable Mautic to append Segment IDs to the tracking URLs in Emails sent from Mautic. This allows Mautic to track which Segment a Contact belongs to when they click a link in an Email.


  * The tracking code automatically detects the Preferred Timezone and Preferred Locale fields.
  * Landing Pages including 4-byte UTF-8 characters, such as emojis and some Chinese or other non-Latin characters, in the Landing Page title or URL aren't tracked on a Contact's activity history in Mautic. Mautic tracks all Latin characters used in English and other western languages which are of 1-byte.

Automatic tracking filtering


To keep your analytics focused on real people, Mautic automatically excludes certain requests from tracking. When a request matches any of the conditions below, Mautic doesn't record the page hit, Email open, Asset download, or Contact tracking activity:



* **Bots and crawlers** - Requests Mautic identifies as bots through the IP and User Agent filtering described in :ref:`Miscellaneous Settings<miscellaneous settings>`.
* **HEAD requests** - Requests that use the ``HTTP HEAD`` method, which monitoring and uptime tools commonly send.
* **Speculative loading requests** - The prefetch and prerender requests browsers make to load links a visitor hasn't actually opened.
* **Global Privacy Control signals** - Requests that send a ``Sec-GPC: 1`` header. Honoring this signal is a legal requirement under privacy laws such as the California Consumer Privacy Act.
* **Do Not Track signals** - Requests that send a ``DNT: 1`` header.


This filtering is always on, and you can't turn it off. Because Mautic doesn't track these requests, it doesn't create anonymous Contacts for them, so your analytics reflect genuine human engagement and respect visitor privacy preferences.

Facebook pixel

  :width: 600
  :alt: Screenshot showing Facebook Pixel Settings Configuration in Mautic

* **Facebook Pixel ID** - Enter your Facebook Pixel ID and select the options you'd like to use the pixel for.

* **Enabled on your tracking Landing Page** - Select Yes to have Mautic append the Facebook Pixel to the Mautic tracking code to track Landing Pages where the tracking code exists.

* **Enabled on Mautic Landing Page** - Select Yes to have Mautic add the Facebook Pixel to Mautic Landing Pages.


Google analytics

  :width: 600
  :alt: Screenshot showing Google Analytics Settings Configuration in Mautic

* **Google Analytics ID** - Enter your Google Analytics ID and select the options you'd like to use the pixel for.

* **Enabled on your tracking Landing Page** - Select Yes to have Mautic append the Google Analytics script to the Mautic tracking code to track Landing Pages where the tracking code exists.

* **Enabled on Mautic Landing Page** - Select Yes to have Mautic add the Google Analytics script to Mautic Landing Pages.

* **Enabled IP** ``Anonymization`` - For subscribers sensitive to General Data Protection Regulation or other data privacy laws and regulations, select Yes to anonymize the IP address of web visitors before sending it to Google Analytics.*

Report settings

  :width: 600
  :alt: Screenshot showing Report Settings Configuration in Mautic

* **Always quote data in CSV export** - Select Yes to wrap each Mautic field in double quotation marks when exported to a CSV file. For example: ``\"First Name\",”Last Name”,””, \"some text\"``.

Text message settings

  :width: 600
  :alt: Screenshot showing Text Message Settings Configuration in Mautic

* **Select default transport to use** - If you have configured a delivery service for SMS messages, select the service here to send messages. You must configure a delivery service before selecting it here.

User/Authentication settings

SAML/SSO settings

  :width: 600
  :alt: Screenshot showing SAML/SSO Settings Configuration in Mautic

* **Identity provider metadata file** - Upload the metadata XML file from your Identity Provider (IDP) here.

* **Default Role for created Users** - You can select one of those Roles as the default for Users created using Single Sign-On by creating :doc:`User Roles</users_roles/managing_roles>` in the Roles section of the settings panel. If empty, Single Sign-On won't create any Mautic Users. See :doc:`Users and Roles</users_roles/managing_roles>`.

Enter the names of the attributes the configured IDP uses for the Mautic User fields. Match the field name from your identity provider to the field name Mautic uses for User creation.

* **Email**
* **First name**
* **Last name**
* **Username**

Use a custom X.509 certificate and private key to secure communication between Mautic and the IDP.

Upload your:

* **X.509 certificate**
* **Private key file**

Enter your **Private key encryption password**

Webhook settings

  :width: 600
  :alt: Screenshot showing Webhook Settings Configuration in Mautic

* **Queue Mode** -  Select how to process Webhook events. The process immediately executes the Webhook event as soon as it arrives. The queue mode improves performance by only adding the event to the queue and requires processing by a :ref:`Cron command<Webhooks Cron job>`.

* **Order of the queued events** - Process the events in chronological or reverse chronological order if a Webhook has a queue of multiple events.

Social settings

  :width: 600
  :alt: Screenshot showing Social Settings Configuration in Mautic

* **Twitter Handle Field** - This field stores the Twitter username for Users added to Mautic through Social Monitoring.""",
    ),

    AppLesson(
      title: "Shortener",
      body: r"""URL shortener service

    Mautic 5 introduces a new shortening feature, replacing the previous legacy shortening system found in the settings. If you utilized the shortening service in Mautic 4, upon upgrading to Mautic 5, please follow the steps below to reconfigure it.

The new URL shortener service allows developers to create Plugins for any shortener service, with any type of authorization. By default, Mautic does not provide a URL shortener service Plugin; you must install it either from the Marketplace or manually.


Example of setup Bitly plugin

1. Install the Bitly bundle from the Marketplace or using Composer:


    composer require webmecanik/mautic-bitly-bundle

2. Obtain an access key from :xref:`Bitly API settings` and set up/enable the Bitly plugin.

3. Navigate to Configuration > System Settings > Shortener Service and designate Bitly as the default shortener service.

   :width: 600
   :alt: Screenshot of Bitly enabled for SMS""",
    ),

    AppLesson(
      title: "Smime Email Signing",
      body: r"""S/MIME Email signing

S/MIME - Secure/Multipurpose Internet Mail Extensions - is a standard for public key encryption and signing of Multipurpose Internet Mail Extensions - MIME - data. Mautic supports S/MIME Email signing to help verify the authenticity of your Emails and ensure that the Email content wasn't modified in transit.

    S/MIME signing is currently only available when using the SMTP Email transport. It doesn't work with API-based Email transports.


What's S/MIME Email signing?


S/MIME Email signing adds a digital signature to your Emails, which allows recipients to:

1. **Verify the sender's identity** - Confirm that the Email actually came from your organization
2. **Ensure Email integrity** - Verify that the Email content wasn't tampered with during transmission
3. **Build trust** - Demonstrate to recipients that your organization follows Email security best practices

    This implementation focuses on **signing** Emails only. It doesn't encrypt the Email body, which means the Email content is still readable to anyone who has access to it. Many Email clients don't support S/MIME encryption, so signing provides verification without compatibility issues.

For more detailed information about S/MIME and why to use it, read this :xref:`S/MIME: secure Email encryption and signature` article by mailbox.

How it works

When you turn on and properly configure S/MIME signing:

1. Mautic signs each outgoing Email with the private key for the sender's Email address
2. Mautic attaches the signature to the Email as a ``smime.p7s`` file
3. Recipients with S/MIME-capable Email clients can verify the signature using the public certificate
4. If no certificate exists for a sender's Email address, Mautic sends the Email unsigned without error

Turn on S/MIME signing

Turn on S/MIME signing through your Mautic configuration file. It isn't available in the web interface.

    Make sure you're using the SMTP Email transport before turning on S/MIME signing. The feature doesn't work with API-based Email transports.

Configuration

Add the following configuration parameters to your ``app/config/local.php`` file:


    <?php
    \$parameters = array(
        // ... other configuration ...
        'smime_signing_enabled' => true,
        'smime_certificates_path' => '%kernel.project_dir%/var/smime_certificates',
    );

Configuration parameters

``smime_signing_enabled``
    set to ``true`` to turn on S/MIME Email signing or ``false`` to turn it off.

    Default: ``false``

``smime_certificates_path``
    the absolute path to the directory where Mautic stores your S/MIME certificates. You can use ``%kernel.project_dir%`` to reference your Mautic installation directory.

    Default: ``%kernel.project_dir%/var/smime_certificates``

Generating S/MIME certificates

Each Email address that sends Emails from Mautic needs its own pair of certificates:

- A **public certificate** - ``.crt`` file - that verifies your identity
- A **private key** - ``.pem`` file - that signs the Emails

Self-signed certificates

For testing purposes, you can create self-signed certificates. However, for production use, you should obtain certificates from a trusted Certificate Authority.

To create a self-signed certificate and private key:


    # Create a private key and certificate signing request
    openssl req -newkey rsa:4096 -nodes -keyout sender@example.com.pem -out sender@example.com.csr

    # Create a self-signed certificate valid for 1 year
    openssl x509 -req -days 365 -in sender@example.com.csr -signkey sender@example.com.pem -out sender@example.com.crt

    Replace ``sender@example.com`` with the actual Email address you're using to send Emails from Mautic.

Production certificates

For production use, obtain S/MIME certificates from a trusted Certificate Authority - CA. Many Certificate Authorities offer S/MIME certificates, and the process typically involves:

1. Generating a Certificate Signing Request - CSR
2. Submitting the CSR to the CA along with identity verification documents
3. Receiving the signed certificate from the CA

To see an example of how this process works in practice, refer to the :xref:`Mozilla guide on obtaining S/MIME certificates` article by Mozilla.

Installing certificates

Certificate file naming

Name certificates according to the Email address they're for:

- Public certificate: ``email@example.com.crt``
- Private key: ``email@example.com.pem`` - plain text - or ``email@example.com.pem.enc`` - encrypted

Replace ``email@example.com`` with the actual sender Email address.

    The Email address in the filename must exactly match the **From** address used when sending Emails.

Certificate directory structure

Place your certificate files in the directory specified by ``smime_certificates_path``:


    /var/smime_certificates/
    ├── admin@example.com.crt
    ├── admin@example.com.pem
    ├── support@example.com.crt
    └── support@example.com.pem

Setting permissions

Ensure that the web server User has read access to the certificate directory and files:


    # Set ownership (replace www-data with your web server user)
    chown -R www-data:www-data /path/to/mautic/var/smime_certificates

    # Set directory permissions
    chmod 755 /path/to/mautic/var/smime_certificates

    # Set certificate permissions
    chmod 644 /path/to/mautic/var/smime_certificates/*.crt
    chmod 600 /path/to/mautic/var/smime_certificates/*.pem

    Private keys - ``.pem`` files - should have restrictive permissions - ``600`` - to prevent unauthorized access.

Encrypting private keys

To enhance security, you can encrypt your private keys using Mautic's encryption system. Mautic stores the encrypted private keys with the ``.pem.enc`` extension.

Benefits of encryption

Encrypting private keys adds an extra layer of security:

- If someone compromises your server, they can't use the encrypted keys without Mautic's secret key
- The encryption uses your Mautic instance's ``secret_key`` from the configuration
- Mautic automatically decrypts the keys when needed to sign Emails

    Make sure you have a ``secret_key`` configured in your ``app/config/local.php`` file. Mautic creates this automatically during installation.

Creating encrypted keys

To encrypt an existing private key:

1. Ensure your ``secret_key`` configures in ``app/config/local.php``
2. Use Mautic's encryption helper or the command line:


    # Using PHP to encrypt the key
    php -r \"
    require 'app/config/local.php';
    require 'app/bundles/CoreBundle/Helper/EncryptionHelper.php';
    \\\$helper = new \\Mautic\\CoreBundle\\Helper\\EncryptionHelper(
        new \\Mautic\\CoreBundle\\Helper\\CoreParametersHelper(new \\Symfony\\Component\\DependencyInjection\\ParameterBag\\ParameterBag(\\\$parameters))
    );
    \\\$key = file_get_contents('var/smime_certificates/sender@example.com.pem');
    file_put_contents('var/smime_certificates/sender@example.com.pem.enc', \\\$helper->encrypt(\\\$key));
    \"

3. After creating the encrypted version, you can remove the plain text ``.pem`` file for security
4. Mautic automatically uses the encrypted version - ``.pem.enc`` - if it exists

Key priority

When looking for a private key, Mautic checks in this order:

1. Encrypted key: ``email@example.com.pem.enc``
2. Plain text key: ``email@example.com.pem``

If both exist, the encrypted version takes priority.

Testing S/MIME signing

After configuring S/MIME signing:

1. Send a test Email from Mautic using an Email address that has certificates configured
2. Select the Email source/headers in your Email client
3. Look for these indicators that Mautic signed the Email:

   - Content-Type header contains ``multipart/signed``
   - An attachment named ``smime.p7s``
   - protocol ``application/x-pkcs7-signature``

4. If your Email client supports S/MIME, you should see a verification indicator - such as a seal or checkmark

Troubleshooting S/MIME

Emails aren't signed

If Mautic doesn't sign Emails, select:

1. **S/MIME enabled** - verify ``smime_signing_enabled`` sets to ``true`` in ``local.php``
2. **Using SMTP transport** - S/MIME only works with SMTP. Select your Email transport settings
3. **Certificates exist** - confirm the ``.crt`` and ``.pem`` files exist in the certificates directory
4. **Correct filenames** - certificate filenames must exactly match the sender Email address
5. **File permissions** - the web server User must have read access to the certificate files
6. **Select logs** - look in ``var/logs/mautic_prod.log`` for any S/MIME-related errors

Certificates not found errors

If you see certificate errors in the logs:

1. Verify the ``smime_certificates_path`` specifies correctly in your configuration
2. Ensure that Mautic names certificate files correctly - ``email@example.com.crt`` and ``.pem``
3. Ensure the Email address in the filename exactly matches the From address
4. Verify file permissions allow the web server User to read the files

Certificate validation errors

If recipients Reports certificate validation errors:

1. **Self-signed certificates** - these aren't trusted by default. Recipients need to manually trust them
2. **Expired certificates** - select your certificate expiration dates
3. **Certificate chain** - ensure you're using the full certificate chain from your Certificate Authority
4. **Domain mismatch** - the certificate's Email address must match the From address

Performance considerations

S/MIME signing adds a small amount of processing overhead to each Email:

- Mautic performs signing for each Email individually
- When you turn on S/MIME, Mautic turns off batch Email processing - token-based sending - to ensure proper signing
- For high-volume Email sending, monitor your server resources

Limitations

Current limitations of S/MIME signing in Mautic:

1. **SMTP only** - S/MIME signing only works with the SMTP Email transport. API-based transports aren't supported.
2. **Signing only** - this implementation signs Emails but doesn't encrypt the Email body. The content is still readable.
3. **No batch processing** - when you turn on S/MIME, Mautic turns off batch Email processing - token-based sending - to ensure proper signing.
4. **One Email per request** - Mautic sends each Email individually rather than in batches.

    If you turn on S/MIME signing and you're using a non-SMTP transport, Mautic forces sending one Email per request, but signing may not work correctly. Always use SMTP for S/MIME signing.

Additional resources

For more information about S/MIME:

- :xref:`S/MIME: secure Email encryption and signature`
- :xref:`Mozilla guide on obtaining S/MIME certificates`
- :xref:`OpenSSL Documentation`

Related documentation


- :doc:`/configuration/settings` - General Email settings configuration
- :doc:`/channels/emails` - Emails overview and management
- :doc:`/configuration/cron_jobs` - Setting up Cron jobs for Email sending""",
    ),

    AppLesson(
      title: "Tracking Script",
      body: r"""Tracking script


After installation and setup of the :doc:`/configuration/cron_jobs` you're ready to begin tracking Contacts. You need to add a piece of JavaScript to the websites for each site you wish to track through Mautic.

This is straightforward process, you can add this tracking script to your website template file, or install a Mautic Integration for the more common Content Management System platforms.

Here is an example of the tracking JavaScript which you can access by clicking on **Tracking Settings** in the Global Configuration.



  (function(w,d,t,u,n,a,m){w['MauticTrackingObject']=n;
     w[n]=w[n]||function(){(w[n].q=w[n].q||[]).push(arguments)},a=d.createElement(t),
     m=d.getElementsByTagName(t)[0];a.async=1;a.src=u;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://example.com/mautic/mtc.js','mt');
   mt('send', 'pageview');

You should replace the site URL, ``example.com/mautic`` with the URL to your Mautic instance in the example provided, but it's recommended to copy the whole code block from the tracking settings in your Mautic instance.""",
    ),

    AppLesson(
      title: "Variables",
      body: r"""Variables

  Default Value

  The default value - sometimes called Fallback Text - is specified after the ``|`` character. Consider this Email salutation:

  ``Hi {contactfield=firstname|there},``

Token modifiers

Label modifier for select and boolean fields

For select and boolean type fields, you can use the ``|label`` modifier to display the human-readable label instead of the stored value. It's beneficial when your select fields store values like codes or IDs, but you want to display friendly labels to your Contacts.

**Syntax:**


   {contactfield=field_alias|label}

**Examples:**

* For a select field with alias ``country_select`` that has options, such as ``us`` for ``United States`` or ``uk`` for ``United Kingdom``:

   * ``{contactfield=country_select}`` displays the value ``us``
   * ``{contactfield=country_select|label}`` displays the label ``United States``

* For a boolean field with alias ``is_subscriber``:

   * ``{contactfield=is_subscriber}`` displays the value ``1`` or ``0``
   * ``{contactfield=is_subscriber|label}`` displays the label ``Yes`` or ``No``

* For both Contact fields and Company fields:

   * ``{contactfield=company_type|label}`` displays the label of a Company select field
   * ``{contactfield=company_active|label}`` displays the label of a Company boolean field


   The ``|label`` modifier only works with select and boolean field types. For other field types, it displays the regular value.

Contact fields

See :doc:`managing custom fields </contacts/custom_fields>` for more information.

   :widths: 100 100
   :header-rows: 1

   * - Variable name
     - Variable syntax
   * - Attribution
     - ``{contactfield=attribution}``
   * - Attribution Date
     - ``{contactfield=attribution_date}``
   * - Address Line 1
     - ``{contactfield=address1}``
   * - Address Line 2
     - ``{contactfield=address2}``
   * - Country
     - ``{contactfield=country}``
   * - City
     - ``{contactfield=city}``
   * - Company
     - ``{contactfield=company}``
   * - Contact ID
     - ``{contactfield=id}``
   * - Email
     - ``{contactfield=email}``
   * - Facebook
     - ``{contactfield=facebook}``
   * - Fax
     - ``{contactfield=fax}``
   * - First Name
     - ``{contactfield=firstname}``
   * - Foursquare
     - ``{contactfield=foursquare}``
   * - Google+
     - ``{contactfield=googleplus}``
   * - Instagram
     - ``{contactfield=instagram}``
   * - IP Address
     - ``{contactfield=ipAddress}``
   * - Last Name
     - ``{contactfield=lastname}``
   * - LinkedIn
     - ``{contactfield=linkedin}``
   * - Mobile Number
     - ``{contactfield=mobile}``
   * - Phone Number
     - ``{contactfield=phone}``
   * - Position
     - ``{contactfield=position}``
   * - Skype
     - ``{contactfield=skype}``
   * - State
     - ``{contactfield=state}``
   * - Twitter
     - ``{contactfield=twitter}``
   * - Title
     - ``{contactfield=title}``
   * - Website
     - ``{contactfield=website}``
   * - Zip Code
     - ``{contactfield=zipcode}``

Contact Owner fields

   :widths: 100 100
   :header-rows: 1


   * - Variable name
     - Variable syntax
   * - First Name
     - ``{ownerfield=firstname}``
   * - Last Name
     - ``{ownerfield=lastname}``
   * - Email
     - ``{ownerfield=email}``
   * - Position
     - ``{ownerfield=position}``
   * - Signature
     - ``{ownerfield=signature}``

Company Contact fields

See :doc:`Companies</companies/companies_overview>` for more information.

   :widths: 100 100
   :header-rows: 1

   * - Variable name
     - Variable syntax
   * - Address Line 1 (Company)
     - ``{contactfield=companyaddress1}``
   * - Address Line 2 (Company)
     - ``{contactfield=companyaddress2}``
   * - Annual Revenue (Company)
     - ``{contactfield=companyannual_revenue}``
   * - City (Company)
     - ``{contactfield=companycity}``
   * - Country (Company)
     - ``{contactfield=companycountry}``
   * - Description (Company)
     - ``{contactfield=companydescription}``
   * - Email (Company)
     - ``{contactfield=companyemail}``
   * - Fax (Company)
     - ``{contactfield=companyfax}``
   * - Industry (Company)
     - ``{contactfield=companyindustry}``
   * - Name
     - ``{contactfield=companyname}``
   * - Number of Employees (Company)
     - ``{contactfield=companynumber_of_employees}``
   * - Phone Number (Company)
     - ``{contactfield=companyphone}``
   * - State (Company)
     - ``{contactfield=companystate}``
   * - Website (Company)
     - ``{contactfield=companywebsite}``
   * - Zip Code (Company)
     - ``{contactfield=companyzipcode}``


   **Custom Company fields**

   The syntax for custom Company fields differs from core Company field syntax. You must **not** add the word 'Company' in the variable and instead treat it as a ``contactfield``.

Mautic Component tokens

See :doc:`Components</components/assets>` and :doc:`Manage Pages</components/landing_pages>` for more information.

   :widths: 100 100
   :header-rows: 1


   * - Variable name
     - Variable syntax
   * - Asset link for Asset id#
     - ``{assetlink=25}``
   * - Focus Item id#
     - ``{focus=4}``
   * - Form id#
     - ``{form=83}``
   * - Landing Page link for page id#
     - ``{pagelink=17}``

Email specific tokens

See :doc:`Manage Emails</channels/emails>` for more information.

   :widths: 100 100
   :header-rows: 1


   * - Variable name
     - Variable syntax
   * - Signature
     - ``{signature}``
   * - Subject
     - ``{subject}``
   * - Tracking pixel
     - ``{tracking_pixel}``
   * - Unsubscribe Text
     - ``{unsubscribe_text}``
   * - Unsubscribe URL
     - ``{unsubscribe_url}``
   * - Resubscribe URL
     - ``{resubscribe_url}``
   * - Web View Text
     - ``{webview_text}``
   * - Web View URL
     - ``{webview_url}``

Landing Page tokens

See :doc:`/components/landing_pages` for more information.

   :widths: 100 100
   :header-rows: 1


   * - Variable name
     - Variable syntax
   * - Meta Description
     - ``{pagemetadescription}``
   * - Title
     - ``{pagetitle}``
   * - Language bar
     - ``{langbar}``
   * - Share Buttons
     - ``{sharebuttons}``
   * - Success Message
     - ``{successmessage}``

Preference Center Landing Page tokens

See :doc:`customizing preference center</contacts/preference_center>` for more information.

   :widths: 100 100
   :header-rows: 1


   * - Variable name
     - Variable syntax
   * - Lead Identifier
     - ``{leadidentifier}``
   * - Category List
     - ``{categorylist}``
   * - Segment List
     - ``{segmentlist}``
   * - Preferred Channel
     - ``{preferredchannel}``
   * - Channel Frequency
     - ``{channelfrequency}``
   * - Save Preferences
     - ``{saveprefsbutton}``

Dynamic Web Content tokens

   :widths: 100 100
   :header-rows: 1


   * - Variable name
     - Variable syntax
   * - [Dynamic Content 1] | for example User-defined variable name
     - ``{dynamiccontent=\"Dynamic Content 1\"}``

Contact Monitoring

See :ref:`Contact Monitoring<Contact tracking>` for more information.

   :widths: 100 100
   :header-rows: 1


   * - Variable name
     - Variable syntax
   * - Language
     - ``{language}``
   * - Title
     - ``{title}``
   * - Landing Page Title
     - ``{page_title}``
   * - URL
     - ``{url}``
   * - Landing Page URL
     - ``{page_url}``
   * - Referrer
     - ``{referrer}``
   * - Tracking pixel
     - ``{tracking_pixel}``
   * - UTM Campaign
     - ``{utm_campaign}``
   * - UTM Content
     - ``{utm_content}``
   * - UTM Medium
     - ``{utm_medium}``
   * - UTM Source
     - ``{utm_source}``
   * - UTM Term
     - ``{utm_term}``

Search filters

See the :ref:`Search<search>` page for more information.

Alphabetical list

   :widths: 40 50
   :header-rows: 1

   * - Variable name
     - Variable syntax
   * - Address Line 1
     - ``{contactfield=address1}``
   * - Address Line 1 (Company)
     - ``{contactfield=address1}``
   * - Address Line 2
     - ``{contactfield=address2}``
   * - Address Line 2 (Company)
     - ``{contactfield=companyaddress2}``
   * - Annual Revenue (Company)
     - ``{contactfield=companyannual_revenue}``
   * - Asset link for Asset id#
     - ``{assetlink=25}``
   * - Attribution
     - ``{contactfield=attribution}``
   * - Attribution Date
     - ``{contactfield=attribution_date}``
   * - Category List (Preference Center)
     - ``{categorylist}``
   * - Channel Frequency (Preference Center)
     - ``{channelfrequency}``
   * - City
     - ``{contactfield=city}``
   * - City (Company)
     - ``{contactfield=companycity}``
   * - Country
     - ``{contactfield=country}``
   * - Country (Company)
     - ``{contactfield=companycountry}``
   * - Company
     - ``{contactfield=company}``
   * - Contact ID
     - ``{contactfield=id}``
   * - Description (Company)
     - ``{contactfield=companydescription}``
   * - [Dynamic Content 1]for example: user-defined variable name
     - ``{dynamiccontent=\"Dynamic Content 1\"}``
   * - Email
     - ``{contactfield=email}``
   * - Email (Company)
     - ``{contactfield=companyemail}``
   * - Facebook
     - ``{contactfield=facebook}``
   * - Fax
     - ``{contactfield=fax}``
   * - Focus Item id#
     - ``{focus=4}``
   * - Form id#
     - ``{form=83}``
   * - Fax (Company)
     - ``{contactfield=companyfax}``
   * - First Name
     - ``{contactfield=firstname}``
   * - Foursquare
     - ``{contactfield=foursquare}``
   * - Google+
     - ``{contactfield=googleplus}``
   * - Instagram
     - ``{contactfield=instagram}``
   * - IP Address
     - ``{contactfield=ipAddress}``
   * - Landing Page link for page id#
     - ``{pagelink=17}``
   * - Language bar
     - ``{langbar}``
   * - Last Name
     - ``{contactfield=lastname}``
   * - Contact Identifier (Preference Center)
     - ``{leadidentifier}``
   * - LinkedIn
     - ``{contactfield=linkedin}``
   * - Meta Description (Landing Page)
     - ``{pagemetadescription}``
   * - Mobile Number
     - ``{contactfield=mobile}``
   * - Name (Company)
     - ``{contactfield=companyname}``
   * - Number of Employees (Company)
     - ``{contactfield=companynumber_of_employees}``
   * - Phone Number
     - ``{contactfield=phone}``
   * - Phone Number (Company)
     - ``{contactfield=companyphone}``
   * - Position
     - ``{contactfield=position}``
   * - Save Preferences (Preference Center)
     - ``{saveprefsbutton}``
   * - Segment List (Preference Center)
     - ``{segmentlist}``
   * - Signature
     - ``{signature}``
   * - Skype
     - ``{contactfield=skype}``
   * - State
     - ``{contactfield=state}``
   * - State (Company)
     - ``{contactfield=companystate}``
   * - Subject
     - ``{subject}``
   * - Twitter
     - ``{contactfield=twitter}``
   * - Preferred Channel (Preference Center)
     - ``{preferredchannel}``
   * - Resubscribe URL
     - ``{resubscribe_url}``
   * - Share Buttons
     - ``{sharebuttons}``
   * - Success Message
     - ``{successmessage}``
   * - Title
     - ``{contactfield=title}``
   * - Title (Landing Page)
     - ``{pagetitle}``
   * - Unsubscribe Text
     - ``{unsubscribe_text}``
   * - Unsubscribe URL
     - ``{unsubscribe_url}``
   * - Website
     - ``{contactfield=website}``
   * - Website (Company)
     - ``{contactfield=companywebsite}``
   * - Web View Text
     - ``{webview_text}``
   * - Web View URL
     - ``{{webview_url}``
   * - Zip Code
     - ``{contactfield=zipcode}``
   * - Zip Code (Company)
     - ``{contactfield=companyzipcode}``""",
    ),

  ],
),

AppCourse(
  id: "marketing_9",
  title: "Contacts",
  description: "Contacts",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "7 Lessons",
  lessons: [
    AppLesson(
      title: "Contacts Overview",
      body: r"""Contacts


Contacts are the central factor of a marketing automation platform.

These are all the individuals who have visited your websites or interacted with you in some way.

Contact types

There are two types of Contacts:

Visitors - formerly ``anonymous leads``

Unidentified visitors to your site who haven't yet completed a Form or otherwise interacted with your site.

Mautic tracks these Contacts, but usually keeps them hidden so as not to clutter up your view.

Visitors are worth tracking, because these could be future customers. By tracking them before they have any interaction, you can retain a log of when they visited your site, which allows you to get a picture of their activity prior to engaging with you.

You can use the filter in the Contacts screen to display only visitors by using the this command ``is:anonymous`` in the search bar at the top of the Contacts list.

   :alt: Screenshot of anonymous Contact

**What you see** - Switching to the anonymous Contacts view displays the IP addresses for visitors to Landing Pages tracked with your Mautic tracking code.
If you have an IP lookup service :ref:`configured<miscellaneous settings>` in **Settings > System Settings > Miscellaneous Settings**, Mautic shows an approximate location of the Contacts. Mautic uses :xref:`MaxMind's` Geolite2 City by default. MaxMind approximates the location based on the Contact's Internet Service Provider, and may not be the exact location of the Contact.

**Individual Contacts** - Click an IP address to display a Contact record, similar to known Contacts. If there's any information on an anonymous Contact, you can see it here. This data can include:

* Landing Pages the Contact has visited

* Forms submitted

* Scoring

* Data from Forms - which don't include the unique identifier, since that would make the Contact known


    * In **Settings > Configuration > Tracking Settings**, you can enable the **Do Not Track 404 error for anonymous Contacts** option to not track page hits on any 404 error page tracked by the tracking code. This option helps prevent tracking pages you're not interested in and filling the Contact logs with bot activity. See :ref:`Tracking settings<tracking settings>`

    * Mautic also filters out bot, monitoring, and privacy opt-out traffic automatically, so it doesn't create anonymous Contacts for those requests. See :ref:`Automatic tracking filtering<automatic tracking filtering>`.

    * Data for anonymous Contacts isn't available for segmentation or reporting. Once identified, the data is available, which applies to non-Campaign based Dynamic Web Content filters.



Standard Contacts


The second type of Contact is a known Contact. These Contacts have identified themselves via a Form or other source. You may also have more information about them from previous interactions, or from a third-party system such as a Customer Relationship Management (CRM) tool.

As a result, these Contacts typically have a name, Email, and other identifying information associated with the Contact.

These are Contacts which may have started as a visitor, but at some point provided additional information such as a name, Email address, social network handle, or other identifying characteristics which have enabled you to connect up the activity on your website with a known person. You can nurture these Contacts through the Mautic marketing automation platform, learn more about their behavior, and take specific actions as a result of this information.


Changing the view

By default Mautic uses the **list view**, but you can also choose to switch to the **card view** also known as **grid view**, which uses avatars to depict the Contacts visually using cards.

Press **V** on your keyboard to switch between the list and card views.

The :ref:`Manage Contacts<managing contacts>` section provides more information on how you can work with Contacts in Mautic.""",
    ),

    AppLesson(
      title: "Custom Fields",
      body: r"""Manage Custom Fields


You can manage Custom Fields through the Admin menu - click the cogwheel upper right-hand side of Mautic.

   :align: center
   :alt: Highlight of Custom Fields option in the settings

|

Custom Fields

The **Custom Fields** page lets you view all existing Contact fields as well as any custom Contact fields you have created.

   :align: center
   :alt: Screenshot of Custom Field

|

You'll notice the group column shows the specific field on the Contact profile. In the last column, you may see several icons which signify various properties of the field:

    :align: center
    :alt: Screenshot of Custom field icons

|

1. **Lock icon** -  The core installation uses these fields, you can't remove them.

2. **List icon** - You can use these fields as filters for Segments.

3. **Asterisks icon** - These are mandatory when filling in the Contact Form

4. **Globe icon** - You can update these fields publicly through the :doc:`tracking pixel</configuration/variables>` URL query see :doc:`Contact Monitoring</contacts/manage_contacts>` for more details.

It's important to note that from Mautic 5, you won't be able to edit the default value for any Fields used to identify a Contact or Company, including:

* Email

* Company

* First name

* Last name

* Social profiles

* Unique identifier fields

* Company name

* Company Email

* Company website

* State

* Country

* City

Published fields

There is a toggle switch which shows before each label title. You can find this type of switch throughout the Mautic UI for publishing and unpublishing items.


   .. figure:: images/unpublish-fields.gif

|


Adding a new Custom Field


You can create additional Custom Fields and define the data type you want that field to hold. In addition to the data type you select the group for that particular field. This defines where the field displays on the Contact edit and detail view.

    :align: center
    :alt: Screenshot of New Custom Field

|

Creating Custom Fields via a command

When you create a new Custom Field for Contacts or Companies in Mautic, the system adds a new column to the database. For larger instances of Mautic, this operation can slow down, and the table remains locked while running. As a result, you can't make any changes until the system creates the field. The ``HTTP`` request may time out, causing the User Interface to report that the column exists even though Contact/Company updates may fail because the column is still missing.

There is a way around this when you configure the processing of field creation in the background.

Since :xref:`Mautic 3` there is an option you can set in your ``app/config/local.php`` file: ``'create_custom_field_in_background' => true``,.

If you configure this option, the new Custom Field becomes visible in the list of Custom Fields. The Custom Field remains unpublished until you run the command ``bin/console mautic:custom-field:create-column``. This command creates the actual column in the table and publishes the field metadata.

Similarly, the ``bin/console mautic:custom-field:delete-column`` command deletes the actual column in the table if you have turned on the ``create_custom_field_in_background`` config option. The column gets soft-deleted and removed from the user interface, but the data is still present in the database until you run the command to delete the column.

This configuration helps prevent **http** request timeouts because it handles the long-running SQL query to create the new table column as a background task.

To mitigate the table lock issue, run the command only once daily when you know that most of your audience is offline. With less traffic going into Mautic, the chances of encountering a problem are lower.


Analyzing Custom Fields to optimize tables

Since Mautic 5.1 there is a command which allows you to analyze the Custom Fields and optimize the tables. This command is useful when you have a lot of Custom Fields and you want to optimize the size of VARCHAR fields.

Using this command allows you to optimize the VARCHAR columns so that you can create more Custom Fields if you hit the hard limit on the Leads table and can't create more.

Use the command:


    bin/console mautic:fields:analyse -t

Use the -t argument to see the output in tabulated form in the console.

Use the following to export the data to a file:


    bin/console mautic:fields:analyse > path/to/file.csv

Locally defined countries and regions

Since Mautic 5.1 it's possible to define custom countries and regions via locally hosted JSON files. This is useful when you have a specific set of countries or regions that you want to use in your Mautic instance. You can define these in a file called ``countries.json`` or ``regions.json`` located in your defined ``upload_dir`` which is ``media/files`` by default. Example code snippets are below:


  [
  \"Middle Earth\",
  \"Fillory\"
  ]


  {
  \"Middle Earth\": [
    \"The Shire\",
    \"Mordor\"
  ],
  \"Fillory\": [
    \"Castle Whitespire\",
    \"Ember's Tomb\"
  ]
  }""",
    ),

    AppLesson(
      title: "Frequency Rules",
      body: r"""Frequency rules


Frequency rules are a set of rules used to define the number of times you should communicate with a Contact by any means in Mautic. Mautic implements this for the Email and SMS Channels currently, but this applies to other Channels as appropriate, such as social media mentions or messages sent in another Channel.

How to set frequency rules

* Globally, from the configuration panel, you can set frequency rules for both Email and SMS settings.


* Individually, from a Contact's detail page under the dropdown menu on the upper right-hand side, you can select the Channels where you want the rules to apply. Setting the rule here overrides the general settings.""",
    ),

    AppLesson(
      title: "Import Contacts",
      body: r"""Import Contacts

Contact importing is possible through the User Interface in Mautic. For larger imports it's recommended to complete the import in the background via a cron job.

Since Mautic 2.9, Mautic shows in a Contact's event history when an import job creates or updates a Contact.

Import file requirements

* The CSV file must use UTF8 encoding. Other encodings may cause failures while importing. Read the documentation of your spreadsheet program on how to export a spreadsheet to UTF8. Google Sheets encodes to UTF8 automatically, Libre/Open Office lets you choose before export.

* For boolean values like ``doNotEmail`` or custom boolean field, use values ``true``, ``1``, ``on`` or ``yes`` as TRUE values. Mautic considers anything else ``false``.
* To import multiple Tags for a Contact separate them with ``|`` like ``tag-a|tag-b|tag-c``
* For date/time values, use ISO8601 notation ``i.e. YYYY-MM-DD hh:mm:ss``.  Other formats may work too, but they could be problematic.

  * Example: ``2019-01-02 19:08:42``.

    Other formats may work too, but they could be problematic.

Tips

* Use a header row with the column names matching the Mautic Contact Custom Field names. This way Mautic automatically pre-selects the mapping for you. For example, if you name the first name column as ``firstname``, Mautic maps this automatically to ``{contactfield=firstname}``.

* When you set up your mapping, you have an option to skip the import on fields where a value already exists on the Contact record. This setting allows you to avoid erasing data which already exists in your Mautic Contacts.

* If your CSV contains more than a few thousand Contacts, divide the file into several smaller CSV files to avoid memory issues and slow import speeds.


  If using a Linux system, see the ``GNU`` parallel command ``sudo apt install parallel``.

  ``cat big_contact_list.csv | parallel --header : --pipe -N 1000 'cat > split_list_part{#}.csv'``

  This generates files: ``split_list_part1.csv ...split_list_part9.csv, split_list_part10.csv``.



Types of import

Browser import

You must import larger CSV files in batches to avoid hitting server (PHP) memory and execution time limits. When importing in the browser, your browser is controlling the batches. When one finishes, the JavaScript starts a new one. This means the browser window has to stay opened and connected to the internet the whole time.

Use the browser import method only if you don't have any other choice. You should default to using the background import.

Background import

Background import jobs - triggered manually or via a cron job - have the advantage of benevolent time limits. A CSV background import isn't restarted every batch - 1 batch = 100 rows by default - Mautic saves the last row imported, and the next batch continues from that point. Background imports are always faster and more reliable than browser imports.



  Background import requires the command ``php /path/to/mautic/bin/console mautic:import`` to run periodically. Add it to your :doc:`cron jobs</configuration/cron_jobs>`.

Successful results of the :doc:`background job</configuration/cron_jobs>` look like this:


  \$ bin/console mautic:import
  48/48 [============================] 100%
  48 lines were processed, 0 items created, 48 items updated, 0 items ignored in 4.78 s

If there is no import waiting in the queue, there won't be any messages. You can also use ``--quiet`` to prevent messages showing.

Automatic import type configuration

There is an option in the Global Mautic Configuration > Contact settings to define the optimal limit of browser import vs background import.

If you enter 500, that means that if there's less than ``500`` rows, the browser imports it. If there's more than 500 rows, Mautic queues it for processing when the background import cron job next runs.

 The default value is zero, which means it shows two import buttons instead of one, and you have to decide what import option to use during every import.

Parallel imports

The import can take several minutes. One import might be running when you start another. There is the ``parallel_import_limit`` configurable option to prevent running out of server resources. By default, only 1 import runs at a time. You can change this option by adding it to your ``app/config/local.php`` file.

Import job list

You can access the list of imports by going to the Contacts area, clicking the Action menu at the top right of the Contacts table, and then selecting the Import History option.

    :align: center
    :alt: Screenshot of Import history button

|


  The direct URL is ``https://example.com/s/contacts/import/1``

The table shows you:

* basic statistics about all imports
* their :ref:`current status<import job status>`
* original CSV file names
* who created the import
* Created date
* when the background job last updated the statistics

There is also a toggle switch which enables you to :ref:`stop and start<starting and stopping imports>` queued or **In Progress** imports.

Import job status

There are several potential statuses for import jobs:

* **Queued** - Mautic has queued the import for background processing. It's waiting for the background job to start the import.

* **In Progress** - The background job started the import and hasn't finished yet. You can see the progress in the list of imports.

* **Imported** - The import has been successfully processed.

* **Failed** - The import failed for some reason. The most common cause may be that the uploaded CSV file no longer exists, Mautic doesn't have permission to read it, or the import was unresponsive for more than 2 hours.

* **Stopped** - The User stopped the import when it was in the **Queued** or **In Progress** states.

* **Manual** - The User selected to import in the browser ``manually``. It's similar to In Progress.

* **Delayed** - The background job wanted to start the import, but the import process couldn't. So it's delayed for later. The reason when this could happen is when it hits the parallel import limit. The import starts as soon as it's able to do so.

Import job detail

Clicking on a filename opens the import job detail page.

The main content area displays information about ignored rows - if any. The table tells you what row in the CSV file it was and what was the reason, so you can fix those rows and :ref:`start the import<how to start an import>` again.

There are two charts:

1. The pie chart shows the ratio between created, updated and failed rows.

2. The line chart shows the Contacts added per minute.

More detailed statistics and the import job configuration are available if you click *Details*. This includes import speed, field mappings, and job timestamps.

Starting and stopping imports

How to start an import

1. Go to **Contacts**.

2. In the top right corner of the Contacts page, open the sub menu of actions and select the **Import** option.


  The direct URL is ``https://example.com/s/contacts/import/new``

3. Select the CSV file with Contacts you want to import.

4. Adjust the CSV settings if your file uses a non-standard delimiter or :ref:`encoding<import file requirements>` and so on.

5. Upload your CSV file.

6. The field mapping page should show up. The first set of options lets you select owner, Segment and tags to assign globally to all imported Contacts. The second set of options lets you map the columns from your CSV file to Mautic Contact :ref:`Custom Fields<manage custom fields>`. The third set of options lets you map columns from your CSV file to special Contact attributes like *Date Created* and so on.

7. When your field mapping is ready, click one of the Import buttons described previously.

How to stop a background import

1. Go to *Contacts*.

2. In the top right corner of the Contacts page, open the sub menu of actions and select the :ref:`Import History<import job list>` option.

3. Deactivate the import job you want to stop. The import changes :ref:`status<import job status>` to Stopped. It finishes importing the current batch and then stops.

4. To start the import again, activate it, and the background job continues with the next :doc:`cron job execution</configuration/cron_jobs>`.

    :align: center
    :alt: Screenshot of Import activation

|

When the background job finishes, either successfully or if it fails, you'll get a notification in Mautic's notification area about it.

    :align: center
    :alt: Screenshot of notification

|

FAQ

Q. The import times out, what should you do?

A. Either use the background job to import, or change the batch limit to smaller number than 100.

Q. What happens with imported *Do Not Contact* values? Are they stored as a bounce or a ``unsubscription``?

A. It's stored as a ``Manual Unsubscription``. It's the same as marking the Contact *Do Not Contact* from the Contact's page.

    :align: center
    :alt: Screenshot of Do Not Contact""",
    ),

    AppLesson(
      title: "Manage Contacts",
      body: r"""Managing Contacts


The manage Contacts page is the main interface through which you can view and interact with your Contacts - both visitors and standard Contacts.


Searching for Contacts


You can search within a Segment using the box at the top of the list, or order Contacts by using the table headings - click the relevant table heading.

    :align: center
    :alt: Screenshot of Contact Search

|

The search box allows many different search types and follows the same search process and variables as found in all other search layouts.


Working with Contacts


Quick add

    :align: center
    :alt: Screenshot of Contact Quick Add

|

Quick Add is a short Form with the fields you deem most important. To display fields in the **Quick Add** Form, make them available on short Forms in the Custom Fields configuration.

You can add the Contact through the New Contact Form and include much more detail, but for quick entry this is the easiest and fastest way to get the Contact into the system.


Add new Contact


    :align: center
    :alt: Screenshot of Contact Manual Add

|

This opens the new Contact screen, where you can enter all the information you have about the Contact. It also displays all available Contact fields when creating a new Contact.

Use the tabs at the top to populate existing Custom Fields and social network profiles.


    Before you start adding Contacts, you may need to add :doc:`custom fields</contacts/custom_fields>` to capture all the information you require.


Importing Contact lists


Mautic offers the ability to import Contacts from other sources via CSV file - this is a great way to get up and running quickly if you need to import a lot of Contacts at once.

Read more about importing Contacts in :doc:`/contacts/import_contacts`.


Exporting Contact lists


Mautic supports exporting Contact lists in CSV and Excel formats.

* **Export to CSV** - Sends a downloadable link containing the CSV file of the Contact list to the Email address on your Mautic User profile.


    This feature currently supports the export of a maximum of one million Contacts. After clicking the link in the Email, Users must log into Mautic via the login screen. Users must login as the same authorized User that received the Email, after which the file download commences. Once downloaded, Users can share the file with other non-Mautic Users.

* **Export to Excel** - Exports Contact lists to Excel directly from the system.


Editing Contacts


To edit a Contact, click the name of the Contact - or the IP address if the visitor is anonymous - to open the Contact screen.

From this screen, you can view the recent events and any notes saved against the Contact.

To edit the Contact, click the '**edit**' button on the top-right menu.

Managing duplicates

When Mautic tracks a Contact's actions - such as page hits or Form submissions - Contacts are automatically merged based on their unique identifiers, which are:

* Email - *or any other Contact field you mark as unique identifier*

* Cookie

Mautic merges all actions to the Contact with the same cookie or creates a new cookie if it knows the unique ``device_id``.

If a Contact sends a Form with an Email address, it merges the submission with the Contact having the same Email address. This happens even if the IP address or the cookie matches another Contact.

So, Mautic takes care of duplicate Contacts created by the event tracking. You can, however, still potentially create a duplicate Contact via the Mautic administration. As of Mautic 2.1.0, Mautic notifies you if there's already a Contact with the same unique identifier.

``AND`` is the default operator to find duplicates by unique identifiers. You can choose to use the ``OR`` operator in the Contact Merge :doc:`Settings configuration</configuration/settings>`.

    :align: center
    :alt: Screenshot of Contact duplicates

|

Batch actions

To make updates to several Contacts at once, select those Contacts then click the green arrow at the top of the checkbox column.

A modal window displays when you click one of the actions, with more configuration details.



You can use this feature to quickly update large volumes of Contacts, but it might be better to use a Campaign action - for example add all the Contacts you need to update into a Segment and use a Campaign to trigger the change - if you need to change more than a few hundred Contacts at a time.

    :width: 200
    :align: center
    :alt: Screenshot of Contact Batch actions

|

The following batch actions are currently available:

* **Change Campaigns** - Allows you to add/remove the selected Contacts to/from Campaigns.

* **Change Categories** - Allows you to add/remove the selected Contacts to/from global Categories.

* **Change Channels** - Allows you to subscribe/unsubscribe the selected Contacts to/from communication Channels (Email, SMS, etc.) and also define frequency rules.

* **Change Owner** - Allows you to assign/unassign the selected Contacts to/from an owner (a Mautic User).

* **Change Segments** - Allows you to add/remove the selected Contacts to/from Segments. Note that if you add or remove a Contact to or from Segment manually, then Segment filters won't apply for them in that particular Segment.

* **Change Stages** - Allows you to add/remove the selected Contacts to/from a specified Stage.

* **Export** - Allows you to export selected Contacts to CSV.

* **Set Do Not Contact (DNC)** - This action sets all selected Contacts as DNC for the Email Channel, and it allows you to provide a custom message as \"reason\" for why the Contacts were manually unsubscribed by a Mautic User.

* **Delete Selected (batch delete)** - The batch delete action in the Contact table allows the deletion of up to 100 Contacts at a time. This limit is there as a performance precaution, since deleting more Contacts at a time could cause performance degradation issues.

If you need to delete large numbers of Contacts, visit the :doc:`segment docs</segments/manage_segments>` which explains how to delete thousands of Contacts easily.


Individual Contact details


Each Contact has a detail page where you can see what Mautic knows about them.

Engagements chart

The Engagements line chart display how active the Contact was in the past 6 months. Engagement is any action the Contact made. For example: page hit, Form submission, Email open and so on. The chart displays also the Points which the Contact received.

Image

* **Gravatar** - By default, Mautic pulls images from Gravatar. If there's a :xref:`Gravatar` associated with the Contact's Email address, Mautic adds the Gravatar photo to the Contact record.

* **Custom** - To add a custom image file to a Contact, edit the Contact record and look for **Preferred profile image** under the image placeholder.

* **Social** - If you've enabled social Plugins and the record includes a social profile, you'll see options to pull in profile images.

History

Event history tracks any engagements between Mautic and a Contact. To find certain event types, search in the **Include events by source** text box. To exclude event types from the history while you're looking at it, use **Exclude events by source**.

**Accessed from IP** - IP addresses which the Contact has opened or clicked Emails, visited your tracked pages, etc. from.

**Added through API** - Contact created through API.

**Asset Downloaded** - Lists which Assets a Contact downloaded from your Landing Pages or website. Combining this information with other data can help with analyzing what led a Contact to download the Asset. If you have deleted the Asset, the timeline displays ``Deleted asset`` without a link or preview.

**Campaign Action Triggered** - Actions within Campaigns which have already happened.

**Campaign Event Scheduled** - Actions within Campaigns which take place in the future. Expand the details to see the event's scheduled date and time. Click the clock icon to reschedule the event, or click **X** to cancel the event. A warning icon means an execution error on the first try caused a rescheduling of the event.

**Campaign Membership Change** - Changes to which Campaign a Contact is a part of.

**Contact Created** - This is the first event, showing the date and time the Contact first entered your database - either as a known or anonymous Contact.

**Contact Created By Source** - The source from which the Contact originated.

**Contact Identified** - The date and time of Contact identification, moving the Contact from an anonymous to a known Contact.

**Contact Identified By Source** - How the Contact became identified.

**Do Not Contact** - The date and time the Contact unsubscribed from your messaging on a particular Channel.

**Dynamic Content sent** - When the Contact has a Dynamic Content slot pushed to them through a Campaign action.

**Email Failed** - If an Email to the Contact returns back as the Email address being an invalid address or the Email being undeliverable, Mautic displays an Email failed event with the internal name of the Email shown.

**Email Read** - The date and time when a specific Email was first read. If the Contact opens the Email multiple times, expanding details on the event type displays the additional opens.


    To avoid performance issues, Mautic has a limit of displaying a maximum of 1,000 **Email Read** event details.

**Email Replied** - If a Contact replies to an Email sent through Mautic, the reply displays on the Contact record with this event type. To see this, you must have the **Contact Replies** inbox configured in **Settings** > **Configuration** > **Email Settings**.

**Email Sent** - When sending a specific Email to a Contact, Mautic lists the internal name of the Email and the time & date of that send.

**Form Submitted** - Along with showing the name and time and date of the Form submission, expanding the details on this event type shows the data collected on the Form and the location of the Form - called the referrer.

**Imported** - Dates, times, and file names for all CSV imports that included a Contact.

**Integration Sync Notice** - Information about connections with Integrations.

**Message Queue** - When exceeding a Contact's frequency limits for a Channel and a message on that Channel later triggers to send, a Message Queue event displays with the Channel and the ID for the message that's queued. Expanding details displays:

* originally scheduled send date
* rescheduled send date
* current status

If the message is ``Pending``, clicking the X button cancels it.

**Page Hit** - Time and date of page visits, and the URL if it's a tracked page on your site or the internal name of a Mautic Landing Page. You may view more information, if tracked, by expanding the details of this event type.

**Point Gained** The ID number of either:

* The global point action (in the **Points** section of Mautic)

* The Campaign where the point action exists, along with the name of the global point action or the Campaign, the number of Points added or subtracted, and the time & date of the point change

**Segment Membership Change** - When adding or removing Contacts from Segments by any method, those changes display in the event history.

**Stage Changed** - If you are using **Stages** in Mautic, changes to those Stages displays in the event history

**Text Message Received** - This event type is for SMS replies, if you are using SMS and have SMS reply tracking configured. Outbound SMS display as ``Campaign Event Scheduled`` or ``Campaign Action Triggered``.

**UTM Tags Recorded** - If you're using UTM tags and record them from a Form submission, Landing Page hit, etc., Mautic displays them here. Expanding the details displays the recorded tags.

**Video View Event** - Details in this event type include the length of time a prospect watched the video, the percentage of the video watched, the page where the video displays - known as Referrer - and the URL of the video file.

Some Plugins contain specific events. The events display and are searchable after installing and configuring the Plugin.

Exporting the change log

You can export the Contact's change log to CSV for offline analysis or record-keeping. The CSV includes columns for each event's timestamp, action, details, and the User or source that triggered the change.

To export the change log:


#. Click the down arrow icon to open dropdown menu in the upper right corner of the Contact detail page.
#. Select the export option.


    :align: center
    :alt: Contact detail view with the Options dropdown open, showing the Export item

|

Notes

It's possible to use Mautic as a basic Customer Relationship Management system (CRM). You or your teammates can write notes for a specific Contact. It's possible to mark a note with a specific purpose; General, Email, Call, Meeting. It's also possible to define a date of a meeting or a call.

Social

If a Contact record includes social profiles, you can see them in the **Social** tab. You must have the respective profiles set up in **Settings** > **Plugins**.

Integrations

If the Contact exists in other tools has connections through Plugin or API Integrations, you'll see those here. This helps identify where a Contact came from, or what other internal systems the Contact exists in.

Map

If Mautic knows the coordinates of the Contact from a geolocation IP lookup service, it displays a fourth tab with a map so you can easily see the Contact's location. If Mautic knows more locations for this Contact as they travel, you'll see all the locations there. If Mautic doesn't know any location, the tab won't show up.


Change Contact Segments


    :align: center
    :alt: Screenshot of change Segment

|

1. Click the **drop down box arrow** in the top right hand corner of the Contact detail.

2. Select **Segments**. A modal box shows up where you'll see all the Segments. The green switch means that the Contact belongs to the Segment, the orange switch means the opposite.

3. Click the **switch** to add/remove the Contact to/from the Segment.


Change Contact Campaigns


1. Click the **drop down box arrow** in the top right hand corner of the Contact detail.

2. Select **Campaigns**. A modal box shows up where you'll see all the Campaigns. The green switch means that the Contact belongs to the Campaign, the orange switch means the opposite.

3. Click the **switch** to add/remove the Contact to/from the Campaign.


Merge two Contacts


If you have 2 Contacts in the Mautic database who are physically one person, you can merge them with the Merge feature.

1. Click the drop down box arrow in the top right hand corner of the Contact detail,

2. Select the Merge item, a modal box shows up.

3. Search for the Contact you want to merge into the current Contact. The select box updates as you search.

4. Select the right Contact and hit the **Merge** button.


Send Email to Contact


This option lets Users send an individual Email, either manually created with the builder or from a template Email. The **From Name** and **From Email Address** default to the User sending the message.


Enter a **Subject** when you send the Email. If you leave it empty, Mautic displays the error 'A subject is required.'



Contact tracking

The act of monitoring the traffic and activity of Contacts can sometimes be somewhat technical and frustrating to understand. Mautic makes this monitoring simple and easy to configure.

Website monitoring

It's possible to use Mautic to monitor all traffic on a website by loading a JavaScript file - recommended - or by adding a tracking pixel to resources. It's important to note that traffic isn't monitored from logged-in Mautic Users. To verify that the JavaScript/pixel is working, use an incognito or private browsing window or log out of Mautic prior to testing.

Note that by default, Mautic won't track traffic originating from the same :xref:`private network` as itself, but you can configure Mautic to track this internal traffic by setting the ``track_private_ip_ranges`` configuration option to ``true`` in ``app/config/local.php`` and clearing the :xref:`symfony cache`.


Tracking script (``JavaScript``)


Since Mautic 1.4 the JavaScript tracking method is the primary way of website tracking. To implement it:

1. Go to Mautic > *Settings* by clicking the cogwheel at the top right > *Configuration* > *Tracking Settings* to find the JS tracking code build for the Mautic instance

2. Insert the code before the ending ``<body/>`` tag of the website you want to track

Or, copy the code below and change the URL to your Mautic instance.

Mautic sets cookies with a lifetime of 1 year, with returning visitors identified exclusively by the cookie. If no cookie exists yet, Mautic creates a new Contact and sets the cookie.

Make sure you enter your website URL correctly as outlined in the :doc:`CORS settings</configuration/settings>`.

Note that if a browser doesn't accept cookies, this may result in each hit creating a new visitor.


  <script>
      (function(w,d,t,u,n,a,m){w['MauticTrackingObject']=n;
          w[n]=w[n]||function(){(w[n].q=w[n].q||[]).push(arguments)},a=d.createElement(t),
          m=d.getElementsByTagName(t)[0];a.async=1;a.src=u;m.parentNode.insertBefore(a,m)
      })(window,document,'script','http(s)://example.com/mtc.js','mt');

      mt('send', 'pageview');
  </script>

*Don't forget to change the scheme (http(s)) either to http or https depending what scheme you use for your Mautic. Also, change [example.com] to the domain where your Mautic runs.*

The advantage of JavaScript tracking is that the tracking request - which can take quite long time to load - loads asynchronously, so it doesn't slow down the tracked website. JavaScript also allows you to track more information automatically:

* **Page Title** is the text written between ``</title>`` tags

* **Page Language** is the language defined in the browser.

* **Page Referrer** is the URL which the Contact came from to the current website.

* **Page URL** the URL of the current website.

``mt() events``

mt() supports two callbacks, ``onload`` and ``onerror`` accepted as the fourth argument. The ``onload`` method fires at loading of the pixel. If the pixel fails for whatever reason, it triggers ``onerror``.


     mt('send', 'pageview', {}, {
        onload: function() {
            redirect();
        },
        onerror: function() {
            redirect();
        }
    });

Local Contact cookie (first party cookie)

If you've configured CORS to allow access from the domain where you've embedded the mtc.js, Mautic places a cookie on the same domain with the name of ``mtc_id``. This cookie has the value of the ID for the currently tracked Contact but isn't used to track the Contact. This enables the server side software to access the Contact ID, and thus providing the ability to integrate with Mautic's REST API as well.

Valid Domains for CORS must include the full domain name as well as the protocol. For example, ``http://example.com``, if you serve up secure and non-secure pages you should include both ``https://example.com`` as well ``http://example.com``. All subdomains will need to be listed as well for example, ``http://example.com`` and ``http://www.example.com`` , if your server allows this. If you would like to allow all subdomains, an asterisk can be used as a wildcard for example, ``http://*.example.com``.

Tracking of custom parameters

You can attach custom parameters or overwrite the automatically generated parameters to the ``pageview`` action as you could to the tracking pixel query. To do that, update the last row of the preceding JS code like this:

``mt('send', 'pageview', {email: 'my@email.com', firstname: 'John'});``

This code sends all the automatic data to Mautic and adds also ``email`` and ``firstname``. Your system must generate the values of those fields.

The tracking code also supports Company fields. Mautic can assign a Company to your tracked Contact based on Company name. Then you have to add the ``**company**`` or ``**companyname**`` parameter to the tracking code, along with other Companies fields such as ``companyemail``, ``companyaddress1``, ``companyaddress2``, ``companyphone``, ``companycity``, ``companystate``, ``companyzipcode``, ``companycountry``, ``companywebsite``, ``companynumber_of_employees``, ``companyfax``, ``companyannual_revenue``, ``companyindustry``, ``companyindustry``, ``companydescription``.

You can also use Contact tags and UTM codes.

``mt('send', 'pageview', {email: 'my@example.com', firstname: 'John', company: 'Mautic', companyemail: 'mautic@example.com', companydescription: 'description of company', companywebsite: 'https://example.com', tags: 'addThisTag,-removeThisTag', utm_campaign: 'Some Campaign'});``


Load Event


To have JS call a function on loading of a request, define an ﻿``onload`` function in the options. This is possible due to the asynchronous loading of the JS tracking request. Here's how you do it:

``mt('send', 'pageview', {email: 'my@example.com', firstname: 'John'}, {onload: function() { alert(\"Tracking request is loaded\"); }});``

Tracking pixel

It's recommended to use the tracking script with CORS properly configured instead of the tracking pixel. If that's not possible for whatever reason, use the tracking pixel. The tracking pixel uses third party cookies for tracking.

``https://example.com/mtracking.gif``

Tracking pixel query

To get the most out of the tracking pixel, it's recommended that you pass information of the web request through the image URL.

Page information

Mautic currently supports ``page_url``, ``referrer``, ``language``, and ``page_title`` - note the deprecation of ``url`` and ``title`` due to conflicts with Contact fields.

UTM code

Currently, Mautic uses ``utm_medium``, ``utm_source``, ``utm_campaign``, ``utm_content``, and ``utm_term`` to generate the content in a new timeline entry.

``utm_campaign`` is the timeline entry's title.

``utm_medium`` displays using the following Font Awesome classes:

All the UTM tags are available in the time entry, just by toggling the entry details button.

Please note that Mautic records UTM tags only on a Form submission that contains the action \"Record UTM Tags\".

   :widths: 100 100
   :header-rows: 1

   * - Values
     - Class
   * - social, ``socialmedia``
     - ``fa-share-alt`` if utm_source isn't available, otherwise Mautic uses ``utm_source`` as the class. For example, if ``utm_source`` is Twitter, the entry uses ``fa-twitter``.
   * - ``email``, ``newsletter``
     - ``fa-envelope-o``
   * - ``banner``, ``ad``
     - ``fa-bullseye``
   * - ``cpc``
     - ``fa-money``
   * - ``location``
     - ``fa-map-marker``
   * - ``device``
     - ``fa-tablet`` if ``utm_source`` isn't available otherwise Mautic uses ``utm_source`` as the class. For example, if ``utm_source`` is ``Mobile``, Mautic uses ``fa-mobile``.

All the UTM tags are available in the time entry, just by toggling the entry details button.

Please note that Mautic records UTM tags only on a Form submission that contains the action \"Record UTM Tags\".

Updating Contact fields

You can also pass information specific to your Contact by setting Mautic Contact ``field(s)`` to be publicly editable. Note that values appended to the tracking pixel should be ``url`` encoded - %20 for spaces, %40 for @, etc.

Tags

You can change the Contact's Tags by using the ``tags`` query parameter. You can separate multiple Tags by comma. To remove a Tag, prefix it with a dash (minus sign).

For example, ``mtracking.gif?tags=ProductA``,-ProductB would add the ProductA Tag to the Contact and remove ProductB.

Embedding the pixel

If you're using a Content Management System, the easiest way is to let one of the available Plugins do this for you - see below. Note that the Plugins may not support all Contact fields, UTM codes or Contact tags.

Here are a couple code snippets that may help as well:

HTML snippet


    <img src=\"https://example.com/mtracking.gif?page_url=http%3a%2f%2fexample.com%2fyour-product-page&page_title=Some%20Cool%20Product&email=user%40theirdomain.com&tags=ProductA,-ProductB\" style=\"display: none;\"  alt=\"mautic is open source marketing automation\" />

PHP snippet


    \$d = urlencode(base64_encode(serialize(array(
    'page_url'   => 'https://' . \$_SERVER[HTTP_HOST] . \$_SERVER['REQUEST_URI'],
    'page_title' => \$pageTitle,    // Use your website's means of retrieving the title or manually insert it
    'email' => \$loggedInUsersEmail // Use your website's means of user management to retrieve the email
    ))));

    echo '<img src=\"https://example.com/mtracking.gif?d=' . \$d . '\" style=\"display: none;\" />';

JavaScript snippet


    <script>
        var mauticUrl = 'https://example.com';
        var src = mauticUrl + '/mtracking.gif?page_url=' + encodeURIComponent(window.location.href) + '&page_title=' + encodeURIComponent(document.title);
        var img = document.createElement('img');
        img.style.width  = '1px';
        img.style.height  = '1px';
        img.style.display = 'none';
        img.src = src;
        var body = document.getElementsByTagName('body')[0];
        body.appendChild(img);
    </script>


Available Plugins


Mautic makes this even easier by providing key Integrations to many existing Content Management Systems. You can download and use any of the following Plugins to automatically add that tracking pixel to your website.


* Joomla!
* Drupal
* WordPress
* TYPO3
* Concrete5
* Grav


These are just a few of the Integrations already created by the Mautic community. It's expected that the list grows as developers submit their own Integrations.


    It's important to note that you aren't limited by these Plugins and you can place the tracking pixel directly on any HTML page for website tracking.

Identify visitors by tracking URL

There's a configuration section for identifying visitors by tracking URL although this isn't recommended for use as it's open to abuse with spoof tracking. If enabled, Mautic identifies returning visitors by tracking URLs from Channels - especially from Emails - when no cookie exists yet.


    For this to work you must mark the Email Contact field as a unique identifier and it must be publicly editable in your Mautic configuration.

How are Contacts tracked with the tracking script?

When using the tracking script, Mautic tracks Contacts with third party cookies on the Mautic instance's domain and/or the browser's local storage.

Although the script writes first party cookies to the tracked domain which expires with the session, they're **not** used for tracking. See :ref:`Local Contact cookie (first party cookie)<local-contact-cookies>`.

When a Contact visits the website for the first time, the tracking script makes a call to Mautic. Mautic looks for the ``mautic_device_id`` cookie on its domain. If Mautic finds the cookie and identifies the ``device_id`` in its database, it associates the request with the Contact tied to that specific device.

Mautic returns the Contact ID, the device ID, and a legacy session ID which is the same as the device ID. Mautic stores these values in the browser's local storage - if applicable - and it's written to the site's domain as a first party cookie - not used for tracking.```

The next time the tracking script sends a request to Mautic, it uses the device ID from the browser's local storage to identify the tracked Contact. If Mautic can't find it, it uses the cookies stored on it's own domain, using third party cookies to identify the Contact.

Mobile monitoring

The essence of monitoring what happens in an App is similar to monitoring what happens on a website. Mautic contains the building blocks needed for native - or pseudo-native - and HTML5-wrapper based Apps, regardless of platform.

In short, use named screen views - for example, ``main_screen`` - in your App as your page_url field in the tracker, and the Contact's Email as the unique identifier, see next section for detailed instructions.

Steps in Mautic

1. Make the Email field publicly editable, this means that a call to the tracking GIF with the variable ``email`` gets properly recognized by Mautic.

2. Set up a Form, as the access point of your Campaign - for example, a new Contact Email. Make this Form as simple as you can, as you POST to it from your App. The typical Form URL you POST to is ``https://example.com/form/submit?formId=<form_id>``

You can get the ID from the Mautic URL as you view / edit the Form in the Mautic interface or in the Forms tables, last column. You can find the Form Fields by looking at the HTML of the 'Manual Copy' of the HTML in the Forms editing page.

3. Define in your Campaigns the screens you want to use as triggers - for example, ``cart_screen`` etc. Mautic isn't looking for a real URL in the Form ``https://`` for ``page_url``, any typical string would do. Like this: ``https://example.com/mtracking.gif?page_url=cart_screen&email=myemail@example.com``


In your App


A best-in-class approach is to have a class (say 'Mautic') that handles all your tracking needs. For example, this sample method call would POST to the Form with ID 3 - see previous section.

 .. note::

  For conciseness and ubiquity, these samples are in JavaScript / ECMAScript-type language, use similar call in your mobile App language of choice.

``mautic.addContact(\"myemail@example.com\",3)``

And then, to track individual Contact activity in the App, this sample call would make an ``HTTP`` request to the tracker:

``mautic.track(\"cart_screen\", \"myemail@example.com\")``

Which is nothing more than an ``HTTP`` request to this GET-formatted URL - as also shown in previous section:

``https://example.com/mtracking.gif?page_url=cart_screen&email=myemail@example.com``



    Make sure in your App, that the ``HTTP`` request is using a cookie - if possible, re-use the cookie from the ``mautic.addcontact`` POST request prior - **and** that you reuse this cookie from one request to the next. This is how Mautic - and other tracking software - knows that it's really the same Contact. If you can't do this, you may run into the - unlikely but possible - case where you have multiple Contacts from the same IP address and Mautic merges them all into a single Contact, as it can't tell who is who without a cookie.


Google Analytics and Facebook Pixel tracking support


Mautic supports Contact tracking using Google Analytics and the Facebook pixel. Go to Mautic **Configuration** > **Tracking Settings** and set up:

* **Google Analytics ID**
* **Facebook Pixel ID**

Tracking codes support also Google Analytics USERID and Facebook Pixel Advanced Matching.


Campaign action Send tracking event


There is a Campaign action which allows you to send a custom event to Google Analytics or Facebook Pixel - it depends on there being a 'Visits a Page' decision immediately before it in the Campaign workflow.


How to test Google Analytics tracking code and campaign action


* Install **Tag Assistant** and enable recording on your website
* Create Campaign with the 'Visits a Page' decision and 'Send tracking event' action
* Test it and verify in the Tag Assistant debug window that you see one ``Pageview`` request and one event

    :align: center
    :alt: Screenshot of Google Analytics

|


How to test Facebook Pixel tracking code and Campaign action


* Install the Facebook Pixel Helper
* Create Campaign with a 'Visits a Page' decision and a 'Send tracking event' action
* Test it and verify in the Facebook Pixel Helper debug window that you see one ``Pageview`` and one custom event action

    :align: center
    :alt: Screenshot of Facebook pixel

|

You can use events for Remarketing with Analytics and Facebook Ads.


Other Online Monitoring


There are several other ways to monitor Contact activity and attach Points to those activities. Website monitoring is only one way to track Contacts. Other Contact monitoring activities can consist of forum posts, chat room messages, mailing list discussion posts, GitHub/Bitbucket messages, code submissions, social media posts, and a myriad of other options.

Troubleshooting

If the tracking doesn't work, take a look at the :ref:`troubleshooting<troubleshooting>` section.

Cookies used by Mautic

This is a list of cookies potentially used by Mautic when tracking Contacts. Note that if using the tracking script, Mautic uses the browser's local storage to store a device ID used to track the Contact.

Third party cookies

    :header-rows: 1
    :widths: 20 25 30 25

   * - Name
     - Expiration
     - Used by Mautic for tracking?
     - Description
   * - mautic_device_id
     - 1 year
     - Yes
     - Used by Mautic to track the Contact for either the tracking pixel or if the same key isn't found in the browser's local storage for the monitored site.
   * - ``mtc_id``
     - session
     - No
     - Stores the Mautic ID of the tracked Contact. No longer used - deprecated in Mautic 2.13 - but retained for backwards compatibility.
   * - ``mautic_referer_id``
     - session
     - Yes
     - Stores a reference to the last tracked page for the Contact and used by Mautic to determine when a Contact exists a page they visited.
   * - ``mtc_sid``
     - session
     - No
     - Deprecated cookie that's the same as ``mautic_device_id``. It's no longer actively used by Mautic but kept for BC reads.
   * - ``mautic_session_id``
     - unknown
     - No
     - Deprecated in Mautic 2 - no longer supported - and removed from Mautic 3

First party

    :header-rows: 1
    :widths: 20 25 30 25

   * - Name
     - Expiration
     - Used by Mautic for tracking?
     - Description
   * - mautic_device_id
     - session
     - No
     - The monitored site may use this, but isn't used by Mautic to actively track the Contact.
   * - ``mtc_id``
     - session
     - No
     - Stores the Mautic ID for the tracked Contact. It's not used for tracking. The monitored site can use this to leverage Mautic's REST API on the backend for the purposes of manipulating the Contact.
   * - ``mtc_sid``
     - session
     - No
     - Deprecated cookie that's the same as ``mautic_device_id``. It's no longer used by Mautic but kept for BC reads.""",
    ),

    AppLesson(
      title: "Preference Center",
      body: r"""Preference center


Manage Contact preferences


When managing a Contact in Mautic, you have the ability to customize their communication preferences. To access the Contact's Preference Center, follow these steps:

1. Open the Contact's profile - To access a Contact's profile, navigate to the Contacts section in Mautic and click the desired Contact's name.

2. Access the Preference Center - Once you are viewing the Contact's profile, locate the dropdown menu and click the **Preferences** option. A new modal window appears with various customization options.

In the Preference Center, you find three main tabs:

* Channels and Frequency - This tab allows you to set the preferred Channels for communicating with the Contact and how often they should receive messages. You can also pause communication for a specified period if needed.

* Categories - In this tab, you have the option to add or remove the Contact from global Categories used in Emails or other marketing materials. This helps to ensure that the Contact only receives content relevant to their interests.

* Segments - The third tab enables you to add or remove the Contact from specific Segments they belong to. This is useful for refining your audience and targeting Contacts based on their behavior, preferences, or other attributes.


Preferred Channels and frequency


    :align: center
    :alt: Screenshot of Preference

|

In this window you can switch Channels of communication, set the frequency of the communication via each Channel enabled, and set one of the Channels as a preferred Channel.

To prevent communications through a Channel, remove the select next to the Channel name in the first column. This sets a Do Not Contact (DNC entry) for only that Channel.

When selecting a Channel, Mautic uses this to send Marketing Messages if there is a message set for any of the Channels selected. You can also set the frequency of the communication, as in this example the set frequency is \"Send Emails twice a day\" but to pause them between November 1 2022 and November 30 2022. Email is also set as the preferred Channel, so if the Marketing Message has the same message for both Email and SMS, it only sends the Email version of the message to the selected Contact


Contact Categories


    :align: center
    :alt: Screenshot of Categories

|

Use the Categories tab to add or remove a Contact from a global Category. Mautic uses Global Categories in areas like Emails, Text Messages and, Campaigns. In combination with the Subscribed Categories Segment filter, Contacts can opt out of categorized communications.


Contact Segments


    :align: center
    :alt: Screenshot of Segments

|

Use the Segments tab to add or remove a Contact from a Segment. Segments are a source for both starting Campaigns and sending Emails. Any Contact in a particular Segment is automatically part of a Campaign that has that Segment as the source. You can also use a standalone Email to manually send an Email to a Segment. If a User has opted out of a Segment they no longer receive Campaign actions or messages sent to that Segment.


Contact's unsubscribe Email preferences


    :align: center
    :alt: Screenshot of Email unsubscribe

|

You can customize the unsubscribe page to display a Contact's preferences by adjusting the Email configuration settings in Mautic. This allows Contacts to manage their preferences when they unsubscribe, instead of being directly unsubscribed. Follow these steps:

1. In the left sidebar, click the gear icon to access the **Configuration** menu.

2. Navigate to the **Email Settings** tab.

3. Look for the \"Show Contact Preference Settings\" option and select the box to enable it. This displays Contact preferences on the unsubscribe page, allowing Contacts to manage their subscription settings.

4. Additionally, you can choose to hide or show different Segments in the User preferences by adjusting the corresponding settings.

Please note that if you turn off any of these options in the global settings, they won't appear on the Contact's personal preferences page. When the preference setting option is turn off, Mautic shows the default unsubscribe message, and the Contact gets directly unsubscribed without the ability to manage their preferences.

    :align: center
    :alt: Screenshot of Unsubscribe

|

Customize Preference Center

It's possible to customize the personal Preference Center/unsubscribe page, edit text labels, format, and apply Themes using the Landing Page builder.


Creating a Preference Center Landing Page


When creating/editing a Landing Page, there is a toggle switch labeled *Is Preference Center*. If selected, Mautic marks the Page as a Preference Center Landing Page, making available the appropriate tokens.

When configured as a Preference Center in a Mautic Email, Mautic automatically directs recipients to this Preference Center when clicking on the ``{unsubscribe_url}`` link. It also shows or hides the Preference Center slots in the Builder.

    :align: center
    :alt: Screenshot of Preference Center switch on a Landing Page

|

Preference tokens

You can use :ref:`Preference Center Landing Page tokens` to insert the different slots. These are available as tokens in the editor in the GrapesJS Builder.

    :align: center
    :alt: Screenshot of Preference Center tokens in editor

|

See the :ref:`Variables<preference center landing page tokens>` documentation for a full list of tokens available for use with a Preference Center.

In addition, add a **Save preferences** button if you wish to save the preferences, otherwise the Contact can't save their preferences:

Save your changes, and the Preference Center Landing Page is ready.


Accessing Preference Center Pages


Now in the Landing Pages list, the icon with the cog icon indicates that the Page is a Preference Center.

    :align: center
    :alt: Screenshot of Preference Center showing icon to denote a Preference Center

|

When viewing a Preference Center Page, there is a header indicating its purpose and the Page URL isn't available, only the preview URL.

    :align: center
    :alt: Screenshot of Preference Center with the preview URL only

|


Setting Preference Center Pages in Emails


When creating or editing an Email, you can select the Preference Center Page from the list as shown:

    :align: center
    :alt: Screenshot of Preference Center select box when creating an Email

|

Keep in mind that your mail must use the same language as the Preference Center landing page - if not, Mautic shows the default Preference Center.

Now when sending the Email, all recipients can click the Unsubscribe link provided in the ``{unsubscribe_text}`` and ``{unsubscribe_url}`` variables, taking them to the new Preference Center.

    :align: center
    :alt: Screenshot of Preference Center as a Contact

|

If you don't select a Preference Center in an Email, Mautic uses the default Preference Center styled with the default Theme.

    :align: center
    :alt: Screenshot of Unsubscribe""",
    ),

    AppLesson(
      title: "Tags",
      body: r"""Tags


Tags are flexible labels you can add to or remove from Contacts at any time. Unlike Segments, which group Contacts based on filters, Tags let you manually categorize Contacts for quick identification, filtering, and triggering Campaign actions.


Managing Tags



Creating Tags


Tags don't require pre-creation. You can create new Tags directly when applying them to Contacts - type a new Tag name in any Tag field, and Mautic creates it automatically.

To view existing Tags, navigate to a Contact's record and look at the Tags field, or use the Tag filter when searching Contacts.


Adding Tags to Contacts


Manual assignment


#. Navigate to the Contact's record.
#. Click **Edit** to open the Contact edit form.
#. In the **Tags** field, start typing to search existing Tags or enter a new Tag name.
#. Press Enter or select from the dropdown to apply the Tag.
#. Click **Save** to save the changes.


Batch updates

#. Navigate to the **Contacts** section.
#. Use filters to find the Contacts you want to update.
#. Select the checkboxes next to the desired Contacts.
#. Click the green arrow at the top of the column.
#. Select **Change Tags** from the dropdown menu.
#. Choose Tags to add or remove.
#. Click **Save**.

Using the tracking script

You can also add or remove Tags from Contacts using the tracking script or tracking pixel. For more information, see :ref:`Contact tracking` section.


Using Tags in Campaigns



Modify Contact's Tags action


Use the **Modify Contact's Tags** action to add or remove Tags from Contacts as they progress through a Campaign.

#. In the Campaign Builder, click the connector below an event.
#. Select **Action**.
#. Choose **Modify Contact's Tags**.
#. Select Tags to add or remove.
#. Click **Add** to save the action.

This action is useful for marking Contacts who have reached certain Stages, completed specific Actions, or require follow-up.


Contact Tags condition


Use the **Contact Tags** condition to create different Campaign paths based on whether a Contact has specific Tags.

#. In the Campaign Builder, click the connector below an event.
#. Select **Condition**.
#. Choose **Contact Tags**.
#. Configure which Tags to match.
#. Click **Add** to save the condition.

Contacts with matching Tags follow the **Yes** path, while others follow the **No** path.


Using Tags in Forms


You can automatically add or remove Tags when a Contact submits a Form.

#. Navigate to **Components** > **Forms** and edit a Form.
#. In the Form builder, go to the **Actions** tab.
#. Click **Add new action** and select **Modify Contact's Tags**.
#. Select Tags to add or remove upon Form submission.
#. Click **Add** to save the action.

This is helpful for tagging Contacts based on which Forms they complete, such as marking someone as interested in a specific product.


Using Tags in Segments


You can use Tags as filters when building Segments:

#. Navigate to **Segments** and create or edit a Segment.
#. Go to the **Filters** tab.
#. Add a filter and select **Tags** from the Contact field options.
#. Choose the operator. For example, **Includes**, **Excludes**, **Empty**, or **Not empty**.
#. Select the Tag or Tags to filter by.
#. Click **Save** to apply the filter.

This creates Segments of Contacts who have - or don't have - specific Tags applied.


Searching Contacts by Tags


You can search for Contacts with specific Tags using the search bar:

* To find Contacts with a specific Tag, use ``tag:tagname``
* To find Contacts without a specific Tag, use ``!tag:tagname``

Replace ``tagname`` with the actual name of the Tag. If the Tag name contains spaces, wrap it in quotes, for example, ``tag:\"tag name\"``.

Best practices

* **Use consistent naming conventions** - Establish naming rules to avoid duplicates, such as 'Webinar' and 'webinar-attendee', for similar purposes.
* **Document your Tag taxonomy** - Keep a record of what each Tag means and when to use it.
* **Avoid over-tagging** - Too many Tags can become difficult to manage. Consider whether a Segment or Custom Field might be more appropriate.
* **Review Tags regularly** - Periodically audit your Tags to remove outdated or unused ones.
* **Combine with Segments** - Use Tags for quick manual labeling and Segments for dynamic, filter-based grouping.""",
    ),

  ],
),

AppCourse(
  id: "marketing_10",
  title: "Dashboard",
  description: "Dashboard",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "1 Lessons",
  lessons: [
    AppLesson(
      title: "Dashboard",
      body: r"""Dashboard

Mautic 1.4.0 introduced a customizable dashboard where each User can compose widgets with information they want to track. Mautic 2.0 brought a number of enhancements to the Dashboard.

Date range filter

All the widgets display data in the selected global date range filter at the top of the widget list. Mautic sets the default date range from 30 days ago to today.

  :width: 600
  :alt: Screenshot of Dashboard date filter

Line charts change the time unit automatically depending on the day count selected in the date range filter like this:

**Date range is equal 1 day:** data displays in hours
**Date range is between 1 and 31 days:** data displays in days
**Date range is between 32 and 100 days:** data displays in weeks
**Date range is between 101 and 1000 days:** data displays in months
**Date range is greater than 1001 days:** data displays in years

The only widget exceptions which display the same information independent on the date range are *Upcoming Emails* and *Recent activity*.

Widgets


  Don't create too many widgets. It can slow the dashboard Landing Page load down. If you have performance issues, decrease the amount of widgets.

You can add a new widget to your dashboard when you click the \"Add widget\" button. The \"Add widget\" Form which appears after each widget allows you define:

- **Name:** describe what the widget displays. If not filled, Mautic calls it the same as the widget type you select.

- **Type:** select what information you want to display from the predefined widget types.

- **Width:** select how wide the widget should be. The options are 25%, 50%, 75%, 100%. The default option is 100%. The optimal width for line charts is 100%, for tables 50%, for pie charts 25%.

- **Height:** each widget can have different height. There are 5 heights predefined. The dashboard looks best if you select a consistent height for each widget in the same row.

Some widgets have additional options:

**Created Contacts over time**

- Show all Contacts: displays one line with all created Contacts.

- Only identified: displays one line with only created and identified Contacts.

- Only anonymous: displays one line with only anonymous visitors.

- All identified vs anonymous: displays 2 lines with anonymous visitors and known Contacts.

- Top Segments: displays up to 6 lines representing the number of Contacts added to the top 6 Segments. If no such Segment exists for the selected date range, the chart won't display.

- Top Segments with Identified vs Anonymous: displays up to 6 lines representing the top 3 Segments for the selected date range. Each Segment shows 2 lines with anonymous visitors and known Contacts.

**Emails in time**

- Only sent Email - Displays 1 line with sent Emails.

- Only opened Emails - Displays 1 line with opened Emails.

- Only failed Emails - Displays 1 line with failed Emails.

- Sent and opened Emails - Displays 2 lines with sent and opened Emails.

- Sent, opened and failed Emails - Displays 3 lines with sent, opened and failed Emails.

**Landing Page visits in time**

- Total visits - Displays 1 line with all visits (Landing Page hits).

- Unique visits - Displays 1 line with unique visits (Contacts).

- Total and unique visits - Displays 2 lines with unique and all visits.

Widget ordering

You can move each widget can on the dashboard using the drag and drop interface. Click and hold on the name of the widget to move it to another position.

Dashboard export

Each dashboard, once configured, is exportable to a single file and shared with others. You can make a backup, send it to a colleague or share it online. It exports only the widget configuration - the data which it pulls isn't included in the exported file.

Dashboard import

If you export a dashboard, you can then upload it and import it again in the Dashboard Import page.

Mautic installations come pre-loaded with 3 pre-defined dashboards. Mautic imports the one called default.json automatically, when your dashboard doesn't contain any widgets. The other 2 predefined dashboards provide an example of alternate layouts. You can export and import any other dashboards and switch between them.

Pre-defined dashboards can be:

**Previewed** - This displays the dashboard widgets for preview. The dashboard loads using your existing Mautic dat but doesn't save or change anything.

**Applied** - This sets the dashboard as your primary dashboard.


  This deletes your current widgets. Export the current dashboard if you want to go back to it later.

**Deleted** - This deletes the predefined dashboard.


Widget cache

The ``WidgetDetailEvent`` automatically caches the widget detail data for a period of time defined in the configuration. The default cache expiration period is 10 minutes.

Dashboard permissions

If a Mautic User doesn't have the 'see others' or 'see own' permissions for a bundle, they won't be able to create widgets for that bundle. However, the widget can still be visible on their dashboard.

For example if a User creates the widgets and then the administrator removes the permission for that bundle, or if a User imports a dashboard which has widgets for bundles they're not permitted to access.

In these cases, Mautic displays the widget on the dashboard, but with a message that the User doesn't have permission to see the data.

If a Mautic User has permission to see only their own data from a bundle, they see only their own data in the Dashboard widgets. For example only Contacts which they own, Landing Page hits of the Landing Pages they created and so on.""",
    ),

  ],
),

AppCourse(
  id: "marketing_11",
  title: "Getting Started",
  description: "Getting Started",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "3 Lessons",
  lessons: [
    AppLesson(
      title: "How To Install Mautic",
      body: r"""Installation

There are several ways to install Mautic, you should select the most appropriate method for your situation and technical knowledge.

- Installing :ref:`using the production package<Using the production package>`, with either the :ref:`web-based installer<using the web-based installer>` or :ref:`from the command line<Installing with command line>`.

- Installing locally by :ref:`cloning from GitHub<Installing from GitHub>` - for testing and local development,

- :ref:`Installing with Composer`

Using the production package

You can install the Mautic production package either by uploading the zipped installation package into the server location or using the command-line installation. The Mautic production package also requires access to a database server.

The Mautic installation is a three-step process:

1. Integrate the database server with the Mautic server.

2. Create an administrator account to access the Mautic server.

3. Set up the Email server for Email marketing automation.

Preparing for installation

Before installing a package, ensure that:

* Your server environment meets the minimum requirements for the version you are installing. Read more in :xref:`Mautic's Requirements`.

* Your server directory is writable by the Mautic web server.

* Your database meets the minimum requirements for the supported databases and valid User permissions to access to the database. Read more in :xref:`Mautic's Requirements`.

* Your server has enough free disk space to run the installation. Consider the database size as well.

* PHP's ``max_execution_time`` is at least 240 seconds.

Downloading a production package

To get started :xref:`Download Mautic` to access the zip file of the latest stable release.

For more information about the available Mautic packages, visit the :xref:`Mautic Releases` Landing Page.

Uploading the production package

After downloading a desired package, upload the package zip file to your web server, and unzip it in the directory where you plan to host the Mautic instance.

Your web server must have the permissions to access the unzipped files.

Using the web-based installer

To access the Mautic server from your browser, enter the URL that corresponds to the Mautic instance (for example, `https://m.example.com`) in your web browser. It's recommended to secure your installation with an SSL certificate (https).

Conducting environment checks

After loading the package in the server, the Mautic installer validates if it can run successfully in your server environment.

You must resolve installation errors, displayed in red, before completing the Mautic package installation successfully. Warnings, displayed in orange, are often recommendations for a better Mautic experience.

  :width: 600
  :alt: Screenshot showing Mautic pre-flight checks with warning about installing on a non-SSL connection

If the environment checks are successful - displayed in green - click **Next Step** to begin the installation process.

Integrating the database

Mautic assumes that the database is on the same server as Mautic.

For setting the database server on the **Mautic Installation-Database Setup** window:

* Select **Database Driver**.

* Enter **Database Host**.

* Enter **Database Name**.

* Enter **Database Username**.

* If desired, you can also enter values for **Database Port**, **Database Table Prefix**, **Database Password**, and **Prefix for backup tables**.

* **Backup existing tables?** is on by default, but you should turn it off for a new installation.

  :width: 600
  :alt: Screenshot of database configuration screen

Click **Next Step**.

Creating the administrator account

To create an Administrator account for your Mautic instance, enter values for the different fields on the **Mautic Installation - Administrative User** window.

  :width: 600
  :alt: Screenshot showing the create User screen

Click **Next Step**.


Configuring Email settings


To configure your Email settings for your Mautic instance, enter details of your Email provider on the **Mautic Installation - Email Configuration** window. You can use a tool such as :xref:`Mailhog` to configure a local instance for testing.

  :width: 600
  :alt: Screenshot showing the Email configuration screen

For configuring your Email sender settings:

* Enter the name and Email address to use with all outgoing Email communications by default. Verify that the provided Email address has been successfully authorized by your Email provider.

* **Queue** Emails and send them through a cron job - to trigger the queue processing - instead of sending them immediately for larger instances of Email handling.

* Select **Mailer transport**. If your provider isn't listed, select **Other SMTP Server** and provide the SMTP credentials. API-based sending is significantly faster than SMTP. Depending on the provider you select, additional fields appear to allow you to enter API keys and select regions.

* Enter **Server** and **Port** for your Email provider.

* Select **Encryption** and **Authentication mode** for your Email provider.

Click **Next Step** to log into the Mautic server.

Logging into Mautic

On the Mautic login window, enter your Mautic administrator credentials to log into your Mautic instance.

  :width: 600
  :alt: Screenshot of Mautic login screen

Click **login** to continue working on your Mautic instance.

Installing with command line

You can also install Mautic using the command line. You can either pass the settings parameters in the command, or create a local PHP file with your database settings. You can also define properties in this file using the syntax expected by the command-line options. Note that Mautic requires a complex password from version 5.1.

Use the command ``path/to/php bin/console mautic:install --help`` for the list of options and flags available.


     --db_driver=DB_DRIVER                    Database driver. [default: \"pdo_mysql\"]
      --db_host=DB_HOST                        Database host.
      --db_port=DB_PORT                        Database port.
      --db_name=DB_NAME                        Database name.
      --db_user=DB_USER                        Database user.
      --db_password=DB_PASSWORD                Database password.
      --db_table_prefix=DB_TABLE_PREFIX        Database tables prefix.
      --db_backup_tables=DB_BACKUP_TABLES      Backup database tables if they exist; otherwise drop them. [default: true]
      --db_backup_prefix=DB_BACKUP_PREFIX      Database backup tables prefix. [default: \"bak_\"]
      --admin_firstname=ADMIN_FIRSTNAME        Admin first name.
      --admin_lastname=ADMIN_LASTNAME          Admin last name.
      --admin_username=ADMIN_USERNAME          Admin username.
      --admin_email=ADMIN_EMAIL                Admin email.
      --admin_password=ADMIN_PASSWORD          Admin user.
      --mailer_from_name[=MAILER_FROM_NAME]    From name for email sent from Mautic.
      --mailer_from_email[=MAILER_FROM_EMAIL]  From email sent from Mautic.
      --mailer_transport[=MAILER_TRANSPORT]    Mail transport.
      --mailer_host=MAILER_HOST                SMTP host.
      --mailer_port=MAILER_PORT                SMTP port.
      --mailer_user=MAILER_USER                SMTP username.
      --mailer_password[=MAILER_PASSWORD]      SMTP password.
      --mailer_encryption[=MAILER_ENCRYPTION]  SMTP encryption (null|tls|ssl).
      --mailer_auth_mode[=MAILER_AUTH_MODE]    SMTP auth mode (null|plain|login|cram-md5).
      --mailer_spool_type=MAILER_SPOOL_TYPE    Spool mode (file|memory).
      --mailer_spool_path=MAILER_SPOOL_PATH    Spool path.

Use the syntax below within a ``local.php`` file:


  <?php
  // Example local.php to test install (to adapt of course)
  \$parameters = array(
    // Do not set db_driver and mailer_from_name as they are used to assume Mautic is installed
    'db_host' => 'localhost',
    'db_table_prefix' => null,
    'db_port' => 3306,
    'db_name' => 'mautic',
    'db_user' => 'mautic',
    'db_password' => 'mautic',
    'db_backup_tables' => false,
    'db_backup_prefix' => 'bak_',
    'admin_email' => 'admin@example.com',
    'admin_password' => 'Maut1cR0cks!',
    'mailer_transport' => null,
    'mailer_host' => null,
    'mailer_port' => null,
    'mailer_user' => null,
    'mailer_password' => null,
    'mailer_api_key' => null,
    'mailer_encryption' => null,
    'mailer_auth_mode' => null,
  );

Installing with a local PHP file

Run the following command after replacing the path to PHP bin and Mautic instance URL.

``path/to/php bin/console mautic:install https://m.example.com``

If desired, you can also add parameters in the install command:


  path/to/php bin/console mautic:install https://m.example.com
  --mailer_from_name=\"Example From Name\" --mailer_from_email=\"mautic@localhost\"
  --mailer_transport=\"smtp\" --mailer_host=\"localhost\" --mailer_port=\"1025\"
  --db_driver=\"pdo_mysql\" --db_host=\"db\" --db_port=\"3306\" --db_name=\"db\" --db_user=\"db\" --db_password=\"db\"
  --db_backup_tables=\"false\" --admin_email=\"admin@mautic.local\" --admin_password=\"Maut1cR0cks!\"

As the installation process begins, it flags up warnings and aborts if there are any critical errors.


  Mautic Install
  ==============

  Parsing options and arguments...
  0 - Checking installation requirements...
  Missing optional settings:
    - [0] The <strong>memory_limit</strong> setting in your PHP configuration is lower than the suggested minimum limit of %min_memory_limit%. Mautic can have performance issues with large datasets without sufficient memory.
  Ready to Install!
  1 - Creating database...
  1.1 - Creating schema...
  1.2 - Loading fixtures...
  2 - Creating admin user...
  3 - Email configuration and final steps...

  ================
  Install complete
  ================

You can now login to your Mautic instance with your Mautic Admin credentials.

Installing from GitHub

It's essential to have all the files locally - including automated tests - from the GitHub repository when testing Mautic or contributing to it. Many of these files aren't included in the production build process.

Cloning Mautic from GitHub

1. Install the :xref:`GitHub CLI` tool.

2. Click **Fork** at the top-right corner of the Mautic GitHub repository to make a personal fork. You can also click to go directly to your fork if you already have one, if you don't then GitHub offers to create one.

3. After the fork is complete, click the green **Code** button to access the command for cloning the repository.

4. Switch to your terminal, and when in the directory where you wish to install Mautic, paste the command using the :xref:`GitHub CLI` tool this is in the format:


  gh repo clone username/mautic


  Please always choose to fork into a **personal account** rather than an organization. The latter prevents Mautic's maintainers from working with your Pull Request.

Install Mautic using DDEV

You can use :xref:`DDEV` which Mautic recommends for testing and development. To get started:

#.  Install :xref:`DDEV`.

#.  Install and ensure you have :xref:`Docker` running on your system.

#.  You can now change into the Mautic directory and kick off the DDEV quickstart using the command:


    ddev start


  For troubleshooting see :xref:`DDEV Troubleshooting`.

  See Mautic's :xref:`Handbook` for more detailed instructions.


This spins up a DDEV instance (which includes Mailhog, PHPMyAdmin, and Redis Commander) - by default at ``https://mautic.ddev.site`` - and also gives the option to set up Mautic ready for you to use.

This runs through the Composer install process, and installs Mautic at the command line with a default username of ``admin`` and password of ``Maut1cR0cks!`` (note: pre Mautic 5.1 the password is just `mautic`.

Installing with Composer

Since :xref:`Mautic 4` it's possible to install and manage Mautic using the full power of Composer. Mautic uses the latest version of :xref:`Composer`.

Mautic is in the process of decoupling Plugins and Themes from core, however at present while they have been technically mirrored out into separate repositories, the source files remain in the main :xref:`Mautic GitHub repository`.

When you clone from GitHub, running ``composer install`` installs all the dependencies, there are some other handy features which you can take advantage of when installing and managing Mautic.


Using the Recommended Project


The Mautic :xref:`Recommended Project` is a template which provides a starter kit for managing your Mautic dependencies with Composer.

  The instructions below refer to the global Composer installation. You might need to replace Composer with ``php composer.phar`` or something similar for your setup.

The basic command to use the Recommended Project is:


  composer create-project mautic/recommended-project:^5 some-dir --no-interaction

With Composer you can add new dependencies to install along with Mautic:


  cd your-directory
  composer require mautic/mautic/helloworld-bundle


  As this method of installation moves the core app files into a folder called ``docroot`` from which Mautic runs, you should ensure that you configure your web server to serve files from this directory. This might mean updating your virtual host and/or NGINX configuration to have ``<your directory>/docroot`` as the root directory. If you don't do this, it's likely you'll see errors when you try to access your Mautic instance.

The Composer ``create-project`` command passes ownership of all files to the created project. You should create a new git repository, and commit all files not excluded by the .gitignore file.


What does the Recommended Project template actually do?


When installing the given ``composer.json`` the following occurs:

- Install Mautic in the ``docroot`` directory. See earlier note about updating your hosting configuration.
- Autoloader uses the generated Composer autoloader in ``vendor/autoload.php``, instead of the one provided by Mautic in ``docroot/vendor/autoload.php``.
- Plugins - packages of type ``mautic-plugin`` - are in ``docroot/plugins/``.
- Themes - packages of type ``mautic-theme`` - are in ``docroot/themes/``.
- Creates ``docroot/media`` directory.
- Creates environment variables based on your ``.env`` file. See ``.env.example``.


Composer FAQs


Should you commit downloaded third party Plugins?

Composer says that the :xref:`Composer commit dependencies`. They provide arguments against but also workarounds if a project decides to do it anyway.

Should you commit the scaffolding files?

The :xref:`Mautic Composer scaffold` Plugin can download the scaffold files - for example ``index.php``, ``.htaccess`` - to the ``docroot/`` directory of your project.


If you haven't customized those files you could choose to not commit them in your version control system - for example, git. If that's the case for your project it might be convenient to automatically run the Mautic Scaffold Plugin after every install or update of your project.


You can achieve that by registering ``@composer mautic:scaffold`` as post-install and post-update command in your composer.json:



  \"scripts\": {
      \"post-install-cmd\": [
          \"@composer mautic:scaffold\",
          \"...\"
      ],
      \"post-update-cmd\": [
          \"@composer mautic:scaffold\",
          \"...\"
      ]
  },

How can you apply patches to downloaded Plugins?

If you need to apply patches - depending on the Plugin, a pull request is often a better solution - you can do so with the ``composer-patches`` Plugin.

To add a patch to Mautic Plugin foobar insert the patches section in the extra section of ``composer.json``:



  \"extra\": {
      \"patches\": {
          \"mautic/foobar\": {
              \"Patch description\": \"URL or local path to patch\"
          }
      }
  }


How can you specify a PHP version?


This project supports PHP 7.4 as the minimum version currently - review :xref:`Mautic's Requirements` however, it's possible that a Composer update may upgrade some package that could then require PHP 7+ or 8+.

To prevent this you can add this code to specify the PHP version you want to use in the config section of ``composer.json``:


  \"config\": {
      \"sort-packages\": true,
      \"platform\": {
          \"php\": \"7.4\"
      }
  },


How can you use another folder than ``docroot`` as the root folder?

By default the ``composer.json`` file places all Mautic core, Plugin and Theme files in the ``docroot`` folder.
It's possible to change this folder to your own needs.

In following examples, ``docroot`` moves into ``public``.


  Remember that you must also update your web server configuration to point to the new folder.

New installations

* Run the create-project command without installing:


  composer create-project mautic/recommended-project:^5 some-dir --no-interaction --no-install

* Do a find and replace in the ``composer.json`` file to change ``docroot/`` into ``public/``
* Review the changes in the ``composer.json`` file to ensure that there are no unintentional replacements
* Run ``composer install`` to install all dependencies in the correct location

Existing installations

* Move the ``docroot/`` to ``public/``


  mv docroot public

* Do a find and replace in the ``composer.json`` file to change ``docroot/`` to ``public/``
* Review the changes in the ``composer.json`` file to ensure that there are no unintentional replacements
* Run ``composer update --lock`` to ensure the autoloader is aware of the changed folder


Setting up a local testing environment with DDEV


Often there is a need to have a local environment for testing Mautic - for example making a backup, testing new features or bug fixes.

In Mautic, DDEV is the tool of choice for this purpose. It's very easy to work with.

To learn how to set up DDEV with Mautic, please review the documentation in the Contributors :xref:`Handbook`.""",
    ),

    AppLesson(
      title: "How To Update Mautic",
      body: r"""How to update Mautic


There are two ways to update Mautic:

1. Using the Command Line - recommended
2. Through the User interface

    If you installed Mautic using Composer or switched to a Composer-based install, jump straight to the :ref:`Updating Mautic (Composer based installs)` section below.

If your instance is in production, has a large number of Contacts and/or is  on shared hosting, it's **strongly** recommended that you update at the command line.

    Updating in the User interface requires a significant amount of resources, and can be error-prone if the server restricts resource allocation. A failed update or corrupted data can result from this. It's planned to remove this feature in Mautic 5.0, requiring updating at the command line.

Updating at the command line (non-Composer based installations)

Before you commence updating Mautic, **please ensure that you have a tested backup of your Mautic instance**.

This means that you have downloaded the files and database of your Mautic instance, and you have re-created it in a test environment somewhere and tested that everything is working as expected. This is your only recourse if there are any problems with the update. Never update without having a working, up-to-date backup.

Checking for updates at the command line

From Mautic 6, the default way to install, update and manage Mautic changes to Composer.

Since Mautic 4.2 deprecated the update feature within the Mautic User interface, you still receive a notification when a new version of Mautic is available until removal of this feature, but it's recommended to update via the command line.

  :width: 700
  :height: 200
  :alt: Screenshot showing deprecated update feature warning

    Before starting to upgrade, it's highly recommended to take a backup of your instance. If updates are available, an update notification displays, followed by step-by-step instructions in the command-line interface to complete the process.


Log in via the command line as a normal user with sudo rights. Avoid running commands as the root user to prevent file permission issues.


Change directory to the Mautic directory:


    cd /your/mautic/directory

For example, if you installed Mautic in ``/var/www/html/mautic/``, use that path.

Installing updates at the command line

If updates are available, follow these steps to apply them:

#. Find available updates:

   .. code-block:: bash

      php bin/console mautic:update:find

   The output shows if there are updates to apply. The notification includes a link to an announcement post explaining the release contents and the recommended environment requirements, such as a higher PHP version or required Plugin updates.

   .. note::

      Review the announcement link for information about the release. It may contain important information or steps to take before you update.

#. After confirming system readiness, apply the updates:

   .. code-block:: shell

       php bin/console mautic:update:apply

#. A prompt displays asking you to run the command again with an additional argument to finish the process:

   .. code-block:: shell

      php bin/console mautic:update:apply --finish


Running update commands as the web server user



When using Apache on Linux, run the following commands as the web server user - typically ``www-data``. This ensures that file ownership and permissions remain correct:


#. Find updates:

   .. code-block:: shell

      sudo -u www-data php bin/console mautic:update:find

#. Apply updates:

   .. code-block:: shell

      sudo -u www-data php bin/console mautic:update:apply

#. Finish the update:

   .. code-block:: shell

      sudo -u www-data php bin/console mautic:update:apply --finish

#. Clear the cache:

   .. code-block:: shell

      sudo -u www-data php /var/www/html/mautic/bin/console cache:clear

Fixing file permission issues

Set the owner to Apache


This command sets the owner of the Mautic directory to the Apache server user:



    sudo chown -R www-data:www-data /var/www/html/mautic

Set file permissions

Set file permissions to 644 for all files in the Mautic folder to ensure they're readable but not executable:


    sudo find /var/www/html/mautic -type f -exec chmod 644 {} +

Set directory permissions

Set directory permissions to 755 for all directories in the Mautic folder to allow the server to open and list folder contents:


    sudo find /var/www/html/mautic -type d -exec chmod 755 {} +

Set write permissions for specific directories

Set write permissions for Apache on specific directories to allow system tasks to run:


    sudo chmod -R g+w /var/www/html/mautic/var/cache \\
        /var/www/html/mautic/var/logs \\
        /var/www/html/mautic/app/config \\
        /var/www/html/mautic/media/files \\
        /var/www/html/mautic/media/images \\
        /var/www/html/mautic/translations

Updating Mautic (Composer based installs)

The Recommended Project attempts to keep all of your Mautic core files up-to-date.

The project ``mautic/core-composer-scaffold`` updates your scaffold files whenever there is an update to ``mautic/core-lib``.

If you customize any of the 'scaffolding' files - commonly ``.htaccess`` - you may need to merge conflicts if new release of Mautic results in changes to your modified files.

Follow the steps below to update your core files.

1. Backup your ``composer.lock`` and ``composer.json`` file. If something doesn't work as expected during the ``composer update`` command, restore them and run ``composer install`` to return your codebase to the state it was in before attempting to update.

2. Edit the ``composer.json`` file, and change all previous versions with the version you wish to update to for all Mautic packages.

    * If you are running ``5.0.4`` and want to update to ``5.1.0``, replace ``5.0.4`` with ``5.1.0`` for all packages that start with ``mautic/`` and currently use ``5.0.4``.
    * You may also need to increase the versions of any other packages you have either manually added or added through :ref:`Mautic Marketplace`.
    * If you haven't added any extra packages, you can also replace the entire ``composer.json`` file with the newer version from the `repository <https://github.com/mautic/recommended-project>`_ that matches your desired target version.

3. Run ``composer update --with-dependencies`` to update all packages.

4. Run ``git diff`` to determine if any of the scaffolding files have changed. Review the files for any changes and restore any customizations to ``.htaccess`` or others.

5. Commit everything all together in a single commit, so the ``docroot`` remains in sync with the core when checking out branches or running ``git bisect``.

6. In the event that there are non-trivial conflicts in step 2, you may wish to perform these steps on a branch, and use ``git merge`` to combine the updated core files with your customized files. This facilitates the use of a three-way merge tool such as :xref:`kdiff3`. This setup isn't necessary if your changes are simple - keeping all of your modifications at the beginning or end of the file is a good strategy to keep merges easy.

7. Run the following commands to update your database with any changes from the release:


    bin/console cache:clear
    bin/console mautic:update:apply --finish
    bin/console doctrine:migration:migrate --no-interaction
    bin/console cache:clear

Updating in the browser

When updating Mautic, there are several tasks which can take a long time to complete depending on the size of your Mautic instance.


    If you have a lot of Contacts and/or use shared hosting, you might run into problems when updating with the notification 'bell' icon in older versions of Mautic.

When updating within the browser, problems usually manifest as the update hanging part way through, or crashing with an error. They often arise as a result of resource limitation, particularly on shared hosting environments.

For this reason, it's **always recommended** that you :ref:`update at the command line<installing updates at the command line>` wherever possible. From Mautic 5.0 the ability to update in the browser is completely removed, and you have to update at the command line.

Before you commence updating, **please ensure that you have a tested backup of your Mautic instance**.

This means that you have downloaded the files and database of your Mautic instance, and you have re-created it in a test environment somewhere and tested that everything is working as expected. This is your only recourse if there are any problems with the update. Never update without having a working, up-to-date backup.

Checking for updates in the browser

When Mautic makes a new release, a notification appears in your Mautic instance.

The notification links to an announcement post which explains what the release includes.

    It's a good idea to read the announcement link for information about the release. There may be important information or steps that you may need to take before updating.

Once you have thoroughly read the release notes, and have tested your backup Mautic instance, you can click the notification to complete the update.

The update takes time to complete, and each step updates in the browser as it proceeds. Be patient and allow it to finish. On completion, a message confirms that the update has completed successfully.

The update wasn't successful

If this has happened to you, head over to the Troubleshooting section for a step-by-step walk-through of how to complete the update. Maybe consider using the command line next time.

Stability levels

By default, Mautic receives notifications both in the User Interface and at the command line for stable releases only.

If you wish to help with testing early access releases in a development environment, do the following

- Edit your configuration and set the stability level to Alpha, Beta, or Release Candidate. This allows you to receive notifications for early access releases.
- Always read the release notes before updating to an early access release.
- Never enable early access releases for production instances.

What to do if you need help updating Mautic

If you need help, you can ask for it in several places. You should remember that most members of the Community Forums, Slack, and GitHub are volunteers.

- The :xref:`Mautic Community Forums` is the place where you can ask questions about your configuration if you think it's the cause of the problem. Please search before posting your question, since someone may have already answered it.

- The live :xref:`Mautic Community Slack` is also available, but you must post all support requests on the forums. Create your request there first, then drop a link in Slack if you plan to discuss it there.

In all cases, it's important to provide details about the issue, as well as the steps you have taken to resolve it. At a minimum, include the following:

- Steps to reproduce your problem - a step-by-step walk-through of what you have done so far
- Your server's PHP version.
- The version of Mautic you are on, and the version you are aiming to update to
- The error messages you are seeing - if you don't see the error message directly, search for it in the var/logs folder within your Mautic directory and in the server logs. Server logs are in different places depending on your setup. Ubuntu servers generally have logs in ``/var/log/apache2/error.log``. Sometimes your hosting provider might offer a graphical interface to view logs in your Control Panel.

If you don't provide the information requested as a minimum, the person who might try to help you has to ask you for it, so please save them the trouble and provide the information upfront. Also, importantly, please be polite. Mautic is an open source project, and people are giving their free time to help you.


If you are sure that you have discovered a bug and you want to report it to developers, you can :xref:`Mautic Github New Issue` on GitHub. GitHub isn't the right place to request support or ask for help with configuration errors. Always post on the forums first if you aren't sure, if a bug report is appropriate this can link to the forum thread.""",
    ),

    AppLesson(
      title: "Switching Composer",
      body: r"""How to switch to Composer


Until Mautic 4, you could download Mautic as a ZIP file and install it on any PHP server.

However, many Mautic Users were running into installation and update errors, many of which caused considerable frustration and in some cases, significant business disruption.

In addition, Mautic recently introduced the :ref:`Mautic Marketplace` which isn't compatible with this installation method.


As a result of the reasons mentioned previously, Composer becomes the default method for installing and updating Mautic starting with the release of Mautic 5. Read more in the :xref:`composer blog post`.


Switching to a Composer-based installation

Before starting, it's good to understand that there's two aspects to Mautic:

* The database - This is where Mautic stores your Contact data.

* The codebase - This is where Mautic interacts with the database.

When switching to a Composer-based installation, the **database** isn't touched, only the **codebase.**

In this tutorial, it's assumed that Mautic is currently installed in ``/var/www/html``.

Here's the steps to follow to switch to a Composer-based installation:

#. Go to ``/var/www``

#. Run ``composer create-project mautic/recommended-project:^5 html-new --no-interaction``

#. Copy the following files and folders from ``/var/www/html`` to ``/var/www/html-new``:

   * Configuration files - in most cases, located at ``app/config/local.php`` - move to ``docroot/app/config/local.php``

   * The entire ``plugins`` directory - move to ``docroot/plugins``.

   * Uploads - in most cases, located at ``app/media/files`` and ``app/media/images`` - move to ``docroot/app/media/files`` and ``docroot/app/media/images`` respectively.

   * Custom dashboards from ``app/media/dashboards`` - move to ``docroot/app/media/dashboards``

   * Any custom Themes from ``themes`` - move to ``/docroot/themes``

   * Any translations from ``translations`` - move to ``/docroot/translations``

#. Rename ``/var/www/html`` to ``/var/www/html-old`` and ``/var/www/html-new`` to ``/var/www/html``

#. Update your web server configuration to point to ``/var/www/html/docroot`` instead of ``/var/www/html``

#. Log in to Mautic, and in your global settings enable the switch to fully manage Mautic with Composer - this also enables you to work with the Mautic Marketplace.

  :width: 600
  :alt: Screenshot of switch enable Composer

You have successfully switched to a Composer-based installation. Test Mautic to see if it works as expected.


Frequently Asked Questions

Q: Is existing data retained?

A: Yes, switching to the Composer-based installation only affects app files. It doesn't affect your data in any way.

Q: What's the minimum Mautic version required to switch to the Composer-based installation?

A: It is necessary to have at least Mautic 4.0.0 in order to switch to a Composer-based installation.""",
    ),

  ],
),

AppCourse(
  id: "marketing_12",
  title: "Marketplace",
  description: "Marketplace",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "1 Lessons",
  lessons: [
    AppLesson(
      title: "Marketplace",
      body: r"""Mautic Marketplace



    The current Marketplace version doesn't verify Mautic version compatibility of Plugins yet, as this requires a change in each existing Plugin.

    Please don't blindly manually install Plugins you see in the Mautic Marketplace, as they may not work with your version of Mautic. Always verify if they support your Mautic version before installing. Developers can refer to the :xref:`Marketplace` section in the Developer Documentation for how to make your Plugin compatible with the Mautic Marketplace.


Using the Mautic Marketplace


From Mautic 4.2, a setting in the Mautic Configuration specifies that the instance uses Composer, which allows the installation, update, and removal of Plugins in the Mautic Marketplace. This is a requirement due to the technology which underpins the Mautic Marketplace.

  :width: 800
  :alt: Screenshot of switch enable Composer

Once configured, you can search the Marketplace using the filter, and install Plugins by selecting the option from the dropdown.

  :width: 800
  :alt: Screenshot of Composer enabled

If you haven't correctly set the Composer setting, Mautic displays a warning that the Mautic Marketplace is available in read-only mode, with a link which explains how to transition to a :doc:`Composer-managed</getting_started/switching_composer>` installation.

  :width: 800
  :alt: Screenshot of Composer enabled


List of Plugins


The list of Plugins available in the Marketplace is accessible from your Mautic administration menu. Click the **cog icon** in the top right hand corner to display the menu.

The list view allows you to search for specific keywords. It displays quick stats including Plugin downloads and how many stars it has in :xref:`Packagist`. It also shows the vendor who has developed the Plugin. Sadly, the sorting by columns isn't available at the moment because it's not supported by the Packagist API. It's planned to add this in a future release.

* Click a Plugin name to view details.

  :width: 800
  :alt: Screenshot of marketplace list

Plugin detail page

The detail page gives you enough information together with links to additional resources to decide whether you want to install the Plugin or not.

  :width: 800
  :alt: Screenshot of marketplace detail


Latest stable version

The first information you see is the latest stable version. *From Mautic 4.2, this includes the currently installed - if any - version and the ability to upgrade.*

All Plugins should follow :xref:`semantic versioning` so you can see from the first glance whether it's a breaking change version, feature version or bug fix - patch - version. In short, it's more risky to install breaking change versions and less risky to install a bug fix version.

The license should be GPLv3 mostly as Mautic uses this license, and it's a viral license. This means anything using Mautic's code base should also use the same license.

Required packages are dependencies. The bigger is the list of dependencies, the bigger the size of the Plugin. More dependencies also means more security risks and incompatibility issues with future upgrades.

All versions

The next table shows the list of all versions. *In the future versions of the Marketplace it should be possible to select which version you want to install or upgrade to*.

From the list you can see Plugin versions, and the release cadence. When you click a specific version, a new window opens where the Plugin maintainers should provide a changelog. This tells you what's added or bugs fixed in the specific version.

Maintainers

In this section is a list of maintainers of the Plugin on Packagist. There may be more contributors in the GitHub repository. There is also a link to the Packagist detail page for the maintainer, where you can browse other PHP packages by the same maintainer.

GitHub information


Packagist information


All the PHP packages listed in Packagist are installable by Composer which is a tool for dependency management used under the hood when you install a Mautic Plugin. The Packagist section shows download stats of Plugin installations in different time frames.

Context menu
The context menu shows actions you can take.

* Close takes you to the List View

* Install installs the Plugin

* Issue tracker opens a new window with the issue tracker for the Plugin. It shows only if the Plugin has this information available. Use this option to search for issues with the Plugin and to report new issues to the maintainers.


Command line (CLI) command

The Marketplace has commands for those who prefer using the command line to the user interface, or for automation of processes.


List Plugins


``bin/console mautic:marketplace:list`` lists the first page of available Plugins like so:


  +-------------------------------------------------------+-----------+--------+
  | name                                                  | downloads | favers |
  +----------------------------------------------------+--------+-----+
  | mautic/mautic-saelos-bundle                           | 11623     | 11     |
  | koco/mautic-recaptcha-bundle                          | 2662      | 24     |
  |     This plugin brings reCAPTCHA integration to       |           |        |
  |     mautic.                                           |           |        |
  | thedmsgroup/mautic-extended-field-bundle              | 3069      | 25     |
  |     Extends custom fields for scalability and         |           |        |
  |     HIPAA/PCI compliance.                             |           |        |
  | mtcextendee/mautic-sql-conditions-bundle              | 190       | 6      |
  | maatoo/mautic-referrals-bundle                        | 1063      | 5      |
  |     This plugin enables referrals in mautic.          |           |        |
  | thedmsgroup/mautic-health-bundle                      | 2139      | 11     |
  |     Checks the health of the Mautic instance.         |           |        |
  | thedmsgroup/mautic-dashboard-warm-bundle              | 1921      | 12     |
  |     Improves the performance of the dashboard by      |           |        |
  |     sharing/extending/warming caches.                 |           |        |
  | thedmsgroup/mautic-contact-source-bundle              | 2852      | 43     |
  |     Creates API endpoints for receiving contacts from |           |        |
  |     external sources.                                 |           |        |
  | thedmsgroup/mautic-contact-client-bundle              | 4035      | 70     |
  |     Create custom integrations without writing code.  |           |        |
  | thedmsgroup/mautic-campaign-watch-bundle              | 1817      | 14     |
  |     Visual improvements for campaigns.                |           |        |
  | raow/mautic-rss-to-email-bundle                       | 971       | 69     |
  | mtcextendee/mautic-random-smtp-bundle                 | 101       | 10     |
  | kuzmany/mautic-recommender-bundle                     | 250       | 30     |
  | kuzmany/mautic-custom-tags-bundle                     | 119       | 20     |
  | dazzle/mautic-sendinblue-bundle                       | 73        | 5      |
  |     Allows to send E-mails with Sendinblue            |           |        |
  +-------------------------------------------------------+-----------+--------+
  Total packages: 69
  Execution time: 388 ms

There are options allowing you to filter or go to next pages. To display the full list, add ``--help`` after the command, as used in other Mautic commands.


  -p, --page[=PAGE]      Page number [default: 1]
  -l, --limit[=LIMIT]    Packages per page [default: 15]
  -f, --filter[=FILTER]  Filter the packages [default: \"\"]
  -h, --help             Display this help message

Example usage how to search for a ``Captcha`` Plugin: ``bin/console mautic:marketplace:list --filter=captcha``

Planned features

Watch out for more features in future releases including:

* Automatic Plugin updates - a configuration that allows you to set globally whether you want to automatically upgrade Plugins and also have the possibility of configuring this at the Plugin level. Automatic upgrades make sense only for bug fix releases. Other releases are too risky and manual updates required. :xref:`API reference`

* List security advisories :xref:`API reference`,

* Notifications about new versions and security vulnerabilities that identified,

* Support also Theme installations and updates.


How to get your Plugin listed on the Mautic Marketplace


Please review the resources on the :xref:`Marketplace` section in the Developer Documentation for more information.""",
    ),

  ],
),

AppCourse(
  id: "marketing_13",
  title: "Overview",
  description: "Overview",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "1 Lessons",
  lessons: [
    AppLesson(
      title: "Overview",
      body: r"""Mautic overview

The Mautic platform helps you create a strong marketing strategy for your business. With Mautic, you can:


- Connect with your Contacts over Channels like Emails, Text Messages, Social Media, and Focus Items.

  - Segment your Contacts based on business requirements and personalize your marketing strategy for each Segment.
  - Create personalized Campaigns to engage with your Contacts.
  - Use performance metrics in Dashboards, Reports, Points, and Stages to measure the efficiency of your marketing strategy.

How it works

To start, it helps to understand how the different pieces of Mautic fit together to give you a holistic marketing platform experience.

   :width: 600
   :align: center
   :alt: Mautic Overview

Contact management

Build a rich and functional database of Contacts for your business, group them together based on your business needs or based on shared attributes.

- :doc:`/contacts/manage_contacts` - Known or unknown individuals who have visited your websites or interacted with your business in some way. Contacts are the primary factor of a marketing automation platform.

- :doc:`/segments/manage_segments` - A group of your Contacts that share certain attributes. For example, you may segment Contacts based on a Contact's location. This may help you easily send out location-based offers or promotions to this specific group of Contacts.

- :doc:`/companies/companies_overview` - An assigned group of Contacts based on their Company or Companies.


Components

Create and manage various types of content that you use for your marketing campaigns to engage your Contacts.

- :doc:`/components/assets` - Valuable items that you provide to your Contacts upon completion of a Form. White papers, a downloadable app/file, documents or videos are some examples of Assets.

- :doc:`/components/forms` - Forms are the primary point of customer engagement. They're used to collect contact information, often in exchange for providing access to an Asset such as a download, an event registration, or an Email newsletter.

- :doc:`/components/landing_pages` - A powerful feature that not only allows you to promote content quickly and easily, but also allows you to rapidly create Landing Pages that are tightly tailored for a specific purpose, such as an advertising campaign.

- :doc:`/components/dynamic_web_content` - A feature that you can use to personalize the web experience for your Contacts. Marketers can display different content to different people in specific areas of a webpage.

Campaigns

- :doc:`/campaigns/campaigns_overview` - With your Contact information and the Components in place, you can start to create customized marketing activities for your Contacts. You create these marketing activities primarily in Campaigns.

Channels

Choose one or more Channels to deliver the content and messages to your Contacts.

- :doc:`/channels/marketing_messages` - A way to personalize communication with your Contacts. With Marketing Messages, Contacts receive your content on a Channel they've set as their preference.

- :doc:`/channels/emails` - Use built-in Email templates to send messages to a group of your Contacts, or send personalized messages to specific Contacts.

- :doc:`/channels/focus_items` - A type of web personalization that enables marketers to embed on a webpage pop-up messages and Forms, bars and splash screens based on the Contact's behavior. By using Focus Items, you can easily convert visitors into known Contacts.

- :doc:`/channels/social_monitoring` - Marketers can add Contacts to Mautic through Twitter mentions and hashtags.

Assess performance

Analyze trends and assess the performance of your marketing strategy using various tools.

- :doc:`/dashboard/dashboard` - A high-level representation of Contact data, Campaigns, and activities. You can create a highly personalized dashboard based on the information that you want to track.

- :doc:`/reports/reports` - A tool to measure the effectiveness of your marketing Campaigns, Emails, Forms, or Landing Page hits. Reports also let you troubleshoot or workaround areas of improvement to enhance your marketing strategy.

- :doc:`/points/points` - A score that's an indicator of progress for a Contact or customer. Points are a way for marketers to measure which of their Contacts are the most engaged based on their interactions and behavior.

- :doc:`/stages/stages` - A customizable feature that enables you to keep a track of where your Contacts are in their marketing/sales journey.""",
    ),

  ],
),

AppCourse(
  id: "marketing_14",
  title: "Plugins",
  description: "Plugins",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "11 Lessons",
  lessons: [
    AppLesson(
      title: "Amazon",
      body: r"""Amazon S3


The Amazon S3 Plugin allows you to host your :doc:`Assets</components/assets>` on an Amazon S3 bucket instead of hosting them on your local server. When creating an Asset you select from your S3 bucket, rather than your local computer.

Setting up an S3 bucket

Follow these steps to :xref:`set up Amazon S3` and create a bucket:


#. :xref:`Create an AWS account` if you haven't. Ensure you are familiar with the :xref:`pricing tiers for S3` before you commit to using it.
#. If you already have one, :xref:`access AWS account` and select **IAM user** as user type.

   .. important::

      Ensure you aren't using your root account for day-to-day tasks.

#.  :xref:`Create a bucket`.

   .. note::

      The region you select for your bucket is important for data protection, and you need to copy this value and use it when you set up Mautic. Consult your privacy policy and act accordingly.


Now that you have created a bucket, create a user who can access it. Instead of using the credentials for your master account which expose you to significant risk if they're ever exposed, use the credentials for this user in Mautic.

1. Select your **account name** in the top right corner.
2. Select **Security Credentials** from the drop-down list.
3. Select **Users** > **Add User** and provide a name.
4. Select **programmatic access**.

  :alt: Screenshot of Amazon S3

5. Select Attach existing policies directly, filter for S3 by typing it in the search box, and select AmazonS3FullAccess.

  :alt: Screenshot of Amazon S3

6. Click **Next** button to proceed through, as you don't need to assign any tags.
7. Create a user after reviewing the information submitted.

  :alt: Screenshot of Amazon S3

8.  Next, you can view the **Access Key ID** and the **Secret Access Key**.


     You must make a copy of these credentials as you won't be able to access them again. Download them and/or save them securely.

Setting up S3 in Mautic

With the bucket details and a user with the correct credentials, it's time to set up Mautic to use this bucket.

1. Go to **Settings** > **Plugins**
2. Click the **Amazon S3** Plugin.
3. Click the **install/upgrade Plugins**, if you don't see the Amazon S3 Plugin.
4. Toggle the **Active** switch button to enable the Plugin.
5. Enter the **ID**, secret from your user, and the bucket name.

  :width: 400
  :align: center
  :alt: Screenshot of Amazon Integration Form

6. Enter the **bucket location** as configured in Amazon S3.
7. Click **Save** to save your changes
8. Click the next tab, **Features**, to ensure that the option to use a cloud provider for Assets is selected.

  :alt: Screenshot of Amazon Integration Form
  :width: 400
  :align: center

9. Click **Save & Close**, and refresh the Plugins page - the Amazon S3 Plugin icon will be in color rather than ``Grayscale``, indicating that it's active.

When you upload an Asset to your S3 bucket you can select it by creating a new Asset and choosing Remote Files > S3.""",
    ),

    AppLesson(
      title: "Clearbit",
      body: r"""Clearbit

This Plugin can:

* Pull data from Clearbit via the API about Contacts and Companies into Mautic.

Clearbit Plugin Requirements

* Mautic installed on a publicly accessible URL. Due to the need for callbacks from Clearbit to Mautic, this Plugin won't work on a localhost.

* Get a Clearbit API key

Authorize the Plugin

  :alt: Screenshot of Clearbit

Clearbit Plugin Usage

A dropdown menu and a toolbar at the top are both present on the Contacts and Companies pages:


A confirmation window pops up when you click one of those buttons:

Upon finding the information, the Contact/Company details updates shortly after.""",
    ),

    AppLesson(
      title: "Hubspot",
      body: r"""HubSpot


Mautic - HubSpot CRM Plugin


Mautic can push Contacts to :xref:`HubSpot CRM` based on :ref:`Contact actions<testing integrations>` or :doc:`Point Triggers</points/points>`.

HubSpot API key

Getting Mautic connected to HubSpot requires integrating and configuring the HubSpot API key with the right credentials.

1. Sign in to your HubSpot CRM account or create an account if you don't already have one.

2. Create a private app to :xref:`HubSpot Credentials`. You need to give to your private app the adapted rights for Mautic to handle Contacts, Companies, etc.

3. Copy your generated HubSpot Key and save it somewhere safe.


Configure the HubSpot CRM Plugin



    Be sure to complete all steps before you activate the Plugin.

1. Log in to Mautic instance.

2. Go to **settings**.

3. Click the **Plugins** option.

  :width: 200
  :align: center
  :alt: Screenshot of settings

4. Select the **HubSpot** Plugin configuration.

  :width: 800
  :alt: Screenshot of HubSpot Plugin

5. In the configuration box, paste your **API key** in the HubSpot API key input field.

6. Configure the **Feature Specific Settings** to synchronize Contacts, Companies, or both  from HubSpot.

7. Click **Save & Close**, then edit the Plugin to configure the field mapping..


    In the default setting, it's checked. The Plugin won't push Contacts to HubSpot CRM if you un-select it.

8. Configure the :ref:`field mapping<field mapping>`.

9. Click **Save** to save the Plugin configuration.

   * If you want to use the Plugin, set the *Active* switch to **Yes**. Only do this when you have fully configured the Plugin settings.

10. Set up the :ref:`cron job<configure Mautic integration cron jobs>` if you haven't already configured it.


    Script to configure in your cron job: ``php \$PATH_TO_MAUTIC_DIRECTORY/bin/console mautic:integration:fetchleads --integration=Hubspot --fetch-all``


Test the Plugin


Follow :ref:`these steps<testing integrations>` to test the Integration.


Troubleshooting HubSpot Integration


When creating the Contact, ensure the email address you used to test is valid. HubSpot only creates a new Contact when the email address is valid.

Note, despite ``--fetch-all`` flag, the HubSpot API endpoints used in Mautic primarily leverage the following endpoints:

* ``/companies/v2/companies/recent/modified/``

* ``/contactslistseg/v1/lists/recently_updated/contacts/recent``

If you intend to do a full sync of your HubSpot Contacts, you need to modify an attribute of each so that they appear in HubSpot's recent/modified endpoints.
When connecting to a long-lived HubSpot instance, these endpoints pull only Contacts modified in the last 30 days, resulting in an incomplete sync. :xref:`Source`.""",
    ),

    AppLesson(
      title: "Mailchimp",
      body: r"""MailChimp

This Plugin can send Contacts to MailChimp lists based on Contact actions or Point Triggers.

Authorize

Get MailChimp API key

1. Create a MailChimp account.
2. Go to *Account* / *Extras* / *API Keys* and create a new one.
3. Copy the created API Key.

  .. image:: images/plugins-mailchimp-create-api-key-1-and-2.png
   :alt: Screenshot of MailChimp dashboard with arrows pointing at the Extras tab and the API Keys section
   :align: center

  .. image:: images/plugins-mailchimp-create-api-key-3a.png
     :alt: Screenshot of MailChimp dashboard with an arrow pointing at the Create API Key button
     :align: center

  .. image:: images/plugins-mailchimp-create-api-key-3b-and-3c.png
     :alt: Screenshot of the Name New API Key section with arrows pointing at the test and Generate Key button
     :align: center


Authorize Mautic - MailChimp Plugin
1. Fill in with your MailChimp's account **username**
2. Add the **API key**
3. Click on ***Save & Close***

Configure the Plugin


Navigate to the *Features* tab in the Plugin configuration modal box. You should see this note:


   The Contact Field Mapping tab will appear after selecting a segment and will update after changing the selected segment.

   .. vale on

   :alt: MailChimp Plugin configuration
   :align: center

1. Select the Segment.

   If you don't have a Segment in MailChimp created yet, go to *MailChimp dashboard* / *Segments* / *Create List* and create one.

2. Save the Plugin configuration
3. Open it again.

   The *Contact Field Mapping* tab should appear now.

4. Configure the field mapping.

Other configuration options

- **Push Contacts to this Integration**

Mautic enables these options by default. If you leave them off, the Plugin won't push Contacts to MailChimp.

- **Enable double opt in** - If MailChimp should send a confirmation Email to the Contacts added by this Plugin. The Contacts must confirm that they really want to join the Segment.
- **Send welcome Email** - Whether MailChimp should send the welcome Email.""",
    ),

    AppLesson(
      title: "Plugin Resources",
      body: r"""Plugin resources

Mautic Plugins are installable packages which can extend Mautic feature or integrate it with another system. You can find more information about how to create a Mautic Plugin on the :xref:`Mautic Plugins` section in the Developer Documentation.

You can find the Plugins in the right Admin menu.

  :width: 800
  :alt: Screenshot of Plugins settings


Install Plugins


If you are on a freshly installed Mautic instance, there is a chance that you don't have the default Plugins installed yet. Click on the **Install/Upgrade Plugins** button in the top right corner and all the Plugins should appear.

  :width: 800
  :alt: Screenshot of install Plugins

If you're trying to install a new Plugin that didn't come with the original Mautic installation files and it doesn't appear after you click Install/Upgrade Plugins, clear your Mautic cache - using the command at the :doc:`command line</configuration/command_line_interface>` - and try the Install/Upgrade Plugins button again.


Testing Integrations

How to test an Integration


If you want to test an Integration Plugin to ensure that it's configured properly, you have three options for how to do that. An Integration can push a Contact via these actions:

* The **Campaign Builder** has the *Push Contact to Integration* action which can be used in the Campaign configuration.

* **Forms** include the **Push Contact to Integration** action, which triggers after a Form submission.

* The **Points Trigger** has the *Push Contact to Integration* action which can be triggered when a Contact achieves a configured point limit.

Use any of those actions to test the Plugin and see if the Contact appears in the Integration. Here is an example of how you can configure the Form action:

  :alt: Screenshot of push Integration

1. Create a Form with some fields. For example, an ``email`` and a ``firstname`` field.

2. Add the Push Contact to Integration action. For example, ``Hubspot CRM``.

3. Browse to the Form's public URL ``https://example.com/form/[formID]``

4. Fill in the fields with sample Contact information and submit

5. Ensure that the Integration created the new Contact.

Troubleshooting Plugins

If the ``firstname`` value wasn't saved to the Integration:

1. Confirm that the Form General configuration tab enables the ``Save result`` option.

2. In the Form Contact Field configuration tab, confirm the field is: ``ContactFirst Name``.

3. Double select the Integration field mappings.


Field mapping


At the *Contact Field Mapping* tab is the list of available fields from an Integration.

You have to select the Mautic Contact Field equivalent so each field gets the right value.


    You don't have to map every field. Map only those you want to push into the Integration.""",
    ),

    AppLesson(
      title: "Salesforce",
      body: r"""Salesforce


Visit the :xref:`Knowledgebase article on Salesforce` for details on how to configure the Salesforce integration.""",
    ),

    AppLesson(
      title: "Social Login",
      body: r"""Social login

With Mautic's Social Login, Users can easily sign in via their favorite social platforms like Twitter, Facebook, or LinkedIn. The social login feature automatically pre-fills Forms with profile data and updates or creates new Contacts in Mautic, streamlining the user experience.

Before you begin: setup requirements

Before configuring social login, make sure you have created apps on the developer platforms for the social media profiles you want to integrate:

- :xref:`X-developer`
- :xref:`Facebook developer`
- :xref:`LinkedIn developer`

Once created, you're ready to connect them to Mautic.

Step 1 - authorizing social media Plugins

Before you can use social login, each social media Plugin needs authorization. Here's how to do it:

1. **Copy the Callback URL**: go to Mautic's Plugin configuration window and copy the Callback URL provided there. Paste it into the appropriate field in your developer app setup.

 .. image:: images/Call_back.png
    :width: 400
    :alt: Screenshot of a callback URL input field.

2. **Add Your API Keys**: copy the API Key - Client Key - and API Secret - Client Secret - from the social platform. Paste these keys into the relevant fields in the Mautic Plugin configuration.

    :width: 400
    :alt: Screenshot of an API Key input field.

3. **Authorize the Plugin**: in the Mautic Plugin configuration, click **Authorize**. You must **turn on** the Plugin - do this by toggling the option to “Yes”. Finally, save your configuration to complete the setup.


Step 2: adding social login buttons to Forms

Having configured the social Plugins, you can add social login buttons to your Mautic Forms.

1. Go to the Forms section in Mautic and either create a new Form or edit an existing one.

2. Select the **Social Login** field from the Form builder. Buttons for all authorized social platforms - for example Twitter, Facebook, LinkedIn automatically appear.

3. When Users log in using their social accounts, Mautic attempts to automatically fill in fields like **Name** or **Email** based on their social profile.

   :alt: Mautic Plugin configuration screen showing authorized status
   :width: 400

   Only the buttons for Plugins you've authorized work in the Form. Ensure you've configured all Integrations correctly for a smooth User experience.

Step 3: configuring features and mapping Contact fields

After configuration and authorization of the Plugin, you can customize how Mautic handles the incoming social profile data. Under the **Contact Field Mapping** tab in the Plugin settings, map the fields from the User's social profile - for example Email, Name - to the appropriate Mautic Contact fields.

- You only need to map fields that are relevant to your Form.

- Unmapped fields aren't used to update or create Contacts in Mautic.

Example: map **First Name** from Facebook to **First Name** in Mautic's Contact fields.

Supported social profile fields

Each platform provides different user data fields. Here's a quick reference of the fields you can map:

- **Twitter**: profile handle, name, location, description, URL, time zone, language, email address.

- **Facebook**: first name, last name, name, gender, locale, email address, profile link.

- **LinkedIn**: first name, last name, maiden name, formatted name, headline, location, summary, specialties, positions, public profile URL, email address.""",
    ),

    AppLesson(
      title: "Twilio",
      body: r"""Twilio

Mautic - Twilio Plugin


Before you start to send text messages from your Mautic instance, it needs to connect to the service which can send them.

The first and default implemented service is :xref:`Twilio`.

In order to configure the text messages correctly, follow these steps:

1. Create an account at :xref:`Twilio`.

2. In Mautic, go to *Settings* (cog icon) > *Plugins*.

3. Open *Twilio* Plugin and activate it.

4. Log into your Twilio account and go to *Dashboard*.

 .. image:: images/twilio-sid-authtoken.png
    :width: 400
    :alt: Screenshot of the SID and Auth Token fields


5. Copy the *Account Sender ID (SID)* from Twilio account and paste it to *Account Sender ID* field in the Twilio Plugin configuration.

6. Unlock and copy the *Auth Token* and paste it to *Auth Token* field in the Twilio Plugin configuration.

7. Go to *Phone Numbers* > Active numbers in Twilio, add a phone number if you haven't already commissioned one.

8. Go to *Messaging* > *Services* in Twilio, and create a new Messaging Service. Select the appropriate settings from the dropdown in the first step as relevant to your usage of SMS messages with Mautic, then click 'Create Messaging Service' at the bottom right.

 .. image:: images/twilio-messaging-services.png
    :width: 400
    :alt: Screenshot of the Messaging Services interface

9. Click the button to add your phone number as a Sender for this Messaging Service, then select the box and click 'Set up Integration' at the bottom right to move on to the next step.

10. Select 'Send a Webhook' under the Integration settings.

11. Configure the Request URL and Fallback URL to use the callback URL of ``https://example.com/sms/twilio/callback`` where ``example.com`` is your Mautic instance domain. Also enter this in the 'Delivery Status Callback' field.

 .. image:: images/twilio-webhook-callback.png
    :width: 400
    :alt: Screenshot of the Messaging Services interface

12. Click the 'Add Compliance Info' button to proceed to the next step, where you can register to send Application to Person (A2P) messages using a 10 digit long code phone number. Otherwise, click the button in the bottom right to complete setup. Click on 'View my new Messaging Service' to see the details of the service you just created. Once created you can view the SID from the Messaging > Services screen.

 .. image:: images/twilio-messaging-service-id.png
    :width: 400
    :alt: Screenshot of the Messaging Services ID field on Twilio.

13. Copy the Messaging Service ID and paste this into the 'Features' tab of your Mautic Twilio Plugin settings

 .. image:: images/twilio-messaging-service-id-mautic.png
    :width: 400
    :alt: Screenshot of the Messaging Services ID field in Mautic.

14. Configure the global frequency rules for the SMS Channel as appropriate for your business.

15. Select the *Published*? switch to *Yes* in the Enabled/Auth tab in Mautic and save the Plugin configuration.


Alphanumeric Sender ID


Alphanumeric Sender ID allows you to send SMS messages using a personalized sender name, in supported countries see :xref:`International Support for Alphanumeric Sender ID`.

Instead of using an E.164 formatted Twilio Phone number for the 'From' value, you can use a custom string like your own business' branding.


     You can't reply directly to messages sent out with an Alphanumeric Sender ID.


Alphanumeric Sender ID requirements


Alphanumeric Sender ID is automatically supported on all new :xref:`upgraded (paid) Twilio accounts`. It's not supported for Free Trial accounts.

You can verify if your account has Alphanumeric Sender enabled by following these steps:

#. Login to your account at :xref:`Twilio`.

#. From the left side navigation bar, click Messaging > Overview.

#. Click Settings.

#. From the General Messaging Settings page, Verify the 'Alphanumeric Sender ID' setting.

 .. image:: images/twilio-alpha-numeric-number-settings.png
    :width: 400
    :alt: Screenshot of the Alphanumeric settings on Twilio.


Adding alphanumeric sender ID to a Messaging Service

#. Open your Messaging Service via your Twilio Dashboard

#. Under the **Senders** section, click the **Add Senders IDs** button

#. From the **Add Senders IDs** dropdown, select **Alpha Sender** and enter the alphanumeric sender ID that you want to add to the Sender Pool.

Read more info about :xref:`Alphanumeric Sender ID` on Twilio site.""",
    ),

    AppLesson(
      title: "Vtiger",
      body: r"""Vtiger


Mautic - Vtiger CRM Plugin


This Plugin can push a Contact to the Vtiger CRM when a Contact makes some action.

Create a :xref:`Vtiger` CRM account if you don't already have one.


    The cloud Vtiger instances have the Contacts module turn off by default. This causes error message ``Permission to perform the operation is denied`` on Plugin edit Form. Enable the Contacts module and the Plugin load the custom field mapping Form.


Authenticate the Vtiger Plugin


To authenticate the Mautic Plugin to be able to communicate with Vtiger CRM you'll need these credentials:

* Vtiger Cloud URL - the base (root) URL starting with ``http://`` or ``https://`` where your Vtiger instance runs. For example, ``https://your_Vtiger.od2.Vtiger.com.``

* Vtiger Open Source URL If you are using Open Source Vtiger you must use the base (root) URL starting with ``http://`` or ``https:// and followed by /webservice.php``. For example ``https://your_Vtiger.od2.Vtiger.com/webservice.php``.

* Vtiger username - The username, email address usually, which you use to log in to your Vtiger.

* Vtiger access key - The access key activated in your Vtiger profile. To get it, go to Vtiger's **My Preferences**. The Access Key hash is at the bottom of the page.

  :alt: Screenshot of Vtiger Mautic Integration
  :width: 500
  :align: center

|

Fill these 3 credentials to the Mautic Plugin and click **Save**.


Configure the Vtiger CRM Plugin


If you want to use the Plugin, you have to activate it.

1. Set the *Active* switch to **Yes**.

2. In the **Features tab** is Push Contacts to this Integration checkbox and it's checked by default.

  :alt: Screenshot of Vtiger Mautic Integration
  :width: 500
  :align: center

|

3. You can also configure whether you want to map Vtiger's Leads to Mautic's Contacts and/or Vtiger's Organizations to Mautic's Companies.

4. Configure the :ref:`field mapping<field mapping>`.

5. Click **Save & Close**.


Test the VTiger CRM Plugin


Follow :ref:`these steps<testing integrations>` to test the Integration.""",
    ),

    AppLesson(
      title: "Wordpress",
      body: r"""WordPress

Installation & activation

Requirements

- WordPress 4.6 or later
- PHP 5.6 or later

Steps

1. Download the WP Mautic Plugin.
2. Go to your WordPress Admin Dashboard → Plugins → Add New.
3. Click 'Upload Plugin' and choose the downloaded ZIP file.
4. Click 'Install Now' and then 'Activate.'

Shortcodes and usage

Available shortcodes

WP Mautic currently provides a shortcode API through ``shortcodes.php``.

Example usage


   [mautic type=\"form\" id=\"1\"]

Parameters

- **type:** type of Mautic resource - for example ``form``.
- **id:** the ID of the Mautic Form or Asset you want to embed.

Tracking script behavior


Header vs footer
You can choose to load the Mautic tracking script in the site header - for faster pageview tracking - or footer - for better performance.


Fallback tracking

If a visitor has JavaScript turned off, a fallback ``<img>`` tag is automatically added for tracking via a tracking pixel.

Custom attributes


The Plugin automatically sends additional metadata like language, page title, referrer, and user details if enabled.


Plugin settings

Accessing the settings

Navigate to **Settings → WPMautic** from your WordPress dashboard.

Available options


- **Base URL:** the URL of your Mautic instance - for example ``https://example.mautic.com``.
- **Script Location:** choose whether to inject tracking code in the header, footer, or turn it off.
- **Track Logged In Users:** enable tracking details like email, username for logged-in users.
- **Fallback Activation:** adds a ``<noscript>`` image tracking fallback if you turn off JavaScript.


Developers

This section covers everything you need to know about setting up your environment and integrating with WordPress.

Environment

Before you begin developing, ensure you have **Docker** running on your system.

Getting started

First, clone the WordPress development repository:


  git clone https://github.com/WordPress/wordpress-develop.git

Change into the cloned directory:


  cd wordpress-develop

Initial setup

Run the following commands to set up your environment:


  npm install
  npm run build:dev
  npm run env:start
  npm run env:install

These commands:


- Install all Node.js dependencies.
- Build development versions of WordPress assets.
- Start the local Docker containers for WordPress.
- Install WordPress into the Docker environment.


Useful commands

After setup, you can use these commands to control your environment:

- ``npm run env:start`` to start Docker containers.
- ``npm run env:stop`` to stop Docker containers.
- ``npm run env:restart`` to restart Docker containers.

Hooks and functions

Useful functions

- ``wpmautic_option( \$option, \$default )`` which retrieves the Plugin settings safely.
- ``wpmautic_base_script()``which retrieves the full URL of the ``mtc.js`` script.
- ``wpmautic_get_tracking_attributes()``which retrieves the custom tracking data array.

Filters

Extend the Plugin using:


  apply_filters('wpmautic_tracking_attributes', \$attrs)

Actions

- ``wp_head`` or ``wp_footer`` which automatically injects the Mautic script depending on settings.""",
    ),

    AppLesson(
      title: "Zoho Crm",
      body: r"""Zoho CRM


Mautic can push a Contact to :xref:`Zoho CRM` based on Campaign :ref:`Actions` or :ref:`Point triggers`.

Language configuration warning


    You must **configure the Zoho and Mautic accounts in** English in order for the synchronization to work. Zoho changes the alias of each of the Contact fields depending on the language, which generates unmatched fields and errors on sync.


Configure the Zoho CRM Plugin


1. Create a :xref:`Zoho CRM` account if you don't have one already.
2. Generate a key pair by going to the :xref:`Zoho API Console`.
3. Select **Server Based Applications** and provide a name for the client; the URL of your Mautic instance, and the callback URL (which you can access by going to Plugins > ZohoCRM in Mautic and copying the callback URL, usually in the format ``https://mautic.example.com/plugins/integrations/authcallback/Zoho``).

  :alt: Screenshot of Zoho Developer console
  :width: 500
  :align: center

  :alt: Screenshot of Zoho Developer console configuration
  :width: 500
  :align: center

4. Enter the Client ID and Client Secret you created the Zoho API Console into the Mautic Zoho Integration Plugin.

  :alt: Screenshot of Mautic Zoho Integration Plugin
  :width: 500
  :align: center

|


    You must select the correct data centre corresponding to your CRM instance - for example, if you access your CRM at ``crm.zoho.com`` you should choose the .com option in the dropdown.

|

1. Select the correct data centre based on the URL of your Zoho CRM instance, and click the button to authorize the Plugin to access your instance. A popup window prompts you to log into Zoho and to authorize access - select Accept.

  :alt: Screenshot of Mautic Zoho Integration Plugin
  :width: 500
  :align: center

Once you have authorized successfully, the button updates to show 'Reauthorize'.

6. In the Features tab you can select the behaviour that you wish to have happen with this Integration:

   * Triggered action push Contacts to Integration - when triggered, Mautic pushes Contacts to Zoho
   * Pull Contacts and/or Companies from Integration - pull all Contacts and/or Companies from ZohoCRM into Mautic
   * Push Contacts and/or Companies to this Integration - push all Contacts and/or Companies from Mautic into ZohoCRM

Note this still requires a :ref:`cron job<cron jobs>` to function

You can also configure other options:

* Update blank values - This updates blank values regardless of data priority, on both ZohoCRM and Mautic.
* Choose what Zoho Objects to pull data from - Here you can specify which objects you want to pull from ZohoCRM - Leads, Contacts and/or Accounts

|

  :alt: Screenshot of Mautic Zoho Integration Plugin
  :width: 500
  :align: center

7. Configure the :ref:`field mapping<field mapping>`.

|


    If the values are empty for the Mautic object, a value of 'Unknown' is sent. If the ZohoCRM field is a pick list, be sure the list values of Mautic's field match those of the field in ZohoCRM.

8. Set the Active switch to **Yes**.
9. Click **Save & Close**.


Test the Plugin Zoho CRM


Follow :ref:`these steps<testing integrations>` to test the Integration.""",
    ),

  ],
),

AppCourse(
  id: "marketing_15",
  title: "Points",
  description: "Points",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "3 Lessons",
  lessons: [
    AppLesson(
      title: "Point Groups",
      body: r"""Point Groups


Point Groups is a feature that allows Users to categorize the score of their Contacts. By setting up Point Groups, Users can assign a specific number of Points to each action taken by a Contact, such as opening an Email, visiting a Landing Page, or downloading an Asset.


Managing Point Groups


To access the currently defined Point Groups in Mautic, navigate to the Points Menu and click the \"Manage Groups\" link. To create a new Group, simply click the \"New\" button.

  :width: 600
  :alt: Screenshot of the create a new Group interface

Enter a name and a description for the Group and click the \"Save & Close\" button to create the Group.


Point Groups usage

Using Point actions
You can change Contact's Points within a Points Group by using Points Actions.

  :width: 600
  :alt: Screenshot of Points action with Group

Using Point triggers
You can use Point triggers based on Point Groups to automatically trigger specific events within the system.

  :width: 600
  :alt: Screenshot of Points trigger with Group

Campaign condition
You can use a condition based on Group Contact score in a Campaign.

  :width: 600
  :alt: Screenshot of Points trigger with Group

Campaign action
You can use a Campaign action to increase or decrease the Group Contact score.

  :width: 600
  :alt: Screenshot of Campaign Point action with Group

Form action
You can use a Form action to increase or decrease the Group Contact score.

  :width: 600
  :alt: Screenshot of Form Adjust Contact's Points Action with Group

Segment filters
Each Point Group adds a new filter for configuring the Segment.

  :width: 600
  :alt: Screenshot of Segment Group filter

  :width: 600
  :alt: Screenshot of Segment Group filter element

Contact details
You can display Point Groups in the Contact details.

  :width: 600
  :alt: Screenshot of Contact Details with Group Points


Group Report


You can generate a Report that contains information about Contact Point Groups.

  :width: 600
  :alt: Screenshot of Group Report

Webhooks
Changing the Contact Group Points doesn't trigger the Contact Points Changed Event Webhook""",
    ),

    AppLesson(
      title: "Points",
      body: r"""Points

Points provide a way for properly weighing Contacts. These Points have both triggers and actions. The following section outlines all the relevant term definitions, and a thorough understanding of how Points function. This helps make your overall marketing automation process successful using Points


Point Actions


Point Actions are those times when a Contact receives a change in their Point total. These actions can be either positive or negative Point changes and occur based on a particular action as you determine.

To add a new action:

1. Click **Points > Point Actions > + New**  - located in the top right corner.

    :alt: Screenshot of New Points action

2. In the main panel, there are four boxes for key information. Enter the appropriate information.

   * **Name** - The name of your action. This is how the action displays in your list of actions, so choose an identifiable name.

   * **Description** - Add a description to help you find certain actions. There may be more actions which are similar or more in-depth.

   * **Change Points (+/-)** - The value change to set for the action. The ``+`` isn't necessary when adding Points. When subtracting Points, add the ``-`` symbol.

   * **Actions taken by User** - This is the behavior or action the Contact must complete to trigger the action.

3. On the right side is more information:

   * **Category** - Organize your Point Actions based on their goals, Campaigns, etc. For more information, see :doc:`Categories</categories/categories-overview>`. All Points accumulate on a Contact record, regardless of Category. There is one Points score for each Contact.

   * **Active and Activate/Deactivate at date/time** - Once you have a Point action, Mautic awards Points when a Contact completes the action. Points aren't given for inactive actions. If you have target behaviors that you want to award Points for within a certain time period, you can set the activate and deactivate dates

   * **Is repeatable** - To award Points each time a Contact completes an action, select **Yes**. If you want to award Points **only** the first time someone completes the action, select **No** - this is the default.

4. Click **Save** or **Save & Close**.


Point Triggers


Once a Contact has accumulated a Point total, you may want to trigger an action with the Contact. You may create multiple triggers for different Point values.

    :alt: Screenshot of New Points trigger

Creating Point Triggers is like creating Point Actions. The **Name**, **Description**, **Category**, and **Active** options are all the same. The trigger fires based on the minimum number of Points. Set a number and decide if you want to **Trigger for existing applicable Contacts upon saving - if activated**.

Once you have decided and entered those options, go to the **Events** tab. Here, you can trigger one or more events once a Contact has reached your predetermined Point total. These Point Triggers and associated events are also fully customizable.

    :alt: Screenshot of New Points trigger events

Campaign triggers

**Modify Contact's Campaigns** - Add a Contact to or remove a Contact from any Campaigns you have activated.

    :alt: Screenshot of Modify Contact's Campaigns

Contact triggers

**Modify Contact's Segments** - Add a Contact to or remove a Contact from any Segments you have activated.

    :alt: Screenshot of Modify Contact's Segments

**Modify Contact's tags** - Add or remove any Tags on the Contact record. If a Tag doesn't exist, you may create a new one in the edit window for this event.

    :alt: Screenshot of Modify Contact's Tags

Add-on triggers

**Push Contact to Integration** - To only push Contacts to an Integration after hitting a minimum Point total, use this option. You must have the **Triggered action push Contacts to Integration** option selected in the Integration. After selecting this event, the system displays a dialog box where you can choose which Integration to push the Contact to. For example, if you base your definition of a Marketing Qualified Lead (MQL) on Point values, you may decide to only push Contacts who are MQLs to your CRM. Once a Contact meets the Points requirement to be an MQL, use this action to push the Contact to your CRM.

    :alt: Screenshot of Push Contact to Integration


    The Push Contact to Integration action isn't supported with the Salesforce Plugin.

Email triggers

**Send an Email** - Send a template Email to the Contact based on their engagement. This may be some sort of special offer, congratulations, etc.

    :alt: Screenshot of Send an Email trigger

**Send an Email to User** - Tell a team member that a Contact has reached a minimum number of Points. There is an option in this event to send the Email to the Contact's owner. You may either write a basic Email in the editor, or use a template Email.
  * Selecting a User and selecting the option of **send Email to Contact's owner** notifies both Contacts.

  * If User has no owner or if the owner is same as the Mautic User, this sends only one Email.

  * You can add more Emails to 'to', 'cc' and 'bcc' fields - separated by a comma. You can add space after each comma if needed.

  * Sends Notification to all address - User's Email, owner's Email, to, cc and bcc.

    :alt: Screenshot of Send an Email to User Email trigger""",
    ),

    AppLesson(
      title: "Points Troubleshooting",
      body: r"""Points troubleshooting

Page visits not recognized

To workaround this issue, try one of the following options:

1. Make sure that you aren't testing while logged into Mautic. Mautic ignores activity from Mautic Administrators. So, it's suggested that you use an anonymous session, an incognito window, another browser, or log out of Mautic.

2. The tracking of Point Actions is currently done once per Contact. This means that subsequent visits won't re-trigger the action if already triggered once.

3. Ensure that the URL defined either matches exactly the URL visited or use a wildcard. A URL can include the schema, host/domain, path, query parameters, and/or fragment.

For example, if you have a URL of ``https://example.com`` and the page hit registers as ``https://example.com/index.php?foo=bar``, the point action won't be recognized. However, if you use ``https://example.com*`` as the URL, it matches the rule and thus gets triggered.""",
    ),

  ],
),

AppCourse(
  id: "marketing_16",
  title: "Projects",
  description: "Projects",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "1 Lessons",
  lessons: [
    AppLesson(
      title: "Projects Overview",
      body: r"""Projects


Projects give you one place to group everything that belongs to a single marketing initiative. Instead of hunting for the Campaigns, Emails, Segments, and other entities behind a launch, you assign them all to a Project and manage them together. A Project works like a folder that spans entity types, so you can see how the pieces of an initiative fit together and find related entities quickly.

You can assign many entity types to a Project, including:


* :doc:`Assets </components/assets>`
* :doc:`Campaigns </campaigns/campaigns_overview>`
* :doc:`Companies </companies/companies_overview>`
* :doc:`Dynamic Web Content </components/dynamic_web_content>`
* :doc:`Emails </channels/emails>`
* :doc:`Focus Items </channels/focus_items>`
* :doc:`Forms </components/forms>`
* :doc:`Landing Pages </components/landing_pages>`
* :doc:`Marketing Messages </channels/marketing_messages>`
* :doc:`Points </points/points>`
* :doc:`Segments </segments/manage_segments>`
* :doc:`Stages </stages/stages>`
* :doc:`Text messages </channels/sms>`



Managing Projects


To open the Projects list, select Projects in the left main menu. From here, you can create a new Project, open an existing one, and delete Projects you no longer need. The list shows each Project along with the number of entities assigned to it.

   :align: center
   :alt: Projects list showing the New button and the Projects entry in the left menu

|


Creating Projects


To create a Project:

#. Select **New**.
#. Give it a name and an optional description.

   :align: center
   :alt: Create new Project screen with Name and Description fields

|

Each Project name must be unique. If you enter a name that's already in use, Mautic displays 'A project with this name already exists.' and asks you to choose another.


Editing Projects


You can edit a Project's name and description at any time. There are two ways to do this.

#. **From the Projects list:**

   #. Click the three-dots icon next to the Project you want to edit.
   #. Click **Edit** to open the Edit Project screen.
   #. Edit the Project and click **Save** or **Save & Close** to save it.

   .. image:: images/edit_project_from_dashboard.png
      :align: center
      :alt: Projects list with the Options menu open and the Edit action highlighted

   |

#. **From the Project's detail view:**

   #. Click the Project name to open its detail view.
   #. Click **Edit** at the top to open the Edit Project screen.
   #. Edit the Project and click **Save** or **Save & Close** to save it.

   .. image:: images/edit_project_from_detail.png
      :align: center
      :alt: Project detail view with the Edit button highlighted at the top

   |


Deleting Projects


There are two ways to delete Projects.

#. **To delete one or more Projects at once:**

   #. Select the checkbox of the Projects you want to delete. Selecting a checkbox automatically opens a blue banner on top of the table.
   #. Click **Delete selected**.
   #. Confirm the deletion.

   .. image:: images/delete_selected_projects.png
      :align: center
      :alt: Projects list with two Projects selected and the Delete selected banner

   |

#. **To delete a single Project:**

   #. Click the three-dots icon next to the Project you want to delete.
   #. Select **Delete**.
   #. Confirm the deletion.

   .. image:: images/delete_single_project.png
      :align: center
      :alt: Projects list with the Options menu open and the Delete action highlighted

   |

Deleting a Project removes the references to it from every assigned entity, but it doesn't delete the entities themselves.


Assigning entities to a Project


There are two ways to assign entities to a Project.

#. **From the entity** - When you create or edit a supported entity, such as an Email or a Campaign, use the Projects field to assign it to one or more Projects. If you have permission to create Projects, you can also type a new name in this field and select **Hit enter to create** to make a new Project on the spot.

   |

   .. image:: images/assign_project_from_email.png
      :align: center
      :alt: Email edit view with the Projects field used to assign the Email to a Project

   |

#. **From the Project**:

   #. Open a Project and select **Add Entities to Project**.

      |

      .. image:: images/add_entities_to_project_button.png
         :align: center
         :alt: Project detail view highlighting the Add Entities to Project button

      |

   #. Choose the type of entity you want to add.
   #. Select the entity you want to add to the Project.


Deleting entities from Projects


To delete an entity from a Project:

#. Click the three-dots icon next to the entity you want to remove.
#. Click the **Remove from project** button.
#. Confirm the removal.

   :align: center
   :alt: Options menu on a Project entity showing the Remove from project action

|


Finding entities by Project


To see entities assigned to a Project, go to the Project dashboard. From the Projects list, select the Project's name or the entities label in the **# Entities** column. Both open the Project's detail view, where Mautic lists every assigned entity grouped by type. From here, you can also remove entities or add new ones.

If you have many Projects, use the search bar at the top of the Projects list to find one quickly:

#. Type the Project's name.
#. Press **Enter**.
#. Select the Project's name or its entities label to open it.

   :align: center
   :alt: Projects list with a Project name typed in the search bar and the entities label highlighted

|


Permissions


Projects use their own permission set, which you can grant per Role. To configure these permissions:

#. Go to **Settings** > **Roles**
#. Open or create a Role
#. Find the **Project permissions** section.

Alongside the standard **View**, **Edit**, **Create**, **Delete**, and **Full** permissions, there's a separate **Associate with other entities** permission that controls whether a User can attach entities to and detach entities from Projects. A User needs this permission to use the Projects field on an entity or the add and remove actions on a Project.

For more information on creating Roles and configuring their permissions, see :ref:`Roles overview` and :ref:`Setting Role permissions <setting granular permissions>`.""",
    ),

  ],
),

AppCourse(
  id: "marketing_17",
  title: "Queue",
  description: "Queue",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "2 Lessons",
  lessons: [
    AppLesson(
      title: "Message Queue",
      body: r"""Message queue


You can trigger a Campaign **marketing** Email, or send it as part of an Email broadcast - a Segment Email. When exceeding a frequency rule - whether defined at the Contact level or as a default set in Configuration, all Emails go to the Queue for processing later.

Priority and number of attempts

  :width: 600
  :align: center
  :alt: Screenshot showing marketing-Email

* You can select priority as **High** or **Normal**. When processing messages for a given date, Mautic places high priority messages at the top of the queue. Broadcasts are always treated as a normal priority.

* On reaching the number of attempts specified, Mautic makes an attempt to send the Email again in the event of rescheduling. Even if the message is pending, exceeding the number of attempts means that Mautic won't send the message.

Processing a message queue

This command processes all pending messages that haven't reached their maximum number of attempts and are in the pending queue.

Setup your :ref:`cron<processing a message queue>` as followed: ``php bin/console mautic:messages:send``""",
    ),

    AppLesson(
      title: "Queue",
      body: r"""Queue


You can improved scalability by activating the queuing mechanism for Email and Page opens. Use this if you are getting too much traffic at once from people opening Pages or opening Emails.


    Mautic 3.x Users who are implementing RabbitMQ or Beanstalkd need to configure the settings directly in their local configuration file. If you are using the legacy Mautic 2.x series the steps below remains the same.

Activating

You can activate and configure the queuing mechanism by going to configuration:

* Open the administrator menu by clicking the cog icon in the top right corner.
* Select the *Configuration* menu item.
* Select the *Queue Settings* tab.
* Switch the *Queue Protocol* to either *RabbitMQ* or *Beanstalkd*.
* Save the configuration.


Using RabbitMQ



Having set up a RabbitMQ server, you can configure Mautic to use it by setting the appropriate parameters ``mautic.rabbitmq_*`` in your installation's configuration file.

   :header-rows: 1
   :widths: 40, 40, 60

   * - Parameter
     - Default
     - Description
   * - ``rabbitmq_host``
     - ``'localhost'``
     - The ``hostname`` of the RabbitMQ server
   * - ``rabbitmq_port``
     - ``'5672'``
     - The port that the RabbitMQ server is listening on
   * - ``rabbitmq_vhost``
     - ``'/'``
     - The virtual host to use for this RabbitMQ server
   * - ``rabbitmq_user``
     - ``'guest'``
     - The username for the RabbitMQ server
   * - ``rabbitmq_password``
     - ``'guest'``
     - The password for the RabbitMQ server
   * - ``rabbitmq_idle_timeout``
     - ``0``
     - 	The number of seconds after which the queue consumer should timeout when idle
   * - ``rabbitmq_idle_timeout_exit_code``
     - ``0``
     - 	The exit code returned when the consumer exits due to idle timeout

Example:


    'queue_protocol' => 'rabbitmq',
    'rabbitmq_host' => 'b-180b97c2-6b05-4b10-80ed-09182eac3a02.mq.us-west-1.amazonaws.com',
    'rabbitmq_port' => '5671',
    'rabbitmq_vhost' => '/',
    'rabbitmq_user' => 'some_user',
    'rabbitmq_password' => 'some_password',
    'rabbitmq_idle_timeout' => 0,
    'rabbitmq_idle_timeout_exit_code' => 0,


Using Beanstalkd


Once you have setup a Beanstalkd server, you can configure Mautic to use it by setting the appropriate parameters ``mautic.beanstalkd_*`` in your installation's configuration file.

   :header-rows: 1
   :widths: 40, 40, 60

   * - Parameter
     - Default
     - Description
   * - ``beanstalkd_host``
     - ``'localhost'``
     - The ``hostname`` of the Beanstalkd server
   * - ``beanstalkd_port``
     - ``'11300'``
     - The port that the Beanstalkd server is listening on
   * - ``beanstalkd_timeout``
     - ``'60'``
     - The default Time To Run - TTR - for Beanstalkd jobs

Processing

Activating the queuing mechanism queues up all Page hits and Email opens for later processing. You need to run some console commands on a regular basis to be able to process them.

To process the hits from a Page, use the following command:

``php /path/to/mautic/bin/console mautic:queue:process --env=prod -i page_hit``

To process the hits from an Email, use the following command:

``php /path/to/mautic/bin/console mautic:queue:process --env=prod -i email_hit``

When these commands run, they continue to run until you stop the program by using the keyboard combination ``Control + C``. If you want to run them to process only, say, 50 Page hits or Email hits, you can run the command like this instead:

``php /path/to/mautic/bin/console mautic:queue:process --env=prod -i page_hit -m 50``

or

``php /path/to/mautic/bin/console mautic:queue:process --env=prod -i email_hit -m 50``

Cron to push the jobs

You need to run the following cron to keep pushing the jobs:

``php /path/to/mautic/bin/console mautic:email:send``

See the documentation on :ref:`cron jobs<process email queue cron job>` for further information.""",
    ),

  ],
),

AppCourse(
  id: "marketing_18",
  title: "Reports",
  description: "Reports",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "1 Lessons",
  lessons: [
    AppLesson(
      title: "Reports",
      body: r"""Reports

Mautic's Reports menu allows you to generate highly customizable Reports.

You can use the reporting tools to track marketing metrics, identify marketing activities that are effective or need improvement, and troubleshoot or investigate if you are curious about why something is happening.

To get to Reports, click the Reports link from the menu on the left side of your instance. To create a new Report, click the **+New** button in the top right corner.

   :align: center
   :alt: Screenshots of Mautic Report

|

Data sources

The **Details** tab on a Report contains the same options across all Reports and provides some general options for your Report.

   :align: center
   :alt: Screenshots of Mautic Report Details

* **Name** - Specify a Report name that makes it easy for you and other Users to identify the purpose of the Report.

* **Data source** - Select the data source appropriate to the Report that you are building. Note that each data source has a different set of available columns, filters, and graphs. The available data sources are:

1. :doc:`Assets</components/assets>`

   * Assets
   * Asset Downloads

2. :doc:`Campaigns</campaigns/campaigns_overview>`

   * Campaign Events

3. :doc:`Channels Messages</queue/message_queue>`

   * Message Queue

4. :doc:`Emails</channels/emails>`

   * Emails
   * Emails Sent

5. :doc:`Forms</components/forms>`

   * Forms
   * Form Submissions

6. :doc:`Contacts</contacts/manage_contacts>`

   * Contacts
   * Multi Touch Attributions
   * First Touch Attributions
   * Last Touch Attributions
   * Contact Point Log
   * Frequency Rules
   * Segment Membership
   * Do Not Contact
   * UTM Codes
   * Group score

7. :doc:`Companies</companies/companies_overview>`

   * Companies

8. :doc:`Mobile Notifications</channels/marketing_messages>`

   * Mobile Notifications
   * Mobile Notifications Sent

9. :doc:`Pages</components/landing_pages>`

   * Landing Pages
   * Page hits

10. Videos

    * Video hits

As demonstrated, Mautic displays the data sources in the format: ``<Parent data source> <Child data source>``

The parent data source provides a high-level summary of the data while the child data source provides a more granular view of Contact behavior that includes your Custom Fields and values.

* **Description - optional** - Add detailed information about the Report, helping you and other Users better understand what the Report is for. You may want to include more information about filters, people, or departments.

* **Published** - Select **Yes** to ensure that the Report is active, ready to send when scheduled in the Report options.

* **Visible for all logged-in Users** - Select **Yes** so that all Users can access the Report. If set to No, only the owner of the Report and Users with permission to view others' Reports can see the Report.

* **Owner** - Select the owner of the Report to determine who can see the Report if the 'Visible for all logged-in Users' setting is No.

* **Dynamic filters settings**

  - Opened by default - If you want to ensure that the date filters and filter options for any other Report filters are visible on a Report detail page without needing to open the filters drop-down, select Yes. For example, for an Emails Report, you might want to view dynamic filters for subject or sent date.
  - Hide date range - To hide the date range filter so that Users can't change the dates that the Report displays data for, select to **Yes**.


Email Report columns


When using 'Emails' as the data source, you can add the following columns to measure Email engagement:


* **Sent count:** the number of Emails sent to Contacts.
* **Read count:** the number of Emails that Contacts opened.
* **Read ratio:** the percentage of sent Emails that Contacts opened.
* **Click-through count:** the number of unique Contacts who clicked any link in the Email.
* **Click-through rate:** the percentage of sent Emails that resulted in at least one click.
* **Click-to-open rate:** the percentage of opened Emails that resulted in at least one click. This helps you understand how engaging the Email content is to recipients who already opened it.
* **Unsubscribed:** the number of Contacts who unsubscribed after receiving the Email.
* **Unsubscribed ratio:** the percentage of sent Emails that resulted in an unsubscribe.
* **Unsubscribe-to-Open Ratio:** the percentage of unsubscribed Contacts relative to those who opened the Email. This helps you understand how Email content affects unsubscribe rates among engaged recipients.
* **Bounced:** the number of Emails that bounced.
* **Bounced ratio:** the percentage of sent Emails that bounced.
* **Clicks:** the total number of link clicks across all recipients - non-unique.
* **Clicks ratio:** the percentage of sent Emails that resulted in a click, based on total clicks rather than unique Contacts.
* **Unique clicks:** the total number of unique clicks across all trackable links. Each link counts separately, so a Contact clicking multiple different links adds multiple unique clicks. If you need the number of unique Contacts who clicked any link, use **Click-through count** instead.
* **Unique clicks ratio:** the percentage of sent Emails that resulted in a unique click, based on summed per-link unique hits.
* **DNC Preferences:** summary of all Do Not Contact preferences for the Contact across all Channels and Emails.



   Use the Unsubscribe-to-Open Ratio to compare the unsubscribe impact of different Emails. A high ratio may indicate that the Email content didn't meet recipient expectations, while a low ratio suggests it resonated with those who read it.


Data

You can customize each Report to include the columns of choice, filter data based on set criteria, and/or set a specific order for the data. In addition you can also group by specific fields, and select different function operators to calculate fields. Note that when you select functions operators, Mautic adds a totals row to the Report. Choosing to export a Report **won't** include this totals row.

   :align: center
   :alt: Screenshots of Mautic Report Data

* **Columns** - Select the columns of data that you want to appear in the table of data in the Report. Click the column name in the left column to have it show in the Report. You can remove a column from the Report by clicking on its right column. The column returns to its original position on the left side. For example, if you select ID, it refers to the **ID** for the parent data source Category that you selected earlier Contact ID, Email ID, Asset ID, etc. It's recommended that you include **ID** in all Reports.
* **Order** - For sorting the data in the Report, select data Points. The available sort options are **Ascending** and **Descending**. To add multiple columns, click **Add Order**. For fields that use text, an **Ascending** order lists values starting with B after values starting with A and so on. For number or date fields, the higher the number or later the date, the lower on the list the row is. Descending order is the opposite.


   Adding multiple fields to order by uses the last one in the Order list first. Ordering by **First Name Ascending** and adding **Email Ascending**, for instance, sorts the Email column first and duplicate rows are then sorted by first name ascending.

* **Filters** -  Filter the data using conditions and values. This allows the generation of very granular Reports. This option helps you to narrow down the data included in the Report. The data Points used for filters don’t have to be columns that appear in the Report table. A commonly used filter for any Reports that include Contact record data is Email Not Empty, which displays only identified Contacts in the Report. Additional use cases can include Contacts or items that match a certain value, events happening within a certain date range, etc.


   Setting the **Dynamic** option to **Yes** makes it easier for Users viewing the Report to change the data they see without actually editing the Report. Users can see the filter by opening the **Filters** drop-down from the top of the Report page.

* **Group by** - Select the columns for which you want to group data. By default, Reports show all items individually. In many Reports, you may see the same Contact, Company, or item appear multiple times. To only see each record listed once, you can add a grouping based on some attribute for the record.

You can use Email or Contact ID to display a single row per Contact record. For example, you can group by **Contact ID** to view the unique number of Asset Downloads or Form Submissions for a single Form, instead of total Asset Downloads or Form Submissions, which could include duplicates.

* **Calculated columns** - Select the function that you want to apply to individual columns. Calculated columns display count, average, sum, or the minimum or maximum values from a selected field. They're only available when using a grouping to show a calculation for that grouping. Continuing with the previous example of grouping by a Contact ID number or Email address, a ``COUNT`` calculation displays how many times that Contact record appears on the Report if not for the grouping.

Graphs

   :align: center
   :alt: Screenshots of Mautic Report Data

Some Report types display graphs for visualization purposes. You can include such graphs in Reports and use them in Dashboard widgets.

* To select an available graph and add it to the Report, click the name of the graph to move it from the left column to the right.
* To remove a graph from a Report, click the name in the right column to move it to the left.

The availability and types of graphs vary by Report type.

Schedule

Mautic allows scheduling Emails to send downloadable links containing the Report data in the ``.csv`` file format.

Use the toggle switch to turn on or off sending Reports via email.

* Email Report - Select **Yes** to see additional options.

* To - Specify the email addresses that should receive the Report. To send to multiple recipients, separate their email addresses with a comma. For example, ``example1@example.com``, ``example2@example.com``.

* **Every** - Select the frequency with which you'd like to automatically send the Report:

  - **now** - Sends the Report once, when it's saved.
  - **day** - Sends the Report every day at midnight in your time zone.
  - **week** - After selecting week, select the day of the week you'd like to send the Report. Mautic sends the Report at midnight in your time zone every week on the selected day.
  - **month** - After selecting month, select either the first or last and a day of the week. For example, set your Report to be automatically sent on the first Monday or last Friday of each month.

Alternatively, you can select Weekdays to send the Report on the first or last weekday of each month.

Once you've set all of the options you'd like in the **Details**, **Data**, **Graphs**, and **Schedule** tabs, click **Save & Close** to save the Report. Clicking **Apply** saves the progress you've made on building the Report and keeps you in the edit mode.

You can identify scheduled Reports in the list of Reports from Mautic 5.1 and later by the paper aeroplane icon next to the Report name.

   :align: center
   :alt: Screenshot of Mautic Scheduled Report showing a paper aeroplane icon


Cron job to schedule Reports


Mautic requires the following cron command to be able to send scheduled Reports:

``php /path/to/mautic/bin/console mautic:reports:scheduler [--report=ID]``

The ``--report=ID`` argument allows you to specify a Report by ID if required. For more information, see :ref:`Cron jobs<send scheduled reports cron job>`.

Report options

Once you've saved the Report, it's listed under the Reports section in Mautic.

   :align: center
   :alt: Screenshots of Mautic Report Options

To view additional options for Report, click the drop-down menu next to the checkbox.

* **Edit** takes you directly to the edit mode, rather than clicking on the view page and editing from there.

* **Clone** copies the Report so that you can make small adjustments in a similar but new Report, while maintaining the original Report.

* **Export & Send** sends a link containing the ``.csv`` file with the Report data to the email address on your User profile.

* **Delete** deletes the Report immediately.


Exporting Reports


   :align: center
   :alt: Screenshots of Mautic Exporting Report

In addition to the **Schedule** and **Export & Send** features, Mautic supports exporting Reports in ``.csv,`` Excel, or HTML format. From the Reports list, click any Report. Open the drop-down menu in the top right corner and select the preferred export format.

To download the Report immediately:

1. On the Schedule tab, do one of the following:

   * Select **No**.
   * In the **Every** field, set the value to now.

2. Click **Save & Close**.

3. On the Report details page, click the dropdown on the top right and click **Export to CSV**.

4. Reset the schedule as needed.

Reporting data is also available to export by API. For more information, see the :xref:`Reports API documentation`.""",
    ),

  ],
),

AppCourse(
  id: "marketing_19",
  title: "Search",
  description: "Search",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "1 Lessons",
  lessons: [
    AppLesson(
      title: "Search Operators",
      body: r"""Searching Mautic


Search operators and filters

Mautic offers a variety of search operators and filters for drilling down into relevant resources. You can find the available search filters and operators by clicking on the button with a question mark next to the search input.

The search filters for that entity aren't available if such a button is missing.

   :align: center
   :alt: Mautic Contact search

|

Mautic also has a 'global search' feature. In the top left-hand corner, click the magnifying glass icon next to the Mautic logo/notifications icon. This opens a search input where you can search across multiple different entities.

   :align: center
   :alt: Mautic global search

|

Search operators

Here are some search operators you can use:

* ``+`` plus sign - Search for the exact string, for example, if you search for ``+admin``, then ``administrator`` won't match.

* ``!`` exclamation mark - Not equals string

* ``\" \"`` double quotes - Search by phrase

* ``( )`` parentheses - Group expressions together.

* ``OR`` - By default the expressions joins as ``AND`` statements. Use the OR operator to change that.

* ``%`` - Use the % as a wildcard to search for specific names or values in a phrase for example, to find all Companies with the word ‘Technologies’ then type %technologies%

Search operators filters

Here are some search filters you can use:

Contacts search filters


    is:anonymous
    is:unowned
    is:mine
    email:*
    segment:{segment_alias}
    name:*
    company:*
    owner:*
    ip:*
    ids:ID1,ID2 (comma separated IDs, no spaces)
    common:{segment_alias} + {segment_alias} + ...
    tag:*
    stage:*
    email_sent:EMAIL_ID
    email_read:EMAIL_ID
    email_queued:EMAIL_ID
    email_pending:EMAIL_ID

Companies search filters


    ids:ID1,ID2 (comma separated IDs, no spaces)
    is:published
    is:unpublished
    is:mine
    is:uncategorized
    category:{category alias}

Segments search filters


    ids:ID1,ID2 (comma separated IDs, no spaces)
    is:global
    name:*
    category:category-alias

Assets search filters


    ids:ID1,ID2 (comma separated IDs, no spaces)
    is:mine
    is:published
    is:unpublished
    name:*
    is:uncategorized
    category:{category alias}

Forms search filters


    ids:ID1,ID2 (comma separated IDs, no spaces)
    is:mine
    is:published
    is:unpublished
    has:results
    name:*
    is:uncategorized
    category:{category alias}


Landing Pages search filters



    ids:ID1,ID2 (comma separated IDs, no spaces)
    is:published
    is:unpublished
    is:mine
    is:uncategorized
    is:prefcenter
    category:{category alias}
    lang:{lang code}


Dynamic Content search filters



    ids:ID1,ID2 (comma separated IDs, no spaces)
    is:published
    is:unpublished
    is:mine
    is:uncategorized
    is:prefcenter
    category:{category alias}
    lang:{lang code}

Emails search filters


    ids:ID1,ID2 (comma separated IDs, no spaces)
    is:published
    is:unpublished
    is:mine
    is:uncategorized
    category:{category alias}
    lang:{lang code}

Focus Items search filters


    ids:ID1,ID2 (comma separated IDs, no spaces)
    is:published
    is:unpublished
    is:mine
    is:uncategorized
    category:{category alias}

Manage actions search filters


    ids:ID1,ID2 (comma separated IDs, no spaces)
    is:published
    is:unpublished
    is:mine
    is:uncategorized
    category:{category alias}

Manage triggers search filters


    ids:ID1,ID2 (comma separated IDs, no spaces)
    is:published
    is:unpublished
    is:mine
    is:uncategorized
    category:{category alias}

Stages search filters


    ids:ID1,ID2 (comma separated IDs, no spaces)
    is:published
    is:unpublished
    is:mine
    is:uncategorized
    category:{category alias}

Reports search filters


    ids:ID1,ID2 (comma separated IDs, no spaces)
    is:published
    is:unpublished
    is:mine
    Categories
    ids:ID1,ID2 (comma separated IDs, no spaces) is:published is:unpublished

Users search filters


    ids:ID1,ID2 (comma separated IDs, no spaces)
    is:admin
    is:active
    is:inactive
    email:*
    name:*
    position:*
    role:*
    username:*
    Roles
    ids:ID1,ID2 (comma separated IDs, no spaces)
    is:admin
    name:*

Webhooks search filters



    ids:ID1,ID2 (comma separated IDs, no spaces)
    is:published
    is:unpublished
    is:mine
    is:uncategorized
    is:prefcenter
    category:{category alias}
    lang:{lang code}""",
    ),

  ],
),

AppCourse(
  id: "marketing_20",
  title: "Segments",
  description: "Segments",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "1 Lessons",
  lessons: [
    AppLesson(
      title: "Manage Segments",
      body: r"""Managing Segments

Segments in Mautic are lists or groups of Contacts. Use Segments to send Emails, trigger Campaigns, or for analysis. You can add and remove Contacts from **static** and **dynamic** Segment types.

Segments provide ways to easily organize your Contacts. There are a variety of fields available for configuring these Segments.


Creating a Segment


#. To create a new Segment, navigate to Segments in the menu, and click the **New** button.

#. In the **Details** tab, add a **Name**, **Public name**, and **Description** to your Segment.

   |

   .. image:: images/create-segment.png
      :width: 700
      :alt: Screenshot showing creating a Segment.

   |

#. Fill in other options:

   * **Visible to other Users** - This option determines if the Segment is available for all Users to see and use, or only the User who created the Segment.
   * **Available in Preference Center** - If set to **Yes**, Contacts can see and opt into or out of the Segment on a **Preference Center** interface. The Segments display if the Preference Center has the **Segment List** slot type.
   * **Active** - If set to **No**, the Segment won't be available for use in filters for other Segments, as a Contact source in Campaigns, modify Segment actions, etc. You still see the Segment in your Segments list, but it won't exist anywhere else in Mautic.

   * **Public name** - Users can set a different name for the Segment, which is visible to Contacts in the Preference Center options.

     On the **Details** tab, static and dynamic Segments also have the option to display a different public name for a Segment.


Viewing Contact Segments



When viewing all Segments, the **# contacts** column shows the number of Contacts included in each specific Segment. The **Building** or **Building (X Contacts)** label appears during the creation of a new Segment or when modifying an existing Segment's filter and remains visible until the building process completes.


   :width: 700
   :alt: Highlight Segments' Contacts column that consists of Contacts count and building labels


Exporting Contacts of a Segment


To export Contacts of a Segment:

#. Click the **View X Contacts** label for the Segment that you want to export. This opens the Contacts interface.

   |

   .. image:: images/segments_view_contacts_label.png
      :width: 700
      :alt: Highlight of view 1 Contact label at Mautic Contact Segments interface.

   |
#. Click the up and down icon next to the search bar to open the **Import/Export** options.
#. Click **Export to CSV** or **Export to Excel** to export the Contacts in your preferred format.

   |

   .. image:: images/import_export_contacts_segment.png
      :width: 700
      :alt: Screenshot showing Contacts matching that particular Segment.


Static Segments


Static Segments aren't filter-based. Adding Contacts to a Segment in done in one of the following ways:


Manually moving Contacts


The two manual options to move a Contact into a static Segment are:


Batch updating Contacts
  .. vale on

1. Use search filters in the Contacts section of Mautic to find the Contacts to change.

2. Select the checkboxes next to those Contacts.

3. Click the green arrow which appears at the top of the column.

4. Select **Change Segments** from the list.

  :width: 500
  :height: 500
  :alt: Screenshot showing batch change Segment.

5. Choose the **Segments** to add or remove Contacts from.

6. Click **Save**.

  :width: 700
  :alt: Screenshot showing Change Segment.


Adding individual Contacts


1. Navigate to the Contact record you want to change.

2. Click the arrow in the top right, next to **Edit/Send Email/Close**.

3. Select **Preference**.

 :width: 500
 :height: 300
 :alt: Screenshot showing individual change Segment.

4. Click **Segments**.

5. Choose the Segments you'd like to add the Contacts to or remove Contacts from.

6. Click **Save**.

 :width: 700
 :alt: Screenshot showing individual change Segment.


Using a Campaign action


Inside a :ref:`Campaign<campaigns overview>`, you can add or remove Contacts from Segments using the **Modify Contact's Segment** action. To add Contacts to a Segment, you must have already created the Segment and set it to **Public Segment = Yes**.

1. In the Campaign builder, click the bottom connector.

  .. image:: images/campaign-builder-connector.png
    :alt: Screenshot Campaign builder connector.

2. Select **Action**.

3. In the list of actions, select **Modify Contact's Segments**.

4. Choose from the list of existing Segments you want to add or remove your Contact from.

  .. image:: images/modify-segments.png
    :alt: Screenshot showing list of existing Segments.

5. Click Save and close.


Form submit action



**Modify Contact's Segment** is available as a submit action on :ref:`Forms<creating a new form>`.


1. Click **Actions**.

2. From the **Add new submit action** menu, select **Modify Contact's Segments.**

    :alt: Screenshot showing Form submit action.

3. Add a Title for the submit action and add a **Description** - optional.

4. Select the Segments you'd like to add the Contact to or remove the Contact from.

5. Click **Add**.


Points trigger


Once a Contact has accrued an assigned number of Points, the system can add them to a Segment. This may be a Segment for your most engaged Contacts who become eligible for special offers, or a Segment your sales team reviews to find strong prospects.

    :alt: Screenshot showing Points trigger.

1. In the **Points** section of the platform, select **Manage Triggers**.

2. Click **+New**.

3. Give your trigger a **Name** and **Description**.

4. Enter the **Minimum number of Points** for adding a Contact to your Segment.

5. Decide if you'd like to add all Contacts with at least that number of Points to the Segment:


    * If you only want to add new Contacts who reach the threshold to this Segment, select **No** - default.

    * To add all existing Contacts with at least a certain number of Points to the Segment, toggle the switch to **Yes**.

1. Click **Events**.

2. Click the menu for **Add an event** and select **Modify Contact's Segments**.

3.  Add a **Title** for the event and a **Description** - optional.

4.  Select the Segments you'd like to add to or remove the Contact from.

5.  Click **Add**.

6.  Click **Save & Close**.

This accomplishes the same thing as creating a Dynamic Segment with a filter for Points, the operator ``greater than (or equal to)``, and the minimum number of Points. The difference is if you only want to add Contacts to a Segment who reach the point value after creating this trigger to a Segment, you can.


CSV upload


If you have a list outside of Mautic, saved as a UTF-8 encoded CSV file, you can upload the list directly into a Mautic Segment.

1. Click **Contact**.

2. Click the menu in the upper-right hand corner and select **Import**.

3. Ensure the file is in a UTF-8 CSV format. Select your file then click **Upload**.

4. At the top of the next screen, select the Segment you want to add the Contacts to.

5. Map the appropriate fields from the file. Remember to always map the unique identifier, so you don't create duplicates.

6. Click **Import**.

If your file is larger than 1,000 rows, the system changes screens and informs you once the file has uploaded. After the upload is complete, click the Segments section of the platform to see the added Contacts.


Dynamic Segments


    :alt: Screenshot showing Segment filters.

Mautic moves Contacts into and out of dynamic Segments based on the filters applied to the Segment. As the data associated with the Contact updates, including Company associations and behaviors, Mautic updates Segment membership.

Configuring Segment filters

    :width: 400
    :alt: Screenshot showing Segment Filters List.

1. Create a new Segment by clicking the **+New** button.

2. In the **Details** tab, add a **Name**, **Public name** and **Description** to your Segment.

3. Click the **Filters** tab to add filters.

4. Click the **Choose one**… menu and search for the field you'd like to Segment by.


  Listed below are three types of fields:

  * Contact fields

    * Set Fields to **Available for Segments = Yes** in your Custom Field manager to display here.

  * Contact behavior and actions

    .. vale off

    * Behavioral date filters, such as **Read any email (date)** and **Sent any email (date)**, evaluate the most recent date when a Contact has multiple occurrences. For example, if a Contact read emails on January 1 and March 15, the **Read any email (date)** filter evaluates March 15 as the Contact's read date.

    .. vale on

  * Primary Company fields

    * Set Fields to **Available for Segments = Yes** in your Custom Field manager to appear here.

    * Contacts associates with multiple Companies, but Mautic adds them to Segments based on fields for the primary Company.

5. Add more filters, using the **And** and **Or** operators. An **Or** operator creates a new group of filters which can include And operators.

6. Click **Save and close**.


    Segments are rebuilt according to how frequently you fire your :ref:`cron jobs<segment cron jobs>`.

    * If a Segment fails to rebuild for a predetermined length of time, Mautic displays a notification alerting you of an error. For information on defining this time period, see :ref:`Segment settings<segment settings>`
    * Mautic supports include/exclude operators with pipe-separated ``|`` values in the Text field types in Segment filters. You can paste the values from a spreadsheet.


Using Date Filters


You can create dynamic Segments by using date filters.


  The date format for values stored in the database is ``YYYY-MM-DD``. For example, December 11, 2020 is stored as 2020-12-11 and November 12, 2020 is stored as 2020-11-12. To update the display format for dates, go to **Settings > Configuration > System Settings > System Defaults**. However, this doesn't alter the storage format in the database.


Operators

    :alt: Screenshot showing Operators.


You must ensure that you use the correct operator and time frame to build an effective Segment.

Once you've selected a date field as your filter, such as the default **Date last active** field or a custom **Birthday** field, you'll have a list of operators to choose from:

* **Equals** - The value on the Contact record exactly matches the filter value.

* **Not Equal** - The value on the Contact record is any value that doesn't match the filter value.

* **Greater than** - The value on the Contact record is at a later date in time than X date. For example, ``Greater than`` today means anytime from tomorrow until the end of time.

* **Greater than or equal** - The value on the Contact record is either at a later date in time than or including X date. For example, ``Greater than or equal`` today means anytime from today until the end of time

* **Less than** - The value on the Contact record is at an earlier date in time than X date. For example, ``Less than today`` means anytime from the beginning of time until yesterday.

* **Less than or equal** - The value on the Contact record is at an earlier date in time than X date. For example, ``Less than or equal today`` means anytime from the beginning of time until today.

* **Empty** - No value exists in the field on the Contact record.

* **Not empty** - A value exists in the field on the Contact record.

* **Like** - This operator isn't supported in date or date-time fields, don't use it.

* **Not like** - This operator isn't supported in date or date-time fields, don't use it.

* **Regexp** - Segment includes Contacts with values that match the specified regular expression pattern. If you aren't proficient with regular expression, don't use this operator.

* **Not regexp** - Segment includes Contacts with values that don't match the specified regular expression pattern. If you aren't proficient with regular expressions, don't use this operator.

* **Starts with** - Segment includes Contacts whose field values begin with the specified numbers. These filter values should generally reference years, or years and months.

  *For example, A value of 19 matches any Contacts whose field value has a year in the 1900^s. A value of 200 matches Contacts with a year value between 2000 and 2009 and a value of 2020-11 matches Contacts with a field value in November 2020.*

* **Ends with** - Segment includes Contacts whose field values end with the specified numbers. These filter values should generally reference days, or months and days.

  *For example, A value of 1 matches anyone whose field value is on the 1^st, 21^st, or 31^st of any month but a value of 01 matches the 1 st of a month. A value of 01-01 finds Contacts whose value is for January 1 of any year.*

* **Contains** - Segment includes Contacts with the specified filter value anywhere in the field value.

    :alt: Screenshot showing Operators.

Once you have selected the field you can then choose the type of operation to perform. These vary depending on the way you wish to filter your Contacts.

Operators for select fields

Single-select fields, such as Country, Timezone, Region, Locale, and custom select fields, offer these operators:

* **Equals** - The Contact's value exactly matches the selected option.
* **Not equal** - The Contact's value doesn't match the selected option.
* **Empty** - The Contact has no value for this field.
* **Not empty** - The Contact has a value for this field.
* **Regexp** - The Contact's value matches the specified regular expression pattern.
* **Not regexp** - The Contact's value doesn't match the specified regular expression pattern.
* **Including any of** - The Contact's value matches at least one of the selected options.
* **Excluding any of** - The Contact's value matches none of the selected options.

A multiselect field can hold more than one value at once, so it offers a different set of operators:

* **Including any of** - The Contact's values include at least one of the selected options.
* **Excluding any of** - The Contact's values include none of the selected options.
* **Including all of** - The Contact's values include every selected option.
* **Excluding all of** - The Contact's values don't include every selected option.
* **Empty** - The Contact has no value for this field.
* **Not empty** - The Contact has a value for this field.

The two sets aren't identical. A multiselect field doesn't offer **Equals**, **Not equal**, **Regexp**, or **Not regexp**, since those compare against a single value. Instead, it adds **Including all of** and **Excluding all of** to match against every selected value.


   The ``Including all of`` and ``Excluding all of`` operators appear only for multiselect fields, since they require a Contact to hold more than one value. Single-select fields, such as Country, Timezone, Region, and Locale, hold only a single value, so these operators don't apply.


Matching part of a string


There are 5 filters you can use for matching part of a string - ``starts with``, ``ends with``, ``contains``, ``like`` and ``regexp``.
First three filters match strings as you enter it. ``like`` filter is for advanced Users - you can specify which type you want to use with ``%`` character:

* ``My string%`` is the same as ``starts with`` filter with ``My string`` value.

* ``%My string`` is the same as ``ends with`` filter with ``My string`` value.

* ``%My string%`` is the same as ``contains`` filter with ``My string`` value.

* ``My string`` is the same as ``contains`` filter with ``My string`` value.

A few notes for text filters:

* You should use ``starts with``, ``ends with``, ``contains`` rather than ``like`` as they're more specific, and therefore can be more effective.

*  A ``%`` character in the middle of the string has no special meaning. A ``contains`` filter with ``my % string`` searches for a string with ``%`` in the middle. The same is TRUE for a ``like`` filter with ``%my % string%`` value. There is no need to escape this character.

* Mautic searches for the ``%`` character in a value for the ``like`` filter, if finding at least one ``%`` Mautic doesn't perform any modification.

You can use regular expressions in a ``regexp`` filter. Mautic recognises all common operators like ``|`` for OR  - for example ``first string|second string``, character sets including ``[0-9]``, ``[a-z0-9]`` and so forth, repetitions (``+``, ``*``, ``?``) and more.

You have to escape special characters with ``\\`` if you want to use them as matching character.

Learn more about :xref:`Regex`.


  MySQL (and Mautic) uses ``POSIX`` regular expressions, which could behave differently from other types of regular expressions.


Date options


Date filters allow you to choose a date via DatePicker:

    :alt: Screenshot showing DatePicker.

However, you can specify much more here. Mautic recognizes relative formats too - these string aren't translatable:

* ``+1 day`` - you can also use ``1 day``
* ``-2 days`` - you can also use ``2 days ago``
* ``+1 week`` / ``-2 weeks`` / ``3 weeks ago``
* ``+5 months`` / ``-6 months`` / ``7 months ago``
* ``+1 year`` / ``-2 years`` / ``3 years ago``

Example - Consider that today is ``2022-03-05``:

* ``Date identified equals -1 week`` returns all Contacts identified on 2022-02-26.
* ``Date identified less than -1 week`` returns all Contacts identified before 2022-02-26.
* ``Date identified equals -1 months`` returns all Contacts identified on 2022-02-05.
* ``Date identified greater or equal -1`` year returns all Contacts identified 2021-03-05 and after.
* ``Date identified greater than -1`` year returns all Contacts identified after 2021-03-05.

Beside this you can specify your date with text. These formulas are **translatable** - Mautic displays them in your current language setting.

* ``birthday`` / ``anniversary``
* ``birthday -7 days`` / ``anniversary -7 days``
* ``today`` / ``tomorrow`` / ``yesterday``
* ``this week`` / ``last week`` / ``next week``
* ``this month`` / ``last month`` / ``next month``
* ``this year`` / ``last year`` / ``next year``
* ``first day of previous month`` / ``first day of January 2022``
* ``last day of previous month`` / ``last day of January 2022``


   Relative date values like ``today``, ``tomorrow``, and ``this week`` work correctly regardless of your Mautic language setting. Switching languages doesn't affect how Segments evaluate these filters.

Example (Consider that today is ``2022-03-05``):

* ``Date identified equals last week`` returns all Contacts identified in the specified date range, for example 2022-03-01 - 2022-03-07.
* ``Date identified less than last week`` returns all Contacts identified before 2022-02-22.
* ``Date identified equals last month`` returns all Contacts identified in the specified date range, for example 2022-02-01 - 2022-02-28.
* ``Date identified greater or equal last year`` returns all Contacts identified 2021-01-01 and after.
* ``Date identified greater than last year`` returns all Contacts identified after 2021-12-31.
* ``Date identified greater than first day of previous month`` returns all Contacts identified after 2022-02-01.
* ``Date identified greater than last day of previous month`` returns all Contacts identified after 2022-02-28.
* ``Custom Contact date field equal birthday -1 day`` returns all Contacts identified every year on 03-04 (4th march).
* ``Custom Contact date field equal anniversary -1 month`` returns all Contacts identified every year on 02-04 (4th february)

Once you have created your Segment, any applicable Contact is automatically added through the execution of a :ref:`cron job<import contacts cron job>`. This is the essence of Segments.

To keep the Segments current, create a cron job that executes the :ref:`command<segment cron jobs>` at the desired interval.

Through the execution of that command, Mautic adds Contacts that match the filters and removes Contacts that no longer match. Any Contacts that were manually added remain part of the list regardless of filters.


Delete all Contacts in a Segment


It's possible to delete all Contacts in a Segment manually rather than with a Campaign action. To do this, first create a Segment with filters that picks up all the Contacts you want to delete.

This is a performance precaution since deleting more Contacts at one time could cause issues. You can, however, delete multiple batches of 100 Contacts to delete larger lists.

1. Select the checkboxes next to those Contacts.

2. Click the green arrow which appears at the top of the column.

3. Select **Delete Selected** from the list.


4. Click **Delete**.

    :width: 200
    :alt: Screenshot showing Deleting all Contacts in a Segment.

Deleting thousands of Contacts this way in one Segment becomes a tedious task. Luckily, there is a trick how to let the background workers do the job for you.

1. Create a Campaign which has the Segment as the source

2. Use the :ref:`Delete contact action<using the campaign builder>`.

This way the ``mautic:campaign:update`` and ``mautic:campaign:trigger`` commands delete all the Contacts in the Segment, and all the Contacts added to the Segment in the future.
It's all done automatically in the background.
It's necessary to configure the :ref:`cron jobs<segment cron jobs>`.


  You can't recover deleted Contacts unless you restore your entire Mautic database backup. **Use with extreme caution**.

    :alt: Screenshot showing deleting used Segment.


Deleting or deactivating a Segment


Since :xref:`Mautic 4` there is a step when deleting or deactivating a Segment to ensure that it's not required as a filter by an existing Segment.

    :width: 300
    :alt: Screenshot deleting or deactivating a Segment

If you attempt to delete or deactivate a Segment which is in use by a filter in another Segment, an alert prompts you to edit the other Segment, removing the dependency before you delete the Segment.""",
    ),

  ],
),

AppCourse(
  id: "marketing_21",
  title: "Stages",
  description: "Stages",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "1 Lessons",
  lessons: [
    AppLesson(
      title: "Stages",
      body: r"""Stages

Mautic Stages provide a means for Users to track and manage the progress of their Contacts through the various phases of the marketing lifecycle or funnel.

By categorizing Contacts into different Stages, you can better understand their engagement with the brand and tailor your marketing strategies accordingly.

Once you have created your Stages, you can easily move Contacts from one Stage to another based on their behavior or other criteria.


Creating Stages


Navigate to the **Stages** section in the left side menu, and then click **+New**.

   :align: center
   :alt: Mautic Stages

|

**Name** - While most Companies have similar Stage structures, each Company uses them differently. Come up with the Stages you want to track different parts of your marketing funnel with.

**Description** - To help you and other Users easily identify what qualifies a Contact for that Stage, it's recommended to add a description.

**Weight** - Used to decide the progression of your Stages. The greater the Stage weight number, the further along in the funnel a Contact is. Contacts can't move backwards to Stages with lower weights.

**Category** - Assign a Category to help you organize your Stages. For more information, see :ref:`categories`.

**Activation options** - The dashboard widget doesn't display data for an inactive Stage. In addition, the Segment filters or Campaign conditions don't display the Stage. To avoid using the Stage while building it, set a future activation date and time. If you want the Stage to become unavailable after a certain time, set the date and time for deactivating.


Moving Contacts between Stages


Moving Contacts between Stages requires a Campaign action.

Depending on how you define your Contact lifecycle and Stages, there may be different triggers for a Contact to move between Stages. Examples include behaviors within a Campaign, or moving between Segments which have criteria set up for each Stage.

In any Campaign where you want to have Contacts move between new Stages:

   :align: center
   :alt: Moving Contacts between Stages

|

1. Add a new **Action**.

2. Select **Change Contact's Stage** as the action type.

3. Select the Stage you want to move the Contacts to. You can base this on a prior event, or on a Segment that Contacts are in based on filters matching your requirements for a Stage.

For more information on setting up Campaigns, see :ref:`triggering campaign events`


    You can have multiple funnels with different Stages, and multiple Stages across those funnels with the same weight. A Contact can only ever be in one Stage at a time. It's not possible to move a Contact to a Stage which has a lesser weight than their current Stage. For example if they're currently in Stage B which has a weight of 50, you can't move them to Stage A which has a weight of 25.


Visualizing Stage movement


The Mautic dashboard features two widgets to help Users see how Contacts are moving between Stages.

   :align: center
   :alt: Visualizing Stage movement

|

The Stages in time widget shows how often Contacts change Stages. More change indicates more velocity through your funnel.

Lifecycle

The lifecycle widget enables marketers to see the number of Contacts within a specified Segment in each Stage. You may include multiple Segments on the widget. It's possible to have more than one lifecycle widget to break down the information into separate graphs, but still display the data on the dashboard for multiple Segments.""",
    ),

  ],
),

AppCourse(
  id: "marketing_22",
  title: "Themes",
  description: "Themes",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "4 Lessons",
  lessons: [
    AppLesson(
      title: "Code Mode",
      body: r"""Code mode


Code Mode is an option available in the Email and Landing Page edit Form. It allows you to create/insert/edit your content in HTML code. It's helpful for situations where you don't want to use a Mautic Theme and you want to use an HTML Theme copied from a third party Theme builder, or if you prefer editing HTML code directly.

The other option to edit Landing Page/Email content is to use the built-in drag-and-drop GrapesJS Builder. Read more in the :doc:`/builders/email_landing_page` section.

Select the Code mode

If you want to work with existing HTML, select code mode from the Theme selector. To open the code mode Builder, click the advanced tab which appears.

    :width: 600
    :alt: Screenshot of code mode builder

Limitations

If you use a Mautic Theme to create the Landing Page/Email and you subsequently want to edit the HTML code, you should think carefully about doing this.

Once you switch from a Theme to Code Mode, content becomes HTML and you can't switch back to the Theme again.

Selecting a Theme replaces the content with that of the default Theme, so you'll lose your modifications.

Instead, to make small code changes to an existing Theme, it's recommended to use the code mode built into the GrapesJS Builder.

    :width: 600
    :alt: Screenshot of code mode


Edit the HTML content in the code mode Builder


In code mode, you can see the HTML content in the text area under the Advanced tab. There is no preview at this time.

Mautic tokens

You can use the tokens in the code mode Builder by typing them directly into your code. For example when you type ``{contactfield=firstname}``.""",
    ),

    AppLesson(
      title: "Customizing Themes",
      body: r"""Customizing Themes


It's possible to customize Themes, or even to create your own from scratch, with Mautic. To do this go to the Theme Manager, open the drop down menu next to the pre-installed Theme you want to modify and download it.


Customizing an existing Theme


To customize the downloaded Theme, review the :xref:`Themes directory structure` section in the Developer Documentation for detailed guidance.""",
    ),

    AppLesson(
      title: "Manage Themes",
      body: r"""Manage Themes


Themes control the look and feel of the Mautic Landing Pages, Emails, Forms and Message screens.

A basic Mautic installation comes pre-packaged with a number of Themes for you to use 'as-is' or adapt to suit specific projects.

It's also possible to create :xref:`Themes` for Mautic from scratch.

Access the Theme Manager via the Admin Menu. Click the cog icon in the top right corner to open it and select the Theme menu item.

The Themes section displays the list of Themes with the following details:

**Title** - The name or title of the Theme.

**Author** - The name of the author or creator of the Theme.

**Feature** - The list of features and Builders that the Theme supports.

    :width: 600
    :alt: Screenshot of Theme list

This list of Themes appears as selectable options in Forms, as this allows you to provide styling for Forms.

Additionally, you can edit and customize Themes in the Email and Landing Page builders to meet your needs.

With the Email and Landing Page builders, you can start from a template and build your own variations using the drag-and-drop Builder. For more information, see :doc:`Email builder</builders/email_landing_page>` and :doc:`Landing Pages</components/landing_pages>`.


Installing a Theme


It's necessary to install a new or edited Theme as a zip package. The zip package must have the same structure as the preinstalled Themes and the ``config.json`` file must be present in the root folder of the zip package. The :xref:`Themes directory structure` section in the Developer Documentation contains more information about that.


    You must select and zip all the files when creating the zip package. Ensure that you don't zip the files within a folder, otherwise the Theme won't install.

You can build and install your own Forms Theme using Twig, and you can also install BeeFree templates as Themes.

To install a Theme:

1. Log in to Mautic.

2. Click the **Settings** icon.

3. Click **Themes**.

4. On the Themes section, in the top-right corner, click **Choose file**.

5. Browse and select the Theme.

6. Click **Install**.


Deleting a Theme


To delete a User-created Theme:

1. Log in to Mautic.

2. Click the **Settings** icon.

3. Click **Themes**.

4. In the Themes section, locate the Theme that you want to delete.

5. Select the drop-down before the Theme, and click **Delete**.

6. In the confirmation dialog box, click **Delete**.


Previewing a Theme


To preview a Theme:

1. Log in to Mautic.

2. Click the **Settings** icon.

3. Click **Themes**.

4. In the Themes section, locate the Theme that you want to preview.

5. Select the drop-down before the Theme, and click **Preview**.

6. Mautic displays the preview of the Theme.


Hiding a Theme


Users can't remove default Themes, but they can hide them from the list of Themes in the Email and Landing Page builders.

To hide a Theme:

1. Log in to Mautic.

2. Click the **Settings** icon.

3. Click **Themes**.

4. In the Themes section, locate the Theme that you want to hide.

5. Select the drop-down before the Theme, and click **Hide**.

6. Mautic moves the Theme to the bottom of the table and show it in grey, which hides it within builders.

To revert this change open the context menu of the hidden Theme and click **Unhide**.


Downloading a Theme


To download a Theme:

1. Log in to Mautic.

2. Click the **Settings** icon.

3. Click **Themes**.

4. In the Themes section, locate the Theme that you want to download.

5. Select the drop-down before the Theme, and click **Download**.

Upon downloading a Theme on your local machine, you can modify it following the structure outlined in the :xref:`Themes` section of the Developer Documentation before reinstalling it for use in your instance.


Update an old Theme


Mautic overwrites old Theme files when installing a Theme which already exists in Mautic. Therefore, the Theme updates can be also done by uploading the Theme with the new changes.

Pre-installed Themes can't be overwritten, because the changes would return again after a Mautic update. If you want to change these Themes, download them and modify them to create a new, custom Theme, as outlined previously.


Assigning a default Theme


You can assign your Mautic instance a default Theme for Landing Pages. Then use the Landing Page Builder to fill in the content for each new Landing Page you create.

    :width: 600
    :alt: Screenshot of Theme


    Changing the Theme after building the Landing Page may cause content to not display if the two Themes don't use the same placeholders.

To assign a default Theme:

1. Log in to Mautic.

2. Click the **Settings** icon.

3. Click **Configuration**.

4. Click Theme **Settings**.

5. From the dropdown menu, select the Theme that you want to use as default.

6. Click **Save & Close**.

Themes are available to select for Emails and Landing Pages when creating them - this setting pre-selects the Theme chosen by default.

    :width: 600
    :alt: Screenshot of all Themes""",
    ),

    AppLesson(
      title: "Theme Structure",
      body: r"""Theme Structure


Visit the :xref:`Themes directory structure` section in the Developer Documentation for more details.""",
    ),

  ],
),

AppCourse(
  id: "marketing_23",
  title: "Translations",
  description: "Translations",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "1 Lessons",
  lessons: [
    AppLesson(
      title: "Translations",
      body: r"""Translation


Being an international project with a world-wide community, many translations for Mautic exist. If you can't find your language yet, take a look to the section about how to :ref:`How to translate Mautic`.

How to select a language in Mautic

There are two places to select the language for the User Interface.

Default language

The default language configuration happens first in the Mautic configuration. The default language is ``English - United States``. Every User has this language if they don't set something different in their profile.

1. Open the configuration menu by clicking on the cog icon in the top right corner.
2. Select the **Configuration** menu item.
3. Select the default language.
4. Save the configuration.

    :width: 600
    :alt: Select the default language


User language


A User can define their preferred language and override the default language. This allows a multilingual team work on the same Mautic instance.

1. Open the User Account menu by clicking on the User's name in the top right corner.
2. Click on **Account** menu item.
3. Select the User language.
4. Save the User profile.

    :width: 600
    :alt: Select the user language

How to translate Mautic

It's possible to translate Mautic into any language. As Mautic is a community project, any community member can suggest and translate Mautic into any language. Mautic uses :xref:`Transifex` to crowd source translations.

1. Create an account at :xref:`Transifex` if you don't have one already.
2. Take a look at the :xref:`transifex-language-list` already existing.
3. Create a language if your language is missing, or apply for an existing language.

Take a look at official :xref:`transifex-documentation` if you have any questions about the translation process.

How to update a language

Mautic downloads language updates automatically when saving Mautic's Configuration, if language isn't already downloaded. To force an update of a language:

1. Open the Mautic file system via SFTP or SSH.
2. In the Mautic root folder you should see the folder called **translations**. Open it.
3. In the **translations** folder are the languages available in Mautic. Remove the folder of the language you want to update.
4. Go to the Mautic Configuration and save it with the language you've deleted selected.

Mautic downloads the language again, with the latest translations. There is a daily process which generates the language packs from Transifex.

If you have any questions about translations, join the :xref:`Mautic Community Slack`.

Translation overrides

Mautic allows you to override the existing language translations without the need to hack the core files. That's a good idea, especially because a Mautic upgrade would remove your modifications. Here's how to change translations correctly:

As an example, to override the first menu item \"Dashboard\" and change it to \"Banana\" follow these steps:

    :width: 600
    :alt: Override Dashboard menu item

Search for the translation key

The best way to search for the right translation key is in a text editor like VS Code that allows you to search for a text in all files of Mautic's source code and filter those files by file extension ``*.ini``.

GitHub has also an option to search for strings in the repository - it's not particularly good search engine but for this example it works well enough.

Try searching for 'Dashboard menu' within the Mautic/Mautic repository, as there is special translation for the menu item and another for the page title. GitHub won't find the right translation when you search for just 'Dashboard' - it requires the full string. Next, use the filter to show only INI files. Here is the link to the search result:


The first file found is ``app/bundles/DashboardBundle/Translations/en_US/messages.ini`` and there is the line ``mautic.dashboard.menu.index=\"Dashboard\"`` within the file, which is text to override.


Override the translation


The string to override is ``mautic.dashboard.menu.index``.

To create the override:

1. Go to the folder ``translations`` in the root directory of the Mautic project
2. Create new folder in it called ``overrides``
3. In this folder, create the folder for the locale to override. In this example, the default locale is in use - ``en_US`` - but if you use different language then you'll see its locale as a folder in the ``translations`` folder - create a folder within the overrides folder using the exact name of the locale.
4. In the ``translations/overrides/en_US`` folder - replace en_US with the locale you are overriding - create new file called ``messages.ini``. Notice it's the same filename as the original. It must be exactly the same. Some translations may be in ``flashes.ini`` or ``validators.ini`` and if you override a translation from those files then you have to create the correct file too, and add the translation strings to be overridden in the file.

In this file, copy the line to override from the original ``app/bundles/DashboardBundle/Translations/en_US/messages.ini`` file and change the translation like so:

``mautic.dashboard.menu.index=\"Banana\"``

Save the file and clear the cache with ``bin/console cache:clear`` command. Refresh your Mautic instance, and the administration is finally perfect:

    :width: 600
    :alt: Dashboard menu item overridden to Banana""",
    ),

  ],
),

AppCourse(
  id: "marketing_24",
  title: "Troubleshooting",
  description: "Troubleshooting",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "3 Lessons",
  lessons: [
    AppLesson(
      title: "File Ownership Permissions",
      body: r"""File ownership and permissions

If you experience errors like the following:


    .WARNING: PHP Warning - require(/mautic/var/cache/prod/doctrine/orm/Proxies/__CG__MauticCategoryBundleEntityCategory.php): failed to open stream: No such file or directory - in file /mautic/vendor/doctrine/common/lib/Doctrine/Common/Proxy/AbstractProxyFactory.php - at line 209

there is a strong likelihood that you have problems with the permissions and/or ownership of the files and folders on your Mautic instance.

This article writes from the perspective of a Linux server using Apache, which is the most common hosting environment for Mautic. NGINX and IIS servers have different configurations, but the principles remain the same.

Why are permissions important?

File and folder permissions specify who and what can read, write, modify, and access them. Ownership determines which User 'owns' the files and folders - and hence is able to carry out actions based on the permission settings.

User

A User is the owner of the file. By default, the person who created a file becomes its owner. Hence, a User is also sometimes called an **owner**.

Group

A Group can contain multiple Users. All Users belonging to a Group have the same access permissions to the file. Groups simplify permissions - all Users in a specific Group inherit the permissions assigned to that Group, rather than having to assign permissions to each User individually.

Other

Any other User who has access to a file comes into 'Other', meaning they have neither created the file, nor belong to a Group that owns the file. Practically, this means 'the rest of the world'. Hence, this is also referred to as **permissions for the world**.

Linux distinguishes between these three User types to prevent Users accessing, editing, or deleting files they shouldn't be able to change. Read more about :xref:`Linux file and folder ownership documentation`.

Permissions and ownership settings are critical to ensuring the security of your server and Mautic instance, so it's important to get them right. If your files don't have the appropriate permissions in place, it's easier for hackers to intrude on your files and gain access to your Mautic instance. Setting your file permissions correctly may not save you from all attacks, but it helps make your Mautic instance a bit more secure.

Why do permissions problems cause errors in Mautic?

Mautic needs access to read and write files in the Mautic directory to enable certain functions and scripts to run. If the permissions aren't set correctly, or if the User running them doesn't have the correct access, Mautic can't function properly and errors occur in the app and server logs as a result.

Problems with permissions and ownership generally occur because:

* You've uploaded Mautic or made changes to files and folders as a different User to the one that Mautic uses to run - for example you uploaded files using an FTP account with the username ``bob`` but your web server executes scripts as a User called ``www-data``
* The User that Mautic uses to run doesn't have the appropriate permissions on the files and folders - for example, ``bob`` isn't able to create directories, or read files
* You ran an update as a different User to that which Mautic uses to run - resulting in some files and folders having their ownership changed

How to fix permission-related problems in Mautic

Resetting the permissions of your files and folders requires running some commands at the command line. You need to have SSH access to your server, or ask someone who does to execute these commands for you. Some hosting providers may be able to create a script to periodically reset permissions if this becomes an ongoing problem for you.

Solution for hosting providers that offer cPanel access

A script to fix permissions & ownership, on files & directories, for cPanel accounts. You could ask your hosting provider to run that script to reset the permissions to the correct values. Find this handy script here: :xref:`cPanel fix permissions script`.

Identifying the problem

Log into your server using SSH, and change to the Mautic directory using the command:


    cd path/to/mautic

In this directory, execute the following command:


    ls -l

The ``ls`` command lists files and directories. It has an option of ``-l``, which lists the contents in a long format, including their permissions and ownership amongst other information.

For a more detailed explanation of what all the information means, take a look at this article: :xref:`Linux ls command`.

The key information is in the first, third, and fourth columns - the permissions, and the User and Group owning the files/folders.

Reset the file and folder permissions

If your file and folder permissions are incorrect, you can run the following commands to reset them:


    find . -type f -not -perm 644 -exec chmod 644 {} +
    find . -type d -not -perm 755 -exec chmod 755 {} +
    chmod -R g+w var/cache/ var/logs/ app/config/
    chmod -R g+w media/files/ media/images/ translations/
    rm -rf var/cache/*

Change ownership of files and folders

Errors can continue if there is a problem with ownership of your files and folders, even with the correct file and folder permissions. This is because the User may not have the necessary permission - as they're not the owner of the files/folders. Read more about :xref:`Linux file and folder ownership documentation`.

To find out which User Apache is running as, run the following command and take note of the first entry in the line returned:


    ps aux | grep apache2

Use this information to find the Groups with the following command:


    groups apache_user - where apache_user is the user you identified from the first step above

To reset the ownership of files and folders, use the following command - ensuring that you replace ``apache_user`` and ``apache_group`` with the values identified in the preceding steps:


    sudo chown -R apache_user:apache_group /path/to/mautic


This command **ch-** anges **own-** ership, using the ``-R`` flag which means recursively - including all files/folders within that location. Read more about the :xref:`Linux chown command`.""",
    ),

    AppLesson(
      title: "Troubleshooting",
      body: r"""Troubleshooting a failed update

Sometimes when updating Mautic, the process might stall or fail part way through. This can cause a problem, because it can cause Mautic to be in-between two versions and often this can make the system unusable.

    Generally speaking, updates fail in this way because the hosting environment is inadequately resourced. Consider moving to a Virtual Private Server or Dedicated Server if you are using shared hosting. Read more in the :doc:`/getting_started/how_to_install_mautic` and :doc:`/getting_started/how_to_update_mautic` sections.

The following processes enables the completion of a failed upgrade.

Before you commence these steps, please ensure that you have a **tested backup of your Mautic instance** where possible.

Checking for schema updates

Mautic has a built-in tool which enables you to verify the database and identify if there are any schema updates required. Visit ``example.com/s/update/schema`` to see if there are any updates required.

If this isn't possible, or your Mautic instance is down completely, follow the next tips.

If you don't have SSH access, skip down to :ref:`SSH access isn't available`.

SSH access is available

Having SSH access to your server makes things much easier. Log in via command line, and change directory to the Mautic directory using the command:


    cd /your/mautic/directory

1. Try to clear the cache

When an upgrade attempt fails in the final step, it may be only the outdated cache that's causing a problem. Use the following command to clear it manually:


    php bin/console cache:clear

If this command throws a PHP error, you can try to remove the cache folder using the following command - be careful, this removes all files and folders in the path specified, so ensure you type it correctly, and in the correct directory.


    rm -rf var/cache

If clearing the cache hasn't resolved your problems, continue with the next step.

2. Trigger an update manually

The first step is to determine if there are any updates available using the following command:


    php bin/console mautic:update:find

The output from this command informs you if there are any updates to apply. If there are, run the following command to apply them:


    php bin/console mautic:update:apply

If there are no updates found, proceed to the next step.

3. Check for outstanding database migrations

Run the following command to identify any outstanding database migrations:


    php bin/console doctrine:migration:status

If there are any reported, firstly ensure that you have a tested backup of your database before proceeding, as this command causes changes to the database, then run:


    php bin/console doctrine:migration:migrate

4. Try to update the files manually

This step requires some manual intervention - there is no command for this part.

To update the files manually, you have to:

   1. Back up (download) all Mautic files from your server to your local computer, using File Transfer Protocol (FTP) or the ``scp`` command, which is much faster.
   2. Delete all Mautic files and folders on your server. Use FTP or the rm command - use the latter with extreme caution.
   3. Download the latest Mautic package from :xref:`Mautic Download`.
   4. Upload the zip package to the server, to the Mautic folder, using FTP or the ``scp`` command which is much faster.
   5. Unzip the package with ``unzip 3.3.3.zip`` -change the filename to match the one you have uploaded. You can then remove the zip file using the command ``rm 3.3.3.zip``.
   6. Upload ``config/local.php`` - note the location is ``app/config/local.php`` prior to Mautic 5.0 - from your backup on your local machine to the fresh Mautic folder on the server - Mautic should now run.
   7. Upload your custom data if you have some. You'll find custom files in the following folders: ``media/files``; ``plugins``; ``themes``; ``translations``.

SSH access isn't available

There is a PHP script which can do almost all steps from the section preceding. You can find this script :xref:`Troubleshooting PHP script`.

Below the script itself the description about how to use the script. There are some details you need to do differently, so please read these instructions carefully. For example, you must use FTP to upload and download the files. You must unzip the files on your local computer and upload those files, which takes a lot longer.

There is a PHP error when running a command

Firstly, read the error message which usually gives good indications to the problem. Next, search for the error in your preferred search engine. You can also search the :xref:`Mautic Community Forums` to see if others have reported and resolved the same problem.

Allowed memory size exhausted

This error reported is:

``PHP Fatal error:  Allowed memory size of 67108864 bytes exhausted (tried to allocate 10924085 bytes) in ...``

This means that the memory limit that Apache has available is too low. Edit the ``memory_limit`` in the ``php.ini`` configuration file.

Read more about this in :doc:`/troubleshooting/working_with_resource_limits`.

A required PHP extension is missing

``Fatal: Class 'ZipArchive' not found``

This means that PHP can't work with Zip packages - you must make changes to your server configuration to allow unzipping of files at the command line. Ask your hosting provider, or search for a tutorial to help with this.

Need further help?

If you need help, there are several places you can go to ask for assistance. Remember that most people who use the Community Forums, Chat, and GitHub are volunteers.

If you think your configuration is causing the problem, ask on the :xref:`Mautic Community Forums`. Search before you post, as it's likely someone might have already answered your question in the past.

You can also chat with someone in the live :xref:`Mautic Community Slack` however you must post all support requests must on the forums. Make a thread there first, then drop the link to the post in Slack if you are discussing it with someone.

In all cases, it's important that you describe the problem, and all steps you have followed to resolve the problem, in detail. At a minimum, include the following:

* Steps to reproduce your problem - a step-by-step tutorial of how the problem arose, or how to reproduce it
* The PHP version of your server
* The error messages you are seeing - if you don't see the error message directly, search for it in the var/logs folder and in the server log. Server logs are in different places depending on your setup. Ubuntu servers generally store their logs in ``/var/log/apache2/error.log``. Sometimes your hosting provider might offer a GUI to view logs in your Control Panel.

If you don't provide this information as a minimum, the person who might try to help you has to ask you for it, so please save them the trouble and provide the information upfront. Also, importantly, please be polite. Mautic is an Open Source project, and people are giving their free time to help you.""",
    ),

    AppLesson(
      title: "Working With Resource Limits",
      body: r"""Working with resource limits

You may come across limitations with your server configuration when installing or using Mautic. These commonly manifest as errors such as:


    The Uploaded file exceeds the upload_max_filesize directive
    Maximum execution time of 30 seconds exceeded - in file <filepath> - at line <line number>
    PHP Error: Allowed memory size of <number> bytes exhausted (tried to allocate <number> bytes) - in file <filepath> - at line <number>

These are, in general, not errors with Mautic, but with your server configuration. To resolve these issues you need to make some changes to your server configuration.

Resolving issues

To resolve these problems you require:

* Access to your server to change configuration files - generally via SSH - or;
* Access to your hosting provider's Control Panel, which may allow you to change these settings via the User Interface * Access to a text editor such as ``Nano`` or ``Vi``

    Note: Nano is used in this walk through, if you don't use Nano simply replace 'nano' with the name of the editor you prefer to use. See this :xref:`Nano keyboard commands` cheat sheet for a useful keyboard shortcut guide when using Nano.

Find the ``php.ini`` file loaded

The first step is to find which ``php.ini`` file in use. The :xref:`php.ini file` is a configuration file which controls how PHP functions.

You have access to Mautic

If you have access to your Mautic instance, navigate to Settings > System Info > PHP Info where you can view a file which tells you every configuration setting for PHP that Mautic is using. In particular, the areas outlined in red in the screenshot below give you the paths to the relevant files.

    :width: 400
    :alt: Screenshot of PHP settings in Mautic dashboard

A note on local versus master values

When you view the PHP info file, there are two values, ``Master`` and ``Local``.

Master value

This comes from your main ``php.ini`` file - the one loaded in the preceding section. This is the value which applies server-wide.

Local value

The global setting can be overridden locally in multiple locations, such as ``httpd.conf``, ``.htaccess`` or other Apache configuration.

This is often used to get around restrictive settings at the server level, and can sometimes mean that making changes at the top global level doesn't trickle down to your specific folder or location. So if you have a discrepancy between the two, look for a local ``.htaccess`` or a ``*.ini`` file within your Mautic directory, or verify with your hosting provider.

You don't have access to Mautic

If you can't access the System Info of Mautic, you can verify the path for ``php.ini`` using a command:


    php -i | grep .ini

You can also use the same command to find the specific value used:


    php -i | grep upload_max_filesize

where ``upload_max_filesize`` is the value you need to change.

Updating the value

Once you have located the ``php.ini`` file in use, you should be able to edit it using the following command:


    sudo nano path/to/file/php.ini

Find the relevant setting using ``ctrl+w`` - keyboard shortcut for 'where' - and then typing the setting you need to change - for example ``upload_max_filesize``.

Change the value you see in the ``php.ini`` file, and then save, using ``ctrl+x`` - keyboard shortcut for 'exit' and then pressing ``y`` to save changes.


Restarting Apache


Once you've saved the changes, you need to restart Apache for the changes to take effect.

It's always a good idea to do a dry-run first, using the :xref:`Apache configtest` command


    sudo apachectl configtest

This checks that your Apache configuration is sound before you restart the service. Resolve any issues identified before restarting Apache.

Once you are happy, run the following command to restart Apache:


Ubuntu and Debian



    sudo systemctl restart apache2


CentOS and Red Hat



    sudo systemctl restart httpd

Overriding the value

If you aren't able to change the value at the ``php.ini`` level, it may be possible - dependant on your server configuration - to override the value at the local folder level.

Check out this :xref:`PHP config changes` article for more details on how to override the ``php.ini`` settings with a local ``.htaccess`` file.

As an example of two settings you may wish to use in a local htaccess file to override the values in the global ``php.ini`` file:


    php_value upload_max_filesize 20M
    php_value max_execution_time 600

This is a last resort, and your hosting provider may not support it.""",
    ),

  ],
),

AppCourse(
  id: "marketing_25",
  title: "Users Roles",
  description: "Users Roles",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "2 Lessons",
  lessons: [
    AppLesson(
      title: "Managing Roles",
      body: r"""Roles

You can control access to Mautic instances by creating accounts for Users and associating them with a Role.


Mautic uses Roles to control which resources and actions Users can access. When team members have different responsibilities, you may not want some team members working in certain parts of Mautic.

By default, Mautic creates new Users with the Administrator Role with full system access. You can change that when manually creating a User, or select a different Role when importing a User by API.


Roles overview

To view Roles, navigate to **Settings** > **Roles**. The Roles listing shows every Role in your Mautic instance, with a short description and the number of Users assigned to each one.

   :width: 800
   :alt: Mautic Roles listing

The listing includes these columns:

* **Name** - The name of the Role. Click a Role name to open and edit it.
* **Description** - The optional description you added when creating the Role.
* **User Count** - A badge showing how many Users have this Role. Select **View X Users** to open a filtered list of the Users assigned to the Role. Roles with no assigned Users show a 'No Users' badge.
* **ID** - The internal identifier Mautic assigns to the Role.


Sorting Roles by the number of Users


You can sort the Roles listing by the number of Users assigned to each Role. Click the **User Count** column header to sort in ascending order, then click it again to switch to descending order.

   :width: 400
   :alt: The User Count column header with the sort control

This makes it easy to find the Roles that most Users depend on, or to spot Roles that no longer have any Users assigned.


Creating a new Role


Full system access

If you select **Yes** on the **Full System Access** switch, you are creating an Administrator account which has the highest level of access to your Mautic instance.

  :alt: Screenshot showing Mautic Roles

1. Navigate to **Settings** > **Roles**.

2. Click **+New** in the top right corner.

3. In the **Details** tab, add a **Title** and **Description**.

4. Select **Yes** on the **Full System Access** switch.

5. Click **Save & Close**

Limit these accounts, and ensure that their credentials are secure.

If you select this option, you won't be able to configure anything under **Permissions** because by default, this account has full access to everything.

Setting granular permissions

Mautic allows you to create Roles with granular permissions for each bundle - or part - of Mautic.

To configure a Role, leave the **Full System Access** switch at **No** and click the **Permissions** tab to start building the Role.

1. Navigate to **Settings** > **Roles**.

2. Click **+New** in the top right corner.

3. In the **Details** tab, add a **Title** and **Description**.

4. Click the Permissions tab. The list of User permissions displays.

  :width: 800
  :alt: Screenshot showing Mautic Roles

5. Most permission Categories have options for **View**, **Edit**, **Create**, **Delete**, and **Active**. Select checkboxes for the appropriate permissions for this Role. To select every checkbox and grant the User all permissions, select the **Full** option.

Explaining the permission options

There are several options for selecting permissions:

* **View** - this allows the Users with this Role to view this part of Mautic

* **Edit** - this allows the Users with this Role to make changes to this part of Mautic

* **Create** - this allows the Users with this Role to create new resources in this part of Mautic

* **Delete** - this allows the Users with this Role to delete resources in this part of Mautic

* **Activate** - this allows the Users with this Role to make resources in this part of Mautic available by activating them

* **Full** - this allows the Users with this Role all of the permissions.

There are permission levels relating to resources the User has created themselves, and those created by others:

* **Own** - this allows the Users with this Role to ``view/edit/delete/activate`` their own resources in this part of Mautic, but not those created by others

* **Others** - this allows the Users with this Role to ``view/edit/delete/activate`` their own resources in this part of Mautic, and those created by others

There are permission levels relating to being able to manage resources:

* **Manage** - this allows the Users with this Role to manage resources in this area of Mautic for example, managing Custom Fields or Plugins.

There are permission levels relating to the editable fields in the Users section:

* **Specified fields** - allow or deny the Users with this Role to edit specified fields in the Users section for example, Name, Username, Email, Position.

* **All** - this allows the Users with this Role to edit all fields relating to the Users section

Since Mautic 5.1 there is an additional permission relating to allowing Users of Mautic to export information. You can set this permission within the Contact, Forms, and Reports Permissions. If this permission isn't set, the User won't see the options for, or be able to export, information - such as lists of Contacts, Form submissions and Report data - from Mautic.


  User permissions restrict their view of dashboard widgets, resulting in them only seeing widgets for items or feature bundles they have permission to see.

  For example, if a User's Role doesn't have Asset permissions, they can't create or view widgets on the dashboard for Asset data.

You can also create :xref:`Roles using the API`.""",
    ),

    AppLesson(
      title: "Managing Users",
      body: r"""Managing Users


An Administrator can manage Users with appropriate permissions in Mautic by accessing the settings cog wheel at the top right of the screen.

Create the User by completing all the mandatory fields, adding a signature if required, and assigning them a username and password. Always use a secure password for Users with access to your Mautic instance.

  :alt: Screenshot showing Mautic Users

You can set up new Users in Mautic manually or through the API.

To set up a User manually:

1. Navigate to **Settings** > **Users**.

2. Click **+New** in the top right corner.

3. Fill in the appropriate fields for your User:

   * **First name** and **Last name** - Your User's first and last name.

   * **Roles** assigned based on permissions you grant.

   * **Signature** is only necessary if you're using the Mailer is owner feature in Mautic.

   * **Position - optional** - Your User's job title.

   * **Username, Email, Password** are the login credentials. If a User forgets their password, they can use the Forgot password link, but you can manually change their password here.

     Passwords must be **at least six characters** in length. Ensure that you use a combination of upper and lower case alphabets, special characters, and numbers.

     .. note::

        .. vale off

        When you log in through SAML, Mautic hides the password fields on the User add and edit forms. SAML Users manage their passwords in the identity provider, not in Mautic. For more information, see :doc:`SAML Single Sign On </authentication/authentication>`.

        .. vale on

   * **Time zone** - Set the User's time zone, or use the default. Adding the User's time zone enables them to account for time zone differences for Email scheduling and other features.

   * **Language** - Select a language for each User, to improve their experience in Mautic.


   .. vale off

   Once you create Users, give them their credentials directly because Mautic doesn't send emails with their login information.

   .. vale on""",
    ),

  ],
),

];
