Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BED224BB6
	for <lists+cgroups@lfdr.de>; Sat, 18 Jul 2020 16:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgGROPb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Jul 2020 10:15:31 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:50442 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726818AbgGROPb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 18 Jul 2020 10:15:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0U33fh2O_1595081725;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U33fh2O_1595081725)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 18 Jul 2020 22:15:25 +0800
Subject: Re: [PATCH v16 20/22] mm/vmscan: use relock for move_pages_to_lru
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
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jann Horn <jannh@google.com>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-21-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0Ufp2FsJd+Lz9U2c_w5Eeb121xRg4SJ5Xoj2=9qZnVKkrA@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <7176001a-fa58-3281-7c6b-b25eea54bd15@linux.alibaba.com>
Date:   Sat, 18 Jul 2020 22:15:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ufp2FsJd+Lz9U2c_w5Eeb121xRg4SJ5Xoj2=9qZnVKkrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/18 上午5:44, Alexander Duyck 写道:
>>                         if (unlikely(PageCompound(page))) {
>>                                 spin_unlock_irq(&lruvec->lru_lock);
>> +                               lruvec = NULL;
>>                                 destroy_compound_page(page);
>> -                               spin_lock_irq(&lruvec->lru_lock);
>>                         } else
>>                                 list_add(&page->lru, &pages_to_free);
>>
> It seems like this should just be rolled into patch 19. Otherwise if
> you are wanting to consider it as a "further optimization" type patch
> you might pull some of the optimizations you were pushing in patch 18
> into this patch as well and just call it out as adding relocks where
> there previously were none.

This patch is picked from Hugh Dickin's version in my review. It could be
fine to have a extra patch which no harm for anyone. :)

Thanks
Alex
