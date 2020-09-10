Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2FD2647FD
	for <lists+cgroups@lfdr.de>; Thu, 10 Sep 2020 16:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIJO3T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Sep 2020 10:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731139AbgIJO1R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Sep 2020 10:27:17 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734F8C061796;
        Thu, 10 Sep 2020 07:25:09 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g128so7223528iof.11;
        Thu, 10 Sep 2020 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJbG0wJxu+3OkwLFEOd0Ennw5o6VsPA/l71MgV2bL8A=;
        b=CsIlPa7kgf5QyQFS8hC4+hb0L/bF/jNeX8ymjdfPGndzk6+fjtb6UPlyyDOgn9T/Rj
         dcNmQZtqRILJ5b0WMWAc4ARCiPRsOwn3OAskLXH4wSnP6Fci/pDDyc9GoV3CkuB65CRE
         gCg/SteaRqwF7agvOR3wOsgUovXU4Sk9WMgkXj7yL2Q8Osfwx9Q9xYGiSHVOIpXEQ5A/
         yTEI8iUxit6bTdUVaNNcOqXYtIqzxR47TjMSxqbx8tT+xNLFdbC99+e8WoQz4furBy7G
         kgFpOOKohzSXDEmsL3JJgxTPGBG3JAgnQ2qg4iT0sUE0gv9NfreIR9dAMEP/R00EWqml
         ypGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJbG0wJxu+3OkwLFEOd0Ennw5o6VsPA/l71MgV2bL8A=;
        b=m305sujl89sqGb3s93TS12t8M3gcv94pf0kVCn9YMYkglB841PjXYCqgiBKU9bYinG
         q742Pzm1OKoxTb0qklN2+oOrl+1y2VnMXTu+odTd6w6aT7pI21uP1IJ4pQzgiT5F0Mg+
         JTKLcMy9psarNhE6VUqFr2y5IP855ZZMyXupnh5kJIigoptUKbmOFfjZ9mMxoCo16fNq
         +zmYdXdYBfevZXiyl+pNA+bXOMT81nneI7wKqDnMZYCe/nce4UzADf2Lym8SYsajgp5n
         YZUxOL/GkuMs/oe1VqDUopj4CevUrCBQshEvFZBHTxTjcSoEYD8wW+Ylp7y5/ptw1zGu
         n6Jg==
X-Gm-Message-State: AOAM531h5gcPtFfQHdXUg2FXuYUUZUOSlZ5CCxiWXtsMf8nBViXysbVq
        UDjh/DRM2H22LJT6IaZE8OgLpLmv4ilK3BqVSfM=
X-Google-Smtp-Source: ABdhPJyHLAehFart54v04ZVzdd9dYoO1X/9VyzBD35P5qq8nrYTHzo/wmLH9Bi9dzeOL0T4JorwX9diu/ssyuf15Fzg=
X-Received: by 2002:a05:6602:240c:: with SMTP id s12mr7606501ioa.5.1599747907552;
 Thu, 10 Sep 2020 07:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils> <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
 <alpine.LSU.2.11.2009081640070.7256@eggly.anvils> <CAKgT0Uc_L-Tz_rVJiHc5GUK_ZWOs2wRvez4QGf2wwEjx38qnbg@mail.gmail.com>
 <alpine.LSU.2.11.2009091640490.10087@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2009091640490.10087@eggly.anvils>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 10 Sep 2020 07:24:56 -0700
