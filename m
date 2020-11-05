Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A322A76BA
	for <lists+cgroups@lfdr.de>; Thu,  5 Nov 2020 05:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgKEE5Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Nov 2020 23:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgKEE5Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Nov 2020 23:57:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08EFC0613CF;
        Wed,  4 Nov 2020 20:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=56c9MV1aCT4xOSMBx0nzDfblxOWC6xg3JuAgCQPVoo0=; b=MtP3X+6N16mNIoQ6VM+zP+mX61
        xZhlLyrMFKBSQTOZqsKgI2SCh4tyCwBipKSKtLPZPw8rs9YxwuiECV/9yS6LDhjuFH/I6yx/YIqh2
        AtQ2CarlmnIs0bwEq890VCWLJakxZsRt/8s3NcD0RPGmUylZaF1L6bKy3RznRg6rB5ufu6PPe5U5d
        Ncq+WO3G3/Sbvn4apMoUtQ2IpG80ZqwDA1iTW+8eJ196udcXf4cOm07Ys1UIw3LqCA/zVJwwRmuw2
        i5B/BI2/zdUb/O22aIeIvtNS/a1NmY4r81q25n70CdNrUNdBVoXybkARM3DiDjAYXFkPUUXTds/+G
        eRC2VJXg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaXKY-0003Di-FI; Thu, 05 Nov 2020 04:57:02 +0000
Date:   Thu, 5 Nov 2020 04:57:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
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
Message-ID: <20201105045702.GI17076@casper.infradead.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-9-git-send-email-alex.shi@linux.alibaba.com>
 <20201102144110.GB724984@cmpxchg.org>
 <20201102144927.GN27442@casper.infradead.org>
 <20201102202003.GA740958@cmpxchg.org>
 <b4038b87-cf5a-fcb7-06f4-b98874029615@linux.alibaba.com>
 <20201104174603.GB744831@cmpxchg.org>
 <6eea82d8-e406-06ee-2333-eb6e2f1944e5@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eea82d8-e406-06ee-2333-eb6e2f1944e5@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 05, 2020 at 12:52:05PM +0800, Alex Shi wrote:
> @@ -1054,8 +1054,27 @@ static void __page_set_anon_rmap(struct page *page,
>  	if (!exclusive)
>  		anon_vma = anon_vma->root;
>  
> +	/*
> +	 * w/o the WRITE_ONCE here the following scenario may happens due to
> +	 * store reordering.
> +	 *
> +	 *      CPU 0                                          CPU 1
> +	 *
> +	 * do_anonymous_page				page_idle_clear_pte_refs
> +	 *   __page_set_anon_rmap
> +	 *     page->mapping = anon_vma + PAGE_MAPPING_ANON
> +	 *   lru_cache_add_inactive_or_unevictable()
> +	 *     SetPageLRU(page)
> +	 *                                               rmap_walk
> +	 *                                                if PageAnon(page)
> +	 *
> +	 *  The 'SetPageLRU' may reordered before page->mapping setting, and
> +	 *  page->mapping may set with anon_vma, w/o anon bit, then rmap_walk
> +	 *  may goes to rmap_walk_file() for a anon page.
> +	 */
> +
>  	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
> -	page->mapping = (struct address_space *) anon_vma;
> +	WRITE_ONCE(page->mapping, (struct address_space *) anon_vma);
>  	page->index = linear_page_index(vma, address);
>  }

I don't like these verbose comments with detailed descriptions in
the source code.  They're fine in changelogs, but they clutter the
code, and they get outdated really quickly.  My preference is for
something more brief:

	/*
	 * Prevent page->mapping from pointing to an anon_vma without
	 * the PAGE_MAPPING_ANON bit set.  This could happen if the
	 * compiler stores anon_vma and then adds PAGE_MAPPING_ANON to it.
	 */

