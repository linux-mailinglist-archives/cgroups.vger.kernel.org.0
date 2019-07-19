Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB92A6E10D
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2019 08:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbfGSGfH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Jul 2019 02:35:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44014 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfGSGfH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Jul 2019 02:35:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so31013605wru.10
        for <cgroups@vger.kernel.org>; Thu, 18 Jul 2019 23:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKIcroJ5c146Me5/UckyA9wonTzrtGOSvsfKceZzZUg=;
        b=YQzRIDxfAuZ0BmCX8ymkY8XmEoUJbc3dLoY87LJj4cVx8coMqpDhsaQLCtKrCzDJmf
         EIj9aPIIMcsCu/6oWzhn3Q6TVrVQ/hX3m0FS8iGaL6IiLGotMgnx/0fCA8P9jwnXc2JT
         qZcx2gzvdbA9ejuZ02HEcvvjL8gdbTmZBQN3Ml+zs52K6rS9dDCGkUDWgqYQet4e5JRU
         3d6u2D8N63mhDYUESt2kvDspKuH10P5LnhOwAFR9eK6Kt/2hvV1y5360iDHJS+M5aQzc
         6X0PwtNP0XFfYa0sqxuJKXa638wf51swQE/A9eEkuuK5re7s6oQbP1n4HUjqEOG9QbdP
         qgvA==
X-Gm-Message-State: APjAAAXqg9LVvONS8RtVw+lw/AD6XXmM4gYzMHj78aODqbDEB/pU54ef
        oVH69dXXzcfVrgy37idiiBmyEw==
X-Google-Smtp-Source: APXvYqwPp6u9X83T0UyTAWZVqFzzT9UvJpG8nGbWUl4quIxB6L49QUU3mCiU6LiumUTuHYkDE/VvuA==
X-Received: by 2002:adf:d081:: with SMTP id y1mr56442538wrh.34.1563518104787;
        Thu, 18 Jul 2019 23:35:04 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id 32sm24181517wrh.76.2019.07.18.23.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jul 2019 23:35:03 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, tj@kernel.org
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, bristot@redhat.com, lizefan@huawei.com,
        longman@redhat.com, cgroups@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2] sched/core: Fix cpu controller for !RT_GROUP_SCHED
Date:   Fri, 19 Jul 2019 08:34:55 +0200
Message-Id: <20190719063455.27328-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Also, as Michal noted, it is currently not possible to enable cpu
controller on unified hierarchy with !CONFIG_RT_GROUP_SCHED (if there
are any kernel RT threads in root cgroup, they can't be migrated to the
newly created cpu controller's root in cgroup_update_dfl_csses()).

Existing code comes with a comment saying the "we don't support RT-tasks
being in separate groups". Such comment is however stale and belongs to
pre-RT_GROUP_SCHED times. Also, it doesn't make much sense for
!RT_GROUP_ SCHED configurations, since checks related to RT bandwidth
are not performed at all in these cases.

Make moving RT tasks between cpu controller groups viable by removing
special case check for RT (and DEADLINE) tasks.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
v1 -> v2: added comment about unified hierachy in changelog (Michal)
          collected acks/reviews
---
 kernel/sched/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fa43ce3962e7..be041dc7d313 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6934,10 +6934,6 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
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

