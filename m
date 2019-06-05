Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9450035E07
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2019 15:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfFENiK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jun 2019 09:38:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40760 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfFENiI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jun 2019 09:38:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55DTE9P140115;
        Wed, 5 Jun 2019 13:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=O2H9FHpacckXJeybu+bDqRWdNDOTIIP45Q/vObEtGBI=;
 b=xhwaLPVQZ0J2XOCl8MdNFxiqeNH9uA4oK6sUyCdHUEnNYIhLBtV2RzOwxedGiB9SuRqs
 EQ++3adtXv+G+xpJyjFXrZpWxWv3w1/3Ab1VRx9PFI6nztzaJNAp9BWT/qUX8+VqzSwu
 F0+rW5iqFcmD+CzjgzdcROPC7Yh7F9uKIlJ/ipFPJ1YywCpnl6HuyDekl5oF5nSULm9E
 l33KtewnHrBZwGHPkRWzgZ+yrHiDO41f8X2sYzk/jN2oQIePv64i04+sQtLYT8lv/Rth
 5Oijbc1qZHqyjES0RNf9AwEpMRW0svvrgqnRSYvzhaNJ1gtSCIGf4Hljb8wGVVnr4Prv 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2suevdjvbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 13:37:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55Dae0F034062;
        Wed, 5 Jun 2019 13:37:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2swnhc4y3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 13:37:08 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x55Dawho022826;
        Wed, 5 Jun 2019 13:37:02 GMT
Received: from localhost.localdomain (/73.60.114.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Jun 2019 06:36:58 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     hannes@cmpxchg.org, jiangshanlai@gmail.com, lizefan@huawei.com,
        tj@kernel.org
Cc:     bsd@redhat.com, dan.j.williams@intel.com,
        daniel.m.jordan@oracle.com, dave.hansen@intel.com,
        juri.lelli@redhat.com, mhocko@kernel.org, peterz@infradead.org,
        steven.sistare@oracle.com, tglx@linutronix.de,
        tom.hromatka@oracle.com, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC v2 0/5] cgroup-aware unbound workqueues
Date:   Wed,  5 Jun 2019 09:36:45 -0400
Message-Id: <20190605133650.28545-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050087
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

This series adds cgroup awareness to unbound workqueues.

This is the second version since Bandan Das's post from a few years ago[1].
The design is completely new, but the code is still in development and I'm
posting early to get feedback on the design.  Is this a good direction?

Thanks,
Daniel


Summary
-------

Cgroup controllers don't throttle workqueue workers for the most part, so
resource-intensive works run unchecked.  Fix it by adding a new type of work
that causes the assigned worker to attach to the given cgroup.

Motivation
----------

Workqueue workers are currently always attached to root cgroups.  If a task in
a child cgroup queues a resource-intensive work, the resource limits of the
child cgroup generally don't throttle the worker, with some exceptions such as
writeback.

My use case for this work is kernel multithreading, the series formerly known
as ktask[2] that I'm now trying to combine with padata according to feedback
from the last post.  Helper threads in a multithreaded job may consume lots of
resources that aren't properly accounted to the cgroup of the task that started
the job.

Basic Idea
----------

I know of two basic ways to fix this, with other ideas welcome.  They both use
the existing cgroup migration path to move workers to different cgroups.

  #1  Maintain per-cgroup worker pools and queue works on these pools.  A
      worker in the pool is migrated once to the pool's assigned cgroup when
      the worker is first created.

These days, users can have hundreds or thousands of cgroups on their systems,
which means that #1 could cause as many workers to be created across the pools,
bringing back the problems of MT workqueues.[3]  The concurrency level could be
managed across the pools, but I don't see how to avoid thrashing on worker
creation and destruction with even demand for workers across cgroups.  So #1
doesn't seem like the right way forward.

  #2  Migrate a worker to the desired cgroup before it runs the work.
      Worker pools are shared across cgroups, and workers migrate to
      different cgroups as needed.

#2 has some issues of its own, namely cgroup_mutex and
cgroup_threadgroup_rwsem.  These prevent concurrent worker migrations, so for
this to work scalably, these locks should be fixed.  css_set_lock and
controller-specific locks may then also be a problem.  Nevertheless, #2 keeps
the total number of workers low to accommodate systems with many cgroups.

