Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A57F1CD2BA
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2020 09:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgEKHiZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 May 2020 03:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgEKHiY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 May 2020 03:38:24 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775C6C061A0E
        for <cgroups@vger.kernel.org>; Mon, 11 May 2020 00:38:24 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k110so6791577otc.2
        for <cgroups@vger.kernel.org>; Mon, 11 May 2020 00:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VP11kHxLwXDXaTzKOz+HMa/draWDszvpLP/hhYf3Fi4=;
        b=ZYITXXk0Sv8/5ieeoX241h0bIN3/+/flJRugchMMNKwGQJF62m7yiaYuZVI0Z2a/Ev
         5jZTGQCU1hQuEquqBEqyiPENflPKm8A85MS4g6fDaKW/l90DVcVfJBVTzPsouTpG3lmj
         lMe15tgjv6BBowKWTrC+EpVWx46wLf1GQtjVgarN9qkIXaHNh4QkeXwgUekIi+xkfIRc
         eT5CVGfVYVNZCpwhTj9das9U5at2ho6q70YrjMSzr+uV3cPM57V5BF6x86vXrNELetjN
         fjLh0Yiub4SlJwlqEienK33bJ5iGStJmdf7jmuufStHuHi9hYYVXfVrWo/QHaGI1kUAY
         B9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VP11kHxLwXDXaTzKOz+HMa/draWDszvpLP/hhYf3Fi4=;
        b=aNpdD8QC+XAEghYoJs3bBbTWD+9Myn7Fb5NK4gY2SGeqNE1v7E3y47MdLeOOROQFwN
         joxfZTZzaHB31FknR21dO7BjAP7XS6uAVl5LtNg8jw0mHpEU5p5TP3hryIj8m8/q684f
         na1KHSFmstSb2EQX/XNVe6Aovl3Po4/rNYiE7zMDKyN8hm4XVXm53piocHL/EFIrBzW0
         /WTLXsue4J3VapAaKv9xTaVeSStt050/IDTxQ4mfnSLcakXySa/XD+4ceIrX+gy8OTYE
         vi88cbvWgysZdb1UdDy38wWXAotApB5ooXpM/2lWk68LSv2fna6ewH0MSdlQiOv6yju7
         RCbw==
X-Gm-Message-State: AGi0Pubq+hlw5e1nr3bKUqWgUIeOv+4koKl83f61DUnrPgdTqBwcFfDx
        +IiMcr7WR71Am1Tnp1iUfFkA5w==
X-Google-Smtp-Source: APiQypISrLk02tj60/eS4sArwh2wB0XcKehRZlfYJebU0VMeRFve1zu672J8EbwdJy+PndQMB8GoXQ==
X-Received: by 2002:a05:6830:19f8:: with SMTP id t24mr10838744ott.326.1589182703345;
        Mon, 11 May 2020 00:38:23 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q3sm2671555oom.12.2020.05.11.00.38.21
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 11 May 2020 00:38:22 -0700 (PDT)
Date:   Mon, 11 May 2020 00:38:04 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 05/18] mm: memcontrol: convert page cache to a new
 mem_cgroup_charge() API
In-Reply-To: <20200508160122.GB181181@cmpxchg.org>
Message-ID: <alpine.LSU.2.11.2005102350360.2769@eggly.anvils>
References: <20200420221126.341272-1-hannes@cmpxchg.org> <20200420221126.341272-6-hannes@cmpxchg.org> <20200422064041.GE6780@js1304-desktop> <20200422120946.GA358439@cmpxchg.org> <20200423052450.GA12538@js1304-desktop> <20200508160122.GB181181@cmpxchg.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 8 May 2020, Johannes Weiner wrote:
> 
> I looked at this some more, as well as compared it to non-shmem
> swapping. My conclusion is - and Hugh may correct me on this - that
> the deletion looks mandatory but is actually an optimization. Page
> reclaim will ultimately pick these pages up.
> 
> When non-shmem pages are swapped in by readahead (locked until IO
> completes) and their page tables are simultaneously unmapped, the
> zap_pte_range() code calls free_swap_and_cache() and the locked pages
> are stranded in the swap cache with no page table references. We rely
> on page reclaim to pick them up later on.
> 
> The same appears to be true for shmem. If the references to the swap
> page are zapped while we're trying to swap in, we can strand the page
> in the swap cache. But it's not up to swapin to detect this reliably,
> it just frees the page more quickly than having to wait for reclaim.

