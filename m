Return-Path: <cgroups+bounces-11188-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F69C0D098
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 12:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A24C188B4BB
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 11:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A4E2F5462;
	Mon, 27 Oct 2025 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OZQ4cnvM"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F921257A;
	Mon, 27 Oct 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761562908; cv=none; b=Ft3QXXWqQV4uAu2ihTSVFmIwt2s9z2bHsAMw3hcuiBjILjnNUoLmGDdjwNXohc+FUVhXKhZoNRj9/O7FyJV1AVIJtNKFJhZgHV9MHp/03GUZXuEQ/B4sx6Yu4PNDzvfevXZv5lQemj04BpoB9h7Lwl13eBJDevRJK+AJjWrEmcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761562908; c=relaxed/simple;
	bh=+YWIDYtWbyxkhyEDXclXTSkiH5uY+GXBlwBY1kWhUWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kif5VAVRh//2fsRbDx03iWjUDxFUvgwmdvBhaMO4FvfrhYTavzjTxHtMASMZM27ayZ5W4p7Tx+EMA2W0dvfoP8azT6xHcUi9Zm1Y3GNynIuc3eMRfOA+WFWJ6XdF6tAzP69b+tqUNtemf/Ojw+hacHKiqYk6mtskR5S3hzTjYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OZQ4cnvM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p/Yj+ABsI/8hmPjw795q+QpQX9cApBNlo4YWlmG2Vus=; b=OZQ4cnvMkRl2gAugW1M1ngTToc
	zqBvNFy1f0um3HLOIjB+xqSm02ZKIFqjdrWW35X5nLk9pG1VOPpqK1JvMwdY7Kf8y8zRUvFy6kRKK
	v/oK4ZECXZ3ZBbXHVZoYxLZTBxUbYmm3k/374rdDB6RkQ6gLNv+z/mb6pV4q92m7aKPhc40p9i65s
	Yxhng/0RGVdH1oi4f16dfzo5L5CKQFMxBLR0vXj9aXRlDcIShBuiMCvaQONVblumV93CHMsZsq2Hf
	9XemYneHEJg+kx3VHHczgLLKKAiNZ7GrSP48VN7NK72EsRJdMBoD0291vxmBrT+e5E86Co/oxPIRg
	YaW2uV7Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDKyj-0000000Gixk-3JBY;
	Mon, 27 Oct 2025 11:01:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F28EA300220; Mon, 27 Oct 2025 12:01:33 +0100 (CET)
Date: Mon, 27 Oct 2025 12:01:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>, japo@linux.ibm.com
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	cgroups@vger.kernel.org, aubrey.li@linux.intel.com,
	yu.c.chen@intel.com
Subject: Re: [tip:sched/core] [sched]  b079d93796:
 WARNING:possible_recursive_locking_detected_migration_is_trying_to_acquire_lock:at:set_cpus_allowed_force_but_task_is_already_holding_lock:at:cpu_stopper_thread
Message-ID: <20251027110133.GI3245006@noisy.programming.kicks-ass.net>
References: <202510271206.24495a68-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510271206.24495a68-lkp@intel.com>

On Mon, Oct 27, 2025 at 01:14:09PM +0800, kernel test robot wrote:

> kernel test robot noticed "WARNING:possible_recursive_locking_detected_migration_is_trying_to_acquire_lock:at:set_cpus_allowed_force_but_task_is_already_holding_lock:at:cpu_stopper_thread" on:
> 
> commit: b079d93796528053cde322f2ca838c2d21c297e7 ("sched: Rename do_set_cpus_allowed()")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core

Your biscect went sideways, it is, as Jan correctly found:

  abfc01077df6 ("sched: Fix do_set_cpus_allowed() locking")


Anyway, this was helpful:

> [  116.814488][   T21] ============================================
> [  116.815227][   T21] WARNING: possible recursive locking detected
> [  116.815957][   T21] 6.18.0-rc1-00014-gb079d9379652 #1 Tainted: G S                 
> [  116.816878][   T21] --------------------------------------------
> [  116.817602][   T21] migration/1/21 is trying to acquire lock:
> [  116.818301][   T21] ee7f1930 (&rq->__lock){-.-.}-{2:2}, at: set_cpus_allowed_force+0x3c/0xc0
> [  116.820432][   T21] 
> [  116.820432][   T21] but task is already holding lock:
> [  116.821314][   T21] ee7f1930 (&rq->__lock){-.-.}-{2:2}, at: cpu_stopper_thread+0x93/0x170

