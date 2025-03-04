Return-Path: <cgroups+bounces-6804-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648C2A4D6C4
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 09:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F833AAC69
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 08:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B15E1FC7EA;
	Tue,  4 Mar 2025 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuUFXaOa"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985F31FC0F9
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077694; cv=none; b=TXQyh4kKEVapI00rZS9CW5PmUHfp0PoZKuC4Hpauz9iwB6zbnhiW1/pqFt52/0rX/uaJ7XIY5sRsemEtFyfLLv6V5pKP8jxQcvVU/leVyi7/ekV6rtSjCowhK/rPAl81s5Ow0aJOSl7ruNTl2rupus3dzkf8xvsN9IP9kI102AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077694; c=relaxed/simple;
	bh=JoFBG7pMXQvknknPg4p6gPlrPQ55M+46+iQsTj5LTik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVnpqLlf/AF/AfJ0WwSonhSBmn8KkHVi3eSsKedX0HUHZn2Aqc5QTfiOnlX1xBIhZA7veOPPGdSji8+qfPSUA87mASpmmWuWJrRZHIOCSz8Nr3+JzKZdGxi0PVRO2mIIcwKBXfr9sYbAON0L31GAWqss/QesrWk+iQPccqwIeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GuUFXaOa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741077691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUFSm032bQgoMPJSD653MNcg2XgGU99Y/sFQDrAbodA=;
	b=GuUFXaOaUgmd0Ez72iPFWzrB1jvuIMBkZBIK1gw6xFkUhHEra/RCj08QN1XZfuHzUfh43p
	X0jJyr/0ICI58dRqvQTXeu9h9qsT2my/gq7FPH0o8/dzaGPUym5nd8tYywGagL44qVcFRu
	umf3AXZi04yHxksjuLN8fdO+qygyiIU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-XmFk_2pkOkapmcJtfInkAw-1; Tue, 04 Mar 2025 03:41:30 -0500
X-MC-Unique: XmFk_2pkOkapmcJtfInkAw-1
X-Mimecast-MFC-AGG-ID: XmFk_2pkOkapmcJtfInkAw_1741077689
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c3b53373faso369683685a.0
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 00:41:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077689; x=1741682489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUFSm032bQgoMPJSD653MNcg2XgGU99Y/sFQDrAbodA=;
        b=d71aeLhYnoL0qeaanUsXrVt7oGkZylUxKz445zAzRqHObgx5gPY8/uafDb6UqM9wdz
         9PD34tF56/sl5vESvxbUKissedKqWFI/hR2Mo93s8uQuydiCeDFMLGB9l2kAXuIeg0wz
         lawZUWJ1PmoEk22iC4WUR3xJGQFHE1NeWOAIifNckO9fSqd9VLVV6tM6WT4gTBmyoFA5
         pi8ruQGYIjvNzMNom9ZpZA2HR9NJ2xIDRML3VqmtLla48krdzFFkSB2BcRQureZ90cJ8
         SYOP4XJ81uPk/WdIP8E73v+tOYzryn6hiA6iFN32g5+QQ05NUNqiJUOJrROqyICrd75m
         l88A==
X-Forwarded-Encrypted: i=1; AJvYcCUQBajQHxhbtPrdSWxMQEg0kw+AiGISD5uOzHlYt2+Ev+gA1zmsWuEchagZBPuKPMilcjyWg0BY@vger.kernel.org
X-Gm-Message-State: AOJu0YwsS+f4wQPMa5hcBrptgskQzs6LlfXSRrgciBQ4wSLoVqdswIl/
	SrzYtcOER6k6RVcoeY4AyI0rrsO5EAy8ZnhpOARsia6oKr/vExju4Oeef9sFfo6bjSo9jMoTCfg
	QZTVS7rLsDAjYzd2m5gYyUNgVs8RRAL6Fcr+M8RRT5Ie9c44IZ4AqpR0=
X-Gm-Gg: ASbGncvMhodcz64gLBhYv1CgQ1/flxOcmzgkLCSOZ3d35ekuKZ+6e/5Du8DuUnjlOse
	jy7In0k21LJwWGtgHALxaiMC0vKxAAJRYibgPoMvZMWjokWWGrbefrcJfm+iCclAMuRIvSkp/n6
	dhYQuCQ92zfSw+efBaNmvdZ6EgsepVIPhb0/lvgBjJ161hikI+KLdTfc0k3fRCZcd1lllttbTnR
	n/Cx+Wb2PRnwYIgEDnWu6zWAh9wuxCwuL2r9sBuRmk4Nrth+UFTsk3nMu6zH14rftL1kwIOR+uw
	adWYMSjZSfDQ0A1+DYtl2ZsSu/jbI+IDRU/u+gIxbaQvGor/TE4xo4q2NINKQPgws4anLNo3EYE
	zdxeT
X-Received: by 2002:a05:620a:2b86:b0:7c3:c1fb:3df2 with SMTP id af79cd13be357-7c3c1fb4244mr730708085a.46.1741077689596;
        Tue, 04 Mar 2025 00:41:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjbG0dTZywrc8B1o3eEIcsstcc67Y38OSW68GGeX9mfGUlHgF5MXZ2iZRf4TVMhcQvkAS5og==
X-Received: by 2002:a05:620a:2b86:b0:7c3:c1fb:3df2 with SMTP id af79cd13be357-7c3c1fb4244mr730704985a.46.1741077689282;
        Tue, 04 Mar 2025 00:41:29 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c0a94fbbsm218395285a.1.2025.03.04.00.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:41:26 -0800 (PST)
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
Subject: [PATCH 4/5] sched/deadline: Rebuild root domain accounting after every update
Date: Tue,  4 Mar 2025 08:40:44 +0000
Message-ID: <20250304084045.62554-5-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304084045.62554-1-juri.lelli@redhat.com>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
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
index b70d6002bb93..bdfda0ef1bd9 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2796,6 +2796,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 	ndoms_cur = ndoms_new;
 
 	update_sched_domain_debugfs();
+	dl_rebuild_rd_accounting();
 }
 
 /*
-- 
2.48.1


