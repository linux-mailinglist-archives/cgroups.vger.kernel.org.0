Return-Path: <cgroups+bounces-13303-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F16FDD399DA
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 21:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91EB8300942B
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 20:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28AA212542;
	Sun, 18 Jan 2026 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wAwy4dum"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AED723EA81;
	Sun, 18 Jan 2026 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768769592; cv=none; b=h16MGpLI50R7LFN5MDkMm/wTVPwOexHsguIdmXRlq3+rvqi5AJPjEmq4+Cb12HEL5bAtqdaFy9T5+WjA03MWpDbLQuY1UWxNw9YJ0wsD7ERZ0ybaNjKljzzornMX8B4yOi8C50ouIDi2ygevaf+RmCbnAhtzy8BFWcJGXui4mbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768769592; c=relaxed/simple;
	bh=fK9ac9RPhRZgFPiQNcPRY83rlzyBRy0paqxUcXHrxlY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DfrIwmtuFNpirhHy+HPqHcHmCl3224mMRDAB3P2uezQy4jYWXnC3ZW/mHgSNYV51mYee/XiXhve8PLQ2t+zoujm0o1lr3KKWYmhyPHQGcJPUBjkjtx7tjGrqZ0VeTene/+4iqmGJG5ZmDOv+0d1TDT8vrJVYk1GEgjYdzgcSc9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wAwy4dum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5E4C116D0;
	Sun, 18 Jan 2026 20:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768769592;
	bh=fK9ac9RPhRZgFPiQNcPRY83rlzyBRy0paqxUcXHrxlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wAwy4dumj3QkHo2j4/DFpsskq0L2LT+YaKl/VWlDSldxxke7hgauSAAaCEQdxQ/rM
	 35l6yp40Je1qZG1ZgTWzwr0eHET0Wp4AjTK9It/U+kfCFKjZTw/tDbw++Y2TB/bEuQ
	 p4KTqMMB/Rkp7GfG3dmQt7Tca4Ph5/U6dNUvAAqY=
Date: Sun, 18 Jan 2026 12:53:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: syzbot <syzbot+079a3b213add54dd18a7@syzkaller.appspotmail.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 syzkaller-bugs@googlegroups.com, Johannes Weiner <hannes@cmpxchg.org>,
 Muchun Song <muchun.song@linux.dev>, Minchan Kim <minchan@kernel.org>
Subject: Re: [syzbot] [cgroups?] [mm?] WARNING in memcg1_swapout
Message-Id: <20260118125311.e1894f598e2a8ef626f47f25@linux-foundation.org>
In-Reply-To: <CADhLXY7FJqRLjX7X2yJfa0=iDbUAMwhS35cOEExW+qBJWAnt+A@mail.gmail.com>
References: <696b56b1.050a0220.3390f1.0007.GAE@google.com>
	<20260117165722.6dc25d72fd58254cb89e711b@linux-foundation.org>
	<CADhLXY6ACKeyLrjARTTdfWyrvUdLbtD-wXiQvsvhsbGjwmUqDA@mail.gmail.com>
	<CADhLXY7FJqRLjX7X2yJfa0=iDbUAMwhS35cOEExW+qBJWAnt+A@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2026 12:31:43 +0530 Deepanshu Kartikey <kartikey406@gmail.com> wrote:

> > >
> > > That's
> > >
> > >         VM_WARN_ON_ONCE(oldid != 0);
> > >
> > > which was added by Deepanshu's "mm/swap_cgroup: fix kernel BUG in
> > > swap_cgroup_record".
> > >
> > > This patch has Fixes: 1a4e58cce84e ("mm: introduce MADV_PAGEOUT"),
> > > which is six years old.  For some reason it has no cc:stable.
> > >
> > > Deepanshu's patch has no reviews.
> > >
> > > So can I please do the memcg maintainer summoning dance here?  We have a
> > > repeatable BUG happening in mainline Linux.
> > >
> >
> > Hi Andrew,
> >
> > I checked the git blame output for commit 0f853ca2a798:
> >
> > Line 763: memcg1_swapout(folio, swap);
> > Line 764: __swap_cache_del_folio(ci, folio, swap, shadow);
> >                     (d7a7b2f91f36b - Kairui Song, 2026-01-13 02:33:36 +0800)
> >
> > Kairui's reordering patch appears to have been merged on Jan 13.

Eek, there are many patches, it helps to identify them carefully.

