Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECED241827
	for <lists+cgroups@lfdr.de>; Tue, 11 Aug 2020 10:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgHKIXE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Aug 2020 04:23:04 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:50623 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbgHKIXE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Aug 2020 04:23:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U5S3WRW_1597134176;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U5S3WRW_1597134176)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 Aug 2020 16:22:57 +0800
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
 <241ca157-104f-4f0d-7d5b-de394443788d@linux.alibaba.com>
 <CAKgT0UdSrarC8j+G=LYRSadcaG6yNCoCfeVpFjEiHRJb4A77-g@mail.gmail.com>
 <8dbd004e-8eba-f1ec-a5eb-5dc551978936@linux.alibaba.com>
 <CAKgT0UdK-fy+yYGLFK=YgE+maa_0_uecq0_8S_0kM8BiVgRO7g@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <d9818e06-95f1-9f21-05c0-98f29ea96d89@linux.alibaba.com>
Date:   Tue, 11 Aug 2020 16:22:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdK-fy+yYGLFK=YgE+maa_0_uecq0_8S_0kM8BiVgRO7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/10 下午10:41, Alexander Duyck 写道:
> On Mon, Aug 10, 2020 at 6:10 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>
>>
>>
>> 在 2020/8/7 下午10:51, Alexander Duyck 写道:
>>> I wonder if this entire section shouldn't be restructured. This is the
>>> only spot I can see where we are resetting the LRU flag instead of
>>> pulling the page from the LRU list with the lock held. Looking over
>>> the code it seems like something like that should be possible. I am
>>> not sure the LRU lock is really protecting us in either the
>>> PageCompound check nor the skip bits. It seems like holding a
>>> reference on the page should prevent it from switching between
>>> compound or not, and the skip bits are per pageblock with the LRU bits
>>> being per node/memcg which I would think implies that we could have
>>> multiple LRU locks that could apply to a single skip bit.
>>
>> Hi Alexander,
>>
>> I don't find problem yet on compound or skip bit usage. Would you clarify the
>> issue do you concerned?
>>
>> Thanks!
> 
> The point I was getting at is that the LRU lock is being used to
> protect these and with your changes I don't think that makes sense
> anymore.
> 
> The skip bits are per-pageblock bits. With your change the LRU lock is
> now per memcg first and then per node. As such I do not believe it
> really provides any sort of exclusive access to the skip bits. I still
> have to look into this more, but it seems like you need a lock per
> either section or zone that can be used to protect those bits and deal
> with this sooner rather than waiting until you have found an LRU page.
> The one part that is confusing though is that the definition of the
> skip bits seems to call out that they are a hint since they are not
> protected by a lock, but that is exactly what has been happening here.
> 

The skip bits are safe here, since even it race with other skip action,
It will still skip out. The skip action is try not to compaction too much,
not a exclusive action needs avoid race.


> The point I was getting at with the PageCompound check is that instead
> of needing the LRU lock you should be able to look at PageCompound as
> soon as you call get_page_unless_zero() and preempt the need to set
> the LRU bit again. Instead of trying to rely on the LRU lock to
> guarantee that the page hasn't been merged you could just rely on the
> fact that you are holding a reference to it so it isn't going to
> switch between being compound or order 0 since it cannot be freed. It
> spoils the idea I originally had of combining the logic for
> get_page_unless_zero and TestClearPageLRU into a single function, but
> the advantage is you aren't clearing the LRU flag unless you are
> actually going to pull the page from the LRU list.

Sorry, I still can not follow you here. Compound code part is unchanged
and follow the original logical. So would you like to pose a new code to
see if its works?

Thanks
Alex

> 
> My main worry is that this is the one spot where we appear to be
> clearing the LRU bit without ever actually pulling the page off of the
> LRU list, and I am thinking we would be better served by addressing
> the skip and PageCompound checks earlier rather than adding code to
> set the bit again if either of those cases are encountered. This way
> we don't pseudo-pin pages in the LRU if they are compound or supposed
> to be skipped.
> 
> Thanks.
> 
> - Alex
> 
