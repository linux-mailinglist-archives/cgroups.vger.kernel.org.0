Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4AA23E63F
	for <lists+cgroups@lfdr.de>; Fri,  7 Aug 2020 05:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgHGDZC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Aug 2020 23:25:02 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:44478 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbgHGDZC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Aug 2020 23:25:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U4zaDnJ_1596770697;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4zaDnJ_1596770697)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Aug 2020 11:24:58 +0800
Subject: Re: [PATCH v17 14/21] mm/compaction: do page isolation first in
 compaction
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
        Rong Chen <rong.a.chen@intel.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-15-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UcbBv=QBK9ErqLKXoNLYxFz52L4fiiHy4h6zKdBs=YPOg@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <241ca157-104f-4f0d-7d5b-de394443788d@linux.alibaba.com>
Date:   Fri, 7 Aug 2020 11:24:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcbBv=QBK9ErqLKXoNLYxFz52L4fiiHy4h6zKdBs=YPOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/7 上午2:38, Alexander Duyck 写道:
>> +
>>  isolate_abort:
>>         if (locked)
>>                 spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>> +       if (page) {
>> +               SetPageLRU(page);
>> +               put_page(page);
>> +       }
>>
>>         /*
>>          * Updated the cached scanner pfn once the pageblock has been scanned
> We should probably be calling SetPageLRU before we release the lru
> lock instead of before. It might make sense to just call it before we
> get here, similar to how you did in the isolate_fail_put case a few
> lines later. Otherwise this seems to violate the rules you had set up
> earlier where we were only going to be setting the LRU bit while
> holding the LRU lock.

Hi Alex,

Set out of lock here should be fine. I never said we must set the bit in locking.
And this page is get by get_page_unless_zero(), no warry on release.

Thanks
Alex
