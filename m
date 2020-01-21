Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D085144120
	for <lists+cgroups@lfdr.de>; Tue, 21 Jan 2020 17:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgAUQAJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jan 2020 11:00:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36547 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbgAUQAJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jan 2020 11:00:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id x184so1715975pfb.3
        for <cgroups@vger.kernel.org>; Tue, 21 Jan 2020 08:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RGHqVegSf46OSrC+vq5Pv4eGAqLOtAwhyN30PfSx9gU=;
        b=zoinFZ0mYrahd5Hl1dR/pT8vt/qq41K+qA8Hu0uEzs6mlFAFNlvnAch12rsopzsna0
         MNXC+r7/nPCC9+9CUKJwbajVlDzmdO6Qgu+H3wuh85tZslqyxdccc4VrsLuTqhRfyDyd
         MGVpXxoWhYOpTRPzk6Z62zIvWWq9vGnpCkB/mRCo54/h0TzeVtku4lgq589YqsBHdkbJ
         dnHSE4oCmvIZnG4aEQ3l4mcwVPt9P7qoGGUTGBqLcU8WjhYHGZFAjN9MF1ZnenLyrxVD
         VMWieaMITU5HC9uhCOAsCsHkG3XVRElBFX2UKbnzLw9BhbBEG3q0JF9z3KxmQ6wWDu4Q
         GiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RGHqVegSf46OSrC+vq5Pv4eGAqLOtAwhyN30PfSx9gU=;
        b=akokAaG9luaNiNvwMJoDKzbJ5jH1wRb2zg8ctnJqxxN9lfyZiyQAMiTYCwgFzGiEMd
         km3HcswzFxa2Kq9ZssQn8h36dgCuO46NhcQiOrvOV8WR5qVnA8tTCGIKL4+hRLp3561p
         fbew82aVf4GGJ0MELMTYwQTkzxcK1IUe7SS61JwZngjmZJ92yeFhz8Ioc/Ff0zW4Z0oT
         ZDcJUiM7c4eBfSmZDVq5T0CO5JoIiNjLm2rnQ/RPHqkgJhRTEznsyWAuNqiKMnt4MBTC
         T02NU+F//XxUe7PKV/6O44pVG80kkFvSyFso+G3Oo3r4VFBIKtKpMLOWs7GnfAx5eNAR
         VVHQ==
X-Gm-Message-State: APjAAAWB8SnSscWkTQyr+YnOvkSamISfDvSkwEJ/EQIJEMvCe8N42h5f
        5OlqZcw63Pu+IE28jaMBYZlVFA==
X-Google-Smtp-Source: APXvYqxuVoSpYzHo96UzVZPSuSADBuFnCVj4+LOj72UvgSuwSuN2rKsj1LKEx0Md+mb4O0Cvw/uxpQ==
X-Received: by 2002:a62:8782:: with SMTP id i124mr5101047pfe.22.1579622408512;
        Tue, 21 Jan 2020 08:00:08 -0800 (PST)
Received: from localhost ([2620:10d:c090:180::f3e0])
        by smtp.gmail.com with ESMTPSA id o98sm4261120pjb.15.2020.01.21.08.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 08:00:07 -0800 (PST)
Date:   Tue, 21 Jan 2020 11:00:05 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
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
Subject: Re: [PATCH v8 03/10] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20200121160005.GA69293@cmpxchg.org>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
 <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
 <20200116215222.GA64230@cmpxchg.org>
 <9ee80b68-a78f-714a-c727-1f6d2b4f87ea@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ee80b68-a78f-714a-c727-1f6d2b4f87ea@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 20, 2020 at 08:58:09PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/1/17 上午5:52, Johannes Weiner 写道:
> 
> > You simply cannot serialize on page->mem_cgroup->lruvec when
> > page->mem_cgroup isn't stable. You need to serialize on the page
> > itself, one way or another, to make this work.
> > 
> > 
> > So here is a crazy idea that may be worth exploring:
> > 
> > Right now, pgdat->lru_lock protects both PageLRU *and* the lruvec's
> > linked list.
> > 
> > Can we make PageLRU atomic and use it to stabilize the lru_lock
> > instead, and then use the lru_lock only serialize list operations?
> > 
> 
> Hi Johannes,
> 
> I am trying to figure out the solution of atomic PageLRU, but is 
> blocked by the following sitations, when PageLRU and lru list was protected
> together under lru_lock, the PageLRU could be a indicator if page on lru list
> But now seems it can't be the indicator anymore.
> Could you give more clues of stabilization usage of PageLRU?

There are two types of PageLRU checks: optimistic and deterministic.

The check in activate_page() for example is optimistic and the result
unstable, but that's okay, because if we miss a page here and there
it's not the end of the world.

But the check in __activate_page() is deterministic, because we need
to be sure before del_page_from_lru_list(). Currently it's made
deterministic by testing under the lock: whoever acquires the lock
first gets to touch the LRU state. The same can be done with an atomic
TestClearPagLRU: whoever clears the flag first gets to touch the LRU
state (the lock is then only acquired to not corrupt the linked list,
in case somebody adds or removes a different page at the same time).

I.e. in my proposal, if you want to get a stable read of PageLRU, you
have to clear it atomically. But AFAICS, everybody who currently does
need a stable read either already clears it or can easily be converted
to clear it and then set it again (like __activate_page and friends).

> __page_cache_release/release_pages/compaction            __pagevec_lru_add
> if (TestClearPageLRU(page))                              if (!PageLRU())
>                                                                 lruvec_lock();
>                                                                 list_add();
>         			                                lruvec_unlock();
>         			                                SetPageLRU() //position 1
>         lock_page_lruvec_irqsave(page, &flags);
>         del_page_from_lru_list(page, lruvec, ..);
>         unlock_page_lruvec_irqrestore(lruvec, flags);
>                                                                 SetPageLRU() //position 2

Hm, that's not how __pagevec_lru_add() looks. In fact,
__pagevec_lru_add_fn() has a BUG_ON(PageLRU).

That's because only one thread can own the isolation state at a time.

If PageLRU is set, only one thread can claim it. Right now, whoever
takes the lock first and clears it wins. When we replace it with
TestClearPageLRU, it's the same thing: only one thread can win.

And you cannot set PageLRU, unless you own it. Either you isolated the
page using TestClearPageLRU, or you allocated a new page.

So you can have multiple threads trying to isolate a page from the LRU
list, hence the atomic testclear. But no two threads should ever be
racing to add a page to the LRU list, because only one thread can own
the isolation state.

With the atomic PageLRU flag, the sequence would be this:

__pagevec_lru_add:

  BUG_ON(PageLRU()) // Caller *must* own the isolation state

  lruvec_lock()     // The lruvec is stable, because changing
                    // page->mem_cgroup requires owning the
                    // isolation state (PageLRU) and we own it

  list_add()        // Linked list protected by lru_lock

  lruvec_unlock()

  SetPageLRU()      // The page has been added to the linked
                    // list, give up our isolation state. Once
                    // this flag becomes visible, other threads
                    // can isolate the page from the LRU list
