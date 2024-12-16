Return-Path: <cgroups+bounces-5919-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D509F3A8D
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 21:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5110C188742F
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 20:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBDD1D2B34;
	Mon, 16 Dec 2024 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UX1LNf8e"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF61CF7AF
	for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379997; cv=none; b=uJdkdeA2X53xdiimJnx/EWg2/7+HEtvxraYHrqu/wt0Muc3tOUgqAMeZ7k79D5fjJDmUdCRVPkf1gxvlHz++LwBgzRa41Seox83EBmBzA7N3I2Gzh3r3CddYu0qt03S8yzFRp5U1XywdZeuAVQIO3yYgON2jpFn5JwbNBAf1QOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379997; c=relaxed/simple;
	bh=sBbcW+mFe9y8oA+JwKVNSCOVQeN+nDtYYa9zn14EvWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtxALwPQaZrAWBn0MoZo6r1noVR4gk240JTYRgOvGWH+UOCvV+0AqIbpro176lhIJMUkp/0I5cnL7CyXS9Jz2zWO+r9XN8p+rTT3SjvNauEccGddjZk6IqPnBLdjV8l0youjbcBETJy6L+UdbNQJzSMzsI4+u5JsvOoAA4hTgRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UX1LNf8e; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361f796586so51085035e9.3
        for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 12:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734379993; x=1734984793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAD9QQaJMjOoF8GYY259h6abZLmkhVQBDuUpRGuLzv4=;
        b=UX1LNf8eP2kPtb4TQ0sWPhR7w3bUqt4ThglInQTVwxcDktG2PQ5bTZYctNMaSZatLN
         jcv2aemSOYSP/1FfCUsCvF8evb7z4WAKfgADxduthw/iP5rbqJ16h6G5z8bAdledFfEK
         KlWZUeeiTN8beWBCo3jOiBINwDywOAjMU8fzO7u7InY0CkQFBmpr2ZzLq3QbF9Jr2FAT
         OZCod5/2JJLOaUuMUGSY8wxmzXlxuNwD2j9jyOJx3pejEXBKEKE3R3+77xXBIxQcBUuv
         LA6aG5CJYmaABrviSnmXwIEsGbKxSYGrG3TYnJ61SbbvUl5Fb2dQIqiLoJ5mgCpKk2t2
         NGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379993; x=1734984793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAD9QQaJMjOoF8GYY259h6abZLmkhVQBDuUpRGuLzv4=;
        b=Je6+coJ+quAYm6VDI1TI96NLv0oKwnF6n9HJbzDQUsRv3fXu8+WDu7SrCg253notep
         Vy1Nt51ftq8suEul/otRDp/5Lo7Y+JsrLSWBPb7J7PHkm1LJDijuJh3NTFq79QWQbHu/
         Zz6z/E4hiqtWfQG6qlrQ1nArz8khZceXPEHx6jZglAA5OIXnlMuv+mJDrG6o/sBxx/PS
         nxoI4GYCsjzI8oawv12cBvnLKwaeogJbGBFHOFKYjtCdzVBE4UMObLulB3iPPbEBhkkF
         GoschbNvEYDjFk1loxtLTCTthYG0KMFz5oE7BrFJHo+yEe8EDjwTQ89ZOrF+xWM2lVn8
         Zy1Q==
X-Gm-Message-State: AOJu0Yy+p85q3e7oISn3WhhI5/229SFtd2RW1K+pbM9O6jD1W32X+eST
	Y5bIYpXncmZ878ewodH62TV7do6qsSBs9A5cZmS7tgWg7b3jVgqWtyZWq4yynnfJYktjPomNh0H
	D
X-Gm-Gg: ASbGncsdhy0I2y+KU/bHgYXclex5yryZSpI19U6cXQ9vUh8ngdAqe/SVCUen5UT6Zas
	/qXCJTKpWx1hz6QFYgnRx/M8fqAsiyPOsJOkZAnr/TClavfTAEjGsyjUK/ZykT670xBgCcUtwaS
	mz7zIvTnjkWog7KFjUtDX7+C9MWLNeFOuyP4jnLCK5+mz+oaJz3GffCvDXLivlAYjeyrAbOv26m
	YQNgza7DPlI1kIgZ86SW4rgVspD0D73sSDeAJTGxX4w0BMIFIoPFRmgUg==
X-Google-Smtp-Source: AGHT+IFMZaawvgQ0mmiXQ+XIost4nkLrH59oXQYTws/XE+0Hed0N6s2bXCIdJJdDop0UM3Vco0N0aw==
X-Received: by 2002:a05:600c:468b:b0:434:a706:c0fb with SMTP id 5b1f17b1804b1-4362aa369ffmr164608895e9.10.1734379993276;
        Mon, 16 Dec 2024 12:13:13 -0800 (PST)
Received: from blackbook2.suse.cz ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm473715e9.0.2024.12.16.12.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:13:13 -0800 (PST)
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
Subject: [RFC PATCH 1/9] sched: Convert CONFIG_RT_GROUP_SCHED macros to code conditions
Date: Mon, 16 Dec 2024 21:12:57 +0100
Message-ID: <20241216201305.19761-2-mkoutny@suse.com>
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
index bd66a46b06aca..6ea46c7219634 100644
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
index ff0e5ab4e37cb..77d0d4a2b68da 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -650,7 +650,7 @@ int __sched_setscheduler(struct task_struct *p,
 			retval = -EPERM;
 			goto unlock;
 		}
-#endif
+#endif /* CONFIG_RT_GROUP_SCHED */
 #ifdef CONFIG_SMP
 		if (dl_bandwidth_enabled() && dl_policy(policy) &&
 				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
-- 
2.47.1


