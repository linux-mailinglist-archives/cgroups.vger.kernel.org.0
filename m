Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15331406DCE
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 16:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhIJO4p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 10:56:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41358 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhIJO4m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Sep 2021 10:56:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1E3F51FE4B;
        Fri, 10 Sep 2021 14:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631285730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+I/RKyAZdBWnkeMlKqYdgK786I94mbT861DCEwjnivU=;
        b=iGS3pLMze+lTPJhBlasZr9bVa4g7NW57UckT4cRZ55LS2Hw2TJduxe9gy2IZBOyMjE7ESl
        bh8JVvw24sutkXOH1Kx1aKew708anymj55P6qFBjGvEUhN1QfOOgTRuljZdEHgTXd7l6F1
        hzv3VW98ejTQsu6YOPPwP2cvjzEsJo4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BD22CA3B8A;
        Fri, 10 Sep 2021 14:55:29 +0000 (UTC)
Date:   Fri, 10 Sep 2021 16:55:26 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH memcg] memcg: prohibit unconditional exceeding the limit
 of dying tasks
Message-ID: <YTtx3toUOMLXk4GZ@dhcp22.suse.cz>
References: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
 <099aa0db-045a-e5b8-6df7-b7c3fc4d3caa@i-love.sakura.ne.jp>
 <4a407474-ff7a-9e4f-d314-ab85f0eeaadf@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a407474-ff7a-9e4f-d314-ab85f0eeaadf@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 10-09-21 16:20:58, Vasily Averin wrote:
> On 9/10/21 4:04 PM, Tetsuo Handa wrote:
> > On 2021/09/10 21:39, Vasily Averin wrote:
> >> The kernel currently allows dying tasks to exceed the memcg limits.
> >> The allocation is expected to be the last one and the occupied memory
> >> will be freed soon.
> >> This is not always true because it can be part of the huge vmalloc
> >> allocation. Allowed once, they will repeat over and over again.
> >> Moreover lifetime of the allocated object can differ from
> >> In addition the lifetime of the dying task.
> > 
> > Can't we add fatal_signal_pending(current) test to vmalloc() loop?

We can and we should.

> 1) this has been done in the past but has been reverted later.

The reason for that should be addressed IIRC.

> 2) any vmalloc changes will affect non-memcg allocations too.
>  If we're doing memcg-related checks it's better to do it in one place.

I think those two things are just orthogonal. Bailing out from vmalloc
early sounds reasonable to me on its own. Allocating a large thing that
is likely to go away with the allocating context is just a waste of
resources and potential reason to disruptions to others.

> 3) it is not vmalloc-only issue. Huge number of  kmalloc page allocations 
> from N concurrent threads will lead to the same problem. 

Agreed. I do not think it is viable to sprinkle fatal_signal_pending or
similar checks all over the code. This should better be limited to
allocators and the charging function.

Our assumption that is described in the code simply doesn't hold and it
is close to impossible to check all charging paths to bail out properly
so I think we should just remove that optimistic attitude and do not
force charges unless that is absolutely necessary (e.g. __GFP_NOFAIL) or
impractical (e.g. atomic allocations) and bound.

I didn't get to review the patch yet. This is a tricky area with many
unobvious corner cases. I will try find some time next week.

Thanks!
-- 
Michal Hocko
SUSE Labs
