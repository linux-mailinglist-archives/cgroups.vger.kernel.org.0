Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7C36A5AA
	for <lists+cgroups@lfdr.de>; Sun, 25 Apr 2021 10:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhDYIMF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 25 Apr 2021 04:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhDYIMF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 25 Apr 2021 04:12:05 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF90C06175F
        for <cgroups@vger.kernel.org>; Sun, 25 Apr 2021 01:11:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id o5so27360303ljc.1
        for <cgroups@vger.kernel.org>; Sun, 25 Apr 2021 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ja9s7DnGWK5NRJashY05ov0nwmFYwHpa/VMTSuJsJUk=;
        b=rEus9jnA+ejmTp7ph79aQsJ7EK4671QgNJJnPWBK3K8AlAHrQ0mCob3KZgWwBV1Vo3
         y0sTGUCHCZEkWsZK7TCGjz17Pp3/8kL8xW/ikeFt0tnDwP5Kc0Lye77shWXiiLd34dpf
         G9SaqVH0F4EigkJqWIujmNJlp0rUE3v4KHcaAOCumgb1ctcMaMEw1EC2m5MWhAm3vWqb
         B+yGGgWceoUAr9ZdtYaIa8OtXkabiBSzUy1pNkhHqfA9xSwgxVW9QR85qGI7J9rDXL10
         Kw4vgfG4u911QsOVk499X0zx8jr9Vj50oCyjXkJSB6scdH4ywYQ+CNt6RaW8tE8A1JFp
         oT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ja9s7DnGWK5NRJashY05ov0nwmFYwHpa/VMTSuJsJUk=;
        b=rAEPh8AOoUfqGeZTj79VZZ3b6rIjuU7RFnPQROTMfyVT542aOWEm9tTe+CYN6/A5g9
         jS78zyBgXV745EbWwB81Tx6Jsb4BlVVbU4AqK+yXMiCVP3+nMkLucNyYDTV8cacnrD6z
         WVYGHjMySsJEbh3H0TY1wMM9CYvA7aX3HWQq85BZwBW7aqq8WUx/mTThsuCvSRJp8J1T
         lcUp5gi3M2HK4iO7aRta5VvyHENUoUKtSlPgv3bzIEAjNxSpR0MYDnFSfFaCQf8aFShY
         N/uAbWh55pc3hqS3EQN+T4cQmBZXublry54/Knxf0LPikINryUUT58TwwK3Yie0wt/Kx
         5L5g==
X-Gm-Message-State: AOAM533UapVtLgoMqO96dceu5bsPOhxj6mfuBja7OOu0wkfsXzHOCJPR
        ZhZYxwUMIL3cvr99VLYP7UKCXQ==
X-Google-Smtp-Source: ABdhPJwb7xJPKOHrp2rA3TRsGAgiQOlmydTxYB9ZmpmdYXn9gjPbf6dzKEW4HEb5H0Bw3xAaGrfFag==
X-Received: by 2002:a05:651c:603:: with SMTP id k3mr8618756lje.191.1619338282374;
        Sun, 25 Apr 2021 01:11:22 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2280.bb.online.no. [80.212.253.245])
        by smtp.gmail.com with ESMTPSA id a5sm1038906lfg.115.2021.04.25.01.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 01:11:22 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odin Ugedal <odin@uged.al>
Subject: [PATCH 1/1] sched/fair: Fix unfairness caused by missing load decay
Date:   Sun, 25 Apr 2021 10:09:02 +0200
Message-Id: <20210425080902.11854-2-odin@uged.al>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210425080902.11854-1-odin@uged.al>
References: <20210425080902.11854-1-odin@uged.al>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This fixes an issue where old load on a cfs_rq is not properly decayed,
resulting in strange behavior where fairness can decrease drastically.
Real workloads with equally weighted control groups have ended up
getting a respective 99% and 1%(!!) of cpu time.

When an idle task is attached to a cfs_rq by attaching a pid to a cgroup,
the old load of the task is attached to the new cfs_rq and sched_entity by
attach_entity_cfs_rq. If the task is then moved to another cpu (and
therefore cfs_rq) before being enqueued/woken up, the load will be moved
to cfs_rq->removed from the sched_entity. Such a move will happen when
enforcing a cpuset on the task (eg. via a cgroup) that force it to move.

The load will however not be removed from the task_group itself, making
it look like there is a constant load on that cfs_rq. This causes the
vruntime of tasks on other sibling cfs_rq's to increase faster than they
are supposed to; causing severe fairness issues. If no other task is
started on the given cfs_rq, and due to the cpuset it would not happen,
this load would never be properly unloaded. With this patch the load
will be properly removed inside update_blocked_averages. This also
applies to tasks moved to the fair scheduling class and moved to another
cpu, and this path will also fix that. For fork, the entity is queued
right away, so this problem does not affect that.

For a simple cgroup hierarchy (as seen below) with two equally weighted
groups, that in theory should get 50/50 of cpu time each, it often leads
to a load of 60/40 or 70/30.

parent/
  cg-1/
    cpu.weight: 100
    cpuset.cpus: 1
  cg-2/
    cpu.weight: 100
    cpuset.cpus: 1

If the hierarchy is deeper (as seen below), while keeping cg-1 and cg-2
equally weighted, they should still get a 50/50 balance of cpu time.
This however sometimes results in a balance of 10/90 or 1/99(!!) between
the task groups.

$ ps u -C stress
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root       18568  1.1  0.0   3684   100 pts/12   R+   13:36   0:00 stress --cpu 1
root       18580 99.3  0.0   3684   100 pts/12   R+   13:36   0:09 stress --cpu 1

parent/
  cg-1/
    cpu.weight: 100
    sub-group/
      cpu.weight: 1
      cpuset.cpus: 1
  cg-2/
    cpu.weight: 100
    sub-group/
      cpu.weight: 10000
      cpuset.cpus: 1

This can be reproduced by attaching an idle process to a cgroup and
moving it to a given cpuset before it wakes up. The issue is evident in
many (if not most) container runtimes, and has been reproduced
with both crun and runc (and therefore docker and all its "derivatives"),
and with both cgroup v1 and v2.

Fixes: 3d30544f0212 ("sched/fair: Apply more PELT fixes")
Signed-off-by: Odin Ugedal <odin@uged.al>
---
 kernel/sched/fair.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..ad7556f99b4a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10916,6 +10916,19 @@ static void attach_task_cfs_rq(struct task_struct *p)
 
 	if (!vruntime_normalized(p))
 		se->vruntime += cfs_rq->min_vruntime;
+
+	/*
+	 * Make sure the attached load will decay properly
+	 * in case the task is moved to another cpu before
+	 * being queued.
+	 */
+	if (!task_on_rq_queued(p)) {
+		for_each_sched_entity(se) {
+			if (se->on_rq)
+				break;
+			list_add_leaf_cfs_rq(cfs_rq_of(se));
+		}
+	}
 }
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
-- 
2.31.1

