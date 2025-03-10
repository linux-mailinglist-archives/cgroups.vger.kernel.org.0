Return-Path: <cgroups+bounces-6941-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0907DA59BF5
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 18:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFF63A6924
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B908233730;
	Mon, 10 Mar 2025 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WwaY1E1A"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8117A231A37
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626307; cv=none; b=royNLhS+FhQAcdeWRE1f/5sHH2Simz7mfhJ01lUHZLPKqIkACZrOuAaK6Cu7SENSt9WduP3q5ZulGB5E03zL8LvmEvE1qfm57khjTA+8zS0lkFBduvx2M0gMZDgIdlIuMd11j0Pz09xB1Wo46X4yAr4pec5fwJl8SmPkXY0I8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626307; c=relaxed/simple;
	bh=eqp+p20wQUC3G9kX8x2gTPBWxovLGLvK0huXE5jYVqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOIefhhs2HSXyxUsMIsqm1Zp2lokzgHK7PghInJAOnYJPlr8zD6+DfVhUtMNYqIt/MZULqEnSTkj9cQLr8pIt4UoZxFrUVdoQEbQgU2/JzdgZbVmJOJguwkKXU8McbEeX3lwpvixWZH2IIr7BNV6+ufeg7ggjZC9nroIIS3Mgdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WwaY1E1A; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso12015935e9.3
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626303; x=1742231103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8u7m4f90z4ywcN2Oo3EiIsdxXzNCHdgpNAW3hDLWX8=;
        b=WwaY1E1AE69SzPRokTlQSuDnWVlUdHM3BFSO7Dyes5LdPU1qy1s8RtalRIrgHoftT8
         q14G5eG+MqiAB/df4xWvOGS3EJwN3V3Ht8im7wXnUr0NZu4LRZZEMuoIMxj4RpPVimPN
         /88m969lhGBpowKvAUywW/GoGOg6lZIxOfK/ibv453/Hs8IGqBA3gZ0HUSi+BlMm7XgF
         GKhGF3Vfc3NxkKxpB+xGLnveaSu0IQdVo8Ts2DshnI374vRqdXFM393+kbNMuuoAK7C4
         gRWuLW3eJ52qffxKlyJ9dhPwUfqMiGUifFYB1edyFIRdSNQDBEgI+j28C8n8Mjtp5vfQ
         1WEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626303; x=1742231103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8u7m4f90z4ywcN2Oo3EiIsdxXzNCHdgpNAW3hDLWX8=;
        b=Mv83kJVpTIA+uPCD08zKhbVBzKOWomrizc0dDjYke89qnYAcLFfm/3YKHmGq/K5PZk
         a5RScTxCRmzTLWyL8aqR86lKMjgLj99tOCbAF9woz2sJIWl20R68AkM6I4wxVsk+3+mi
         tylDwuNAhLYoKqAEe/Tpp8OYIf+/RnIRV6ei3w5nNL2yejh3Y/Vnooa3NH5y70PjP707
         H6dtct6kObj0D1nuU2ZzV0+UFDZ0Aj/z45TahpM+nqFRs1sBK+cUEpFIijxTaufVfX/6
         7yNeJ7BNAqcst/V7miAYyQEtWoxTLGThiUOrZPxNEY152iL3Jo8iVYYUy9Owc7SytDF0
         EubA==
X-Forwarded-Encrypted: i=1; AJvYcCVsgF+mAEtvTWQYUlKVD+7DMOzYhBDKq38a9QOCCtOJ1obbJhUtntvaTwBQTo+qQOMXTfXalc6T@vger.kernel.org
X-Gm-Message-State: AOJu0YzvuPfDa9wWwN1zsQrfXp/3KuarrSyClbu6m2eR6QvJhxRsujXh
	jVng6BDtD1m9/vQfpjMoWGoc4urHPSQwp1OvjtWauNk2S8uz/ogzVlLbLNLXICQ=
X-Gm-Gg: ASbGncvQozbxoHw2/9gRpn0LX606+bjOzHunglEqM7fFKBgmMecJGPyOYXWsKpPyhLR
	C23Tinz/1JEOqlH3SNUz+rH75IiAH0SKf18iW5riWx01z40GpPoFNWEARaFMOyvfk4zxv+ML9pS
	AGICG2kGJe+E3jF4zYIztimmVpYFkoLt6ASTg632ARLyAizr1EZmKbqd6JKgMLEOPTEdQEIWzGp
	HaaRucueba5Lkk4hLsWBcL2FcmpHD8hRaeKcTYu+TTQSQmUNJ3+kXHezSJzsvPb0nH7p/+L4PgV
	FYJBeGaZgruy/uva0+R7iv35tJ50fEcdzgoQ50zfy0ALVF8Kf9mHVD0dIQ==
X-Google-Smtp-Source: AGHT+IFlJVRZCEshYk7Wfa802nBla5K6NUqsThPUNNSFqpHEeriX8ZJPGcyYFslAHxGKJ1PxoTJywg==
X-Received: by 2002:a05:6000:1844:b0:391:8a3:d964 with SMTP id ffacd0b85a97d-39132da10e0mr10182161f8f.41.1741626302781;
        Mon, 10 Mar 2025 10:05:02 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba679sm15302514f8f.8.2025.03.10.10.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:05:02 -0700 (PDT)
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
Subject: [PATCH v2 05/10] sched: Skip non-root task_groups with disabled RT_GROUP_SCHED
Date: Mon, 10 Mar 2025 18:04:37 +0100
Message-ID: <20250310170442.504716-6-mkoutny@suse.com>
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


