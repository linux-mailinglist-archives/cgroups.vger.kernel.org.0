Return-Path: <cgroups+bounces-5923-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D99F3A97
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 21:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBE6188E086
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 20:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B071D6DB1;
	Mon, 16 Dec 2024 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OFFWs2IR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6851D5ACD
	for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380002; cv=none; b=TwaWkT/xDUwxU7I6R8y5RXuzFm8oRCRdWfP2pfWL5qO6hT40M1mzzG/YcUBpT+ggjdtXwlWt775EbsD2wY2X+TWXe9qG63xB5BalKOEIq7BC7LJCaRamVy8idz+OlF3jydUdLwRgSP7YJAUSq0gESU0dpzv5vi9Tjgrf/R8XtB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380002; c=relaxed/simple;
	bh=GEVPFmfx8lJk0msTC4kBxvoqsFBYZDzhe/s440TxMQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9hDhTeqbjRXL2jfjni+2E9eXJ+D5/RdaeRy2GGTDqCohwl/gfZkrXy+m9apnrKvLN39r+BWRQbutHppK/jxTt8lG5GZ9DQvPCeNgJygMyaOJep0IYoirhAhtKoxP7B7K1eE58wCxuC/FA6hpy3GnLxHictEA2F4uGCe+tWiOqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OFFWs2IR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so49812095e9.0
        for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 12:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734379997; x=1734984797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQzHk+vq4hHffbPZrG6QBU6HzZrXvwTNaQRxK1FhdoM=;
        b=OFFWs2IRpc7vC2rcS0i+0eMrYoWre/vJiK8Yh6ICQwk+zBFIYTkuuw7xpedpDaw2t/
         Z+iVePgVR0GeoaC4uzHXY+0Em2qHZQT0HBtdAP220VUJRHqVDw4UIrRvym41z1lUYf2h
         e4+QaZpGvagH37I0xHbpg09t+ux22PL75JcHKUNnvjy0U44yba+B4ZPA578Ua7ZIXGQr
         slWQ8PQn6MqztxdK7qr2O7VwgfZ8uNpAQOT48OZn7SFJ5pq6/5oe67sVhlkd2CG+FB9W
         12z+1sFgQ8yhVEZd4K7dqrYmvWmwqujla2qm4LxcnUX5DutjCSl4J/Yhdnx8IEU5s20d
         xbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379997; x=1734984797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQzHk+vq4hHffbPZrG6QBU6HzZrXvwTNaQRxK1FhdoM=;
        b=V1tSPm+lBgFpMWZLUSkIA/IVoBMeTnW3NGKFuo67/hzcmFqs2+LyIGYuVt81Y3CuM3
         HzhR3VW4BmVsRDt8b9woh4kCnPoUfDdIVaUz3gXwpVfAoyxC8aBykLGjwaIbIZWGcrBu
         DS+PRzNjJYgIArrA0SHDU2GUm/v/TLTa0tr1kB90WD3Gcstl4zJXdILSB6kBCgrZTyaC
         IRSiIu+QHacQ/De0UoOHvswyvIaxpIa7t4LPqsxl8TwBk3y9V9h79r7m0CuhSXEbWmKB
         r3kCILT7KrOIwpeSC+QWJpo6fvp1kPqiYR3vQFo3kAh3ln4biJ19SVXTFJeJ6+MUZphQ
         ooiw==
X-Gm-Message-State: AOJu0YwSzpF5E2hOpl+BSel0/r/9rjgo9BqJdPejzgbwGm+dl0FU7LP+
	YFgqpppoA7mCzlYy1GrkiOKgo3tOHmUdp24SuvavzqDredxQsuZKNmCnxCimv5oqayP0YUnHi1u
	W
