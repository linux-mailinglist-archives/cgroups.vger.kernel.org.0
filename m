Return-Path: <cgroups+bounces-6250-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E83EBA1A929
	for <lists+cgroups@lfdr.de>; Thu, 23 Jan 2025 18:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E7D3A6F99
	for <lists+cgroups@lfdr.de>; Thu, 23 Jan 2025 17:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C02157A55;
	Thu, 23 Jan 2025 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L6DjL5zd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01C7156991
	for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654525; cv=none; b=lNNyOGeZ1Z5vtaVwzvPTTULGIkYMNOVCagY488eOZtGCAxvqysFf49H5GZMiWZdUtg32JJf9nXyOyXGm4M1k8bQvk1evvYVHgAiCSjSwS5VRu7wvXwYzEyweeh8/zrA8josQeTir08yYqxNJO5HcXoKDzHpDxaf76DCrRlpHRYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654525; c=relaxed/simple;
	bh=XwNrVTH6RspMCBLEZ/5wMEfwaHpU6drBEqIS2KKM5wM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PzsMgx2fBJJUBg9ZZ5IzIc7HsfhvVENiELShVgexvKkFl475CSiqsiCujoJesLdbc+0AjDAUIbjCrIKxgjN5hkFeZfz87GK1ahMvRo53vR71dsTqVnhgZ5SKhuQV4ZdpRv2XMimVBi3kzxbbnBVcIwjvlpp5nb3qEvB+yZ5/5zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=L6DjL5zd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21c2f1b6093so2202005ad.1
        for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 09:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737654522; x=1738259322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx8fUoG+qG925p/xr/d8LpD/h5B1JhsStZuypGEmZQI=;
        b=L6DjL5zdrc1QnqkaGNFl/4rQG5acwUXjonz5eIBm1+6/9eSxQd6qY4XQelX8c4Pyvp
         r7f6lkHnpPbXkJZ5M1v8KyzcThJ0Q3INXz27J/c0lmCUG4f2lI4Ti65hZVvNIojBEmnz
         LApywd05kKUx5+ZY4Mshri5SUNo8DWJNt29aqor6LwJXfFqJXgRZ8AY9Ro9PsxVE1Jmm
         n7ROryizyiOOUtrYc14foNfXj2pmD1fDQRXBAoW4xykQaDVZyJ2AQaE7c5lQc8QY0VFW
         3eMCR2ECkPjrBQXQUN4IA1XeiyHCNTyTPnUdu1MftR04NMbdFrFxw3E0id3qFWVWIodt
         n1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737654522; x=1738259322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cx8fUoG+qG925p/xr/d8LpD/h5B1JhsStZuypGEmZQI=;
        b=DuBiGY7nw8C5zGZdKUCYWa9c1SMUpMy2bNDdnktzf6Zf5/fUHN7T4EL9/gL7Yi62pd
         +MY/paZIWjOcH+y4VjNJ0YMC2d/yp92yJpRuCIlvcFifDu6WGWhNDXIj9YkMS72nYK1t
         pCqdpr3tow5jNZOH+VUQvFDakQsLypCzjp1nAsW/kNSCm/NgfjA3cTaTWeylOC7l1lSg
         f7MkvszZSFeLhm+s94z5LvtiqjmryPewzXTCD7KGpPlAfkvQoxmco2tRvXbqzB7Wej9P
         F/d15VZZ73Rs+tYna5mpfxHuaW/OKG9E2moT6rdxguNuanUWkPPqEo6EZzMEwBrNS5+L
         Hrfw==
X-Gm-Message-State: AOJu0YwaEr63eDOZHloBXRNJ13J/5Oz9MRIxtBz5wusM13PhBpYc60id
	G4MvkTMFt13EKC55PbRp33lqz2fSbkKg3QM4DwopttOsRAgjVeZ+9wotqKIyj9s=
X-Gm-Gg: ASbGncv4l+uXs15bqdFPF3lj3baTwxVrx50GTztNXa3zDYr4ahacGniRE/Kqh6th7Bz
	/sAikOZDNRLCFS5MdVmDo1hO5oG2zeyrry69wI1JnGE1jFioXZeYK6G54COLFFob/6gsLpQRQeu
	0issoTheu9+KH0R4P+gJezS8D7PFXCMFFOrMCMAKyRJ8DosuBgoVjoB685PELZqPZ8XEC8AqOVj
	B6tyjTVOuy91WTqVW7fkgUD5u4fStONW5nC4gyEjtOV8gI1NVhUtQ0KBLSRsZGqxd6Ws0FmelOo
	h60YNOUTdHrwGZ6HQywKjDV0ZTKFBXYepxYbKk8Q3tE=
