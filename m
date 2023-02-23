Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DD76A1030
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 20:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjBWTLP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 14:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjBWTLM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 14:11:12 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF74C53EDF
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 11:10:45 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c12so11558880wrw.1
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 11:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=amjUgTYAx/u1lKfEtCZ9rPPfk76z53NvC+c6k/7gQs4=;
        b=tT1fIN/hcdPpFrjFxNHYZHXBdIEvFA33DXVkevY0tA97V/uC1S3qosuiDnwxKbGNDF
         wwzRsHNSY2Qq0gh9ayNajj5z5N9NpkjG6qfgXi9WAVRk51gfRNk6NrJ4+BrRTOlRVjsG
         GO/QHEOdaVi7Rlk8ajJrtDPdZ0bhQSD4AiQh5b0VT1CzATtNfvbUw0qW6g6aXM6bJO2k
         PMY4kbcY65TOEcxUn6DIBybyZEAqGJxZ3AhBzVpi16IOBZ6FxWKOTFfXfmLGeuSfdsPy
         s5P2++5nL6FLBSVnLphy60EJ+THKF/ApOB5ibLn36IS6e9i1DKayuG2ZaTynhF9zRJdm
         jL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amjUgTYAx/u1lKfEtCZ9rPPfk76z53NvC+c6k/7gQs4=;
        b=YjMkboYAGYfmT3QZ0R4k5StyohweVw8DPqBFjjcUba5kc4i8gz98NB9zb8R/9JjexZ
         Au9xfBW9AkfNAV1em6+Pf20DVWIM5UYKGJT9n3WotwPmkyC4SaSsWzpxAZSCrxHuJA9V
         BzYga371fsp6U4DGWENJ4q0bQlmRdOvgdfsUJdyBQ2Jj04Vv/9yKdFRXowzzObII5U32
         Upl7mKx0b0mK7eeNjr7pDo0wLFIKXxciKIG7FDHbFsT0LnqCRZ9BHY83kW2EUJeYOjcE
         0S8Lso3K3ANQVJMp+81fZ1VnTCVo6xWz/A/tnvALfC6EDt05qLvYBcy19i3Zq1Zm7tFn
         RGPQ==
X-Gm-Message-State: AO0yUKVxA+zJNsOVGXKj4EC8mg4DoN7G+u9Zg5aIIeHY+flhVxfu0owP
        CgmQ9u6iyIJj+DxoFp0OjWpJVA==
X-Google-Smtp-Source: AK7set8LWoBlVQt+nMBOXbSVrRNsU09V65+tTnU9dbRt1fYOFlZfDUWG0bvZ3oN0ODeFUN1NnKsH2A==
X-Received: by 2002:adf:f883:0:b0:2c7:3d5:9faa with SMTP id u3-20020adff883000000b002c703d59faamr8882234wrp.11.1677179444311;
        Thu, 23 Feb 2023 11:10:44 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a6f0:4ee9:c103:44cb])
        by smtp.gmail.com with ESMTPSA id k2-20020adff282000000b002c6e8cb612fsm9844481wro.92.2023.02.23.11.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:10:43 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     tj@kernel.org, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v11 0/8] Add latency priority for CFS class
Date:   Thu, 23 Feb 2023 20:10:33 +0100
Message-Id: <20230223191041.577305-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patchset restarts the work about adding a latency priority to describe
the latency tolerance of cfs tasks.

Patch [1] is a new one that has been added with v6. It fixes an
unfairness for low prio tasks because of wakeup_gran() being bigger
than the maximum vruntime credit that a waking task can keep after
sleeping.

The patches [2-4] have been done by Parth:
https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/

I have just rebased and moved the set of latency priority outside the
priority update. I have removed the reviewed tag because the patches
are 2 years old.

This aims to be a generic interface and the following patches is one use
of it to improve the scheduling latency of cfs tasks.

Patch [5] uses latency nice priority to define a latency offset
and then decide if a cfs task can or should preempt the current
running task. The patch gives some tests results with cyclictests and
hackbench to highlight the benefit of latency priority for short
interactive task or long intensive tasks.

Patch [6] adds the support of latency nice priority to task group by
adding a cpu.latency.nice field. The range is [-20:19] as for setting task
latency priority.

Patch [7] makes sched_core taking into account the latency offset.

Patch [8] adds a rb tree to cover some corner cases where the latency
sensitive task (priority < 0) is preempted by high priority task (RT/DL)
or fails to preempt them. This patch ensures that tasks will have at least
a slice of sched_min_granularity in priority at wakeup.

I have also backported the patchset on a dragonboard RB3 with an android
mainline kernel based on v5.18 for a quick test. I have used the
TouchLatency app which is part of AOSP and described to be a very good
test to highlight jitter and jank frame sources of a system [1].
In addition to the app, I have added some short running tasks waking-up
regularly (to use the 8 cpus for 4 ms every 37777us) to stress the system
without overloading it (and disabling EAS). The 1st results shows that the
patchset helps to reduce the missed deadline frames from 5% to less than
0.1% when the cpu.latency.nice of task group are set. I haven't rerun the
test with latest version.

I have also tested the patchset with the modified version of the alsa
latency test that has been shared by Tim. The test quickly xruns with
default latency nice priority 0 but is able to run without underuns with
a latency -20 and hackbench running simultaneously.

