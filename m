Return-Path: <cgroups+bounces-4047-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D149436B4
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 21:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216DD1C216FF
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 19:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13C5148FF3;
	Wed, 31 Jul 2024 19:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0L820fc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E64018044;
	Wed, 31 Jul 2024 19:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455249; cv=none; b=XXMvYv7oK9WKypZsyI17F2H/6FJL2ovjavN+vh2y4hQ9bxPGcFOfpTd7oLlKZcpo1qqEJv+as1KR74LSDJIBTbHYieUGDBSKifjx10ApfdNFbo/jxm96tALzs+nyl4FPBnDaySbMapilHE/wGAxLqZSrg0gz5t9fZmFLp8AHDko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455249; c=relaxed/simple;
	bh=Q2e7po8J+L6F35gasVB8tGKFXWuPCBzWtFxt9x2NrGQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XL6triDAYahrsUYwrmWxO8DTq+lHjG2gwe2W8O3Z/AKubiMKIXKDsxDFZEeyfAlog1H+5pXVTqn3G+/0ZZsLzSr3xcxCB4FNOdOSsdzjNDWwlaPKJBvrSWCMvHvo7EflzukpQE1KXeeIr2hmIlCqeNacPVlhcDFsD2tt0mekr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0L820fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F23C116B1;
	Wed, 31 Jul 2024 19:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722455249;
	bh=Q2e7po8J+L6F35gasVB8tGKFXWuPCBzWtFxt9x2NrGQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=u0L820fc2XQ8WzMEYAVX39p5MrG9oz4sqnYgcqtpSKKKwTVDAkf1Zzcl+eDq7UdJ1
	 WMW2zjUp0/RoJJYfCqHiyIazcRKWwvd+rDfCKgwRdJBM6MRWBk9Gk/PcYdmrHlzhck
	 eWDkClLNs1bEYw7hEh1zwQGThMZg8UxS3yG8nVGvPg03NloQr+uZ9ns4UHiCmJFcgL
	 fGkHJ3wCd9FvOYqCEo8vek0nchdAxcv05Zb5PyaHOB9C5LSGgpvBidbGVCSyOoCTKK
	 JkBLFvGHe+Tkt/67tH8jiu8AGCeXq2SDv8zTwYana19BSEEecUNZs/nBSdhiUCdq0p
	 NodnBpuSKnjMA==
Subject: [PATCH V9 2/2] cgroup/rstat: add tracepoints for ongoing flusher
 waits
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Wed, 31 Jul 2024 21:47:24 +0200
Message-ID: <172245523597.3147408.4165443154847854225.stgit@firesoul>
In-Reply-To: <172245504313.3147408.12138439169548255896.stgit@firesoul>
References: <172245504313.3147408.12138439169548255896.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

These tracepoints were practical to measure ongoing flusher
wait time behavior and see that race do occur in production.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/trace/events/cgroup.h |   56 +++++++++++++++++++++++++++++++++++++++++
 kernel/cgroup/rstat.c         |   21 ++++++++++++---
 2 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index af2755bda6eb..81f57fa751c4 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -296,6 +296,62 @@ DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_unlock_fastpath,
 	TP_ARGS(cgrp, cpu, contended)
 );
 
