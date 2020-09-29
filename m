Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1451927D210
	for <lists+cgroups@lfdr.de>; Tue, 29 Sep 2020 17:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgI2PEs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Sep 2020 11:04:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:42590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgI2PEs (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 29 Sep 2020 11:04:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601391886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BK7zsoCScu7iUZFoKsqeYor8HokJPerHJKMNvd3iTAo=;
        b=X0bhDucboFOYukcc7cM6CgWPOH3Rf+ilMyYdAXP8JWtTcN2ymeRID9j68NiB2ZJGCZYx3Q
        JzA7ZzQI15e65/pR4F3BG/EaXJnQz2cgQn2cgbRgLLJcuu/PZMGU0b4exblOFvu+6XVT/Z
        4Xx9ee/8vd1rTiRrhHjAP7obubmgpL4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B4EAAD0F;
        Tue, 29 Sep 2020 15:04:46 +0000 (UTC)
Date:   Tue, 29 Sep 2020 17:04:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
Message-ID: <20200929150444.GG2277@dhcp22.suse.cz>
References: <20200909215752.1725525-1-shakeelb@google.com>
 <20200928210216.GA378894@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928210216.GA378894@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 28-09-20 17:02:16, Johannes Weiner wrote:
[...]
> My take is that a proactive reclaim feature, whose goal is never to
> thrash or punish but to keep the LRUs warm and the workingset trimmed,
> would ideally have:
> 
> - a pressure or size target specified by userspace but with
>   enforcement driven inside the kernel from the allocation path
> 
> - the enforcement work NOT be done synchronously by the workload
>   (something I'd argue we want for *all* memory limits)
> 
> - the enforcement work ACCOUNTED to the cgroup, though, since it's the
>   cgroup's memory allocations causing the work (again something I'd
>   argue we want in general)
> 
> - a delegatable knob that is independent of setting the maximum size
>   of a container, as that expresses a different type of policy
> 
> - if size target, self-limiting (ha) enforcement on a pressure
>   threshold or stop enforcement when the userspace component dies
> 
> Thoughts?

Agreed with above points. What do you think about
http://lkml.kernel.org/r/20200922190859.GH12990@dhcp22.suse.cz. I assume
that you do not want to override memory.high to implement this because
that tends to be tricky from the configuration POV as you mentioned
above. But a new limit (memory.middle for a lack of a better name) to
define the background reclaim sounds like a good fit with above points.

-- 
Michal Hocko
SUSE Labs
