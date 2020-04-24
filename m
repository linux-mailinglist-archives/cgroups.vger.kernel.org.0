Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706911B6B9B
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2020 04:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDXCvj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Apr 2020 22:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgDXCvi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Apr 2020 22:51:38 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB30C09B045
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2020 19:51:38 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v26so1231993qto.0
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2020 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8QJoTXqVG0DZe/mQnKE8SNa8hRGYUaKenWzWiibacQo=;
        b=fWyMKe13DTH0WU39blr8r9fcIdg3WBh/22Qxi2N7/ZMi57uMaMHC/LswPiuSjuDGrM
         zAXBsVSEfj/DS2W4JCdcrTiZVmjoKokQ6z5mvtJNnXt7/kv+EPEP+dsi2RmQXk2NPSuM
         yTmXoyi+hqG1qYalmMWuPITt2paqd8GD9tZLfk7uhJDG1NdivLWI3Q5JJ6kGyMrLUiR4
         rfPqA28+wLh8IkDmjIOb6ygNjMVfna281My/tfr+rwPZoX3nJjW4AVXiJTycMOgdiI37
         bkhzmYKfjeH5tajFE8yKQguK2PGATn1ik7TlViwHPVLmrNN6hvRAjDx6Usw6Su+poqmg
         mPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8QJoTXqVG0DZe/mQnKE8SNa8hRGYUaKenWzWiibacQo=;
        b=E6B1agkITc5F1B8SMLcQXMdIfrnAyqieYg0xXzWnrcusUevGQbcw6NwzwQEKTujEVM
         gVOdptMUcMIPIuUBtO2f7QNmbAWHMW8xanrTvQLpbqn3RhK5eGrnGXIwnEb1SUnC0fMa
         mORrXGluCde0ImuxkGqXDZy6dSHK9PA7QfuHLiYcOld2jl63ww/+U7Qjlohixu/w6soI
         3wQ4L+kR81gHqQuqJN1R9NCcNdgJQINlfzoxKEnTDqowLSCprNlGOuDy1cJcLDo+pl3X
         m4coByEo4gY1cprMlmuuLgLYQEwVRq+0Lkw0V/796R8u83iJJXz8YkHy1vTLa+6LjN/M
         GTsw==
X-Gm-Message-State: AGi0PuagcoVWBJ0ugEnAVDwByQr46mqvi1eVpT8sWrPBp3kBo8lI4go6
        uncDC1rZxKwdJW7pI+bZ/zvXXg==
X-Google-Smtp-Source: APiQypINaEFha5KGIe0+/afOHGPj9jlzn31/ef9b0TwirU85PVQm6jcyrfBcvP+omZnqnjFXKevINQ==
X-Received: by 2002:ac8:1bbd:: with SMTP id z58mr7257252qtj.94.1587696697771;
        Thu, 23 Apr 2020 19:51:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::921])
        by smtp.gmail.com with ESMTPSA id 205sm2851782qkj.1.2020.04.23.19.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 19:51:37 -0700 (PDT)
Date:   Thu, 23 Apr 2020 22:51:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 16/18] mm: memcontrol: charge swapin pages on
 instantiation
Message-ID: <20200424025135.GB464082@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-17-hannes@cmpxchg.org>
 <20200424004441.GF13929@js1304-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424004441.GF13929@js1304-desktop>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 24, 2020 at 09:44:42AM +0900, Joonsoo Kim wrote:
> On Mon, Apr 20, 2020 at 06:11:24PM -0400, Johannes Weiner wrote:
> > @@ -412,31 +407,43 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
> >  			 */
> >  			cond_resched();
> >  			continue;
> > -		} else if (err)		/* swp entry is obsolete ? */
> > -			break;
> > -
> > -		/* May fail (-ENOMEM) if XArray node allocation failed. */
> > -		__SetPageLocked(new_page);
> > -		__SetPageSwapBacked(new_page);
> > -		err = add_to_swap_cache(new_page, entry, gfp_mask & GFP_KERNEL);
> > -		if (likely(!err)) {
> > -			/* Initiate read into locked page */
> > -			SetPageWorkingset(new_page);
> > -			lru_cache_add_anon(new_page);
> > -			*new_page_allocated = true;
> > -			return new_page;
> >  		}
> > -		__ClearPageLocked(new_page);
> > -		/*
> > -		 * add_to_swap_cache() doesn't return -EEXIST, so we can safely
> > -		 * clear SWAP_HAS_CACHE flag.
> > -		 */
> > -		put_swap_page(new_page, entry);
> > -	} while (err != -ENOMEM);
> > +		if (err)		/* swp entry is obsolete ? */
> > +			return NULL;
> 
> "if (err)" is not needed since "!err" is already exiting the loop.

But we don't want to leave the loop, we want to leave the
function. For example, if swapcache_prepare() says the entry is gone
(-ENOENT), we don't want to exit the loop and allocate a page for it.

> > +
> > +	/*
> > +	 * The swap entry is ours to swap in. Prepare a new page.
> > +	 */
> > +
> > +	page = alloc_page_vma(gfp_mask, vma, addr);
> > +	if (!page)
> > +		goto fail_free;
> > +
> > +	__SetPageLocked(page);
> > +	__SetPageSwapBacked(page);
> > +
> > +	/* May fail (-ENOMEM) if XArray node allocation failed. */
> > +	if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL))
> > +		goto fail_unlock;
> > +
> > +	if (mem_cgroup_charge(page, NULL, gfp_mask & GFP_KERNEL, false))
> > +		goto fail_delete;
> > +
> 
> I think that following order of operations is better than yours.
> 
> 1. page alloc
> 2. memcg charge
> 3. swapcache_prepare
> 4. add_to_swap_cache
> 
> Reason is that page allocation and memcg charging could take for a
> long time due to reclaim and other tasks waiting this swapcache page
> could be blocked inbetween swapcache_prepare() and add_to_swap_cache().

I see how that would be preferable, but memcg charging actually needs
the swap(cache) information to figure out the cgroup that owned it at
swapout, then uncharge the swapcache and drop the swap cgroup record.

Maybe it could be done, but I'm not sure that level of surgery would
be worth the benefits? Whoever else would be trying to swap the page
in at the same time is likely in the same memory situation, and would
not necessarily be able to allocate pages any faster.
