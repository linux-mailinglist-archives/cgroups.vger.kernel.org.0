Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E962A8BFC
	for <lists+cgroups@lfdr.de>; Fri,  6 Nov 2020 02:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbgKFBL3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Nov 2020 20:11:29 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:53250 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732396AbgKFBL2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Nov 2020 20:11:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0UEMg2FE_1604625083;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEMg2FE_1604625083)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Nov 2020 09:11:24 +0800
Subject: Re: [PATCH v20 08/20] mm: page_idle_get_page() does not need lru_lock
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-9-git-send-email-alex.shi@linux.alibaba.com>
 <20201102144110.GB724984@cmpxchg.org>
 <20201102144927.GN27442@casper.infradead.org>
 <20201102202003.GA740958@cmpxchg.org>
 <b4038b87-cf5a-fcb7-06f4-b98874029615@linux.alibaba.com>
 <20201104174603.GB744831@cmpxchg.org>
 <6eea82d8-e406-06ee-2333-eb6e2f1944e5@linux.alibaba.com>
 <20201105045702.GI17076@casper.infradead.org>
 <1e8f0162-cf2e-03eb-e7e0-ccc9f6a3eaf2@linux.alibaba.com>
 <20201105153649.GC744831@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <a7ed8ebf-0d7b-2f01-eaad-14a07e660f68@linux.alibaba.com>
Date:   Fri, 6 Nov 2020 09:11:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201105153649.GC744831@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/11/5 下午11:36, Johannes Weiner 写道:
>>> 	 */
>>>
> Yeah, I don't think this scenario warrants the full race diagram in
> the code itself.
> 
> But the code is highly specific - synchronizing one struct page member
> for one particular use case. Let's keep at least a reference to what
> we are synchronizing against. There is a non-zero chance that if the
> comment goes out of date, so does the code. How about this?
> 
> 	/*
> 	 * page_idle does a lockless/optimistic rmap scan on page->mapping.
> 	 * Make sure the compiler doesn't split the stores of anon_vma and
> 	 * the PAGE_MAPPING_ANON type identifier, otherwise the rmap code
> 	 * could mistake the mapping for a struct address_space and crash.
> 	 */

Thanks a lot to you all. I will update to v21 patch

Alex
