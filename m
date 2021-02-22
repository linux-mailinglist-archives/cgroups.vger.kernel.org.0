Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5779B321229
	for <lists+cgroups@lfdr.de>; Mon, 22 Feb 2021 09:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhBVIln (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Feb 2021 03:41:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:39826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhBVIl2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 22 Feb 2021 03:41:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613983241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cW7dIegbk6LhcE9Xv6LCJLDHAKtdDtCBdL39sJGIE5Q=;
        b=CxxARZ61+bbckdWC9mSQIGLcUMz5NxoXGw2kpO80V0YLOz+leyTYpDC/LpAhOvfzT1OZZS
        kVWOwWXFddWMzjyQd/yVZgAnUSNKTAli7cNenfVsiSCx3XGcVPr/53T1PrxscBP0xslri+
        kd1oOxrZYixyOnLCn7TLzk2Rd9AIaRA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EFFD7AD6B;
        Mon, 22 Feb 2021 08:40:40 +0000 (UTC)
Date:   Mon, 22 Feb 2021 09:40:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm: Force update of mem cgroup soft limit tree on
 usage excess
Message-ID: <YDNuAIztiGJpLEtw@dhcp22.suse.cz>
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <06f1f92f1f7d4e57c4e20c97f435252c16c60a27.1613584277.git.tim.c.chen@linux.intel.com>
 <YC+ApsntwnlVfCuK@dhcp22.suse.cz>
 <884d7559-e118-3773-351d-84c02642ca96@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <884d7559-e118-3773-351d-84c02642ca96@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 19-02-21 10:59:05, Tim Chen wrote:
> 
> 
> On 2/19/21 1:11 AM, Michal Hocko wrote:
> > On Wed 17-02-21 12:41:35, Tim Chen wrote:
> 
> >> Memory is accessed at a much lower frequency
> >> for the second cgroup.  The memcg event update was not triggered for the
> >> second cgroup as the memcg event update didn't happened on the 1024th sample.
> >> The second cgroup was not placed on the soft limit tree and we didn't
> >> try to reclaim the excess pages.
> >>
> >> As time goes on, we saw that the first cgroup was kept close to its
> >> soft limit due to reclaim activities, while the second cgroup's memory
> >> usage slowly creep up as it keeps getting missed from the soft limit tree
> >> update as the update didn't fall on the modulo 1024 sample.  As a result,
> >> the memory usage of the second cgroup keeps growing over the soft limit
> >> for a long time due to its relatively rare occurrence.
> > 
> > Soft limit is evaluated every THRESHOLDS_EVENTS_TARGET * SOFTLIMIT_EVENTS_TARGET.
> > If all events correspond with a newly charged memory and the last event
> > was just about the soft limit boundary then we should be bound by 128k
> > pages (512M and much more if this were huge pages) which is a lot!
> > I haven't realized this was that much. Now I see the problem. This would
> > be a useful information for the changelog.
> > 
> > Your fix is focusing on the over-the-limit boundary which will solve the
> > problem but wouldn't that lead to to updates happening too often in
> > pathological situation when a memcg would get reclaimed immediatelly?
> 
> Not really immediately.  The memcg that has the most soft limit excess will
> be chosen for page reclaim, which is the way it should be.  
> It is less likely that a memcg that just exceeded
> the soft limit becomes the worst offender immediately. 

Well this all depends on when the the soft limit reclaim triggeres. In
other words how often you see the global memory reclaim. If we have a
memcg with a sufficient excess then this will work mostly fine. I was more
worried about a case when you have memcgs just slightly over the limit
and the global memory pressure is a regular event. You can easily end up
bouncing memcgs off and on the tree in a rapid fashion. 

> With the fix, we make
> sure that it is on the bad guys list and will not be ignored and be chosen
> eventually for reclaim.  It will not sneakily increase its memory usage
> slowly.   
> 
> > 
> > One way around that would be to lower the SOFTLIMIT_EVENTS_TARGET. Have
> > you tried that? Do we even need a separate treshold for soft limit, why
> > cannot we simply update the tree each MEM_CGROUP_TARGET_THRESH?
> >  
> 
> Lowering the threshold is a band aid that really doesn't fix the problem.
> I found that if the cgroup touches the memory infrequently enough, you
> could still miss the update of it.  And in the mean time, you are updating
> things a lot more frequently with added overhead.

Yes, I agree this is more of a workaround than a fix but I would rather
go and touch the threshold which is simply bad than play more tricks
which can lead to other potential problems. All that for a feature which
is rarely used and quite problematic in itself. Not sure what Johannes
thinks about that.
-- 
Michal Hocko
SUSE Labs