X-Gm-Gg: ASbGncvx05BWhYO3UcprhuVqEd28RknqaXj8+yc7NTfon5wy6yHW9eLCr/qAq45JOZG
	LQvoefoHuX5wLt2D+yo7LaeavxtmwAI8i3s+W8UQBfnuVC8TWy3zldo6bq2LCDldBShIe2Jwi1B
	Auuq1w/uWHdxWi9pW2ECwUmDJNrlUoZQDts8SyvyutKVTzxTlCr+3fj4APgvPW0rlz9mjNZwa58
	9ny0Fu5CRCSlyQfHw9rgWe6YGJoUNqjcPWLSPF80tHOKaS7/6xPBLXY/Q==
X-Google-Smtp-Source: AGHT+IGyt5ABFZR5mnMw1R3r7LXBL15BSl/L4PEq55+haAC/GNs+ad/ewuDRlHUqZRIg1Cop42eYZg==
X-Received: by 2002:a05:600c:83cf:b0:434:edcf:7474 with SMTP id 5b1f17b1804b1-4362aaa1ee4mr112233245e9.33.1734379997270;
        Mon, 16 Dec 2024 12:13:17 -0800 (PST)
Received: from blackbook2.suse.cz ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm473715e9.0.2024.12.16.12.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:13:17 -0800 (PST)
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
Subject: [RFC PATCH 5/9] sched: Skip non-root task_groups with disabled RT_GROUP_SCHED
Date: Mon, 16 Dec 2024 21:13:01 +0100
Message-ID: <20241216201305.19761-6-mkoutny@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216201305.19761-1-mkoutny@suse.com>
References: <20241216201305.19761-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

First, we want to prevent placement of RT tasks on non-root rt_rqs which
we achieve in the task migration code that'd fall back to
root_task_group's rt_rq.

Second, we want to work with only root_task_group's rt_rq when iterating
all "real" rt_rqs when RT_GROUP is disabled. To achieve this we keep
root_task_group as the first one on the task_groups and break out
quickly.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/rt.c    | 9 ++++++---
 kernel/sched/sched.h | 7 +++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 47898f895a5a3..dfd2778622b8b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8958,7 +8958,7 @@ void sched_online_group(struct task_group *tg, struct task_group *parent)
 	unsigned long flags;
 
 	spin_lock_irqsave(&task_group_lock, flags);
-	list_add_rcu(&tg->list, &task_groups);
+	list_add_tail_rcu(&tg->list, &task_groups);
 
 	/* Root should already exist: */
 	WARN_ON(!parent);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 41fed8865cb09..923ec978ff756 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -497,6 +497,9 @@ typedef struct task_group *rt_rq_iter_t;
 
 static inline struct task_group *next_task_group(struct task_group *tg)
 {
+	if (!rt_group_sched_enabled())
+		return NULL;
+
 	do {
 		tg = list_entry_rcu(tg->list.next,
 			typeof(struct task_group), list);
@@ -509,9 +512,9 @@ static inline struct task_group *next_task_group(struct task_group *tg)
 }
 
 #define for_each_rt_rq(rt_rq, iter, rq)					\
-	for (iter = container_of(&task_groups, typeof(*iter), list);	\
-		(iter = next_task_group(iter)) &&			\
-		(rt_rq = iter->rt_rq[cpu_of(rq)]);)
+	for (iter = &root_task_group;					\
+		iter && (rt_rq = iter->rt_rq[cpu_of(rq)]);		\
+		iter = next_task_group(iter))
 
 #define for_each_sched_rt_entity(rt_se) \
 	for (; rt_se; rt_se = rt_se->parent)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1c457dc1472a3..d8d28c3d1ac5f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2148,6 +2148,13 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 #endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
+	/*
+	 * p->rt.rt_rq is NULL initially and it is easier to assign
+	 * root_task_group's rt_rq than switching in rt_rq_of_se()
+	 * Clobbers tg(!)
+	 */
+	if (!rt_group_sched_enabled())
+		tg = &root_task_group;
 	p->rt.rt_rq  = tg->rt_rq[cpu];
 	p->rt.parent = tg->rt_se[cpu];
 #endif
-- 
2.47.1


