Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D95422519C
	for <lists+cgroups@lfdr.de>; Sun, 19 Jul 2020 13:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgGSLYQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Jul 2020 07:24:16 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33998 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbgGSLYQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 Jul 2020 07:24:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0U38ILvo_1595157849;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U38ILvo_1595157849)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 19 Jul 2020 19:24:09 +0800
Subject: Re: [PATCH v16 13/22] mm/lru: introduce TestClearPageLRU
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-14-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UfLbVRQ4+TOw-XnjuyZqoVmRmWb5_rbEZZ0povYv-n_Lg@mail.gmail.com>
 <072b39ac-b95a-94f1-67a2-3293d4550ff8@linux.alibaba.com>
 <CAKgT0UdDQp_bptKAjG4A4fJQgS5gJuvu6D7LJfKw_wETLtLG_w@mail.gmail.com>
 <530c222e-dfd4-f78e-e9d4-315fad6f816a@linux.alibaba.com>
Message-ID: <c189ebf6-47a8-bb8f-2c99-a7ddb159b9c9@linux.alibaba.com>
Date:   Sun, 19 Jul 2020 19:24:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <530c222e-dfd4-f78e-e9d4-315fad6f816a@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/19 下午12:45, Alex Shi 写道:
>>>
>>>> It might make it more readable to pull in the later patch that
>>>> modifies isolate_lru_pages that has it using TestClearPageLRU.
>>> As to this change, It has to do in this patch, since any TestClearPageLRU may
>>> cause lru bit miss in the lru list, so the precondication check has to
>>> removed here.
>> So I think some of my cognitive dissonance is from the fact that you
>> really are doing two different things here. You aren't really
>> implementing the full TestClearPageLRU until patch 15. So this patch
>> is doing part of 2a and 2b, and then patch 15 is following up and
>> completing the 2a cases. I still think it might make more sense to
>> pull out the pieces related to 2b and move them into a patch before
>> this with documentation explaining that there should be no competition
>> for the LRU flag because the page has transitioned to a reference
>> count of zero. Then take the remaining bits and combine them with
>> patch 15 since the description for the two is pretty similar.
>>


As to the patch split suggest, actually, Hugh and I talked about a few weeks 
ago when he give me these changes. We both thought keep these changes in this
patch looks better at that time.
If it make you confuse, don't know a changed commit log make it better?

Thanks
Alex

    mm/lru: introduce TestClearPageLRU

    Currently lru_lock still guards both lru list and page's lru bit, that's
    ok. but if we want to use specific lruvec lock on the page, we need to
    pin down the page's lruvec/memcg during locking. Just taking lruvec
    lock first may be undermined by the page's memcg charge/migration. To
    fix this problem, we could take out the page's lru bit clear and use
    it as pin down action to block the memcg changes. That's the reason
    for new atomic func TestClearPageLRU. So now isolating a page need both
    actions: TestClearPageLRU and hold the lru_lock.

    This patch combines PageLRU check and ClearPageLRU into a macro func
    TestClearPageLRU. This function will be used as page isolation
    precondition to prevent other isolations some where else.
    Then there are may non PageLRU page on lru list, need to remove BUG
    checking accordingly.

    There 2 rules for lru bit:
    1, the lru bit still indicate if a page on lru list, just
    in some temporary moment(isolating), the page may have no lru bit when
    it's on lru list.  but the page still must be on lru list when the
    lru bit is set.
    2, have to remove lru bit before delete it from lru list.

    Hugh Dickins pointed that when a page is in freeing path and no one is
    possible to take it, non atomic lru bit clearing is better, like in
    __page_cache_release and release_pages.
    ANd no need get_page() before lru bit clear in isolate_lru_page,
    since it '(1) Must be called with an elevated refcount on the page'.

    As Andrew Morton mentioned this change would dirty cacheline for page
    isn't on LRU. But the lost would be acceptable with Rong Chen
    <rong.a.chen@intel.com> report:
    https://lkml.org/lkml/2020/3/4/173

    Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
    Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
    Cc: Hugh Dickins <hughd@google.com>
    Cc: Johannes Weiner <hannes@cmpxchg.org>
    Cc: Michal Hocko <mhocko@kernel.org>
    Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: linux-kernel@vger.kernel.org
    Cc: cgroups@vger.kernel.org
    Cc: linux-mm@kvack.org


