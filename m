Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757671B2291
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 11:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgDUJWh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 05:22:37 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:47543 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgDUJWg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 05:22:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TwDn81a_1587460953;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TwDn81a_1587460953)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Apr 2020 17:22:34 +0800
Subject: Re: [PATCH 16/18] mm: memcontrol: charge swapin pages on
 instantiation
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <js1304@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-17-hannes@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <6f03ed4e-f917-2ccc-26c0-c438c84d3d97@linux.alibaba.com>
Date:   Tue, 21 Apr 2020 17:21:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420221126.341272-17-hannes@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/4/21 ÉÏÎç6:11, Johannes Weiner Ð´µÀ:
> Right now, users that are otherwise memory controlled can easily
> escape their containment and allocate significant amounts of memory
> that they're not being charged for. That's because swap readahead
> pages are not being charged until somebody actually faults them into
> their page table. This can be exploited with MADV_WILLNEED, which
> triggers arbitrary readahead allocations without charging the pages.
> 
> There are additional problems with the delayed charging of swap pages:
> 
> 1. To implement refault/workingset detection for anonymous pages, we
>    need to have a target LRU available at swapin time, but the LRU is
>    not determinable until the page has been charged.
> 
> 2. To implement per-cgroup LRU locking, we need page->mem_cgroup to be
>    stable when the page is isolated from the LRU; otherwise, the locks
>    change under us. But swapcache gets charged after it's already on
>    the LRU, and even if we cannot isolate it ourselves (since charging
>    is not exactly optional).
> 
> The previous patch ensured we always maintain cgroup ownership records
> for swap pages. This patch moves the swapcache charging point from the
> fault handler to swapin time to fix all of the above problems.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
