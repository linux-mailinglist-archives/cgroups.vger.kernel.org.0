Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4F434075F
	for <lists+cgroups@lfdr.de>; Thu, 18 Mar 2021 15:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhCROBy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Mar 2021 10:01:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:52880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCROB2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 18 Mar 2021 10:01:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616076086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CJKjKFzH2Oz9V1KExzh/D5bnwo5wq9sGnNFQSvBiHoE=;
        b=Wom5vnku1jvAJyVaLvzB9o9HTjhTb0xA6SLbfWE2afD0RUi+h+TnBjUTC5EnU4pVJRzIO6
        RV9e+V0KTVuVkex7bcTAqI5M4I6MA2kENPgPkcOVuPxUUbArdzpB598lQc/wGqF6T6q9ht
        IeQVdK3N+hVid6CnPSTubid4TFs34yw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6390FAB8C;
        Thu, 18 Mar 2021 14:01:26 +0000 (UTC)
Date:   Thu, 18 Mar 2021 15:01:25 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] memcg: set page->private before calling swap_readpage
Message-ID: <YFNdNeczjnmF55bm@dhcp22.suse.cz>
References: <20210318015959.2986837-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318015959.2986837-1-shakeelb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 17-03-21 18:59:59, Shakeel Butt wrote:
> The function swap_readpage() (and other functions it call) extracts swap
> entry from page->private. However for SWP_SYNCHRONOUS_IO, the kernel
> skips the swapcache and thus we need to manually set the page->private
> with the swap entry before calling swap_readpage().

One thing that is not really clear to me is whether/why this is only
needed with your patch. Can you expand a bit on that please? Maybe I am
just missing something obvious but I just do not see any connection.

> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> ---
> 
> Andrew, please squash this into "memcg: charge before adding to
> swapcache on swapin" patch.
> 
>  mm/memory.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index aefd158ae1ea..b6f3410b5902 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3324,7 +3324,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  					workingset_refault(page, shadow);
>  
>  				lru_cache_add(page);
> +
> +				/* To provide entry to swap_readpage() */
> +				set_page_private(page, entry.val);
>  				swap_readpage(page, true);
> +				set_page_private(page, 0);
>  			}
>  		} else {
>  			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 

-- 
Michal Hocko
SUSE Labs
