Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E83262458
	for <lists+cgroups@lfdr.de>; Wed,  9 Sep 2020 03:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgIIBBm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Sep 2020 21:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIIBBm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Sep 2020 21:01:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F476C061573;
        Tue,  8 Sep 2020 18:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fVCZ2gAQlCOU+3FQ8zVoZg2a2/Nz/JlYFnCb9jL8Xz0=; b=SNQjPYWHMmaFL7LKw4GX4WfZlG
        jqCZi08dIMAMm78xsBxjzttVxrreGfM/VkZblsnmw7u/IjfZA+8cVbKcrhuXgKI68/lQkiNTvpJaA
        u1d9lIuxE++qMUdBjM8NP9Nl1GoK2hBFIkf0ewekXxEkrV+ppWkaOTpuGF6WRGAQxKWB6whYUtJpo
        aT0MUfU+Bo51JVvUpzB7d6JWHzb0XJcx7osuTkygosX4d9xlTPLYgjwCgGJzFdjocTow9gyLfIPAB
        PO3jgrUt0dAMTn/b7ZVGH2K+aFTTflDztYCCY98ocrpLwT6fUGwc1K6lN2N7IPFzDI4Azpo4w8Ylu
        H/nmn/kA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFoUA-0006Dw-54; Wed, 09 Sep 2020 01:01:18 +0000
Date:   Wed, 9 Sep 2020 02:01:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH v18 31/32] mm: Add explicit page decrement in exception
 path for isolate_lru_pages
Message-ID: <20200909010118.GB6583@casper.infradead.org>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598273705-69124-32-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598273705-69124-32-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 24, 2020 at 08:55:04PM +0800, Alex Shi wrote:
> +++ b/mm/vmscan.c
> @@ -1688,10 +1688,13 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>  
>  			if (!TestClearPageLRU(page)) {
>  				/*
> -				 * This page may in other isolation path,
> -				 * but we still hold lru_lock.
> +				 * This page is being isolated in another
> +				 * thread, but we still hold lru_lock. The
> +				 * other thread must be holding a reference
> +				 * to the page so this should never hit a
> +				 * reference count of 0.
>  				 */
> -				put_page(page);
> +				WARN_ON(put_page_testzero(page));
>  				goto busy;

I read Hugh's review and that led me to take a look at this.  We don't
do it like this.  Use the same pattern as elsewhere in mm:

        page_ref_sub(page, nr);
        VM_BUG_ON_PAGE(page_count(page) <= 0, page);

