Return-Path: <cgroups+bounces-3809-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A7D937820
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 15:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C9C1F217E5
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 13:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0006F13C3D2;
	Fri, 19 Jul 2024 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxPWbaF1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C98287D;
	Fri, 19 Jul 2024 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721394472; cv=none; b=KM42jt3853BXBgETPGC1u5+bCiEWkangv2JReYRNzCdzISB5i/qZcY24rK2sXhRgc1J2Z6aAGOnl989U0TkO19tQVje1k4e8IULxXVRh4tNpVJTPD7fPLSClh9S0QgRVkeLXc2wbT6kE1Vkv4bcRahprVruCUdJYAgVDq5DcO6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721394472; c=relaxed/simple;
	bh=7zTaxivH6TZiJpCmsPOaYPHmaRAX9f1Y7IJuuZGbuPM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4nUAcS/klhlE43VYlm0A2h2cDH7djaSzNYTjXOh1Z+bA5IORoT3hlZFyjoxnkqjdtiKUJiS8kIKAxGYLciJO0hmIcjwAfzRVAO+gIsSq/JtJtBnnFt39Lg1Mqfj93DQ7AtBhT+vCLJmTL7+o2zwGO/vDlYvvCxkSfg3PBcKgwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxPWbaF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192C4C32782;
	Fri, 19 Jul 2024 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721394472;
	bh=7zTaxivH6TZiJpCmsPOaYPHmaRAX9f1Y7IJuuZGbuPM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SxPWbaF1lpLtzt7stK2H9/YKhzURL4bsn/4B95hTLCDfIqZUOAzFF/I/f3pcg5dTl
	 fqeRJQU74sYzfkaNxZl9T0eK0u4+841IfnsTiIrbvXFvuCPXDLv2WCwbaiZCY4gfNf
	 NEne1nH3dn8AOGL8J82c9qjVv7rUygZp5ZzWw3Yw87giT0gJ7fog2sUQQgB5lF6qzY
	 IKmiGhQiFzwLAq5XxcVxMFlNlc7y/n6w2/FDoYzk2FmBTY9wP+elnOYu/z7mhcGCc4
	 cr/emNtktmAENh5SKEA5xBkf/ASaq10pq8y8u6yp0vh4H3VRmnfrhVW/84QuloUBjZ
	 rItxlvav9kqIA==
Subject: [PATCH V8 2/2] cgroup/rstat: add tracepoints for ongoing flusher
 waits
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Fri, 19 Jul 2024 15:07:47 +0200
Message-ID: <172139440730.3084888.16497707303868810863.stgit@firesoul>
In-Reply-To: <172139415725.3084888.13770938453137383953.stgit@firesoul>
References: <172139415725.3084888.13770938453137383953.stgit@firesoul>
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
V8: Add TP for detecting ongoing_flusher yielding lock

 include/trace/events/cgroup.h |   56 +++++++++++++++++++++++++++++++++++++++++
 kernel/cgroup/rstat.c         |   18 +++++++++++--
 2 files changed, 71 insertions(+), 3 deletions(-)

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
index eaa138f2da2f..cf344c0e71b3 100644
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
@@ -369,6 +378,9 @@ static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
 			reinit_completion(&cgrp->flush_done);
 			WRITE_ONCE(cgrp_rstat_ongoing_flusher, cgrp);
 		}
+	} else {
+		/* Detect multiple flushers as ongoing yielded lock */
+		trace_cgroup_ongoing_flusher_yield(cgrp, ongoing, 0, 0, 0);
 	}
 	return true;
 }



