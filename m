Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B361D3DB3C4
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 08:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbhG3Goj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jul 2021 02:44:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41386 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbhG3Goj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Jul 2021 02:44:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3DB0F1FDB2;
        Fri, 30 Jul 2021 06:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627627474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mi1HYsWpUJ4quInI70i8clFEb3QGaTP2cyfGUhAVlYg=;
        b=QZac1o24u01b6AgmLK3Z0+E0zMc4ZqY4IyVVXaXxctxAv00rJsz5IuS5BFlXoC+VYRlBGS
        zzqVQeD7TgrhHa9bFg3NEGMvyMvwrwKz87Izv/ltThmf5cUZYq9CpmqrBKO3fyKsJWaDam
        pLTUGlKfs0yq3HNIhQLIOGfvmfv+i+M=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DE133A3B8B;
        Fri, 30 Jul 2021 06:44:33 +0000 (UTC)
Date:   Fri, 30 Jul 2021 08:44:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        shakeelb@google.com, willy@infradead.org, alexs@kernel.org,
        richard.weiyang@gmail.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 4/5] mm, memcg: avoid possible NULL pointer dereferencing
 in mem_cgroup_init()
Message-ID: <YQOf0TKOXpGRQFHF@dhcp22.suse.cz>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-5-linmiaohe@huawei.com>
 <YQNuK+jN7pZLJTvT@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQNuK+jN7pZLJTvT@carbon.lan>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 29-07-21 20:12:43, Roman Gushchin wrote:
> On Thu, Jul 29, 2021 at 08:57:54PM +0800, Miaohe Lin wrote:
> > rtpn might be NULL in very rare case. We have better to check it before
> > dereferencing it. Since memcg can live with NULL rb_tree_per_node in
> > soft_limit_tree, warn this case and continue.
> > 
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >  mm/memcontrol.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 5b4592d1e0f2..70a32174e7c4 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -7109,6 +7109,8 @@ static int __init mem_cgroup_init(void)
> >  		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL,
> >  				    node_online(node) ? node : NUMA_NO_NODE);
> >  
> > +		if (WARN_ON_ONCE(!rtpn))
> > +			continue;
> 
> I also really doubt that it makes any sense to continue in this case.
> If this allocations fails (at the very beginning of the system's life, it's an __init function),
> something is terribly wrong and panic'ing on a NULL-pointer dereference sounds like
> a perfect choice.

Moreover this is 24B allocation during early boot. Kernel will OOM and
panic when not being able to find any victim. I do not think we need to
do any special handling here.
-- 
Michal Hocko
SUSE Labs
