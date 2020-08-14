Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737162445D0
	for <lists+cgroups@lfdr.de>; Fri, 14 Aug 2020 09:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgHNHZ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Aug 2020 03:25:59 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:45953 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbgHNHZ7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Aug 2020 03:25:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U5j8GEh_1597389951;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U5j8GEh_1597389951)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Aug 2020 15:25:53 +0800
Subject: Re: [RFC PATCH 1/3] mm: Drop locked from isolate_migratepages_block
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
References: <20200813035100.13054.25671.stgit@localhost.localdomain>
 <20200813040224.13054.96724.stgit@localhost.localdomain>
 <8ea9e186-b223-fb1b-5c82-2aa43c5e9f10@linux.alibaba.com>
 <CAKgT0UcRFqXUOJ+QjgtjdQE6A7EMgAc_v9b7+mXy-ZJLvG2AgQ@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <d56ee23c-3c79-33e4-6702-a7d586acb0ac@linux.alibaba.com>
Date:   Fri, 14 Aug 2020 15:25:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcRFqXUOJ+QjgtjdQE6A7EMgAc_v9b7+mXy-ZJLvG2AgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/13 下午10:32, Alexander Duyck 写道:
>> Thanks a lot!
>> Don't know if community is ok if we keep the patch following whole patchset alone?
> I am fine with you squashing it with another patch if you want. In
> theory this could probably be squashed in with the earlier patch I
> submitted that introduced lruvec_holds_page_lru_lock or some other
> patch. It is mostly just a cleanup anyway as it gets us away from
> needing to hold the RCU read lock in the case that we already have the
> correct lruvec.

Hi Alexander,

Thanks a lot! look like it's better to fold it in patch 17.

Alex