X-Google-Smtp-Source: AGHT+IFsazWW4fPdtPuxncs3q9P/qmXf4v1U22R2wSi5/Ec7pQyEc+6B2cc7jn1KQB1fA2Ms5Bmetw==
X-Received: by 2002:a17:903:1106:b0:20c:f648:e388 with SMTP id d9443c01a7336-21c355c024bmr149310335ad.7.1737654520451;
        Thu, 23 Jan 2025 09:48:40 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141c4esm1620765ad.110.2025.01.23.09.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:48:40 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yury Norov <yury.norov@gmail.com>,
	Chen Ridong <chenridong@huawei.com>
Cc: cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] cgroup/rstat: Cleanup cpu.stat once for all
Date: Fri, 24 Jan 2025 01:47:02 +0800
Message-Id: <20250123174713.25570-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250123174713.25570-1-wuyun.abel@bytedance.com>
References: <20250123174713.25570-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There were efforts like b824766504e4 ("cgroup/rstat: add force idle show helper")
to escape from #ifdef hells, and there could be new stats coming out in
the future, let's clean it up once for all.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/cgroup/rstat.c | 46 +++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index c2784c317cdd..6ad647f3e241 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -599,21 +599,38 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 	}
 }
 
+static struct bstat_entry {
+	const char	*name;
+	const int	offset;
+} bstats[] = {
+#define BSTAT_ENTRY(name, field)	\
+	{ name, offsetof(struct cgroup_base_stat, field) }
+	BSTAT_ENTRY("usage_usec",	cputime.sum_exec_runtime),
+	BSTAT_ENTRY("user_usec",	cputime.utime),
+	BSTAT_ENTRY("system_usec",	cputime.stime),
+	BSTAT_ENTRY("nice_usec",	ntime),
+#ifdef CONFIG_SCHED_CORE
+	BSTAT_ENTRY("core_sched.force_idle_usec", forceidle_sum),
+#endif
+	{ NULL } /* must be at end */
+#undef BSTAT_ENTRY
+};
 
-static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat *bstat)
+static void __append_bstat(struct seq_file *seq, struct cgroup_base_stat *bstat,
+			   struct bstat_entry *entry)
 {
-#ifdef CONFIG_SCHED_CORE
-	u64 forceidle_time = bstat->forceidle_sum;
+	u64 *val;
 
-	do_div(forceidle_time, NSEC_PER_USEC);
-	seq_printf(seq, "core_sched.force_idle_usec %llu\n", forceidle_time);
-#endif
+	val = (void *)bstat + entry->offset;
+	do_div(*val, NSEC_PER_USEC);
+	seq_printf(seq, "%s %llu\n", entry->name, *val);
 }
 
 void cgroup_base_stat_cputime_show(struct seq_file *seq)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
 	struct cgroup_base_stat bstat;
+	struct bstat_entry *e;
 
 	if (cgroup_parent(cgrp)) {
 		cgroup_rstat_flush_hold(cgrp);
@@ -625,21 +642,8 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 		root_cgroup_cputime(&bstat);
 	}
 
-	do_div(bstat.cputime.sum_exec_runtime, NSEC_PER_USEC);
-	do_div(bstat.cputime.utime, NSEC_PER_USEC);
-	do_div(bstat.cputime.stime, NSEC_PER_USEC);
-	do_div(bstat.ntime, NSEC_PER_USEC);
-
-	seq_printf(seq, "usage_usec %llu\n"
-			"user_usec %llu\n"
-			"system_usec %llu\n"
-			"nice_usec %llu\n",
-			bstat.cputime.sum_exec_runtime,
-			bstat.cputime.utime,
-			bstat.cputime.stime,
-			bstat.ntime);
-
-	cgroup_force_idle_show(seq, &bstat);
+	for (e = bstats; e->name; e++)
+		__append_bstat(seq, &bstat, e);
 }
 
 /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
-- 
2.37.3


