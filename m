Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4D2263167
	for <lists+cgroups@lfdr.de>; Wed,  9 Sep 2020 18:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgIIQMO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Sep 2020 12:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730576AbgIIQLl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Sep 2020 12:11:41 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ED3C061756;
        Wed,  9 Sep 2020 09:11:40 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t16so2820126ilf.13;
        Wed, 09 Sep 2020 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fi6EPOk4V99JFbqYmEhNPN5TNg8BdROS9o2xQ3RBg5E=;
        b=rlfBLzoK50AdGuXYFUe5sFCgGZuO8AeB+DJLXTpOd98w2tONPNvWw7PRN8UwfX1kcB
         qpaUWzVXxXFCR4QS6X1eKPXKlVCOw84PnHMfRJcwucgm7MCtrONclkv3c2KGz6NKRWF6
         bIpuGEl92zf3lDES3mrCY0o9yN5bbmlesde/nSjHgaz11aqQZJE94l16lobir7khJp1G
         cAcR6z9rG4oAj+dPwZ9HPfHvbwf3BM1FGFuYK/NIxWfxS1rSM4FBiuz2BiSu5KXeaOPw
         QTce2zDZfvrieGVGSjHvcdTXGqtBQ81gE7ZOjeMSmma7RQZoOn1sEkpUSmqsZ5lAvgfp
         /a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fi6EPOk4V99JFbqYmEhNPN5TNg8BdROS9o2xQ3RBg5E=;
        b=qJha6f4gmbSWYnm3pGMA6D5vLY6ARzjyxho3VTsLMjBB/cTxAtHxTt94z8Aoa+r5xE
         EWpB1yVgcPRfJoAy9OD8AfSKjtSZVpG4/+TEplEuCjhedRNFCRDWSymyo8b8qvKZCZTL
         jrw3/FM1+i9EGAcnFdXFtRyir26nDvRCPWImbaGfJN/vcyM9QQm6INroR9lLzetFSvSK
         u4XhOKZEwVJp3VAnEkn2CIVldc2MXdTk0oCCSjSHLLgojnkQsmWSq2WBlAxQJ+pdOjgB
         fzVKx3+seybPo0VHEOcW01GkOfJmc/G1C754Qb9KKbvNskgtlfQcYyQsRgRkE89rR+Q0
         GbUQ==
X-Gm-Message-State: AOAM5321nXgtgmyU/XSM+cjnc5QIBRQkFic+sZNGwaw4A+QIhdbi+DdM
        Di3dKc9UoZfhuVY0iZciEBhYXP4U67TKgyaDnY0=
X-Google-Smtp-Source: ABdhPJx7KEby+OfH82kXGH3NIHe6v3PfIbd7mVCLU00Uzi2e/UVTJzdsgLsJe7WH+xQ5FqL4JHH6CPwAlr9OBlnQ7WQ=
X-Received: by 2002:a92:ae06:: with SMTP id s6mr4063803ilh.64.1599667899575;
 Wed, 09 Sep 2020 09:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils> <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
 <alpine.LSU.2.11.2009081640070.7256@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2009081640070.7256@eggly.anvils>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 9 Sep 2020 09:11:28 -0700
Message-ID: <CAKgT0Uc_L-Tz_rVJiHc5GUK_ZWOs2wRvez4QGf2wwEjx38qnbg@mail.gmail.com>
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

On Tue, Sep 8, 2020 at 4:41 PM Hugh Dickins <hughd@google.com> wrote:
>

<snip>

> [PATCH v18 28/32] mm/compaction: Drop locked from isolate_migratepages_block
> Most of this consists of replacing "locked" by "lruvec", which is good:
> but please fold those changes back into 20/32 (or would it be 17/32?
> I've not yet looked into the relationship between those two), so we
> can then see more clearly what change this 28/32 (will need renaming!)
> actually makes, to use lruvec_holds_page_lru_lock(). That may be a
> good change, but it's mixed up with the "locked"->"lruvec" at present,
> and I think you could have just used lruvec for locked all along
> (but of course there's a place where you'll need new_lruvec too).

I am good with my patch being folded in. No need to keep it separate.

> [PATCH v18 29/32] mm: Identify compound pages sooner in isolate_migratepages_block
> NAK. I agree that isolate_migratepages_block() looks nicer this way, but
> take a look at prep_new_page() in mm/page_alloc.c: post_alloc_hook() is
> where set_page_refcounted() changes page->_refcount from 0 to 1, allowing
> a racing get_page_unless_zero() to succeed; then later prep_compound_page()
> is where PageHead and PageTails get set. So there's a small race window in
> which this patch could deliver a compound page when it should not.

So the main motivation for the patch was to avoid the case where we
are having to reset the LRU flag. One question I would have is what if
we swapped the code block with the __isolate_lru_page_prepare section?
WIth that we would be taking a reference on the page, then verifying
the LRU flag is set, and then testing for compound page flag bit.
Would doing that close the race window since the LRU flag being set
should indicate that the allocation has already been completed has it
not?

> [PATCH v18 30/32] mm: Drop use of test_and_set_skip in favor of just setting skip
> I haven't looked at this yet (but recall that per-memcg lru_lock can
> change the point at which compaction should skip a contended lock: IIRC
> the current kernel needs nothing extra, whereas some earlier kernels did
> need extra; but when I look at 30/32, may find these remarks irrelevant).
>
> [PATCH v18 31/32] mm: Add explicit page decrement in exception path for isolate_lru_pages
> The title of this patch is definitely wrong: there was an explicit page
> decrement there before (put_page), now it's wrapping it up inside a
> WARN_ON().  We usually prefer to avoid doing functional operations
> inside WARN/BUGs, but I think I'll overlook that - anyone else worried?
> The comment is certainly better than what was there before: yes, this
> warning reflects the difficulty we have in thinking about the
> TestClearPageLRU protocol: which I'm still not sold on, but
> agree we should proceed with.  With a change in title, perhaps
> "mm: add warning where TestClearPageLRU failed on freeable page"?
> Acked-by: Hugh Dickins <hughd@google.com>

I can update that and resubmit it if needed. I know there were also
some suggestions from Matthew.
