Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D642E7B0DCD
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 23:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjI0VCL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 17:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0VCK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 17:02:10 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6696122
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 14:02:08 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7741b18a06aso726669085a.1
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695848528; x=1696453328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9G/HLJ01FZeXOW/EiwRF0i/XwdYFJSfQ3MESOHhln7I=;
        b=KM6Lb2/UoXcwwPn0S2kLK+nUet4U1xQyszFCU/t3o8Ra34cx0wtzJD8pg9yaL/xXGA
         Pj+V1pQmgi6Rq6mUmhIXoz7Gd4BVD1HTvVgpJ7RkdKzMNq9fcXzijMiWx/CrtBbMhouR
         XzuAAk2SCSkbBM+7266H2RJwTWbSXj4xxJ1sgutln42j+1ttFbUVF/bVleE84mqPQdnb
         P3f3ddXucPRZp6g5sB8Kg3WYstAiwk1pjTdGwLXx9AD8ZNDvC0kIAyrSR3csyDJYyKKb
         Ujwagw2oNuOG8CbEb3LjLDdZ9qqHnLwms1gUgSs0lGpUQBl2D1Ct+peD6srgoHLsdZmf
         MgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695848528; x=1696453328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9G/HLJ01FZeXOW/EiwRF0i/XwdYFJSfQ3MESOHhln7I=;
        b=fUmlI1Pr/SivSpGOlwWA1M/TdcW+SC0vWfQ01Z3DAf0WIQmSkYri0jU6CMbQ7KULwF
         y++59hXQHrynojJe0VSdDONMzkBOl3rUDCRBD3E1KgwTncVnYzQEQo5FTzS0qBSP8le/
         YUP3MdiyNcyx3j9aobLnEebBvLWQ1KV9Ovv/S63xkfk7Z2Ywl+983bBg6dK72ohW2gCG
         mgxIyLgmyCYXgJA+MZG1SrJO4gYPnXnhbChGiu5FyQ9wBNCKetdDwGTXUuij2F9jI/qw
         kynpxihbYvszQ+rZ5hJgdszILoQ2uTLmdSI3+V/SpMRgqlG63gJUJ1gdutgOpzc6YC1i
         M5fA==
X-Gm-Message-State: AOJu0YxpVssJdi50iCW1Pjv0PSWgXDELihz50UH9XgOmkRL0mS9Q4vZ7
        H50U5axHPxIL3FRc5QqIC4GUPQ==
X-Google-Smtp-Source: AGHT+IHaNWmq04rPYSAM3Coge8OuS9p8M2ExEAsfXHcLuVDR+WYtFIlfptZTF6VlSNbvXdrlw3fXEg==
X-Received: by 2002:a05:620a:25d4:b0:767:ae40:1cae with SMTP id y20-20020a05620a25d400b00767ae401caemr3203135qko.7.1695848528012;
        Wed, 27 Sep 2023 14:02:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ba06])
        by smtp.gmail.com with ESMTPSA id op34-20020a05620a536200b00772662b7804sm5746480qkn.100.2023.09.27.14.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:02:07 -0700 (PDT)
Date:   Wed, 27 Sep 2023 17:02:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Chris Li <chrisl@kernel.org>
Subject: Re: [PATCH v2 1/2] zswap: make shrinking memcg-aware
Message-ID: <20230927210206.GC399644@cmpxchg.org>
References: <20230919171447.2712746-1-nphamcs@gmail.com>
 <20230919171447.2712746-2-nphamcs@gmail.com>
 <CAJD7tkZqm9ZsAL0triwJPLYuN02jMMS-5Y8DE7TuDJVnOCm_7Q@mail.gmail.com>
 <CA+CLi1httFOg4OM-0Hu3+fOvya4kpacCqN7A0upqOt4-YJiECg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CLi1httFOg4OM-0Hu3+fOvya4kpacCqN7A0upqOt4-YJiECg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 27, 2023 at 09:48:10PM +0200, Domenico Cerasuolo wrote:
> > > @@ -485,6 +487,17 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
> > >         __folio_set_locked(folio);
> > >         __folio_set_swapbacked(folio);
> > >
> > > +       /*
> > > +        * Page fault might itself trigger reclaim, on a zswap object that
> > > +        * corresponds to the same swap entry. However, as the swap entry has
> > > +        * previously been pinned, the task will run into an infinite loop trying
> > > +        * to pin the swap entry again.
> > > +        *
> > > +        * To prevent this from happening, we remove it from the zswap
> > > +        * LRU to prevent its reclamation.
> > > +        */
> > > +       zswap_lru_removed = zswap_remove_swpentry_from_lru(entry);
> > > +
> >
> > This will add a zswap lookup (and potentially an insertion below) in
> > every single swap fault path, right?. Doesn't this introduce latency
> > regressions? I am also not a fan of having zswap-specific details in
> > this path.
> >
> > When you say "pinned", do you mean the call to swapcache_prepare()
> > above (i.e. setting SWAP_HAS_CACHE)? IIUC, the scenario you are
> > worried about is that the following call to charge the page may invoke
> > reclaim, go into zswap, and try to writeback the same page we are
> > swapping in here. The writeback call will recurse into
> > __read_swap_cache_async(), call swapcache_prepare() and get EEXIST,
> > and keep looping indefinitely. Is this correct?

Yeah, exactly.

> > If yes, can we handle this by adding a flag to
> > __read_swap_cache_async() that basically says "don't wait for
> > SWAP_HAS_CACHE and the swapcache to be consistent, if
> > swapcache_prepare() returns EEXIST just fail and return"? The zswap
> > writeback path can pass in this flag and skip such pages. We might
> > want to modify the writeback code to put back those pages at the end
> > of the lru instead of in the beginning.
> 
> Thanks for the suggestion, this actually works and it seems cleaner so I think
> we'll go for your solution.

That sounds like a great idea.

It should be pointed out that these aren't perfectly
equivalent. Removing the entry from the LRU eliminates the lock
recursion scenario on that very specific entry.

Having writeback skip on -EEXIST will make it skip *any* pages that
are concurrently entering the swapcache, even when it *could* wait for
them to finish.

However, pages that are concurrently read back into memory are a poor
choice for writeback anyway, and likely to be removed from swap soon.

So it happens to work out just fine in this case. I'd just add a
comment that explains the recursion deadlock, as well as the
implication of skipping any busy entry and why that's okay.
