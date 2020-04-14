Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D451A84FA
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 18:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391623AbgDNQb2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391696AbgDNQbW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 12:31:22 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D5FC061A0C
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 09:31:16 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v7so13974426qkc.0
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VLlqU4q1Tg1FlNFBFuJbOrDiNdW49LDEweZ01PUJ+98=;
        b=KqIgm1YWeupPQ5AKLZtSk0DWobRLAyx4G0DicpwgPEuui+DlaMsDiKTWKhHut76tPe
         cYkvg60mA+l32MQOTN2Yo9cr2x9SfF7mZFyW2bPkKGoWpB9W4i9Fg/XLdxsyHIRG6xIv
         Vdu9Te/V8atdgTrrO4LzPtLZ5EpU2OptdF7l28ADsB3fiAaEBk922FWRSmKrVCt6HG0T
         xX+N2nBIgTpHnzmZk3oEfPv09qpNqpyFn1/hmFKdTUV/HIjx0pv9hZkhSNQb2tcIGmmd
         fw0D7qs3MC9hPJXIiHPKn2r0dwccVBsgYR0SfZ5+96775nW8w/RprUF1bKur1zG/sKiy
         6YYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VLlqU4q1Tg1FlNFBFuJbOrDiNdW49LDEweZ01PUJ+98=;
        b=JlJKVLWvGO7GOabFsZc/xq9rty3fLDQCp8jz3AuDrHHfvgkK5NAZH4xRaW/pnjLPER
         XGXx+p7o2RCM5IUeAWGMLKvSuoNTjudq2UOSnJVtHtm+nIJ+Glp226x2U8g3opzcxXYR
         eNk5ud4ool3imlQfeoZNjXwY8SUSbWCmcLx8B8O5vWg5rrZBeRi65K5N/YfJW/Jq/3nY
         pZLfYwJGXfWYhlhhLXr5UB+g+UCaDZOwZvYGzHcqBfFKRS8Oq9mQggyWIRphyHlRovTz
         h++kIoZ7PO0aGnRlgR7v5UiRMZjoneLy/k7g4tph2EL/Q49VijD1MjSjJjK57jqUFD1f
         QUQw==
X-Gm-Message-State: AGi0PuZv7SpEl18OCTokgg3KwWSEF29AF5BMIekFWabds7uleToMTPk6
        YfGKylPvsKEMm/JhwdoQYErF/Q==
X-Google-Smtp-Source: APiQypJC4xDXZh2RTbpe7APa2bCoLe+wBervVwS7oEjfiQ4YylFde7I8dO9567LUfW0QyczZeiX5wQ==
X-Received: by 2002:a37:4a85:: with SMTP id x127mr22454961qka.152.1586881876177;
        Tue, 14 Apr 2020 09:31:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e623])
        by smtp.gmail.com with ESMTPSA id s14sm8027858qts.70.2020.04.14.09.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:31:15 -0700 (PDT)
Date:   Tue, 14 Apr 2020 12:31:14 -0400
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
Message-ID: <20200414163114.GA136578@cmpxchg.org>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
 <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
 <20200116215222.GA64230@cmpxchg.org>
 <cdcdb710-1d78-6fac-48d7-35519ddcdc6a@linux.alibaba.com>
 <20200413180725.GA99267@cmpxchg.org>
 <8e7bf170-2bb5-f862-c12b-809f7f7d96cb@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e7bf170-2bb5-f862-c12b-809f7f7d96cb@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 14, 2020 at 12:52:30PM +0800, Alex Shi wrote:
> 在 2020/4/14 上午2:07, Johannes Weiner 写道:
> > Plus, the overhead of tracking is tiny - 512k per G of swap (0.04%).
> > 
> > Maybe we should just delete MEMCG_SWAP and unconditionally track swap
> > entry ownership when the memory controller is enabled. I don't see a
> > good reason not to, and it would simplify the entire swapin path, the
> > LRU locking, and the page->mem_cgroup stabilization rules.
> > 
> 
> Sorry for not follow you up, did you mean just remove the MEMCG_SWAP configuration
> and keep the feature in default memcg? 

Yes.

> That does can remove lrucare, but PageLRU lock scheme still fails since
> we can not isolate the page during commit_charge, is that right?

No, without lrucare the scheme works. Charges usually do:

page->mem_cgroup = new;
SetPageLRU(page);

And so if you can TestClearPageLRU(), page->mem_cgroup is stable.

lrucare charging is the exception: it changes page->mem_cgroup AFTER
PageLRU has already been set, and even when it CANNOT acquire the
PageLRU lock itself. It violates the rules.

If we make MEMCG_SWAP mandatory, we always have cgroup records for
swapped out pages. That means we can charge all swapin pages
(incl. readahead pages) directly in __read_swap_cache_async(), before
setting PageLRU on the new pages.

Then we can delete lrucare.

And then TestClearPageLRU() guarantees page->mem_cgroup is stable.
