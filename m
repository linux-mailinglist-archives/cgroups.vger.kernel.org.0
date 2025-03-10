Return-Path: <cgroups+bounces-6919-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBADA58FD6
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 10:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493BF3A420A
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 09:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40062253EA;
	Mon, 10 Mar 2025 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHez2J8/"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D978C2253E1
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599440; cv=none; b=F4day+9MCVzSpAtDq3A/pKpm4y3LR339DIWSmW4uJef5rUle8rGp75y2iZ/yrs0EKTfbLqRB2Cnsre+S3h7cveyudAkWnZ3sfwSgLyKod5FI+AeA2n6xvWQ5TBwGP+kkigsrT8mcBPlX9xWxmz17HctCPlfI9YGpLATh4e4WFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599440; c=relaxed/simple;
	bh=dJ0qYuhLvHREJelUpJrsJhya+cYWSalYL5+mpIrhEfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClKVPR6xt+n12J7dHVQXDzEArY12UN7JOCn9JsvRo+OhYx9F8mvjUvcrkeaN9AjktdO61FqP7UOV7Tnsd9sWIUHflgExZFBGIIMzfKdYsDmqIUKbU9S0Fyht1TpePfhhq7lDjirUW6ihJbfveEop1kHMxtuLa47iFiffM1Qcl0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHez2J8/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+C55SaFeRG+WldAEv/0LRZJhn3q8mtrbeietSUyeneQ=;
	b=hHez2J8/UIpehNIJfw1BUykIWbrK7okHotUMWGRxs5dSEjez9DkFAwC0n/I47UMsvW8cQV
	UTXlxq7uILJvw/HOh4l1efInFa5c3XquP0803UJJlBL6QfXGxr5hhY+wHiLOfChHn96LmT
	NWudH3kipSm/7JXqeCq+sG+rp2pzTmE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-vEy8N9WDNy2Z3uW4TgpkIQ-1; Mon, 10 Mar 2025 05:37:16 -0400
X-MC-Unique: vEy8N9WDNy2Z3uW4TgpkIQ-1
X-Mimecast-MFC-AGG-ID: vEy8N9WDNy2Z3uW4TgpkIQ_1741599435
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39131f2bbe5so1204436f8f.3
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 02:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599435; x=1742204235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+C55SaFeRG+WldAEv/0LRZJhn3q8mtrbeietSUyeneQ=;
        b=YM75LmjTDMmINEK3xY88rf3RMe6ogkBqdYsk9knbms41tdfw7I/BA8Ls4FUC3TL4KG
         klFoO6kFva3DPttssoVAXVd3ojZnvtMRV0EZsy/5B4cx6KZLPYn1mEJzquCvu8orGO0u
         phgHNvgjVC7wwvcQRfuBlCtO/l+6z3CKc2WbmdDvIFVUeYKyZBa6E0rgSX90vvJkb6hb
         wMwfUPPszVumGkwDtrp1nKcXyO5jV7yF6rdUuoo5AWfiu6nSwXz2RaxG8PiMPm6kMs8f
         kXtjbdm2z5D8NNuwzdKTdsJUxCLgb/p+dc0bhgKqFLKYd1tG4SkNQ8R8snf6APITPHhW
         38uA==
X-Forwarded-Encrypted: i=1; AJvYcCWE907AsgNHUYkc+3x8SE7hGCV6gT0qhTXhpwStYPYEj46vVcVuIrjHryB1ogA3GnPKfce/l5o1@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRlv6c16Mh0KV8DYupyL239hmjUj3T2t46HDD3zs1ne4ZDhNP
	XDP/pM0xAAuYXx0MRNB/lYOSj9LDXX9NFyDlmHNZbyHjOG5ih/EKuuY4htnIwOvyL/C8OZVD/Ir
	DILEKCKXWkgoBJC5bgkzf63v/5JWfJfRGYaOQPpMZ7WtFL476xbqBqlU=
X-Gm-Gg: ASbGnct891RGMrxLky+sYTajZBFYrK21KKA8IJGXnfGfti7DTvQ3dmVSLqaV1ltj0H/
	98iZLYvAMHGS9hzYFZJ47sqmxon9GefzbhvzTqkv3V1SNAB8y8UIFKTYWBVvPWtRLxWA5AdLHiv
	ytznY8yv3Zy2SFTQzTbgM3CxOVFNLgeoQuD9lI3SA8HCwYgaAZwq7B+yuqidgIEv3yKtd+jGdfr
	HXgE3RgrafDBdrMyNgeRJM8EhD70BI7FelU539HVNwcya9I6olP8oKQnWE3keqqpStcj3+xMwjO
	sV42PUhZWSsFq/+khbwXzVr2BA5fWdiMHSVUV0oaqds=
X-Received: by 2002:a5d:6d8c:0:b0:391:275a:273f with SMTP id ffacd0b85a97d-39132d062ffmr6592127f8f.4.1741599435170;
        Mon, 10 Mar 2025 02:37:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExIpAItUyYwNwbwrEcWjE6mY/t/AxIyxf0UMVVUy7pCml0YQyGPHbTBqkpFTvPNnlmG/D4tA==
X-Received: by 2002:a5d:6d8c:0:b0:391:275a:273f with SMTP id ffacd0b85a97d-39132d062ffmr6592100f8f.4.1741599434809;
        Mon, 10 Mar 2025 02:37:14 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfcfd2a95sm10234805e9.29.2025.03.10.02.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:37:13 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:37:10 +0100
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
Subject: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting after
 every update
Message-ID: <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310091935.22923-1-juri.lelli@redhat.com>

Rebuilding of root domains accounting information (total_bw) is
currently broken on some cases, e.g. suspend/resume on aarch64. Problem
is that the way we keep track of domain changes and try to add bandwidth
back is convoluted and fragile.

Fix it by simplify things by making sure bandwidth accounting is cleared
and completely restored after root domains changes (after root domains
are again stable).

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
v2 -> v3: remove spurious dl_bw_visited declaration (Shrikanth)
---
 include/linux/sched/deadline.h |  1 +
 include/linux/sched/topology.h |  2 ++
 kernel/cgroup/cpuset.c         | 16 +++++++++-------
 kernel/sched/deadline.c        | 16 ++++++++++------
 kernel/sched/topology.c        |  1 +
 5 files changed, 23 insertions(+), 13 deletions(-)

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


