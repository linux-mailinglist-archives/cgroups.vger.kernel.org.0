Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9372B27080A
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 23:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgIRVTX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 17:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgIRVTW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Sep 2020 17:19:22 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED3CC0613CE
        for <cgroups@vger.kernel.org>; Fri, 18 Sep 2020 14:19:22 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h17so6717904otr.1
        for <cgroups@vger.kernel.org>; Fri, 18 Sep 2020 14:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=hCqfyPqClFtsWYJ6Us4lj54w9VZCcNft/YN87A9Cm1M=;
        b=RCLC4pAGnJPpVPcdwcMuRM/kCYe5yGj3+0+2krt4aXaidS5UjLbpsy5sPdGpUYeYRj
         IBCHrTculQJ+3IShLOsUN6M5LV+639lGd7bqOJYdYqXbWCjoM+eHsTdG3SZ0VnMu3VBb
         v1MqRjdzxrxOIQMNceoi2JERCRmFElH4hkgHDalq70CLk5z3OYuyljGxTWjzOaUk/Oxy
         6zibOGX9vP7z9sGGCcerC4SEGV83/ul+bVkJTN0QLe4xEOrQBdEFfPpj32cEFf8O1FxL
         Neg5uuOeUd8D7gZYZDr8oPchdjy3oDL0qD8+0dxihlkhQph1J00Bku1yFNeDZ0N5wddQ
         SNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=hCqfyPqClFtsWYJ6Us4lj54w9VZCcNft/YN87A9Cm1M=;
        b=fxSJ+OpqyLbUdvgI/KSIjktu+rkvAscLeTKMXwyb/HHu03QwcZjkDu08fY6Jpm9VXw
         6G5qk6eXojN0KcLJErDoeQqG6kcg4dIu+D/90CuSbNNkCrNb+fcaWGD4FS4vcg5/n0Wy
         AsMWGZCXRoE6EHve/4/C014Iwy8X4PHRXunle+efM2yZDe6KEB8lLS7GQDYnOVP2PQos
         XWPDFVJLS4Eifsw89hbyUO1DvZK9glunU9CwnyWKO4vsg/IJvQMwl4P9Lly2+KRkVcKE
         glc7VVFESeag5y0bOXBHxjDsmCFrKhSNR346ktvG9z2nok+jqMJtNfQIFnwL9p5mut5+
         Cd2A==
X-Gm-Message-State: AOAM533wUoOW/Jde2AqmOJk3WQ25uKybub6ITfxBGo4XRVHEXi5hDVVg
        glRYMUEh2u3Yz69xWF3XnjbEUw==
