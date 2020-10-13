Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2434128C724
	for <lists+cgroups@lfdr.de>; Tue, 13 Oct 2020 04:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgJMCaU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Oct 2020 22:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbgJMCaT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Oct 2020 22:30:19 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0D0C0613D1
        for <cgroups@vger.kernel.org>; Mon, 12 Oct 2020 19:30:19 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id s21so3060064oij.0
        for <cgroups@vger.kernel.org>; Mon, 12 Oct 2020 19:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bnow7E0NdAgjP24uVGPtsFmB33v0oAbeU6I6hhEmdgc=;
        b=KrUvpd/NgSTDTdOcGQLuHHaZU0xD55DjswJ8khTx2pSoboXy93Jxf2qHywUyjFDyrL
         eJQUerC2H2GL4jTguLveYvjUixN4gsg3qBA/m+K5Dfe6h4qUtsz7Vzxttb55XV+X07yB
         kfJsUhqTIm7vY9XRgP0As0lJu4QCGjFfWbyvTvKwuQN9Ol1pXyvIXfZ0yCe+cDXpIBz0
         NktjqctuKy/KaU5U0Jzy7+/tIpw0pkGlOhP2aiJ/dnkqcmgDetRZb/OomuI7G4yUVnsK
         bQwYA/vsGGaELvLzBIJMzUE0z3E9wAmmRH21fVOl6c2nyipuA/AhCfzP0wGJoCU0LAAQ
         PArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bnow7E0NdAgjP24uVGPtsFmB33v0oAbeU6I6hhEmdgc=;
        b=tkfOOHn7DTi35MIrOPMyC7e/RJalyFcTbysF37HQ0sUwtgIddLZXlsGVvvEHFfSKp/
         3ltna32XT6lVhVJ7+cGQSTzil1+QnQwWyt0lieMnp2jUIht6hCHdZ9yRTq7VvSZi/Zz8
         hR9bK/Dnl2rH5SdaIqFEAobE5Nulw7B0IGNZFhIke8WH13VolZNJfox6iyOe851GDwYn
         WCdMieT5tz9owoOSJp4dbtbBrhYxU6nLzToY0hlBsSF0bAxjooaWjZd1qOjzaWeHPHox
         kXgYMHj1OYBP8L8MfL8iwtE/NYioZtRPRR4eNYY4aMUtSGmb3OtwjzJ/GAJ+j2yuAiiu
         yrbg==
X-Gm-Message-State: AOAM530PT7Ekp1B54UR9RN6hITRIBkz4l5QGYo5w0wz/ERC8iqC5VAnN
        ZUOdNQcm2PCO4Zpx//ehZ3WWXw==
