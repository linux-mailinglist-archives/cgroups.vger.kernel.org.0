Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40E05F3560
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 20:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJCSNI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 14:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJCSNG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 14:13:06 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CB32B24A;
        Mon,  3 Oct 2022 11:13:04 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id a23so2628006pgi.10;
        Mon, 03 Oct 2022 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=qjD9B+YikJdVf0d+9gXelGzE4y1SLS+IR2Z0Xi8fWPo=;
        b=W59UzeWn26yGfJLSBgtmt8RimoEmAFLHyFmzVkIyrM51hr+Mvpv7VoqY+tWFxKBOYK
         SHvkg6AlojI/BY0baSBe1hCEEAY62BhmBkdP30qFBWBtn3OVEHT+1JTixzGwxBfJVDoL
         uUSqaJMSrjF+7l+quNr1qgRpLlZTdaDHcFR4211hDIFuF4CYIp9Pj7gGoW3X1dGTBV2s
         Bo5BqRlCOj+Nn3qudj59ME1tt/QG9XdHFzfy3zUelAC5dqaO7JOLNIoufDj4uuDL7PWB
         wLiv9wXV4w734dz1kFxg3X9jfpSX41/0ncugwAd3hm/oTqXv9zAQOQOqHzZmtZRofwZh
         m5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=qjD9B+YikJdVf0d+9gXelGzE4y1SLS+IR2Z0Xi8fWPo=;
        b=lY//m0xq/H6skJAKaSKc18FqHv6UROobDMHiqT1DTqzPXXNoX+qlkuVTgclbHpQFoS
         Tv+CxAQJaCNZHJLXgLsiFApb9plV9fldrd/FHjawrQmgY/PYNiwTnw1AbAurpHN7qldK
         eh5DrljCZzywjHWttHz42z25jrMVxj2j4zQ0yWh8a1UlWkld/8qYQ30ISFyuraimChfE
         UHJARrJ4w/h+YAO7uZvJjdKRgclMC0jyuOHhFq8QfvEUA3pND9RdBrF5EZ4+kmj80m3W
         ENwx/OowjMnKEr2chMQ9IrNZ2BQe5VOVPNK4iGPx36OG9bmVHPtaPSClvwQgkhJA7Xnr
         lGGw==
X-Gm-Message-State: ACrzQf04sQ+JGjfTKi2FMRSwEbP4IiVcvh//IdmlRZUhw6eiSCY1WGpM
        VHMAGYmllyK7uhEtMjG68XQ=
X-Google-Smtp-Source: AMsMyM5OiZ3wzoHirEQ1aaQ8oKwirMXIByMzjtoLFTnWFSF/haPW/vJeh6XLxEkPlNenuymtqCu1qg==
X-Received: by 2002:a05:6a00:1898:b0:561:1990:63c0 with SMTP id x24-20020a056a00189800b00561199063c0mr8261843pfh.49.1664820784296;
        Mon, 03 Oct 2022 11:13:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:cb45])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902f15100b0017b224969d6sm7451905plb.76.2022.10.03.11.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:13:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 3 Oct 2022 08:13:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [GIT PULL] cgroup changes for v6.1-rc1
Message-ID: <YzsmLRxPvYQlwtZo@slm.duckdns.org>
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

