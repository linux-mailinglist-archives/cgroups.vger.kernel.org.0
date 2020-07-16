Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747A3222DE5
	for <lists+cgroups@lfdr.de>; Thu, 16 Jul 2020 23:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgGPV2r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jul 2020 17:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgGPV2q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jul 2020 17:28:46 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663EAC061755
        for <cgroups@vger.kernel.org>; Thu, 16 Jul 2020 14:28:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ch3so5435634pjb.5
        for <cgroups@vger.kernel.org>; Thu, 16 Jul 2020 14:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VIlti4DdqvC4yQ4DwI6JLsQiEiXC5SNQn8TNQgd556Q=;
        b=XGXkGoQrH8BP+NW2bw4rDZtLLTOshTUmtiwOatXYDziroYOltnjs4mO+hzUACJMr68
         94AeisgKn+w2GWwwkg+O4hPuA2EeL0vq3n5GoSuvCteQF2K7mCQCfzP88WPHY3eoDx8V
         zGU0BfgWnAeurO6c53/vu6bsJhz3e1ZME0E6I/EcJukxapq1BAPkBcQLKOeQDfWdBYRl
         vxI4R4/odoFjBs/HtyPKO182ZWO1AVmViDDefMo+FMiPQaDBCmzrjpfEj4UvaiS3mjDc
         d0tWqb2BH4Hxe6AYcefKCvKC7WqqbeyKUH4/I7UB29TGsC4LAU8EsnXumob7k674zw6A
         HLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VIlti4DdqvC4yQ4DwI6JLsQiEiXC5SNQn8TNQgd556Q=;
        b=CtBKj6JoGC+q+w6knJZnS8U5QYlqKMoa4KP6uiooBwTrcnBJU4LB5N8ddy3T/neN8H
         TfSvnc0GN9UEz5oEe4rVVBwMtswaU0SwiwGHJ2TG33iVZKB/6VTqOMzR1JSSOXD/sKvC
         BS7TpommLD3ioZpsuOFVrhVcE22aSdypmzV0m8MwUDHE5uKVkNTcvQpUD0eJKHiq57T/
         gvzh7Ma2/sAK56vHrClb/CLzZZWlnkWrkY66jBjRSQGo27HSpkjXknPpVAKG2An0RSpe
         BudNDzBUhc85p4w8/SUAZRRr6MFMK/kjzXET0c+ViPeTAOrMPMFx4QNbKiR+OnAnwtYI
         re8A==
X-Gm-Message-State: AOAM531XKEmQttsvtKBKqS+v7FziKDkplrFZlitmjRxlkmOtDxBvwUUq
        liL5efdTjMR+sG6xOFmLPkvSrQ==
X-Google-Smtp-Source: ABdhPJxnZqE0IUw08hXKrX+JTvko046ieCDFS0+HatbRMRkZjlkI9ZeY+HG2qRZamdtBQcCO4uNF3Q==
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr5094119pls.244.1594934925673;
        Thu, 16 Jul 2020 14:28:45 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id y20sm5473104pfo.170.2020.07.16.14.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 14:28:45 -0700 (PDT)
Date:   Thu, 16 Jul 2020 14:28:44 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Shakeel Butt <shakeelb@google.com>
cc:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Subject: Re: [patch] mm, memcg: provide an anon_reclaimable stat
In-Reply-To: <CALvZod6DbAUA-M9VXJW4RumeUD8qGf+BHM+9TUNeAr92JVkxsA@mail.gmail.com>
Message-ID: <alpine.DEB.2.23.453.2007161427360.3213701@chino.kir.corp.google.com>
References: <20200715071522.19663-1-sjpark@amazon.com> <alpine.DEB.2.23.453.2007151031020.2788464@chino.kir.corp.google.com> <alpine.DEB.2.23.453.2007161357490.3209847@chino.kir.corp.google.com>
 <CALvZod6DbAUA-M9VXJW4RumeUD8qGf+BHM+9TUNeAr92JVkxsA@mail.gmail.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 16 Jul 2020, Shakeel Butt wrote:

