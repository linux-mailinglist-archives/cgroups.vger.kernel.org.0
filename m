Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B5D43B39B
	for <lists+cgroups@lfdr.de>; Tue, 26 Oct 2021 16:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhJZOKI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Oct 2021 10:10:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34714 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhJZOKI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Oct 2021 10:10:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 50F5C1F770;
        Tue, 26 Oct 2021 14:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635257263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sW8fX/bIkRavS2IM2SW67s4/k2HA13rrU7KuzOI/OYA=;
        b=XLQpg2KAcIM7gQTqzvrzY5Igd4UdGIws6JdRiIfbJQ8F1ubXcXk+95Wocng0fDJL/i/Ivg
        +OQ//LuLM9kDN56S0F6gBVNZDMP9o95FO5Zp3iFWP01ds7iy0/TOwJlitIe5kfi10yAwSG
        408Z8qmYPv7D5KNsFCV4RRii8RLmGfk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C6A66A3B85;
        Tue, 26 Oct 2021 14:07:41 +0000 (UTC)
Date:   Tue, 26 Oct 2021 16:07:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Vasily Averin <vvs@virtuozzo.com>, Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH memcg v3 2/3] mm, oom: do not trigger out_of_memory from
 the #PF
Message-ID: <YXgLrQwC/gKZAusv@dhcp22.suse.cz>
References: <YXJ/63kIpTq8AOlD@dhcp22.suse.cz>
 <cover.1634994605.git.vvs@virtuozzo.com>
 <f5fd8dd8-0ad4-c524-5f65-920b01972a42@virtuozzo.com>
 <e2a847a2-a414-2535-e3d1-b100a023b9d1@i-love.sakura.ne.jp>
 <YXZk9Lr217e+saSM@dhcp22.suse.cz>
 <62a326bc-37d2-b8c9-ddbf-7adaeaadf341@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62a326bc-37d2-b8c9-ddbf-7adaeaadf341@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 26-10-21 22:56:44, Tetsuo Handa wrote:
> On 2021/10/25 17:04, Michal Hocko wrote:
> > I do not think there is any guarantee. This code has meant to be a
> > safeguard but it turns out to be adding more harm than a safety. There
> > are several scenarios mentioned in this thread where this would be
> > counter productive or outright wrong thing to do.
> 
> Setting PR_IO_FLUSHER via prctl(PR_SET_IO_FLUSHER) + hitting legacy kmem
> charge limit might be an unexpected combination?

I am not sure I follow or why PR_SET_IO_FLUSHER should be relevant. But
triggering the global OOM killer on kmem charge limit failure is
certainly not the right thing to do. Quite opposite because this would
be effectivelly a global DoS as a result of a local memory constrain.
 
> > On the other hand it is hard to imagine any legitimate situation where
> > this would be a right thing to do. Maybe you have something more
> > specific in mind? What would be the legit code to rely on OOM handling
> > out of the line (where the details about the allocation scope is lost)?
> 
> I don't have specific scenario, but I feel that it might be a chance to
> retry killable vmalloc(). Commit b8c8a338f75e ("Revert "vmalloc: back off
> when the current task is killed"") was 4.5 years ago, and fuzz testing found
> many bugs triggered by memory allocation fault injection. Thus, I think that
> the direction is going towards "we can fail memory allocation upon SIGKILL
> (rather than worrying about depleting memory reserves and/or escalating to
> global OOM killer invocations)". Most memory allocation requests which
> allocate memory for userspace process are willing to give up upon SIGKILL.
> 
> Like you are trying to add NOFS, NOIO, NOFAIL support to vmalloc(), you could
> consider KILLABLE support as well. Of course, direct reclaim makes it difficult
> to immediately give up upon SIGKILL, but killable allocation sounds still nice
> even if best-effort basis.

This is all fine but I am not sure how this is realated to this patch.
The previous patch already gives up in pagefault_out_of_memory on fatal
signal pending. So this code is not really reachable.

Also alowing more allocations to fail doesn't really suggest that we
should trigger OOM killer from #PF. I would argue that the opposite is
the case actually. Or I just haven't understood your concern?
-- 
Michal Hocko
SUSE Labs
