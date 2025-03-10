Return-Path: <cgroups+bounces-6943-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8DAA59BF8
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 18:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAC1188B3CD
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 17:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBF1230BC3;
	Mon, 10 Mar 2025 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KZT446zf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0400D233120
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626308; cv=none; b=KEfse+KoJEnGDj6zNc/tdW5hHzCxeN5R+cDOdA5m5tdEjDfeu+vg43jJy4+xYbmED2WVEEptYfmEByQpMFM1O5/Q9mZrx3HsM+7A8wop6YKfs6kFmw6bgFg4BT2SumGT0GhLnk+vvdWtIdBh3La6sgunh8nvQhylZx5nu8QZYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626308; c=relaxed/simple;
	bh=e1GtMQHyXqLttzeCe+LsTrtmYMYgOJr+zxNK5BFPZ+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibkemPkJEpbNYZoTH3xMycPj9kD77uuNQ/3b48G5qOBbQWMV9f1qNueA+sQGaqOefJGpgBm/uyFnxzruNyR64o/QNhGvFI5kqiCJsKBi6Rf0kuq8J6uwB0mN6y+aPE8t5QaBV1lLmw5fj1RJi5xlKu/OwoW+movX1VOVW3gs7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KZT446zf; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3914a5def6bso805764f8f.1
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626304; x=1742231104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CdFzOQJ6hH6QUOgKxio0cWYoQzFtWX3s2A4l5iJzf4=;
        b=KZT446zfBGpgnJDDGtt7WnO9qgjTKLRY/6MNW5lzUtgMGrQ0xxplYWyI4vUYj7IVBY
         FPzPDVJAyQpOYKrQvpY28KTDIdGRcQb4pFXW4Q4WKcqmuOnmP6cxU6aLbbtSzM+NIpbX
         Yt0DhIs44diYNclSs5cTE3h3OyFX9jCjfRrz5f4ndox/RR7xpiC4SWuYAEN27K1mzuNs
         EmjmSQYs39g6fxPCEocpmQWjoFgy47afBucO74a1wOTAxz0ZcFPQsOVPdTfzplk7a2R6
         OeNe7GTwRVIzsxJHw6pa6r2dDGV1dhn5tf3psYFew0m4gJ/iBztcHQdexOAmEno1QOtA
         JjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626304; x=1742231104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CdFzOQJ6hH6QUOgKxio0cWYoQzFtWX3s2A4l5iJzf4=;
        b=mB/aa6w+K9fU02m+BQMMbPy9ljPnDLvaS0bp1NpNpQCRit6FCLGyInCcoNYnLDaq1Q
         mUDlLdaz/AXqOrieU2cu64ElpSHZf+mLP7Hpqa5Hs3/gOSU/A41novEnDuw6cZf4i9fQ
         +pv7SMezllESI3KR9zSPDzO9V6oOOZf1vjjts1LZOTsurc9tz7GG1uBQfCgvF5m0f3jH
         uTLsyJzG68pGMxVLuJJLZ95TCPhBuYUKJ4SEczMmphWLTSBaIyxTVQ452CT/BxDWakv+
         wIfxd2d5wksYRA4VFqLC8LLuHL5QBJAgYShnj1EySsZM0U8Qt2oyk8uWa6aCX71WqKQq
         2m0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/HXW4e5rz6B/P515cIjU4LSR3ydYhEg7//IqqVmE6KunQTQZvoWIYFIzqqVu2nh/58odNGx9r@vger.kernel.org
X-Gm-Message-State: AOJu0YxHr5zafPRsn1GkCBidQbmsFN+hdU3jLl5VlqsabD7aie1wSN1/
	LfI9cDm/O+2wYFXhYUnLNbW4zYRmbL/fMUD2PxcsDdCaKIlIE4REAnWwP1H/Y9Q=
X-Gm-Gg: ASbGncv36azX+cDc4Wg17nsN8RdeM/Z+oSR8xt1E499Uz48C1MsAeabIRGXeGzIfoDL
	lO316sYYReNr9f6sNZyn2z2n/8ztGIMJ/UChX2RwbmqSpe5S6FFVIsvNYd0fMiexiBgImdzb7GL
	xcIQu4bA+KrJfvrAmLBRBuKwD13uuMhQt/7ZjZEEIatjSF3++3LT0svqzWqQY6dKulwnM8f5dzp
	OUcUc2686SzLaC11KbKyWC4zqfx3XrAAsu1PpuuvScHwqII0onjMc3pqfQTbW7SANU1E4YESIm0
	xD81Oge0TvO5vbmo8X6Odm1iaaF1W2FbEuhEh6D+waClrVs=
X-Google-Smtp-Source: AGHT+IHrl+aJzW5pNkgbF9I6l+mU7rRhdrECqyUo2hjKVe+CzUcZUZcuNl1pVkPcNQTUFgWNmsbfLw==
X-Received: by 2002:adf:b312:0:b0:390:f6cd:c89f with SMTP id ffacd0b85a97d-39132db6f86mr7386155f8f.53.1741626304335;
        Mon, 10 Mar 2025 10:05:04 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba679sm15302514f8f.8.2025.03.10.10.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:05:04 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v2 07/10] sched: Do not construct nor expose RT_GROUP_SCHED structures if disabled
Date: Mon, 10 Mar 2025 18:04:39 +0100
Message-ID: <20250310170442.504716-8-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170442.504716-1-mkoutny@suse.com>
References: <20250310170442.504716-1-mkoutny@suse.com>
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


