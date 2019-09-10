Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A7AAEB68
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2019 15:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfIJNYV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Sep 2019 09:24:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:55476 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbfIJNYV (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 10 Sep 2019 09:24:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99511ABCE;
        Tue, 10 Sep 2019 13:24:19 +0000 (UTC)
Date:   Tue, 10 Sep 2019 15:24:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: lot of MemAvailable but falling cache and raising PSI
Message-ID: <20190910132418.GC2063@dhcp22.suse.cz>
References: <52235eda-ffe2-721c-7ad7-575048e2d29d@profihost.ag>
 <20190910082919.GL2063@dhcp22.suse.cz>
 <132e1fd0-c392-c158-8f3a-20e340e542f0@profihost.ag>
 <20190910090241.GM2063@dhcp22.suse.cz>
 <743a047e-a46f-32fa-1fe4-a9bd8f09ed87@profihost.ag>
 <20190910110741.GR2063@dhcp22.suse.cz>
 <364d4c2e-9c9a-d8b3-43a8-aa17cccae9c7@profihost.ag>
 <20190910125756.GB2063@dhcp22.suse.cz>
 <d7448f13-899a-5805-bd36-8922fa17b8a9@profihost.ag>
 <b1fe902f-fce6-1aa9-f371-ceffdad85968@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1fe902f-fce6-1aa9-f371-ceffdad85968@profihost.ag>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 10-09-19 15:14:45, Stefan Priebe - Profihost AG wrote:
> Am 10.09.19 um 15:05 schrieb Stefan Priebe - Profihost AG:
> > 
> > Am 10.09.19 um 14:57 schrieb Michal Hocko:
> >> On Tue 10-09-19 14:45:37, Stefan Priebe - Profihost AG wrote:
> >>> Hello Michal,
> >>>
> >>> ok this might take a long time. Attached you'll find a graph from a
> >>> fresh boot what happens over time (here 17 August to 30 August). Memory
> >>> Usage decreases as well as cache but slowly and only over time and days.
> >>>
> >>> So it might take 2-3 weeks running Kernel 5.3 to see what happens.
> >>
> >> No problem. Just make sure to collect the requested data from the time
> >> you see the actual problem. Btw. you try my very dumb scriplets to get
> >> an idea of how much memory gets reclaimed due to THP.
> > 
> > You mean your sed and sort on top of the trace file? No i did not with
> > the current 5.3 kernel do you think it will show anything interesting?
> > Which line shows me how much memory gets reclaimed due to THP?

Please re-read http://lkml.kernel.org/r/20190910082919.GL2063@dhcp22.suse.cz
Each command has a commented output. If you see nunmber of reclaimed
pages to be large for GFP_TRANSHUGE then you are seeing a similar
problem.

> Is something like a kernel memory leak possible? Or wouldn't this end up
> in having a lot of free memory which doesn't seem usable.

I would be really surprised if this was the case.

> I also wonder why a reclaim takes place when there is enough memory.

This is not clear yet and it might be a bug that has been fixed since
4.18. That's why we need to see whether the same is pattern is happening
with 5.3 as well.

-- 
Michal Hocko
SUSE Labs
