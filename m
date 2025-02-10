Return-Path: <cgroups+bounces-6484-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D03FA2F11F
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 16:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE41F1627BE
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2B123CF15;
	Mon, 10 Feb 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JhQanq6C"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30886204866
	for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200383; cv=none; b=J0ZaqhxnkTAAks7/MieF2QcHD9QO3758ymPHn5oYs/wBfPmQuX8pGRQg3awvRdtTiMHrZ4/6qohvtWowa6beaBGihqhxSjkSjr9yxW5gwP4uY6VWrRMZZ0Sgdsvf+dFG7UQXXfIcyG0gkED1B5x85i+CeNv4UPNoC2srWdoKkG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200383; c=relaxed/simple;
	bh=e1GtMQHyXqLttzeCe+LsTrtmYMYgOJr+zxNK5BFPZ+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZdcmZas/fJdBluj7PhY61FEQUzO14PLfj+V87d6yCfKmMV4G/RTuGKcbt91mEW+ek71TaYNpoH+bCwIOf0viA0oxmsa6IzUBEjPwPrIYuyfe0eajhZ1vSsB1a2/WtCES/mlBTZEaFjGZx+NebyX6TZMqPJdP4jlC+3etd3gfW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JhQanq6C; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaec61d0f65so995438266b.1
        for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739200379; x=1739805179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CdFzOQJ6hH6QUOgKxio0cWYoQzFtWX3s2A4l5iJzf4=;
        b=JhQanq6CRa2EtQcyBxaCpgZ2DLlBaqsGzPhZe5P53it/db8YkCM0GHQAoPAjD8ckTu
         ChBQ/1L47cUHRWvkaIYMzRfNDgtAwY/GDD7b7ZAmbiCaclMK6yeiEVq5lQ3ec8SQpPCQ
         yEQPXq740/3U0wPx6O2+0xx5SDsGZhDfWkHOyH02vRe5lDygKj0uk6n2fSs29JSjYCmz
         IV2rTj3O/rL9y3tIu+tdz1S3h56tQ2FPuYu4kFn2bDx2CdqNPgfJVNlowE0KmY+cTFr+
         v5kNXFLbBgCNZJs0TLBbRYfkKhIrWZ/jC04LLXQGTlYGm0B0/KYKahOG+4FP/40t9bqm
         F/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200379; x=1739805179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CdFzOQJ6hH6QUOgKxio0cWYoQzFtWX3s2A4l5iJzf4=;
        b=aQvNiDWvnYhWxv2NlT1EePu6eBzOuqcLeuqpbw8rvgCbCRaDzq4oebswWrxs25/xZa
         x3q1pHZFFKziSHut4IG1kw1Xc9bspHJEcq+la8Hpw5hOYnaZFga3bqXhdPr/4Q7u6k7q
         rSo4ecbGrmhKggUp1ptgc3/m7eHeWroWluJjSJGR6B9+LiAY4o2qOj6vvM2YFoFAMTM1
         BdK9ka8GSTNAeDWmRKDW5p2fQRri/eQG7HGETScQ/QH6vfoyhyhPmOhsiVGt1MMwsZ2t
         HV+F0Hn2JWlb1vXWO+i84IXLs4LQxY4qd/PXX32IuDLz9OdZBM8r0IWVIIjhnPArcz9l
         6Z/g==
X-Gm-Message-State: AOJu0YxcKpCj/FwztOSCZAJDYvyr4rV2HVLKTwUu0/qmH5yM10H2HHdw
	KCyoJPuw4ezb8IxWBuhNdKh9IOY8Rf+4dcGoOTq5Hu5Aqr5NSA8SXsHSMWw/DHJFv2PZuWp01l3
	t
X-Gm-Gg: ASbGncszeF9abx1knmdlY4OAhap/1OkaDoWzR7hKp4O7EBtdbmmmzRU80pyKxQuhdsn
	CtOmEDxlbzVd4oHUz2sBYG18zM4Y8lXVQ7xvKAjb2LeB3iNC8YeZzddif9sP3KU03OsWysXRSaO
	JeeHfYbZzCdaLQJdW3lvgKtiNxLV2eLzDzfbZirITdqBb4uvNGQ9DazHnwrjewS9UxwWe6wOEUN
	XUVN8Yv1oW/lPas3mnBhk23DJ+6L20ccH68W9/5dOmK6QtQpBLvEwfbGenJGs5QC6zgIKU8kag2
	WdQr/UvFY7Flu+GjmQ==