I think you've got all that exactly right, thanks for working it out.
It originates from v3.7's 215c02bc33bb ("tmpfs: fix shmem_getpage_gfp()
VM_BUG_ON") - in which I also had to thank you.

I think I chose to do the delete_from_swap_cache() right there, partly
because of following shmem_unuse_inode() code which already did that,
partly on the basis that while we have to observe the case then it's
better to clean it up, and partly out of guilt that our page lock here
is what had prevented shmem_undo_range() from completing its job; but
I believe you're right that unused swapcache reclaim would sort it out
eventually.

> 
> That being said, my patch introduces potentially undesirable behavior
> (although AFAICS no correctness problem): We should only delete the
> page from swapcache when we actually raced with undo_range - which we
> see from the swap entry having been purged from the page cache
> tree. If we delete the page from swapcache just because we failed to
> charge it, the next fault has to read the still-valid page again from
> the swap device.

Yes.

> 
> I'm going to include this:

I haven't pulled down your V2 series into a tree yet (expecting perhaps
a respin from Alex on top, when I hope to switch over to trying them
both), so haven't looked into the context and may be wrong...

> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e80167927dce..236642775f89 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -640,7 +640,7 @@ static int shmem_add_to_page_cache(struct page *page,
>  		xas_lock_irq(&xas);
>  		entry = xas_find_conflict(&xas);
>  		if (entry != expected)
> -			xas_set_err(&xas, -EEXIST);
> +			xas_set_err(&xas, expected ? -ENOENT : -EEXIST);

Two things on this.

Minor matter of taste, I'd prefer that as
			xas_set_err(&xas, entry ? -EEXIST : -ENOENT);
which would be more general and more understandable -
but what you have written should be fine for the actual callers.

Except... I think returning -ENOENT there will not work correctly,
in the case of a punched hole.  Because (unless you've reworked it
and I just haven't looked) shmem_getpage_gfp() knows to retry in
the case of -EEXIST, but -ENOENT will percolate up to shmem_fault()
and result in a SIGBUS, or a read/write error, when the hole should
just get refilled instead.

Not something that needs fixing in a hurry (it took trinity to
generate this racy case in the first place), I'll take another look
once I've pulled it into a tree (or collected next mmotm) - unless
you've already have changed it around by then.

Hugh

>  		xas_create_range(&xas);
>  		if (xas_error(&xas))
>  			goto unlock;
> @@ -1683,17 +1683,18 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>  	error = shmem_add_to_page_cache(page, mapping, index,
>  					swp_to_radix_entry(swap), gfp,
>  					charge_mm);
> -	/*
> -	 * We already confirmed swap under page lock, and make no
> -	 * memory allocation here, so usually no possibility of error;
> -	 * but free_swap_and_cache() only trylocks a page, so it is
> -	 * just possible that the entry has been truncated or
> -	 * holepunched since swap was confirmed.  shmem_undo_range()
> -	 * will have done some of the unaccounting, now
> -	 * delete_from_swap_cache() will do the rest.
> -	 */
>  	if (error) {
> -		delete_from_swap_cache(page);
> +		/*
> +		 * We already confirmed swap under page lock, but
> +		 * free_swap_and_cache() only trylocks a page, so it
> +		 * is just possible that the entry has been truncated
> +		 * or holepunched since swap was confirmed.
> +		 * shmem_undo_range() will have done some of the
> +		 * unaccounting, now delete_from_swap_cache() will do
> +		 * the rest.
> +		 */
> +		if (error == -ENOENT)
> +			delete_from_swap_cache(page);
>  		goto failed;
>  	}
>  
> 
