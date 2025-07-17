Return-Path: <cgroups+bounces-8756-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4367FB09388
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 19:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D139169EDD
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 17:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF02FE332;
	Thu, 17 Jul 2025 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dG9kkDkV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7292FC3DB;
	Thu, 17 Jul 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752774282; cv=none; b=ZyU2X6KUc5aWodQzGWqKZwZ0rwHhQ668y/FAoKXp0HqKZn39/FJGBy3N6v/buT8Qwm7tydslhCQ1cNG9UBQadhfZ375IL7jpMHtqYmcgjT8NjX0aUaYyoXzwv5dMd0PfDAWF/Csgoy+4UerngYPFbZNH7BLtw3GWANA751gQTv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752774282; c=relaxed/simple;
	bh=2WNUl7kyz/4/3vixbfH5Y+4CmMQgWbIBu6ljnStnCq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blCD65WxP+1c6Xrk4jMNjvBiACEr/uXlkn7zKYDTDBCafqTcrRwr9EsxrOFtFILsWNu6ArDDjhJItaP7Z1udBB0DR8iJZA0McWx1kniOTPXzZBgGOHmlsd94R5EDMxS2inWPIfNvkP7DVRd4/Jkz7hK7IWGjyy2P0QwJe2PQADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dG9kkDkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19486C4CEE3;
	Thu, 17 Jul 2025 17:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752774282;
	bh=2WNUl7kyz/4/3vixbfH5Y+4CmMQgWbIBu6ljnStnCq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dG9kkDkVBUZSvPKcI1O58rQ74A1sQkG0I7YLwsM06A3Q77yyjfcUXEG05ibbDYcFb
	 88IjxnUyEiGPMNxvER3n+juXuGnte81eM1WOg6ZyoX/r/VgY5Q1tCfROCeeH2DmVSc
	 3/ft0SQofUZ6n2F68zJfyWJ2KyqXnlxYr40csj5CIzQ2d0QLW71Ccp7IfTLEI4qv6K
	 deXFnWSCwBXbuZwpsysgJ7sKps18BS+dMSV6xycZUCqk7ASY71CwBbkHVTH2y9dKRI
	 a6OkH9CrO/JMwpOeOrmqT0bltQsvFHGlGhqg07PjGdo2ywOgFbz9bHIParCdGyDQEs
	 Y8+a6U19cT6aQ==
Date: Thu, 17 Jul 2025 07:44:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v3] cgroup: llist: avoid memory tears for llist_node
Message-ID: <aHk2iXXJkgaDkXVe@slm.duckdns.org>
References: <20250704180804.3598503-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704180804.3598503-1-shakeel.butt@linux.dev>

On Fri, Jul 04, 2025 at 11:08:04AM -0700, Shakeel Butt wrote:
> Before the commit 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi
> safe"), the struct llist_node is expected to be private to the one
> inserting the node to the lockless list or the one removing the node
> from the lockless list. After the mentioned commit, the llist_node in
> the rstat code is per-cpu shared between the stacked contexts i.e.
> process, softirq, hardirq & nmi. It is possible the compiler may tear
> the loads or stores of llist_node. Let's avoid that.
> 
> KCSAN reported the following race:
> 
>  Reported by Kernel Concurrency Sanitizer on:
>  CPU: 60 UID: 0 PID: 5425 ... 6.16.0-rc3-next-20250626 #1 NONE
>  Tainted: [E]=UNSIGNED_MODULE
>  Hardware name: ...
>  ==================================================================
>  ==================================================================
>  BUG: KCSAN: data-race in css_rstat_flush / css_rstat_updated
>  write to 0xffffe8fffe1c85f0 of 8 bytes by task 1061 on cpu 1:
>   css_rstat_flush+0x1b8/0xeb0
>   __mem_cgroup_flush_stats+0x184/0x190
>   flush_memcg_stats_dwork+0x22/0x50
>   process_one_work+0x335/0x630
>   worker_thread+0x5f1/0x8a0
>   kthread+0x197/0x340
>   ret_from_fork+0xd3/0x110
>   ret_from_fork_asm+0x11/0x20
>  read to 0xffffe8fffe1c85f0 of 8 bytes by task 3551 on cpu 15:
>   css_rstat_updated+0x81/0x180
>   mod_memcg_lruvec_state+0x113/0x2d0
>   __mod_lruvec_state+0x3d/0x50
>   lru_add+0x21e/0x3f0
>   folio_batch_move_lru+0x80/0x1b0
>   __folio_batch_add_and_move+0xd7/0x160
>   folio_add_lru_vma+0x42/0x50
>   do_anonymous_page+0x892/0xe90
>   __handle_mm_fault+0xfaa/0x1520
>   handle_mm_fault+0xdc/0x350
>   do_user_addr_fault+0x1dc/0x650
>   exc_page_fault+0x5c/0x110
>   asm_exc_page_fault+0x22/0x30
>  value changed: 0xffffe8fffe18e0d0 -> 0xffffe8fffe1c85f0
> 
> $ ./scripts/faddr2line vmlinux css_rstat_flush+0x1b8/0xeb0
> css_rstat_flush+0x1b8/0xeb0:
> init_llist_node at include/linux/llist.h:86
> (inlined by) llist_del_first_init at include/linux/llist.h:308
> (inlined by) css_process_update_tree at kernel/cgroup/rstat.c:148
> (inlined by) css_rstat_updated_list at kernel/cgroup/rstat.c:258
> (inlined by) css_rstat_flush at kernel/cgroup/rstat.c:389
> 
> $ ./scripts/faddr2line vmlinux css_rstat_updated+0x81/0x180
> css_rstat_updated+0x81/0x180:
> css_rstat_updated at kernel/cgroup/rstat.c:90 (discriminator 1)
> 
> These are expected race and a simple READ_ONCE/WRITE_ONCE resolves these
> reports. However let's add comments to explain the race and the need for
> memory barriers if stronger guarantees are needed.
> 
> More specifically the rstat updater and the flusher can race and cause a
> scenario where the stats updater skips adding the css to the lockless
> list but the flusher might not see those updates done by the skipped
> updater. This is benign race and the subsequent flusher will flush those
> stats and at the moment there aren't any rstat users which are not fine
> with this kind of race. However some future user might want more
> stricter guarantee, so let's add appropriate comments to ease the job of
> future users.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Fixes: 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi safe")

Applied to cgroup/for-6.17. Sorry about the delay. I'm on a vacation and
ended up a lot more offline than I expected to be.

Thanks.

-- 
tejun

