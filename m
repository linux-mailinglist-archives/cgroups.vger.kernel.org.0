Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A6B1092C7
	for <lists+cgroups@lfdr.de>; Mon, 25 Nov 2019 18:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfKYR1i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Nov 2019 12:27:38 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41600 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfKYR1i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Nov 2019 12:27:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id 94so13310673oty.8
        for <cgroups@vger.kernel.org>; Mon, 25 Nov 2019 09:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ehtg0LDgFByK5WRliTFTt8kMCURVP50x4sdG0deprfY=;
        b=MsGNoi87guRmgvoKPI/D/lOK0M/mezTFZNaBeRkMe12Xdy9kJ4sQT0icrrtk/cQ7I+
         XoOUItIX1FSBnkYcrZNSLWVdkvbyYY40szlADlj3lWhFlS5quaL3NVAC+VY+2TVDe7jI
         KJ+irc2cGqgmeHCwls2VTypiKNL4znvvZVBq7mEG+h2OaXeYPNK1I5f176snrGp3GBXx
         B8P0Z1NJcl6VH8gT+6fWXSAYEvX+5xYGf7Dpzb4m5qVgjkm4VYf1mvMik/y5MBs39Mlc
         IptXJd/rvAlz7G/M0cIit1TcxUUhwgZJZwIepPVz//Hd5W1aQ7RNB1qVciD6Jo0S4AlO
         3PJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ehtg0LDgFByK5WRliTFTt8kMCURVP50x4sdG0deprfY=;
        b=fXjapPloNmRAZ+sdlz0oYX6Hhq5847hxjOyT2tLuDQHMbRGiPj2oQkViir54sO4tV6
         Qss+wH0uADgpNoYqRBwzwKIvw47I+HN0o1dFjBdb/GWdOIzQJbgGjmLalc0czQBtTm5/
         dXUizKbWUUE3v5K7Y0RLRUCkTCfgFrqYL6eyT6f2Aff1lbsVTn0pJi6w1sttNiBnndBE
         6gaGuGd9woZ7zVMwU/Ged6PbiUqJ+cxcm+nmdpXikfB5+9Zk/ofK3GCi+uE4c06HHl9u
         ujsoxdDBHSP3K+xjppw9r9Ndox65kAvsKVKZUJMh2BAYsGUPjiobnKAIJVnl53ks9Ytp
         kpwg==
X-Gm-Message-State: APjAAAXOJ4UAuGIIR366lkehrhgrCcnOiCnpCUJZEqrRjte0L+oF4Pdq
        W5BxWv1RFPc/OPUgs4lukz7ZDNXGPVcHy/tOKRIe8xoq
X-Google-Smtp-Source: APXvYqxpNOnsfH70r6wlFMNUcWUSE7NqnT2MNrFaRB7UYaM0KYhnvGDb5WggsU+yxs0nW8YmcyUasGizxzAArT0Llgg=
X-Received: by 2002:a9d:3982:: with SMTP id y2mr21401811otb.191.1574702857225;
 Mon, 25 Nov 2019 09:27:37 -0800 (PST)
MIME-Version: 1.0
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
 <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com>
 <20191119160456.GD382712@cmpxchg.org> <bcf6a952-5b92-50ad-cfc1-f4d9f8f63172@linux.alibaba.com>
 <20191121220613.GB487872@cmpxchg.org> <d3bbbbf5-52c5-374c-0897-899e787cecb4@linux.alibaba.com>
 <20191122161652.GA489821@cmpxchg.org> <e629f595-df0a-71b2-35b4-b266ba1d0431@linux.alibaba.com>
In-Reply-To: <e629f595-df0a-71b2-35b4-b266ba1d0431@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 25 Nov 2019 09:27:25 -0800
Message-ID: <CALvZod4ZKh3HbDWJz5-tD9Q0gcMUjWmqzBGUD-ejOLCoS7ga2w@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 25, 2019 at 1:26 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
>
> >
> > But that leaves me with one more worry: compaction. We locked out
> > charge moving now, so between that and knowing that the page is alive,
> > we have page->mem_cgroup stable. But compaction doesn't know whether
> > the page is alive - it comes from a pfn and finds out using PageLRU.
> >
> > In the current code, pgdat->lru_lock remains the same before and after
> > the page is charged to a cgroup, so once compaction has that locked
> > and it observes PageLRU, it can go ahead and isolate the page.
> >
> > But lruvec->lru_lock changes during charging, and then compaction may
> > hold the wrong lock during isolation:
> >
> > compaction:                           generic_file_buffered_read:
> >
> >                                       page_cache_alloc()
> >
> > !PageBuddy()
> >
> > lock_page_lruvec(page)
> >   lruvec = mem_cgroup_page_lruvec()
> >   spin_lock(&lruvec->lru_lock)
> >   if lruvec != mem_cgroup_page_lruvec()
> >     goto again
> >
> >                                       add_to_page_cache_lru()
> >                                         mem_cgroup_commit_charge()
> >                                           page->mem_cgroup = foo
> >                                         lru_cache_add()
> >                                           __pagevec_lru_add()
> >                                             SetPageLRU()
> >
> > if PageLRU(page):
> >   __isolate_lru_page()
> >
> > I don't see what prevents the lruvec from changing under compaction,
> > neither in your patches nor in Hugh's. Maybe I'm missing something?
> >
>
> Hi Johannes,
>
> It looks my patch do the lruvec recheck/relock after PageLRU in compaction.c.
> It should be fine for your question. So I will try more testing after all changes.

Actually no, unless PageLRU check and taking lruvec lock are atomic,
the race mentioned by Johannes still exist.

Shakeel