This RFC implements #2.  If the design looks good, I can start working on
fixing the locks, and I'd be thrilled if others wanted to help with this.


A third alternative arose late in the development of this series that takes
inspiration from proxy execution, in which a task's scheduling context and
execution context are treated separately[4].  The idea is to allow a proxy task
to temporarily assume the cgroup characteristics of another task so that it can
use the other task's cgroup-related task_struct fields.  The worker avoids the
performance and scalability cost of the migration path, but it also doesn't run
the attach callbacks, so controllers wouldn't work as designed without adding
special logic in various places to account for this situation.  That doesn't
sound immediately appealing, but I haven't thought about it for very long.

Data Structures
---------------

Cgroup awareness is implemented per work with a new type of work item:

        struct cgroup_work {
                struct work_struct work;
        #ifdef CONFIG_CGROUPS
                struct cgroup *cgroup;
        #endif
        };

The cgroup field contains the cgroup to which the assigned worker should
attach.  A new type is used so only those users who want cgroup awareness incur
the space overhead of the cgroup pointer.  This feature is supported only for
cgroups on the default hierarchy, so one cgroup pointer is sufficient.  

Workqueues may be created with the WQ_CGROUP flag.  The flag means that cgroup
works, and only cgroup works, may be queued on this workqueue.  Cgroup works
aren't allowed to be queued on !WQ_CGROUP workqueues.

This separation avoids the issues that come from cgroup_works and regular works
being queued together, such as distinguishing between the two on a worklist,
which probably means adding a new work data bit causing increased memory usage
from higher pool_workqueue alignment, or creating multiple worklists and
dealing fairly with, "which worklist do I pick from next?"

Migrating Kernel Threads
------------------------

Migrated worker pids appear in cgroup.procs and cgroup.threads, and they block
cgroup destruction (cgroup_rmdir) just as user tasks do.  To alleviate this
somewhat, workers that have finished their work migrate themselves back to the
root cgroup before sleeping.

In addition, it's probably best to allow userland to destroy a cgroup when only
kernel threads remain (no user tasks left), with destruction finishing in the
background once all kernel threads have been migrated out.  The reason is, it's
consistent with current cgroup behavior in which management apps, libraries,
etc may expect destruction to succeed when all known tasks have been moved out.
So that's tentatively on my TODO, but I'm curious what people think.

It's possible for task migration to fail for several reasons.  On failure, the
worker tries migrating itself to the root cgroup.  In case _this_ fails, the
code currently throws a warning, but it seems best to design this so that
migrating a kernel thread to the root can't fail.  Otherwise, with both
failures, we account work to an unrelated, random cgroup.

Priority Inversion
------------------

One concern with cgroup-aware workers may be priority inversion[5].  I couldn't
find where this was discussed in detail, but it seems the issue is that a
worker could be throttled by some resource limit from its attached cgroup,
causing other work items' execution to be delayed a long time.

However, this doesn't seem to be a problem because of how worker pools are
managed.  There's an invariant that at least one idle worker should exist in a
pool before a worker begins processing works, so that there will be at least
one worker per work item, avoiding the inversion.

It's possible that works from a large number of different resource-constrained
cgroups could cause as many workers to be created, with creation eventually
failing due for example to pid exhaustion, but in that extreme case workqueue
will retry repeatedly with a CREATE_COOLDOWN timeout.  This seems good enough,
but I'm open to other ideas.

Testing
-------

A little, not a lot.  I've sanity-checked that some controllers throttle
workers as expected (memory, cpu, pids), "believe" rdma should work, haven't
looked at io yet, and know cpuset is broken.  For cpuset, I need to fix
->can_attach() for bound kthreads and reconcile the controller's cpumasks with
worker cpumasks.

In one experiment on a large Xeon server, a kernel thread was migrated 2M times
back and forth between two cgroups.  The mean time per migration was 1 usec, so
cgroup-aware work items should take much longer than that for the migration to
be worth it.

