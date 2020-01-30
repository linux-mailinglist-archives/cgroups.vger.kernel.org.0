Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE26514DF8A
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2020 18:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgA3RA1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jan 2020 12:00:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56207 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgA3RA0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Jan 2020 12:00:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so4551462wmj.5;
        Thu, 30 Jan 2020 09:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O19S44JgA364hfEmw1UsxeYnxuzE72hVX9NKFWCFSOg=;
        b=UfIn2y0W/9FLSRJaKMRvNvv32po7nWAFneISeoojqjfigZSHwKdN8qBEY+0720rMb5
         tXO+cRYc2R/QlSxThudfT6Xn1acmvRtswL1oWXXjNpv07y0v99DGEupTjSc2mSU0va4O
         hE5efrmyJuWL3uvrgxnzZcSohq2PMBIf28Mcngv8BWaLdZL4ryoTWWUYjsRHRrD4QnX/
         Ql0888nEha9fV0ESxcmceaddcaKx46pMZqFB06kf5unlfvk0H7gJd3y9vwsnH1oHvbxo
         rw3OjgISf7o4t+mEnJOmGQg2bwBHGqw2znfjO67i4TavMJy2QOO5Vf0zveAMfxjwRMZ7
         zTeA==
X-Gm-Message-State: APjAAAWy9jJ0DyFoi3YvjezzEKKAm+KLQ0fS2vdcWkHOuH+t+tCn+8k8
        AsVFI6FAvDL7CUksGDTG4w4=
X-Google-Smtp-Source: APXvYqwdX+hj8xuZWB1fIH0IInh2RVER3tbrowqd6kOiJs0+YGQp+XaPDGyatOBTpouCtewwfAsb6g==
X-Received: by 2002:a1c:8156:: with SMTP id c83mr6470112wmd.164.1580403622689;
        Thu, 30 Jan 2020 09:00:22 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id d14sm8428287wru.9.2020.01.30.09.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 09:00:21 -0800 (PST)
Date:   Thu, 30 Jan 2020 18:00:20 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200130170020.GZ24244@dhcp22.suse.cz>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219200718.15696-4-hannes@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 19-12-19 15:07:18, Johannes Weiner wrote:
> Right now, the effective protection of any given cgroup is capped by
> its own explicit memory.low setting, regardless of what the parent
> says. The reasons for this are mostly historical and ease of
> implementation: to make delegation of memory.low safe, effective
> protection is the min() of all memory.low up the tree.
> 
> Unfortunately, this limitation makes it impossible to protect an
> entire subtree from another without forcing the user to make explicit
> protection allocations all the way to the leaf cgroups - something
> that is highly undesirable in real life scenarios.
> 
> Consider memory in a data center host. At the cgroup top level, we
> have a distinction between system management software and the actual
> workload the system is executing. Both branches are further subdivided
> into individual services, job components etc.
> 
> We want to protect the workload as a whole from the system management
> software, but that doesn't mean we want to protect and prioritize
> individual workload wrt each other. Their memory demand can vary over
> time, and we'd want the VM to simply cache the hottest data within the
> workload subtree. Yet, the current memory.low limitations force us to
> allocate a fixed amount of protection to each workload component in
> order to get protection from system management software in
> general. This results in very inefficient resource distribution.

I do agree that configuring the reclaim protection is not an easy task.
Especially in a deeper reclaim hierarchy. systemd tends to create a deep
and commonly shared subtrees. So having a protected workload really
requires to be put directly into a new first level cgroup in practice
AFAICT. That is a simpler example though. Just imagine you want to
protect a certain user slice.

You seem to be facing a different problem though IIUC. You know how much
memory you want to protect and you do not have to care about the cgroup
hierarchy up but you do not know/care how to distribute that protection
among workloads running under that protection. I agree that this is a
reasonable usecase.

Those both problems however show that we have a more general
configurability problem for both leaf and intermediate nodes. They are
both a result of strong requirements imposed by delegation as you have
noted above. I am thinking didn't we just go too rigid here?

Delegation points are certainly a security boundary and they should
be treated like that but do we really need a strong containment when
the reclaim protection is under admin full control? Does the admin
really have to reconfigure a large part of the hierarchy to protect a
particular subtree?

I do not have a great answer on how to implement this unfortunately. The
best I could come up with was to add a "$inherited_protection" magic
value to distinguish from an explicit >=0 protection. What's the
difference? $inherited_protection would be a default and it would always
refer to the closest explicit protection up the hierarchy (with 0 as a
default if there is none defined).
        A
       / \
      B   C (low=10G)
         / \
        D   E (low = 5G)

A, B don't get any protection (low=0). C gets protection (10G) and
distributes the pressure to D, E when in excess. D inherits (low=10G)
and E overrides the protection to 5G.

That would help both usecases AFAICS while the delegation should be
still possible (configure the delegation point with an explicit
value). I have very likely not thought that through completely.  Does
that sound like a completely insane idea?

Or do you think that the two usecases are simply impossible to handle
at the same time?
[...]
-- 
Michal Hocko
SUSE Labs