The following changes since commit df02452f3df069a59bc9e69c84435bf115cb6e37:

  cgroup: cgroup_get_from_id() must check the looked-up kn is a directory (2022-09-23 07:18:45 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.1

for you to fetch changes up to 8619e94d3be376bb5e8f20988c0e6e3309d2b09a:

  cgroup: use strscpy() is more robust and safer (2022-09-23 17:27:02 -1000)

----------------------------------------------------------------
cgroup changes for v6.1-rc1.

* cpuset now support isolated cpus.partition type, which will enable dynamic
  CPU isolation.
* pids.peak added to remember the max number of pids used.
* Holes in cgroup namespace plugged.
* Internal cleanups.

Note that for-6.1-fixes was pulled into for-6.1 twice. Both were for
follow-up cleanups and each merge commit has details.

Also, 8a693f7766f9 ("cgroup: Remove CFTYPE_PRESSURE") removes the flag used
by PSI changes in the tip tree and the merged result won't compile due to
the missing flag. Simply removing the struct init lines specifying the flag
is the correct resolution. linux-next already contains the correct fix:

 https://lkml.kernel.org/r/20220912161812.072aaa3b@canb.auug.org.au

----------------------------------------------------------------
Elijah Conners (1):
      iocost_monitor: reorder BlkgIterator

Jiapeng Chong (1):
      cgroup/cpuset: remove unreachable code

Josh Don (1):
      cgroup: add pids.peak interface for pids controller

Michal Koutný (3):
      cgroup: Honor caller's cgroup NS when resolving path
      cgroup: cgroup: Honor caller's cgroup NS when resolving cgroup id
      cgroup: Homogenize cgroup_get_from_id() return value

Tejun Heo (8):
      cgroup: Replace cgroup->ancestor_ids[] with ->ancestors[]
      Merge branch 'for-6.0-fixes' into for-6.1
      cgroup: Fix build failure when CONFIG_SHRINKER_DEBUG
      cgroup: Remove data-race around cgrp_dfl_visible
      cgroup: Improve cftype add/rm error handling
      cgroup: Remove CFTYPE_PRESSURE
      Merge branch 'for-6.0-fixes' into for-6.1
      cgroup: Make cgroup_get_from_id() prettier

Tetsuo Handa (1):
      cgroup: Use cgroup_attach_{lock,unlock}() from cgroup_attach_task_all()

Waiman Long (10):
      cgroup/cpuset: Enable update_tasks_cpumask() on top_cpuset
      cgroup/cpuset: Miscellaneous cleanups & add helper functions
      cgroup/cpuset: Allow no-task partition to have empty cpuset.cpus.effective
      cgroup/cpuset: Relax constraints to partition & cpus changes
      cgroup/cpuset: Add a new isolated cpus.partition type
      cgroup/cpuset: Show invalid partition reason string
      cgroup/cpuset: Relocate a code block in validate_change()
      cgroup/cpuset: Make partition invalid if cpumask change violates exclusivity rule
      cgroup/cpuset: Update description of cpuset.cpus.partition in cgroup-v2.rst
      kselftest/cgroup: Add cpuset v2 partition root state test

William Dean (1):
      cgroup: simplify code in cgroup_apply_control

ye xingchen (1):
      cgroup: use strscpy() is more robust and safer

 Documentation/admin-guide/cgroup-v2.rst           | 156 +++--
 block/blk-cgroup-fc-appid.c                       |   4 +-
 include/linux/cgroup-defs.h                       |  18 +-
 include/linux/cgroup.h                            |  13 +-
 kernel/cgroup/cgroup-internal.h                   |   2 +
 kernel/cgroup/cgroup-v1.c                         |   6 +-
 kernel/cgroup/cgroup.c                            | 145 ++--
 kernel/cgroup/cpuset.c                            | 815 ++++++++++++++--------
 kernel/cgroup/pids.c                              |  37 +-
 mm/memcontrol.c                                   |   4 +-
 net/netfilter/nft_socket.c                        |   9 +-
 tools/cgroup/iocost_monitor.py                    |  10 +-
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c       |   2 +-
 tools/testing/selftests/cgroup/.gitignore         |   1 +
 tools/testing/selftests/cgroup/Makefile           |   5 +-
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 674 ++++++++++++++++++
 tools/testing/selftests/cgroup/wait_inotify.c     |  87 +++
 17 files changed, 1544 insertions(+), 444 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_prs.sh
 create mode 100644 tools/testing/selftests/cgroup/wait_inotify.c

-- 
tejun
