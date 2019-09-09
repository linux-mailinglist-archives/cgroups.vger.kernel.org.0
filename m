Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC48AD8FF
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2019 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfIIM2y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Sep 2019 08:28:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:49278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfIIM2y (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 9 Sep 2019 08:28:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35CC2B07D;
        Mon,  9 Sep 2019 12:28:53 +0000 (UTC)
Date:   Mon, 9 Sep 2019 14:28:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: lot of MemAvailable but falling cache and raising PSI
Message-ID: <20190909122852.GM27159@dhcp22.suse.cz>
References: <4b4ba042-3741-7b16-2292-198c569da2aa@profihost.ag>
 <20190905114022.GH3838@dhcp22.suse.cz>
 <7a3d23f2-b5fe-b4c0-41cd-e79070637bd9@profihost.ag>
 <e866c481-04f2-fdb4-4d99-e7be2414591e@profihost.ag>
 <20190909082732.GC27159@dhcp22.suse.cz>
 <1d9ee19a-98c9-cd78-1e5b-21d9d6e36792@profihost.ag>
 <20190909110136.GG27159@dhcp22.suse.cz>
 <20190909120811.GL27159@dhcp22.suse.cz>
 <88ff0310-b9ab-36b6-d8ab-b6edd484d973@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ff0310-b9ab-36b6-d8ab-b6edd484d973@profihost.ag>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 09-09-19 14:10:02, Stefan Priebe - Profihost AG wrote:
> 
> Am 09.09.19 um 14:08 schrieb Michal Hocko:
> > On Mon 09-09-19 13:01:36, Michal Hocko wrote:
> >> and that matches moments when we reclaimed memory. There seems to be a
> >> steady THP allocations flow so maybe this is a source of the direct
> >> reclaim?
> > 
> > I was thinking about this some more and THP being a source of reclaim
> > sounds quite unlikely. At least in a default configuration because we
> > shouldn't do anything expensinve in the #PF path. But there might be a
> > difference source of high order (!costly) allocations. Could you check
> > how many allocation requests like that you have on your system?
> > 
> > mount -t debugfs none /debug
> > echo "order > 0" > /debug/tracing/events/kmem/mm_page_alloc/filter
> > echo 1 > /debug/tracing/events/kmem/mm_page_alloc/enable
> > cat /debug/tracing/trace_pipe > $file

echo 1 > /debug/tracing/events/vmscan/mm_vmscan_direct_reclaim_begin/enable
echo 1 > /debug/tracing/events/vmscan/mm_vmscan_direct_reclaim_end/enable
 
might tell us something as well but it might turn out that it just still
doesn't give us the full picture and we might need
echo stacktrace > /debug/tracing/trace_options

It will generate much more output though.

> Just now or when PSI raises?

When the excessive reclaim is happening ideally.

-- 
Michal Hocko
SUSE Labs
