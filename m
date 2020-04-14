Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9F91A8534
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 18:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391844AbgDNQhJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 12:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391838AbgDNQhB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 12:37:01 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770E2C061A0C
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 09:37:01 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g74so13875377qke.13
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DYImV4WFqfjPjnkhvl2nD8nYSEJboQaYtVJWAd3b//Q=;
        b=KS5KSsAg991FP2nFTxhky8wQhQOu9BwakhqYU+efKhtive2f3PbE42bLxc5ZIjZRzc
         PNWD/LEGWAtMm5/XDuYn/2V4ghpqNkIk8WmZzEJDhpzW4YQNMk1oJKjjSmLLHWlxNlwS
         SRUHNobeIH59Sg0OvosYB0vVt4FtWC7jtzla2qHmPJoefzLEY2MgbK5IVRlVcrYE4yjp
         pbtJ8ktGppKUT+kjFT9pc36mAcNXqgmuiq2LD/VFTMh5hdHNLBGM4atG+Z8QcePqRbK+
         Va56KXOZ1ODNr3uJ0s9LW7EOHOBYLzqekZ1OIXQgckvam6fjqxNU8ywgqJZiDaF17jON
         qxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DYImV4WFqfjPjnkhvl2nD8nYSEJboQaYtVJWAd3b//Q=;
        b=I0tetE9TtrVNwEXz7mBNdpBpOaskHGGuEyk6LebJKgESMPLEPEoTY5i2wS1IyziiOY
         l+rgLXdUsUZCPfpRrLI3Fdrm++dJY7McLrmJjyqBcspStUyCCcWG8/OIUKH+xbPdmBa7
         Hy2ZpJLfuVFqFzAgnVJIhh8RytKn4bR5pQx2Hd93SDE4k5BufSczLgvMng6CDndDQiKT
         /acLnv3hKSpin+KDnCnzPJWkUMrOWmKr3OmZcdS4TLKsjlwPlM4NWpl4eJDTNTyhuhr1
         Xz1LlHKpRwBS/IESwtYxcURE9yxIbjQeRIKSYJG0FqmgCW9wCcARzlBoE4VPlshO2q2I
         3hxQ==
X-Gm-Message-State: AGi0PuaFneEkh2eGLGBpOYrk+b+HnsRygkwzoG94ZClej/zV1rVBtvm9
        W8/U+4A01SVEWtmzApF/pE3tKg==
X-Google-Smtp-Source: APiQypJDaEd/nGS9BTaUv72nAKo3JSl8h//gwiZ42bd2PG7DF/jOIddhKGGPuIigNWUmnLczWkFCwg==
X-Received: by 2002:a37:ac08:: with SMTP id e8mr3627259qkm.439.1586882220593;
        Tue, 14 Apr 2020 09:37:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e623])
        by smtp.gmail.com with ESMTPSA id u24sm2884840qkk.84.2020.04.14.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:36:59 -0700 (PDT)
Date:   Tue, 14 Apr 2020 12:36:58 -0400
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
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v8 03/10] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20200414163658.GB136578@cmpxchg.org>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
 <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
 <20200116215222.GA64230@cmpxchg.org>
 <cdcdb710-1d78-6fac-48d7-35519ddcdc6a@linux.alibaba.com>
 <20200413180725.GA99267@cmpxchg.org>
 <42d5c2cb-3019-993f-eba7-33a1d69ef699@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42d5c2cb-3019-993f-eba7-33a1d69ef699@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 14, 2020 at 04:19:01PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/4/14 上午2:07, Johannes Weiner 写道:
> > But isolation actually needs to lock out charging, or it would operate
> > on the wrong list:
> > 
> > isolation:                                     commit_charge:
> > if (TestClearPageLRU(page))
> >                                                page->mem_cgroup = new
> >   // page is still physically on
> >   // the root_mem_cgroup's LRU. We're
> >   // updating the wrong list:
> >   memcg = page->mem_cgroup
> >   spin_lock(memcg->lru_lock)
> >   del_page_from_lru_list(page, memcg)
> >   spin_unlock(memcg->lru_lock)
> > 
> > lrucare really is a mess. Even before this patch series, it makes
> > things tricky and subtle and error prone.
> > 
> > The only reason we're doing it is for when there is swapping without
> > swap tracking, in which case swap reahadead needs to put pages on the
> > LRU but cannot charge them until we have a faulting vma later.
> > 
> > But it's not clear how practical such a configuration is. Both memory
> > and swap are shared resources, and isolation isn't really effective
> > when you restrict access to memory but then let workloads swap freely.
> > 
> > Plus, the overhead of tracking is tiny - 512k per G of swap (0.04%).
> > 
> > Maybe we should just delete MEMCG_SWAP and unconditionally track swap
> > entry ownership when the memory controller is enabled. I don't see a
> > good reason not to, and it would simplify the entire swapin path, the
> > LRU locking, and the page->mem_cgroup stabilization rules.
> 
> Hi Johannes,
> 
> I think what you mean here is to keep swap_cgroup id even it was swaped,
> then we read back the page from swap disk, we don't need to charge it.
> So all other memcg charge are just happens on non lru list, thus we have
> no isolation required in above awkward scenario.

We don't need to change how swap recording works, we just need to
always do it when CONFIG_MEMCG && CONFIG_SWAP.

We can uncharge the page once it's swapped out. The only difference is
that with a swap record, we know who owned the page and can charge
readahead pages right awya, before setting PageLRU; whereas without a
record, we read pages onto the LRU, and then wait until we hit a page
fault with an mm to charge. That's why we have this lrucare mess.
