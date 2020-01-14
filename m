Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3EF213A3B0
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2020 10:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgANJVl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jan 2020 04:21:41 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:42813 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbgANJVl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Jan 2020 04:21:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TnibZb5_1578993695;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TnibZb5_1578993695)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Jan 2020 17:21:35 +0800
Subject: Re: [PATCH v7 02/10] mm/memcg: fold lru_lock in lock_page_lru
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        shakeelb@google.com, hannes@cmpxchg.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
 <1577264666-246071-3-git-send-email-alex.shi@linux.alibaba.com>
 <36d7e390-a3d1-908c-d181-4a9e9c8d3d98@yandex-team.ru>
 <952d02c2-8aa5-40bb-88bb-c43dee65c8bc@linux.alibaba.com>
 <2ba8a04e-d8e0-1d50-addc-dbe1b4d8e0f1@yandex-team.ru>
 <a095d80d-8e34-c84f-e4be-085a5aae1929@linux.alibaba.com>
 <20200113163456.GA332@bombadil.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <2f3b6613-d107-6d89-2510-6d01c0ae0625@linux.alibaba.com>
Date:   Tue, 14 Jan 2020 17:20:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200113163456.GA332@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/1/14 上午12:34, Matthew Wilcox 写道:
> On Mon, Jan 13, 2020 at 08:47:25PM +0800, Alex Shi wrote:
>> 在 2020/1/13 下午5:55, Konstantin Khlebnikov 写道:
>>>>> That's wrong. Here PageLRU must be checked again under lru_lock.
>>>> Hi, Konstantin,
>>>>
>>>> For logical remain, we can get the lock and then release for !PageLRU.
>>>> but I still can figure out the problem scenario. Would like to give more hints?
>>>
>>> That's trivial race: page could be isolated from lru between
>>>
>>> if (PageLRU(page))
>>> and
>>> spin_lock_irq(&pgdat->lru_lock);
>>
>> yes, it could be a problem. guess the following change could helpful:
>> I will update it in new version.
> 
>> +       if (lrucare) {
>> +               lruvec = lock_page_lruvec_irq(page);
>> +               if (likely(PageLRU(page))) {
>> +                       ClearPageLRU(page);
>> +                       del_page_from_lru_list(page, lruvec, page_lru(page));
>> +               } else {
>> +                       unlock_page_lruvec_irq(lruvec);
>> +                       lruvec = NULL;
>> +               }
> 
> What about a harder race to hit like a page being on LRU list A when you
> look up the lruvec, then it's removed and added to LRU list B by the
> time you get the lock?  At that point, you are holding a lock on the
> wrong LRU list.  I think you need to check not just that the page
> is still PageLRU but also still on the same LRU list.
> 

Thanks for comments, Matthew!

We will check and lock lruvec after lock_page_memcg, so if it works well, a page
won't moved from one lruvec to another. Also the later debug do this check, to
see if lruvec changed.

If you mean lru list not lruvec, It seems there is noway to figure out the lru list
from a page now.

Thanks
Alex

