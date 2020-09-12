Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADACD2677FA
	for <lists+cgroups@lfdr.de>; Sat, 12 Sep 2020 07:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgILFMr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Sep 2020 01:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgILFMp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Sep 2020 01:12:45 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACE9C061573
        for <cgroups@vger.kernel.org>; Fri, 11 Sep 2020 22:12:44 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id n18so9645246qtw.0
        for <cgroups@vger.kernel.org>; Fri, 11 Sep 2020 22:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Njp+ra4byHicMXgvdPxLtePVBkgp4wb2zbg5cxZEkM4=;
        b=iXyUt2LRzpeoLUgh0kDhMSlcxhCK6mIo5puDn10FfmsK1xQrBI3ZshP6YvNqkzPYlA
         lgqr2Nvxw2lhmPNwMf0FUJFULtDHvZIsfFXZqyKGHMkDJcXtyFyxeVan8DrDJjM9ou1E
         vmO3KHcuN77V/sNAwxUj+CRADysHR+nxOx6NPHAdhP1rptejdI8tF2+bCXSfofBTF5vy
         bUVUKsya7MTGJRXGvVGrMzYc2tMGgSr5SXvyCiAc1765IiS5z5aZN0apDazRE2+Q06YW
         g7WU4vtN8R378hqJjNVIuq33kXTqZ6TJQFOL2wRYyq+aiFPqq9ztoWnt3X1gP2AUaBwy
         H8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Njp+ra4byHicMXgvdPxLtePVBkgp4wb2zbg5cxZEkM4=;
        b=iQJuleEftnHadNJqNtuyZEBH2FiOLtr+R33qMn/pJOLhL17e89f8eW53E5g8Nf3M4v
         CIGaQd854TG4a69yRHy1+l+arACETKmeoAw2UNwjulEynVVae5UASyZ5QOM7/DSv2voL
         zVb+hUj9THQBcId6wPM90RhROXmcMjLjBbDnBeYdNupweAeTzJ9sPxElmw49NDnQi+s3
         0d6xXfzVyJzwsP6gzuv0avllJ3p+C5YhXmkil94CRFC7upoGimu1vbHdWi74zvS6cb2r
         WsaQurAdglEjyC25d31zPYt8v1G1TKVDdwllf5zPT14IgbRIv4W9vtf/wzG0m+UNaA+s
         8PhA==
X-Gm-Message-State: AOAM533TbsxN4BTM6jiAIMFfj4tWbIDSkAx1dvIiQ+Aqw4gc19/gryBO
        CESxQn0APMla3zxjbkXAojZk1w==
X-Google-Smtp-Source: ABdhPJwlIXtSOGS55cvCMzK0LEF3rUJcYQ/aOfXAtGkYlhPFemnuIgLHzRd3yACtH2lVcUbidLuhMw==
X-Received: by 2002:ac8:4e8f:: with SMTP id 15mr5046605qtp.358.1599887562977;
        Fri, 11 Sep 2020 22:12:42 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r34sm6012007qtr.18.2020.09.11.22.12.37
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 11 Sep 2020 22:12:40 -0700 (PDT)
Date:   Fri, 11 Sep 2020 22:12:27 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alexander Duyck <alexander.duyck@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, shy828301@gmail.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v18 00/32] per memcg lru_lock: reviews
In-Reply-To: <CAKgT0Ucive3RreD3TJt1Fjch_BH2ygFfUnpAJ_1BhsHy74w88g@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2009112058040.23961@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org> <alpine.LSU.2.11.2008241231460.1065@eggly.anvils> <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
 <alpine.LSU.2.11.2009081640070.7256@eggly.anvils> <CAKgT0Uc_L-Tz_rVJiHc5GUK_ZWOs2wRvez4QGf2wwEjx38qnbg@mail.gmail.com> <alpine.LSU.2.11.2009091640490.10087@eggly.anvils> <CAKgT0Ucive3RreD3TJt1Fjch_BH2ygFfUnpAJ_1BhsHy74w88g@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 10 Sep 2020, Alexander Duyck wrote:
