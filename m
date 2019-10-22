Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69A0E01F1
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbfJVKUh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 06:20:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:58182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729874AbfJVKUh (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 22 Oct 2019 06:20:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45537ADB5;
        Tue, 22 Oct 2019 10:20:35 +0000 (UTC)
Date:   Tue, 22 Oct 2019 12:20:32 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: lot of MemAvailable but falling cache and raising PSI
Message-ID: <20191022102028.GA21387@linux>
References: <20190910125756.GB2063@dhcp22.suse.cz>
 <d7448f13-899a-5805-bd36-8922fa17b8a9@profihost.ag>
 <b1fe902f-fce6-1aa9-f371-ceffdad85968@profihost.ag>
 <20190910132418.GC2063@dhcp22.suse.cz>
 <d07620d9-4967-40fe-fa0f-be51f2459dc5@profihost.ag>
 <2fe81a9e-5d29-79cf-f747-c66ae35defd0@profihost.ag>
 <4f6f1bc9-08f4-d53a-8788-a761be769757@suse.cz>
 <76ad5b29-815b-3d87-cefa-ec5b222279f1@profihost.ag>
 <b82b9fcb-fa64-c36c-5ef5-cb2e4d64a51a@suse.cz>
 <1430bb64-ef9b-f6a1-fb2c-1ca351e7950e@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1430bb64-ef9b-f6a1-fb2c-1ca351e7950e@profihost.ag>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 22, 2019 at 12:02:13PM +0200, Stefan Priebe - Profihost AG wrote:
> 
> Am 22.10.19 um 09:48 schrieb Vlastimil Babka:
> > On 10/22/19 9:41 AM, Stefan Priebe - Profihost AG wrote:
> >>> Hi, could you try the patch below? I suspect you're hitting a corner
> >>> case where compaction_suitable() returns COMPACT_SKIPPED for the
> >>> ZONE_DMA, triggering reclaim even if other zones have plenty of free
> >>> memory. And should_continue_reclaim() then returns true until twice the
> >>> requested page size is reclaimed (compact_gap()). That means 4MB
> >>> reclaimed for each THP allocation attempt, which roughly matches the
> >>> trace data you preovided previously.
> >>>
> >>> The amplification to 4MB should be removed in patches merged for 5.4, so
> >>> it would be only 32 pages reclaimed per THP allocation. The patch below
> >>> tries to remove this corner case completely, and it should be more
> >>> visible on your 5.2.x, so please apply it there.
> >>>
> >> is there any reason to not apply that one on top of 4.19?
> >>
> >> Greets,
> >> Stefan
> >>
> > 
> > It should work, cherrypicks fine without conflict here.
> 
> OK but does not work ;-)
> 
> 
> mm/compaction.c: In function '__compaction_suitable':
> mm/compaction.c:1451:19: error: implicit declaration of function
> 'zone_managed_pages'; did you mean 'node_spanned_pages'?
> [-Werror=implicit-function-declaration]
>       alloc_flags, zone_managed_pages(zone)))
>                    ^~~~~~~~~~~~~~~~~~
>                    node_spanned_pages

zone_managed_pages() was introduced later.
On 4.19, you need zone->managed_pages.
So, changing zone_managed_pages(zone) to zone->managed_pages in that chunk
should make the trick.

> 
> Greets,
> Stefan
> 
> 
> 

-- 
Oscar Salvador
SUSE L3
