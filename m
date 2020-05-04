Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CECB1C3394
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2020 09:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEDHXt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 03:23:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45625 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgEDHXs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 03:23:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so736430wro.12;
        Mon, 04 May 2020 00:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h1ingnCqfP1NmzgaKlFt/8G2H7C1Nvk+u23vCUoHbec=;
        b=eDh4JiLmuKYrUxo16xxz/qZcPcEQ/bBMEV2zElJS2ZmtgFjwwhb/0y7kUxqDQJAMJT
         S2nPxhOex6pUkjYODws9rZRoH5WcsX+4Tnn6dqVx+yYeMgPoP2bpqR0E7I+2cCxiw8rE
         UFdcoBTfH4zACtf+Oy1ByPtOo1uwUoXepb5D7SJO3gizrFtf9AXGymFmDXVW5wpMg05p
         pNxTtqd5mSoekPwn8hfygXqQgdHll6EN1qOm9+LtJ+EkTAv+4NZGW/UHjHPOskI1bbRk
         y9+0ImjnTSDEtkCIcWkm7D+MMsZtLyrWC9A8ddBEbI0uLieGG5e5iCynkNWMU5Z1mIeC
         XqRw==
X-Gm-Message-State: AGi0PuYCtI+tQ+6dytnW2s9wtd032lf/iYs21YAlOM80tClewxQq/68W
        cGa/WZ2ZtRQBNVtICme0Mts=
X-Google-Smtp-Source: APiQypLIjftj5bfi0FJoyciwli5Lgm8Xiw3xiCNELKq9S06y0FkVAki+ByzIYMpffY1AmGghWFeFEg==
X-Received: by 2002:adf:ed07:: with SMTP id a7mr18156096wro.2.1588577024655;
        Mon, 04 May 2020 00:23:44 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id f23sm11550652wml.4.2020.05.04.00.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 00:23:43 -0700 (PDT)
Date:   Mon, 4 May 2020 09:23:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
Message-ID: <20200504072342.GD22838@dhcp22.suse.cz>
References: <cover.1588092152.git.chris@chrisdown.name>
 <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
 <20200429101510.GA28637@dhcp22.suse.cz>
 <20200429140330.GA5054@cmpxchg.org>
 <20200429150414.GI28637@dhcp22.suse.cz>
 <20200429165627.GA24768@cmpxchg.org>
 <20200430145721.GF12655@dhcp22.suse.cz>
 <CALOAHbBub_oojkb5DpXUoHV=-e9PDAeVzJvKvDtyk-9Jg6_Pkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbBub_oojkb5DpXUoHV=-e9PDAeVzJvKvDtyk-9Jg6_Pkw@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 01-05-20 07:59:57, Yafang Shao wrote:
> On Thu, Apr 30, 2020 at 10:57 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 29-04-20 12:56:27, Johannes Weiner wrote:
> > [...]
> > > I think to address this, we need a more comprehensive solution and
> > > introduce some form of serialization. I'm not sure yet how that would
> > > look like yet.
> >
> > Yeah, that is what I've tried to express earlier and that is why I would
> > rather go with an uglier workaround for now and think about a more
> > robust effective values calculation on top.
> >
> 
> Agreed.
> If there's a more robust effective values calculation on top, then we
> don't need to hack it here and there.
> 
> > > I'm still not sure it's worth having a somewhat ugly workaround in
> > > mem_cgroup_protection() to protect against half of the bug. If you
> > > think so, the full problem should at least be documented and marked
> > > XXX or something.
> >
> > Yes, this makes sense to me. What about the following?
> 
> Many thanks for the explaination on this workaround.
> With this explanation, I think the others will have a clear idea why
> we must add this ugly workaround here.

OK, this would be the patch with the full changelog. If both Chris and
Johannes are ok with this I would suggest replacing the one Andrew took
already


From dfcdbfd336d2d23195ec9d90e6e58898f49f8998 Mon Sep 17 00:00:00 2001
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 4 May 2020 09:10:03 +0200
Subject: [PATCH] mm, memcg: Avoid stale protection values when cgroup is above
 protection

A cgroup can have both memory protection and a memory limit to isolate
it from its siblings in both directions - for example, to prevent it
from being shrunk below 2G under high pressure from outside, but also
from growing beyond 4G under low pressure.

Commit 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
implemented proportional scan pressure so that multiple siblings in
excess of their protection settings don't get reclaimed equally but
instead in accordance to their unprotected portion.

