Return-Path: <cgroups+bounces-17414-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WGHgMyl+RGobvwoAu9opvQ
	(envelope-from <cgroups+bounces-17414-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 04:40:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1883C6E9478
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 04:40:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=jU53toVP;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17414-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17414-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 015383031CAF
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76D23644CA;
	Wed,  1 Jul 2026 02:40:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7BA3624B3
	for <cgroups@vger.kernel.org>; Wed,  1 Jul 2026 02:40:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873628; cv=none; b=VeTeUndJMfZQbOyb9n1A04EuwGCb7kLn9lymqGlnFnTGV7NtHMttDeTtND4D1dQz7+42mMuEDlhNLgqFsVhsPzCNE6LRz5wOO1nNmaX37OjbIP6SI0Vz46t39/wYs9r2S2ohER3RagudrcIroOTJ7SHZ0YlFpJoqeoYAdkqBTwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873628; c=relaxed/simple;
	bh=/uNUCpPIvAgfrLvp/TRz/0Kj8XssEJWttncPwsErGyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHN/yKIR5qqzwv6V2+hYZHoGT8GN32NQ8SmvdnQ4MXGBKdIN06EzStsKmmgCdS19kWhUe/6ADG1Bdf4B73uZzLIZxI0fyD4l71lzJnXp4z4pt3MNyoE47x3RTaezMiKIexDNaXaxjY8cAS1k8QbQRtJ+HJRJ1yDzHLwjbx4n1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jU53toVP; arc=none smtp.client-ip=91.218.175.174
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782873624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zOd8DSH7cMYtJD/+/URsy/IxwgqSz9ZSG2fyMnhSXak=;
	b=jU53toVPumrS9P5nkr8lgqCFP3On/pZhU6agZrcXkfqKCJkvxOKtlYu/72jObB/OC9jhqZ
	BjXP02wTgs93xHsY/ptW+JuOjrGzS92mQSLkYBuLjiSIiHoqCZZ4dDkxjAAWaKx2pd52T/
	3ULYc9iXvhPdt7Auvx4hQY9Ul009zSM=
From: Hui Zhu <hui.zhu@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH v3] mm/memcontrol: Avoid stuck FLUSHING_CACHED_CHARGE on isolated CPU
Date: Wed,  1 Jul 2026 10:40:10 +0800
Message-ID: <20260701024010.564830-1-hui.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17414-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:zhuhui@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1883C6E9478

From: Hui Zhu <zhuhui@kylinos.cn>

drain_all_stock() sets FLUSHING_CACHED_CHARGE before calling
schedule_drain_work() to queue per-CPU drain work.  When the target
CPU is isolated (cpu_is_isolated() == true), the work is silently
not queued, but FLUSHING_CACHED_CHARGE stays set.  Every subsequent
drain_all_stock() then sees the bit and skips this stock entirely,
so the entry is effectively pinned until something else on that CPU
runs drain_local_*_stock() and clears the bit -- which on a long-
isolated CPU may never happen.

The original idea was to actually perform the drain from the calling
CPU on behalf of the isolated one, by adding a lock around the
per-CPU stock so that a remote drainer could safely touch it.  In
practice this turned out to be intrusive: the stock data structures
and their fast paths (consume_stock(), refill_stock(), the obj_stock
helpers) are deliberately designed around current-CPU-only access,
and retrofitting cross-CPU serialisation onto them adds non-trivial
locking and PREEMPT_RT concerns for very little gain.

Looking at the actual amount of charge that can accumulate in a
single per-CPU stock, it is bounded and small, so leaving an
isolated CPU's stock undrained for a while is not a real problem.
The only real bug is that the stuck FLUSHING_CACHED_CHARGE bit
prevents future drain_all_stock() callers from re-attempting once
the CPU is no longer isolated.

Fix this minimally by clearing FLUSHING_CACHED_CHARGE when the work
could not be queued because the target CPU is isolated.  The cached
charge itself is left in place; it will be released the next time
the CPU runs drain_local_*_stock() (e.g. after leaving isolation,
or if the isolated CPU itself calls drain_all_stock() -- in that
case cpu == curcpu causes drain_local_memcg_stock() to be invoked
directly), and the next drain_all_stock() call is free to retry
instead of skipping the stock forever.

Fixes: 6a792697a53a ("memcg: do not drain charge pcp caches on remote isolated cpus")
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
Changelog:
v3:
According to the comments of Shakeel Butt, keep the whole
schedule_drain_work() body under a single guard(rcu)() instead of
splitting it with scoped_guard(rcu){}.
v2:
According to the comments of Waiman Long, updated fixes.

 mm/memcontrol.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6dc4888a90f3..42a0d0d6284a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2256,7 +2256,8 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
 	return flush;
 }
 
-static void schedule_drain_work(int cpu, struct work_struct *work)
+static void
+schedule_drain_work(int cpu, struct work_struct *work, unsigned long *flags)
 {
 	/*
 	 * Protect housekeeping cpumask read and work enqueue together
@@ -2265,8 +2266,21 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
 	 * pending work on newly isolated CPUs.
 	 */
 	guard(rcu)();
-	if (!cpu_is_isolated(cpu))
-		queue_work_on(cpu, memcg_wq, work);
+	if (cpu_is_isolated(cpu)) {
+		/*
+		 * The target CPU is isolated: the drain work was not
+		 * queued. Clear FLUSHING_CACHED_CHARGE so a future
+		 * drain_all_stock() call can retry instead of skipping
+		 * this stock forever.
+		 *
+		 * The cached charge itself is left untouched here; it
+		 * will be drained the next time drain_local_stock() runs
+		 * on this CPU (e.g. after it leaves isolation).
+		 */
+		clear_bit(FLUSHING_CACHED_CHARGE, flags);
+		return;
+	}
+	queue_work_on(cpu, memcg_wq, work);
 }
 
 /*
@@ -2299,7 +2313,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 			if (cpu == curcpu)
 				drain_local_memcg_stock(&memcg_st->work);
 			else
-				schedule_drain_work(cpu, &memcg_st->work);
+				schedule_drain_work(cpu, &memcg_st->work,
+						    &memcg_st->flags);
 		}
 
 		if (!test_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags) &&
@@ -2309,7 +2324,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 			if (cpu == curcpu)
 				drain_local_obj_stock(&obj_st->work);
 			else
-				schedule_drain_work(cpu, &obj_st->work);
+				schedule_drain_work(cpu, &obj_st->work,
+						    &obj_st->flags);
 		}
 	}
 	migrate_enable();
-- 
2.43.0


