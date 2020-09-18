Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C762707B0
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 23:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgIRVBd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 17:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgIRVBc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Sep 2020 17:01:32 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1BDC0613CF
        for <cgroups@vger.kernel.org>; Fri, 18 Sep 2020 14:01:32 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id h2so7654021ilo.12
        for <cgroups@vger.kernel.org>; Fri, 18 Sep 2020 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gK5XsFJwjR3oBOvG/qkXacDHUsWYEbBlXXhB7nU1Ags=;
        b=pcN7Q//IQygz5FJBITdJVrxJvWq0Vm0gpULffWDjradPmXmYqjFqKoWw5t5ym2b7WF
         5JwcUs9TGqqN+OKKYQOm7jmsFNoZTsG4999NWYiG1ZduRlD77SAh7ijt3RZoAYnJEU4c
         nGEQ2urcqmq68lZxEHpgpfGGRC5HISEn+1orSu9d/3bwgdZ9iYImNwTG+rrmnJBRoCrs
         pwZOYq55fGt4kJen3gnpAOUJ0GLWS7rFcbW3aOuYQnl/6jpxy/KSviHHupyLJ6sdyzws
         iy8uqFFL6WbcHU7//Cme8yFxA/phGZ4gbCrDmXiJ84kbRWOfRnSTaA9CJ0bsQZlsCXVW
         K67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gK5XsFJwjR3oBOvG/qkXacDHUsWYEbBlXXhB7nU1Ags=;
        b=DryESabU95gjpV4uBWtLnup+Er3DqF+q8spsD7t23wWbYRnYm22bho3THq3D4KCycZ
         hTwhSdFhNjGtUprQffwslEGbyT7CsMmZFT+LZXv1L8LZyjCXodzFQRr1217XXw7U8LsK
         cChenUMLxFIXRCujOppquITg2/+g4xaGkbEpI6X71234iwUvlvq80NoTf7FJpry4rGtq
         VATcT17PvGR+pTEdW6hZEB/ET6IbhFTV1aDuDeOJQ3qE3JS+ZJ7WqBso2NCXrSy0ktU5
         BbKoFFNPfWltAefG98mwVrwgUwCDXw6UsvcHzGmj82+0ntxWV+iIr2cXD2eAZGGqhUIO
         peuA==
X-Gm-Message-State: AOAM530654uFBymnCF0JYxQ9f+WHRaZCViBkh3Qc9CTP3ysBlCSYSyIV
        EaxvKEuRw4zryto0tx6JA4kvqQ==
X-Google-Smtp-Source: ABdhPJzVnVuLlyjiuxOoFIg1EIYFneo1FDyst+YvS4rLzDGzl3letx9XWjVpMFScZNn64/p2AGTd8g==
X-Received: by 2002:a92:c750:: with SMTP id y16mr1187041ilp.277.1600462891719;
        Fri, 18 Sep 2020 14:01:31 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id j20sm2243158ilq.6.2020.09.18.14.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:01:30 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:01:26 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20200918210126.GA1118730@google.com>
References: <20200918030051.650890-1-yuzhao@google.com>
 <alpine.LSU.2.11.2009181317350.11298@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2009181317350.11298@eggly.anvils>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 18, 2020 at 01:46:59PM -0700, Hugh Dickins wrote:
> On Thu, 17 Sep 2020, Yu Zhao wrote:
> 
> > Hi Andrew,
> > 
> > I see you have taken this:
> >   mm: use add_page_to_lru_list()/page_lru()/page_off_lru()
> > Do you mind dropping it?
> > 
> > Michal asked to do a bit of additional work. So I thought I probably
> > should create a series to do more cleanups I've been meaning to.
> > 
> > This series contains the change in the patch above and goes a few
> > more steps farther. It's intended to improve readability and should
> > not have any performance impacts. There are minor behavior changes in
> > terms of debugging and error reporting, which I have all highlighted
> > in the individual patches. All patches were properly tested on 5.8
> > running Chrome OS, with various debug options turned on.
> > 
> > Michal,
> > 
> > Do you mind taking a looking at the entire series?
> > 
> > Thank you.
> > 
> > Yu Zhao (13):
> >   mm: use add_page_to_lru_list()
> >   mm: use page_off_lru()
> >   mm: move __ClearPageLRU() into page_off_lru()
> >   mm: shuffle lru list addition and deletion functions
> >   mm: don't pass enum lru_list to lru list addition functions
> >   mm: don't pass enum lru_list to trace_mm_lru_insertion()
> >   mm: don't pass enum lru_list to del_page_from_lru_list()
> >   mm: rename page_off_lru() to __clear_page_lru_flags()
> >   mm: inline page_lru_base_type()
> >   mm: VM_BUG_ON lru page flags
> >   mm: inline __update_lru_size()
> >   mm: make lruvec_lru_size() static
> >   mm: enlarge the int parameter of update_lru_size()
> > 
> >  include/linux/memcontrol.h     |  14 ++--
> >  include/linux/mm_inline.h      | 115 ++++++++++++++-------------------
> >  include/linux/mmzone.h         |   2 -
> >  include/linux/vmstat.h         |   2 +-
> >  include/trace/events/pagemap.h |  11 ++--
> >  mm/compaction.c                |   2 +-
> >  mm/memcontrol.c                |  10 +--
> >  mm/mlock.c                     |   2 +-
> >  mm/swap.c                      |  53 ++++++---------
> >  mm/vmscan.c                    |  28 +++-----
> >  10 files changed, 95 insertions(+), 144 deletions(-)
> > 
> > -- 
> > 2.28.0.681.g6f77f65b4e-goog
> 
> Sorry, Yu, I may be out-of-line in sending this: but as you know,
> Alex Shi has a long per-memcg lru_lock series playing in much the
> same area (particularly conflicting in mm/swap.c and mm/vmscan.c):
> a patchset that makes useful changes, that I'm very keen to help
> into mmotm a.s.a.p (but not before I've completed diligence).
> 
> We've put a lot of effort into its testing, I'm currently reviewing
> it patch by patch (my general silence indicating that I'm busy on that,
> but slow as ever): so I'm a bit discouraged to have its stability
> potentially undermined by conflicting cleanups at this stage.
> 
> If there's general agreement that your cleanups are safe and welcome
> (Michal's initial reaction sheds some doubt on that), great: I hope
> that Andrew can fast-track them into mmotm, then Alex rebase on top
> of them, and I then re-test and re-review.
> 
> But if that quick agreement is not forthcoming, may I ask you please
> to hold back, and resend based on top of Alex's next posting?

The per-memcg lru lock series seems a high priority, and I have
absolutely no problem accommodate your request.

In return, may I ask you or Alex to review this series after you
have finished with per-memcg lru lock (to make sure that I resolve
all the conflicts correctly at least)?
