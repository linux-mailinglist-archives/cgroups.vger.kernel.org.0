Return-Path: <cgroups+bounces-7044-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA1AA5FD1D
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 18:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751D517131A
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F8E269D08;
	Thu, 13 Mar 2025 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKLTav2j"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427B269812
	for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885830; cv=none; b=Lj6+fqFdnE8/cC0EAknKyQJas8ZeffxdbhidqXpFVRJ3tydIR/kp1sCGkcAJlStBZFCR1Rsc6Sc0kzcybT1dWg91fxKRzXuGmpvFVgF1BjL8ucGDW+nZxm1Mj/P+yFoYx3P9nU7fdTBdBQgTJUmrAP09J+/uLM3uEcMdLKfVHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885830; c=relaxed/simple;
	bh=nR1ob2cQONENW8eUXzLTE8w0E2+3XPvDjEWYcWYXJ6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5s0JGm6F1MyaFblSXJQ3ghmgqzvLIpIDgUE42XP5PNgHdgH2CzL5Lr7Seor00eSuDbhl/AsZs4pJsZNwam1GcR9UGdwoJSnKMq8zUrx+yR7/Z02AM7A2AXriHU+r3cmSsvd6Tx2LdMMu5RrxuNQsXhGGig9PVf+wUj/z2jkrCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKLTav2j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13IrME9qVH+0+hXjGK6BJyrl1EowiQUElDsQf/trHmI=;
	b=gKLTav2jRTD12bRwwAn89KemLIrRnq56XY3bxnRqFbcz7CDwDJiViGhnjI31d9ELr0FknW
	NJHK2zmxkIXbmREftI8DENqBfZmh//TasQmg3Ucbm2lxDfcXcvmLPLpaAkgYOli8eQU+9T
	EcugsI5At3goqgd2jbKTi5ianY41t6c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-zLmnX66VPA6Bq-OnC-P2Rg-1; Thu, 13 Mar 2025 13:10:26 -0400
X-MC-Unique: zLmnX66VPA6Bq-OnC-P2Rg-1
X-Mimecast-MFC-AGG-ID: zLmnX66VPA6Bq-OnC-P2Rg_1741885825
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912a0439afso589682f8f.3
        for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 10:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885825; x=1742490625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13IrME9qVH+0+hXjGK6BJyrl1EowiQUElDsQf/trHmI=;
        b=f+uNXIO15DJ22knuF/HkORSFoXZqgt3cqi2+9vnjhy3gQWTUHRmP8x0/F4j3sBPs0t
         k3c8XmF4uTBiChh4XPsNaWimvz+fBEE5boXpbYphiZojmY1+8d25YsETkUjIaGtZsgKf
         hzAh72ZjN5gbMS5EyDHLoTLamBRfRrjaWst27Kn2JikAh0M+Bl4vn6/ck9g3cKnsZO9m
         E+K6yNSwUZ1jsL5BcNam8savCQ7X+vM09PUwLbrTWGDPwIJkVv4S5tobj8UXy9955EOm
         YbkJ9Jqw/a//h3M7FCGXnG+cFsJlNlRGRJWu4/6J2uqCnlWo+A283dV81BlD+w0v7ELg
         mLrA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Duo+H/CyDFBSCe7jinqLr4S5PUXkUB2GQD/bOZtxCbN0jZqZ+P7uCaPlm2BdxZeSUMB9axqX@vger.kernel.org
X-Gm-Message-State: AOJu0YxtPAt7XQ6+E9d6YdAs4gG0/EQ+CZdM7QbrttkAE5CBqOpOCF1S
	YJwP8mWIoi4YZPUa0eMKW0GvYe2ctwoahrkLmmVGeNOxA5mni59Xg7SoNIuauiunSEeZ0bE4IkZ
	/21yDpdwVMB60w069qlNwPhAwIYTjvy9kLLDQsCFpPaG5bJzI0c1oMTc=