> [  116.841003][   T21] 
> [  116.842427][   T21] 2 locks held by migration/1/21:
> [  116.843393][   T21]  #0: b92d06dc (&p->pi_lock){-.-.}-{2:2}, at: __balance_push_cpu_stop+0x28/0x2b0
> [  116.845044][   T21]  #1: ee7f1930 (&rq->__lock){-.-.}-{2:2}, at: cpu_stopper_thread+0x93/0x170
> [  116.846669][   T21] 
> [  116.846669][   T21] stack backtrace:
> [  116.847890][   T21] CPU: 1 UID: 0 PID: 21 Comm: migration/1 Tainted: G S                  6.18.0-rc1-00014-gb079d9379652 #1 NONE  6d63d2e836521c1c681a07c673117fb98e4815ab
> [  116.847897][   T21] Tainted: [S]=CPU_OUT_OF_SPEC
> [  116.847898][   T21] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  116.847901][   T21] Stopper: __balance_push_cpu_stop+0x0/0x2b0 <- finish_lock_switch+0x7d/0xd0
> [  116.847909][   T21] Call Trace:

> [  116.847939][   T21]  ? lock_acquire+0xc3/0x1f0
> [  116.847943][   T21]  ? set_cpus_allowed_force+0x3c/0xc0
> [  116.847947][   T21]  ? lock_acquire+0xc3/0x1f0
> [  116.847952][   T21]  ? __task_rq_lock+0x73/0x1d0
> [  116.847955][   T21]  ? set_cpus_allowed_force+0x3c/0xc0
> [  116.847959][   T21]  ? set_cpus_allowed_force+0x3c/0xc0
> [  116.847962][   T21]  ? __balance_push_cpu_stop+0x136/0x2b0
> [  116.847966][   T21]  ? select_fallback_rq+0x148/0x230
> [  116.847970][   T21]  ? __balance_push_cpu_stop+0x163/0x2b0
> [  116.847974][   T21]  ? cpu_stopper_thread+0x93/0x170

Clearly I missed that case :/

---
Subject: sched: Fix the do_set_cpus_allowed() locking fix

Commit abfc01077df6 ("sched: Fix do_set_cpus_allowed() locking")
overlooked that __balance_push_cpu_stop() calls select_fallback_rq()
with rq->lock held. This makes that set_cpus_allowed_force() will
recursively take rq->lock and the machine locks up.

Run select_fallback_rq() earlier, without holding rq->lock. This opens
up a race window where a task could get migrated out from under us, but
that is harmless, we want the task migrated.

select_fallback_rq() itself will not be subject to concurrency as it
will be fully serialized by p->pi_lock, so there is no chance of
set_cpus_allowed_force() getting called with different arguments and
selecting different fallback CPUs for one task.

Fixes: abfc01077df6 ("sched: Fix do_set_cpus_allowed() locking")
Reported-by: Jan Polensky <japo@linux.ibm.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Closes: https://lore.kernel.org/oe-lkp/202510271206.24495a68-lkp@intel.com
---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1842285eac1e..67b5f2faab36 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8044,18 +8044,15 @@ static int __balance_push_cpu_stop(void *arg)
 	struct rq_flags rf;
 	int cpu;
 
-	raw_spin_lock_irq(&p->pi_lock);
-	rq_lock(rq, &rf);
-
-	update_rq_clock(rq);
-
-	if (task_rq(p) == rq && task_on_rq_queued(p)) {
+	scoped_guard (raw_spinlock_irq, &p->pi_lock) {
 		cpu = select_fallback_rq(rq->cpu, p);
-		rq = __migrate_task(rq, &rf, p, cpu);
-	}
 
-	rq_unlock(rq, &rf);
-	raw_spin_unlock_irq(&p->pi_lock);
+		rq_lock(rq, &rf);
+		update_rq_clock(rq);
+		if (task_rq(p) == rq && task_on_rq_queued(p))
+			rq = __migrate_task(rq, &rf, p, cpu);
+		rq_unlock(rq, &rf);
+	}
 
 	put_task_struct(p);
 

