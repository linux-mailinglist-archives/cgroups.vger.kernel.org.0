Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399BF253E7F
	for <lists+cgroups@lfdr.de>; Thu, 27 Aug 2020 09:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgH0HB1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Aug 2020 03:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgH0HBG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Aug 2020 03:01:06 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6BCC061264
        for <cgroups@vger.kernel.org>; Thu, 27 Aug 2020 00:01:05 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id d30so1243568qvc.9
        for <cgroups@vger.kernel.org>; Thu, 27 Aug 2020 00:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dlLginyZpxCAkGKRMWKhKVlveqMIe3fj5HCC0Huvfao=;
        b=iTzlBDK5N3vB0kF0mheFhzDF2e7u55djSMT2skp+BdTo976XWc/TZRw+elYMkw+ThD
         xrMz1T2uj6T7cVjjPvp6ViASakvAdlKSJumMNJ7KzgC7zjBrlK1XlUw+4SEvs3m0byaj
         NIgxVuTZTlbifu/LYJseaO8d9o6Pg7fmw338E6SQUmE+CJ3LKfHJTb5bGYWLpsx76gH6
         OTCoNd52vkU+sscAfruhgy/dsQmR3rhtgPxNpJec5T/YFWRBM8QFWDnWX7FbNAcf3KUi
         uWrEOhYMNYmM1URuoxqtXIRn0+7yv8Kc0ScIGL7o9zhfK9Tecg+ZI9Ae+tegdhmuMcBL
         XVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dlLginyZpxCAkGKRMWKhKVlveqMIe3fj5HCC0Huvfao=;
        b=V1M6yZimvzuqfoEv2BkkD9xv+CdSE+fe0mSkTPUB6MRLcpxzgU6c54cEoC3LPyuBv1
         Cj/ACS/0nxWWpY1D0B57OWb3WwDaaL3UJ4Gy18A3VaZKsBcuqVkb6Sibmk9RoobJcSPd
         D6WxEohy0NYqeiPj8fSfbaUnOnWBL6ZqPOxqe+/tYb2GL2lfjv5y/PwU3Tx5LjLqLDyF
         gCyNZ8aNNoWNsP5bvRLjkCsFg+laRcIgC0klTL9GIQDLCAMdx7yT4ql9411xCC1XEihI
         v3MBrkCRdMZVI2jTcSinz4gB3bXGV9hNNUOzjYbTP7Gent1whst+CVRNblm1fTRfk8lZ
         3pPA==
X-Gm-Message-State: AOAM530dzWm63iFgKtX6F12o1/kNwRHjmvv/ircaq5P5qyjOKWHezAcW
        08viTslHjt0aHQXkCq0t4i6evA==
X-Google-Smtp-Source: ABdhPJz/rd6lmSUghWfbcgs7kwrUOX8v0PfcsNpdKb5vNdqnbFZsYftjGDmGgYs9sI84li3J0Ge46A==
X-Received: by 2002:a0c:d805:: with SMTP id h5mr2320517qvj.27.1598511664114;
        Thu, 27 Aug 2020 00:01:04 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i7sm1193133qkb.131.2020.08.27.00.01.01
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 27 Aug 2020 00:01:03 -0700 (PDT)
Date:   Thu, 27 Aug 2020 00:01:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com, cai@lca.pw
Subject: Re: [PATCH v18 00/32] per memcg lru_lock
In-Reply-To: <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org> <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 24 Aug 2020, Hugh Dickins wrote:
> On Mon, 24 Aug 2020, Andrew Morton wrote:
> > On Mon, 24 Aug 2020 20:54:33 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
> > 
> > > The new version which bases on v5.9-rc2.
> 
> Well timed and well based, thank you Alex.  Particulary helpful to me,
> to include those that already went into mmotm: it's a surer foundation
> to test on top of the -rc2 base.
> 
> > > the first 6 patches was picked into
> > > linux-mm, and add patch 25-32 that do some further post optimization.
> > 
> > 32 patches, version 18.  That's quite heroic.  I'm unsure whether I
> > should merge it up at this point - what do people think?
> 
> I'd love for it to go into mmotm - but not today.
> 
> Version 17 tested out well.  I've only just started testing version 18,
> but I'm afraid there's been a number of "improvements" in between,
> which show up as warnings (lots of VM_WARN_ON_ONCE_PAGE(!memcg) -
> I think one or more of those are already in mmotm and under discussion
> on the list, but I haven't read through yet, and I may have caught
> more cases to examine; a per-cpu warning from munlock_vma_page();

Alex already posted the fix for that one.

> something else flitted by at reboot time before I could read it).

That one still eludes me, but I'm not giving it high priority.

> No crashes so far, but I haven't got very far with it yet.
> 
> I'll report back later in the week.

Just a quick report for now: I have some fixes, not to Alex's patchset
itself, but to things it revealed - a couple of which I knew of already,
but better now be fixed.  Once I've fleshed those out with comments and
sent them in, I'll get down to review.

Testing held up very well, no other problems seen in the patchset,
and the 1/27 discovered something useful.

I was going to say, no crashes observed at all, but one did crash
this afternoon.  But like before, I think it's something unrelated
to Alex's work, just revealed now that I hammer harder on compaction
(knowing that to be the hardest test for per-memcg lru_lock).

It was a crash from checking PageWaiters on a Tail in wake_up_page(),
called from end_page_writeback(), from ext4_finish_bio(): yet the
page a tail of a shmem huge page.  Linus's wake_up_page_bit() changes?
No, I don't think so.  It seems to me that once end_page_writeback()
has done its test_clear_page_writeback(), it has no further hold on
the struct page, which could be reused as part of a compound page
by the time of wake_up_page()'s PageWaiters check.  But I probably
need to muse on that for longer.

(I'm also kind-of-worried because Alex's patchset should make no
functional difference, yet appears to fix some undebugged ZONE_DMA=y
slow leak of memory that's been plaguing my testing for months.
I mention that in case those vague words are enough to prompt an
idea from someone, but cannot afford to spend much time on it.)

Hugh
