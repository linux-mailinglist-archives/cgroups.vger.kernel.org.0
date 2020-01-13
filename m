Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F064139157
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2020 13:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgAMMs7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jan 2020 07:48:59 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:42003 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726946AbgAMMs6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jan 2020 07:48:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Tne44Ij_1578919732;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tne44Ij_1578919732)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Jan 2020 20:48:53 +0800
Subject: Re: [PATCH v7 02/10] mm/memcg: fold lru_lock in lock_page_lru
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, shakeelb@google.com, hannes@cmpxchg.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
 <1577264666-246071-3-git-send-email-alex.shi@linux.alibaba.com>
 <36d7e390-a3d1-908c-d181-4a9e9c8d3d98@yandex-team.ru>
 <952d02c2-8aa5-40bb-88bb-c43dee65c8bc@linux.alibaba.com>
 <2ba8a04e-d8e0-1d50-addc-dbe1b4d8e0f1@yandex-team.ru>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <a095d80d-8e34-c84f-e4be-085a5aae1929@linux.alibaba.com>
Date:   Mon, 13 Jan 2020 20:47:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <2ba8a04e-d8e0-1d50-addc-dbe1b4d8e0f1@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/1/13 下午5:55, Konstantin Khlebnikov 写道:
>>>>
>>>> index c5b5f74cfd4d..0ad10caabc3d 100644
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>> @@ -2572,12 +2572,11 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>>>>      static void lock_page_lru(struct page *page, int *isolated)
>>>>    {
>>>> -    pg_data_t *pgdat = page_pgdat(page);
>>>> -
>>>> -    spin_lock_irq(&pgdat->lru_lock);
>>>>        if (PageLRU(page)) {
>>>> +        pg_data_t *pgdat = page_pgdat(page);
>>>>            struct lruvec *lruvec;
>>>>    +        spin_lock_irq(&pgdat->lru_lock);
>>>
>>> That's wrong. Here PageLRU must be checked again under lru_lock.
>> Hi, Konstantin,
>>
>> For logical remain, we can get the lock and then release for !PageLRU.
>> but I still can figure out the problem scenario. Would like to give more hints?
> 
> That's trivial race: page could be isolated from lru between
> 
> if (PageLRU(page))
> and
> spin_lock_irq(&pgdat->lru_lock);

yes, it could be a problem. guess the following change could helpful:
I will update it in new version.

Thanks a lot!
Alex

-static void lock_page_lru(struct page *page, int *isolated)
-{
-       pg_data_t *pgdat = page_pgdat(page);
-
-       spin_lock_irq(&pgdat->lru_lock);
-       if (PageLRU(page)) {
-               struct lruvec *lruvec;
-
-               lruvec = mem_cgroup_page_lruvec(page, pgdat);
-               ClearPageLRU(page);
-               del_page_from_lru_list(page, lruvec, page_lru(page));
-               *isolated = 1;
-       } else
-               *isolated = 0;
-}
-
-static void unlock_page_lru(struct page *page, int isolated)
-{
-       pg_data_t *pgdat = page_pgdat(page);
-
-       if (isolated) {
-               struct lruvec *lruvec;
-
-               lruvec = mem_cgroup_page_lruvec(page, pgdat);
-               VM_BUG_ON_PAGE(PageLRU(page), page);
-               SetPageLRU(page);
-               add_page_to_lru_list(page, lruvec, page_lru(page));
-       }
-       spin_unlock_irq(&pgdat->lru_lock);
-}
-
 static void commit_charge(struct page *page, struct mem_cgroup *memcg,
                          bool lrucare)
 {
-       int isolated;
+       struct lruvec *lruvec = NULL;

        VM_BUG_ON_PAGE(page->mem_cgroup, page);

@@ -2612,8 +2617,16 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
         * In some cases, SwapCache and FUSE(splice_buf->radixtree), the page
         * may already be on some other mem_cgroup's LRU.  Take care of it.
         */
-       if (lrucare)
-               lock_page_lru(page, &isolated);
+       if (lrucare) {
+               lruvec = lock_page_lruvec_irq(page);
+               if (likely(PageLRU(page))) {
+                       ClearPageLRU(page);
+                       del_page_from_lru_list(page, lruvec, page_lru(page));
+               } else {
+                       unlock_page_lruvec_irq(lruvec);
+                       lruvec = NULL;
+               }
+       }

        /*
         * Nobody should be changing or seriously looking at
@@ -2631,8 +2644,15 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
         */
        page->mem_cgroup = memcg;

-       if (lrucare)
-               unlock_page_lru(page, isolated);
+       if (lrucare && lruvec) {
+               unlock_page_lruvec_irq(lruvec);
+               lruvec = lock_page_lruvec_irq(page);
+
+               VM_BUG_ON_PAGE(PageLRU(page), page);
+               SetPageLRU(page);
+               add_page_to_lru_list(page, lruvec, page_lru(page));
+               unlock_page_lruvec_irq(lruvec);
+       }
 }