While preparing the version 8, I have evaluated the benefit of using an
augmented rbtree instead of adding a rbtree for latency sensitive entities,
which was a relevant suggestion done by PeterZ. Although the augmented
rbtree enables to sort additional information in the tree with a limited
overhead, it has more impact on legacy use cases (latency_nice >= 0)
because the augmented callbacks are always called to maintain this
additional information even when there is no sensitive tasks. In such
cases, the dedicated rbtree remains empty and the overhead is reduced to
loading a cached null node pointer. Nevertheless, we might want to
reconsider the augmented rbtree once the use of negative latency_nice will
be more widlely deployed. At now, the different tests that I have done,
have not shown improvements with augmented rbtree.

Below are some hackbench results (from v10):
        2 rbtrees               augmented rbtree        augmented rbtree	
                                sorted by vruntime      sorted by wakeup_vruntime
sched	pipe	
avg     26311,000               25976,667               25839,556
stdev   0,15 %                  0,28 %                  0,24 %
vs tip  0,50 %                  -0,78 %                 -1,31 %
hackbench	1 group	
avg     1,315                   1,344                   1,359
stdev   0,88 %                  1,55 %                  1,82 %
vs tip  -0,47 %                 -2,68 %                 -3,87 %
hackbench	4 groups
avg     1,339                   1,365                   1,367
stdev   2,39 %                  2,26 %                  3,58 %
vs tip  -0,08 %                 -2,01 %                 -2,22 %
hackbench	8 groups
avg     1,233                   1,286                   1,301
stdev   0,74 %                  1,09 %                  1,52 %
vs tip  0,29 %                  -4,05 %                 -5,27 %
hackbench	16 groups	
avg     1,268                   1,313                   1,319
stdev   0,85 %                  1,60 %                  0,68 %
vs tip  -0,02 %                 -3,56 %                 -4,01 %

[1] https://source.android.com/docs/core/debug/eval_perf#touchlatency

Change since v10:
- remove sched_latency_to_weight array and use a calc_latency_offset() instead
- save latency_prio instead for task group instead of latency offset
- enqueue back an entity when changing the latency nice prio fo a task group

Change since v9:
- Rebase
- add tags

Change since v8:
- Rename get_sched_latency by get_sleep_latency
- move latency nice defines in sched/prio.h and fix latency_prio init value
- Fix typo and comments

Change since v7:
- Replaced se->on_latency by using RB_CLEAR_NODE() and RB_EMPTY_NODE()
- Clarify the limit behavior fo the cgroup cpu.latenyc_nice

Change since v6:
- Fix compilation error for !CONFIG_SCHED_DEBUG

Change since v5:
- Add patch 1 to fix unfairness for low prio task. This has been
  discovered while studying Youssef's tests results with latency nice
  which were hitting the same problem.
- Fixed latency_offset computation to take into account
  GENTLE_FAIR_SLEEPERS. This has diseappeared with v2and has been raised
  by Youssef's tests.
- Reworked and optimized how latency_offset in used to check for
  preempting current task at wakeup and tick. This cover more cases too.
- Add patch 9 to remove check_preempt_from_others() which is not needed
  anymore with the rb tree.

Change since v4:
- Removed permission checks to set latency priority. This enables user
  without elevated privilege like audio application to set their latency
  priority as requested by Tim.
- Removed cpu.latency and replaced it by cpu.latency.nice so we keep a
  generic interface not tied to latency_offset which can be used to
  implement other latency features.
- Added an entry in Documentation/admin-guide/cgroup-v2.rst to describe
  cpu.latency.nice.
- Fix some typos.

Change since v3:
- Fix 2 compilation warnings raised by kernel test robot <lkp@intel.com>

Change since v2:
- Set a latency_offset field instead of saving a weight and computing it
  on the fly.
- Make latency_offset available for task group: cpu.latency
- Fix some corner cases to make latency sensitive tasks schedule first and
  add a rb tree for latency sensitive task.

Change since v1:
- fix typo
- move some codes in the right patch to make bisect happy
- simplify and fixed how the weight is computed
- added support of sched core patch 7

Parth Shah (3):
  sched: Introduce latency-nice as a per-task attribute
  sched/core: Propagate parent task's latency requirements to the child
    task
  sched: Allow sched_{get,set}attr to change latency_nice of the task

Vincent Guittot (5):
  sched/fair: fix unfairness at wakeup
  sched/fair: Take into account latency priority at wakeup
  sched/fair: Add sched group latency support
  sched/core: Support latency priority with sched core
  sched/fair: Add latency list

 Documentation/admin-guide/cgroup-v2.rst |  10 ++
 include/linux/sched.h                   |   4 +
 include/linux/sched/prio.h              |  27 +++
 include/uapi/linux/sched.h              |   4 +-
 include/uapi/linux/sched/types.h        |  19 ++
 init/init_task.c                        |   1 +
 kernel/sched/core.c                     |  65 +++++++
 kernel/sched/debug.c                    |   1 +
 kernel/sched/fair.c                     | 221 ++++++++++++++++++++----
 kernel/sched/sched.h                    |  50 +++++-
 tools/include/uapi/linux/sched.h        |   4 +-
 11 files changed, 370 insertions(+), 36 deletions(-)

-- 
2.34.1

