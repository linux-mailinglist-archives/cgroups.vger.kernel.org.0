Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69E22165A66
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 10:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgBTJqo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 04:46:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40325 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgBTJqo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 04:46:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so3823637wru.7;
        Thu, 20 Feb 2020 01:46:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oRcv0oZQdOVrWzd1qr9lYtPniV+jiJ713yM3v9mJOlY=;
        b=jRC5H94gY4zCIOQJxm8Qk622Y8og9gk8/ii6TNBdcpv3IOb4E3BY5Hvbfy3Dkm8fsa
         5I5gDfJ60rWQ0Xr0ZgIphujHM9EKruwZiZBZU/lkuzxPgjG2NNbxooV8mVc6kNqkeHrm
         UOirhlzVxEXBqO4ZiHJqiVkZ7yVKM3exYHL3UNP/zJB5o7xatKuMqdJgxXMvRWhy+161
         1HPRIhz0xH0NFOtDCoih8LfNjmfwEHI9YZXe1Wz9MHaFZkFSw1wW8Lh30FbUxDnFg/K3
         QdAp/A+FS7YVuC2HatQmjmBfcUwpW0Vy80ugN8m2Q/C141A0OcLXjPwa5YyZ7FNs+JeD
         cdZg==
X-Gm-Message-State: APjAAAWJL32EaVxh7Sx26DjfJk9kQWXIyvf6RAz0w87ulrSg2abf7nDD
        pL85H7e5cEFI8nSSHjeYz2g=
X-Google-Smtp-Source: APXvYqxVsZPoloFl8GWV4xlA+vljGixiQhWbtX8JzJzdcvTayL4q97ix36Y5HD94YcgGjeNyCYPj2A==
X-Received: by 2002:adf:ed8e:: with SMTP id c14mr41341248wro.80.1582192001250;
        Thu, 20 Feb 2020 01:46:41 -0800 (PST)
Received: from localhost (ip-37-188-133-21.eurotel.cz. [37.188.133.21])
        by smtp.gmail.com with ESMTPSA id h128sm4202184wmh.33.2020.02.20.01.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 01:46:40 -0800 (PST)
Date:   Thu, 20 Feb 2020 10:46:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200220094639.GD20509@dhcp22.suse.cz>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <20200219183731.GC11847@dhcp22.suse.cz>
 <20200219191618.GB54486@cmpxchg.org>
 <20200219195332.GE11847@dhcp22.suse.cz>
 <20200219211735.GD54486@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219211735.GD54486@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 19-02-20 16:17:35, Johannes Weiner wrote:
> On Wed, Feb 19, 2020 at 08:53:32PM +0100, Michal Hocko wrote:
> > On Wed 19-02-20 14:16:18, Johannes Weiner wrote:
[...]
> > > [ This is generally work in process: for example, if you isolate
> > >   workloads with memory.low, kswapd cpu time isn't accounted to the
> > >   cgroup that causes it. Swap IO issued by kswapd isn't accounted to
> > >   the group that is getting swapped.
> > 
> > Well, kswapd is a system activity and as such it is acceptable that it
> > is accounted to the system. But in this case we are talking about a
> > memcg configuration which influences all other workloads by stealing CPU
> > cycles from them 
> 
> From a user perspective this isn't a meaningful distinction.
> 
> If I partition my memory among containers and one cgroup is acting
> out, I would want the culprit to be charged for the cpu cycles the
> reclaim is causing. Whether I divide my machine up using memory.low or
> using memory.max doesn't really matter: I'm choosing between the two
> based on a *memory policy* I want to implement - work-conserving vs
> non-conserving. I shouldn't have to worry about the kernel tracking
> CPU cycles properly in the respective implementations of these knobs.
> 
> So kswapd is very much a cgroup-attributable activity, *especially* if
> I'm using memory.low to delineate different memory domains.

While I understand what you are saying I do not think this is easily
achievable with the current implementation. The biggest problem I can
see is that you do not have a clear information who to charge for
the memory shortage on a particular NUMA node with a pure low limit
based balancing because the limit is not NUMA aware. Besides that the
origin of the memory pressure might be outside of any memcg.  You can
punish/account all memcgs in excess in some manner, e.g. proportionally
to their size/excess but I am not really sure how fair that will
be. Sounds like an interesting project but also sounds like tangent to
this patch.

High/Max limits are quite different because they are dealing with
the internal memory pressure and you can attribute it to the
cgroup/hierarchy which is in excess. There is a clear domain to reclaim
from. This is an easier model to reason about IMHO.

> > without much throttling on the consumer side - especially when the
> > memory is reclaimable without a lot of sleeping or contention on
> > locks etc.
> 
> The limiting factor on the consumer side is IO. Reading a page is way
> more costly than reclaiming it, which is why we built our isolation
> stack starting with memory and IO control and are only now getting to
> working on proper CPU isolation.
> 
> > I am absolutely aware that we will never achieve a perfect isolation due
> > to all sorts of shared data structures, lock contention and what not but
> > this patch alone just allows spill over to unaccounted work way too
> > easily IMHO.
> 
> I understand your concern about CPU cycles escaping, and I share
> it. My point is that this patch isn't adding a problem that isn't
> already there, nor is it that much of a practical concern at the time
> of this writing given the state of CPU isolation in general.

I beg to differ here. Ppu controller should be able to isolate user
contexts performing high limit reclaim now. Your patch is changing that
functionality to become unaccounted for a large part and that might be
seen as a regression for those workloads which partition the system by
using high limit and also rely on cpu controller because workloads are
CPU sensitive.

Without the CPU controller support this patch is not complete and I do
not see an absolute must to marge it ASAP because it is not a regression
fix or something we cannot live without.
-- 
Michal Hocko
SUSE Labs
