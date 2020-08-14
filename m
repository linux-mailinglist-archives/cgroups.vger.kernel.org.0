Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A742445C7
	for <lists+cgroups@lfdr.de>; Fri, 14 Aug 2020 09:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgHNHUy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Aug 2020 03:20:54 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:53701 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbgHNHUx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Aug 2020 03:20:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U5ih6Du_1597389645;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U5ih6Du_1597389645)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Aug 2020 15:20:47 +0800
Subject: Re: [RFC PATCH 3/3] mm: Identify compound pages sooner in
 isolate_migratepages_block
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     yang.shi@linux.alibaba.com, lkp@intel.com, rong.a.chen@intel.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name, hughd@google.com,
        linux-kernel@vger.kernel.org, daniel.m.jordan@oracle.com,
        linux-mm@kvack.org, shakeelb@google.com, willy@infradead.org,
        hannes@cmpxchg.org, tj@kernel.org, cgroups@vger.kernel.org,
        akpm@linux-foundation.org, richard.weiyang@gmail.com,
        mgorman@techsingularity.net, iamjoonsoo.kim@lge.com
References: <20200813035100.13054.25671.stgit@localhost.localdomain>
 <20200813040240.13054.76770.stgit@localhost.localdomain>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <76f64f08-e2c7-9862-5e7f-6251032735f0@linux.alibaba.com>
Date:   Fri, 14 Aug 2020 15:20:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200813040240.13054.76770.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It has a slight performance drop too...

Thanks
Alex

在 2020/8/13 下午12:02, Alexander Duyck 写道:
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  mm/compaction.c |   33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
