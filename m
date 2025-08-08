Return-Path: <cgroups+bounces-9045-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A268B1EB92
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 17:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB1584E48F8
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 15:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35546284B39;
	Fri,  8 Aug 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mk5QMeRb"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDFE283FEA
	for <cgroups@vger.kernel.org>; Fri,  8 Aug 2025 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666485; cv=none; b=L66qmGAOMOZpeAy1uZTgtSmbW0L32Vyx7GIUsZ7gq4AtOksUBFafW9gSloZkgl2Pg+5x3y0oWivFJROHVrnUP0vbBVe/kqYsPLoE01exMN2Flectdng82gkEOqJAtGKzkII6q4SFL2sCvEg8dm00sGddsefSsTo2Y/u3AGYCCVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666485; c=relaxed/simple;
	bh=GoVQz85XRSK4EnmDjUywrx9qG5mAsCPsLS5ttvZ+MJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAG/NIzSRi4YkE/4irQgxjRzpS8VIxuTko/5BgKbeaytTysF+SSwyXrW/utjcikY0fbirTQw5BuADWqyDa560Ep7vZyr/GguOwVCopGhbx68FnPI8HDp106YfcdfCTjOA9qC9GSR9KMD4oUqteioV68BqhZJ2juWqt/KusoBqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mk5QMeRb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754666482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJvtXRmFLqg3cjTyv7JZL5JKi+l3dywyp+8sWT9E3vU=;
	b=Mk5QMeRbA8DZsMbocriVBE31Te/wLMt1vvFy3yz1OL3LKjMvL4X6+Y7pqmgZd4LiQfXFE0
	Em+0g6acOvYaRGql3fwcLCuNA2ja0qTEbxu031YJUz9+o3Hfvj430hwXCmcKV/N0yswCnB
	Co6dzDkjVvN8tRioovdmBZCC3QFKEPU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-lLulFMOLMk2tYQ8XiMY6nw-1; Fri,
 08 Aug 2025 11:21:17 -0400
X-MC-Unique: lLulFMOLMk2tYQ8XiMY6nw-1
X-Mimecast-MFC-AGG-ID: lLulFMOLMk2tYQ8XiMY6nw_1754666448
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA0D119560B2;
	Fri,  8 Aug 2025 15:20:47 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8727180029D;
	Fri,  8 Aug 2025 15:20:41 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 14/18] tick: Pass timer tick job to an online HK CPU in tick_cpu_dying()
Date: Fri,  8 Aug 2025 11:19:57 -0400
Message-ID: <20250808152001.20245-5-longman@redhat.com>
In-Reply-To: <20250808151053.19777-1-longman@redhat.com>
References: <20250808151053.19777-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

In tick_cpu_dying(), if the dying CPU is the current timekeeper,
it has to pass the job over to another CPU. The current code passes
it to another online CPU. However, that CPU may not be a timer tick
housekeeping CPU.  If that happens, another CPU will have to manually
take it over again later. Avoid this unnecessary work by directly
assigning an online housekeeping CPU.

Use READ_ONCE/WRITE_ONCE() to access tick_do_timer_cpu in case the
non-HK CPUs may not be in stop machine in the future.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/time/tick-common.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 9a3859443c04..6d5ff85281cc 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -17,6 +17,7 @@
 #include <linux/profile.h>
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <linux/sched/isolation.h>
 #include <trace/events/power.h>
 
 #include <asm/irq_regs.h>
@@ -394,12 +395,18 @@ int tick_cpu_dying(unsigned int dying_cpu)
 {
 	/*
 	 * If the current CPU is the timekeeper, it's the only one that can
-	 * safely hand over its duty. Also all online CPUs are in stop
-	 * machine, guaranteed not to be idle, therefore there is no
+	 * safely hand over its duty. Also all online housekeeping CPUs are
+	 * in stop machine, guaranteed not to be idle, therefore there is no
 	 * concurrency and it's safe to pick any online successor.
 	 */
-	if (tick_do_timer_cpu == dying_cpu)
-		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
+	if (READ_ONCE(tick_do_timer_cpu) == dying_cpu) {
+		unsigned int new_cpu;
+
+		new_cpu = cpumask_first_and(cpu_online_mask, housekeeping_cpumask(HK_TYPE_TICK));
+		if (WARN_ON_ONCE(new_cpu >= nr_cpu_ids))
+			new_cpu = cpumask_first(cpu_online_mask);
+		WRITE_ONCE(tick_do_timer_cpu, new_cpu);
+	}
 
 	/* Make sure the CPU won't try to retake the timekeeping duty */
 	tick_sched_timer_dying(dying_cpu);
-- 
2.50.0