Message-ID: <CAKgT0Ucive3RreD3TJt1Fjch_BH2ygFfUnpAJ_1BhsHy74w88g@mail.gmail.com>
Subject: Re: [PATCH v18 00/32] per memcg lru_lock: reviews
To:     Hugh Dickins <hughd@google.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 9, 2020 at 5:32 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Wed, 9 Sep 2020, Alexander Duyck wrote:
> > On Tue, Sep 8, 2020 at 4:41 PM Hugh Dickins <hughd@google.com> wrote:
> > > [PATCH v18 28/32] mm/compaction: Drop locked from isolate_migratepages_block
> > > Most of this consists of replacing "locked" by "lruvec", which is good:
> > > but please fold those changes back into 20/32 (or would it be 17/32?
> > > I've not yet looked into the relationship between those two), so we
> > > can then see more clearly what change this 28/32 (will need renaming!)
> > > actually makes, to use lruvec_holds_page_lru_lock(). That may be a
> > > good change, but it's mixed up with the "locked"->"lruvec" at present,
> > > and I think you could have just used lruvec for locked all along
> > > (but of course there's a place where you'll need new_lruvec too).
> >
> > I am good with my patch being folded in. No need to keep it separate.
>
> Thanks.  Though it was only the "locked"->"lruvec" changes I was
> suggesting to fold back, to minimize the diff, so that we could
> see your use of lruvec_holds_page_lru_lock() more clearly - you
> had not introduced that function at the stage of the earlier patches.
>
> But now that I stare at it again, using lruvec_holds_page_lru_lock()
> there doesn't look like an advantage to me: when it decides no, the
> same calculation is made all over again in mem_cgroup_page_lruvec(),
> whereas the code before only had to calculate it once.
>
> So, the code before looks better to me: I wonder, do you think that
> rcu_read_lock() is more expensive than I think it?  There can be
> debug instrumentation that makes it heavier, but by itself it is
> very cheap (by design) - not worth branching around.

Actually what I was more concerned with was the pointer chase that
required the RCU lock. With this function we are able to compare a
pair of pointers from the page and the lruvec and avoid the need for
the RCU lock. The way the old code was working we had to crawl through
the memcg to get to the lruvec before we could compare it to the one
we currently hold. The general idea is to use the data we have instead
of having to pull in some additional cache lines to perform the test.

> >
> > > [PATCH v18 29/32] mm: Identify compound pages sooner in isolate_migratepages_block
> > > NAK. I agree that isolate_migratepages_block() looks nicer this way, but
> > > take a look at prep_new_page() in mm/page_alloc.c: post_alloc_hook() is
> > > where set_page_refcounted() changes page->_refcount from 0 to 1, allowing
> > > a racing get_page_unless_zero() to succeed; then later prep_compound_page()
> > > is where PageHead and PageTails get set. So there's a small race window in
> > > which this patch could deliver a compound page when it should not.
> >
> > So the main motivation for the patch was to avoid the case where we
> > are having to reset the LRU flag.
>
> That would be satisfying.  Not necessary, but I agree satisfying.
> Maybe depends also on your "skip" change, which I've not looked at yet?

My concern is that we have scenarios where isolate_migratepages_block
could possibly prevent another page from being able to isolate a page.
I'm mostly concerned with us potentially creating something like an
isolation leak if multiple threads are doing something like clearing
and then resetting the LRU flag. In my mind if we clear the LRU flag
we should be certain we are going to remove the page as otherwise
another thread would have done it if it would have been allowed
access.

> > One question I would have is what if
> > we swapped the code block with the __isolate_lru_page_prepare section?
> > WIth that we would be taking a reference on the page, then verifying
> > the LRU flag is set, and then testing for compound page flag bit.
> > Would doing that close the race window since the LRU flag being set
> > should indicate that the allocation has already been completed has it
> > not?
>
> Yes, I think that would be safe, and would look better.  But I am
> very hesitant to give snap assurances here (I've twice missed out
> a vital PageLRU check from this sequence myself): it is very easy
> to deceive myself and only see it later.

I'm not looking for assurances, just sanity checks to make sure I am
not missing something obvious.

> If you can see a bug in what's there before these patches, certainly
> we need to fix it.  But adding non-essential patches to the already
> overlong series risks delaying it.

My concern ends up being that if we are clearing the bit and restoring
it while holding the LRU lock we can effectively cause pages to become
pseudo-pinned on the LRU. In my mind I would want us to avoid clearing
the LRU flag until we know we are going to be pulling the page from
the list once we take the lruvec lock. I interpret clearing of the
flag to indicate the page has already been pulled, it just hasn't left
the list yet. With us resetting the bit we are violating that which I
worry will lead to issues.
