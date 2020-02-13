Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047AA15BA33
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2020 08:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbgBMHkz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Feb 2020 02:40:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39928 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbgBMHky (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Feb 2020 02:40:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so5368233wrt.6;
        Wed, 12 Feb 2020 23:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VikzcxuvzZjt5786Kga/OPgmPI0d+YsoVj/K9eGOyeU=;
        b=YgI3HI5cSF8KJ4tbw0den80EJ8B3PR1GvpLbw1XB4feFW0fhSFsYZYLGhvK29x1IK8
         m3121tX2knkWjSGTgUfuRISYxAeu4DghfGLMuv0umcjVH8xLczqTMg/MssxFDQ1wiImQ
         Pl73yTSmbHP5+2ow9hc4W4kPkqkdO/UrAPIfKhV4i8avByEnEDEDyPX9qJlXXDfUfaR7
         znkn9AXn1k2d+v+KeASI4zyo1+WzoRaL6LoGy1bY0MqiQySez+EegRGagbrJlXoy9IgC
         kvSOq2xtpLtXKZX+y1tuSl88LAKMQBV+gtlPGRRJR/OUq8Ww/6qV59DRicTigo3DZUl4
         v8tA==
X-Gm-Message-State: APjAAAX0X/JAzkcVn4SxBlXiemEVCBvtL8+mfdnskA8saQlwZcnfUoCx
        LH3euM3671z+Bi5kRQNvnpc=
X-Google-Smtp-Source: APXvYqxKmZsq/EnT/yDwMIc+CtkJTjfoRHXWLR4Gm98glFGipcPyrbjpdbh0emtezP9vHCwVFkIj9w==
X-Received: by 2002:adf:f084:: with SMTP id n4mr19962569wro.200.1581579652792;
        Wed, 12 Feb 2020 23:40:52 -0800 (PST)
Received: from localhost (ip-37-188-133-87.eurotel.cz. [37.188.133.87])
        by smtp.gmail.com with ESMTPSA id q1sm1708500wrw.5.2020.02.12.23.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 23:40:51 -0800 (PST)
Date:   Thu, 13 Feb 2020 08:40:49 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200213074049.GA31689@dhcp22.suse.cz>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200130170020.GZ24244@dhcp22.suse.cz>
 <20200203215201.GD6380@cmpxchg.org>
 <20200211164753.GQ10636@dhcp22.suse.cz>
 <20200212170826.GC180867@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212170826.GC180867@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 12-02-20 12:08:26, Johannes Weiner wrote:
> On Tue, Feb 11, 2020 at 05:47:53PM +0100, Michal Hocko wrote:
> > Unless I am missing something then I am afraid it doesn't. Say you have a
> > default systemd cgroup deployment (aka deeper cgroup hierarchy with
> > slices and scopes) and now you want to grant a reclaim protection on a
> > leaf cgroup (or even a whole slice that is not really important). All the
> > hierarchy up the tree has the protection set to 0 by default, right? You
> > simply cannot get that protection. You would need to configure the
> > protection up the hierarchy and that is really cumbersome.
> 
> Okay, I think I know what you mean. Let's say you have a tree like
> this:
> 
>                           A
>                          / \
>                         B1  B2
>                        / \   \
>                       C1 C2   C3
> 
> and there is no actual delegation point - everything belongs to the
> same user / trust domain. C1 sets memory.low to 10G, but its parents
> set nothing. You're saying we should honor the 10G protection during
> global and limit reclaims anywhere in the tree?

No, only in the C1 which sets the limit, because that is the woriking
set we want to protect.

> Now let's consider there is a delegation point at B1: we set up and
> trust B1, but not its children. What effect would the C1 protection
> have then? Would we ignore it during global and A reclaim, but honor
> it when there is B1 limit reclaim?

In the scheme with the inherited protection it would act as the gate
and require an explicit low limit setup defaulting to 0 if none is
specified.

> Doing an explicit downward propagation from the root to C1 *could* be
> tedious, but I can't think of a scenario where it's completely
> impossible. Especially because we allow proportional distribution when
> the limit is overcommitted and you don't have to be 100% accurate.

So let's see how that works in practice, say a multi workload setup
with a complex/deep cgroup hierachies (e.g. your above example). No
delegation point this time.

C1 asks for low=1G while using 500M, C3 low=100M using 80M.  B1 and
B2 are completely independent workloads and the same applies to C2 which
doesn't ask for any protection at all? C2 uses 100M. Now the admin has
to propagate protection upwards so B1 low=1G, B2 low=100M and A low=1G,
right? Let's say we have a global reclaim due to external pressure that
originates from outside of A hierarchy (it is not overcommited on the
protection).

Unless I miss something C2 would get a protection even though nobody
asked for it.

> And the clarity that comes with being explicit is an asset too,
> IMO. Since it has an effect at the reclaim level, it's not a bad thing
> to have that effect *visible* in the settings at that level as well:
> the protected memory doesn't come out of thin air, it's delegated down
> from the top where memory pressure originates.

So how are we going to deal with hierarchies where the actual workload
of interest is a leaf deeper in the hierarchy and the upper levels of
the hierarchy are shared between unrelated workloads?  Look at how
systemd organizes system into cgroups for example (slices vs. scopes)
and say you want to add a protection to a single user or a service.
 
> My patch is different. It allows a configuration that simply isn't
> possible today: protecting C1 and C2 from C3, without having to
> protect C1 and C2 from each other.
> 
> So I don't think requiring an uninterrupted, authorized chain of
> protection from the top is necessarily wrong. In fact, I think it has
> benefits. But requiring the protection chain to go all the way to the
> leaves for it to have any effect, that is a real problem, and it can't
> be worked around.

Yes I do agree that the problem you are dealing with is slightly
different. My main point was that you are already introducing a new
semantic which is not fully backward compatible and I figured we have
more problems in the area and maybe we can introduce a semantic to
handle both above mentioned scenarios while doing that.
-- 
Michal Hocko
SUSE Labs
