Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66832F98A5
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 19:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKLSai (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 13:30:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:52924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726965AbfKLSah (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 12 Nov 2019 13:30:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 313B2ACBD;
        Tue, 12 Nov 2019 18:30:35 +0000 (UTC)
Date:   Tue, 12 Nov 2019 19:30:32 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Down <chris@chrisdown.name>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, guro@fb.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/vmscan: fix an undefined behavior for zone id
Message-ID: <20191112183032.GC512@dhcp22.suse.cz>
References: <20191108204407.1435-1-cai@lca.pw>
 <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
 <20191111130516.GA891635@chrisdown.name>
 <20191111131427.GB891635@chrisdown.name>
 <20191111132812.GK1396@dhcp22.suse.cz>
 <20191112145942.GA168812@cmpxchg.org>
 <20191112152750.GA512@dhcp22.suse.cz>
 <20191112161658.GF168812@cmpxchg.org>
 <20191112163156.GB512@dhcp22.suse.cz>
 <20191112182017.GB179587@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112182017.GB179587@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 12-11-19 13:20:17, Johannes Weiner wrote:
> On Tue, Nov 12, 2019 at 05:31:56PM +0100, Michal Hocko wrote:
> > On Tue 12-11-19 11:16:58, Johannes Weiner wrote:
> > > On Tue, Nov 12, 2019 at 04:27:50PM +0100, Michal Hocko wrote:
> > > > lruvec_lru_size is explicitly documented to use MAX_NR_ZONES for all
> > > > LRUs and git grep says there are more instances outside of
> > > > get_scan_count. So all of them have to be fixed.
> > > 
> > > Which ones?
> > > 
> > > [hannes@computer linux]$ git grep lruvec_lru_size
> > > include/linux/mmzone.h:extern unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx);
> > > mm/vmscan.c: * lruvec_lru_size -  Returns the number of pages on the given LRU list.
> > > mm/vmscan.c:unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
> > > mm/vmscan.c:    anon  = lruvec_lru_size(lruvec, LRU_ACTIVE_ANON, MAX_NR_ZONES - 1) +
> > > mm/vmscan.c:            lruvec_lru_size(lruvec, LRU_INACTIVE_ANON, MAX_NR_ZONES - 1);
> > > mm/vmscan.c:    file  = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES - 1) +
> > > mm/vmscan.c:            lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES - 1);
> > > mm/vmscan.c:            lruvec_size = lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
> > > [hannes@computer linux]$
> > 
> > I have checked the Linus tree but now double checked with the current
> > next
> > $ git describe next/master
> > next-20191112
> > $ git grep "lruvec_lru_size.*MAX_NR_ZONES" next/master
> > next/master:mm/vmscan.c:                        lruvec_lru_size(lruvec, inactive_lru, MAX_NR_ZONES), inactive,
> > next/master:mm/vmscan.c:                        lruvec_lru_size(lruvec, active_lru, MAX_NR_ZONES), active,
> > next/master:mm/vmscan.c:        anon  = lruvec_lru_size(lruvec, LRU_ACTIVE_ANON, MAX_NR_ZONES) +
> > next/master:mm/vmscan.c:                lruvec_lru_size(lruvec, LRU_INACTIVE_ANON, MAX_NR_ZONES);
> > next/master:mm/vmscan.c:        file  = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES) +
> > next/master:mm/vmscan.c:                lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES);
> > next/master:mm/workingset.c:    active_file = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES);
> > 
> > are there any changes which didn't make it to linux next yet?
> 
> Aaahh, that makes sense. I was looking at the latest mmots which
> has
> 
> - mm: vmscan: detect file thrashing at the reclaim root
> - mm: vmscan: enforce inactive:active ratio at the reclaim root
> 
> Those replace the inactive_is_low and the workingset callsites with
> the recursive lruvec_page_state(). It looks like that isn't in next -
> and while I hope it'll make it into 5.5, it might not. So we need a
> fix that considers the other callsites as well.
> 
> Qian's patches that Andrew already has will be good then, as it
> reduces the churn to those other callsites that are in flux.
> 
> We can clean things up when the dust settles.

Yeah, while I am not really super happy about the code that is more
complex than necessary the clean up can be done on top and we can also
think about how to do it properly (I still haven't given up ;))

-- 
Michal Hocko
SUSE Labs