X-Google-Smtp-Source: AGHT+IH/BV7V8vs1uXFvIC4uN9ZnTMvJSeRLysfZRy4ypVIbXT1Ov45yrEhapv3A6zivAa4othcS2Q==
X-Received: by 2002:a17:907:6d12:b0:ab7:cd83:98c4 with SMTP id a640c23a62f3a-ab7cd839b76mr268690466b.50.1739200379226;
        Mon, 10 Feb 2025 07:12:59 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773339e82sm895192866b.143.2025.02.10.07.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:12:59 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: [PATCH 7/9] sched: Do not construct nor expose RT_GROUP_SCHED structures if disabled
Date: Mon, 10 Feb 2025 16:12:37 +0100
Message-ID: <20250210151239.50055-8-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210151239.50055-1-mkoutny@suse.com>
References: <20250210151239.50055-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks to kernel cmdline being available early, before any
cgroup hierarchy exists, we can achieve the RT_GROUP_SCHED boottime
disabling goal by simply skipping any creation (and destruction) of
RT_GROUP data and its exposure via RT attributes.

We can do this thanks to previously placed runtime guards that would
redirect all operations to root_task_group's data when RT_GROUP_SCHED
disabled.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/core.c | 36 ++++++++++++++++++++++++------------
 kernel/sched/rt.c   |  9 +++++++++
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a418e7bc6a123..4b2d9ec0c1f23 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9827,18 +9827,6 @@ static struct cftype cpu_legacy_files[] = {
 		.seq_show = cpu_cfs_local_stat_show,
 	},
 #endif
-#ifdef CONFIG_RT_GROUP_SCHED
-	{
-		.name = "rt_runtime_us",
-		.read_s64 = cpu_rt_runtime_read,
-		.write_s64 = cpu_rt_runtime_write,
-	},
-	{
-		.name = "rt_period_us",
-		.read_u64 = cpu_rt_period_read_uint,
-		.write_u64 = cpu_rt_period_write_uint,
-	},
-#endif
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	{
 		.name = "uclamp.min",
@@ -9857,6 +9845,20 @@ static struct cftype cpu_legacy_files[] = {
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
+static struct cftype rt_group_files[] = {
+	{
+		.name = "rt_runtime_us",
+		.read_s64 = cpu_rt_runtime_read,
+		.write_s64 = cpu_rt_runtime_write,
+	},
+	{
+		.name = "rt_period_us",
+		.read_u64 = cpu_rt_period_read_uint,
+		.write_u64 = cpu_rt_period_write_uint,
+	},
+	{ }	/* Terminate */
+};
+
 # ifdef CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED
 DEFINE_STATIC_KEY_FALSE(rt_group_sched);
 # else
@@ -9879,6 +9881,16 @@ static int __init setup_rt_group_sched(char *str)
 	return 1;
 }
 __setup("rt_group_sched=", setup_rt_group_sched);
+
+static int __init cpu_rt_group_init(void)
+{
+	if (!rt_group_sched_enabled())
+		return 0;
+
+	WARN_ON(cgroup_add_legacy_cftypes(&cpu_cgrp_subsys, rt_group_files));
+	return 0;
+}
+subsys_initcall(cpu_rt_group_init);
 #endif /* CONFIG_RT_GROUP_SCHED */
 
 static int cpu_extra_stat_show(struct seq_file *sf,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f25fe2862a7df..1633b49b2ce26 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -195,6 +195,9 @@ static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
 
 void unregister_rt_sched_group(struct task_group *tg)
 {
+	if (!rt_group_sched_enabled())
+		return;
+
 	if (tg->rt_se)
 		destroy_rt_bandwidth(&tg->rt_bandwidth);
 }
@@ -203,6 +206,9 @@ void free_rt_sched_group(struct task_group *tg)
 {
 	int i;
 
+	if (!rt_group_sched_enabled())
+		return;
+
 	for_each_possible_cpu(i) {
 		if (tg->rt_rq)
 			kfree(tg->rt_rq[i]);
@@ -247,6 +253,9 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 	struct sched_rt_entity *rt_se;
 	int i;
 
+	if (!rt_group_sched_enabled())
+		return 1;
+
 	tg->rt_rq = kcalloc(nr_cpu_ids, sizeof(rt_rq), GFP_KERNEL);
 	if (!tg->rt_rq)
 		goto err;
-- 
2.48.1


