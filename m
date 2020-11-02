Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022112A2D5A
	for <lists+cgroups@lfdr.de>; Mon,  2 Nov 2020 15:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgKBOtt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Nov 2020 09:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgKBOts (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Nov 2020 09:49:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95849C0617A6;
        Mon,  2 Nov 2020 06:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9Y50BuvtY/Iv9iX09V09H3tcMOFeUq4GX0ITyW7hR88=; b=Fc5EzzbP5uGjYagLwVWe4N7rSc
        dT4LPqKUJQefMq0cWg6QZxnZyzdW0BT/rLNPNmIIzGjo6rnnJx/uNQnCaukD43QfeUz4egAOUJTEN
        EsUPSMhMJLUgnontgXLVFf1k9EJkUYkC4BpE+14S9u/W8QEbfXOis468N/nX2cczNVhkRsKScXYHY
        tpj4XWjN+CWDGuX9qefNrodCFBeuiTggLV5g0NTk4c+wGg7MWemnx0Wt1qSxG5lpOvgIFJITFzZ80
        DB3MVpy1gEYCxw9T6tPp5HHxTX30xlGavqhM697UTSooTwW0jmx5PcZIOUmXva0C6VNnW2SiHnAfe
        ROmfwCBA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZb9D-0007ZT-TK; Mon, 02 Nov 2020 14:49:28 +0000
Date:   Mon, 2 Nov 2020 14:49:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
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
Message-ID: <20201102144927.GN27442@casper.infradead.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-9-git-send-email-alex.shi@linux.alibaba.com>
 <20201102144110.GB724984@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102144110.GB724984@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 02, 2020 at 09:41:10AM -0500, Johannes Weiner wrote:
> On Thu, Oct 29, 2020 at 06:44:53PM +0800, Alex Shi wrote:
> > From: Hugh Dickins <hughd@google.com>
> > 
> > It is necessary for page_idle_get_page() to recheck PageLRU() after
> > get_page_unless_zero(), but holding lru_lock around that serves no
> > useful purpose, and adds to lru_lock contention: delete it.
> > 
> > See https://lore.kernel.org/lkml/20150504031722.GA2768@blaptop for the
> > discussion that led to lru_lock there; but __page_set_anon_rmap() now
> > uses WRITE_ONCE(),
> 
> That doesn't seem to be the case in Linus's or Andrew's tree. Am I
> missing a dependent patch series?
> 
> > and I see no other risk in page_idle_clear_pte_refs() using
> > rmap_walk() (beyond the risk of racing PageAnon->PageKsm, mostly but
> > not entirely prevented by page_count() check in ksm.c's
> > write_protect_page(): that risk being shared with page_referenced()
> > and not helped by lru_lock).
> 
> Isn't it possible, as per Minchan's description, for page->mapping to
> point to a struct anon_vma without PAGE_MAPPING_ANON set, and rmap
> thinking it's looking at a struct address_space?

I don't think it can point to an anon_vma without the ANON bit set.
Minchan's concern in that email was that it might still be NULL.
