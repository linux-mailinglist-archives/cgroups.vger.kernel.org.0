Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14983157EA5
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2020 16:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBJPVw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Feb 2020 10:21:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32810 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgBJPVw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Feb 2020 10:21:52 -0500
Received: by mail-qk1-f194.google.com with SMTP id h4so6894468qkm.0
        for <cgroups@vger.kernel.org>; Mon, 10 Feb 2020 07:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0XzNCGsvm2JX9H67Z4jya19LdAjGhytD7UpOs0ymlZ8=;
        b=x1r6/ks2nsChRD7SWchka27jTZGIyNr3vY4salP/P1gehOC1RkWIGi90cn3yO+oFna
         +afMAQEQloqw20jJBrt5H5tCsXq/5FwWgd1YI7F9GJNpry8AOBY5NhJ2+9YDfwd7B1CR
         lreE5KocaMp73iX6bjf8vViNeC2jYfSJQWR/HGfYufuwO0hGSgTcpqKhJ8rNPzBx6h2O
         tzAiyeJMvYFpB5DIjUa90Q5KWPmutUZXODnSEzPzz6qDu/q5G3TWFxuV4stNvaANdhMg
         C2nYEvW361zdMMMvk1/SezYxvq/eoDCqnnQYGOiPbJCYZW3r5l82nNyLIhy7SF3pqNZy
         1wJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0XzNCGsvm2JX9H67Z4jya19LdAjGhytD7UpOs0ymlZ8=;
        b=HDZgFetY5+dG/XAuklWaLX1l2pv5TH3j0T6ujYLL92+VmFNlxcmqjceV4m1GHFkNTi
         bh0ShVVT08fpRr/tP2lBAYgV8opdEp+hjIJuoaMHLOQUSzrifLH5eQzKQ/KUPfnrky2h
         xLMEK+uW7edDLt07yF2bRvFX9HrwgnzvZDsJM0a1BxW1DvDmZavg1vzJh7ORQ53fj/ow
         LaVW/9uCR3NpUfogNnz3NmVmAzGMrqE1xHuDHGvgl8xJwKEZgBP5pmFfInFTBoAGB2S8
         KfFXco9c36VZRq2HC+7bsVquXDRZK89DmN9eN4P1HMuz/vKkRSF98RLjocxH36Yi1EYN
         fA2A==
X-Gm-Message-State: APjAAAXrFVx/Q8Ni57E+cxdfhkbcmogMQKX2GKEbAxcffM/Q3ZnC93wL
        aEZpEqJ80+SfJ68reJ48/8b6sYd1gXY=
X-Google-Smtp-Source: APXvYqyDnv0Aac60gNb+uupk0XNe+AUl5C8UNnXuzAXGxV7p4OVsT4AUrwUNZ3QnRVcEnLFCCbaeCA==
X-Received: by 2002:ae9:f80d:: with SMTP id x13mr1801792qkh.226.1581348110945;
        Mon, 10 Feb 2020 07:21:50 -0800 (PST)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id a145sm277397qkg.128.2020.02.10.07.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 07:21:50 -0800 (PST)
Date:   Mon, 10 Feb 2020 10:21:49 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200210152149.GA1588@cmpxchg.org>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200130170020.GZ24244@dhcp22.suse.cz>
 <20200203215201.GD6380@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203215201.GD6380@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

did you have any more thoughts on this?

