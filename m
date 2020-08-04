Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F3F23B86D
	for <lists+cgroups@lfdr.de>; Tue,  4 Aug 2020 12:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgHDKE6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Aug 2020 06:04:58 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:54201 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728332AbgHDKE5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Aug 2020 06:04:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U4jkImR_1596535490;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4jkImR_1596535490)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Aug 2020 18:04:51 +0800
Subject: Re: [PATCH v17 21/21] mm/lru: revise the comments of lru_lock
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
        Rong Chen <rong.a.chen@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jann Horn <jannh@google.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-22-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UfpHjBTHvtZz7=WMhZZAunVYuNMpuYBQCiorERb5seFUQ@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <f34e790f-50e6-112c-622f-d7ab804c6d22@linux.alibaba.com>
Date:   Tue, 4 Aug 2020 18:04:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfpHjBTHvtZz7=WMhZZAunVYuNMpuYBQCiorERb5seFUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/4 上午6:37, Alexander Duyck 写道:
>>
>>  shrink_inactive_list() also diverts any unevictable pages that it finds on the
>> -inactive lists to the appropriate zone's unevictable list.
>> +inactive lists to the appropriate node's unevictable list.
>>
>>  shrink_inactive_list() should only see SHM_LOCK'd pages that became SHM_LOCK'd
>>  after shrink_active_list() had moved them to the inactive list, or pages mapped
> Same here.

lruvec is used per memcg per node actually, and it fallback to node if memcg disabled.
So the comments are still right.

And most of changes just fix from zone->lru_lock to pgdat->lru_lock change.
> 
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 64ede5f150dc..44738cdb5a55 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -78,7 +78,7 @@ struct page {
>>                 struct {        /* Page cache and anonymous pages */
>>                         /**
>>                          * @lru: Pageout list, eg. active_list protected by
>> -                        * pgdat->lru_lock.  Sometimes used as a generic list
>> +                        * lruvec->lru_lock.  Sometimes used as a generic list
>>                          * by the page owner.
>>                          */
>>                         struct list_head lru;
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 8af956aa13cf..c92289a4e14d 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -115,7 +115,7 @@ static inline bool free_area_empty(struct free_area *area, int migratetype)
>>  struct pglist_data;
>>
>>  /*
>> - * zone->lock and the zone lru_lock are two of the hottest locks in the kernel.
>> + * zone->lock and the lru_lock are two of the hottest locks in the kernel.
>>   * So add a wild amount of padding here to ensure that they fall into separate
>>   * cachelines.  There are very few zone structures in the machine, so space
>>   * consumption is not a concern here.
> So I don't believe you are using ZONE_PADDING in any way to try and
> protect the LRU lock currently. At least you aren't using it in the
> lruvec. As such it might make sense to just drop the reference to the
> lru_lock here. That reminds me that we still need to review the
> placement of the lru_lock and determine if there might be a better
> placement and/or padding that might improve performance when under
> heavy stress.
> 

Right, is it the following looks better?

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ccc76590f823..0ed520954843 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -113,8 +113,7 @@ static inline bool free_area_empty(struct free_area *area, int migratetype)
 struct pglist_data;

 /*
- * zone->lock and the lru_lock are two of the hottest locks in the kernel.
- * So add a wild amount of padding here to ensure that they fall into separate
+ * Add a wild amount of padding here to ensure datas fall into separate
  * cachelines.  There are very few zone structures in the machine, so space
  * consumption is not a concern here.
  */

Thanks!
Alex
