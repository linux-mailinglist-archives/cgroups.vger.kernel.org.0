Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EB322572D
	for <lists+cgroups@lfdr.de>; Mon, 20 Jul 2020 07:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgGTFrS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jul 2020 01:47:18 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:44673 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgGTFrS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jul 2020 01:47:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U3BbMp-_1595224030;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U3BbMp-_1595224030)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Jul 2020 13:47:10 +0800
Subject: Re: [PATCH v16 18/22] mm/lru: replace pgdat lru_lock with lruvec lock
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
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Rong Chen <rong.a.chen@intel.com>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-19-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0Ud+Dj-Q8Sxv8eDQhjM3fFHwnU_ZFEVG54debBennUmxAg@mail.gmail.com>
 <62dfd262-a7ac-d18e-216a-2988c690b256@linux.alibaba.com>
 <c339f46e-ae04-4e65-2713-a5c8be56051a@linux.alibaba.com>
 <CAKgT0UestD7cU+3aqg3a9JT4bTXVYQpjGbwoC2-bOBHPY5xn6A@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <27eb389d-b5f9-fe03-2e57-15c351629efc@linux.alibaba.com>
Date:   Mon, 20 Jul 2020 13:47:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UestD7cU+3aqg3a9JT4bTXVYQpjGbwoC2-bOBHPY5xn6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/19 下午11:14, Alexander Duyck 写道:
>> Compare to move to tail, how about to move it to head of struct, which is
>> close to lru list? Did you have some data of the place change?
> I don't have specific data, just anecdotal evidence from the past that
> usually you want to keep locks away from read-mostly items since they
> cause obvious cache thrash. My concern was more with the other fields
> in the structure such as pgdat since it should be a static value and
> having it evicted would likely be more expensive than just leaving the
> cacheline as it is.
> 

Thanks for comments, Alex.

So, sounds like moving the lru_lock to head of struct lruvec could be better.

>> -       __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
>> +       if (delta_munlocked)
>> +               __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
>>         if (lruvec)
>>                 unlock_page_lruvec_irq(lruvec);
> Why not just wrap the entire thing in a check for "lruvec"? Yes you
> could theoretically be modding with a value of 0, but it avoids a
> secondary unnecessary check and branching.

Right, and the delta_munlocked value could be checked inside the accounting
func

Thanks!
