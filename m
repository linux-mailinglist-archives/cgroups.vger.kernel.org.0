Return-Path: <cgroups+bounces-6479-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C2FA2F110
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 16:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF027A2ABE
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 15:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAEB2397A0;
	Mon, 10 Feb 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bAWZkfOu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB22528E1
	for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200380; cv=none; b=u04iDy3EnBlUTMMzgXPtmU6j8zOPI2J/oxFTy+TyjXuDqvXZxBWgVxYbH6nclksZtvbvCeBxicDoKAqmYWS9kdM8bkEJujuFRJTtEmqjQ6cIoheWrPbaahMf4RRrwunttlmRm7Yo4CXaBMNEf61QQCsdP8c+AG2cVhO/edS/1pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200380; c=relaxed/simple;
	bh=+0+OTGy/IlZfe8fbfVCeZWpUYt2alRVziCCdrmZbW30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApLnQaW+6EVjq6yMAVMZW/orgiO/0QSrMetsqD+fIYoLEBF9aHyckvkO8HjrPKc88QKB7vi/n4N8zzYfooCVJV+zaOOPnPHMC3RqwnYmwA5NG+WVPyAQ/Sz1FQYb+r7MBDDYw2xQzPids8BGmFmjgmdQtIXWhUqt9gwHPrAs6N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bAWZkfOu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaec111762bso1086845666b.2
        for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 07:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739200375; x=1739805175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHPvs5h0lN5qcRjT7tnplrDlfrX3Yssy64qHxvPIi1w=;
        b=bAWZkfOuJYPgN8oSyv5kk9kNLMHhI2QytCT4UlwY0q/lc0OTtiUJGGtQ7vFGLw+THX
         IxUbUReEknQxZZsU4dWzhWqU3jQeVvYBm3vrQDuy+3ggPo4qH2sgFydZhrfNaRpv+EBt
         O/GIJVyUuLUp6+Abqnq9IAVbcQmBT21LVqj26jS0G1On1KR6lmPPgu1jQ+P1vEKoUd6x
         C1i120JGZl3m/iOeLSIg21i3i/ClRVCU6lHBpk97ym9TJOyRZp2w04C4X1pAuGjECl29
         lfCb5wUGYvQgi/wJboagn0jXOzOHa3pKJWyn9MCoOtTMrW5NsnmXqtFdbXpeJR4q3ZKY
         BMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200375; x=1739805175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHPvs5h0lN5qcRjT7tnplrDlfrX3Yssy64qHxvPIi1w=;
        b=frlGYnzZSxiaqLySs0WAgFJtHjPGLlfMXZOzov4ZYEGvuH9mnXVfZrpi5MZSggMfYj
         2aGu9bcIOxUaelnkDZv0vzerakX+OFQI6gUItgjmpE+5V3mCYVXs1p6nbHUd1lxtS+Ih
         I0NZ+Uj/zXO/n+wml8aJoOhJ9mg4tL0a9zFpcIidabj8RJSqhB0RQKLhzr2CMrTCcKf/
         j8nTwIp2JC5p452eCzEW0iyBRWGis0zRhxMvR6IQsrVTJE97aMNaAUgqM3WCPmV8RVMM
         b7k++b7YhznbjSDMURu6Xg+sHiFq1z/VwSDC/Nk99O72UlDaVpfxBlU6fha+rxIbeeOs
         fA6g==
X-Gm-Message-State: AOJu0YzAMramrrru3P6SLVJJdFWdevGeljnhwnP1Hp7qTWAxw5y1DPoL
	7OSRRCzacsDJXKLXIcVTMBDJe8F6CUkZGCZmemhwIXJZyyBah9MMTPOcIdtSoHcuvRYBwBsvqfX
	3
X-Gm-Gg: ASbGncvXMW5djvmcEzKuwplKA1j4Ut2JwYLBLvFSTRduKWFfq6Hj/QXym0y/gkrk50K
	Lo6soxL4gwRhRM6KrP7cF16W7u77d2fmyeVB6v/bmtUFk/lEO8dLB1K59A+2Tz4IgyELL82WM+y
	OWmGyRdSmgqSGGPVVTPsbt/Cds2P8a5ICEVRs5FKH/fi/6c34b4PPV3YxWsgX3MgRMXzJ2OBr9W
	Gv5ujaetoMfT4bM4Pg/C9EfBIr7e3lfroDklPLxwgDF2dIUrMEDqM3StY49afVQ11NimaUu3cSH
	/Cd3//H+Zbj3dT6sDQ==
X-Google-Smtp-Source: AGHT+IEqT2HqyEU97xbfdsBL84h2jKrpMtkd/2pq59J3hPZeDg9i4UwQ1Su0OfZqBDIMGK/V+nmmOw==
X-Received: by 2002:a17:907:748:b0:ab7:a39:db4 with SMTP id a640c23a62f3a-ab789cfaef4mr1355751566b.57.1739200375206;
        Mon, 10 Feb 2025 07:12:55 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773339e82sm895192866b.143.2025.02.10.07.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:12:54 -0800 (PST)
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
Subject: [PATCH 1/9] sched: Convert CONFIG_RT_GROUP_SCHED macros to code conditions
Date: Mon, 10 Feb 2025 16:12:31 +0100
Message-ID: <20250210151239.50055-2-mkoutny@suse.com>
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


