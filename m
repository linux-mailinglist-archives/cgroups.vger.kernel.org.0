Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037AC24BA72
	for <lists+cgroups@lfdr.de>; Thu, 20 Aug 2020 14:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgHTMIY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Aug 2020 08:08:24 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36079 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729885AbgHTJ57 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Aug 2020 05:57:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U6IpR5A_1597917472;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6IpR5A_1597917472)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 20 Aug 2020 17:57:54 +0800
Subject: Re: [RFC PATCH v2 5/5] mm: Split move_pages_to_lru into 3 separate
 passes
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        kbuild test robot <lkp@intel.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200819041852.23414.95939.stgit@localhost.localdomain>
 <20200819042738.23414.60815.stgit@localhost.localdomain>
 <084c58a7-7aac-820c-9606-19391c35b9b5@linux.alibaba.com>
 <CAKgT0Ud3CZ8KHLXCrWNGJAX85x23-EWLnAV63-NMmJ+5vD1JAA@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <87ded438-e908-117d-ecfb-1af7224d46da@linux.alibaba.com>
Date:   Thu, 20 Aug 2020 17:56:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ud3CZ8KHLXCrWNGJAX85x23-EWLnAV63-NMmJ+5vD1JAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/19 下午10:42, Alexander Duyck 写道:
>> It's actually changed the meaning from current func. which I had seen a bug if no relock.
>> but after move to 5.9 kernel, I can not reprodce the bug any more. I am not sure if 5.9 fixed
>> the problem, and we don't need relock here.
> So I am not sure what you mean here about "changed the meaning from
> the current func". Which function are you referring to and what
> changed?
> 
> From what I can tell the pages cannot change memcg because they were
> isolated and had the LRU flag stripped. They shouldn't be able to
> change destination LRU vector as a result. Assuming that, then they
> can all be processed under same LRU lock and we can avoid having to
> release it until we are forced to do so to call putback_lru_page or
> destroy the compound pages that were freed while we were shrinking the
> LRU lists.
> 

I had sent a bug which base on 5.8 kernel.
https://lkml.org/lkml/2020/7/28/465

I am not sure it was fixed in new kernel. The original line was introduced by Hugh Dickins
I believe it would be great if you can get comments from him.

Thanks
Alex
