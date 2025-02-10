Return-Path: <cgroups+bounces-6482-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58871A2F11B
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 16:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC46716531B
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DEB23CF03;
	Mon, 10 Feb 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MLzUWYYw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB13622FE1F
	for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200382; cv=none; b=KeUKASd9GAZ4LFkMg1eD1eyftPMvBmhfxcAC86kNR36dnTGuCb7P5GaDvii2SpYW0FuOdYE2AN4SUG/owOgbQ5bOomKTHovKvb3JP73+MFB7h5k3wkBgA/JS4Sil5YgJj1h6XnZOXjfLqTo6ZzsFs6HRi4st0EBcUz+lJQ7Unu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200382; c=relaxed/simple;
	bh=eqp+p20wQUC3G9kX8x2gTPBWxovLGLvK0huXE5jYVqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6hX+5v2lGZnLC4WmNIDYR3GpNZo5X4vpJaSrAj7gzb7EPls7yI/q7qHPJoiHjqEwvpXhAihIpv1D2pdmKf6sNA/Y9puaoVU5+NJS32w7YUe6z4In8sCHSe2N8fOnm6rbWOhbTqAG6oPniDVantjBL/YYtWzN37Budyf9k/xQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MLzUWYYw; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dd14c99d3so2083871f8f.3
        for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 07:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739200378; x=1739805178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8u7m4f90z4ywcN2Oo3EiIsdxXzNCHdgpNAW3hDLWX8=;
        b=MLzUWYYwer6TUCXHogcUEo64m499yH7Ze3mqmDIdvopWpBo/c4V7pA109mZ3CijnUT
         2HCXdHENai4xpC54x1RN9+z4mBDwI6Ym9N6iD/hsgnfFqZ1rv/50sQRQdwrfW1WpQFj2
         kjYnwWDzgEq5u/Ti5hxQgJmlCh4P6QYEb70kO+gQasesJ2U++WHrfdeAJAZ6M3V1AgP4
         90VlE4OP9AtMeBEZuXp27+/JmI8tf3X7sn5bey6caUATNW7EJ4b3FLvB1KabeEIavCro
         07J7/W0ZzBuUrUTu8jd1V5y1fp1F0MOePicrVXOl140vj9YH7XK7jxiW78TpNvv2ZkR+
         6UUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200378; x=1739805178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8u7m4f90z4ywcN2Oo3EiIsdxXzNCHdgpNAW3hDLWX8=;
        b=gKIb7yQ39NGkz+nOEy7v8C5iQZh1r+NZc2B1W83gtH2g2f7KFC/ndd1NAyN5VSlDs8
         SSa1pk+6pfZKoKk+X8dBjeXikcqoX2WXrKTDWtqaePp6GYJEoKEJaGmr2cWg3j6y1JtP
         a3QmuMeQdJ3vtaWHeD5eOohUotWwF9EJquwvger4oEV7BhjRJSEvi7Lpk6QW6buKhuM8
         ROKyJhvLdGw5xozTdIDLVnOtaQFe++Nct8lL/IhFk4VRWm/JePTxH7lQAjre/nXLs9t6
         4gzh7RJ92ejTWipjUKEdMpahHi1+daJZBX8zLSaP+jtfkCINOShtvvcn/P3gAxZlhz5v
         NmSw==
X-Gm-Message-State: AOJu0YyZIRF9VdCDepcwI5qier1xROfaDJjqs/bv4lWNiLE4lQUtnWFO
	/DvWsIsHza2Dcex1rBUp3qJiVA5SPleakPFXdktPKexPaIUcW4mHO2GmPnyVrOcR6GDgURFsmF4
	+
X-Gm-Gg: ASbGncsVUObGdk6n4PvkKZ+xx+VYyehiG3nDDIF/ieuWKt9EBTqHGt5a8QBmo8X3TW1
	WzEO3gch7Nm3DYofA8LJsxkSRUCfg0PN1PzZcio+b/FalTWD5jteolVXynM1YGo779BQcad612i
	e4Y0Y/hOF+qHaSR3r+5/2NLdgXMB2c7cRXyBc+L+6UqZ4JqaUqLMT48LWNV9dqbMFJ+ERtjpeLh
	B1Boz6iGpQO0nQlDPIl74bQWVjViVb8XVrw84YPziOl8nmgwcKZD2vwbdES0XTvr9wI4rh1Nuus
	e6bJZVx2DdB0wYgFwg==
X-Google-Smtp-Source: AGHT+IEge08iLsF1RRQW3k1u5tD9yIP/8sgYpac4yAMXvhMo/XohY8zQN34d83VvEo4HX5DSd15g2g==
X-Received: by 2002:a5d:64a6:0:b0:38d:de38:746d with SMTP id ffacd0b85a97d-38dde387647mr4442150f8f.47.1739200378025;
        Mon, 10 Feb 2025 07:12:58 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773339e82sm895192866b.143.2025.02.10.07.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:12:57 -0800 (PST)
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
Subject: [PATCH 5/9] sched: Skip non-root task_groups with disabled RT_GROUP_SCHED
Date: Mon, 10 Feb 2025 16:12:35 +0100
Message-ID: <20250210151239.50055-6-mkoutny@suse.com>
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
index e6e072e618a00..5b67b4704a5ed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8966,7 +8966,7 @@ void sched_online_group(struct task_group *tg, struct task_group *parent)
 	unsigned long flags;
 
 	spin_lock_irqsave(&task_group_lock, flags);
-	list_add_rcu(&tg->list, &task_groups);
+	list_add_tail_rcu(&tg->list, &task_groups);
 
 	/* Root should already exist: */
 	WARN_ON(!parent);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index dabb26b438e88..a427c3f560b71 100644
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
index e4f6c0b1a3163..4548048dbcb8f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2187,6 +2187,13 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
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
2.48.1