TODO
----

 - scale cgroup_mutex and cgroup_threadcgroup_rwsem
 - support the cpuset controller, and reconcile that with workqueue NUMA
   awareness and worker_pool cpumasks
 - support the io controller
 - make kernel thread migration to the root cgroup always succeed
 - maybe allow userland to destroy a cgroup with only kernel threads

Dependencies
------------

This series is against 5.1 plus some kernel multithreading patches (formerly
ktask).  A branch with everything is available at

    git://oss.oracle.com/git/linux-dmjordan.git cauwq-rfc-v2

The multithreading patches don't incorporate some of the feedback from the last
post[2] (yet) because I'm in the process of addressing the larger design
comments.

[1] http://lkml.kernel.org/r/1458339291-4093-1-git-send-email-bsd@redhat.com
[2] https://lore.kernel.org/linux-mm/20181105165558.11698-1-daniel.m.jordan@oracle.com/
[3] https://lore.kernel.org/lkml/4C17C598.7070303@kernel.org/
[4] https://lore.kernel.org/lkml/20181009092434.26221-1-juri.lelli@redhat.com/
[5] https://lore.kernel.org/netdev/4BFE9ABA.6030907@kernel.org/

Daniel Jordan (5):
  cgroup: add cgroup v2 interfaces to migrate kernel threads
  workqueue, cgroup: add cgroup-aware workqueues
  workqueue, memcontrol: make memcg throttle workqueue workers
  workqueue, cgroup: add test module
  ktask, cgroup: attach helper threads to the master thread's cgroup

 include/linux/cgroup.h                        |  43 +++
 include/linux/workqueue.h                     |  85 +++++
 kernel/cgroup/cgroup-internal.h               |   1 -
 kernel/cgroup/cgroup.c                        |  48 ++-
 kernel/ktask.c                                |  32 +-
 kernel/workqueue.c                            | 263 +++++++++++++-
 kernel/workqueue_internal.h                   |  50 +++
 lib/Kconfig.debug                             |  12 +
 lib/Makefile                                  |   1 +
 lib/test_cgroup_workqueue.c                   | 325 ++++++++++++++++++
 mm/memcontrol.c                               |  26 +-
 .../selftests/cgroup_workqueue/Makefile       |   9 +
 .../testing/selftests/cgroup_workqueue/config |   1 +
 .../cgroup_workqueue/test_cgroup_workqueue.sh | 104 ++++++
 14 files changed, 963 insertions(+), 37 deletions(-)
 create mode 100644 lib/test_cgroup_workqueue.c
 create mode 100644 tools/testing/selftests/cgroup_workqueue/Makefile
 create mode 100644 tools/testing/selftests/cgroup_workqueue/config
 create mode 100755 tools/testing/selftests/cgroup_workqueue/test_cgroup_workqueue.sh


base-commit: e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd
prerequisite-patch-id: 253830d9ec7ed8f9d10127c1bc61f2489c40f042
prerequisite-patch-id: 0fa4fe0d879ae76f8e16d15982d799d84f67bee3
prerequisite-patch-id: e2e8229b9d1a1efa75262910a597902e136a6214
prerequisite-patch-id: f67900739fe811de1d4d06e19a5aa180b46396d8
prerequisite-patch-id: 7349e563091d065d4ace565f3daca139d7d470ad
prerequisite-patch-id: 6cd37c09bb0902519d574080b5c56d61755935fe
prerequisite-patch-id: a07d6676fbb5ed07486a3160e6eced91ecef1842
prerequisite-patch-id: 17baa0481806fc48dcb32caffb973120ac599c8d
prerequisite-patch-id: 6e629bbeb6efdd69aa733731bc91690346f26f21
prerequisite-patch-id: 59630f99305aa371e024b652e754d67614481c29
prerequisite-patch-id: 46c713fed894a530e9a0a83ca2a7c1ae2c787a5f
prerequisite-patch-id: 4b233711a8bdd1ef9fa82e364f07595526036ff4
prerequisite-patch-id: 9caefc8d5d48d6ec42bad4336fa38a28118296da
prerequisite-patch-id: 04d008e4ffbe499ebc5b466b7777dabff9a6c77e
prerequisite-patch-id: 396a88dad48473d4b54f539fadeb7d601020098d
-- 
2.21.0

