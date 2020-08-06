Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C04023D524
	for <lists+cgroups@lfdr.de>; Thu,  6 Aug 2020 03:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgHFBji (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Aug 2020 21:39:38 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:44365 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbgHFBjh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Aug 2020 21:39:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U4t4FRM_1596677972;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4t4FRM_1596677972)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Aug 2020 09:39:32 +0800
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
 <f34e790f-50e6-112c-622f-d7ab804c6d22@linux.alibaba.com>
 <CAKgT0UckqbmYJDE3L2Bg1Nr=Y=GT0OBx1GEhaZ14EbRTzd8tiw@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <a1c6a3a6-f8e3-7bb5-e881-216a4b57ae84@linux.alibaba.com>
Date:   Thu, 6 Aug 2020 09:39:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UckqbmYJDE3L2Bg1Nr=Y=GT0OBx1GEhaZ14EbRTzd8tiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/4 下午10:29, Alexander Duyck 写道:
> On Tue, Aug 4, 2020 at 3:04 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>
>>
>>
>> 在 2020/8/4 上午6:37, Alexander Duyck 写道:
>>>>
>>>>  shrink_inactive_list() also diverts any unevictable pages that it finds on the
>>>> -inactive lists to the appropriate zone's unevictable list.
>>>> +inactive lists to the appropriate node's unevictable list.
>>>>
>>>>  shrink_inactive_list() should only see SHM_LOCK'd pages that became SHM_LOCK'd
>>>>  after shrink_active_list() had moved them to the inactive list, or pages mapped
>>> Same here.
>>
>> lruvec is used per memcg per node actually, and it fallback to node if memcg disabled.
>> So the comments are still right.
>>
>> And most of changes just fix from zone->lru_lock to pgdat->lru_lock change.
> 
> Actually in my mind one thing that might work better would be to
> explain what the lruvec is and where it resides. Then replace zone
> with lruvec since that is really where the unevictable list resides.
> Then it would be correct for both the memcg and pgdat case.

Could you like to revise the doc as your thought?
> 
>>>
>>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>>> index 64ede5f150dc..44738cdb5a55 100644
>>>> --- a/include/linux/mm_types.h
>>>> +++ b/include/linux/mm_types.h
>>>> @@ -78,7 +78,7 @@ struct page {
>>>>                 struct {        /* Page cache and anonymous pages */
>>>>                         /**
>>>>                          * @lru: Pageout list, eg. active_list protected by
>>>> -                        * pgdat->lru_lock.  Sometimes used as a generic list
>>>> +                        * lruvec->lru_lock.  Sometimes used as a generic list
>>>>                          * by the page owner.
>>>>                          */
>>>>                         struct list_head lru;
>>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>>> index 8af956aa13cf..c92289a4e14d 100644
>>>> --- a/include/linux/mmzone.h
>>>> +++ b/include/linux/mmzone.h
>>>> @@ -115,7 +115,7 @@ static inline bool free_area_empty(struct free_area *area, int migratetype)
>>>>  struct pglist_data;
>>>>
>>>>  /*
>>>> - * zone->lock and the zone lru_lock are two of the hottest locks in the kernel.
>>>> + * zone->lock and the lru_lock are two of the hottest locks in the kernel.
>>>>   * So add a wild amount of padding here to ensure that they fall into separate
>>>>   * cachelines.  There are very few zone structures in the machine, so space
>>>>   * consumption is not a concern here.
>>> So I don't believe you are using ZONE_PADDING in any way to try and
>>> protect the LRU lock currently. At least you aren't using it in the
>>> lruvec. As such it might make sense to just drop the reference to the
>>> lru_lock here. That reminds me that we still need to review the
>>> placement of the lru_lock and determine if there might be a better
>>> placement and/or padding that might improve performance when under
>>> heavy stress.
>>>
>>
>> Right, is it the following looks better?
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index ccc76590f823..0ed520954843 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -113,8 +113,7 @@ static inline bool free_area_empty(struct free_area *area, int migratetype)
>>  struct pglist_data;
>>
>>  /*
>> - * zone->lock and the lru_lock are two of the hottest locks in the kernel.
>> - * So add a wild amount of padding here to ensure that they fall into separate
>> + * Add a wild amount of padding here to ensure datas fall into separate
>>   * cachelines.  There are very few zone structures in the machine, so space
>>   * consumption is not a concern here.
>>   */
>>
>> Thanks!
>> Alex
> 
> I would maybe tweak it to make sure it is clear that we are using this
> to pad out items that are likely to cause cache thrash such as various
> hot spinocks and such.
> 

I appreciate if you like to change the doc better. :)

Thanks
Alex
