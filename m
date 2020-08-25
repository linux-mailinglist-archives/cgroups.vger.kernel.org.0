Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A505B25131F
	for <lists+cgroups@lfdr.de>; Tue, 25 Aug 2020 09:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgHYHZl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Aug 2020 03:25:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:55654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbgHYHZk (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 25 Aug 2020 03:25:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92205AC24;
        Tue, 25 Aug 2020 07:26:09 +0000 (UTC)
Date:   Tue, 25 Aug 2020 09:25:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nao.horiguchi@gmail.com,
        osalvador@suse.de, mike.kravetz@oracle.com
Subject: Re: [Resend PATCH 1/6] mm/memcg: warning on !memcg after readahead
 page charged
Message-ID: <20200825072538.GB22869@dhcp22.suse.cz>
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200820145850.GA4622@lca.pw>
 <20200821080127.GD32537@dhcp22.suse.cz>
 <20200821123934.GA4314@lca.pw>
 <20200821134842.GF32537@dhcp22.suse.cz>
 <20200824151013.GB3415@dhcp22.suse.cz>
 <12425e06-38ce-7ff4-28ce-b0418353fc67@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12425e06-38ce-7ff4-28ce-b0418353fc67@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 25-08-20 09:25:01, Alex Shi wrote:
> reproduce using our linux-mm random bug collection on NUMA systems.
> >>
> >> OK, I must have missed that this was on ppc. The order makes more sense
> >> now. I will have a look at this next week.
> > 
> > OK, so I've had a look and I know what's going on there. The
> > move_pages12 is migrating hugetlb pages. Those are not charged to any
> > memcg. We have completely missed this case. There are two ways going
> > around that. Drop the warning and update the comment so that we do not
> > forget about that or special case hugetlb pages.
> > 
> > I think the first option is better.
> > 
> 
> 
> Hi Michal,
> 
> Compare to ignore the warning which is designed to give, seems addressing
> the hugetlb out of charge issue is a better solution, otherwise the memcg
> memory usage is out of control on hugetlb, is that right?

Hugetlb memory is out of memcg scope deliberately. This is not a
reclaimable memory and something that can easily get out of control. The
memory is preallocated and overcommit is strictly controlled as well. We
have a dedicated hugetlb cgroup controller to offer a better control of
the preallocated pool distribution.

Anyway this just shows that there are more subtle cases where a page
with no memcg can hit some common paths so the patch is clearly not
ready.

I should have realized that when giving my ack but same as you I got
misled by the existing comment.
-- 
Michal Hocko
SUSE Labs
