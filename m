Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3862509EC
	for <lists+cgroups@lfdr.de>; Mon, 24 Aug 2020 22:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgHXUYj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 16:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXUYj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 16:24:39 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E51C061755
        for <cgroups@vger.kernel.org>; Mon, 24 Aug 2020 13:24:38 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id o21so9487396oie.12
        for <cgroups@vger.kernel.org>; Mon, 24 Aug 2020 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=jZJmpxUuRgi9v+jqMkzrZxBWaBUdOYUK94hlHfWB0r0=;
        b=MR7Bq/ZQYkG+RC4+pV7gn6md1ynlBoEqj97iWI4NmkE5R4tB+vonwjD3hBXKNY5NXi
         s6RgBUQ6GmZB9oN4eO759+P2STSWXsvR2iTFwi5em6FO1uSp9K6BrqWiBz2kHenZzz1P
         Py+yCIIKP4LDK18RFOWS5hwNf9QS/atikITGHcNt+QLbnxvvnLbqWHGkYnXujCSOVLTs
         81PlBJi5s6WGIJnJ2cHHmh6PUWyvIS66CnqqIjAVzz/+qHPYBCk5bMfIYwxbQwPJZTlO
         HeP6Hse7VzkhwJXSINHM5U3hSAJUo0uzysf4ar42eBFpZytIQnrqwxAFiM3GD2E23ZeY
         IOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=jZJmpxUuRgi9v+jqMkzrZxBWaBUdOYUK94hlHfWB0r0=;
        b=Vh7M86xsYmIkFYZnzODP6pyIHf05jrhdCin0sXdUKJ09Kr6pCAe/a8inDuIf2IXJYF
         E4iIe8vU0TeyQ4y0HWliEHI0/K+pUlQfpB2lr/p0RRlSI4CiXcE7HaqFRW3J4KgNGXJw
         bSszqAYYAaEDA+3a9jOevHViP/vF7dpHZhjhvStoTPsD5KOik7gq0zuOrkt5UHseZvIX
         L9rgTQQD64jhpd9o/8ES8TjdWh5in6/OAFxtyzLE7Iic3JDXW7M13OVcNNnLal7xtMdi
         IMT5pCtoXV9OSN+FuYHa+eilO03KEIotRIez2/EGlrTfqjs1ACqdZZ4ikYu6n1dbsp3i
         PLhg==
X-Gm-Message-State: AOAM530usSDOQkNyYe0WeD+hAt6IBDShAjNbEkGcFhThCy7ivnkZ77Ez
        tNYXkgomkSl+Lr8assXjJda0eg==
X-Google-Smtp-Source: ABdhPJwTgYizqjG5+M4jDsuRlA7NwkFtJ6lTlVT81F3k+vnUeL/RKMp78IcmS5oQunUsuiR9Fo0rKQ==
X-Received: by 2002:aca:670b:: with SMTP id z11mr707247oix.6.1598300677784;
        Mon, 24 Aug 2020 13:24:37 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a15sm2130930oid.49.2020.08.24.13.24.33
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 24 Aug 2020 13:24:36 -0700 (PDT)
Date:   Mon, 24 Aug 2020 13:24:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Alex Shi <alex.shi@linux.alibaba.com>, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
Subject: Re: [PATCH v18 00/32] per memcg lru_lock
In-Reply-To: <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 24 Aug 2020, Andrew Morton wrote:
> On Mon, 24 Aug 2020 20:54:33 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
> 
> > The new version which bases on v5.9-rc2.

Well timed and well based, thank you Alex.  Particulary helpful to me,
to include those that already went into mmotm: it's a surer foundation
to test on top of the -rc2 base.

> > the first 6 patches was picked into
> > linux-mm, and add patch 25-32 that do some further post optimization.
> 
> 32 patches, version 18.  That's quite heroic.  I'm unsure whether I
> should merge it up at this point - what do people think?

I'd love for it to go into mmotm - but not today.

Version 17 tested out well.  I've only just started testing version 18,
but I'm afraid there's been a number of "improvements" in between,
which show up as warnings (lots of VM_WARN_ON_ONCE_PAGE(!memcg) -
I think one or more of those are already in mmotm and under discussion
on the list, but I haven't read through yet, and I may have caught
more cases to examine; a per-cpu warning from munlock_vma_page();
something else flitted by at reboot time before I could read it).
No crashes so far, but I haven't got very far with it yet.

I'll report back later in the week.

Andrew demurred on version 17 for lack of review.  Alexander Duyck has
been doing a lot on that front since then.  I have intended to do so,
but it's a mirage that moves away from me as I move towards it: I have
some time in the coming weeks to get back to that, but it would help
me if the series is held more static by being in mmotm - we may need
fixes, but improvements are liable to get in the way of finalizing.

I still find the reliance on TestClearPageLRU, rather than lru_lock,
hard to wrap my head around: but for so long as it's working correctly,
please take that as a problem with my head (and something we can
certainly change later if necessary, by re-adding the use of lru_lock
in certain places (or by fitting me with a new head)).

> 
> > 
> > Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
> > containers on a 2s * 26cores * HT box with a modefied case:
> > https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
> > With this patchset, the readtwice performance increased about 80%
> > in concurrent containers.
> 
> That's rather a slight amount of performance testing for a huge
> performance patchset!

Indeed.  And I see that clause about readtwice performance increased 80%
going back eight months to v6: a lot of fundamental bugs have been fixed
in it since then, so I do think it needs refreshing.  It could be faster
now: v16 or v17 fixed the last bug I knew of, which had been slowing
down reclaim considerably.

When I last timed my repetitive swapping loads (not loads anyone sensible
would be running with), across only two memcgs, Alex's patchset was
slightly faster than without: it really did make a difference.  But
I tend to think that for all patchsets, there exists at least one
test that shows it faster, and another that shows it slower.

> Is more detailed testing planned?

Not by me, performance testing is not something I trust myself with,
just get lost in the numbers: Alex, this is what we hoped for months
ago, please make a more convincing case, I hope Daniel and others
can make more suggestions.  But my own evidence suggests it's good.

Hugh