X-Gm-Gg: ASbGncse7SmAuswTo51rSEMgbTVdSqetCbz/WMLdApDcqr4pmfY314XsgaUwwVbCWFF
	HBSOk5SArXmmfflgl/91ptzWRsfj9VvvaNtMQzlh0rgvw00UoOnlG8ZEN0sQ0S9zYuTCz5r+90h
	XGgR2HX5XyCJ7hS5NiXntrlVeUfnccNulcqjU2KGIRWhdjHRo7SPCS4HlMs8/KItgzFDXq6Stb4
	ib4y8EGSfG0MRVUIdlZl8u7B6O23FT/MSb3GcHMcf7Kckf4KbFLUjA3+iGK1AuLY2yIaNPnFzEC
	64A7f3Vnq2FCEbOTFy/uV8UCtNGJulABfJEfw91Ajq8=
X-Received: by 2002:a5d:598f:0:b0:391:2e97:577a with SMTP id ffacd0b85a97d-396c3e16586mr352397f8f.55.1741885824764;
        Thu, 13 Mar 2025 10:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+lg8zlUlXluRXE6AcisRhjeRo0PjZSFqibrRBKyIRUbuHm3FBSBZu6OcQAhW2z6WDs92D3g==
X-Received: by 2002:a5d:598f:0:b0:391:2e97:577a with SMTP id ffacd0b85a97d-396c3e16586mr352346f8f.55.1741885824314;
        Thu, 13 Mar 2025 10:10:24 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb92csm2752500f8f.91.2025.03.13.10.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:10:23 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:10:21 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v4 4/8] sched/deadline: Rebuild root domain accounting after
 every update
Message-ID: <Z9MRfeJKJUOyUSto@jlelli-thinkpadt14gen4.remote.csb>
References: <20250313170011.357208-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313170011.357208-1-juri.lelli@redhat.com>

Rebuilding of root domains accounting information (total_bw) is
currently broken on some cases, e.g. suspend/resume on aarch64. Problem
is that the way we keep track of domain changes and try to add bandwidth
back is convoluted and fragile.

Fix it by simplify things by making sure bandwidth accounting is cleared
and completely restored after root domains changes (after root domains
are again stable).

To be sure we always call dl_rebuild_rd_accounting while holding
cpuset_mutex we also add cpuset_reset_sched_domains() wrapper.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Co-developed-by: Waiman Long <llong@redhat.com>
Signed-off-by: Waiman Long <llong@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
v3 -> v4: add cpuset_reset_sched_domains wrapper so that we always call
          partition_sched_domains holding cpuset_mutex (Waiman)
---
 include/linux/cpuset.h         |  6 ++++++
 include/linux/sched/deadline.h |  1 +
 include/linux/sched/topology.h |  2 ++
 kernel/cgroup/cpuset.c         | 23 ++++++++++++++++-------
 kernel/sched/core.c            |  4 ++--
 kernel/sched/deadline.c        | 16 ++++++++++------
 kernel/sched/topology.c        |  1 +
 7 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 835e7b793f6a..17cc90d900f9 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -128,6 +128,7 @@ extern bool current_cpuset_is_being_rebound(void);
 extern void rebuild_sched_domains(void);
 
 extern void cpuset_print_current_mems_allowed(void);
+extern void cpuset_reset_sched_domains(void);
 
 /*
  * read_mems_allowed_begin is required when making decisions involving
@@ -264,6 +265,11 @@ static inline void rebuild_sched_domains(void)
 	partition_sched_domains(1, NULL, NULL);
 }
 
+static inline void cpuset_reset_sched_domains(void)
+{
+	partition_sched_domains(1, NULL, NULL);
+}
+
 static inline void cpuset_print_current_mems_allowed(void)
 {
 }
diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 6ec578600b24..f9aabbc9d22e 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -34,6 +34,7 @@ static inline bool dl_time_before(u64 a, u64 b)
 struct root_domain;
 extern void dl_add_task_root_domain(struct task_struct *p);
 extern void dl_clear_root_domain(struct root_domain *rd);
+extern void dl_clear_root_domain_cpu(int cpu);
 
 #endif /* CONFIG_SMP */
 
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 7f3dbafe1817..1622232bd08b 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -166,6 +166,8 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
+extern void dl_rebuild_rd_accounting(void);
+
 extern void partition_sched_domains_locked(int ndoms_new,
 					   cpumask_var_t doms_new[],
 					   struct sched_domain_attr *dattr_new);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f87526edb2a4..1892dc8cd211 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -954,10 +954,12 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
 	css_task_iter_end(&it);
 }
 
