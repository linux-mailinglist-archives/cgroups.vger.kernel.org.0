Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3717269142
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgINQRv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 12:17:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46844 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725957AbgINQRR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 12:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600100235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1rPx5UZdSZkkl2+kwuF5ixN5RaMtxpW+jRF3FLv45IQ=;
        b=OYTaJffIjA+YrAXeu0CrSrH+rEuozQGxbvYW8ast8ZFd9vDatg/4obkEVIPpH9NMftGHPH
        sNdP0yC9K7+9s94Qx7S3k4BJbo/yDNZIRxjZe+KOkCkE9peYhtYJplQJ9j+Ef7RIJEWdda
        zVIu94CGZhO3fLBcrGRfJlk5sL/9AU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-pEpxIfFmOVWf5HYfLbDg2w-1; Mon, 14 Sep 2020 12:17:12 -0400
X-MC-Unique: pEpxIfFmOVWf5HYfLbDg2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 262721882FBB;
        Mon, 14 Sep 2020 16:17:10 +0000 (UTC)
Received: from ovpn-113-249.rdu2.redhat.com (ovpn-113-249.rdu2.redhat.com [10.10.113.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D8377513D;
        Mon, 14 Sep 2020 16:17:08 +0000 (UTC)
Message-ID: <c48c5eaa09d1ea5b78b12b545c034d1e937c49ba.camel@redhat.com>
Subject: Re: [PATCH v2 3/8] mm: Optimise madvise WILLNEED
From:   Qian Cai <cai@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     intel-gfx@lists.freedesktop.org, Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Auld <matthew.auld@intel.com>
Date:   Mon, 14 Sep 2020 12:17:07 -0400
In-Reply-To: <20200910183318.20139-4-willy@infradead.org>
References: <20200910183318.20139-1-willy@infradead.org>
         <20200910183318.20139-4-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 2020-09-10 at 19:33 +0100, Matthew Wilcox (Oracle) wrote:
> Instead of calling find_get_entry() for every page index, use an XArray
> iterator to skip over NULL entries, and avoid calling get_page(),
> because we only want the swap entries.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reverting the "Return head pages from find_*_entry" patchset [1] up to this
patch fixed the issue that LTP madvise06 test [2] would trigger endless soft-
lockups below. It does not help after applied patches fixed other separate
issues in the patchset [3][4].

[1] https://lore.kernel.org/intel-gfx/20200910183318.20139-1-willy@infradead.org/ 
[2] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise06.c
[3] https://lore.kernel.org/intel-gfx/20200914112738.GM6583@casper.infradead.org/
[4] https://lore.kernel.org/lkml/20200914115559.GN6583@casper.infradead.org/

[ 2653.179563][    C4] CPU: 4 PID: 23320 Comm: madvise06 Not tainted 5.9.0-rc5-next-20200914+ #2
[ 2653.220176][    C4] Hardware name: HP ProLiant BL660c Gen9, BIOS I38 10/17/2018
[ 2653.254908][    C4] RIP: 0010:lock_acquire+0x211/0x8e0
[ 2653.278534][    C4] Code: 83 c0 03 38 d0 7c 08 84 d2 0f 85 3a 05 00 00 8b 85 04 08 00 00 83 e8 01 89 85 04 08 00 00 66 85 c0 0f 85 9a 04 00 00 41 52 9d <48> b8 00 00 00 00 00 fc ff df 48 01 c3 c7 03 00 00 00 00 c7 43 08
[ 2653.369929][    C4] RSP: 0018:ffffc9000e1bf9f0 EFLAGS: 00000246
[ 2653.399398][    C4] RAX: 0000000000000000 RBX: 1ffff92001c37f41 RCX: 1ffff92001c37f27
[ 2653.437720][    C4] RDX: 0000000000000000 RSI: 0000000029956a3e RDI: ffff889042f40844
[ 2653.475829][    C4] RBP: ffff889042f40040 R08: fffffbfff5083905 R09: fffffbfff5083905
[ 2653.511611][    C4] R10: 0000000000000246 R11: fffffbfff5083904 R12: ffffffffa74ce320
[ 2653.547396][    C4] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 2653.582938][    C4] FS:  00007f1fc85e4600(0000) GS:ffff88881e100000(0000) knlGS:0000000000000000
[ 2653.622910][    C4] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2653.652310][    C4] CR2: 0000000000620050 CR3: 000000054d438002 CR4: 00000000001706e0
[ 2653.688228][    C4] Call Trace:
[ 2653.702537][    C4]  ? rcu_read_unlock+0x40/0x40
[ 2653.723647][    C4]  ? find_held_lock+0x33/0x1c0
[ 2653.744708][    C4]  ? __read_swap_cache_async+0x18f/0x870
[ 2653.770547][    C4]  get_swap_device+0xf5/0x280
rcu_read_lock at include/linux/rcupdate.h:642
(inlined by) get_swap_device at mm/swapfile.c:1303
[ 2653.791303][    C4]  ? get_swap_device+0xce/0x280
[ 2653.812693][    C4]  ? swap_page_trans_huge_swapped+0x2a0/0x2a0
[ 2653.839963][    C4]  __read_swap_cache_async+0x10c/0x870
__read_swap_cache_async at mm/swap_state.c:469
[ 2653.864243][    C4]  ? rcu_read_lock_sched_held+0x9c/0xd0
[ 2653.890657][    C4]  ? find_get_incore_page+0x220/0x220
[ 2653.916978][    C4]  ? rcu_read_lock_held+0x9c/0xb0
[ 2653.940235][    C4]  ? find_held_lock+0x33/0x1c0
[ 2653.961325][    C4]  ? do_madvise.part.30+0xd11/0x1b70
[ 2653.984922][    C4]  ? lock_downgrade+0x730/0x730
[ 2654.006502][    C4]  read_swap_cache_async+0x60/0xb0
read_swap_cache_async at mm/swap_state.c:564
[ 2654.029694][    C4]  ? __read_swap_cache_async+0x870/0x870
[ 2654.055486][    C4]  ? xas_find+0x410/0x6c0
[ 2654.074663][    C4]  do_madvise.part.30+0xd47/0x1b70
force_shm_swapin_readahead at mm/madvise.c:243
(inlined by) madvise_willneed at mm/madvise.c:277
(inlined by) madvise_vma at mm/madvise.c:939
(inlined by) do_madvise at mm/madvise.c:1142
[ 2654.097959][    C4]  ? find_held_lock+0x33/0x1c0
[ 2654.119031][    C4]  ? swapin_walk_pmd_entry+0x430/0x430
[ 2654.143518][    C4]  ? down_read_nested+0x420/0x420
[ 2654.165748][    C4]  ? rcu_read_lock_sched_held+0x9c/0xd0
[ 2654.190523][    C4]  ? __x64_sys_madvise+0xa1/0x110
[ 2654.212973][    C4]  __x64_sys_madvise+0xa1/0x110
[ 2654.233976][    C4]  ? syscall_enter_from_user_mode+0x1c/0x50
[ 2654.260983][    C4]  do_syscall_64+0x33/0x40
[ 2654.281132][    C4]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2654.307623][    C4] RIP: 0033:0x7f1fc80fca6b
[ 2654.327125][    C4] Code: 64 89 02 b8 ff ff ff ff c3 48 8b 15 17 54 2c 00 f7 d8 64 89 02 b8 ff ff ff ff eb bc 0f 1f 00 f3 0f 1e fa b8 1c 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ed 53 2c 00 f7 d8 64 89 01 48
[ 2654.420246][    C4] RSP: 002b:00007fff53609998 EFLAGS: 00000202 ORIG_RAX: 000000000000001c
[ 2654.458926][    C4] RAX: ffffffffffffffda RBX: 00007f1fc85e4580 RCX: 00007f1fc80fca6b
[ 2654.494295][    C4] RDX: 0000000000000003 RSI: 0000000019000000 RDI: 00007f1faf006000
[ 2654.530104][    C4] RBP: 00007f1faf006000 R08: 0000000000000000 R09: 00007fff53609284
[ 2654.566057][    C4] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[ 2654.601697][    C4] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
...
[ 2846.587644][  T353] Showing all locks held in the system:
[ 2846.622367][  T353] 1 lock held by khungtaskd/353:
[ 2846.644378][  T353]  #0: ffffffffa74ce320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire.constprop.51+0x0/0x30
[ 2846.695738][  T353] 1 lock held by khugepaged/361:
[ 2846.718056][  T353]  #0: ffffffffa75418e8 (lock#4){+.+.}-{3:3}, at: lru_add_drain_all+0x55/0x5f0
[ 2846.758184][  T353] 1 lock held by madvise06/23320:
[ 2846.780486][  T353] 
[ 2846.790445][  T353] =============================================

