Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F27735C0A
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2019 13:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfFELtu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jun 2019 07:49:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37790 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfFELtq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jun 2019 07:49:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id 22so1957371wmg.2
        for <cgroups@vger.kernel.org>; Wed, 05 Jun 2019 04:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Ue7OXtzKu1Kff0kNekLMtjlDJwlS2dW920UpK4s3Ms=;
        b=s/7gV0XlSrg1gG1v9EpPJB1CHgyp7C1EPgCBwDOQdH5Ank4yYZu8ulpcnLy7RjTm/H
         Nq2RaCQYXE9m/vyFPZv52v8RZP3uVR8fBuXDPk0CFrOY7eCnmvuq5yNeDUWvzDjiyvCG
         1kKhaU8a2T5Z1jcsMMzgPs3OwRRUDLaMwsj8gG+bfgFFGBObDDuwuk4IWv83+yfvmzqp
         wGEjIUZiURHdjYmnLuMOIkMhJYfqAthnnC7/Wm+OZ9AJJoY5/O0p99jrZWZTVWGjFucD
         7e5BICHaH+4xz8jgzGARzcIg7f6cMh/7cTObVd9MZoEVfQuJv7gdSBozaMHcH1YaMSgg
         ShLw==
X-Gm-Message-State: APjAAAWVT1eUcIrp8D7+HN0nO+IJZvXUjPN4s9ck4DXDaw73nJW6Jvf9
        OsSOMGVqYdvPaWCHQ+mg38S3Zw==
X-Google-Smtp-Source: APXvYqzzwHQb34R7sFsjS5HGKPSwoEyCFLR1Wtv5JbBmSIVcnS1uLVQYiBHhDTy1DFXU4jHyMwncXA==
X-Received: by 2002:a1c:99ca:: with SMTP id b193mr8387665wme.31.1559735384686;
        Wed, 05 Jun 2019 04:49:44 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id h17sm17236079wrq.79.2019.06.05.04.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 04:49:44 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, bristot@redhat.com, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] sched/core: Fix cpu controller for !RT_GROUP_SCHED
Date:   Wed,  5 Jun 2019 13:49:35 +0200
Message-Id: <20190605114935.7683-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On !CONFIG_RT_GROUP_SCHED configurations it is currently not possible to
move RT tasks between cgroups to which cpu controller has been attached;
but it is oddly possible to first move tasks around and then make them
RT (setschedule to FIFO/RR).

E.g.:

  # mkdir /sys/fs/cgroup/cpu,cpuacct/group1
  # chrt -fp 10 $$
  # echo $$ > /sys/fs/cgroup/cpu,cpuacct/group1/tasks
  bash: echo: write error: Invalid argument
  # chrt -op 0 $$
  # echo $$ > /sys/fs/cgroup/cpu,cpuacct/group1/tasks
  # chrt -fp 10 $$
  # cat /sys/fs/cgroup/cpu,cpuacct/group1/tasks
  2345
  2598
  # chrt -p 2345
  pid 2345's current scheduling policy: SCHED_FIFO
  pid 2345's current scheduling priority: 10

Existing code comes with a comment saying the "we don't support RT-tasks
being in separate groups". Such comment is however stale and belongs to
pre-RT_GROUP_SCHED times. Also, it doesn't make much sense for
!RT_GROUP_ SCHED configurations, since checks related to RT bandwidth
are not performed at all in these cases.

Make moving RT tasks between cpu controller groups viable by removing
special case check for RT (and DEADLINE) tasks.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
Hi,

Although I'm pretty assertive in the changelog, I actually wonder what
am I missing here and why (if) current behavior is needed and makes
sense.

Any input?

Thanks,

Juri
---
 kernel/sched/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 29984d8c41f0..37386b8bd1ad 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6464,10 +6464,6 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 #ifdef CONFIG_RT_GROUP_SCHED
 		if (!sched_rt_can_attach(css_tg(css), task))
 			return -EINVAL;
-#else
-		/* We don't support RT-tasks being in separate groups */
-		if (task->sched_class != &fair_sched_class)
-			return -EINVAL;
 #endif
 		/*
 		 * Serialize against wake_up_new_task() such that if its
-- 
2.17.2

