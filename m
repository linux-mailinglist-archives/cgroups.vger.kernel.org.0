Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7F2FFD29
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2019 03:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfKRCpN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 17 Nov 2019 21:45:13 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:7130 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbfKRCpM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 17 Nov 2019 21:45:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0TiMbn5R_1574045097;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TiMbn5R_1574045097)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 18 Nov 2019 10:44:58 +0800
Subject: Re: [PATCH v3 1/7] mm/lru: add per lruvec lock for memcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Arun KS <arunks@codeaurora.org>
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573874106-23802-2-git-send-email-alex.shi@linux.alibaba.com>
 <CALvZod77568+TozRXpERDDap__jbj+oJBY8zD=UBd40XNJC2zg@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e707fd66-16c2-8523-dd8b-860b5b6bb11d@linux.alibaba.com>
Date:   Mon, 18 Nov 2019 10:44:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CALvZod77568+TozRXpERDDap__jbj+oJBY8zD=UBd40XNJC2zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2019/11/16 下午2:28, Shakeel Butt 写道:
> On Fri, Nov 15, 2019 at 7:15 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>
>> Currently memcg still use per node pgdat->lru_lock to guard its lruvec.
>> That causes some lru_lock contention in a high container density system.
>>
>> If we can use per lruvec lock, that could relief much of the lru_lock
>> contention.
>>
>> The later patches will replace the pgdat->lru_lock with lruvec->lru_lock
>> and show the performance benefit by benchmarks.
> 
> Merge this patch with actual usage. No need to have a separate patch.

Thanks for comment, Shakeel!

Yes, but considering the 3rd, huge and un-splitable patch of actully replacing, I'd rather to pull sth out from 
it. Ty to make patches a bit more readable, Do you think so?

Thanks
Alex
