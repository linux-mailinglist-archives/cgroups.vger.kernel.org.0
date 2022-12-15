Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3289D64D873
	for <lists+cgroups@lfdr.de>; Thu, 15 Dec 2022 10:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLOJVc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Dec 2022 04:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLOJV3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Dec 2022 04:21:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD07D44;
        Thu, 15 Dec 2022 01:21:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7F0A0211BC;
        Thu, 15 Dec 2022 09:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671096086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZpJ8bIqa20K6AOQSS7MjDOb2ROLXcd/4UFBcK5ftzSw=;
        b=eStTkJ4Uq2IaY7/wCaPTH9ZTh4+3JGTku6CGhbtuZLS958Geom0iaf7W2iiUzNK5LbTGcX
        fisjHOWN54atCAiwvEUptpoTczjynBXeFvyAVHuvnoRkllvJpx8BOYRpODeZQCEreh1j0Y
        sn1IlFHHWGpFQDwiUze/1vv1wT4xnM8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A9B413434;
        Thu, 15 Dec 2022 09:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FelCExbnmmNjLAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 15 Dec 2022 09:21:26 +0000
Date:   Thu, 15 Dec 2022 10:21:25 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: Add nodes= arg to memory.reclaim
Message-ID: <Y5rnFbOqHQUT5da7@dhcp22.suse.cz>
References: <20221202223533.1785418-1-almasrymina@google.com>
 <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
 <CAHS8izM-XdLgFrQ1k13X-4YrK=JGayRXV_G3c3Qh4NLKP7cH_g@mail.gmail.com>
 <87k02volwe.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y5h+gHBneexFQcR3@cmpxchg.org>
 <Y5iGJ/9PMmSCwqLj@dhcp22.suse.cz>
 <CAHS8izOuT_-p-N1xPApi+BPJQ+P--2YVSUeiWBROGvGinN0vcg@mail.gmail.com>
 <Y5mkJL6I5Zlc1k97@dhcp22.suse.cz>
 <87mt7pdxm1.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt7pdxm1.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 15-12-22 13:50:14, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Tue 13-12-22 11:29:45, Mina Almasry wrote:
> >> On Tue, Dec 13, 2022 at 6:03 AM Michal Hocko <mhocko@suse.com> wrote:
> >> >
> >> > On Tue 13-12-22 14:30:40, Johannes Weiner wrote:
> >> > > On Tue, Dec 13, 2022 at 02:30:57PM +0800, Huang, Ying wrote:
> >> > [...]
> >> > > > After these discussion, I think the solution maybe use different
> >> > > > interfaces for "proactive demote" and "proactive reclaim".  That is,
> >> > > > reconsider "memory.demote".  In this way, we will always uncharge the
> >> > > > cgroup for "memory.reclaim".  This avoid the possible confusion there.
> >> > > > And, because demotion is considered aging, we don't need to disable
> >> > > > demotion for "memory.reclaim", just don't count it.
> >> > >
> >> > > Hm, so in summary:
> >> > >
> >> > > 1) memory.reclaim would demote and reclaim like today, but it would
> >> > >    change to only count reclaimed pages against the goal.
> >> > >
> >> > > 2) memory.demote would only demote.
> >> > >
> >> 
> >> If the above 2 points are agreeable then yes, this sounds good to me
> >> and does address our use case.
> >> 
> >> > >    a) What if the demotion targets are full? Would it reclaim or fail?
> >> > >
> >> 
> >> Wei will chime in if he disagrees, but I think we _require_ that it
> >> fails, not falls back to reclaim. The interface is asking for
> >> demotion, and is called memory.demote. For such an interface to fall
> >> back to reclaim would be very confusing to userspace and may trigger
> >> reclaim on a high priority job that we want to shield from proactive
> >> reclaim.
> >
> > But what should happen if the immediate demotion target is full but
> > lower tiers are still usable. Should the first one demote before
> > allowing to demote from the top tier?
> >  
> >> > > 3) Would memory.reclaim and memory.demote still need nodemasks?
> >> 
> >> memory.demote will need a nodemask, for sure. Today the nodemask would
> >> be useful if there is a specific node in the top tier that is
> >> overloaded and we want to reduce the pressure by demoting. In the
> >> future there will be N tiers and the nodemask says which tier to
> >> demote from.
> >
> > OK, so what is the exact semantic of the node mask. Does it control
> > where to demote from or to or both?
> >
> >> I don't think memory.reclaim would need a nodemask anymore? At least I
> >> no longer see the use for it for us.
> >> 
> >> > >    Would
> >> > >    they return -EINVAL if a) memory.reclaim gets passed only toptier
> >> > >    nodes or b) memory.demote gets passed any lasttier nodes?
> >> >
> >> 
> >> Honestly it would be great if memory.reclaim can force reclaim from a
> >> top tier nodes. It breaks the aginig pipeline, yes, but if the user is
> >> specifically asking for that because they decided in their usecase
> >> it's a good idea then the kernel should comply IMO. Not a strict
> >> requirement for us. Wei will chime in if he disagrees.
> >
> > That would require a nodemask to say which nodes to reclaim, no? The
> > default behavior should be in line with what standard memory reclaim
> > does. If the demotion is a part of that process so should be
> > memory.reclaim part of it. If we want to have a finer control then a
> > nodemask is really a must and then the nodemaks should constrain both
> > agining and reclaim.
> >
> >> memory.demote returning -EINVAL for lasttier nodes makes sense to me.
> >> 
> >> > I would also add
> >> > 4) Do we want to allow to control the demotion path (e.g. which node to
> >> >    demote from and to) and how to achieve that?
> >> 
> >> We care deeply about specifying which node to demote _from_. That
> >> would be some node that is approaching pressure and we're looking for
> >> proactive saving from. So far I haven't seen any reason to control
> >> which nodes to demote _to_. The kernel deciding that based on the
> >> aging pipeline and the node distances sounds good to me. Obviously
> >> someone else may find that useful.
> >
> > Please keep in mind that the interface should be really prepared for
> > future extensions so try to abstract from your immediate usecases.
> 
> I see two requirements here, one is to control the demotion source, that
> is, which nodes to free memory.  The other is to control the demotion
> path.  I think that we can use two different parameters for them, for
> example, "from=<demotion source nodes>" and "to=<demotion target
> nodes>".  In most cases we don't need to control the demotion path.
> Because in current implementation, the nodes in the lower tiers in the
> same socket (local nodes) will be preferred.  I think that this is
> the desired behavior in most cases.

Even if the demotion path is not really required at the moment we should
keep in mind future potential extensions. E.g. when a userspace based
balancing is to be implemented because the default behavior cannot
capture userspace policies (one example would be enforcing a
prioritization of containers when some container's demoted pages would
need to be demoted further to free up a space for a different
workload). 
 
> >> > 5) Is the demotion api restricted to multi-tier systems or any numa
> >> >    configuration allowed as well?
> >> >
> >> 
> >> demotion will of course not work on single tiered systems. The
> >> interface may return some failure on such systems or not be available
> >> at all.
> >
> > Is there any strong reason for that? We do not have any interface to
> > control NUMA balancing from userspace. Why cannot we use the interface
> > for that purpose? 
> 
> Do you mean to demote the cold pages from the specified source nodes to
> the specified target nodes in different sockets?  We don't do that to
> avoid loop in the demotion path.  If we prevent the target nodes from
> demoting cold pages to the source nodes at the same time, it seems
> doable.

Loops could be avoid by properly specifying from and to nodes if this is
going to be a fine grained interface to control demotion.
-- 
Michal Hocko
SUSE Labs