X-Google-Smtp-Source: ABdhPJyNWyKUZsUDgJBuIgPpf2i2iguj4TPsuCoz2AqoNjriX/A+uxXwTQHeC491Oww9bEb83eWPDg==
X-Received: by 2002:a05:6830:1e6b:: with SMTP id m11mr24868463otr.40.1600463961917;
        Fri, 18 Sep 2020 14:19:21 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q184sm4146364ooq.40.2020.09.18.14.19.19
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 18 Sep 2020 14:19:20 -0700 (PDT)
Date:   Fri, 18 Sep 2020 14:19:02 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yu Zhao <yuzhao@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
In-Reply-To: <20200918210126.GA1118730@google.com>
Message-ID: <alpine.LSU.2.11.2009181406410.11531@eggly.anvils>
References: <20200918030051.650890-1-yuzhao@google.com> <alpine.LSU.2.11.2009181317350.11298@eggly.anvils> <20200918210126.GA1118730@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 18 Sep 2020, Yu Zhao wrote:
> On Fri, Sep 18, 2020 at 01:46:59PM -0700, Hugh Dickins wrote:
> > On Thu, 17 Sep 2020, Yu Zhao wrote:
> > 
> > > Hi Andrew,
> > > 
> > > I see you have taken this:
> > >   mm: use add_page_to_lru_list()/page_lru()/page_off_lru()
> > > Do you mind dropping it?
> > > 
> > > Michal asked to do a bit of additional work. So I thought I probably
> > > should create a series to do more cleanups I've been meaning to.
> > > 
> > > This series contains the change in the patch above and goes a few
> > > more steps farther. It's intended to improve readability and should
> > > not have any performance impacts. There are minor behavior changes in
> > > terms of debugging and error reporting, which I have all highlighted
> > > in the individual patches. All patches were properly tested on 5.8
> > > running Chrome OS, with various debug options turned on.
> > > 
> > > Michal,
> > > 
> > > Do you mind taking a looking at the entire series?
> > > 
> > > Thank you.
> > > 
> > > Yu Zhao (13):
> > >   mm: use add_page_to_lru_list()
> > >   mm: use page_off_lru()
> > >   mm: move __ClearPageLRU() into page_off_lru()
> > >   mm: shuffle lru list addition and deletion functions
> > >   mm: don't pass enum lru_list to lru list addition functions
> > >   mm: don't pass enum lru_list to trace_mm_lru_insertion()
> > >   mm: don't pass enum lru_list to del_page_from_lru_list()
> > >   mm: rename page_off_lru() to __clear_page_lru_flags()
> > >   mm: inline page_lru_base_type()
> > >   mm: VM_BUG_ON lru page flags
> > >   mm: inline __update_lru_size()
> > >   mm: make lruvec_lru_size() static
> > >   mm: enlarge the int parameter of update_lru_size()
> > > 
> > >  include/linux/memcontrol.h     |  14 ++--
> > >  include/linux/mm_inline.h      | 115 ++++++++++++++-------------------
> > >  include/linux/mmzone.h         |   2 -
> > >  include/linux/vmstat.h         |   2 +-
> > >  include/trace/events/pagemap.h |  11 ++--
> > >  mm/compaction.c                |   2 +-
> > >  mm/memcontrol.c                |  10 +--
> > >  mm/mlock.c                     |   2 +-
> > >  mm/swap.c                      |  53 ++++++---------
> > >  mm/vmscan.c                    |  28 +++-----
> > >  10 files changed, 95 insertions(+), 144 deletions(-)
> > > 
> > > -- 
> > > 2.28.0.681.g6f77f65b4e-goog
> > 
> > Sorry, Yu, I may be out-of-line in sending this: but as you know,
> > Alex Shi has a long per-memcg lru_lock series playing in much the
> > same area (particularly conflicting in mm/swap.c and mm/vmscan.c):
> > a patchset that makes useful changes, that I'm very keen to help
> > into mmotm a.s.a.p (but not before I've completed diligence).
> > 
> > We've put a lot of effort into its testing, I'm currently reviewing
> > it patch by patch (my general silence indicating that I'm busy on that,
> > but slow as ever): so I'm a bit discouraged to have its stability
> > potentially undermined by conflicting cleanups at this stage.
> > 
> > If there's general agreement that your cleanups are safe and welcome
> > (Michal's initial reaction sheds some doubt on that), great: I hope
> > that Andrew can fast-track them into mmotm, then Alex rebase on top
> > of them, and I then re-test and re-review.
> > 
> > But if that quick agreement is not forthcoming, may I ask you please
> > to hold back, and resend based on top of Alex's next posting?
> 
> The per-memcg lru lock series seems a high priority, and I have
> absolutely no problem accommodate your request.

Many thanks!

> 
> In return, may I ask you or Alex to review this series after you
> have finished with per-memcg lru lock (to make sure that I resolve
> all the conflicts correctly at least)?

Fair enough: I promise to do so.

And your rebasing will necessarily lead you to review some parts
of Alex's patchset, which will help us all too.

Andrew, Yu asked at the start:
> > > I see you have taken this:
> > >   mm: use add_page_to_lru_list()/page_lru()/page_off_lru()
> > > Do you mind dropping it?
Dropping that for now will help too.

Thanks,
Hugh
