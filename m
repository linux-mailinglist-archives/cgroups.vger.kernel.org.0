Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A013325F79
	for <lists+cgroups@lfdr.de>; Fri, 26 Feb 2021 09:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhBZIw5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Feb 2021 03:52:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:55790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhBZIw4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 26 Feb 2021 03:52:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614329530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NV8HHUAhGyMKMdxJOAqWE34D2NQYX6VFUHRpOEastO8=;
        b=G45FTSyWYpZtUtKeL8sHnB58FYPM4Bd7jXJ+v5/01Mo/i//UxfXkkRztJDF1yupehrb0uU
        +xshvAAQtIbQJ1sGTw8tyBnADadr6LGtauQGeLOJ3AHbCjViqimAZ1H4ZoHyqlDLFT3Hq/
        4WJyi+qk+V7ApnoGE+7U+2qs6aRu0cU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C97DAAAE;
        Fri, 26 Feb 2021 08:52:10 +0000 (UTC)
Date:   Fri, 26 Feb 2021 09:52:09 +0100
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
Message-ID: <YDi2udQqIML6Vdpo@dhcp22.suse.cz>
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <06f1f92f1f7d4e57c4e20c97f435252c16c60a27.1613584277.git.tim.c.chen@linux.intel.com>
 <YC+ApsntwnlVfCuK@dhcp22.suse.cz>
 <884d7559-e118-3773-351d-84c02642ca96@linux.intel.com>
 <YDNuAIztiGJpLEtw@dhcp22.suse.cz>
 <e132f836-b5d5-3776-22d6-669e713983e4@linux.intel.com>
 <YDQBh5th9txxEFUm@dhcp22.suse.cz>
 <cf5ca7a1-7965-f307-22e1-e216316904cf@linux.intel.com>
 <YDY+PydRUGQpHNaJ@dhcp22.suse.cz>
 <b5b1944d-846b-3212-fe4a-f10f5fcb87d7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5b1944d-846b-3212-fe4a-f10f5fcb87d7@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 25-02-21 14:48:58, Tim Chen wrote:
> 
> 
> On 2/24/21 3:53 AM, Michal Hocko wrote:
> > On Mon 22-02-21 11:48:37, Tim Chen wrote:
> >>
> >>
> >> On 2/22/21 11:09 AM, Michal Hocko wrote:
> >>
> >>>>
> >>>> I actually have tried adjusting the threshold but found that it doesn't work well for
> >>>> the case with unenven memory access frequency between cgroups.  The soft
> >>>> limit for the low memory event cgroup could creep up quite a lot, exceeding
> >>>> the soft limit by hundreds of MB, even
> >>>> if I drop the SOFTLIMIT_EVENTS_TARGET from 1024 to something like 8.
> >>>
> >>> What was the underlying reason? Higher order allocations?
> >>>
> >>
> >> Not high order allocation.
> >>
> >> The reason was because the run away memcg asks for memory much less often, compared
> >> to the other memcgs in the system.  So it escapes the sampling update and
> >> was not put onto the tree and exceeds the soft limit
> >> pretty badly.  Even if it was put onto the tree and gets page reclaimed below the
> >> limit, it could escape the sampling the next time it exceeds the soft limit.
> > 
> > I am sorry but I really do not follow. Maybe I am missing something
> > obvious but the the rate of events (charge/uncharge) shouldn't be really
> > important. There is no way to exceed the limit without charging memory
> > (either a new or via task migration in v1 and immigrate_on_move). If you
> > have SOFTLIMIT_EVENTS_TARGET 8 then you should be 128 * 8 events to
> > re-evaluate. Huge pages can make the runaway much bigger but how it
> > would be possible to runaway outside of that bound.
> 
> 
> Michal,
> 
> Let's take an extreme case where memcg 1 always generate the
> first event and memcg 2 generates the rest of 128*8-1 events
> and the pattern repeat.

I do not follow. Events are per-memcg, aren't they?
	__this_cpu_read(memcg->vmstats_percpu->targets[target]);
	[...]
	__this_cpu_write(memcg->vmstats_percpu->targets[target], next);
-- 
Michal Hocko
SUSE Labs
