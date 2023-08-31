Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E167078F53D
	for <lists+cgroups@lfdr.de>; Fri,  1 Sep 2023 00:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245313AbjHaWC0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Aug 2023 18:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHaWCZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Aug 2023 18:02:25 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3271411B;
        Thu, 31 Aug 2023 15:02:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c0d0bf18d6so11039215ad.0;
        Thu, 31 Aug 2023 15:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693519341; x=1694124141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQOyDv9sjSzw+C3k8cWIKUlFmXgFOg/u8urYymdnFIg=;
        b=bxR1AAsGu/hk+dyUT059z5i0Pgz+9q+sS7WpTWc3Q6I7VnhDQU/pH97KgssRCY2z4b
         UfsS4y8ryzjEBVRfK33YY06ORPyYh9sEcHczmOfctfJWE/H19p4joPIIQjy37goBkWPY
         3HaGOGbqaLGJSrBOBaP0TQo3DKoV4VRFhdflxa9qcOaCHeNv9Ombzlz0OVFCeLiHae3j
         N+8ZxrXHWQ0hNHzq2EmXlrR5NFUSCIxT214nzjMVxQeft/QU6DnZALBlAfbSOTPFid8N
         mVEibLNuxdRGR6E6rj/nXxn+A/UEdqWajk5SHbirwUJyO+2zCmnPHWLpEBaS5khPMJ5L
         6Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693519341; x=1694124141;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mQOyDv9sjSzw+C3k8cWIKUlFmXgFOg/u8urYymdnFIg=;
        b=e5n/B2pOs1fbUEDqba/Tgidh8UI6wLtmGoPN0PVUmMRg14sDz5kQg81JREOx5Y2qxd
         8ADezVXWcyHOhqxh2x/OoK38qbWHD5h05peQHSio7VBdhiPa0d/egbjLxyYtZeSYsol9
         MjiYcqBIe/QVPd0hgyC7kUKGe6Kyb5psFR2OesJKBvOK+5teIdlYYuoHiQ/v6udR0Wp0
         M71+VVBHoKZQKEaRFrWJK7aL+Qy4QcIT1TKM5uWdOcBoWUvcoYt1F+Rm6GfP41x5MERf
         iuGqknN7nIf7wTlmKT2fUcpsBRb3i8XYbuxOXc9PR+Tlx2MKIKOYbD5d8wrW0idV1I4q
         zcPQ==
X-Gm-Message-State: AOJu0YyprqkqzV1yKrj1dVC4aCmBs6yX61yA3mHCJNyi/JllJ28c6wVr
        WDgpFnHW1MUcCZzI7SYsyXQ=
X-Google-Smtp-Source: AGHT+IEBpWSVggOTlbiTA0AsDo4SFWXf7lqY1VeF9BmVtEbY2tZCJtd+xMxSfoF+MbbSV8DIIwWgvw==
X-Received: by 2002:a17:903:1252:b0:1c1:ecff:a637 with SMTP id u18-20020a170903125200b001c1ecffa637mr1134123plh.15.1693519341383;
        Thu, 31 Aug 2023 15:02:21 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:eca7])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001b86e17ecacsm1683925plb.131.2023.08.31.15.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 15:02:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 31 Aug 2023 12:02:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [GIT PULL] cgroup: Changes for v6.6
Message-ID: <ZPEN6j8Zm6ZfpqxJ@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The following changes since commit 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c:

  Merge tag 'linux-watchdog-6.5-rc2' of git://www.linux-watchdog.org/linux-watchdog (2023-07-10 10:04:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.6

for you to fetch changes up to 78d44b824ed04dd1553c55c5b839c9a55cbcaf4e:

  cgroup: Avoid -Wstringop-overflow warnings (2023-08-17 11:55:05 -1000)

----------------------------------------------------------------
cgroup: Changes for v6.6

* Per-cpu cpu usage stats are now tracked. This currently isn't printed out
  in the cgroupfs interface and can only be accessed through e.g. BPF.
  Should decide on a not-too-ugly way to show per-cpu stats in cgroupfs.

* cpuset received some cleanups and prepatory patches for the pending
  cpus.exclusive patchset which will allow cpuset partitions to be created
  below non-partition parents, which should ease the management of partition
  cpusets.

