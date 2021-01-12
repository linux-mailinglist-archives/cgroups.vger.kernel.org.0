Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711182F34CF
	for <lists+cgroups@lfdr.de>; Tue, 12 Jan 2021 16:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391533AbhALP4O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Jan 2021 10:56:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391715AbhALP4O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Jan 2021 10:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610466886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfgtcL4F5AYD3v5kDSOmx2qMlgaNuM9QROpZ54Xxzng=;
        b=eAmV7qyEPrnqcZZl59IZb+TbtDYPR59Zyu5h4YBYXIAdSdHMUrhOL+v3Aqw9YwJnsufFRo
        R5RKUq2UF0p2k2QtyjwatWrVQ+D7GSxJYCA7+piIIGkLb0GMjV1u+yZV1H8L5ePJL2gFsd
        S1Ls0ClGK5Tnl4M3C6zqbD6dV53EL6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-2u1xyzybNIuEgojcFJD9NA-1; Tue, 12 Jan 2021 10:54:45 -0500
X-MC-Unique: 2u1xyzybNIuEgojcFJD9NA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1743518C89C4;
        Tue, 12 Jan 2021 15:54:43 +0000 (UTC)
Received: from x1.com (ovpn-113-251.rdu2.redhat.com [10.10.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53B075D9CD;
        Tue, 12 Jan 2021 15:54:33 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marco Perronet <perronet@mpi-sws.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        cgroups@vger.kernel.org
Subject: [PATCH 5/6] sched/deadline: Add helpers to get the correct root domain/span/dl_bw
Date:   Tue, 12 Jan 2021 16:53:44 +0100
Message-Id: <645f20a3fc9287aff2c5e8ca1a08ec1cb32996d5.1610463999.git.bristot@redhat.com>
In-Reply-To: <cover.1610463999.git.bristot@redhat.com>
References: <cover.1610463999.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

task_cpu() is often used on SCHED_DEADLINE to access the root_domain
and associated information. However, the task_cpu() does not always
reflect the correct CPU. The reason being is shown in the code:

From kernel/sched/core:
----- %< -----
 * p->on_rq <- { 0, 1 = TASK_ON_RQ_QUEUED, 2 = TASK_ON_RQ_MIGRATING }:
 *
 *   is set by activate_task() and cleared by deactivate_task(), under
 *   rq->lock. Non-zero indicates the task is runnable, the special
 *   ON_RQ_MIGRATING state is used for migration without holding both
 *   rq->locks. It indicates task_cpu() is not stable, see task_rq_lock().
[...]
 * task_cpu(p): is changed by set_task_cpu(), the rules are:
 *
 *  - Don't call set_task_cpu() on a blocked task:
 *
 *    We don't care what CPU we're not running on, this simplifies hotplug,
 *    the CPU assignment of blocked tasks isn't required to be valid.
----- >% -----

So, a sleeping task will not have its task_cpu() stable, and this is
causing problems on SCHED_DEADLINE.

In preparation for fixing this problems, we need to add helper functions
that return the dl_task_cpu, root_domain, and "root" dl_bw that
reflects the current placement/affinity of the task.

Note that these functions are only required on the code path that
can happen when the task is not queued.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
---
 kernel/sched/sched.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 54881d99cebd..5f3f3cb5a6ff 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2393,6 +2393,37 @@ void __dl_update(struct dl_bw *dl_b, s64 bw)
 		rq->dl.extra_bw += bw;
 	}
 }
+
+static inline
+int dl_task_cpu(struct task_struct *p)
+{
+	/*
+	 * We can only rely on task_cpu() of runnable tasks.
+	 */
+	if (p->on_rq)
+		return task_cpu(p);
+
+	/*
+	 * The task_cpu() of non-runnable task migth be pointing a CPU
+	 * it cannot run anymore (see set_task_cpu()). Hence, let's
+	 * get a possible cpu from the current cpu_mask.
+	 */
+	return cpumask_any(p->cpus_ptr);
+
+}
+
+static inline
+struct root_domain *dl_task_rd(struct task_struct *p)
+{
+	int cpu = dl_task_cpu(p);
+	return cpu_rq(cpu)->rd;
+}
+
+static inline
+struct dl_bw *dl_task_root_bw(struct task_struct *p)
+{
+	return &dl_task_rd(p)->dl_bw;
+}
 #else
 static inline
 void __dl_update(struct dl_bw *dl_b, s64 bw)
@@ -2401,6 +2432,18 @@ void __dl_update(struct dl_bw *dl_b, s64 bw)
 
 	dl->extra_bw += bw;
 }
+
+static inline
+int dl_task_cpu(struct task_struct *p)
+{
+	return 0;
+}
+
+static inline
+struct dl_bw *dl_task_root_bw(struct task_struct *p)
+{
+	return &task_rq(p)->dl.dl_bw;
+}
 #endif
 
 
-- 
2.29.2

