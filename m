Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26277224BBF
	for <lists+cgroups@lfdr.de>; Sat, 18 Jul 2020 16:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgGROR7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Jul 2020 10:17:59 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:38127 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbgGROR6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 18 Jul 2020 10:17:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U33fhOh_1595081868;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U33fhOh_1595081868)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 18 Jul 2020 22:17:49 +0800
Subject: Re: [PATCH v16 21/22] mm/pgdat: remove pgdat lru_lock
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
        "Kirill A. Shutemov" <kirill@shutemov.name>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-22-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UeK3c4NjoJ7MQMxU20Bu0AZKZh73Cj4P_g5OSL6KaONhQ@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <5f162d78-2318-3d12-bbbb-1a47ed978bf7@linux.alibaba.com>
Date:   Sat, 18 Jul 2020 22:17:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeK3c4NjoJ7MQMxU20Bu0AZKZh73Cj4P_g5OSL6KaONhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/18 上午5:09, Alexander Duyck 写道:
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index e028b87ce294..4d7df42b32d6 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6721,7 +6721,6 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
>>         init_waitqueue_head(&pgdat->pfmemalloc_wait);
>>
>>         pgdat_page_ext_init(pgdat);
>> -       spin_lock_init(&pgdat->lru_lock);
>>         lruvec_init(&pgdat->__lruvec);
>>  }
>>
> This patch would probably make more sense as part of patch 18 since
> you removed all of the users of this field there.


yes, I just want to a bit of sense of ceremony to remove this huge big lock. :)
