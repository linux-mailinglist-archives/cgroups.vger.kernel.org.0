Return-Path: <cgroups+bounces-6485-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56728A2F122
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 16:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A7A18844AE
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 15:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C84323FC7F;
	Mon, 10 Feb 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OFy4zNEF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952A123C38C
	for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200383; cv=none; b=fFLS8JfUSJ92CRBCCNRt/MPGU3rBeXbP8gA9+vHH/QRssg1Op5aT54usxSNlPxERsuMXCMNmizPks0eoGphyjG02eU8TSv5jKRG2dqO8ESmgv5UQ60DPLUtvGsj+YyBp/Ti7qxZyMtHBUV+81BSl6KHS+xlIK1GhPYzC1+ZKW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200383; c=relaxed/simple;
	bh=pi9xguxgmi8jgveuQ3APRb4E+MjxkvqvRH3D05xwEJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9skMaBI//V6MlBTDB1VXrkH3Z15ZVvtna7FurFqRPdQ5X7MKHcePLVWqykXDL6eqGX53OikkmtrSisHFEzLg5gHnyhEGTUUovgSheMA9j7R/aSkyyKgfTYbxgwgX8Aw3wQaOmzUrq2PI2QHWvh/APDUZ4brvtLuzYvpJUYXBlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OFy4zNEF; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab78bcb4b19so561150066b.2
        for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 07:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739200380; x=1739805180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsKAVR4VpZ3o1CX3CIQeDuMn525H6M2KaGLkBcm6fQw=;
        b=OFy4zNEFZ6VIRIJ2HT3Qijood/Mh9pogOcbwjJKnLdIyFOYNbgJVnmrUuNYS2k0elb
         4RzZ9ADZBjfxcQ5EN4yi5BbAtAk5QNjkaDwuXYFF+HL+wBWSgICbq+fnoCWA3Bn8Xx/I
         jl3Vb0pX8TefGc2Zwb/wrtuD9MLJ5jPCO8WIG8WrF3i6J7iPcMyFFl0csJHC3052DtYh
         kJvdaCh32IGDwtCgu6d58YoDF62eZFn6UPKtgM4SN2dWRGcxBTjGD2lVXwv8bUPHdfoZ
         22jJS1hkO6MqXJoBx1LHgFKSBQZ/masyvOYEiL/6rIyBhEZeoK82o8t37N0bmKhJSI3Q
         fTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200380; x=1739805180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsKAVR4VpZ3o1CX3CIQeDuMn525H6M2KaGLkBcm6fQw=;
        b=G3hG0U0Wx71W3sBXF/A3im/eCVSA1BDj+rbhl50kXrlaxlWZD136QRbmXOCsM0cqqL
         /2uThyHJS8ufsfL8EsB0jJ1LeI6kd0n0SIYd1xpm2lcWDi4EmG+Sw74aWCgq1WrUH7aX
         lzXxIIc4a6hv+cScyYefJxkoOz83n8aDQWlicwKMdB65eRIJwFvNhdbs2gCJMCBhBCOD
         s1jqlwgSwUbuo9K0JQvstKGTmp+T1luNugCrshWYgT/n9u0UWfUF9uDZpAdRS/NVJJN2
         GmaqzDY0yHx1rgkodAjvZ9hpkAcRHg/FoPHhxGeDmaQk34r8aNY2NOieug5ikvWk6XlG
         wKvA==
X-Gm-Message-State: AOJu0YxBHsn3MBivy2Vbzh21UczC/bfMbAh1IU6eniqVLDrxCB9a04/j
	KQdwpotHxHZjVU+/NpwC+kh2/5UlEa1LNzspW5dRqEbHyLOmmvZJU7K36kBTINHN3dAsjzTEfgA
	F
X-Gm-Gg: ASbGncv7bpWlwxef6bFivLvENuvqacH5dfE2Q+HWjt8M27JYjd3cbi2zy2tlbGKSXWu
	tYfF+WHV+WykTa67W8T2FgIuhLqWSX8WqWPM52JsljYIIaPF/gbhC7DalsO4Rg3+CgQpo9bpysd
	LYv0RYvD8wOjEa8yBsqP6dQG1WAmGSI/apT/28idTWvQ5XPxjPATqp0JWJ1xwWF27NQbrlrySaT
	Y2F5nQnyiAyxNmv0nv749Db5/u99mQDE/hjK3EPS8Wzq+M7r1D+7uIixgHwRLRad4hLmBfPhIj4
	A/YXjZoEf5Ecye1Wxg==
X-Google-Smtp-Source: AGHT+IHT6NnKwYsI6TprB2iMRHM/h1jJUEiVDEKn7peT9uyPdC0s/d7xz0F+2KsYIHFQId6TRqa5Nw==
X-Received: by 2002:a17:907:360c:b0:ab7:63fa:e4a8 with SMTP id a640c23a62f3a-ab7897b37ffmr1256700366b.0.1739200379887;
        Mon, 10 Feb 2025 07:12:59 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773339e82sm895192866b.143.2025.02.10.07.12.59
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
Subject: [PATCH 8/9] sched: Add RT_GROUP WARN checks for non-root task_groups
Date: Mon, 10 Feb 2025 16:12:38 +0100
Message-ID: <20250210151239.50055-9-mkoutny@suse.com>
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

With CONFIG_RT_GROUP_SCHED but runtime disabling of RT_GROUPs we expect
the existence of the root task_group only and all rt_sched_entity'ies
should be queued on root's rt_rq.

If we get a non-root RT_GROUP something went wrong.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/rt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1633b49b2ce26..d0acfc112d68e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -178,11 +178,14 @@ static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 
 static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
 {
+	/* Cannot fold with non-CONFIG_RT_GROUP_SCHED version, layout */
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
 	return rt_rq->rq;
 }
 
 static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
 {
+	WARN_ON(!rt_group_sched_enabled() && rt_se->rt_rq->tg != &root_task_group);
 	return rt_se->rt_rq;
 }
 
@@ -190,6 +193,7 @@ static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
 {
 	struct rt_rq *rt_rq = rt_se->rt_rq;
 
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
 	return rt_rq->rq;
 }
 
@@ -506,8 +510,10 @@ typedef struct task_group *rt_rq_iter_t;
 
 static inline struct task_group *next_task_group(struct task_group *tg)
 {
-	if (!rt_group_sched_enabled())
+	if (!rt_group_sched_enabled()) {
+		WARN_ON(tg != &root_task_group);
 		return NULL;
+	}
 
 	do {
 		tg = list_entry_rcu(tg->list.next,
@@ -2609,8 +2615,9 @@ static int task_is_throttled_rt(struct task_struct *p, int cpu)
 {
 	struct rt_rq *rt_rq;
 
-#ifdef CONFIG_RT_GROUP_SCHED
+#ifdef CONFIG_RT_GROUP_SCHED // XXX maybe add task_rt_rq(), see also sched_rt_period_rt_rq
 	rt_rq = task_group(p)->rt_rq[cpu];
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
 #else
 	rt_rq = &cpu_rq(cpu)->rt;
 #endif
@@ -2720,6 +2727,9 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 	    tg->rt_bandwidth.rt_runtime && tg_has_rt_tasks(tg))
 		return -EBUSY;
 
+	if (WARN_ON(!rt_group_sched_enabled() && tg != &root_task_group))
+		return -EBUSY;
+
 	total = to_ratio(period, runtime);
 
 	/*
-- 
2.48.1