On Mon, Feb 03, 2020 at 04:52:02PM -0500, Johannes Weiner wrote:
> On Thu, Jan 30, 2020 at 06:00:20PM +0100, Michal Hocko wrote:
> > On Thu 19-12-19 15:07:18, Johannes Weiner wrote:
> > > Right now, the effective protection of any given cgroup is capped by
> > > its own explicit memory.low setting, regardless of what the parent
> > > says. The reasons for this are mostly historical and ease of
> > > implementation: to make delegation of memory.low safe, effective
> > > protection is the min() of all memory.low up the tree.
> > > 
> > > Unfortunately, this limitation makes it impossible to protect an
> > > entire subtree from another without forcing the user to make explicit
> > > protection allocations all the way to the leaf cgroups - something
> > > that is highly undesirable in real life scenarios.
> > > 
> > > Consider memory in a data center host. At the cgroup top level, we
> > > have a distinction between system management software and the actual
> > > workload the system is executing. Both branches are further subdivided
> > > into individual services, job components etc.
> > > 
> > > We want to protect the workload as a whole from the system management
> > > software, but that doesn't mean we want to protect and prioritize
> > > individual workload wrt each other. Their memory demand can vary over
> > > time, and we'd want the VM to simply cache the hottest data within the
> > > workload subtree. Yet, the current memory.low limitations force us to
> > > allocate a fixed amount of protection to each workload component in
> > > order to get protection from system management software in
> > > general. This results in very inefficient resource distribution.
> > 
> > I do agree that configuring the reclaim protection is not an easy task.
> > Especially in a deeper reclaim hierarchy. systemd tends to create a deep
> > and commonly shared subtrees. So having a protected workload really
> > requires to be put directly into a new first level cgroup in practice
> > AFAICT. That is a simpler example though. Just imagine you want to
> > protect a certain user slice.
> 
> Can you elaborate a bit on this? I don't quite understand the two
> usecases you are contrasting here.
> 
> > You seem to be facing a different problem though IIUC. You know how much
> > memory you want to protect and you do not have to care about the cgroup
> > hierarchy up but you do not know/care how to distribute that protection
> > among workloads running under that protection. I agree that this is a
> > reasonable usecase.
> 
> I'm not sure I'm parsing this right, but the use case is this:
> 
> When I'm running a multi-component workload on a host without any
> cgrouping, the individual components compete over the host's memory
> based on rate of allocation, how often they reference their memory and
> so forth. It's a need-based distribution of pages, and the weight can
> change as demand changes throughout the life of the workload.
> 
> If I now stick several of such workloads into a containerized
> environment, I want to use memory.low to assign each workload as a
> whole a chunk of memory it can use - I don't want to assign fixed-size
> subchunks to each individual component of each workload! I want the
> same free competition *within* the workload while setting clear rules
> for competition *between* the different workloads.
> 
> [ What I can do today to achieve this is disable the memory controller
>   for the subgroups. When I do this, all pages of the workload are on
>   one single LRU that is protected by one single memory.low.
> 
>   But obviously I lose any detailed accounting as well.
> 
>   This patch allows me to have the same recursive protection semantics
>   while retaining accounting. ]
> 
> > Those both problems however show that we have a more general
> > configurability problem for both leaf and intermediate nodes. They are
> > both a result of strong requirements imposed by delegation as you have
> > noted above. I am thinking didn't we just go too rigid here?
> 
> The requirement for delegation is that child groups cannot claim more
> than the parent affords. Is that the restriction you are referring to?
> 
> > Delegation points are certainly a security boundary and they should
> > be treated like that but do we really need a strong containment when
> > the reclaim protection is under admin full control? Does the admin
> > really have to reconfigure a large part of the hierarchy to protect a
> > particular subtree?
> > 
> > I do not have a great answer on how to implement this unfortunately. The
> > best I could come up with was to add a "$inherited_protection" magic
> > value to distinguish from an explicit >=0 protection. What's the
> > difference? $inherited_protection would be a default and it would always
> > refer to the closest explicit protection up the hierarchy (with 0 as a
> > default if there is none defined).
> >         A
> >        / \
> >       B   C (low=10G)
> >          / \
> >         D   E (low = 5G)
> > 
> > A, B don't get any protection (low=0). C gets protection (10G) and
> > distributes the pressure to D, E when in excess. D inherits (low=10G)
> > and E overrides the protection to 5G.
> > 
> > That would help both usecases AFAICS while the delegation should be
> > still possible (configure the delegation point with an explicit
> > value). I have very likely not thought that through completely.  Does
> > that sound like a completely insane idea?
> > 
> > Or do you think that the two usecases are simply impossible to handle
> > at the same time?
> 
> Doesn't my patch accomplish this?
> 
> Any cgroup or group of cgroups still cannot claim more than the
> ancestral protection for the subtree. If a cgroup says 10G, the sum of
> all children's protection will never exceed that. This ensures
> delegation is safe.
> 
> But once an ancestor does declare protection, that value automatically
> applies recursively to the entire subtree. The subtree can *chose* to
> assign fixed shares of that to its cgroups. But it doesn't have to.
> 
> While designing this, I also thought about a new magic token for the
> memory.low to distinguish "inherit" from 0 (or other values smaller
> than what the parent affords). But the only thing it buys you is that
> you allow children to *opt out* of protection the parent prescribes.
> And I'm not sure that's a valid usecase: If the parent specifies that
> a subtree shall receive a protection of 10G compared to other subtrees
> at that level, does it really make sense for children to opt out and
> reduce the subtree's protection?
> 
> IMO, no. A cgroup should be able to influence competition among its
> children, it should not be able to change the rules of competition
> among its ancestors.
