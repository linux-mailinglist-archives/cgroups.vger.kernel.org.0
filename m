Return-Path: <cgroups+bounces-5921-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 186EF9F3A92
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 21:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DA616B8F6
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 20:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312C1D5AB2;
	Mon, 16 Dec 2024 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GFS9j/hU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EEF1D434F
	for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379999; cv=none; b=tLhmTsKmTTkk4R0PlOfKILjFIBoSb2b4bo6D8DfXbUal+JoDqP9F3Do1BLT0zuVPM+7ODl0MM1uI48w4JRzYl/xfXyKdbs+6ntN/mMXEfbghBqxJbCfZXEQCd7PYdUxHXgi7K6Y54RFpungnnMSQAVRmpGk75Rr1Ud5QxczhaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379999; c=relaxed/simple;
	bh=RYk23+XCY5BrG85isbX7d7sB012sPIA2IgncWgxuiqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4w7pax4Z4wRKc15rcAgGfqoMFxHfTMUGsxyaZLcoBhT50cfqUhD9skGo64aTe68Ez7tBwdg8lqMbIG9RCnA9sW/txXP0jtj0yaFX3xxoEDEIFbHJ5s/AOfQ8xtqkLF130fVYi3VoyjJXnZrGS3DlC0x2jp5agBxU+RiOf+z3Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GFS9j/hU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436281c8a38so29761815e9.3
        for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 12:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734379995; x=1734984795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWohpvsaidJAImWnCCb6nIgTAJEp6TGh7j1uXezpKLk=;
        b=GFS9j/hUxZi7Nts6eGzuXbKr+jHXI/SNhfH5FkHHdePGaYX0hcwH5QGIlcAK7jNe7b
         I0chkwGBOiqx/JKMEEUIP5oNweEhKPXF1K0JceG8GcS5wj1PIDHUKTRaYZf7VSZMs523
         LQRJcs8aCSjR7MK0Nau2gnzqc6AEZMT2StQrXWaTOymXQf43RfZB/jTF0ywQkJASRLx7
         tOuAEHkrziM8JqN7cC/r9fJAdxZ1K4HP9bV5MuTQJV1Q1fWxfdseOSbG+ybaiGIqXfAu
         5tJSPTTXhF8JW2tKGfQ08nPpgLy+DeUc+/7C+suQF6LnCi30fWKVWv6BTRYPFZxjeshG
         qt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379995; x=1734984795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWohpvsaidJAImWnCCb6nIgTAJEp6TGh7j1uXezpKLk=;
        b=r8yfspeF9gqljYsT5plfHEj0rLVRJ+s1xaep2E/ktpWtbYIWdbCjap8/lLEcGLbNg0
         GadcSz4rC6MzZ0/xbofEienQ6lsH73OP3aR9a8pa3BMLs3qxWAUkWuqYC24YeS3jxfND
         AgYAhDX2Hz14W3Ir+H9YHg4lrxwBf/iFXQ93MXPsb2CWJSUpNwtlJ3CsU0WWpbrzsJGV
         T+00bYDpBMgnUI9M+rBIRyMAMaT8wVY+Yf1nqloG8glwjZGdSDb6GhhgJG1KFL79ebgf
         wiT74eVDysmttkBLXFHKWV+A4jTp7ZZdJTQ9dlakUHz81o7b0o8U4c/zlmj9z5AWQtIg
         voCg==
X-Gm-Message-State: AOJu0YyTUrBeZuuZYvyS/xkWrDT4sk6HbEtMCqXoTNF81zzn/qx7HPII
	VCkbE3tv+G6xi45LmWVDv2xWpE66HGCaZvqbXXxf3/IbGg8kwzYMo7KWIuksKW+2ljKFpvoRcyy
	r
X-Gm-Gg: ASbGncu5vmE4ZmU4HVZSe1sThkDrXLSMXXKX90OkUdUIyXntCwtjHxoCM9RdwtG6HlC
	L84gqj9K8Zzg/XA4qUEZIZPaJyXM+t5BxlR3eeMyPivzag8+url1oLWUveW+XfLZ6Qj2LusvXi4
	s6Yn38SqAeIlr62ziRfgW1oXG6yduDW3RqVzX5fRYfhzK6uH8vyyVoVyQs+/r4PjzpNFa16r9cp
	+FlEIDAegOu4QPWbed2DHAbVL0wvwujDYbqUxKgcaET/NR/AMsbY1TZxA==
X-Google-Smtp-Source: AGHT+IHJNXDQlYkb8clBBC3f+NAsF9zFsTHuTzAExcEQsQ+x/QllJKlwA0cXeJSh82Dvjt73cqZ58g==
X-Received: by 2002:a05:600c:1c1c:b0:434:f953:eed with SMTP id 5b1f17b1804b1-4362aab0ec4mr135894205e9.30.1734379994894;
        Mon, 16 Dec 2024 12:13:14 -0800 (PST)
Received: from blackbook2.suse.cz ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm473715e9.0.2024.12.16.12.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:13:14 -0800 (PST)
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
Subject: [RFC PATCH 3/9] sched: Always initialize rt_rq's task_group
Date: Mon, 16 Dec 2024 21:12:59 +0100
Message-ID: <20241216201305.19761-4-mkoutny@suse.com>
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

rt_rq->tg may be NULL which denotes the root task_group.
Store the pointer to root_task_group directly so that callers may use
rt_rq->tg homogenously.

root_task_group exists always with CONFIG_CGROUPS_SCHED,
CONFIG_RT_GROUP_SCHED depends on that.

This changes root level rt_rq's default limit from infinity to the
value of (originally) global RT throttling.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/rt.c    | 7 ++-----
 kernel/sched/sched.h | 2 ++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1940301c40f7d..41fed8865cb09 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -89,6 +89,7 @@ void init_rt_rq(struct rt_rq *rt_rq)
 	rt_rq->rt_throttled = 0;
 	rt_rq->rt_runtime = 0;
 	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
+	rt_rq->tg = &root_task_group;
 #endif
 }
 
@@ -484,9 +485,6 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
 
 static inline u64 sched_rt_runtime(struct rt_rq *rt_rq)
 {
-	if (!rt_rq->tg)
-		return RUNTIME_INF;
-
 	return rt_rq->rt_runtime;
 }
 
@@ -1156,8 +1154,7 @@ inc_rt_group(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 	if (rt_se_boosted(rt_se))
 		rt_rq->rt_nr_boosted++;
 
-	if (rt_rq->tg)
-		start_rt_bandwidth(&rt_rq->tg->rt_bandwidth);
+	start_rt_bandwidth(&rt_rq->tg->rt_bandwidth);
 }
 
 static void
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 76f5f53a645fc..38325bd32a0e0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -820,6 +820,8 @@ struct rt_rq {
 	unsigned int		rt_nr_boosted;
 
 	struct rq		*rq;
+#endif
+#ifdef CONFIG_CGROUP_SCHED
 	struct task_group	*tg;
 #endif
 };
-- 
2.47.1


