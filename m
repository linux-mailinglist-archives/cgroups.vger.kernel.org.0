Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8934760F8
	for <lists+cgroups@lfdr.de>; Wed, 15 Dec 2021 19:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbhLOSoD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Dec 2021 13:44:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37490 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbhLOSoD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Dec 2021 13:44:03 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D24371F3CC;
        Wed, 15 Dec 2021 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639593841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NWqD+PcCuxR8HDxLdpgeitQDnhGffUIL9j/CCfmjTsM=;
        b=ZrtZuZL9p+UI1aJNPgIfrBv5AA1n9CG6VLC82bQzhuhvW7kETDDJ0FtNiqFx7Cufw+EZn7
        QMszsvkFZ+2lBhW1DRQUbdIy1BOnr7EIedb4HK+T+H3BUi/X41gWGwT9SUgAQiem8cRx6Q
        OCtF40bavtOsWRDwyGAdw85RjFdlFMs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 969CCA3B84;
        Wed, 15 Dec 2021 18:44:01 +0000 (UTC)
Date:   Wed, 15 Dec 2021 19:44:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] mm/memcontrol: Disable on PREEMPT_RT
Message-ID: <Ybo3cAkyg0SrUyJJ@dhcp22.suse.cz>
References: <20211207155208.eyre5svucpg7krxe@linutronix.de>
 <Ya+SCkLOLBVN/kiY@cmpxchg.org>
 <YbNwmUMPFM/MO0cX@linutronix.de>
 <YbcbmvQk+Sgdsi9G@dhcp22.suse.cz>
 <YbocOh+h3o/Yc5Ag@linutronix.de>
 <YboeI1aTFdQpN0TI@dhcp22.suse.cz>
 <YboiRA1znig/cbCt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YboiRA1znig/cbCt@linutronix.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 15-12-21 18:13:40, Sebastian Andrzej Siewior wrote:
> On 2021-12-15 17:56:03 [+0100], Michal Hocko wrote:
> > On Wed 15-12-21 17:47:54, Sebastian Andrzej Siewior wrote:
> > > On 2021-12-13 11:08:26 [+0100], Michal Hocko wrote:
> > > > On Fri 10-12-21 16:22:01, Sebastian Andrzej Siewior wrote:
> > > > [...]
> > > > I am sorry but I didn't get to read and digest the rest of the message
> > > > yet. Let me just point out this
> > > > 
> > > > > The problematic part here is mem_cgroup_tree_per_node::lock which can
> > > > > not be acquired with disabled interrupts on PREEMPT_RT.  The "locking
> > > > > scope" is not always clear to me.  Also, if it is _just_ the counter,
> > > > > then we might solve this differently.
> > > > 
> > > > I do not think you should be losing sleep over soft limit reclaim. This
> > > > is certainly not something to be used for RT workloads and rather than
> > > > touching that code I think it makes some sense to simply disallow soft
> > > > limit with RT enabled (i.e. do not allow to set any soft limit).
> > > 
> > > Okay. So instead of disabling it entirely you suggest I should take
> > > another stab at it? Okay. Disabling softlimit, where should I start with
> > > it? Should mem_cgroup_write() for RES_SOFT_LIMIT always return an error
> > > or something else?
> > 
> > Yeah, I would just return an error for RT configuration. If we ever need
> > to implement that behavior for RT then we can look at specific fixes.
> 
> Okay. What do I gain by doing this / how do I test this? Is running
> tools/testing/selftests/cgroup/test_*mem* sufficient to test all corner
> cases here?

I am not fully aware of all the tests but my point is that if the soft
limit is not configured then there are no soft limit tree manipulations
ever happening and therefore the code is effectivelly dead. Is this
sufficient for the RT patchset to ignore the RT incompatible parts?
-- 
Michal Hocko
SUSE Labs
