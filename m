Return-Path: <cgroups+bounces-6864-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF00A54D1E
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 15:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246AC3B1ABF
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 14:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E371B16F0E8;
	Thu,  6 Mar 2025 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1l02Ykx"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF35B18A6AF
	for <cgroups@vger.kernel.org>; Thu,  6 Mar 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270280; cv=none; b=BWcKUHLRUcAxsLkTGw38sIbVr8VE/CXU8lEajFNr7QNYbQKO+e1LDMJc+OxkWn4faGyJwZZAZaNPsCuFjlR1zf1eUH0zmoqMAdA+YWKUOOBAZe0aiJGDLQTd1XKRL0yiFTBDnt1pqjUfJ6Ncpu5dEu/Hz2wiOq09iFPJhNTsu3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270280; c=relaxed/simple;
	bh=72vgfzS/NoqpzjzSUDCO8wd5QQDPCLgcmhF+lVelQns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=speiayotY8GzZOxRmIL9Pd0geryYlMQ+3GeYEvjYjMO3SsHWUsGAZ+yRxxLm+XRKf/pv3Pm95YUeQUPcNvw31VEfd1ULkjRdzjMjFpoDreZtc0d/9t541dtHxomzbVN8UIy3CwiE5j++E4qRpGSBlL95KU3td5jvEmvpDv9Ekvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1l02Ykx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAqrxFos5baxMMm+58GJv+qJfXrJ7okyTkO5C9Q+Myk=;
	b=I1l02YkxXPK1FVuFUHWTEHAgoJTAdYd0l5fh4DBy35F0uYZoMXBi4MoIxtPWJ93UfU74Q1
	2MiCbABKToLzPDATjCIqZDhOadhJ+h5ANuGHNK5v1xjl1kz3S9+c8+/QQIJliKeRMFqsiK
	4yY2IrxALKod5gbrlVtp5nV2TDAqFSQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-Oh2QOOHxPoGRdSOGtimo7A-1; Thu, 06 Mar 2025 09:11:00 -0500
X-MC-Unique: Oh2QOOHxPoGRdSOGtimo7A-1
X-Mimecast-MFC-AGG-ID: Oh2QOOHxPoGRdSOGtimo7A_1741270260
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c3c8f8ab79so127830085a.2
        for <cgroups@vger.kernel.org>; Thu, 06 Mar 2025 06:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270260; x=1741875060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAqrxFos5baxMMm+58GJv+qJfXrJ7okyTkO5C9Q+Myk=;
        b=FrzoYSgWyK98l3647QqcLgA34pFlj3JsOlTQ+u9QBQQBsITcAJ79VBgjueHQPyUcz2
         41jcTER4zdYEhWKloddoA0ziuYRGjJ+ppR6DiI41Y+SG5hqdR2gH6ogERrsk58PhAk99
         Snduyb1EdXfqVNDhc8ZJm26jEcuKcR+9Ey7RPatmyBeZnUkxyKzqGFI5DHiqHJNMhWGy
         3dvryKtuwmWVknmpjqCMeuC/MUwxy11P+d9km5kO0w2a8rdz5grUkxtMDBhmAjuNah4T
         sqxsRQoTxBg/AuVUkK0JJzZg+2DXo3Gll3yFuVhQTVeVP7pxlx4wD1B8zu6j6DWA2KPh
         v0vA==
X-Forwarded-Encrypted: i=1; AJvYcCXfnW/6Wk+k/Kl5pErIdEsH5FBOu7KHh5knOy2X+JiGzvnWCRig8E1S71WWPtSsL3rPQ5nc2s/g@vger.kernel.org
X-Gm-Message-State: AOJu0YzQCXYsJ7MRzMeySon2AXc4FMU4NYHAfffpprVRnHVQMr3A5YtJ
	0cB32uL7TQgFRRA4nrVQDorC5wTOyFbeE8CUMeX0GN8RhhaXOuE7IcUaNT46s95LY36qnRKnP1E
	pTenCqW2vcjxPDMVAauGotBNdfJCKXVElpBnxGLnUf37mMV2SndXpgtI=
X-Gm-Gg: ASbGnctP84V8wvtv27b6XwDTsv9lM0pP/s8izsc27u4lSp7/EXA9NmmWSl/RtJhJ4wE
	YPFUcpeQKh1vluInUCWYN0HDqJbCWrS2lWg76ojyWSAODGCnrQ2jkKczqcXh7/J8u0b8lmjh1/C
	Od/T8B6QqInVoC3s9hqHQ/Cdu1M6ecvZrwpE7+POC4myfux3zjA+JkVUVdW/PCSPwRIhMKmCIs0
	/NihN1yyEqEqoTnTnp3xzS+XAvoSJu0r6dei4Zibzw/M36RVkTyYyGc7rRF/kx5sF1TBx81qPVj
	hVXEtQUzj9ID3w93whxfbzXEMAAqpDYtTtFT63Dzx1YzewqryZDobqId0RWXQmpHCQgGE6wH999
	b5n3H
X-Received: by 2002:a05:620a:8085:b0:7c0:ac2a:ec2 with SMTP id af79cd13be357-7c3d8bd2980mr967717785a.2.1741270260197;
        Thu, 06 Mar 2025 06:11:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG771ZEB7JVBEk+ccelxoIpVf1FwI0733+VbrstNGFZVGij6ibDc85fMk4i+GYeD/BM+tseog==
X-Received: by 2002:a05:620a:8085:b0:7c0:ac2a:ec2 with SMTP id af79cd13be357-7c3d8bd2980mr967713185a.2.1741270259808;
        Thu, 06 Mar 2025 06:10:59 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:10:57 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 4/8] sched/deadline: Rebuild root domain accounting after every update
Date: Thu,  6 Mar 2025 14:10:12 +0000
Message-ID: <20250306141016.268313-5-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306141016.268313-1-juri.lelli@redhat.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rebuilding of root domains accounting information (total_bw) is
currently broken on some cases, e.g. suspend/resume on aarch64. Problem
is that the way we keep track of domain changes and try to add bandwidth
back is convoluted and fragile.

Fix it by simplify things by making sure bandwidth accounting is cleared
and completely restored after root domains changes (after root domains
are again stable).

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched/deadline.h |  4 ++++
 include/linux/sched/topology.h |  2 ++
 kernel/cgroup/cpuset.c         | 16 +++++++++-------
 kernel/sched/deadline.c        | 16 ++++++++++------
 kernel/sched/topology.c        |  1 +
 5 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 6ec578600b24..a780068aa1a5 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -34,6 +34,10 @@ static inline bool dl_time_before(u64 a, u64 b)
 struct root_domain;
 extern void dl_add_task_root_domain(struct task_struct *p);
 extern void dl_clear_root_domain(struct root_domain *rd);
+extern void dl_clear_root_domain_cpu(int cpu);
+
+extern u64 dl_cookie;
+extern bool dl_bw_visited(int cpu, u64 gen);
 
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
index f87526edb2a4..f66b2aefdc04 100644
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
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 339434271cba..17b040c92885 100644
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
+	 * dl_servers are not tasks. Since dl_add_task_root_domanin ignores
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


