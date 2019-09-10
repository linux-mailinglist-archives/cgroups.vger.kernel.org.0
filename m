Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B21AEAF0
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2019 14:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393273AbfIJM6A (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Sep 2019 08:58:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:53034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393272AbfIJM6A (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 10 Sep 2019 08:58:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A8F8B863;
        Tue, 10 Sep 2019 12:57:58 +0000 (UTC)
Date:   Tue, 10 Sep 2019 14:57:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: lot of MemAvailable but falling cache and raising PSI
Message-ID: <20190910125756.GB2063@dhcp22.suse.cz>
References: <2d04fc69-8fac-2900-013b-7377ca5fd9a8@profihost.ag>
 <20190909124950.GN27159@dhcp22.suse.cz>
 <10fa0b97-631d-f82b-0881-89adb9ad5ded@profihost.ag>
 <52235eda-ffe2-721c-7ad7-575048e2d29d@profihost.ag>
 <20190910082919.GL2063@dhcp22.suse.cz>
 <132e1fd0-c392-c158-8f3a-20e340e542f0@profihost.ag>
 <20190910090241.GM2063@dhcp22.suse.cz>
 <743a047e-a46f-32fa-1fe4-a9bd8f09ed87@profihost.ag>
 <20190910110741.GR2063@dhcp22.suse.cz>
 <364d4c2e-9c9a-d8b3-43a8-aa17cccae9c7@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <364d4c2e-9c9a-d8b3-43a8-aa17cccae9c7@profihost.ag>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 10-09-19 14:45:37, Stefan Priebe - Profihost AG wrote:
> Hello Michal,
> 
> ok this might take a long time. Attached you'll find a graph from a
> fresh boot what happens over time (here 17 August to 30 August). Memory
> Usage decreases as well as cache but slowly and only over time and days.
> 
> So it might take 2-3 weeks running Kernel 5.3 to see what happens.

No problem. Just make sure to collect the requested data from the time
you see the actual problem. Btw. you try my very dumb scriplets to get
an idea of how much memory gets reclaimed due to THP.
-- 
Michal Hocko
SUSE Labs
