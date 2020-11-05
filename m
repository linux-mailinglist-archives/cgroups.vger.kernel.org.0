Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5997A2A8258
	for <lists+cgroups@lfdr.de>; Thu,  5 Nov 2020 16:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbgKEPih (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Nov 2020 10:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731204AbgKEPig (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Nov 2020 10:38:36 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C310BC0613CF
        for <cgroups@vger.kernel.org>; Thu,  5 Nov 2020 07:38:36 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id d1so869698qvl.6
        for <cgroups@vger.kernel.org>; Thu, 05 Nov 2020 07:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gJn4RrhgML8VnnTGge57cXSGujNjtgZ05i1FRRImWao=;
        b=e8y3o+IKqhhxV7akZZldI6gyK1nc1DOad8e1uBzEMak6DsXvwHPrRI8r3GWOaI+yoP
         dk31zHh4gAAoOXdGxC4LA0dB3GCRCzaDpN6BHMXyTXBtwLOKKtG4zwcHcGfhosDznZ8x
         Fgj95HDnzganMbEoxUo6h1vOvPr34F6a4g/+u+YmQCKqTo2FydNqWiEDSCFp040h47sH
         V0HEAytJrVwkVWml2z5K3OdZruFcjWXcUgkysE5tgSAMOqyzZfmP0V5U+n8TVKw0FdLu
         dbeRygU1pwJ+U3OATtx7ElipTO3sccVxMtzBEkVZLy5NzKQvhV1fofu1iWN86fw7fH4v
         7vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gJn4RrhgML8VnnTGge57cXSGujNjtgZ05i1FRRImWao=;
        b=t2kYag/Xfx8Q9W+YZ7RWYo+/y4SQvqU8EsEaR06OPhIBXyjlXq3k7G6P77dZ77BdbH
         g2JJcLvAtWzR596+/dHhXUL4LEYw5fC28VX9fSKcX0/7NH6oJ3BRAE5hR5+KGQS1nSKC
         Tor37yU5LVmJ00e60DcVodfDQf67gHdpoOgh0hunoqOvmsStox8WH+f4tZcD9v6QjCs1
         aSWjS783Dj3R9tQd/mZbpS+jUxgwL87gWfHqddoblB6du1h+kV+UpVZ/NhblumxEWZNi
         4eias7zI26kyJ/ov0HVOhuCTWkNeQ5AxEO5l2pHxOo9dND2/e6CLKkyE6SrwZKEoAD2m
         TcRg==
X-Gm-Message-State: AOAM533H7A1GIj4Fnx8WSk0dmRW82L57WgGaQsDx9xt4Im6i2R0MvdnY
        O/90hQygav8YGsTfgMFD8i7goA==
X-Google-Smtp-Source: ABdhPJznRNE8E9a5EXrGvaKmLqQRIxP/m+auIfdNbAsuBf75INXE3XnVMIGAaRoz7CO/MkSMjRnUHQ==
X-Received: by 2002:a05:6214:401:: with SMTP id z1mr2772209qvx.53.1604590715972;
        Thu, 05 Nov 2020 07:38:35 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:fc05])
        by smtp.gmail.com with ESMTPSA id x75sm1244661qka.59.2020.11.05.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:38:35 -0800 (PST)
Date:   Thu, 5 Nov 2020 10:36:49 -0500
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
Message-ID: <20201105153649.GC744831@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-9-git-send-email-alex.shi@linux.alibaba.com>
 <20201102144110.GB724984@cmpxchg.org>
 <20201102144927.GN27442@casper.infradead.org>
 <20201102202003.GA740958@cmpxchg.org>
 <b4038b87-cf5a-fcb7-06f4-b98874029615@linux.alibaba.com>
 <20201104174603.GB744831@cmpxchg.org>
 <6eea82d8-e406-06ee-2333-eb6e2f1944e5@linux.alibaba.com>
 <20201105045702.GI17076@casper.infradead.org>
 <1e8f0162-cf2e-03eb-e7e0-ccc9f6a3eaf2@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e8f0162-cf2e-03eb-e7e0-ccc9f6a3eaf2@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 05, 2020 at 01:03:18PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/11/5 下午12:57, Matthew Wilcox 写道:
> > On Thu, Nov 05, 2020 at 12:52:05PM +0800, Alex Shi wrote:
> >> @@ -1054,8 +1054,27 @@ static void __page_set_anon_rmap(struct page *page,
> >>  	if (!exclusive)
> >>  		anon_vma = anon_vma->root;
> >>  
> >> +	/*
> >> +	 * w/o the WRITE_ONCE here the following scenario may happens due to
> >> +	 * store reordering.
> >> +	 *
> >> +	 *      CPU 0                                          CPU 1
> >> +	 *
> >> +	 * do_anonymous_page				page_idle_clear_pte_refs
> >> +	 *   __page_set_anon_rmap
> >> +	 *     page->mapping = anon_vma + PAGE_MAPPING_ANON
> >> +	 *   lru_cache_add_inactive_or_unevictable()
> >> +	 *     SetPageLRU(page)
> >> +	 *                                               rmap_walk
> >> +	 *                                                if PageAnon(page)
> >> +	 *
> >> +	 *  The 'SetPageLRU' may reordered before page->mapping setting, and
> >> +	 *  page->mapping may set with anon_vma, w/o anon bit, then rmap_walk
> >> +	 *  may goes to rmap_walk_file() for a anon page.
> >> +	 */
> >> +
> >>  	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
> >> -	page->mapping = (struct address_space *) anon_vma;
> >> +	WRITE_ONCE(page->mapping, (struct address_space *) anon_vma);
> >>  	page->index = linear_page_index(vma, address);
> >>  }
> > 
> > I don't like these verbose comments with detailed descriptions in
> > the source code.  They're fine in changelogs, but they clutter the
> > code, and they get outdated really quickly.  My preference is for
> > something more brief:
> > 
> > 	/*
> > 	 * Prevent page->mapping from pointing to an anon_vma without
> > 	 * the PAGE_MAPPING_ANON bit set.  This could happen if the
> > 	 * compiler stores anon_vma and then adds PAGE_MAPPING_ANON to it.
> > 	 */
> > 

Yeah, I don't think this scenario warrants the full race diagram in
the code itself.

But the code is highly specific - synchronizing one struct page member
for one particular use case. Let's keep at least a reference to what
we are synchronizing against. There is a non-zero chance that if the
comment goes out of date, so does the code. How about this?

	/*
	 * page_idle does a lockless/optimistic rmap scan on page->mapping.
	 * Make sure the compiler doesn't split the stores of anon_vma and
	 * the PAGE_MAPPING_ANON type identifier, otherwise the rmap code
	 * could mistake the mapping for a struct address_space and crash.
	 */