+DECLARE_EVENT_CLASS(cgroup_ongoing,
+
+	TP_PROTO(struct cgroup *cgrp, struct cgroup *cgrp_ongoing, \
+		 long res, unsigned int race, ktime_t ts),
+
+	TP_ARGS(cgrp, cgrp_ongoing, res, race, ts),
+
+	TP_STRUCT__entry(
+		__field(	int,		root			)
+		__field(	int,		level			)
+		__field(	u64,		id			)
+		__field(	u64,		id_ongoing		)
+		__field(	ktime_t,	ts			)
+		__field(	long,		res			)
+		__field(	u64,		race			)
+	),
+
+	TP_fast_assign(
+		__entry->root = cgrp->root->hierarchy_id;
+		__entry->id = cgroup_id(cgrp);
+		__entry->level = cgrp->level;
+		__entry->id_ongoing = cgroup_id(cgrp_ongoing);
+		__entry->res = res;
+		__entry->race = race;
+		__entry->ts = ts;
+	),
+
+	TP_printk("root=%d id=%llu level=%d ongoing_flusher=%llu res=%ld race=%llu ts=%lld",
+		  __entry->root, __entry->id, __entry->level,
+		  __entry->id_ongoing, __entry->res, __entry->race, __entry->ts)
+);
+
+DEFINE_EVENT(cgroup_ongoing, cgroup_ongoing_flusher,
+
+	TP_PROTO(struct cgroup *cgrp, struct cgroup *cgrp_ongoing, \
+		 long res, unsigned int race, ktime_t ts),
+
+	TP_ARGS(cgrp, cgrp_ongoing, res, race, ts)
+);
+
+DEFINE_EVENT(cgroup_ongoing, cgroup_ongoing_flusher_wait,
+
+	TP_PROTO(struct cgroup *cgrp, struct cgroup *cgrp_ongoing, \
+		 long res, unsigned int race, ktime_t ts),
+
+	TP_ARGS(cgrp, cgrp_ongoing, res, race, ts)
+);
+
+DEFINE_EVENT(cgroup_ongoing, cgroup_ongoing_flusher_yield,
+
+	TP_PROTO(struct cgroup *cgrp, struct cgroup *cgrp_ongoing, \
+		 long res, unsigned int race, ktime_t ts),
+
+	TP_ARGS(cgrp, cgrp_ongoing, res, race, ts)
+);
+
 #endif /* _TRACE_CGROUP_H */
 
 /* This part must be outside protection */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 463f9807ec7e..c343506b2c7b 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -328,6 +328,7 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
 static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
 {
 	struct cgroup *ongoing;
+	unsigned int race = 0;
 	bool locked;
 
 	/*
@@ -338,17 +339,25 @@ static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
 retry:
 	ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
 	if (ongoing && cgroup_is_descendant(cgrp, ongoing)) {
-		wait_for_completion_interruptible_timeout(
+		ktime_t ts = ktime_get_mono_fast_ns();
+		long res = 0;
+
+		trace_cgroup_ongoing_flusher(cgrp, ongoing, 0, race, ts);
+
+		res = wait_for_completion_interruptible_timeout(
 			&ongoing->flush_done, MAX_WAIT);
-		/* TODO: Add tracepoint here */
+		trace_cgroup_ongoing_flusher_wait(cgrp, ongoing, res, race, ts);
+
 		return false;
 	}
 
 	locked = __cgroup_rstat_trylock(cgrp, -1);
 	if (!locked) {
 		/* Contended: Handle losing race for ongoing flusher */
-		if (!ongoing && READ_ONCE(cgrp_rstat_ongoing_flusher))
+		if (!ongoing && READ_ONCE(cgrp_rstat_ongoing_flusher)) {
+			race++;
 			goto retry;
+		}
 
 		__cgroup_rstat_lock(cgrp, -1, true);
 	}
@@ -357,7 +366,8 @@ static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
 	 * Due to lock yielding, we might obtain lock while another
 	 * ongoing flusher (that isn't a parent) owns ongoing_flusher.
 	 */
-	if (!READ_ONCE(cgrp_rstat_ongoing_flusher)) {
+	ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
+	if (!ongoing) {
 		/*
 		 * Limit to top-level as lock yielding allows others to obtain
 		 * lock without being ongoing_flusher. Leading to cgroup that
@@ -368,6 +378,9 @@ static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
 			reinit_completion(&cgrp->flush_done);
 			WRITE_ONCE(cgrp_rstat_ongoing_flusher, cgrp);
 		}
+	} else {
+		/* Detect multiple flushers as ongoing yielded lock */
+		trace_cgroup_ongoing_flusher_yield(cgrp, ongoing, 0, 0, 0);
 	}
 	return true;
 }



