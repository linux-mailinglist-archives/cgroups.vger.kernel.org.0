Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727B38CDB9
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2019 10:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfHNIL5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Aug 2019 04:11:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:38490 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbfHNIL5 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 14 Aug 2019 04:11:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA6AAAF98;
        Wed, 14 Aug 2019 08:11:55 +0000 (UTC)
Date:   Wed, 14 Aug 2019 10:11:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: vmscan: do not share cgroup iteration between
 reclaimers
Message-ID: <20190814081155.GQ17933@dhcp22.suse.cz>
References: <20190812192316.13615-1-hannes@cmpxchg.org>
 <20190813132938.GJ17933@dhcp22.suse.cz>
 <20190813171237.GA21743@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813171237.GA21743@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 13-08-19 13:12:37, Johannes Weiner wrote:
> On Tue, Aug 13, 2019 at 03:29:38PM +0200, Michal Hocko wrote:
> > On Mon 12-08-19 15:23:16, Johannes Weiner wrote:
[...]
> > > This change completely eliminates the OOM kills on our service, while
> > > showing no signs of overreclaim - no increased scan rates, %sys time,
> > > or abrupt free memory spikes. I tested across 100 machines that have
> > > 64G of RAM and host about 300 cgroups each.
> > 
> > What is the usual direct reclaim involvement on those machines?
> 
> 80-200 kb/s. In general we try to keep this low to non-existent on our
> hosts due to the latency implications. So it's fair to say that kswapd
> does page reclaim, and direct reclaim is a sign of overload.

Well, there are workloads which are much more direct reclaim heavier.
How much they rely on large memcg trees remains to be seen. Your
changelog should state that the above workload is very light on direct
reclaim, though, because the above paragraph suggests that a risk of
longer stalls is really non-issue while I think this is not really all
that clear.
-- 
Michal Hocko
SUSE Labs
