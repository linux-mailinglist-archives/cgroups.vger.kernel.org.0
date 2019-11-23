Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83A50107C39
	for <lists+cgroups@lfdr.de>; Sat, 23 Nov 2019 01:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfKWA6w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Nov 2019 19:58:52 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34888 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfKWA6t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Nov 2019 19:58:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id k32so4181831pgl.2
        for <cgroups@vger.kernel.org>; Fri, 22 Nov 2019 16:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IuWeFnrYeJCjuhCM2V1dA58lGjRpOtXacus/IBoPj+E=;
        b=SWT9RPbbH0wqbnY590Ng1zNYJSEYMwqyk2hjYVStgfe3cn8J9xhspUE/IhAhMyiyYF
         ITsmkvVswijzNTydtgsNqLfWO5AlPmHZfgbeP/ck3vqmG8WD1AthVOBjQq/7wIxhNj6N
         IhmPbMJDedgw7loa0CC2hR6GkM41ieeXfMen6GAXTZZY2Y0aEjcK/Bj1BejspvEmOXyA
         zo/hn1dh/4KxioncezIii0LXRSfDqEwYu6VZbBVGOhhR7OLAyWwJhZLPdB9oGfMaULZa
         gsxPSmoSKUVsQOHxRh4sawj5xROFzr/xaOzGB7fddbIKF3FVjM+LXYaqj5zXQ27i30Lz
         iu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IuWeFnrYeJCjuhCM2V1dA58lGjRpOtXacus/IBoPj+E=;
        b=mpelM3JI1lZ0QX9Qbw+7p8Ez98CCVVxna2S8O7elLb5dSvo0ViekWQ/xZ5VPl76ZIL
         j1B/SdNFaa0XyAkAaBgSkKXxMumAMaUL57c8oVxYRfA6OeI5k+memBVGY7bO33M5mueA
         y5a0ao/+NOXiC/c5CSLF47XE42/a/N/KBgA8lKQgnAlOaVI414zrlKlrfIy4mf89v9L3
         6AQYXE6p/RGcPsQjF3OPM31wpCfbuqJXcdnJu8xNgcq+FuOno0LKXg6FzWXJ0na0N/4l
         X3R6l20/U5VkpDKlRzH1qK0F6QVjwHgryO/70iGki3KPiK/4UOkGRCQk8uEeLk/lLK4x
         cu7g==
X-Gm-Message-State: APjAAAWSwX++RNpiCEySQuknQGhQLfO/Uwh1DMMWZx5DT2/GC2RAikRX
        AdJQupxMhJa5uX8EbNvOkMvoug==
X-Google-Smtp-Source: APXvYqz0ZXll8DZmCwf0ofv4uPNO7sFTvsQEUZIIytWRI6hPkiIhvNBJyAjp5BS/LzwHLnPhFD8fWw==
X-Received: by 2002:a63:fb04:: with SMTP id o4mr1513860pgh.122.1574470727152;
        Fri, 22 Nov 2019 16:58:47 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id w69sm9117470pfc.164.2019.11.22.16.58.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Nov 2019 16:58:46 -0800 (PST)
Date:   Fri, 22 Nov 2019 16:58:34 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Alex Shi <alex.shi@linux.alibaba.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, shakeelb@google.com,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v4 3/9] mm/lru: replace pgdat lru_lock with lruvec lock
In-Reply-To: <20191122161652.GA489821@cmpxchg.org>
Message-ID: <alpine.LSU.2.11.1911221616580.1144@eggly.anvils>
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com> <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com> <20191119160456.GD382712@cmpxchg.org> <bcf6a952-5b92-50ad-cfc1-f4d9f8f63172@linux.alibaba.com> <20191121220613.GB487872@cmpxchg.org>
 <d3bbbbf5-52c5-374c-0897-899e787cecb4@linux.alibaba.com> <20191122161652.GA489821@cmpxchg.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 22 Nov 2019, Johannes Weiner wrote:
> 
> But that leaves me with one more worry: compaction. We locked out
> charge moving now, so between that and knowing that the page is alive,
> we have page->mem_cgroup stable. But compaction doesn't know whether
> the page is alive - it comes from a pfn and finds out using PageLRU.
> 
> In the current code, pgdat->lru_lock remains the same before and after
> the page is charged to a cgroup, so once compaction has that locked
> and it observes PageLRU, it can go ahead and isolate the page.
> 
> But lruvec->lru_lock changes during charging, and then compaction may
> hold the wrong lock during isolation:
> 
> compaction:				generic_file_buffered_read:
> 
> 					page_cache_alloc()
> 
> !PageBuddy()
> 
> lock_page_lruvec(page)
>   lruvec = mem_cgroup_page_lruvec()
>   spin_lock(&lruvec->lru_lock)
>   if lruvec != mem_cgroup_page_lruvec()
>     goto again
> 
> 					add_to_page_cache_lru()
> 					  mem_cgroup_commit_charge()
> 					    page->mem_cgroup = foo
> 					  lru_cache_add()
> 					    __pagevec_lru_add()
> 					      SetPageLRU()
> 
> if PageLRU(page):
>   __isolate_lru_page()
> 
> I don't see what prevents the lruvec from changing under compaction,
> neither in your patches nor in Hugh's. Maybe I'm missing something?

Speaking for my patches only: I'm humbled, I think you have caught me,
I cannot find any argument against the race you suggest here.

The race with mem_cgroup_move_account(), which Konstantin pointed out
in 2012's https://lore.kernel.org/lkml/4F433418.3010401@openvz.org/
but I later misunderstood, and came to think I needed no patch against,
until this week coming to perceive the same race in isolate_lru_page():
that one is easily and satisfactorily fixed by holding lruvec lock in
mem_cgroup_move_account() - embarrassing, but not too serious.

Your race here (again, lruvec lock taken then PageLRU observed, but
page->mem_cgroup changed in between) really questions my whole scheme:
I am not going to propose a solution now, I'll have to go back and
recheck my assumptions all over.  Certainly isolate_migratepage_block()
has a harder job than any other, but I need to re-review it all.

Maybe we got it right back in the days of PageCgroupUsed, and then I
paid too little attention when rebasing to your welcome simplifications.
I don't think any of us want to bring back PageCgroupUsed! And maybe we
could get it right by always holding lruvec lock in commit_charge(),
lrucare or not; but that's a much hotter path, and not a change I'd
expect anyone to embrace.

I'll go away and re-examine it all; probably start by verifying that
your race actually happens in practice, though we never observed it.

Heavy-hearted thanks, Hannes!
Hugh
