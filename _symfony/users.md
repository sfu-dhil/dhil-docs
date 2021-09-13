---
layout: default
title: User Management
---

# User Management

This document explains the process for adding, updating, and removing users
from a Symfony application.

Our project PIs do not have access to manage users. SFU IT's security policy 
requires all user management be done by IT staff or developers. 

In default, unstyled, Symfony applications the user menu is located in the
top-right corner of every web page. If you are not logged in, the menu will
be hidden and "Login" will be displayed in its place.

![screenshots/symfony/user-menu.png]({{ "assets/screenshots/symfony/user-menu.png" | relative_url }})

All users can access this menu to update your own profile and password, or to 
log out. If you have the appropriate permissions, you will also be able to 
manage users with the item at the bottom.

There are several fields associated with users in a symfony application. 

- **Active**: Users with active accounts can log in to the site. Users with 
  inactive accounts cannot. This provides an alternative to removing a user 
  account. If the user leaves the project temporarily the account can be 
  made inactive.
- **Email**: This is the only login identifier. It should be an sfu.ca email 
  address, but not all users have SFU affiliations.
- **Full name**: We do not separate given names and family names in the 
  Symfony user management.
- **Affiliation**: For DHIL staff, this should be DHIL. For faculty members 
  and PIs, this should be their department's name (English, History, etc). 
  For non-DHIL student staff, this should be the name of the project.
- **Roles**: Each user has one or more roles. The roles determine what a 
  person can do in a project. The roles are defined below, although some 
  projects may define additional roles.
  
## User Roles
This is a non-exhaustive list of roles in a Symfony application. They can be 
combined to grant a user access to only the parts of the 
application required.

1. *ROLE_ADMIN*: Unlimited access. Can do anything. Only DHIL staff should 
   have this role.
2. *ROLE_USER_ADMIN*: Able to manage user access.
3. *ROLE_CONTENT_ADMIN*: Grants access to edit any of the normal database 
   content.
4. *ROLE_DC_ADMIN*: If the project uses Dublin Core, the user can add, 
   edit, and delete terms.
5. *ROLE_BLOG_ADMIN*: For applications with blogging enabled, this role 
   grants full access to blog content editing. 
6. *ROLE_COMMENT_ADMIN*: Users who will vet comments must have this role.

## Adding Users

The User menu item links to a page that displays the list of users for an 
application.

Use the "New" button above the table of users to add a new user. Be sure to 
make the account active and select only the roles necessary for the user.

![screenshots/symfony/user-list.png]({{ "assets/screenshots/symfony/user-list.png" | relative_url }})

**Important**: Only grant *ROLE_ADMIN* and *ROLE_USER* to DHIL staff. 

![screenshots/symfony/user-new.png]({{ "assets/screenshots/symfony/user-new.png" | relative_url }})

## Updating User Information

Email addresses in the User List are linked to the user account details. The 
details page will show all the user information and also the last login 
timestamp. Use the Edit button to change a user's details or the Password 
button to change the password associated with the account.

![screenshots/symfony/user-details.png]({{"assets/screenshots/symfony/user-details.png" | relative_url }})

*Changing a password for a user should be a last resort. Users should try to 
reset their account password from the login screen first.*

## Removing Users

The user details page described above also has a Delete button. Use it to 
permanently remove a user account. If the user account has any content 
associated with it, the deletion will fail. In this case, set the account to 
inactive instead of removing it. 

*If you really must delete a user account with content associated with it, 
you must change the content to be associated with a different user first.*

## From the command line

All actions available in the web interface are also available via the shell. Log
into the DHIL server or run the commands locally in a project folder. 

* Create a new account: `./bin/console nines:user:create`
* Activate an account: `./bin/console nines:user:activate`
* Deactivate an account: `./bin/console nines:user:deactivate`
* Grant a role: `./bin/console nines:user:promote`
* Remove a role: `./bin/console nines:user:demote`
* Send a password reset email: `./bin/console nines:user:reset`
* Change a password: `./bin/console nines:user:password`

All arguments to the commands are optional. The commands will ask for any 
missing information. Try adding `--help` to a command to determine the 
arguments.