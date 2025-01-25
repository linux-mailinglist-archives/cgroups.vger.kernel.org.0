Return-Path: <cgroups+bounces-6322-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D040A1C111
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 06:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227ED188CFF0
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 05:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089BD207A14;
	Sat, 25 Jan 2025 05:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DzIxWiIn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528B820765D
	for <cgroups@vger.kernel.org>; Sat, 25 Jan 2025 05:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737782777; cv=none; b=Kg2ybxHTqNpJFYWvnqHwIGvIRkSPIK1gRmDCXoLBzBNX639TuNDWHshgx0czD176n73z367scu0DEon7hpGJXBYzvHR2UUEAZEXh3darb5QvSn8qEPoDVdUSEPgJTdVYB9qaCMjMz8h+vIRntaFaAeh8Kf6u8eG6Mi33UBJEM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737782777; c=relaxed/simple;
	bh=aEtkYsQ/WkKEeXt9CBXl6mkcKsScO2YS9z/v9JWQHrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hxvVQRIxmIixfltwxn30NHe7T8n8zMfBmjVBRFt5/E6RfwaJAvC8nnMeaNBz34jYcjDdTxbg+Hf5/8WwrEUm0xOJjY9yeC3HX00RgX3Ln8kNxKPLuhLwmrwQ7Apckjp3r/9iEyOnF1+pKUBUt+sVhVY9DKRcvN4cu1XITd4D8L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DzIxWiIn; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso611091a91.2
        for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 21:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737782775; x=1738387575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eCb6/WBehJQZpcvJZGWQL2Hz1Q/N9ND9H1TrdzwNMc=;
        b=DzIxWiInmrDisvXREsDqjzWkHDWfrq7tGS23EnmmAScOQuoaJiBqeINleOqrGFopon
         14EMzUlM5r0++j2u1jBj3G7jnJGy+FxqowcHAYSzNCC677QxBLe37ZJFrhYAmWm7R+6/
         HgV/eh7DXiSHaU6VWYS6gDgmlRAxqanv7Cv5bw0ZOKjxp4JRhoxO4X4NuzFf6n7FnXSc
         in7/alBShe9gaeUZbniYQjXB5f4pyouC/KpWTIiv1KwqQfAcaXCpU/y5q2C99tNULY4q
         RjsxCkuKheLI6m2vveKQ87LfeHECpjMlQgoJXrytcutmKPFQrzH9PzYtoz3HBp8M5eU1
         DQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737782775; x=1738387575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eCb6/WBehJQZpcvJZGWQL2Hz1Q/N9ND9H1TrdzwNMc=;
        b=uLWQM43EYNJcZn6+q3YuE5vqIBiS9mEw56xNIIZJIs2/yp/0RyaxF5mUJubuTxZL/7
         Ay3yfS15bqhWFNbZxLDiUt4ejymUaBxNUvivjRJ/ySZRBuWUO3W3WDU5ZJ4CESgxP77R
         7J29ZBj/Df7mqY1CDrbgY+78uSJ36JEschpjCiV7ZO3Ak/67lXBt8T0omApfNxhZZgPo
         hNEWqu9ShtR8awOgKkSNtBw93qRDRctT2J0D7or2uobG25NCesV74PApWiLNVd/4lU2v
         KChLt6qS8xFeDYeRlZEsnlB19w3ajaeU1FSEuvNOh7SYZpDbMIZj3mmJLyrAThQo8nYz
         n/Ow==
X-Gm-Message-State: AOJu0YzuZCh2PKq3kxqy1NCVQP+fdN9lvhg/st9yUvP+NKjf6Z4igsIy
	kfgOT3CRRAEy2V3ya2xT2eB5JxByX1YI8INcGKumVLZHjPZrhlRtJmPDQZQHfhuHXIZAw98pj0K
	8
X-Gm-Gg: ASbGncvSMA8doSrnxQghCDjbaRXkGvRdJ701tR78j3j7Ud79o0rujPOf+6vuUOZ4XMr
	jKkwhFvNw2vLLx9+fOQ3LEAl+kn0Om0PvpyLDhYLi2nKbTB72/PlEQ/h0na6pG0anoaOQl+FlD9
	VzjytzQnKIc5C1YEKAqRdZrpNG5NGBPmqnP5msJ5hZXNbgSMv2e1sAYcAUPVYR6+mWMkNEdLQBl
	/d1dgBMeCswWP/CRLOG2NU53PDkZpm4dHd4W30DjtbrdFNzVzdh8uIdUSIC6rSLL2vzcUrdR82r
	irQf1Ms6byCnwBYzESL7sVnpSSubYApEcEdkNpEfaJQ=
X-Google-Smtp-Source: AGHT+IEF1uRgd/zoHtjikgksLY/feiCQXspGODJ2tSSlRF8u1Tj21NlAQAQEv3+mjbNYZi+a+IWdcA==
X-Received: by 2002:a05:6a21:900d:b0:1cf:4dae:224e with SMTP id adf61e73a8af0-1eb21470211mr18598282637.1.1737782775632;
        Fri, 24 Jan 2025 21:26:15 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac496bbdc9esm2563856a12.63.2025.01.24.21.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 21:26:15 -0800 (PST)
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
	Bitao Hu <yaoma@linux.alibaba.com>,
	Yury Norov <yury.norov@gmail.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Chen Ridong <chenridong@huawei.com>
Cc: cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] cgroup/rstat: Cleanup cpu.stat once for all
Date: Sat, 25 Jan 2025 13:25:11 +0800
Message-Id: <20250125052521.19487-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250125052521.19487-1-wuyun.abel@bytedance.com>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
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
 kernel/cgroup/rstat.c | 47 ++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index c2784c317cdd..dc6acab00d69 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -599,21 +599,39 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
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
+static void cgroup_bstat_entry_show(struct seq_file *seq,
+				    struct cgroup_base_stat *bstat,
+				    struct bstat_entry *entry)
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
@@ -625,21 +643,8 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
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
+		cgroup_bstat_entry_show(seq, &bstat, e);
 }
 
 /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
-- 
2.37.3


