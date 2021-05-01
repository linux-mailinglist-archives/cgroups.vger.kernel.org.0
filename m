Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D572237078C
	for <lists+cgroups@lfdr.de>; Sat,  1 May 2021 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhEAOWy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 1 May 2021 10:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhEAOWy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 1 May 2021 10:22:54 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670CEC06138B
        for <cgroups@vger.kernel.org>; Sat,  1 May 2021 07:22:03 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id d15so1518263ljo.12
        for <cgroups@vger.kernel.org>; Sat, 01 May 2021 07:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8uPHeuGdEheiXGiJoHLYGMoo98FylflZj6piR4L3lk8=;
        b=rQ7RohVXnRLvo0DxISMGS3hUDUhGbjxWFMmy8VHQf4B4r9DzYTt0E5hHUSnlpY756m
         H6xNHZSeWaK98dMFi+sOLcPSAk5rL/oJlbpKZB+hwlrPB75hGrRYwMeBBBsRlI2TnApY
         toRH/Y9cOxBDJPOqIWhkEBvj41b5adOZV/JqsXHjxT11/6hFeGf9RlQCbvSPb/2NzAzj
         7hNlQKJmvmgds2/GFCQY8DBgHdL0VpLPnAziHCQEwU9wZYkGjBwSWfUdodtTePYA5ovz
         l5pLYKKyfSY64ghOPIyFmebLKAw4A+HebS3uq87vbLrdb2y+ho733BwKBBSa+z16/yVH
         8rSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8uPHeuGdEheiXGiJoHLYGMoo98FylflZj6piR4L3lk8=;
        b=kJZNk6pXuS5WnrJnDGt7JQMHQu3XivnSMnfLuT6GNlN1Sr09tOfD2kncdtn4ZrwHux
         k4OYr8ujcyJuItedHWklCijFEU2jH+HynYEOxoC716JHcVnLYa/28ADceD3Lu5rtcznX
         Yh4NiPSQTVAkM26GAiZ+xYJE9/toBsb6JQ4Gh7obpshK2O9QeOiPwPYiUK8NS1X7eE+A
         uzecoTNiRE3ueXQlH3T+Jd1CGWAIxAzBRroOan0M+Oh4IKpuLV6+XFD44TiMBE+DH6G+
         VAhkBZflSLiy3uH12pV74BChwEb1/Uu6eqGjSwCE2I+xL2o/OFul+oUHo6DeiBagQpRy
         p8gA==
X-Gm-Message-State: AOAM533+0rB+/UlpvUCfe7IoG7Vmbh1/loIjlr/zWmxSaiIJcFInusNN
        FCvZJFnr43VBbdJDLg6rgpzK/w==
X-Google-Smtp-Source: ABdhPJwd8yELdg+c0LWe0nc0HHmIoneFP7abqVeT+aKbyE2o7PZUqUERt8RMFD+LWVhXXgCN86DB3A==
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr6956200ljm.160.1619878921934;
        Sat, 01 May 2021 07:22:01 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2280.bb.online.no. [80.212.253.245])
        by smtp.gmail.com with ESMTPSA id h22sm581400lfu.91.2021.05.01.07.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 07:22:01 -0700 (PDT)
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
Subject: [PATCH v2 1/1] sched/fair: Fix unfairness caused by missing load decay
Date:   Sat,  1 May 2021 16:19:50 +0200
Message-Id: <20210501141950.23622-2-odin@uged.al>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501141950.23622-1-odin@uged.al>
References: <20210501141950.23622-1-odin@uged.al>
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

This applies to cases where the new process is the first in the cfs_rq,
issue introduced 3d30544f0212 ("sched/fair: Apply more PELT fixes"), and
when there has previously been load on the cgroup but the cgroup was
removed from the leaflist due to having null PELT load, indroduced
in 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing
path").

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
Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
Signed-off-by: Odin Ugedal <odin@uged.al>
---
 kernel/sched/fair.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..9e189727a457 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10844,16 +10844,22 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq;
 
+	list_add_leaf_cfs_rq(cfs_rq_of(se));
+
 	/* Start to propagate at parent */
 	se = se->parent;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
-		if (cfs_rq_throttled(cfs_rq))
-			break;
+		if (!cfs_rq_throttled(cfs_rq)){
+			update_load_avg(cfs_rq, se, UPDATE_TG);
+			list_add_leaf_cfs_rq(cfs_rq);
+			continue;
+		}
 
-		update_load_avg(cfs_rq, se, UPDATE_TG);
+		if (list_add_leaf_cfs_rq(cfs_rq))
+			break;
 	}
 }
 #else
-- 
2.31.1

