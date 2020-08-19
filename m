Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D20249C06
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 13:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHSLnj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 07:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHSLnd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 07:43:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF20C061757;
        Wed, 19 Aug 2020 04:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ak4zJfL3jaSZH9A144fE0Ks6867bEAtu2NTkcDH4RvU=; b=RXOzKbrxZsfW3t1Wc6xtkyc7lT
        I+02t0IG7W47hbjx6qsg4QiL6EcBfdWn2aBpC7gmY52ux5erb1OYdpDwQu58mJ9ZG4hmTgVFgDIMb
        CKVgKq/EMapYfJeCEq7+sPv9fSjNFOr1z7bYFj6ovfyc3jt7+Gpy0dV/1c6OSRwXnmYUu9ayo7G9H
        acNNDxZjmcEBy/nqgab4XdpN5SnxJPNEca2H4ALpDZ/QhF6XGF/hKvoViSs2EYF4g1sUHQMErIgKf
        EqDgis9otkTiDaVkk0eQYqWc/Bxf9X8D3dXkNa/TV+XSz6A0hxRiY7AUM3ESI0ctl2xdYmsUfjk+Y
        R2hAdK3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8MUn-0002W6-IT; Wed, 19 Aug 2020 11:43:09 +0000
Date:   Wed, 19 Aug 2020 12:43:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     alex.shi@linux.alibaba.com, yang.shi@linux.alibaba.com,
        lkp@intel.com, rong.a.chen@intel.com, khlebnikov@yandex-team.ru,
        kirill@shutemov.name, hughd@google.com,
        linux-kernel@vger.kernel.org, daniel.m.jordan@oracle.com,
        linux-mm@kvack.org, shakeelb@google.com, hannes@cmpxchg.org,
        tj@kernel.org, cgroups@vger.kernel.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com
Subject: Re: [RFC PATCH v2 1/5] mm: Identify compound pages sooner in
 isolate_migratepages_block
Message-ID: <20200819114309.GB17456@casper.infradead.org>
References: <20200819041852.23414.95939.stgit@localhost.localdomain>
 <20200819042705.23414.84098.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819042705.23414.84098.stgit@localhost.localdomain>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 18, 2020 at 09:27:05PM -0700, Alexander Duyck wrote:
> +		/*
> +		 * Page is compound. We know the order before we know if it is
> +		 * on the LRU so we cannot assume it is THP. However since the
> +		 * page will have the LRU validated shortly we can use the value
> +		 * to skip over this page for now or validate the LRU is set and
> +		 * then isolate the entire compound page if we are isolating to
> +		 * generate a CMA page.
> +		 */
> +		if (PageCompound(page)) {
> +			const unsigned int order = compound_order(page);
> +
> +			if (likely(order < MAX_ORDER))
> +				low_pfn += (1UL << order) - 1;

Hmm.  You're checking for PageCompound but then skipping 1UL << order.
That only works if PageHead.  If instead this is PageCompound because
it's PageTail, you need to do something like:

				low_pfn |= (1UL << order) - 1;

which will move you to the end of the page you're in the middle of.

If PageTail can't actually happen here, then it's better to check for
PageHead explicitly and WARN_ON if you get a PageTail (eg a page was
combined into a compound page after you processed the earlier head page).

Is it possible the page you've found is hugetlbfs?  Those can have orders
larger than MAX_ORDER.
