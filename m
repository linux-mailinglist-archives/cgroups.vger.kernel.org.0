Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06FB31091A0
	for <lists+cgroups@lfdr.de>; Mon, 25 Nov 2019 17:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfKYQLr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Nov 2019 11:11:47 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41507 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbfKYQLq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Nov 2019 11:11:46 -0500
Received: by mail-qt1-f195.google.com with SMTP id 59so12235950qtg.8;
        Mon, 25 Nov 2019 08:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=PsI4yZtUmbMwiHynlpswlFtIawc/jhnogyFzjtBl7eU=;
        b=YiccQRIt/381JV3wKlX3qKTo/qvot6ogYibsfv73ierej9fCq6YCsy5c9orqQhVVRP
         4S1XADPjHaOddI9LGQ90lqf5MD3L7iW0OpHHffbi+2q68ebCBgXisqN9JBvKxdk6cju9
         T56M1ith/oVge9bsLR4OKhM5N3arTcVOVIaBirHLFbWtR39HcTYiJncGp6BS4vJVWjTk
         NNJlKTq2Q1X5Iz8zf/R4WXs2dyVMgaKHAeEB4pOf47BByhM2q5dSevua7cSDS2yWDaFy
         dZ6RENtiwPndYnavbh+cBygZIyEwtPZeeraBssBVWszRz30+c/7cFQF/E6gnTZ6TuaWP
         oPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=PsI4yZtUmbMwiHynlpswlFtIawc/jhnogyFzjtBl7eU=;
        b=ZaI+8TmP3gn00Y8f57l/32v+HdBoktFQvETkbvWK+kOy5PM91kqJZUxgHVWeOTuT4A
         J+mhlIPmzxQSSYJi/MFuor3HRoY8j6Ihm7EeaX+WGVTIKeB2nDyTPaIEaIQk2sp5qYKP
         O4nv/rvzUswgo1Wio3jnA2NyyHNYaB3uy4GVHhU6jG/em5UFBIid14avbabqOs/XJTYc
         JEtS2ZRAbK+UNjOp515xrOFyTX/Sp1OFHHUlci4HwMUDV+9DFvg4aIUcjLIsaGwzLhtI
         VkMFv5ICS4HADErXCDg2QN8n28yZ262Uozz3839oUfjIiTYkDkG75fbEdiGAqbnCNa/w
         aIyg==
X-Gm-Message-State: APjAAAW0ySUhzOM08JTPrKLaUJ2wNNngS6381TX7Kj0YOxY81Y8hSpKr
        Ujib0FW7Y3afLZnRYGOriZw=
X-Google-Smtp-Source: APXvYqzc5+rMGpatEtjwOueIYyyg3OWDhFGQsiFZiy/JECfvlfQl6TNlBcl6pHn9mUB/jf4bs01UWQ==
X-Received: by 2002:ac8:73ce:: with SMTP id v14mr29680412qtp.136.1574698303940;
        Mon, 25 Nov 2019 08:11:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:2f2e])
        by smtp.gmail.com with ESMTPSA id u7sm3571504qkm.127.2019.11.25.08.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 08:11:43 -0800 (PST)
Date:   Mon, 25 Nov 2019 08:11:41 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v5.5-rc1
Message-ID: <20191125161141.GC2867037@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

There are several notable changes in this pull request.

* Single thread migrating itself has been optimized so that it doesn't
  need threadgroup rwsem anymore.

* Freezer optimization to avoid unnecessary frozen state changes.

* cgroup ID unification so that cgroup fs ino is the only unique ID
  used for the cgroup and can be used to directly look up live cgroups
  through filehandle interface on 64bit ino archs.  On 32bit archs,
  cgroup fs ino is still the only ID in use but it is only unique when
  combined with gen.

* selftest and other changes.

Thanks.

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.5

for you to fetch changes up to 40363cf13999ee4fb3b5c1e67fa5e6f0e9da34bd:

  writeback: fix -Wformat compilation warnings (2019-11-25 07:50:41 -0800)

