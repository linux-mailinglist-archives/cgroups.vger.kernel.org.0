Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB9923B4F9
	for <lists+cgroups@lfdr.de>; Tue,  4 Aug 2020 08:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgHDGXl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Aug 2020 02:23:41 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:40956 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbgHDGXl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Aug 2020 02:23:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U4isUyX_1596522215;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4isUyX_1596522215)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Aug 2020 14:23:36 +0800
Subject: Re: [PATCH v17 19/21] mm/vmscan: use relock for move_pages_to_lru
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
 <1595681998-19193-20-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UebLfdju0Ny9ad5bigzAazqpzfwk2_JNQQ9yEHYyVm5-Q@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e6b142b6-8349-443d-5442-80d25d79eb57@linux.alibaba.com>
Date:   Tue, 4 Aug 2020 14:23:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UebLfdju0Ny9ad5bigzAazqpzfwk2_JNQQ9yEHYyVm5-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/4 上午6:49, Alexander Duyck 写道:
>> Cc: linux-mm@kvack.org
> I am assuming this is only separate from patch 18 because of the fact
> that it is from Hugh and not yourself. Otherwise I would recommend
> folding this into patch 18.

Yes, that's resaon for this patch keeps.

> 
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Thanks a lot!
Alex
