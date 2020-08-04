Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2029D23B4F7
	for <lists+cgroups@lfdr.de>; Tue,  4 Aug 2020 08:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgHDGWy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Aug 2020 02:22:54 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:65424 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbgHDGWy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Aug 2020 02:22:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U4j3PBv_1596522158;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4j3PBv_1596522158)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Aug 2020 14:22:39 +0800
Subject: Re: [PATCH v17 20/21] mm/pgdat: remove pgdat lru_lock
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
 <1595681998-19193-21-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UfZg5Wf2qNJ_=VPO1Cj8YuifZN8rG_X4Btq86ADmsVZFw@mail.gmail.com>
 <CAKgT0UciRJCPs_zrxri1pEJmJVKkHpEq=AFiVpJE99JJQe=Xrg@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e20ce97a-b713-f90d-e572-0aa54256bb42@linux.alibaba.com>
Date:   Tue, 4 Aug 2020 14:22:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UciRJCPs_zrxri1pEJmJVKkHpEq=AFiVpJE99JJQe=Xrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/4 上午6:45, Alexander Duyck 写道:
> Just to correct a typo, I meant patch 17, not 18. in the comment below.
> 
> 
> On Mon, Aug 3, 2020 at 3:42 PM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
>>
>> On Sat, Jul 25, 2020 at 6:00 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>>
>>> Now pgdat.lru_lock was replaced by lruvec lock. It's not used anymore.
>>>
>>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: cgroups@vger.kernel.org
>>
>> I really think this would be better just squashed into patch 18
>> instead of as a standalone patch since you were moving all of the
>> locking anyway so it would be more likely to trigger build errors if
>> somebody didn't move a lock somewhere that was referencing this.

Thanks for comments!
If someone changed the lru_lock between patch 17 and this, it would cause
more troubles then build error here. :) so don't warries for that.
But on the other side, I am so insist to have a ceremony to remove this lock...
  
>>
>> That said this change is harmless at this point.
>>
>> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Thanks a lot for review!
