Return-Path: <cgroups+bounces-6937-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0317A59BED
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 18:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393753A6588
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 17:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0D1231A21;
	Mon, 10 Mar 2025 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CGKgbvHD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0792230BE3
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626303; cv=none; b=sw3v5YF6pNCBeqSQFV0aOpQAAxfYrn0uM7NSNL8pAHMY8L7VLN1lwKxk4nlzgSKtANT5wm9hJyBEONBQQlG1zjf1Da9hNOtSyQ9kAC4lcta42PmqDAepTms7dP6ebSPB6xTY7wx7JlHPFHP6Rv9uzgJWWuOV7UvzBISWNwrHKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626303; c=relaxed/simple;
	bh=+0+OTGy/IlZfe8fbfVCeZWpUYt2alRVziCCdrmZbW30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4FyetNnYAKTljl4tHXM4sa3GQOK2+KAwTVhwLTKg2awj2DPwy2NLZmmUk5z6mVxeSpIDWqY9yqao/h2QXyem4XNNvLYod3E66Re8Y8qAllzCFlVMN4Hm+/KFjms//R1p/6Oy5Xw95IWTbyORxim7RDxq5a8gpANFWs69S3qlXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CGKgbvHD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-391342fc1f6so3429590f8f.1
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626299; x=1742231099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHPvs5h0lN5qcRjT7tnplrDlfrX3Yssy64qHxvPIi1w=;
        b=CGKgbvHDLtwNelWlORtqs7heroTZQ3euDihCM9jFyO+FbBQexw27qgwDEjGK43Paem
         BqSmrIiX3W4TwXqKj1xRuj9rfx7p4j8sTNAY3gmJXQXanbj3mUgJkHnK2RKGPKiX0NMZ
         PIq6WQ1STC1aObxmTUmbIGvnvnN6YhLTagCb3LEcrS/83F5UsRzZMemqjJFxDJLot+uB
         YvhANSQdQnp7sWfh03Ttwa7Ak4meoGeTqwtoiMSjewg7wJPBKP/WjR5OJGt2aQHFU9Cl
         MXd+wKuV4cyxXV7eQzzd8ruGqBZmNNb/w3B6ckMIPYbpGEITGGfBBcCjcQzljjRj4Y/d
         cfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626299; x=1742231099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHPvs5h0lN5qcRjT7tnplrDlfrX3Yssy64qHxvPIi1w=;
        b=AlbkjvdrSpEILo0sdYhD9c5a+vIsCJ44W4UWuY0ze4jGfCgUZZXSzFgxfUjAJQCnSl
         e8Myo77UtIg2va8w89K7dQO/PnRnAc3mHEyG8ZQThPCI2HTEFPZMnAseq2mUUR1ibhW8
         Bl6tQuYpXoy48/bh26lUR/FaZ3kGh94tvdzPSanbxpPF/cCxCR6pz5z9SV2AKqxP0/8r
         DK+odHVT7UutvKYddAcVAvzxwTB6gWCWqs2nYogEInGRkLRZWQhDY3ycGpQ8bV8AOy8v
         doO9TtrDO/YiruF0ISPlfUa4ug7IIfiby6bFyOINP09O4uiLzR42Cwjz1lPd4TzkHvBv
         8uyg==
X-Forwarded-Encrypted: i=1; AJvYcCVPZmkk4RqDy33KBExPKB8TfpbmV092UdfkZ/e3neai+DekxJJKiprEBRaTbseKnC2JWD6/OMjV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1DU9MCc1DOhvHH53B9Wd/ge54XcxmnAuT5hgChEndd42bFYq1
	l1rpFEM+038OWTJ6qxmmICcqd/qE34SfYTrRKnJQObbL6c8CJ1x6a/ntoGpvukI=
X-Gm-Gg: ASbGnctT3jjDD/3PgaYYIvgXk6c8QFByq68jNeg+Odd/lPbDT0okm0nCCTcrgeZ20nE
	YdTMnqX0Xp8ykuX23eZEvKnDGCY3iTLFH1Kd5mf+iFWVeY+I5oyM++9nOaT5vVyoUjpJcxY+6+B
	9CHhArHL9wRqpiRhEwUhoeaJj6pNKPbK4vOE0RrePQnkgihcPfIVqomBN8kkqVrJTSDA3Lcv6Un
	1XM+T6DzQeog9/pp1x/qkSndl1DxbJBY4lZwwaY7AaE1/fPDf+k33KjI8ZNDNB/i9LcJtG6ezgE
	V3rX60AHp4GRHY4xrfgmfYlS9ybfHb8txcVBLOtaMOpTg38=
X-Google-Smtp-Source: AGHT+IGnxbvs9WEx8x5gm1cwMA4+m7u6Ms6T87jBBqilNBg1H0VQGarcoEnIF4+qTK0yxBRtSopgfA==
X-Received: by 2002:adf:b35e:0:b0:391:37e0:d40f with SMTP id ffacd0b85a97d-39137e0d59cmr5713195f8f.17.1741626299204;
        Mon, 10 Mar 2025 10:04:59 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba679sm15302514f8f.8.2025.03.10.10.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:04:58 -0700 (PDT)
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
Subject: [PATCH v2 01/10] sched: Convert CONFIG_RT_GROUP_SCHED macros to code conditions
Date: Mon, 10 Mar 2025 18:04:33 +0100
Message-ID: <20250310170442.504716-2-mkoutny@suse.com>
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

Convert the blocks guarded by macros to regular code so that the RT
group code gets more compile validation. Reasoning is in
Documentation/process/coding-style.rst 21) Conditional Compilation.
With that, no functional change is expected.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/rt.c       | 10 ++++------
 kernel/sched/syscalls.c |  2 +-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b12..3116745be304b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1068,13 +1068,12 @@ inc_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
 {
 	struct rq *rq = rq_of_rt_rq(rt_rq);
 
-#ifdef CONFIG_RT_GROUP_SCHED
 	/*
 	 * Change rq's cpupri only if rt_rq is the top queue.
 	 */
-	if (&rq->rt != rt_rq)
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && &rq->rt != rt_rq)
 		return;
-#endif
+
 	if (rq->online && prio < prev_prio)
 		cpupri_set(&rq->rd->cpupri, rq->cpu, prio);
 }
@@ -1084,13 +1083,12 @@ dec_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
 {
 	struct rq *rq = rq_of_rt_rq(rt_rq);
 
-#ifdef CONFIG_RT_GROUP_SCHED
 	/*
 	 * Change rq's cpupri only if rt_rq is the top queue.
 	 */
-	if (&rq->rt != rt_rq)
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && &rq->rt != rt_rq)
 		return;
-#endif
+
 	if (rq->online && rt_rq->highest_prio.curr != prev_prio)
 		cpupri_set(&rq->rd->cpupri, rq->cpu, rt_rq->highest_prio.curr);
 }
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 456d339be98fb..8629a87628ebf 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -640,7 +640,7 @@ int __sched_setscheduler(struct task_struct *p,
 			retval = -EPERM;
 			goto unlock;
 		}
-#endif
+#endif /* CONFIG_RT_GROUP_SCHED */
 #ifdef CONFIG_SMP
 		if (dl_bandwidth_enabled() && dl_policy(policy) &&
 				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
-- 
2.48.1


