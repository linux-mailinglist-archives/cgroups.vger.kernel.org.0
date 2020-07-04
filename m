Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9696A214625
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 15:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgGDNdx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 4 Jul 2020 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDNdx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 4 Jul 2020 09:33:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88F7C061794;
        Sat,  4 Jul 2020 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=WX43RKw0+FGdp9bNmImS/2sAa8MNXnNJwwbZw51kMdQ=; b=P6cgPErml8i03xIAD2T2msZxIG
        m8LjhA4KE1VmUJ/jww8W5OIDqMwXNvGXmLJGm4V84vgiHw1Q1sLRBY/KET+hmBWm6YagHqDZOxy1S
        1Cl5YP8V6suzo6wGWC78gJS46MGJpjwrQBxUv7MUsIRJcX5aG7Y+vlV7q/wTWzQA54upC4dU6oywQ
        vNfwjiOvGOpXyTBDyxyFo9KCpqLv4grXWw6HZGrK8fRYYgmfV9wk7OjDtMPRq144R4RlYp+6bxG0r
        b8KTCgPZUJhUs9VACBdSKb2OCv3N6WdQNjMqc6ky2TBcBYCmQnMTCLhZTAfd9qaKHaEari7D+2tOb
        do6pVwFg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jriIM-0002wM-5j; Sat, 04 Jul 2020 13:33:30 +0000
Date:   Sat, 4 Jul 2020 14:33:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        =?utf-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0KXQu9C10LHQvdC40LrQvtCy?= 
        <khlebnikov@yandex-team.ru>, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, Johannes Weiner <hannes@cmpxchg.org>,
        lkp@intel.com, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, shakeelb@google.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, richard.weiyang@gmail.com
Subject: Re: [PATCH v14 15/20] mm/swap: serialize memcg changes during
 pagevec_lru_move_fn
Message-ID: <20200704133330.GP25523@casper.infradead.org>
References: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
 <1593752873-4493-16-git-send-email-alex.shi@linux.alibaba.com>
 <CALYGNiOkA_ZsycF_hqm3XLk55Ek1Mo9w1gO=6EeE35fUtA0i_w@mail.gmail.com>
 <56e395c6-81e7-7163-0d4f-42b91573289f@linux.alibaba.com>
 <20200704113944.GN25523@casper.infradead.org>
 <b6caf0d7-266e-55ea-0c88-656c800af1e3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6caf0d7-266e-55ea-0c88-656c800af1e3@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 04, 2020 at 09:12:46PM +0800, Alex Shi wrote:
> 在 2020/7/4 下午7:39, Matthew Wilcox 写道:
> > On Sat, Jul 04, 2020 at 07:34:59PM +0800, Alex Shi wrote:
> >> That's a great idea! Guess what the new struct we need would be like this?
> >> I like to try this. :)
> >>
> >>
> >> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
> >> index 081d934eda64..d62778c8c184 100644
> >> --- a/include/linux/pagevec.h
> >> +++ b/include/linux/pagevec.h
> >> @@ -20,7 +20,7 @@
> >>  struct pagevec {
> >>         unsigned char nr;
> >>         bool percpu_pvec_drained;
> >> -       struct page *pages[PAGEVEC_SIZE];
> >> +       struct list_head veclist;
> >>  };
> > 
> > pagevecs are used not just for LRU.  If you want to use a list_head for
> > LRU then define a new structure.
> 
> yes, there are much page don't use page->lru, like slab etc. we need a new struct.

That's not what I mean.  Slab pages aren't on the LRU anyway.

Consider the callers of page_cache_delete_batch().  These use a pagevec
for a non-LRU purpose, and they will be much slower with a list_head than
with an array.