I think you're referring to
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-swap-use-swap-cache-as-the-swap-in-synchronize-layer-fix.patch

> > The syzbot report is also from Jan 13, likely from earlier in the
> > day before the reordering patch was merged.
> >
> > So this report is from before the fix. The warning should not appear
> > in linux-next builds after Jan 13.
> >
> > Thanks,
> >
> > Deepanshu
> 
> Hi Andrew,
> 
> I tested with the latest linux-next in sysbot. It is working fine

Great, thanks.  But we still don't have review for this one.

For some reason I don't have cc:stable on this - could people
make a recommendation?



From: Deepanshu Kartikey <kartikey406@gmail.com>
Subject: mm/swap_cgroup: fix kernel BUG in swap_cgroup_record
Date: Sat, 10 Jan 2026 12:16:13 +0530

When using MADV_PAGEOUT, pages can remain in swapcache with their swap
entries assigned.  If MADV_PAGEOUT is called again on these pages, they
reuse the same swap entries, causing memcg1_swapout() to call
swap_cgroup_record() with an already-recorded entry.

The existing code assumes swap entries are always being recorded for the
first time (oldid == 0), triggering VM_BUG_ON when it encounters an
already-recorded entry:

  ------------[ cut here ]------------
  kernel BUG at mm/swap_cgroup.c:78!
  Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
  CPU: 0 UID: 0 PID: 6176 Comm: syz.0.30 Not tainted
  RIP: 0010:swap_cgroup_record+0x19c/0x1c0 mm/swap_cgroup.c:78
  Call Trace:
   memcg1_swapout+0x2fa/0x830 mm/memcontrol-v1.c:623
   __remove_mapping+0xac5/0xe30 mm/vmscan.c:773
   shrink_folio_list+0x2786/0x4f40 mm/vmscan.c:1528
   reclaim_folio_list+0xeb/0x4e0 mm/vmscan.c:2208
   reclaim_pages+0x454/0x520 mm/vmscan.c:2245
   madvise_cold_or_pageout_pte_range+0x19a0/0x1ce0 mm/madvise.c:563
   ...
   do_madvise+0x1bc/0x270 mm/madvise.c:2030
   __do_sys_madvise mm/madvise.c:2039

This bug occurs because pages in swapcache can be targeted by MADV_PAGEOUT
multiple times without being swapped in between.  Each time, the same swap
entry is reused, but swap_cgroup_record() expects to only record new,
unused entries.

Fix this by checking if the swap entry already has the correct cgroup ID
recorded before attempting to record it.  Use the existing
lookup_swap_cgroup_id() to read the current cgroup ID, and return early
from memcg1_swapout() if the entry is already correctly recorded.  Only
call swap_cgroup_record() when the entry needs to be set or updated.

This approach avoids unnecessary atomic operations, reference count
manipulations, and statistics updates when the entry is already correct.

Link: https://syzkaller.appspot.com/bug?extid=d97580a8cceb9b03c13e
Link: https://lkml.kernel.org/r/20260110064613.606532-1-kartikey406@gmail.com
Fixes: 1a4e58cce84e ("mm: introduce MADV_PAGEOUT")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Reported-by: syzbot+d97580a8cceb9b03c13e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d97580a8cceb9b03c13e
Tested-by: syzbot+d97580a8cceb9b03c13e@syzkaller.appspotmail.com
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memcontrol-v1.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/mm/memcontrol-v1.c~mm-swap_cgroup-fix-kernel-bug-in-swap_cgroup_record
+++ a/mm/memcontrol-v1.c
@@ -592,6 +592,7 @@ void memcg1_swapout(struct folio *folio,
 {
 	struct mem_cgroup *memcg, *swap_memcg;
 	unsigned int nr_entries;
+	unsigned short oldid;
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
@@ -609,6 +610,16 @@ void memcg1_swapout(struct folio *folio,
 		return;
 
 	/*
+	 * Check if this swap entry is already recorded. This can happen
+	 * when MADV_PAGEOUT is called multiple times on pages that remain
+	 * in swapcache, reusing the same swap entries.
+	 */
+	oldid = lookup_swap_cgroup_id(entry);
+	if (oldid == mem_cgroup_id(memcg))
+		return;
+	VM_WARN_ON_ONCE(oldid != 0);
+
+	/*
 	 * In case the memcg owning these pages has been offlined and doesn't
 	 * have an ID allocated to it anymore, charge the closest online
 	 * ancestor for the swap instead and transfer the memory+swap charge.
_


