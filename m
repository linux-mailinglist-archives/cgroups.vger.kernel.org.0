Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C67328BF75
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2019 19:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfHMRMk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Aug 2019 13:12:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43335 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfHMRMk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Aug 2019 13:12:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so562124pgb.10
        for <cgroups@vger.kernel.org>; Tue, 13 Aug 2019 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t4C71UdUds8mfeMVRJziN4Jin8vpYyBJxbMwjur/Fro=;
        b=E1iZdgGcDwOWZSz781OrghxIVDmdCFm/suaSubJzTX/RHIbSaauz/rqQaBTA0IIlsL
         ydLOykhXrF+BbCHfIKE5mcgxzUEXo+PkcOgawkYtiX3+3AN4lhBdptyVnBxbBpA5SQXJ
         GMaBMMmi0Aalp71NI78fm9cmBwwalj4xPOlkmfYte/mAgArodwEk1IQ2PMUv/ieeXbqD
         sHI2Xz5mXapGE7E2yjTie/8Ppgw6QPrH6kJ/xwPFrT1AJpfKQfkFoti660ZyDwnXdNWw
         agLiZdR0qMRFDwIIW6+vs4K8D76uIqsU0rr5ImMJwWYfvhXTkyxLF49I7mCMwdUZ/wNa
         sWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t4C71UdUds8mfeMVRJziN4Jin8vpYyBJxbMwjur/Fro=;
        b=HUGnjSh7fvATGGKbGSruTsmujbWiz6seM1mOwlOi/Nc6xzj2iBURid+CpqA9g93hSJ
         9VarpcL6ncs5fV9pmr/OfWcl3c6PF1qnZjxC2fQMbpM9BDZxgx0on6JczKIYMAXoYIFb
         9Hu/XOzFYiIT215K4W9Rz1o9TLCAg9R1cM35cBTrAzoBDPvzVK2ywVdj96phw4nti1kI
         f7dxlZ92snh//prvAgMzDIo9+j35LCe3Jz8PLMb/Layu1HRZRZvUUCEwimOwhw1XhNO5
         z0uuB7bFxviNsIxOWoK0q1AXyKe6ij8ztKYcbIIW4CSa/HzP4D4iLyg4zOSMSlJMACpE
         Yveg==
X-Gm-Message-State: APjAAAWUOVPD43atM3bK8jGoFLQqvRA8yGY/rJz6ymFXWHkko/ChIzl7
        9b1pWuher4BURVb9HI0yjWoEwA==
X-Google-Smtp-Source: APXvYqytMHDCmOCDQLztxZo9Q0q6CYXm6Ps9ifpdxmbaJm6efzYlYKpW6H6YHY45ud4Opdoz/tMqFA==
X-Received: by 2002:a63:1341:: with SMTP id 1mr35984347pgt.48.1565716359879;
        Tue, 13 Aug 2019 10:12:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:674])
        by smtp.gmail.com with ESMTPSA id q7sm124462102pff.2.2019.08.13.10.12.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 10:12:39 -0700 (PDT)
Date:   Tue, 13 Aug 2019 13:12:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: vmscan: do not share cgroup iteration between
 reclaimers
Message-ID: <20190813171237.GA21743@cmpxchg.org>
References: <20190812192316.13615-1-hannes@cmpxchg.org>
 <20190813132938.GJ17933@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813132938.GJ17933@dhcp22.suse.cz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 13, 2019 at 03:29:38PM +0200, Michal Hocko wrote:
> On Mon 12-08-19 15:23:16, Johannes Weiner wrote:
> > One of our services observed a high rate of cgroup OOM kills in the
> > presence of large amounts of clean cache. Debugging showed that the
> > culprit is the shared cgroup iteration in page reclaim.
> > 
> > Under high allocation concurrency, multiple threads enter reclaim at
> > the same time. Fearing overreclaim when we first switched from the
> > single global LRU to cgrouped LRU lists, we introduced a shared
> > iteration state for reclaim invocations - whether 1 or 20 reclaimers
> > are active concurrently, we only walk the cgroup tree once: the 1st
> > reclaimer reclaims the first cgroup, the second the second one etc.
> > With more reclaimers than cgroups, we start another walk from the top.
> > 
> > This sounded reasonable at the time, but the problem is that reclaim
> > concurrency doesn't scale with allocation concurrency. As reclaim
> > concurrency increases, the amount of memory individual reclaimers get
> > to scan gets smaller and smaller. Individual reclaimers may only see
> > one cgroup per cycle, and that may not have much reclaimable
> > memory. We see individual reclaimers declare OOM when there is plenty
> > of reclaimable memory available in cgroups they didn't visit.
> > 
> > This patch does away with the shared iterator, and every reclaimer is
> > allowed to scan the full cgroup tree and see all of reclaimable
> > memory, just like it would on a non-cgrouped system. This way, when
> > OOM is declared, we know that the reclaimer actually had a chance.
> > 
> > To still maintain fairness in reclaim pressure, disallow cgroup
> > reclaim from bailing out of the tree walk early. Kswapd and regular
> > direct reclaim already don't bail, so it's not clear why limit reclaim
> > would have to, especially since it only walks subtrees to begin with.
> 
> The code does bail out on any direct reclaim - be it limit or page
> allocator triggered. Check the !current_is_kswapd part of the condition.

Ah you're right. In practice I doubt it makes much of a difference,
though, because...

> > This change completely eliminates the OOM kills on our service, while
> > showing no signs of overreclaim - no increased scan rates, %sys time,
> > or abrupt free memory spikes. I tested across 100 machines that have
> > 64G of RAM and host about 300 cgroups each.
> 
> What is the usual direct reclaim involvement on those machines?

80-200 kb/s. In general we try to keep this low to non-existent on our
hosts due to the latency implications. So it's fair to say that kswapd
does page reclaim, and direct reclaim is a sign of overload.

> That being said, I do agree that the oom side of the coin is causing
> real troubles and it is a real problem to be addressed first. Especially with
> cgroup v2 where we have likely more memcgs without any pages because
> inner nodes do not have any tasks and direct charges which makes some
> reclaimers hit memcgs without pages more likely.
> 
> Let's see whether we see regression due to over-reclaim. 
> 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> With the direct reclaim bail out reference fixed - unless I am wrong
> there of course
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks! I'll send an updated changelog.

> It is sad to see this piece of fun not being used after that many years
> of bugs here and there and all the lockless fun but this is the life

Haha, agreed.
