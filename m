Return-Path: <cgroups+bounces-15531-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKnVFT2M8GkuUwEAu9opvQ
	(envelope-from <cgroups+bounces-15531-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 12:30:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB816482A5F
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 12:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E20AF30A852A
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 09:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DC43DFC98;
	Tue, 28 Apr 2026 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AgmJ4X1D"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860D173463
	for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370396; cv=none; b=KSC0lPNaNdzX0QcWJ2knQI6CrupyscLDAHNtJy5b8rRTGNXDQnfmqAzveZLMEW50GXlqRJRM707tF1ZUom56aylWoL35mmSgxUFcbJhpbUOu1F4JxuskU1GdBxWJxm+6Tcz7uPIRiRmD/Zaff+WXcVxPLJVZVDRhYefcB58RkeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370396; c=relaxed/simple;
	bh=5xFU/lATmgGgFS63VwB0ToNR9W+Z2EIumB/CNijaVs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKmMoa29IiKek03oc+0uurPVA4GLhoLktlHOukd8V8vu2nFB43qTl4pa9hPknidPKWOqkhLBHAN2vqXhyLXCp+zVRiPFIHiYeUHEVfHxw9uXSJeSzmReH6TW4d73YkM/74uqcdu4Ry+dg7ZFrYVOE6rlNE6bUQwjNuHXMugt9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AgmJ4X1D; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 28 Apr 2026 02:59:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777370381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MiTyaQb0gH/enfcQNGJbMNOh9xViBgr4r/Sr0EX4sgQ=;
	b=AgmJ4X1DAE/4K8J4aGBiJGCx4ShRw9Yk4yo1Nm9esDzMbomO1CMTEJ/p/pLVUlLgcw5JT8
	XV2Z30hj2JKnllRiwYLkUE5OtVei/iU193jyjAmZqF+ab+HCajouQKbV7RBj6tp8BVGw2H
	G/eCcKQG4Qs6/d568nEW6YW5nqIjA8Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, yosry@kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH] mm: memcontrol: fix rcu unbalance in
 get_non_dying_memcg_end()
Message-ID: <afCEgUMqhLvrYJe7@linux.dev>
References: <20260428030621.94470-1-qi.zheng@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428030621.94470-1-qi.zheng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: BB816482A5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15531-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]

On Tue, Apr 28, 2026 at 11:06:21AM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Currently, get_non_dying_memcg_start() and get_non_dying_memcg_end() both
> evaluate cgroup_subsys_on_dfl(memory_cgrp_subsys) independently to
> determine whether to acquire or release the RCU read lock.
> 
> However, the result of cgroup_subsys_on_dfl() can change dynamically at
> runtime due to cgroup hierarchy rebinding (e.g., when the memory
> controller is moved between cgroup v1 and v2 hierarchies). This can cause
> the following warning:
> 
>  =====================================
>  WARNING: bad unlock balance detected!
>  7.0.0-next-20260420+ #83 Tainted: G        W
>  -------------------------------------
>  memcg-repro/270 is trying to release lock (rcu_read_lock) at:
>  [<ffffffff815f57f7>] rcu_read_unlock+0x17/0x60
>  but there are no more locks to release!
> 
>  other info that might help us debug this:
>  1 lock held by memcg-repro/270:
>   #0: ffff888102fa2088 (vm_lock){++++}-{0:0}, at: do_user_addr_fault+0x285/0x880
> 
>  stack backtrace:
>  CPU: 0 UID: 0 PID: 270 Comm: memcg-repro Tainted: G        W           7.0.0-next-20260420+ #
>  Tainted: [W]=WARN
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>  Call Trace:
>   <TASK>
>   ? rcu_read_unlock+0x17/0x60
>   dump_stack_lvl+0x77/0xb0
>   print_unlock_imbalance_bug+0xe0/0xf0
>   ? rcu_read_unlock+0x17/0x60
>   lock_release+0x21d/0x2a0
>   rcu_read_unlock+0x1c/0x60
>   do_pte_missing+0x233/0xb40
>   __handle_mm_fault+0x80e/0xcd0
>   handle_mm_fault+0x146/0x310
>   do_user_addr_fault+0x303/0x880
>   exc_page_fault+0x9b/0x270
>   asm_exc_page_fault+0x26/0x30
>  RIP: 0033:0x5590e4eb41ea
>  Code: 61 cc 66 0f 6f e0 66 0f 61 c2 66 0f db cd 66 0f 69 e2 66 0f 6f d0 66 0f 69 d4 66 0f 61 0
>  RSP: 002b:00007ffcad25f030 EFLAGS: 00010202
>  RAX: 00005590e4eb8010 RBX: 00007ffcad260f7d RCX: 00007f73c474d44d
>  RDX: 00005590e4eb80a0 RSI: 00005590e4eb503c RDI: 000000000000000f
>  RBP: 00005590e4eb70a0 R08: 0000000000000000 R09: 00007f73c483a680
>  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>  R13: 00007ffcad25f180 R14: 00005590e4eb6dd8 R15: 00007f73c4869020
>   </TASK>
>  ------------[ cut here ]------------
> 
> Fix this by explicitly tracking the RCU lock state, ensuring that
> rcu_read_unlock() in get_non_dying_memcg_end() is strictly paired with
> the lock acquisition, regardless of any runtime rebinding events.
> 
> Fixes: 8285917d6f38 ("mm: memcontrol: prepare for reparenting non-hierarchical stats")
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/memcontrol.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c3d98ab41f1f1..38f48a45b7ae5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -805,12 +805,17 @@ static long memcg_state_val_in_pages(int idx, long val)
>   * Used in mod_memcg_state() and mod_memcg_lruvec_state() to avoid race with
>   * reparenting of non-hierarchical state_locals.
>   */
> -static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cgroup *memcg)
> +static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cgroup *memcg,
> +							   bool *rcu_locked)
>  {
> -	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +	/* Rebinding can cause this value to be changed at runtime */
> +	if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> +		*rcu_locked = false;
>  		return memcg;
> +	}
>  
>  	rcu_read_lock();
> +	*rcu_locked = true;
>  
>  	while (memcg_is_dying(memcg))
>  		memcg = parent_mem_cgroup(memcg);
> @@ -818,20 +823,23 @@ static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cgroup *me
>  	return memcg;
>  }
>  
> -static inline void get_non_dying_memcg_end(void)
> +static inline void get_non_dying_memcg_end(bool rcu_locked)
>  {
> -	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +	if (!rcu_locked)
>  		return;
>  
>  	rcu_read_unlock();
>  }
>  #else
> -static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cgroup *memcg)
> +static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cgroup *memcg,
> +							   bool *rcu_locked)
>  {
> +	*rcu_locked = false;

We don't need to set rcu_locked to false here as we don't access in !V1 build
option.

With that fixed, you can add:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