> > Userspace can lack insight into the amount of memory that can be reclaimed
> > from a memcg based on values from memory.stat.  Two specific examples:
> >
> >  - Lazy freeable memory (MADV_FREE) that are clean anonymous pages on the
> >    inactive file LRU that can be quickly reclaimed under memory pressure
> >    but otherwise shows up as mapped anon in memory.stat, and
> >
> >  - Memory on deferred split queues (thp) that are compound pages that can
> >    be split and uncharged from the memcg under memory pressure, but
> >    otherwise shows up as charged anon LRU memory in memory.stat.
> >
> > Both of this anonymous usage is also charged to memory.current.
> >
> > Userspace can currently derive this information but it depends on kernel
> > implementation details for how this memory is handled for the purposes of
> > reclaim (anon on inactive file LRU or unmapped anon on the LRU).
> >
> > For the purposes of writing portable userspace code that does not need to
> > have insight into the kernel implementation for reclaimable memory, this
> > exports a stat that reveals the amount of anonymous memory that can be
> > reclaimed and uncharged from the memcg to start new applications.
> >
> > As the kernel implementation evolves for memory that can be reclaimed
> > under memory pressure, this stat can be kept consistent.
> >
> > Signed-off-by: David Rientjes <rientjes@google.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  6 +++++
> >  mm/memcontrol.c                         | 31 +++++++++++++++++++++++++
> >  2 files changed, 37 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1296,6 +1296,12 @@ PAGE_SIZE multiple when read back.
> >                 Amount of memory used in anonymous mappings backed by
> >                 transparent hugepages
> >
> > +         anon_reclaimable
> > +               The amount of charged anonymous memory that can be reclaimed
> > +               under memory pressure without swap.  This currently includes
> > +               lazy freeable memory (MADV_FREE) and compound pages that can be
> > +               split and uncharged.
> > +
> >           inactive_anon, active_anon, inactive_file, active_file, unevictable
> >                 Amount of memory, swap-backed and filesystem-backed,
> >                 on the internal memory management lists used by the
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1350,6 +1350,32 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
> >         return false;
> >  }
> >
> > +/*
> > + * Returns the amount of anon memory that is charged to the memcg that is
> > + * reclaimable under memory pressure without swap, in pages.
> > + */
> > +static unsigned long memcg_anon_reclaimable(struct mem_cgroup *memcg)
> > +{
> > +       long deferred, lazyfree;
> > +
> > +       /*
> > +        * Deferred pages are charged anonymous pages that are on the LRU but
> > +        * are unmapped.  These compound pages are split under memory pressure.
> > +        */
> > +       deferred = max_t(long, memcg_page_state(memcg, NR_ACTIVE_ANON) +
> > +                              memcg_page_state(memcg, NR_INACTIVE_ANON) -
> > +                              memcg_page_state(memcg, NR_ANON_MAPPED), 0);
> 
> Please note that the NR_ANON_MAPPED does not include tmpfs memory but
> NR_[IN]ACTIVE_ANON does include the tmpfs.
> 
> > +       /*
> > +        * Lazyfree pages are charged clean anonymous pages that are on the file
> > +        * LRU and can be reclaimed under memory pressure.
> > +        */
> > +       lazyfree = max_t(long, memcg_page_state(memcg, NR_ACTIVE_FILE) +
> > +                              memcg_page_state(memcg, NR_INACTIVE_FILE) -
> > +                              memcg_page_state(memcg, NR_FILE_PAGES), 0);
> 
> Similarly NR_FILE_PAGES includes tmpfs memory but NR_[IN]ACTIVE_FILE does not.
> 

Ah, so this adds to the motivation of providing the anon_reclaimable stat 
because the calculation becomes even more convoluted and completely based 
on the kernel implementation details for both lazyfree memory and deferred 
split queues.  Did you have a calculation in mind for 
memcg_anon_reclaimable()?
