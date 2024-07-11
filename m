Return-Path: <cgroups+bounces-3618-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B1492E983
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 15:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1D91F241F7
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5BD15ECD6;
	Thu, 11 Jul 2024 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnXshWEc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D361514ED;
	Thu, 11 Jul 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704550; cv=none; b=jBSyeAJQSfkQVyxkRxA3VlXhPIzJ6ogMS8xxxOsLMW0Ch0pw0+DccY2eyhzHJryYuzemB1+IxEPMA+VXFKY+azPLWaj/RTTaf//kZDX8xi4vS8TsBNssqeQqQJJ1GSSNrc8ixJE9n3NI7LuAGo7EDwqeDmYOsp8VeN8+4lQ0KDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704550; c=relaxed/simple;
	bh=71qZnHa/lOQXOs6SPxp3YR6prqZbbSZTednAdP42Nvw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTZ0hT/eyDMXzRr65zEedgZotHwKCf4CmvgjRDPcZ2nnLVf6+3aEzCEw6vc0uEuDEyfD55+9iWH/p5OBMqbGrkY3vGR+6SOBCdXtbytHx4LU6idZeRLZP3HfkET6scFY4Foy/EsuJ4OM2EIdlR89q9tI9Nt+bCGNZ9ImlmqhuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnXshWEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D8DC116B1;
	Thu, 11 Jul 2024 13:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720704548;
	bh=71qZnHa/lOQXOs6SPxp3YR6prqZbbSZTednAdP42Nvw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lnXshWEcQmP4VRNf41OlqGBQFa9tJ3wyNmFf9hqXdO/3++NfHoBJ/Xy2ewfxM9vGh
	 0YKn9zTu2OBXDdqWDy554AlBqmCzJ/jpuYHq6ZR6TaxKsaLBwdhv+Z3QzwgojDV0uL
	 xMCfwonkVgOttj0Mje6clsRQaE7t9BJFHmc0LZOUxmWBOi+5kaK3z4qnY+Gw4ON8pU
	 E/U13b99c/k9Pp3fMGlMx2dJIhNcLln28AcKkW65HrF94toRmbo1Afx8nPIyW4DJ/9
	 PVn6gvsm3eX2vSqplagOMgS4ez0szl1yoBs8MHwkcJwguZXFkmnTgynhN7gZbUcpM3
	 dUxY/zrrEeZfA==
Subject: [PATCH V7 2/2 RFC] cgroup/rstat: add tracepoint for ongoing flusher
 waits
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Thu, 11 Jul 2024 15:29:04 +0200
Message-ID: <172070452878.2992819.10548676901200594081.stgit@firesoul>
In-Reply-To: <172070450139.2992819.13210624094367257881.stgit@firesoul>
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

I'll be using this tracepoint in production and will
report back on findings, e.g. measuring how often the
race for ongoing flusher happens. Tthen we can decide
if it is worth to keep/apply this patch.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/trace/events/cgroup.h |   49 +++++++++++++++++++++++++++++++++++++++++
 kernel/cgroup/rstat.c         |   15 ++++++++++---
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index af2755bda6eb..c8d84e9a08dc 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -296,6 +296,55 @@ DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_unlock_fastpath,
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
+
 #endif /* _TRACE_CGROUP_H */
 
 /* This part must be outside protection */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index fe2a81a310bb..2d7af86e31c8 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -321,6 +321,7 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
 static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
 {
 	struct cgroup *ongoing;
+	unsigned int race = 0;
 	bool locked;
 
 	/* Check if ongoing flusher is already taking care of this, if
@@ -330,17 +331,25 @@ static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
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
 		/* Contended: Handle loosing race for ongoing flusher */
-		if (!ongoing && READ_ONCE(cgrp_rstat_ongoing_flusher))
+		if (!ongoing && READ_ONCE(cgrp_rstat_ongoing_flusher)) {
+			race++;
 			goto retry;
+		}
 
 		__cgroup_rstat_lock(cgrp, -1, false);
 	}



