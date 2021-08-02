Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26903DD41B
	for <lists+cgroups@lfdr.de>; Mon,  2 Aug 2021 12:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhHBKmw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Aug 2021 06:42:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57124 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbhHBKmw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Aug 2021 06:42:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 497A821ED8;
        Mon,  2 Aug 2021 10:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627900962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VjdOHRLy4OhFB/nI1Wg/RzSMrcrEU18YM9TrBL5loyk=;
        b=uXnGYFv+I4AyENCnJs+dpJ3e4RdX5jc6mcG8FDSMNdW/wQTEBxVUxaa1TSn2wMGP704vHN
        zTPIhA4mbq3bXmdtbT3kBDE1E1OQpI1WpF7auNV5Cc2yXdBvJekxBhuL3lgFSlxZPQKyKk
        bW2lha1tGQe28RcD4/okxagmJjVzAjQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BC0AFA3BAE;
        Mon,  2 Aug 2021 10:42:41 +0000 (UTC)
Date:   Mon, 2 Aug 2021 12:42:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Roman Gushchin <guro@fb.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        shakeelb@google.com, willy@infradead.org, alexs@kernel.org,
        richard.weiyang@gmail.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 4/5] mm, memcg: avoid possible NULL pointer dereferencing
 in mem_cgroup_init()
Message-ID: <YQfMISKHetFOm1Kx@dhcp22.suse.cz>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-5-linmiaohe@huawei.com>
 <YQNuK+jN7pZLJTvT@carbon.lan>
 <YQOf0TKOXpGRQFHF@dhcp22.suse.cz>
 <f7a22702-cd08-6b15-48c7-68523c38060b@huawei.com>
 <YQeUATTCVMd1D7Ra@dhcp22.suse.cz>
 <47daf062-f510-edb3-6ec7-f8e7615ad8a0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47daf062-f510-edb3-6ec7-f8e7615ad8a0@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 02-08-21 18:00:10, Miaohe Lin wrote:
> On 2021/8/2 14:43, Michal Hocko wrote:
> > On Sat 31-07-21 10:05:51, Miaohe Lin wrote:
> >> On 2021/7/30 14:44, Michal Hocko wrote:
> >>> On Thu 29-07-21 20:12:43, Roman Gushchin wrote:
> >>>> On Thu, Jul 29, 2021 at 08:57:54PM +0800, Miaohe Lin wrote:
> >>>>> rtpn might be NULL in very rare case. We have better to check it before
> >>>>> dereferencing it. Since memcg can live with NULL rb_tree_per_node in
> >>>>> soft_limit_tree, warn this case and continue.
> >>>>>
> >>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >>>>> ---
> >>>>>  mm/memcontrol.c | 2 ++
> >>>>>  1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >>>>> index 5b4592d1e0f2..70a32174e7c4 100644
> >>>>> --- a/mm/memcontrol.c
> >>>>> +++ b/mm/memcontrol.c
> >>>>> @@ -7109,6 +7109,8 @@ static int __init mem_cgroup_init(void)
> >>>>>  		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL,
> >>>>>  				    node_online(node) ? node : NUMA_NO_NODE);
> >>>>>  
> >>>>> +		if (WARN_ON_ONCE(!rtpn))
> >>>>> +			continue;
> >>>>
> >>>> I also really doubt that it makes any sense to continue in this case.
> >>>> If this allocations fails (at the very beginning of the system's life, it's an __init function),
> >>>> something is terribly wrong and panic'ing on a NULL-pointer dereference sounds like
> >>>> a perfect choice.
> >>>
> >>> Moreover this is 24B allocation during early boot. Kernel will OOM and
> >>> panic when not being able to find any victim. I do not think we need to
> >>
> >> Agree with you. But IMO it may not be a good idea to leave the rtpn without NULL check. We should defend
> >> it though it could hardly happen. But I'm not insist on this check. I will drop this patch if you insist.
> > 
> > It is not that I would insist. I just do not see any point in the code
> > churn. This check is not going to ever trigger and there is nothing you
> > can do to recover anyway so crashing the kernel is likely the only
> > choice left.
> > 
> 
> I hope I get the point now. What you mean is nothing we can do to recover and panic'ing on a
> NULL-pointer dereference is a perfect choice ? Should we declare that we leave the rtpn without
> NULL check on purpose like below ?
> 
> Many thanks.
> 
> @@ -7109,8 +7109,12 @@ static int __init mem_cgroup_init(void)
>                 rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL,
>                                     node_online(node) ? node : NUMA_NO_NODE);
> 
> -               if (WARN_ON_ONCE(!rtpn))
> -                       continue;
> +               /*
> +                * If this allocation fails (at the very beginning of the
> +                * system's life, it's an __init function), something is
> +                * terribly wrong and panic'ing on a NULL-pointer
> +                * dereference sounds like a perfect choice.
> +                */

I am not really sure this is really worth it. Really we do not really
want to have similar comments all over the early init code, do we?

>                 rtpn->rb_root = RB_ROOT;
>                 rtpn->rb_rightmost = NULL;
>                 spin_lock_init(&rtpn->lock);

-- 
Michal Hocko
SUSE Labs
