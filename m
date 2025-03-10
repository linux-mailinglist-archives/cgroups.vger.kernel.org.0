Return-Path: <cgroups+bounces-6939-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 258A5A59BF1
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 18:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C32AD7A3AAC
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 17:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F27A232376;
	Mon, 10 Mar 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PuJc+E8W"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD87230D3A
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626305; cv=none; b=oksW4e4YDftMjoSdeSEtrNHdu7MF8aoCBmJEHoobz5NWDVBMKIXxv7nPEthBnwSkcsITtNiH3VDiihr+xll6HYGuEEXdmKxTlribmhBkteqlLObi7kC6WEIPAO/AfZ/XF0RuigrqiXHnNKDqKKz3lWtBLzyni1WXX340B4rDKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626305; c=relaxed/simple;
	bh=xj17MFlJulz5p0jdPBcalKowBvoJHFJ9677WrwPHzAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeQ+AyJWDkda+y4w33I03xqSMNVaE0CosfuFYaY2rfI8w7j2nZ+7wY3SVCuguEfKirQ22gSw3LWbkj99SWyLxczkaEbirAXbaFki4+ZhQhNpumoEoxJKjBERs7AgzwryE7dbmC4SvfrGY04qh9/g9aOZ7iMQxzHBi7uJSp7cs+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PuJc+E8W; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3911748893aso2814822f8f.3
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626301; x=1742231101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=friAMnSjLY0+SGaIxPPMR2wFL3NaVBwarbQhTRSR7xY=;
        b=PuJc+E8WO4yuf+rBRsFIP0kbzTY/NgODnnaCFZ4qAIObzmcLV69aNSeU5HhqbJz5bX
         ALk2iIbOurCjtiqmIGc2XfRElkZPAY73NhFR52K1OhzVsn5mzuoSMzuDqwWl29xCJ5jI
         J4b4C04cgxorPSG93n5w3jQFNIKjESM5P9Oh4Z4S9UekCP3nQFLiRMJwDnAQlFacCyGH
         /rDA6JQ8dLjQ5bXgUGWGPZU7AZ+Dq3DXVRdharTb8SDI1DvAqWt8scu6VCEtpra1b0BK
         IwpQJmwqjwCc5AMDLTzQDevNE1xzp+Xj9On3EzBy08vAo1KNuta0IHbBr63LmDH1Rf+S
         f/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626301; x=1742231101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=friAMnSjLY0+SGaIxPPMR2wFL3NaVBwarbQhTRSR7xY=;
        b=kIljWI53Da4RJOiLQDscNdnNS2F97FB6wxmoor0XyIwV/OsXiyW1GZhy4Ha2Hy/mUE
         qzdefTrZ2nHrLBcGQO6vfO1IW2QSLjM9kfhH27LfNOpww2162NWMXMeE2qB1Pe3cAwwP
         MMwVpvSzDvYaCjjYTeBqId9RWgE0hDBfkf16xLOfKC4JWFtL/pbniS67Q67huvS08sHm
         dysLQfCGk18UXlHXNQdHLmn0EACPnyUZFjhBWgjQlQN2oOkR0ZT8yLOujvecj96v3y/3
         cj8itKawJZ3TerYSjKzPYKM3c9rPB2fMRLO44Pm/eygVA4z9IQhs7uMuzaiyIoJg4ESS
         iGcA==
X-Forwarded-Encrypted: i=1; AJvYcCVmxkhKLH3aDMdcLr9DyqI/N44Ecd42xJ6zBpkxBs/lw++ujPJgCPpy2DqHGw6mJLTYMAhjGEfu@vger.kernel.org
X-Gm-Message-State: AOJu0YzzXRw40QnCDzQNvOLVppWhSVmcxPyMt6KCFfJFrlLaxOk2MG3u
	5FD2jJej+UYQxMa5PxWXbwlhL08Y6LC30Lj7vWg9SjIMtaW4GisorvyU9D3C1Bg=
X-Gm-Gg: ASbGncuCtgLFGVLTaAkAE+Rg00XfdL58zHvyOFyJglNtxj9vWTQpkHlpG7Q+BBWmhHU
	93KIUlHYoNSGlsXW/+sqAz1hw2KR9jPLoCnAc+D3kO3lofWHdBEi4PmjE916lf6FDaNw8N0By0S
	hGLOTtS90n2t9TIoFPxQJfTGnXgbb10QRC2ZruggM+fhya12XM/N+dP3ltFwqmXMzuBcvHj6HlA
	F8vCM/KwzBvXT0Fkf3yDuYpPMXeJMhXXcT5kFG+C0hqTHUMYMWx/8I+TX58NLvWrnHM0HJMluHS
	shmn1llnL4MLLmtTclJUM4G/wiu9eP1J+TmxZLGUq5d8bjQ=
X-Google-Smtp-Source: AGHT+IGgGIo4ggCkxmgbFu54U8KT/dvev04XZ2xtuqxgDeQn/qpnBz4ws/SgLAqL7IKChTe7TcyYVw==
X-Received: by 2002:a05:6000:1842:b0:391:2e97:577a with SMTP id ffacd0b85a97d-39132de2e83mr8487685f8f.55.1741626301487;
        Mon, 10 Mar 2025 10:05:01 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba679sm15302514f8f.8.2025.03.10.10.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:05:01 -0700 (PDT)
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
Subject: [PATCH v2 03/10] sched: Always initialize rt_rq's task_group
Date: Mon, 10 Mar 2025 18:04:35 +0100
Message-ID: <20250310170442.504716-4-mkoutny@suse.com>
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


