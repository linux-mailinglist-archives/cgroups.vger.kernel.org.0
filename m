Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7BB34A068
	for <lists+cgroups@lfdr.de>; Fri, 26 Mar 2021 05:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCZEFd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Mar 2021 00:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhCZEFF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Mar 2021 00:05:05 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F17C061763
        for <cgroups@vger.kernel.org>; Thu, 25 Mar 2021 21:05:04 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id s11-20020a056830124bb029021bb3524ebeso4142508otp.0
        for <cgroups@vger.kernel.org>; Thu, 25 Mar 2021 21:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xeJRI/bSrn1eC4w9Rqatogj3zx30m75cryPTZk0CO7o=;
        b=wIoSYann9vLV5TBBngoEF/fhWRXoVEs2/a/Nma/eiT81J6J79Ec1J2FRlo036zBd17
         6j2v7Nrk+eQlCwdKc/b5X3Cn4GStVjxNug8VVdVnB66+vhUE4q1EvVG8NfXfCQIa4jnm
         8Lkn0zKQX9xndeM9wR6TU2ecnWyT5QdGfDzcELVCrwlA0f/n9QTzWowTd3AWTFvEUuRX
         KSp5F435PbNcqtkv3K0aliXXoGKExDfDBAQ7LW24N8EPrdK5b3xeN370kioD4ps9ECS8
         ibR60tg+18LUMuZ5XOLjeQvWY9Hd5WGylFGu6Sj7m6HPwE8lRARm/JLe0Ih09NibUU38
         PEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xeJRI/bSrn1eC4w9Rqatogj3zx30m75cryPTZk0CO7o=;
        b=Lj5rA2rkyHv65SvCNDEBYYiONG43xu8+AXGU3CF/lQ9hrC293RabeM5BeBQnjHOKGE
         4ZwBHWB9jp8SEbpZO6fIhM/6/o3L5D0IRVHuP6FVHdMNhOMbf6bOq3c/qyrzao3+Oz2G
         i/DbksL/1+AHRPNBXLPsM8FyX7wLB1yAWYHMzSUg7AV9+VV1mtk2DPWo9/Shs49oFoEL
         arkaFmXRCQOBdys7W42utj4tBlBc1d7m8kWvDeNFLIg3Fvy51rzX32hlsnTrvittH4pW
         j+VT99I+Q2ameFIf1HMqEn2uYHbs2d+7mWElv9C5Y2AfM6jMivEh7ySSxQL95JueEO0r
         SAlw==
X-Gm-Message-State: AOAM533YfvBK8u2BNSDVxwzMTtOSoMOVVsOm5ozeviOjQ5XeZGPeruzr
        WzK9FbyYcWIMbQgps6Hkr+RMGw==
X-Google-Smtp-Source: ABdhPJz44gh3DvCn74zpPfoS1tLJ52JmVUH8jZdUZkgM1yYxXyHp7Rs6+k+P716C96ZuSMbVe6Ptsg==
X-Received: by 2002:a9d:d89:: with SMTP id 9mr10342469ots.23.1616731503946;
        Thu, 25 Mar 2021 21:05:03 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o197sm1719716ooo.44.2021.03.25.21.05.02
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 25 Mar 2021 21:05:03 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:04:40 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: page_alloc: fix memcg accounting leak in speculative
 cache lookup
In-Reply-To: <20210326025143.GB1719932@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2103252018170.13067@eggly.anvils>
References: <20210319071547.60973-1-hannes@cmpxchg.org> <alpine.LSU.2.11.2103191814040.1043@eggly.anvils> <YFo7SOni0s0TbXUm@cmpxchg.org> <alpine.LSU.2.11.2103231310020.5513@eggly.anvils> <alpine.LSU.2.11.2103251716160.12404@eggly.anvils>
 <20210326025143.GB1719932@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 26 Mar 2021, Matthew Wilcox wrote:
