Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DC1425111
	for <lists+cgroups@lfdr.de>; Thu,  7 Oct 2021 12:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhJGKbl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Oct 2021 06:31:41 -0400
Received: from outbound-smtp47.blacknight.com ([46.22.136.64]:51161 "EHLO
        outbound-smtp47.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240726AbhJGKbk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Oct 2021 06:31:40 -0400
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Oct 2021 06:31:40 EDT
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id B6001FB6ED
        for <cgroups@vger.kernel.org>; Thu,  7 Oct 2021 11:20:45 +0100 (IST)
Received: (qmail 10512 invoked from network); 7 Oct 2021 10:20:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Oct 2021 10:20:45 -0000
Date:   Thu, 7 Oct 2021 11:20:44 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@openvz.org, Mel Gorman <mgorman@suse.de>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: memcg memory accounting in vmalloc is broken
Message-ID: <20211007102044.GR3959@techsingularity.net>
References: <b3c232ff-d9dc-4304-629f-22cc95df1e2e@virtuozzo.com>
 <YV6sIz5UjfbhRyHN@dhcp22.suse.cz>
 <YV6s+ze8LzuxfvOM@dhcp22.suse.cz>
 <953ef8e2-1221-a12c-8f71-e34e477a52e8@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <953ef8e2-1221-a12c-8f71-e34e477a52e8@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 07, 2021 at 11:50:44AM +0300, Vasily Averin wrote:
> On 10/7/21 11:16 AM, Michal Hocko wrote:
> > Cc Mel and Uladzislau
> > 
> > On Thu 07-10-21 10:13:23, Michal Hocko wrote:
> >> On Thu 07-10-21 11:04:40, Vasily Averin wrote:
> >>> vmalloc was switched to __alloc_pages_bulk but it does not account the memory to memcg.
> >>>
> >>> Is it known issue perhaps?
> >>
> >> No, I think this was just overlooked. Definitely doesn't look
> >> intentional to me.
> 
> I use following patch as a quick fix,
> it helps though it is far from ideal and can be optimized.

Thanks Vasily.

This papers over the problem but it could certainly be optimized. At
minimum;

1. Test (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT)) in the
   function preamble and store the result in a bool
2. Avoid the temptation to batch the accounting because if the
   accounting fails, there is no information on how many pages could be
   allocated before the limits were hit. I guess you could pre-charge the
   pages and uncharging the number of pages that failed to be allocated
   but it should be a separate patch.
3. If an allocation fails due to memcg accounting, break
   out of the loop because all remaining bulk allocations are
   also likely to fail.

As it's not vmalloc's fault, I would suggest the patch
have
Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
and
Cc: <stable@vger.kernel.org>

Note the Cc should just be in the patch and not mailed directly to
stable@ as it'll simply trigger a form letter about the patch having to
be merged to mainline first.

-- 
Mel Gorman
SUSE Labs
