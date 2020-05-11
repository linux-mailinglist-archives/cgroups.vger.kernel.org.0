Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CCE1CE2F7
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2020 20:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgEKSoi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 May 2020 14:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729727AbgEKSoi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 May 2020 14:44:38 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5194C061A0C
        for <cgroups@vger.kernel.org>; Mon, 11 May 2020 11:44:37 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id c124so15789264oib.13
        for <cgroups@vger.kernel.org>; Mon, 11 May 2020 11:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fUrEOO+y3D6qyRoObBtBb6IstX2hI5RkiWjny9eyf2g=;
        b=ewA66SNz/mrr0YGX9ELb06rzKDiBYl/PL2esub6hnYZ+6TALexrmZPMIB8qJFeEFQd
         IF0LVoeS9dsVfQZcUMGsaoh15m09m9CjX4NdAExvYiE0/lfPlterADU+Q/Hnf8H2j6c5
         YKeM8EpuneuojhKYM0ZC9hT2FBdlQ0DPTdwuXwbmSzlYmwFGpW99Hw0ERgZfBzHvgWvh
         emK8fLJefimnuGZ8BKEF6tl1HinCTmvsETP8ybYotG3S58k+VHH1hK7AmoIPB3ysRIyz
         OYi/+MGYuIcNxIdA/1tjfRm8BlMts+W7Bxv3mcHAWEwsHl934fFKXGUdEH3AwIy91tW2
         szyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fUrEOO+y3D6qyRoObBtBb6IstX2hI5RkiWjny9eyf2g=;
        b=GDO3vnHizEegs87LLoUH6cqz9l0UqDdVLd5JlF2eG526p73Prsap+JaIcnP9yQUGs0
         Q28XI4QmRylb6uilMSNEWc0Pm+BgdqfVMROuc4ho+Mjurp53fvsJyVnMuL/tG78ogIh7
         1CyjXFhPTxV60hyM9NUEfOHgPBSiut8qmaDGYsfRzYgLr5d1d7mAtUQ+zliU1rk5Kx+k
         s8NkXGAVyJmuxvn6xw5Ds8QKZ4nsiKAodyI5kWY3NyVptkXHWYgocMzM9x6yalBMRl41
         tU6LTrupfNU5Sz/z8qim3cdRw9F6aqezcPTr8/jI7kwlTasF5J9nIH6N7h8NTS19wyI6
         pHzg==
X-Gm-Message-State: AGi0PuY5DPoHZy41dNSiXk3SYK1lmV4g1J2JVn5MAh5SJieitk0Wr0EE
        HAKYdGqZKhMPKLjK7tu0y4VUWQ==
X-Google-Smtp-Source: APiQypJPKtawHfjFwCRo/VUEXiQqWma/qUvHGiSpLqc2MhbZsPz2K4KVszWv+9LIbRIbt2YcLxL8/A==
X-Received: by 2002:aca:478e:: with SMTP id u136mr20830110oia.34.1589222676847;
        Mon, 11 May 2020 11:44:36 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k26sm2869896ots.3.2020.05.11.11.44.35
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 11 May 2020 11:44:36 -0700 (PDT)
Date:   Mon, 11 May 2020 11:44:21 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Hugh Dickins <hughd@google.com>, Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 05/18] mm: memcontrol: convert page cache to a new
 mem_cgroup_charge() API
In-Reply-To: <20200511181056.GA339505@cmpxchg.org>
Message-ID: <alpine.LSU.2.11.2005111132450.4088@eggly.anvils>
References: <20200420221126.341272-1-hannes@cmpxchg.org> <20200420221126.341272-6-hannes@cmpxchg.org> <20200422064041.GE6780@js1304-desktop> <20200422120946.GA358439@cmpxchg.org> <20200423052450.GA12538@js1304-desktop> <20200508160122.GB181181@cmpxchg.org>
 <alpine.LSU.2.11.2005102350360.2769@eggly.anvils> <20200511150648.GA306292@cmpxchg.org> <alpine.LSU.2.11.2005110912180.3431@eggly.anvils> <20200511181056.GA339505@cmpxchg.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 11 May 2020, Johannes Weiner wrote:
> 
> Since commit b56a2d8af914 ("mm: rid swapoff of quadratic complexity"),
> shmem_unuse_inode() doesn't have its own copy anymore - it uses
> shmem_swapin_page().
> 
> However, that commit appears to have made shmem's private call to
> delete_from_swap_cache() obsolete as well. Whereas before this change
> we fully relied on shmem_unuse() to find and clear a shmem swap entry
> and its swapcache page, we now only need it to clean out shmem's
> private state in the inode, as it's followed by a loop over all
> remaining swap slots, calling try_to_free_swap() on stragglers.

Great, you've looked deeper into the current situation than I had.

> 
> Unless I missed something, it's still merely an optimization, and we
> can delete it for simplicity:

Yes, nice ---s, simpler code, and a good idea to separate it out
as a precursor: thanks, Hannes.

> 
> ---
> 
> From fc9dcaf68c8b54baf365cd670fb5780c7f0d243f Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 11 May 2020 12:59:08 -0400
> Subject: [PATCH] mm: shmem: remove rare optimization when swapin races with
>  hole punching
> 
> Commit 215c02bc33bb ("tmpfs: fix shmem_getpage_gfp() VM_BUG_ON")
> recognized that hole punching can race with swapin and removed the
> BUG_ON() for a truncated entry from the swapin path.
> 
> The patch also added a swapcache deletion to optimize this rare case:
> Since swapin has the page locked, and free_swap_and_cache() merely
> trylocks, this situation can leave the page stranded in
> swapcache. Usually, page reclaim picks up stale swapcache pages, and
> the race can happen at any other time when the page is locked. (The
> same happens for non-shmem swapin racing with page table zapping.) The
> thinking here was: we already observed the race and we have the page
> locked, we may as well do the cleanup instead of waiting for reclaim.
> 
> However, this optimization complicates the next patch which moves the
> cgroup charging code around. As this is just a minor speedup for a
> race condition that is so rare that it required a fuzzer to trigger
> the original BUG_ON(), it's no longer worth the complications.
> 
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Hugh Dickins <hughd@google.com>
(if one is allowed to suggest and to ack)

> ---
>  mm/shmem.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d505b6cce4ab..729bbb3513cd 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1665,27 +1665,16 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>  	}
>  
>  	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg);
> -	if (!error) {
> -		error = shmem_add_to_page_cache(page, mapping, index,
> -						swp_to_radix_entry(swap), gfp);
> -		/*
> -		 * We already confirmed swap under page lock, and make
> -		 * no memory allocation here, so usually no possibility
> -		 * of error; but free_swap_and_cache() only trylocks a
> -		 * page, so it is just possible that the entry has been
> -		 * truncated or holepunched since swap was confirmed.
> -		 * shmem_undo_range() will have done some of the
> -		 * unaccounting, now delete_from_swap_cache() will do
> -		 * the rest.
> -		 */
> -		if (error) {
> -			mem_cgroup_cancel_charge(page, memcg);
> -			delete_from_swap_cache(page);
> -		}
> -	}
>  	if (error)
>  		goto failed;
>  
> +	error = shmem_add_to_page_cache(page, mapping, index,
> +					swp_to_radix_entry(swap), gfp);
> +	if (error) {
> +		mem_cgroup_cancel_charge(page, memcg);
> +		goto failed;
> +	}
> +
>  	mem_cgroup_commit_charge(page, memcg, true);
>  
>  	spin_lock_irq(&info->lock);
> -- 
> 2.26.2
> 
> 