> On Thu, Mar 25, 2021 at 06:55:42PM -0700, Hugh Dickins wrote:
> > The first reason occurred to me this morning.  I thought I had been
> > clever to spot the PageHead race which you fix here.  But now I just feel
> > very stupid not to have spotted the very similar memcg_data race.  The
> > speculative racer may call mem_cgroup_uncharge() from __put_single_page(),
> > and the new call to split_page_memcg() do nothing because page_memcg(head)
> > is already NULL.
> > 
> > And is it even safe there, to sprinkle memcg_data through all of those
> > order-0 subpages, when free_the_page() is about to be applied to a
> > series of descending orders?  I could easily be wrong, but I think
> > free_pages_prepare()'s check_free_page() will find that is not
> > page_expected_state().
> 
> So back to something more like my original patch then?
> 
> +++ b/mm/page_alloc.c
> @@ -5081,9 +5081,15 @@ void __free_pages(struct page *page, unsigned int order)
>  {
>         if (put_page_testzero(page))
>                 free_the_page(page, order);
> -	else if (!PageHead(page))
> -               while (order-- > 0)
> -                       free_the_page(page + (1 << order), order);
> +       else if (!PageHead(page)) {
> +               while (order-- > 0) {
> +                       struct page *tail = page + (1 << order);
> +#ifdef CONFIG_MEMCG
> +                       tail->memcg_data = page->memcg_data;
> +#endif
> +                       free_the_page(tail, order);
> +               }
> +       }
>  }
>  EXPORT_SYMBOL(__free_pages);
> 
> We can cache page->memcg_data before calling put_page_testzero(),
> just like we cache the Head flag in Johannes' patch.

If I still believed in e320d3012d25, yes, that would look right
(but I don't have much faith in my judgement after all this).

I'd fallen in love with split_page_memcg() when you posted that
one, and was put off by your #ifdef, so got my priorities wrong
and went for the split_page_memcg().

> 
> > But, after all that, I'm now thinking that Matthew's original
> > e320d3012d25 ("mm/page_alloc.c: fix freeing non-compound pages")
> > is safer reverted.  The put_page_testzero() in __free_pages() was
> > not introduced for speculative pagecache: it was there in 2.4.0,
> > and atomic_dec_and_test() in 2.2, I don't have older trees to hand.
> 
> I think you're confused in that last assertion.  According to
> linux-fullhistory, the first introduction of __free_pages was 2.3.29pre3
> (September 1999), where it did indeed use put_page_testzero:

Not confused, just pontificating from a misleading subset of the data.
I knew there's an even-more-history-than-tglx git tree somewhere, but
what I usually look back to is 2.4 trees, plus a 2.2.26 tree - but of
course that's a late 2.2, from 2004, around the same time as 2.6.3.
That tree shows a __free_pages() using atomic_dec_and_test().

But we digress...

> 
> +extern inline void __free_pages(struct page *page, unsigned long order)
> +{
> +       if (!put_page_testzero(page))
> +               return;
> +       __free_pages_ok(page, order);
> +}
> 
> Before that, we had only free_pages() and __free_page().
> 
> > So, it has "always" been accepted that multiple references to a
> > high-order non-compound page can be given out and released: maybe
> > they were all released with __free_pages() of the right order, or
> > maybe only the last had to get that right; but as __free_pages()
> > stands today, all but the last caller frees all but the first
> > subpage.  A very rare leak seems much safer.
> > 
> > I don't have the answer (find somewhere in struct page to squirrel
> > away the order, even when it's a non-compound page?), and I think
> > each of us would much rather be thinking about other things at the
> > moment.  But for now it looks to me like NAK to this patch, and
> > revert of e320d3012d25.
> 
> We did discuss that possibility prior to the introduction of
> e320d3012d25.  Here's one such:
> https://lore.kernel.org/linux-mm/20200922031215.GZ32101@casper.infradead.org/T/#m0b08c0c3430e09e20fa6648877dc42b04b18e6f3

Thanks for the link. And I'll willingly grant that your experience is
vast compared to mine. But "Drivers don't do that, in my experience"
is not a convincing reason to invalidate a way of working that the
code has gone out of its way to allow for, for over twenty years.

But you make a good point on the "Bad page" reports that would now
be generated: maybe that will change my mind later on.

Hugh
