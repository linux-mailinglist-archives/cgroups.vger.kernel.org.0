Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A66BAE8D8
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2019 13:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfIJLHr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Sep 2019 07:07:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:53782 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbfIJLHr (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 10 Sep 2019 07:07:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63F6FB71D;
        Tue, 10 Sep 2019 11:07:45 +0000 (UTC)
Date:   Tue, 10 Sep 2019 13:07:41 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: lot of MemAvailable but falling cache and raising PSI
Message-ID: <20190910110741.GR2063@dhcp22.suse.cz>
References: <88ff0310-b9ab-36b6-d8ab-b6edd484d973@profihost.ag>
 <20190909122852.GM27159@dhcp22.suse.cz>
 <2d04fc69-8fac-2900-013b-7377ca5fd9a8@profihost.ag>
 <20190909124950.GN27159@dhcp22.suse.cz>
 <10fa0b97-631d-f82b-0881-89adb9ad5ded@profihost.ag>
 <52235eda-ffe2-721c-7ad7-575048e2d29d@profihost.ag>
 <20190910082919.GL2063@dhcp22.suse.cz>
 <132e1fd0-c392-c158-8f3a-20e340e542f0@profihost.ag>
 <20190910090241.GM2063@dhcp22.suse.cz>
 <743a047e-a46f-32fa-1fe4-a9bd8f09ed87@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <743a047e-a46f-32fa-1fe4-a9bd8f09ed87@profihost.ag>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 10-09-19 11:37:19, Stefan Priebe - Profihost AG wrote:
> 
> Am 10.09.19 um 11:02 schrieb Michal Hocko:
> > On Tue 10-09-19 10:38:25, Stefan Priebe - Profihost AG wrote:
[...]
> >> /sys/kernel/mm/transparent_hugepage/defrag:always defer [defer+madvise]
> >> madvise never
[...]
> > Many processes hitting the reclaim are php5 others I cannot say because
> > their cmd is not reflected in the trace. I suspect those are using
> > madvise. I haven't really seen kcompactd interfering much. That would
> > suggest using defer.
> 
> You mean i should set transparent_hugepage to defer?

Let's try with 5.3 without any changes first and then if the problem is
still reproducible then limit the THP load by setting
transparent_hugepage to defer.
-- 
Michal Hocko
SUSE Labs