> ---
>  mm/madvise.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index dd1d43cf026d..96189acd6969 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -224,25 +224,28 @@ static void force_shm_swapin_readahead(struct
> vm_area_struct *vma,
>  		unsigned long start, unsigned long end,
>  		struct address_space *mapping)
>  {
> -	pgoff_t index;
> +	XA_STATE(xas, &mapping->i_pages, linear_page_index(vma, start));
> +	pgoff_t end_index = end / PAGE_SIZE;
>  	struct page *page;
> -	swp_entry_t swap;
>  
> -	for (; start < end; start += PAGE_SIZE) {
> -		index = ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
> +	rcu_read_lock();
> +	xas_for_each(&xas, page, end_index) {
> +		swp_entry_t swap;
>  
> -		page = find_get_entry(mapping, index);
> -		if (!xa_is_value(page)) {
> -			if (page)
> -				put_page(page);
> +		if (!xa_is_value(page))
>  			continue;
> -		}
> +		rcu_read_unlock();
> +
>  		swap = radix_to_swp_entry(page);
>  		page = read_swap_cache_async(swap, GFP_HIGHUSER_MOVABLE,
>  							NULL, 0, false);
>  		if (page)
>  			put_page(page);
> +
> +		rcu_read_lock();
> +		xas_reset(&xas);
>  	}
> +	rcu_read_unlock();
>  
>  	lru_add_drain();	/* Push any new pages onto the LRU now */
>  }