* A lot of code and documentation cleanup patches.

* tools/testing/selftests/cgroup/test_cpuset.c is added. This causes trivial
  conflicts in .gitignore and Makefile under the directory against
  fe3b1bf19bdf ("selftests: cgroup: add test_zswap program"). They can be
  resolved by keeping lines from both branches.

----------------------------------------------------------------
Cai Xinchen (1):
      cgroup/cpuset: fix kernel-doc

Gustavo A. R. Silva (1):
      cgroup: Avoid -Wstringop-overflow warnings

Haitao Huang (2):
      cgroup/misc: Change counters to be explicit 64bit types
      cgroup/misc: Store atomic64_t reads to u64

Han Dapeng (1):
      Documentation: cgroup-v2.rst: Correct number of stats entries

Hao Jia (1):
      cgroup/rstat: Record the cumulative per-cpu time of cgroup and its descendants

Kamalesh Babulal (3):
      cgroup: remove cgrp->kn check in css_populate_dir()
      cgroup/misc: update struct members descriptions
      cgroup: clean up printk()

Lu Jialin (1):
      cgroup:namespace: Remove unused cgroup_namespaces_init()

Miaohe Lin (13):
      cgroup: remove unneeded return value of cgroup_rm_cftypes_locked()
      cgroup: minor cleanup for cgroup_extra_stat_show()
      cgroup/cpuset: simplify the percpu kthreads check in update_tasks_cpumask()
      cgroup/cpuset: avoid unneeded cpuset_mutex re-lock
      cgroup: fix obsolete comment above for_each_css()
      cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED
      cgroup: remove obsolete comment above struct cgroupstats
      cgroup: use cached local variable parent in for loop
      cgroup: fix obsolete function name
      cgroup: fix obsolete comment above cgroup_create()
      cgroup: fix obsolete function name above css_free_rwork_fn()
      cgroup: fix obsolete function name in cgroup_destroy_locked()
      cgroup: clean up if condition in cgroup_pidlist_start()

Michal Koutný (3):
      cpuset: Allow setscheduler regardless of manipulated task
      selftests: cgroup: Minor code reorganizations
      selftests: cgroup: Add cpuset migrations testcase

Waiman Long (4):
      cgroup/cpuset: Inherit parent's load balance state in v2
      cgroup/cpuset: Extract out CS_CPU_EXCLUSIVE & CS_SCHED_LOAD_BALANCE handling
      cgroup/cpuset: Improve temporary cpumasks handling
      cgroup/cpuset: Allow suppression of sched domain rebuild in update_cpumasks_hier()

Xiongwei Song (2):
      docs: cgroup-v1: correct the term of Page Cache organization in inode
      docs: cgroup-v1: fix typo

 Documentation/admin-guide/cgroup-v1/memory.rst    |   6 +-
 Documentation/admin-guide/cgroup-v2.rst           |   2 +-
 MAINTAINERS                                       |   2 +
 include/linux/cgroup-defs.h                       |  14 ++
 include/linux/misc_cgroup.h                       |  28 +--
 include/uapi/linux/cgroupstats.h                  |   2 -
 kernel/cgroup/cgroup-v1.c                         |   2 +-
 kernel/cgroup/cgroup.c                            |  85 ++++---
 kernel/cgroup/cpuset.c                            | 264 +++++++++++++--------
 kernel/cgroup/misc.c                              |  55 +++--
 kernel/cgroup/namespace.c                         |   6 -
 kernel/cgroup/rstat.c                             |  12 +-
 tools/testing/selftests/cgroup/.gitignore         |   1 +
 tools/testing/selftests/cgroup/Makefile           |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c      |   2 +
 tools/testing/selftests/cgroup/cgroup_util.h      |   2 +
 tools/testing/selftests/cgroup/test_core.c        |   2 +-
 tools/testing/selftests/cgroup/test_cpuset.c      | 275 ++++++++++++++++++++++
 tools/testing/selftests/cgroup/test_cpuset_prs.sh |   2 +-
 19 files changed, 560 insertions(+), 204 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/test_cpuset.c

-- 
tejun
