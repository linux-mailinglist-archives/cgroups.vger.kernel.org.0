Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22811B226E
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 11:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgDUJNX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 05:13:23 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:52067 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgDUJNX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 05:13:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TwDfDaE_1587460397;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TwDfDaE_1587460397)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Apr 2020 17:13:18 +0800
Subject: Re: [PATCH 05/18] mm: memcontrol: convert page cache to a new
 mem_cgroup_charge() API
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
 <20200420221126.341272-6-hannes@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e3d70030-a9ae-a679-9cf9-1cd5b680650e@linux.alibaba.com>
Date:   Tue, 21 Apr 2020 17:12:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420221126.341272-6-hannes@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/4/21 ÉÏÎç6:11, Johannes Weiner Ð´µÀ:
> The try/commit/cancel protocol that memcg uses dates back to when
> pages used to be uncharged upon removal from the page cache, and thus
> couldn't be committed before the insertion had succeeded. Nowadays,
> pages are uncharged when they are physically freed; it doesn't matter
> whether the insertion was successful or not. For the page cache, the
> transaction dance has become unnecessary.
> 
> Introduce a mem_cgroup_charge() function that simply charges a newly
> allocated page to a cgroup and sets up page->mem_cgroup in one single
> step. If the insertion fails, the caller doesn't have to do anything
> but free/put the page.
> 
> Then switch the page cache over to this new API.
> 
> Subsequent patches will also convert anon pages, but it needs a bit
> more prep work. Right now, memcg depends on page->mapping being
> already set up at the time of charging, so that it can maintain its
> own MEMCG_CACHE and MEMCG_RSS counters. For anon, page->mapping is set
> under the same pte lock under which the page is publishd, so a single
> charge point that can block doesn't work there just yet.
> 
> The following prep patches will replace the private memcg counters
> with the generic vmstat counters, thus removing the page->mapping
> dependency, then complete the transition to the new single-point
> charge API and delete the old transactional scheme.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
