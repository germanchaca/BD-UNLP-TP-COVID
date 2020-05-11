Friendster social network data set -- Friends lists (June/July 2011)
====================================================================

Before its relaunch as a gaming website, Friendster was a social networking
website that allowed users to connect with their friends. The central element
of the site was the 'friends list', showing the contacts of the user.

This dataset contains the connections between all Friendster users. It is the
result of an extensive crawl of Friendster.com at the end of June 2011. It
was performed as part of the ArchiveTeam project to archive part of the
Friendster data before the service relaunched.

The data files list, for each user id, the user ids of the users that were
listed on the friends page of that user. These connections have a direction:
if user A lists user B as a friend, that does not imply that the friends list
of user B also includes user A.

Some of the users had elected to keep their friends list private. It is
possible, however, that these users appear in the friends lists of others.


Statistics
----------

The dataset contains the friends lists of 103,750,348 users. The friends
lists of an additional 14,001,031 users had been marked private. In total,
the dataset contains 2,586,147,869 friend connections.

In graph terms: the graph contains 117,751,379 nodes and 2,586,147,869
directed edges.


Files in this dataset
---------------------

The dataset consists of 125 compressed text files, each containing the data
of 1,000,000 users. The filename indicates the prefix of the user ids in the
file. For example, file  friends-031______.txt  provides the friends lists
of the users with user ids 31,000,000 to 31,999,999.


File format
-----------

Each line of the data files represents the friends list of one user, in the
following format:

  <user id of user> : <comma separated list of user's friends>

e.g.,  1:2,3        indicates that user 1 lists users 2 and 3 as friends.

If the friends list for a user was private, this is indicated as follows:

  <user id of user> : private

e.g.,  4:private

Similarly, user ids that did not map to a valid user are marked with notfound:

  <user id of user> : notfound

e.g.,  5:notfound

The user ids used here correspond with the user ids in the group membership
data file.

