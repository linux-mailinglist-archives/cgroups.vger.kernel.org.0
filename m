Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D1C272C52
	for <lists+cgroups@lfdr.de>; Mon, 21 Sep 2020 18:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgIUQa6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Sep 2020 12:30:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:34290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbgIUQa6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 21 Sep 2020 12:30:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600705856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eU/CicWZpDdvdLu+VtNr7opHyCa0NGxGdgD8aIFSXMo=;
        b=PRpdvcHC33L60xFXcwyptnBlBYfsLtFzPSGiGsPkOOg0QwjORmuBW1r+0xNQxQX+J7PxwN
        41gAQ7J1b9nYGpiItpdXHj0D4qTPMtpBR3oMwVjI7EnW5ZPEw6R1FEh8rAbWGyABLPoYdZ
        62uPgYcmPx2Djiz/xHMjr09Y+sYM5Qo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDC24AC65;
        Mon, 21 Sep 2020 16:31:32 +0000 (UTC)
Date:   Mon, 21 Sep 2020 18:30:55 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
Message-ID: <20200921163055.GQ12990@dhcp22.suse.cz>
References: <20200909215752.1725525-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909215752.1725525-1-shakeelb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 09-09-20 14:57:52, Shakeel Butt wrote:
> Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
> 
> Use cases:
> ----------
> 
> 1) Per-memcg uswapd:
> 
> Usually applications consists of combination of latency sensitive and
> latency tolerant tasks. For example, tasks serving user requests vs
> tasks doing data backup for a database application. At the moment the
> kernel does not differentiate between such tasks when the application
> hits the memcg limits. So, potentially a latency sensitive user facing
> task can get stuck in high reclaim and be throttled by the kernel.
> 
> Similarly there are cases of single process applications having two set
> of thread pools where threads from one pool have high scheduling
> priority and low latency requirement. One concrete example from our
> production is the VMM which have high priority low latency thread pool
> for the VCPUs while separate thread pool for stats reporting, I/O
> emulation, health checks and other managerial operations. The kernel
> memory reclaim does not differentiate between VCPU thread or a
> non-latency sensitive thread and a VCPU thread can get stuck in high
> reclaim.

As those are presumably in the same cgroup what does prevent them to get
stuck behind shared resources with taken during the reclaim performed by
somebody else? I mean, memory reclaim might drop memory used by the high
priority task. Or they might simply stumble over same locks.

I am also more interested in actual numbers here. The high limit reclaim
is normally swift and should be mostly unnoticeable. If the reclaim gets
more expensive then it can get really noticeable for sure. But for the
later the same can happen with the external pro-activee reclaimer as
well, right? So there is no real "guarantee". Do you have any numbers
from your workloads where you can demonstrate that the external reclaim
has saved you this amount of effective cpu time of the sensitive
workload? (Essentially measure how much time it has to consume in the
high limit reclaim)

To the feature itself, I am not yet convinced we want to have a feature
like that. It surely sounds easy to use and attractive for a better user
space control. It is also much well defined than drop_caches/force_empty
because it is not all or nothing. But it also sounds like something too
easy to use incorrectly (remember drop_caches). I am also a bit worried
about corner cases wich would be easier to hit - e.g. fill up the swap
limit and turn anonymous memory into unreclaimable and who knows what
else.
-- 
Michal Hocko
SUSE Labs