-static void dl_rebuild_rd_accounting(void)
+void dl_rebuild_rd_accounting(void)
 {
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
+	int cpu;
+	u64 cookie = ++dl_cookie;
 
 	lockdep_assert_held(&cpuset_mutex);
 	lockdep_assert_cpus_held();
@@ -965,11 +967,12 @@ static void dl_rebuild_rd_accounting(void)
 
 	rcu_read_lock();
 
-	/*
-	 * Clear default root domain DL accounting, it will be computed again
-	 * if a task belongs to it.
-	 */
-	dl_clear_root_domain(&def_root_domain);
+	for_each_possible_cpu(cpu) {
+		if (dl_bw_visited(cpu, cookie))
+			continue;
+
+		dl_clear_root_domain_cpu(cpu);
+	}
 
 	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
 
@@ -996,7 +999,6 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 	sched_domains_mutex_lock();
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	dl_rebuild_rd_accounting();
 	sched_domains_mutex_unlock();
 }
 
@@ -1083,6 +1085,13 @@ void rebuild_sched_domains(void)
 	cpus_read_unlock();
 }
 
+void cpuset_reset_sched_domains(void)
+{
+	mutex_lock(&cpuset_mutex);
+	partition_sched_domains(1, NULL, NULL);
+	mutex_unlock(&cpuset_mutex);
+}
+
 /**
  * cpuset_update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
  * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 58593f4d09a1..dbf44ddbb6b4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8183,7 +8183,7 @@ static void cpuset_cpu_active(void)
 		 * operation in the resume sequence, just build a single sched
 		 * domain, ignoring cpusets.
 		 */
-		partition_sched_domains(1, NULL, NULL);
+		cpuset_reset_sched_domains();
 		if (--num_cpus_frozen)
 			return;
 		/*
@@ -8202,7 +8202,7 @@ static void cpuset_cpu_inactive(unsigned int cpu)
 		cpuset_update_active_cpus();
 	} else {
 		num_cpus_frozen++;
-		partition_sched_domains(1, NULL, NULL);
+		cpuset_reset_sched_domains();
 	}
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3e05032e9e0e..5dca336cdd7c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -166,7 +166,7 @@ static inline unsigned long dl_bw_capacity(int i)
 	}
 }
 
-static inline bool dl_bw_visited(int cpu, u64 cookie)
+bool dl_bw_visited(int cpu, u64 cookie)
 {
 	struct root_domain *rd = cpu_rq(cpu)->rd;
 
@@ -207,7 +207,7 @@ static inline unsigned long dl_bw_capacity(int i)
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline bool dl_bw_visited(int cpu, u64 cookie)
+bool dl_bw_visited(int cpu, u64 cookie)
 {
 	return false;
 }
@@ -2981,18 +2981,22 @@ void dl_clear_root_domain(struct root_domain *rd)
 	rd->dl_bw.total_bw = 0;
 
 	/*
-	 * dl_server bandwidth is only restored when CPUs are attached to root
-	 * domains (after domains are created or CPUs moved back to the
-	 * default root doamin).
+	 * dl_servers are not tasks. Since dl_add_task_root_domain ignores
+	 * them, we need to account for them here explicitly.
 	 */
 	for_each_cpu(i, rd->span) {
 		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
 
 		if (dl_server(dl_se) && cpu_active(i))
-			rd->dl_bw.total_bw += dl_se->dl_bw;
+			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
 	}
 }
 
+void dl_clear_root_domain_cpu(int cpu)
+{
+	dl_clear_root_domain(cpu_rq(cpu)->rd);
+}
+
 #endif /* CONFIG_SMP */
 
 static void switched_from_dl(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 44093339761c..363ad268a25b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2791,6 +2791,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 	ndoms_cur = ndoms_new;
 
 	update_sched_domain_debugfs();
+	dl_rebuild_rd_accounting();
 }
 
 /*
-- 
2.48.1