----------------------------------------------------------------
Aleksa Sarai (1):
      cgroup: pids: use atomic64_t for pids->limit

Chris Down (1):
      docs: cgroup: mm: Fix spelling of "list"

Hewenliang (1):
      kselftests: cgroup: Avoid the reuse of fd after it is deallocated

Honglei Wang (1):
      cgroup: freezer: don't change task and cgroups status unnecessarily

Miaohe Lin (1):
      cgroup: short-circuit current_cgns_cgroup_from_root() on the default hierarchy

Michal Koutný (5):
      cgroup: Update comments about task exit path
      cgroup: Optimize single thread migration
      selftests: cgroup: Simplify task self migration
      selftests: cgroup: Add task migration tests
      selftests: cgroup: Run test_core under interfering stress

Qian Cai (1):
      writeback: fix -Wformat compilation warnings

Tejun Heo (13):
      cgroup: remove cgroup_enable_task_cg_lists() optimization
      cgroup: use cgroup->last_bstat instead of cgroup->bstat_pending for consistency
      kernfs: fix ino wrap-around detection
      writeback: use ino_t for inodes in tracepoints
      netprio: use css ID instead of cgroup ID
      kernfs: use dumber locking for kernfs_find_and_get_node_by_ino()
      kernfs: kernfs_find_and_get_node_by_ino() should only look up activated nodes
      kernfs: convert kernfs_node->id from union kernfs_node_id to u64
      kernfs: combine ino/id lookup functions into kernfs_find_and_get_node_by_id()
      kernfs: implement custom exportfs ops and fid type
      kernfs: use 64bit inos if ino_t is 64bit
      cgroup: use cgrp->kn->id as the cgroup ID
      cgroup: fix incorrect WARN_ON_ONCE() in cgroup_setup_root()

 Documentation/admin-guide/cgroup-v2.rst       |   2 +-
 fs/kernfs/dir.c                               | 101 ++++----
 fs/kernfs/file.c                              |   4 +-
 fs/kernfs/inode.c                             |   4 +-
 fs/kernfs/kernfs-internal.h                   |   2 -
 fs/kernfs/mount.c                             | 102 ++++----
 include/linux/cgroup-defs.h                   |  19 +-
 include/linux/cgroup.h                        |  27 +--
 include/linux/exportfs.h                      |   5 +
 include/linux/kernfs.h                        |  57 +++--
 include/net/netprio_cgroup.h                  |   2 +-
 include/trace/events/cgroup.h                 |   6 +-
 include/trace/events/writeback.h              | 140 +++++------
 kernel/bpf/helpers.c                          |   2 +-
 kernel/bpf/local_storage.c                    |   2 +-
 kernel/cgroup/cgroup-internal.h               |   5 +-
 kernel/cgroup/cgroup-v1.c                     |   5 +-
 kernel/cgroup/cgroup.c                        | 325 ++++++++------------------
 kernel/cgroup/cpuset.c                        |   2 -
 kernel/cgroup/freezer.c                       |   9 +
 kernel/cgroup/pids.c                          |  11 +-
 kernel/cgroup/rstat.c                         |  46 ++--
 kernel/trace/blktrace.c                       |  84 ++++---
 net/core/filter.c                             |   4 +-
 net/core/netprio_cgroup.c                     |   8 +-
 tools/testing/selftests/cgroup/Makefile       |   4 +-
 tools/testing/selftests/cgroup/cgroup_util.c  |  42 +++-
 tools/testing/selftests/cgroup/cgroup_util.h  |   6 +-
 tools/testing/selftests/cgroup/test_core.c    | 146 ++++++++++++
 tools/testing/selftests/cgroup/test_freezer.c |   3 +-
 tools/testing/selftests/cgroup/test_stress.sh |   4 +
 tools/testing/selftests/cgroup/with_stress.sh | 101 ++++++++
 32 files changed, 746 insertions(+), 534 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_stress.sh
 create mode 100755 tools/testing/selftests/cgroup/with_stress.sh

-- 
tejun
