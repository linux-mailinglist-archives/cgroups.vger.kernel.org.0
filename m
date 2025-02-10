Return-Path: <cgroups+bounces-6478-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5E1A2F10F
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 16:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11651885497
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5FF2397A4;
	Mon, 10 Feb 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O+vU7twm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84432204866
	for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200380; cv=none; b=ob2Bw0tOySRPKBkJyZPkojXBtXXthSIBjiI9y+mCP9tKIbw7cSsGgToH8W1+wIe6FtU6AhWXBbSI8OWuC0ALa0LhQVQwwjXzaf/PYE4l6KoiiT2Rt54jriH/ZKTCAUP6aTwo6DkmXIOG2aBtR+LkNqILkM7LkypDPfh5BlgykgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200380; c=relaxed/simple;
	bh=xj17MFlJulz5p0jdPBcalKowBvoJHFJ9677WrwPHzAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbsMBeJ/f8aDSB9BojKdL64/hg4/34CnVVPm3h8NUk7hkY3WaWgBpSX9MvzyC9yAn9OHHFYRx18eqgRwWdM4xaLBP7aoL99acFJRhRr/8OgL4lHzml2wDq6rby7p+xjuv8MP9JR/fiLkPGHhucbB0wgD0IrwrBdUmmRaOxR3++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O+vU7twm; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de6ff9643fso2777569a12.3
        for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 07:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739200377; x=1739805177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=friAMnSjLY0+SGaIxPPMR2wFL3NaVBwarbQhTRSR7xY=;
        b=O+vU7twmNJ0IUZ6ed++VpYIoENxMTlmNYdzPZ6i0zkQpPir7iFBwyfJIndN3L2H/mb
         r6B9f6p3CVSi6aCed+h59QxurfNyrT0QoMCI+ksSHI9QzJXz++nIl2QtujYwQVFLHfVb
         fwWrHpZeclvF2arj/9xIPHR/CLSnvV+qmSD3J4ANjVB2orciGly2HhXmquADDHfrrBQ/
         gpExhRX7wRDkt2BDgIXaqLy60afi4vJ5UtnI5M0VG0ylZ/bJXB+e8Hge0PsWo0X3gZSm
         1AM63z2zkxGKxx4mFSmCab0qUa7BJoipAmQ5rCjYd2PD8gRVyr/pU9WO+RHW0zlr1KvW
         Qdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200377; x=1739805177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=friAMnSjLY0+SGaIxPPMR2wFL3NaVBwarbQhTRSR7xY=;
        b=IuHTtSVtQnZRxw16bssFiwBT/apgtiiBmNkAojua2v4bmDp+chf5iJIqZoW2OhhYDP
         cBD56SU3eA/zTORYVjoHWGKGbejITvOxpn9O8F8qRsat9VJGL+wbbAeBR55117goqf8f
         ESL0D5jltvy3coXWHzghWxr1aGkOb7nZa0ySoZ4MaT1Qzr9UriGGowj+hINvoOa0AChz
         ouul77D1avnZkFlkg09XtgiUqQm6IPSHxW6PDeFZxCGcN5MV2Siaroe/JiP0VCEcQrFe
         ycMQQaF4bHc/S5w46TJommRv0wF44LtVYH60dp7D66kH4zMDqSpLZPWeNkMbTjWSfntw
         fKGw==
X-Gm-Message-State: AOJu0YwTf7wfDKzbSPpuAlBk3oNSqXxj+6bMw+8S2zdTxt//q+E0JCcM
	V64YLDAljY6P+oWzcI4P7Mnrr9W9HukrS201D0PXMRgxZ6w/GwtzkhWvnz06EI72fv5Fxfx4XwD
	v
X-Gm-Gg: ASbGncu1DjXDUPdQjU2g810HXXfQxnCABfRY70aidIw08h5UPg/bKImCYm+3TOSkgeh
	QSdWAOE0kOQ3W8rON8RxecJm+CL618aana2uPnZQ/pUhsvXwmSY8qlQEtdrLRTXaWzFbjSoa/l4
	4XYhwbsfSpuNoaYjeUnCPaTMTRbuqTyyFnUzVji8VXI3b/9IzhkwKYgmryiQrikPbyJBBOsUHKv
	pc732xsnrCoVHZx8829wHMoaAM7681ikrKFs/b/2aLlHoH0bdsjaz4sxfDrHWNtVEOfLVol1aow
	mQq1wf9GACiyu3Pslw==
X-Google-Smtp-Source: AGHT+IG/vCz02gYL/LIB5SscWC32zJnOpctVQAJXvp5QEx6eAgb2yHXEDLpqT66quaqHwD+vieK5PA==
X-Received: by 2002:a17:907:d01:b0:ab6:d59b:614d with SMTP id a640c23a62f3a-ab789b395a1mr1619973666b.23.1739200376665;
        Mon, 10 Feb 2025 07:12:56 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773339e82sm895192866b.143.2025.02.10.07.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:12:56 -0800 (PST)
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
Subject: [PATCH 3/9] sched: Always initialize rt_rq's task_group
Date: Mon, 10 Feb 2025 16:12:33 +0100
Message-ID: <20250210151239.50055-4-mkoutny@suse.com>
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
index 17b1fd0bac1d9..dabb26b438e88 100644
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
index 38e0e323dda26..4453e79ff65a3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -827,6 +827,8 @@ struct rt_rq {
 	unsigned int		rt_nr_boosted;
 
 	struct rq		*rq;
+#endif
+#ifdef CONFIG_CGROUP_SCHED
 	struct task_group	*tg;
 #endif
 };
-- 
2.48.1


