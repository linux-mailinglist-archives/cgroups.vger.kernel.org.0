Return-Path: <cgroups+bounces-13029-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 079E6D0DF28
	for <lists+cgroups@lfdr.de>; Sun, 11 Jan 2026 00:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A1CF300698C
	for <lists+cgroups@lfdr.de>; Sat, 10 Jan 2026 23:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5722877FE;
	Sat, 10 Jan 2026 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2ASNKvMY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AED50095C
	for <cgroups@vger.kernel.org>; Sat, 10 Jan 2026 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768087767; cv=none; b=s5zkvRrBbhT+xq8YP/+aCZEFicFGc74Ix7OqcWiKro34PDBq6DvHCvV8t7kwEAUtsX4V1UzBM/7dKNAC0xXwYPbAusUhZOya6hBz0pKcvWAimAzVc7tTzjOsLLPhPu3NX9O9POlGbrjRDT32JOTmnjftlGMgCAsTNEHkKMOqFq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768087767; c=relaxed/simple;
	bh=8feMRPd7kn/QU8hVFk5c80/pgbFRqhrP8JeGJi4HKKo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Qx5bVp/mbpbBMwSJIFsfnrllzfbuqlEyk+iaqeduUULfqO28Mv/DaXDgfeQmGDHAhqsAFCYm5jtpJobYwZS88Lzm69ILUSKfZWKORcr+g50bd9GLp0vLu9/9TRscV/0rz0jtOWMuP2DYXp7Hcn0GxX2F+cWjffTlY0RxI4ha5NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2ASNKvMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F2DC4CEF1;
	Sat, 10 Jan 2026 23:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768087766;
	bh=8feMRPd7kn/QU8hVFk5c80/pgbFRqhrP8JeGJi4HKKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2ASNKvMY/09pxE3gVtRyni1RtnWh7WNCcnBqDVsO8H4jx32rQTeIhsrsO2mVgQQ2F
	 LvOSWCm606uCj9CmtdJk4WRXEsxAj1FCf/sYSDUjHFu1Fanx/Wcm8vLEPbqPmj/xJd
	 Ycm/hbHm+qIpKzbB1MRyf1eYlcpw6lNy+EJGBKhw=
Date: Sat, 10 Jan 2026 15:29:25 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org,
 linux-mm@kvack.org, syzbot+d97580a8cceb9b03c13e@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/swap_cgroup: fix kernel BUG in swap_cgroup_record
Message-Id: <20260110152925.a2f98e1be21fac5bc8bc0bd5@linux-foundation.org>
In-Reply-To: <20260110064613.606532-1-kartikey406@gmail.com>
References: <20260110064613.606532-1-kartikey406@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Jan 2026 12:16:13 +0530 Deepanshu Kartikey <kartikey406@gmail.com> wrote:

> When using MADV_PAGEOUT, pages can remain in swapcache with their swap
> entries assigned. If MADV_PAGEOUT is called again on these pages, they
> reuse the same swap entries, causing memcg1_swapout() to call
> swap_cgroup_record() with an already-recorded entry.
> 
> The existing code assumes swap entries are always being recorded for the
> first time (oldid == 0), triggering VM_BUG_ON when it encounters an
> already-recorded entry:
> 
>   ------------[ cut here ]------------
>   kernel BUG at mm/swap_cgroup.c:78!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
>   CPU: 0 UID: 0 PID: 6176 Comm: syz.0.30 Not tainted
>   RIP: 0010:swap_cgroup_record+0x19c/0x1c0 mm/swap_cgroup.c:78
>   Call Trace:
>    memcg1_swapout+0x2fa/0x830 mm/memcontrol-v1.c:623
>    __remove_mapping+0xac5/0xe30 mm/vmscan.c:773
>    shrink_folio_list+0x2786/0x4f40 mm/vmscan.c:1528
>    reclaim_folio_list+0xeb/0x4e0 mm/vmscan.c:2208
>    reclaim_pages+0x454/0x520 mm/vmscan.c:2245
>    madvise_cold_or_pageout_pte_range+0x19a0/0x1ce0 mm/madvise.c:563
>    ...
>    do_madvise+0x1bc/0x270 mm/madvise.c:2030
>    __do_sys_madvise mm/madvise.c:2039
> 
> This bug occurs because pages in swapcache can be targeted by
> MADV_PAGEOUT multiple times without being swapped in between. Each time,
> the same swap entry is reused, but swap_cgroup_record() expects to only
> record new, unused entries.
> 
> Fix this by checking if the swap entry already has the correct cgroup ID
> recorded before attempting to record it. Use the existing
> lookup_swap_cgroup_id() to read the current cgroup ID, and return early
> from memcg1_swapout() if the entry is already correctly recorded. Only
> call swap_cgroup_record() when the entry needs to be set or updated.
> 
> This approach avoids unnecessary atomic operations, reference count
> manipulations, and statistics updates when the entry is already correct.

Thanks.  This looks like a fairly old bug and it annoyingly predates a
lot of memcg code movement.

What do people think?  Should we backport this into -stable kernels? 
If so, can some intrepid soul please help figure out what it Fixes:?

Deepanshu, if we do decide to put a cc:stable on this then some -stable
maintainers will complain that the patch alters things in a file which
doesn't exist and they'll hope that you can help.  Which means
backporting the fix into kernels which predate 89ce924f0bd44.