> On Wed, Sep 9, 2020 at 5:32 PM Hugh Dickins <hughd@google.com> wrote:
> > On Wed, 9 Sep 2020, Alexander Duyck wrote:
> > > On Tue, Sep 8, 2020 at 4:41 PM Hugh Dickins <hughd@google.com> wrote:
> > > > [PATCH v18 28/32] mm/compaction: Drop locked from isolate_migratepages_block
> > > > Most of this consists of replacing "locked" by "lruvec", which is good:
> > > > but please fold those changes back into 20/32 (or would it be 17/32?
> > > > I've not yet looked into the relationship between those two), so we
> > > > can then see more clearly what change this 28/32 (will need renaming!)
> > > > actually makes, to use lruvec_holds_page_lru_lock(). That may be a
> > > > good change, but it's mixed up with the "locked"->"lruvec" at present,
> > > > and I think you could have just used lruvec for locked all along
> > > > (but of course there's a place where you'll need new_lruvec too).
> > >
> > > I am good with my patch being folded in. No need to keep it separate.
> >
> > Thanks.  Though it was only the "locked"->"lruvec" changes I was
> > suggesting to fold back, to minimize the diff, so that we could
> > see your use of lruvec_holds_page_lru_lock() more clearly - you
> > had not introduced that function at the stage of the earlier patches.
> >
> > But now that I stare at it again, using lruvec_holds_page_lru_lock()
> > there doesn't look like an advantage to me: when it decides no, the
> > same calculation is made all over again in mem_cgroup_page_lruvec(),
> > whereas the code before only had to calculate it once.
> >
> > So, the code before looks better to me: I wonder, do you think that
> > rcu_read_lock() is more expensive than I think it?  There can be
> > debug instrumentation that makes it heavier, but by itself it is
> > very cheap (by design) - not worth branching around.
> 
> Actually what I was more concerned with was the pointer chase that
> required the RCU lock. With this function we are able to compare a
> pair of pointers from the page and the lruvec and avoid the need for
> the RCU lock. The way the old code was working we had to crawl through
> the memcg to get to the lruvec before we could compare it to the one
> we currently hold. The general idea is to use the data we have instead
> of having to pull in some additional cache lines to perform the test.

When you say "With this function...", I think you are referring to
lruvec_holds_page_lru_lock().  Yes, I appreciate what you're doing
there, making calculations from known-stable data, and taking it no
further than the required comparison; and I think (I don't yet claim
to have reviewed 21/32) what you do with it in relock_page_lruvec*()
is an improvement over what we had there before.

But here I'm talking about using it in isolate_migratepages_block()
in 28/32: in this case, the code before evaluated the new lruvec,
compared against the old, and immediately used the new lruvec if
different; whereas using lruvec_holds_page_lru_lock() makes an
almost (I agree not entirely, and I haven't counted cachelines)
equivalent evaluation, but its results have to thrown away when
it's false, then the new lruvec actually calculated and used.

The same "results thrown away" criticism can be made of
relock_page_lruvec*(), but what was done there before your rewrite
in v18 was no better: they both resort to lock_page_lruvec*(page),
working it all out again from page.  And I'm not suggesting that
be changed, not at this point anyway; but 28/32 looks to me
like a regression from what was done there before 28/32.

> 
> > >
> > > > [PATCH v18 29/32] mm: Identify compound pages sooner in isolate_migratepages_block
> > > > NAK. I agree that isolate_migratepages_block() looks nicer this way, but
> > > > take a look at prep_new_page() in mm/page_alloc.c: post_alloc_hook() is
> > > > where set_page_refcounted() changes page->_refcount from 0 to 1, allowing
> > > > a racing get_page_unless_zero() to succeed; then later prep_compound_page()
> > > > is where PageHead and PageTails get set. So there's a small race window in
> > > > which this patch could deliver a compound page when it should not.
> > >
> > > So the main motivation for the patch was to avoid the case where we
> > > are having to reset the LRU flag.
> >
> > That would be satisfying.  Not necessary, but I agree satisfying.
> > Maybe depends also on your "skip" change, which I've not looked at yet?
> 
> My concern is that we have scenarios where isolate_migratepages_block
> could possibly prevent another page from being able to isolate a page.
> I'm mostly concerned with us potentially creating something like an
> isolation leak if multiple threads are doing something like clearing
> and then resetting the LRU flag. In my mind if we clear the LRU flag
> we should be certain we are going to remove the page as otherwise
> another thread would have done it if it would have been allowed
> access.

I agree it's nicer not to TestClearPageLRU unnecessarily; but if the
occasional unnecessary TestClearPageLRU were really a concern, then
there's a lot of more serious places to worry about - page reclaim
is the great isolator that comes first to my mind.

> 
> > > One question I would have is what if
> > > we swapped the code block with the __isolate_lru_page_prepare section?
> > > WIth that we would be taking a reference on the page, then verifying
> > > the LRU flag is set, and then testing for compound page flag bit.
> > > Would doing that close the race window since the LRU flag being set
> > > should indicate that the allocation has already been completed has it
> > > not?
> >
> > Yes, I think that would be safe, and would look better.  But I am
> > very hesitant to give snap assurances here (I've twice missed out
> > a vital PageLRU check from this sequence myself): it is very easy
> > to deceive myself and only see it later.
> 
> I'm not looking for assurances, just sanity checks to make sure I am
> not missing something obvious.
> 
> > If you can see a bug in what's there before these patches, certainly
> > we need to fix it.  But adding non-essential patches to the already
> > overlong series risks delaying it.
> 
> My concern ends up being that if we are clearing the bit and restoring
> it while holding the LRU lock we can effectively cause pages to become
> pseudo-pinned on the LRU. In my mind I would want us to avoid clearing
> the LRU flag until we know we are going to be pulling the page from
> the list once we take the lruvec lock. I interpret clearing of the
> flag to indicate the page has already been pulled, it just hasn't left
> the list yet. With us resetting the bit we are violating that which I
> worry will lead to issues.

Your concern and my concern are different, but we are "on the same page".

I've said repeatedly (to Alex) that I am not at ease with this
TestClearPageLRU() technique: he has got it working, reliably, but
I find it hard to reason about.  Perhaps I'm just too used to what
was there before, but clearing PageLRU and removing from LRU while
holding lru_lock seems natural to me; whereas disconnecting them
leaves us on shaky ground, adding comments and warnings about the
peculiar races involved.  And it adds a pair of atomic operations
on each page in pagevec_lru_move_fn(), which were not needed before.

I want us to go ahead with TestClearPageLRU, to get the series into
mmotm and under wider testing.  But if we accept the lock reordering
in 06/32, then it becomes possible to replace those TestClearPageLRUs
by lock_page_memcg()s: which in principle should be cheaper, but that
will have to be measured.

Hugh
