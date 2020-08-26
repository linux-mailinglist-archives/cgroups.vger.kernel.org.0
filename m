Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843142533F3
	for <lists+cgroups@lfdr.de>; Wed, 26 Aug 2020 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgHZPth (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Aug 2020 11:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZPt3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Aug 2020 11:49:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C558C061574;
        Wed, 26 Aug 2020 08:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I18u0dNCe4slxMxufMguyF6f9uk6YgWYDMxiYXb8r/M=; b=UkAgccpf8C57KDxqkodEH9olO/
        1uRw550MvDayPZHtymBnFfxwmNtcgF2M6M96967ti7Q0kRqhAJD7EntbGZL40Lyy/dSXmziTiz7Hk
        lbnctZsn662cXzfd6hEb2utiYDSGSBQ9MMuBEMkU4epwpDT9aRW6rBD0kAE2/WhSDIlgYgN0uvYHv
        c5TtMuUjgUaaySu/tXn9XT3Fdu34TLsipV80GR1LCDvPxHlwYwEnRuupZUec5g7a9rqmgnBVv2OwM
        AfLYitWZTrvbKthc6NKOJtYTa0Bz0jsofeKe/qhWz/aTsyo6BYZPDxDJfSEiDV625F6g9O9aiVfKH
        0a4QY2Ng==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAxfX-0005m4-3j; Wed, 26 Aug 2020 15:48:59 +0000
Date:   Wed, 26 Aug 2020 16:48:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] mm: Convert find_get_entry to return the head page
Message-ID: <20200826154859.GT17456@casper.infradead.org>
References: <20200819184850.24779-1-willy@infradead.org>
 <20200819184850.24779-7-willy@infradead.org>
 <20200826150925.GE988805@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826150925.GE988805@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 26, 2020 at 11:09:25AM -0400, Johannes Weiner wrote:
> On Wed, Aug 19, 2020 at 07:48:48PM +0100, Matthew Wilcox (Oracle) wrote:
> > There are only three callers remaining of find_get_entry().
> > find_get_swap_page() is happy to get the head page instead of the subpage.
> > Add find_subpage() calls to find_lock_entry() and pagecache_get_page()
> > to avoid auditing all their callers.
> 
> I believe this would cause a subtle bug in memcg charge moving for pte
> mapped huge pages. We currently skip over tail pages in the range
> (they don't have page->mem_cgroup set) and account for the huge page
> once from the headpage. After this change, we would see the headpage
> and account for it 512 times (or whatever the number is on non-x86).

Hmm ... so if you have the last 511 pages of a huge page mapped, you
actually don't charge for it at all today?

I think you're right that I'd introduce this bug, and so that needs to
be fixed.

> But that aside, I don't quite understand the intent.
> 
> Before, all these functions simply return the base page at @index,
> whether it's a regular page or a tail page.
> 
> Afterwards, find_lock_entry(), find_get_page() et al still do, but
> find_get_entry() returns headpage at @index & HPAGE_CACHE_INDEX_MASK.
> 
> Shouldn't we be consistent about how we handle huge pages when
> somebody queries the tree for a given base page index?
> 
> [ Wouldn't that mean that e.g. find_get_swap_page() would return tail
>   pages for regular files and head pages for shmem files? ]

What I'd _like_ to do is convert all the callers to cope with tail
pages never being returned from all the find_* functions.  That seems
like a lot of disruption.

My intent in this series is to get all the find_*_entr{y,ies}
functions to the point where they don't return tail pages.
Also find_get_pages_tag() because tags are only set on head pages.

This is generally what the callers want anyway.  There's even a hack
in find_get_entries() in current to terminate early on finding a THP
(see commit 71725ed10c40696dc6bdccf8e225815dcef24dba).  If I want
to remove that, I need to do _something_ to not put all the subpages
of a THP into the pagevec.

So the new rule will be that find_*_entry() don't return tail pages but
find_*_page() do.  With the full THP patchset in place, THPs become quite
common, so bugs in this area will surface quickly instead of lingering
for years and only popping out in rare circumstances.
