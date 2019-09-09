Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3955CAD788
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2019 13:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfIILBj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Sep 2019 07:01:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:60012 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728349AbfIILBj (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 9 Sep 2019 07:01:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 618F8AD44;
        Mon,  9 Sep 2019 11:01:37 +0000 (UTC)
Date:   Mon, 9 Sep 2019 13:01:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: lot of MemAvailable but falling cache and raising PSI
Message-ID: <20190909110136.GG27159@dhcp22.suse.cz>
References: <4b4ba042-3741-7b16-2292-198c569da2aa@profihost.ag>
 <20190905114022.GH3838@dhcp22.suse.cz>
 <7a3d23f2-b5fe-b4c0-41cd-e79070637bd9@profihost.ag>
 <e866c481-04f2-fdb4-4d99-e7be2414591e@profihost.ag>
 <20190909082732.GC27159@dhcp22.suse.cz>
 <1d9ee19a-98c9-cd78-1e5b-21d9d6e36792@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d9ee19a-98c9-cd78-1e5b-21d9d6e36792@profihost.ag>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[Cc Vlastimil - logs are http://lkml.kernel.org/r/1d9ee19a-98c9-cd78-1e5b-21d9d6e36792@profihost.ag]

On Mon 09-09-19 10:54:21, Stefan Priebe - Profihost AG wrote:
> Hello Michal,
> 
> Am 09.09.19 um 10:27 schrieb Michal Hocko:
> > On Fri 06-09-19 12:08:31, Stefan Priebe - Profihost AG wrote:
> >> These are the biggest differences in meminfo before and after cached
> >> starts to drop. I didn't expect cached end up in MemFree.
> >>
> >> Before:
> >> MemTotal:       16423116 kB
> >> MemFree:          374572 kB
> >> MemAvailable:    5633816 kB
> >> Cached:          5550972 kB
> >> Inactive:        4696580 kB
> >> Inactive(file):  3624776 kB
> >>
> >>
> >> After:
> >> MemTotal:       16423116 kB
> >> MemFree:         3477168 kB
> >> MemAvailable:    6066916 kB
> >> Cached:          2724504 kB
> >> Inactive:        1854740 kB
> >> Inactive(file):   950680 kB
> >>
> >> Any explanation?
> > 
> > Do you have more snapshots of /proc/vmstat as suggested by Vlastimil and
> > me earlier in this thread? Seeing the overall progress would tell us
> > much more than before and after. Or have I missed this data?
> 
> I needed to wait until today to grab again such a situation but from
> what i know it is very clear that MemFree is low and than the kernel
> starts to drop the chaches.
> 
> Attached you'll find two log files.

$ grep pgsteal_kswapd vmstat | uniq -c
   1331 pgsteal_kswapd 37142300
$ grep pgscan_kswapd vmstat | uniq -c
   1331 pgscan_kswapd 37285092

kswapd hasn't scanned nor reclaimed any memory throughout the whole
collected time span. On the other hand we can see direct reclaim active.
But we can see quite some direct reclaim activity:
$ awk '/pgsteal_direct/ {val=$2+0; ln++; if (last && val-last > 0) {printf("%d %d\n", ln, val-last)} last=val}' vmstat | head
17 1058
18 9773
19 1036
24 11413
49 1055
50 1050
51 17938
52 22665
53 29400
54 5997

So there is a steady source of the direct reclaim which is quite
unexpected considering the background reclaim is inactive. Or maybe it
is blocked not able to make a forward progress.

780513 pages has been reclaimed which is 3G worth of memory which
matches the dropdown you are seeing AFAICS.

$ grep allocstall_dma32 vmstat | uniq -c
   1331 allocstall_dma32 0
$ grep allocstall_normal vmstat | uniq -c
   1331 allocstall_normal 39

no direct reclaim invoked for DMA32 and Normal zones. But Movable zone
seems the be the source of the direct reclaim
awk '/allocstall_movable/ {val=$2+0; ln++; if (last && val-last > 0) {printf("%d %d\n", ln, val-last)} last=val}' vmstat | head
17 1
18 9
19 1
24 10
49 1
50 1
51 17
52 20
53 28
54 5

and that matches moments when we reclaimed memory. There seems to be a
steady THP allocations flow so maybe this is a source of the direct
reclaim?
-- 
Michal Hocko
SUSE Labs
