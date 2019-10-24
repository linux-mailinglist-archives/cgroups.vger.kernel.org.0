Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC2E2C0C
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2019 10:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfJXIYt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Oct 2019 04:24:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:32832 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbfJXIYt (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 24 Oct 2019 04:24:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F6C6B2AC;
        Thu, 24 Oct 2019 08:24:41 +0000 (UTC)
Date:   Thu, 24 Oct 2019 10:24:40 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: memcontrol: try harder to set a new memory.high
Message-ID: <20191024082440.GT17610@dhcp22.suse.cz>
References: <20191022201518.341216-1-hannes@cmpxchg.org>
 <20191022201518.341216-2-hannes@cmpxchg.org>
 <20191023065949.GD754@dhcp22.suse.cz>
 <20191023175724.GD366316@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023175724.GD366316@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 23-10-19 13:57:24, Johannes Weiner wrote:
> On Wed, Oct 23, 2019 at 08:59:49AM +0200, Michal Hocko wrote:
> > On Tue 22-10-19 16:15:18, Johannes Weiner wrote:
> > > Setting a memory.high limit below the usage makes almost no effort to
> > > shrink the cgroup to the new target size.
> > > 
> > > While memory.high is a "soft" limit that isn't supposed to cause OOM
> > > situations, we should still try harder to meet a user request through
> > > persistent reclaim.
> > > 
> > > For example, after setting a 10M memory.high on an 800M cgroup full of
> > > file cache, the usage shrinks to about 350M:
> > > 
> > > + cat /cgroup/workingset/memory.current
> > > 841568256
> > > + echo 10M
> > > + cat /cgroup/workingset/memory.current
> > > 355729408
> > > 
> > > This isn't exactly what the user would expect to happen. Setting the
> > > value a few more times eventually whittles the usage down to what we
> > > are asking for:
> > > 
> > > + echo 10M
> > > + cat /cgroup/workingset/memory.current
> > > 104181760
> > > + echo 10M
> > > + cat /cgroup/workingset/memory.current
> > > 31801344
> > > + echo 10M
> > > + cat /cgroup/workingset/memory.current
> > > 10440704
> > > 
> > > To improve this, add reclaim retry loops to the memory.high write()
> > > callback, similar to what we do for memory.max, to make a reasonable
> > > effort that the usage meets the requested size after the call returns.
> > 
> > That suggests that the reclaim couldn't meet the given reclaim target
> > but later attempts just made it through. Is this due to amount of dirty
> > pages or what prevented the reclaim to do its job?
> > 
> > While I am not against the reclaim retry loop I would like to understand
> > the underlying issue. Because if this is really about dirty memory then
> > we should probably be more pro-active in flushing it. Otherwise the
> > retry might not be of any help.
> 
> All the pages in my test case are clean cache. But they are active,
> and they need to go through the inactive list before reclaiming. The
> inactive list size is designed to pre-age just enough pages for
> regular reclaim targets, i.e. pages in the SWAP_CLUSTER_MAX ballpark,
> In this case, the reclaim goal for a single invocation is 790M and the
> inactive list is a small funnel to put all that through, and we need
> several iterations to accomplish that.

Thanks for the clarification.

> But 790M is not a reasonable reclaim target to ask of a single reclaim
> invocation. And it wouldn't be reasonable to optimize the reclaim code
> for it. So asking for the full size but retrying is not a bad choice
> here: we express our intent, and benefit if reclaim becomes better at
> handling larger requests, but we also acknowledge that some of the
> deltas we can encounter in memory_high_write() are just too
> ridiculously big for a single reclaim invocation to manage.

Yes that makes sense and I think it should be a part of the changelog.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
-- 
Michal Hocko
SUSE Labs
