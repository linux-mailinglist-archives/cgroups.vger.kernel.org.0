Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DFF214706
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 17:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgGDPry (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 4 Jul 2020 11:47:54 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:47953 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbgGDPry (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 4 Jul 2020 11:47:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U1ffIy7_1593877655;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U1ffIy7_1593877655)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 04 Jul 2020 23:47:36 +0800
Subject: Re: [PATCH v14 15/20] mm/swap: serialize memcg changes during
 pagevec_lru_move_fn
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0KXQu9C10LHQvdC40LrQvtCy?= 
        <khlebnikov@yandex-team.ru>, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, Johannes Weiner <hannes@cmpxchg.org>,
        lkp@intel.com, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, shakeelb@google.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, richard.weiyang@gmail.com
References: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
 <1593752873-4493-16-git-send-email-alex.shi@linux.alibaba.com>
 <CALYGNiOkA_ZsycF_hqm3XLk55Ek1Mo9w1gO=6EeE35fUtA0i_w@mail.gmail.com>
 <56e395c6-81e7-7163-0d4f-42b91573289f@linux.alibaba.com>
 <20200704113944.GN25523@casper.infradead.org>
 <b6caf0d7-266e-55ea-0c88-656c800af1e3@linux.alibaba.com>
 <20200704133330.GP25523@casper.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <4a42888e-4d7e-0d76-358c-9a073e6e4794@linux.alibaba.com>
Date:   Sat, 4 Jul 2020 23:47:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200704133330.GP25523@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/4 下午9:33, Matthew Wilcox 写道:
> On Sat, Jul 04, 2020 at 09:12:46PM +0800, Alex Shi wrote:
>> 在 2020/7/4 下午7:39, Matthew Wilcox 写道:
>>> On Sat, Jul 04, 2020 at 07:34:59PM +0800, Alex Shi wrote:
>>>> That's a great idea! Guess what the new struct we need would be like this?
>>>> I like to try this. :)
>>>>
>>>>
>>>> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
>>>> index 081d934eda64..d62778c8c184 100644
>>>> --- a/include/linux/pagevec.h
>>>> +++ b/include/linux/pagevec.h
>>>> @@ -20,7 +20,7 @@
>>>>  struct pagevec {
>>>>         unsigned char nr;
>>>>         bool percpu_pvec_drained;
>>>> -       struct page *pages[PAGEVEC_SIZE];
>>>> +       struct list_head veclist;
>>>>  };
>>>
>>> pagevecs are used not just for LRU.  If you want to use a list_head for
>>> LRU then define a new structure.
>>
>> yes, there are much page don't use page->lru, like slab etc. we need a new struct> 
> That's not what I mean.  Slab pages aren't on the LRU anyway.

Right. I mean, that's reason for a new struct if we change to list.

> 
> Consider the callers of page_cache_delete_batch().  These use a pagevec
> for a non-LRU purpose, and they will be much slower with a list_head than
> with an array.
> 

Thanks for the info.
If the list is slower than pagevec, maybe it's not worth to do the change.
Since pagevec could handle any kind of pages, anon/file, non-active/active, but one
list only fit for just one kind of list. 5 kinds of list adding would increase the
complexity. Consider this, I am wondering if it's worth?

Thanks
Alex