X-Google-Smtp-Source: ABdhPJyONDiO5yevIWMqwITzHHdmzf1rJ12V6IDE32XCQJ68uNg6ZptgDpu7d8FRdFcD63qBuGDB4w==
X-Received: by 2002:aca:c490:: with SMTP id u138mr12541282oif.54.1602556218373;
        Mon, 12 Oct 2020 19:30:18 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x15sm11158198oor.33.2020.10.12.19.30.15
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2020 19:30:17 -0700 (PDT)
Date:   Mon, 12 Oct 2020 19:30:03 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] mm: clean up some lru related pieces
In-Reply-To: <alpine.LSU.2.11.2009181406410.11531@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2010121910200.11039@eggly.anvils>
References: <20200918030051.650890-1-yuzhao@google.com> <alpine.LSU.2.11.2009181317350.11298@eggly.anvils> <20200918210126.GA1118730@google.com> <alpine.LSU.2.11.2009181406410.11531@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 18 Sep 2020, Hugh Dickins wrote:
> On Fri, 18 Sep 2020, Yu Zhao wrote:
> > On Fri, Sep 18, 2020 at 01:46:59PM -0700, Hugh Dickins wrote:
> > > On Thu, 17 Sep 2020, Yu Zhao wrote:
> > > 
> > > > Hi Andrew,
> > > > 
> > > > I see you have taken this:
> > > >   mm: use add_page_to_lru_list()/page_lru()/page_off_lru()
> > > > Do you mind dropping it?
> > > > 
> > > > Michal asked to do a bit of additional work. So I thought I probably
> > > > should create a series to do more cleanups I've been meaning to.
> > > > 
> > > > This series contains the change in the patch above and goes a few
> > > > more steps farther. It's intended to improve readability and should
> > > > not have any performance impacts. There are minor behavior changes in
> > > > terms of debugging and error reporting, which I have all highlighted
> > > > in the individual patches. All patches were properly tested on 5.8
> > > > running Chrome OS, with various debug options turned on.
> > > > 
> > > > Michal,
> > > > 
> > > > Do you mind taking a looking at the entire series?
> > > > 
> > > > Thank you.
> > > > 
> > > > Yu Zhao (13):
> > > >   mm: use add_page_to_lru_list()
> > > >   mm: use page_off_lru()
> > > >   mm: move __ClearPageLRU() into page_off_lru()
> > > >   mm: shuffle lru list addition and deletion functions
> > > >   mm: don't pass enum lru_list to lru list addition functions
> > > >   mm: don't pass enum lru_list to trace_mm_lru_insertion()
> > > >   mm: don't pass enum lru_list to del_page_from_lru_list()
> > > >   mm: rename page_off_lru() to __clear_page_lru_flags()
> > > >   mm: inline page_lru_base_type()
> > > >   mm: VM_BUG_ON lru page flags
> > > >   mm: inline __update_lru_size()
> > > >   mm: make lruvec_lru_size() static
> > > >   mm: enlarge the int parameter of update_lru_size()
> > > > 
> > > >  include/linux/memcontrol.h     |  14 ++--
> > > >  include/linux/mm_inline.h      | 115 ++++++++++++++-------------------
> > > >  include/linux/mmzone.h         |   2 -
> > > >  include/linux/vmstat.h         |   2 +-
> > > >  include/trace/events/pagemap.h |  11 ++--
> > > >  mm/compaction.c                |   2 +-
> > > >  mm/memcontrol.c                |  10 +--
> > > >  mm/mlock.c                     |   2 +-
> > > >  mm/swap.c                      |  53 ++++++---------
> > > >  mm/vmscan.c                    |  28 +++-----
> > > >  10 files changed, 95 insertions(+), 144 deletions(-)
> > > > 
> > > > -- 
> > > > 2.28.0.681.g6f77f65b4e-goog
> > > 
> > > Sorry, Yu, I may be out-of-line in sending this: but as you know,
> > > Alex Shi has a long per-memcg lru_lock series playing in much the
> > > same area (particularly conflicting in mm/swap.c and mm/vmscan.c):
> > > a patchset that makes useful changes, that I'm very keen to help
> > > into mmotm a.s.a.p (but not before I've completed diligence).
> > > 
> > > We've put a lot of effort into its testing, I'm currently reviewing
> > > it patch by patch (my general silence indicating that I'm busy on that,
> > > but slow as ever): so I'm a bit discouraged to have its stability
> > > potentially undermined by conflicting cleanups at this stage.
> > > 
> > > If there's general agreement that your cleanups are safe and welcome
> > > (Michal's initial reaction sheds some doubt on that), great: I hope
> > > that Andrew can fast-track them into mmotm, then Alex rebase on top
> > > of them, and I then re-test and re-review.
> > > 
> > > But if that quick agreement is not forthcoming, may I ask you please
> > > to hold back, and resend based on top of Alex's next posting?
> > 
> > The per-memcg lru lock series seems a high priority, and I have
> > absolutely no problem accommodate your request.
> 
> Many thanks!
> 
> > 
> > In return, may I ask you or Alex to review this series after you
> > have finished with per-memcg lru lock (to make sure that I resolve
> > all the conflicts correctly at least)?
> 
> Fair enough: I promise to do so.
> 
> And your rebasing will necessarily lead you to review some parts
> of Alex's patchset, which will help us all too.
> 
> Andrew, Yu asked at the start:
> > > > I see you have taken this:
> > > >   mm: use add_page_to_lru_list()/page_lru()/page_off_lru()
> > > > Do you mind dropping it?
> Dropping that for now will help too.

Andrew, please drop Yu Zhao's
mm-use-add_page_to_lru_list-page_lru-page_off_lru.patch
from the mmotm tree.

Yu wants to replace it by this cleanup series, and he has graciously
agreed to rebase his series on top of Alex Shi's per-memcg lru_lock
series; but mm-use-add_page_to_lru_list-page_lru-page_off_lru.patch
is getting in the way of adding them to mmotm.  The three of us are
all hoping that Alex's v19 series can go into mmotm when the merge
window closes, then I'll review Yu's series rebased on top of it.

Thanks,
Hugh
