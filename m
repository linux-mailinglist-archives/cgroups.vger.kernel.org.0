Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B552A6C24
	for <lists+cgroups@lfdr.de>; Wed,  4 Nov 2020 18:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgKDRru (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Nov 2020 12:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730797AbgKDRru (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Nov 2020 12:47:50 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6982C0613D3
        for <cgroups@vger.kernel.org>; Wed,  4 Nov 2020 09:47:49 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 140so20094861qko.2
        for <cgroups@vger.kernel.org>; Wed, 04 Nov 2020 09:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7p9nMEZ9CzGNR2nnoc/NmQ6U82GjuP7yX7DwiANzfMc=;
        b=rli6FwsWHB6cip/0jF9V7BsRWZHrrjIg7apvuKsE1Kge0E1dkDcIwIFohwKtLUNDAk
         wz/XglDjWFEulLaAfpTOkI/0Uc4V5g+ashXdnCpUU5Y67NkbPnjYcHowLSGV3qpV1sm8
         PXa4wmOaVMSbRNKZO03cdu+YlTVXPEjInI04LrO59b8qeBsErr+oo5tT/Kqu6AQo2ZRk
         65sCqy2Xavh+oMTSK1yv/QuMP9HCT8mS1vrN5D4TUL9Ved1CVkPbN6xpb49UcVVNb2VC
         YNORrzogpHxam/vez2HbOF4GRctTlLzbSWFf3SULmRcwcG/9bFvtEV/CyaxRuImJqqNG
         bpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7p9nMEZ9CzGNR2nnoc/NmQ6U82GjuP7yX7DwiANzfMc=;
        b=Y7R/x2pmlyOiZXYSMg0llsCrVhN7fuGjVBUvWelq8tre2lXX8v6jrBTJ2BwZMR253u
         lC002cvaYVcbo6G0OLxm1WopxCKTDB9Vw987b/XKXij3GX3DrHQnV0u4z1z7XGTMgdX/
         tkGoiLcZVWLw4CjT0a/7KoG9pTB1zPiquf81YBy9Hvor3tlRH6f6SUz1r0UrnexueZ7Y
         pam50GTmEH7EvdXxtVoq1N+TGHoJntBo1PcRfxpP+XohzDLtOo2JikJO4OdO48dRO6KR
         dPSvxIw61nMNEaVAkS3IxBWSTUP5JoxztHaPyKFKbuZVmmoOZQSXqT+R4BphArfeEALl
         d+rw==
X-Gm-Message-State: AOAM532FzMpoGkdjkkLwA9oCKEVnfGlPHYLX0g6VV0uEpwugqG72FW7Q
        RIcjMFNrQhg5m6mb5dgQHVeqGA==
X-Google-Smtp-Source: ABdhPJyMmSWtU9YdDH6PIQ8KMI59p6etR+e16HXhCBMFokoPryGCTptpZglCy4FPpuIv5MAhH7H3vA==
X-Received: by 2002:a37:8542:: with SMTP id h63mr27249718qkd.102.1604512068975;
        Wed, 04 Nov 2020 09:47:48 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:9e9e])
        by smtp.gmail.com with ESMTPSA id d145sm2908052qke.83.2020.11.04.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:47:48 -0800 (PST)
Date:   Wed, 4 Nov 2020 12:46:03 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v20 08/20] mm: page_idle_get_page() does not need lru_lock
Message-ID: <20201104174603.GB744831@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-9-git-send-email-alex.shi@linux.alibaba.com>
 <20201102144110.GB724984@cmpxchg.org>
 <20201102144927.GN27442@casper.infradead.org>
 <20201102202003.GA740958@cmpxchg.org>
 <b4038b87-cf5a-fcb7-06f4-b98874029615@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4038b87-cf5a-fcb7-06f4-b98874029615@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 04, 2020 at 07:27:21PM +0800, Alex Shi wrote:
> 在 2020/11/3 上午4:20, Johannes Weiner 写道:
> > On Mon, Nov 02, 2020 at 02:49:27PM +0000, Matthew Wilcox wrote:
> >> On Mon, Nov 02, 2020 at 09:41:10AM -0500, Johannes Weiner wrote:
> >>> On Thu, Oct 29, 2020 at 06:44:53PM +0800, Alex Shi wrote:
> >>>> From: Hugh Dickins <hughd@google.com>
> >>>>
> >>>> It is necessary for page_idle_get_page() to recheck PageLRU() after
> >>>> get_page_unless_zero(), but holding lru_lock around that serves no
> >>>> useful purpose, and adds to lru_lock contention: delete it.
> >>>>
> >>>> See https://lore.kernel.org/lkml/20150504031722.GA2768@blaptop for the
> >>>> discussion that led to lru_lock there; but __page_set_anon_rmap() now
> >>>> uses WRITE_ONCE(),
> >>>
> >>> That doesn't seem to be the case in Linus's or Andrew's tree. Am I
> >>> missing a dependent patch series?
> >>>
> >>>> and I see no other risk in page_idle_clear_pte_refs() using
> >>>> rmap_walk() (beyond the risk of racing PageAnon->PageKsm, mostly but
> >>>> not entirely prevented by page_count() check in ksm.c's
> >>>> write_protect_page(): that risk being shared with page_referenced()
> >>>> and not helped by lru_lock).
> >>>
> >>> Isn't it possible, as per Minchan's description, for page->mapping to
> >>> point to a struct anon_vma without PAGE_MAPPING_ANON set, and rmap
> >>> thinking it's looking at a struct address_space?
> >>
> >> I don't think it can point to an anon_vma without the ANON bit set.
> >> Minchan's concern in that email was that it might still be NULL.
> > 
> > Hm, no, the thread is a lengthy discussion about whether the store
> > could be split such that page->mapping is actually pointing to
> > something invalid (anon_vma without the PageAnon bit).
> > 
> > From his email:
> > 
> >         CPU 0                                                                           CPU 1
> > 
> > do_anonymous_page
> >   __page_set_anon_rmap
> >   /* out of order happened so SetPageLRU is done ahead */
> >   SetPageLRU(page)
> 
> This SetPageLRU done in __pagevec_lru_add_fn() which under the lru_lock
> protection, so the original memory barrier or lock concern isn't
> correct. that means, the SetPageLRU isn't possible to be here.
> And then no warry on right side 'CPU 1' problem.

The SetPageLRU is done under lru_lock, but the store to page->mapping
is not, so what ensures ordering between them? And what prevents the
compiler from tearing the store to page->mapping?

The writer does this:

	CPU 0
	page_add_new_anon_rmap()
	  page->mapping = anon_vma + PAGE_MAPPING_ANON
	lru_cache_add_inactive_or_unevictable()
	  spin_lock(lruvec->lock)
	  SetPageLRU()
	  spin_unlock(lruvec->lock)

The concern is what CPU 1 will observe at page->mapping after
observing PageLRU set on the page.

1. anon_vma + PAGE_MAPPING_ANON

   That's the in-order scenario and is fine.

2. NULL

   That's possible if the page->mapping store gets reordered to occur
   after SetPageLRU. That's fine too because we check for it.

3. anon_vma without the PAGE_MAPPING_ANON bit

   That would be a problem and could lead to all kinds of undesirable
   behavior including crashes and data corruption.

   Is it possible? AFAICT the compiler is allowed to tear the store to
   page->mapping and I don't see anything that would prevent it.

That said, I also don't see how the reader testing PageLRU under the
lru_lock would prevent that in the first place. AFAICT we need that
WRITE_ONCE() around the page->mapping assignment that's referenced in
the changelog of this patch but I cannot find in any tree or patch.
