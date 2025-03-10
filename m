Return-Path: <cgroups+bounces-6944-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92379A59BFA
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 18:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A3A165B2B
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D2B2356AB;
	Mon, 10 Mar 2025 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dxIVChwA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1840230BC0
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626309; cv=none; b=DbJpeTqTs8j698YQAC6eEws30q021O9IkUIZEYiFdV0w2Tt9QiobJK9CUpaANlC8KVOsqSR1v7vLZLP0pe6/1Nf81iyhGzFdybGi/a3pVdrioA7oqUGCvpzA9zXtAwg1k3p/YwSJQ10wbWDgRPrRxfdDIJ5jjHZtlXXZ66GdBb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626309; c=relaxed/simple;
	bh=pi9xguxgmi8jgveuQ3APRb4E+MjxkvqvRH3D05xwEJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ps16mUJ26X9C9YlogBRjuo2AfoRSY9qjWOVF2xCni1xliigjYdJ3JKXT+wPPuw93x3VVGj4jyk8DKJn3LY6BqIEJOplAY5K6L6rz3AGSNcfpQPKTo3zlW8n59HytpsKCHiQNk3llpjXDPE5bzkQSJMFuSotWgYoh1ioOkAjTlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dxIVChwA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so898079f8f.2
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626305; x=1742231105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsKAVR4VpZ3o1CX3CIQeDuMn525H6M2KaGLkBcm6fQw=;
        b=dxIVChwA/2syr/8ilj++nasP4V4aXzh7NCrLJRcYok8/CUZmTaE+SrbnsgoWNdGfXP
         dH/xyOk2NcvgJMSeER6zW83wcl+azl9p7xM1kETbuhdolAZswcGfZEoO9H79APZTa+wW
         hH2wkkXFtWcElW8x/xWp3Yl3nWEG/zq6/FdJ8JRkS+0mfjBT7AwMLNmrPtez29MUSsy+
         lk89I1UeY6ybX5tecnMKYR4A7q4cfjxmOw3CJARjRckmZIECx98d9QZevds3Yy7zjcUd
         JOEnFK566Q135/ub9q8lsmZmrz+dF3noOPm2kTQ8tspC4V/e7pFBUNlhGHQlF7o31enm
         GQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626305; x=1742231105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsKAVR4VpZ3o1CX3CIQeDuMn525H6M2KaGLkBcm6fQw=;
        b=w08SyH3qNLRRjH7nMQr+y+2429WTx5N17AoaeUShXJsEllyXSgP8Wgmnw1zfsyxqGH
         zUD0DXOWyChcY6XXiuGUb9WlIPJTSBHygDxAZL3thbQa9EsylLhhdvsFSD9bH9n5ReLN
         rzdQTG2yE1qx16Hbl6XntJbrm6FohodUpa4wCuRPsY7SQc7QZjvCG8+lcml31GaOQfSv
         74Hfa6WAXCGvrVR2tjgbtCDo48benkELE8+fIjLaiwHjEWsr03vFizKyM3NcPmUdGAo8
         EigDxfn4kzVGcqzY9O6ibQAbRfIIIFQYEbVLoqWLCJXOOqBFqIGvhY1X0x0ztdX88dJR
         RJEw==
X-Forwarded-Encrypted: i=1; AJvYcCVgx9SX3Vk2LrhFBaKEWIb2N72XqJn0PNfl0KMI0O0XxhcuNhUZrbcmxg+3GlGTLv6cxt+GdHEy@vger.kernel.org
X-Gm-Message-State: AOJu0Yym2T8F+uPuoWX70imvm1X/jx6/mGNdeMIa3nCwOhhetz5wQPFB
	mBinJhOlX3eR7xHpWaZH7Lo0h5g2pVD1oTO38SemNEu/iPsgIvH9Pc+j4uBbyl4=
X-Gm-Gg: ASbGncuZGm6yNFdqzxB1NMtsNKkLr9gGM+j2/d7hZNtYqwNOvqo2pejDOsgBUiinbVG
	udFbOK1ajCmdFT1/W3WdPgI6ZP8TqyzkVvKCiEZ6O71azHTLHR8wWxrZyb5eZ0OoS14DZZUrnbG
	LwLW16MEw+UG1XZp3iuPg5RH+Jbdb6NjdyXWqdbaGlK78WDnOFDq0CER9A4WVRjtnGvxH6dkdx4
	w1LbXJve9U/tWNZcF4LtT4UQtAkbD35mgkV/M0+6P+RY5VKm9jOkwj0mmL/zC4RVXAGSnle1dDM
	kzVlyCEwPJ9H5LUdPNN269kfhHUezsPgfMGv2ANzHGSZYUQ=
X-Google-Smtp-Source: AGHT+IEjcwJt33XK0+9oNBWYafwW/xgXhi9ZySNjt6XnxyxR7xOz/zzPFrVCVP5U0+zTQKRhB11BqQ==
X-Received: by 2002:a5d:47c1:0:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-39132d2ac45mr8673374f8f.1.1741626305012;
        Mon, 10 Mar 2025 10:05:05 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba679sm15302514f8f.8.2025.03.10.10.05.04
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
Subject: [PATCH v2 08/10] sched: Add RT_GROUP WARN checks for non-root task_groups
Date: Mon, 10 Mar 2025 18:04:40 +0100
Message-ID: <20250310170442.504716-9-mkoutny@suse.com>
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