During limit reclaim, this proportionality shouldn't apply of course:
there is no competition, all pressure is from within the cgroup and
should be applied as such. Reclaim should operate at full efficiency.

However, mem_cgroup_protected() never expected anybody to look at the
effective protection values when it indicated that the cgroup is above
its protection. As a result, a query during limit reclaim may return
stale protection values that were calculated by a previous reclaim cycle
in which the cgroup did have siblings.

When this happens, reclaim is unnecessarily hesitant and potentially
slow to meet the desired limit. In theory this could lead to premature
OOM kills, although it's not obvious this has occurred in practice.

Workaround the problem by special casing reclaim roots in
mem_cgroup_protection. These memcgs are never participating in the
reclaim protection because the reclaim is internal.

We have to ignore effective protection values for reclaim roots because
mem_cgroup_protected might be called from racing reclaim contexts with
different roots. Calculation is relying on root -> leaf tree traversal
therefore top-down reclaim protection invariants should hold. The only
exception is the reclaim root which should have effective protection set
to 0 but that would be problematic for the following setup:
 Let's have global and A's reclaim in parallel:
  |
  A (low=2G, usage = 3G, max = 3G, children_low_usage = 1.5G)
  |\
  | C (low = 1G, usage = 2.5G)
  B (low = 1G, usage = 0.5G)

 for A reclaim we have
 B.elow = B.low
 C.elow = C.low

 For the global reclaim
 A.elow = A.low
 B.elow = min(B.usage, B.low) because children_low_usage <= A.elow
 C.elow = min(C.usage, C.low)

 With the effective values resetting we have A reclaim
 A.elow = 0
 B.elow = B.low
 C.elow = C.low

 and global reclaim could see the above and then
 B.elow = C.elow = 0 because children_low_usage > A.elow

Which means that protected memcgs would get reclaimed.

In future we would like to make mem_cgroup_protected more robust against
racing reclaim contexts but that is likely more complex solution that
this simple workaround.

[hannes@cmpxchg.org - large part of the changelog]
[mhocko@suse.com - workaround explanation]
Fixes: 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/memcontrol.h | 36 ++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c            |  8 ++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1b4150ff64be..50ffbc17cdd8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -350,6 +350,42 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
 	if (mem_cgroup_disabled())
 		return 0;
 
+	/*
+	 * There is no reclaim protection applied to a targeted reclaim.
+	 * We are special casing this specific case here because
+	 * mem_cgroup_protected calculation is not robust enough to keep
+	 * the protection invariant for calculated effective values for
+	 * parallel reclaimers with different reclaim target. This is
+	 * especially a problem for tail memcgs (as they have pages on LRU)
+	 * which would want to have effective values 0 for targeted reclaim
+	 * but a different value for external reclaim.
+	 *
+	 * Example
+	 * Let's have global and A's reclaim in parallel:
+	 *  |
+	 *  A (low=2G, usage = 3G, max = 3G, children_low_usage = 1.5G)
+	 *  |\
+	 *  | C (low = 1G, usage = 2.5G)
+	 *  B (low = 1G, usage = 0.5G)
+	 *
+	 * For the global reclaim
+	 * A.elow = A.low
+	 * B.elow = min(B.usage, B.low) because children_low_usage <= A.elow
+	 * C.elow = min(C.usage, C.low)
+	 *
+	 * With the effective values resetting we have A reclaim
+	 * A.elow = 0
+	 * B.elow = B.low
+	 * C.elow = C.low
+	 *
+	 * If the global reclaim races with A's reclaim then
+	 * B.elow = C.elow = 0 because children_low_usage > A.elow)
+	 * is possible and reclaiming B would be violating the protection.
+	 *
+	 */
+	if (memcg == root)
+		return 0;
+
 	if (in_low_reclaim)
 		return READ_ONCE(memcg->memory.emin);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 05b4ec2c6499..df88a22f09bc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6385,6 +6385,14 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 
 	if (!root)
 		root = root_mem_cgroup;
+
+	/*
+	 * Effective values of the reclaim targets are ignored so they
+	 * can be stale. Have a look at mem_cgroup_protection for more
+	 * details.
+	 * TODO: calculation should be more robust so that we do not need
+	 * that special casing.
+	 */
 	if (memcg == root)
 		return MEMCG_PROT_NONE;
 
-- 
2.25.1

-- 
Michal Hocko
SUSE Labs
