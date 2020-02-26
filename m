Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 090B716FFD9
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2020 14:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgBZNWr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Feb 2020 08:22:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:37544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgBZNWr (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Feb 2020 08:22:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33620B18D;
        Wed, 26 Feb 2020 13:22:45 +0000 (UTC)
Date:   Wed, 26 Feb 2020 14:22:37 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200226132237.GA16746@blackbody.suse.cz>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200221171256.GB23476@blackbody.suse.cz>
 <20200221185839.GB70967@cmpxchg.org>
 <20200225133720.GA6709@blackbody.suse.cz>
 <20200225150304.GA10257@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225150304.GA10257@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello
and thanks for continuing the debate.

On Tue, Feb 25, 2020 at 10:03:04AM -0500, Johannes Weiner <hannes@cmpxchg.org> wrote:
> By origin protection I mean protection [...]
> If global reclaim occurs, [...]
> However, if limit reclaim in A occurs due to the 12G max limit [...]
My previous thinking was too bound to the absolute/global POV. Hence,
effectiveness of memory.low is relative to reclaim origin:
- full value -- protection against siblings (i.e. limit in parent).
- reduced value (share) -- protection against (great)-uncles (i.e. limit in
  (great)-grandparent).

(And depending on the absolute depth, it means respective protection
against global reclaim too.)

I see this didn't change since the original implementation w/out
effective protections. So it was just me being confused that protection
can be overcommited locally (but not globally/at higher level, so it's
consistent).

> That hinges on whether an opt-out mechanism makes sense, and we
> disagree on that part.
After my correction above, the calculation I had proposed would reduce
protection unnecessarily for reclaims triggered by nearby limits.

> > Simplest approach would be likely to introduce the special "inherit"
> > value (such a literal name may be misleading as it would be also
> > "dont-care").
> 
> Again, a complication of the interface for *everybody* 
Not if the special value is the new default (alas, that would still need
the mount option).


> Can you explain why you think protection is different from a weight?
- weights are dimension-less, they represent no real resource
- sum of sibling weights is meaningless (and independent from parent
  weight)
- to me this protection is closer to limits (actually I like your simile
  that they're very lazily enforced limits)

> Both specify a minimum amount of a resource that the cgroup can use
> under contention, while allowing the cgroup to use more than that
> share if there is no contention with siblings.
>
> You configure memory in bytes instead of a relative proportion, but
> that's only because bytes are a natural unit of memory whereas a
> relative proportion of time is a natural unit of CPU and IO.
Weights specify ratio (between siblings), not the amount. Single weight
is meaningless, (the meaningful proportion would be the fraction from
cpu.max, i.e. relative to absolute resource).

With weights, non-competing siblings drop out of denominator,
with protection, non-competing siblings (in the sense of not consuming
their allowance) may add resource back to the pool (given by parent).

> For example, if you assign a share of CPU or IO to a subtree, that
> applies to the entire subtree. Nobody has proposed being able to
> opt-out of shares in a subtree, let alone forcing individual cgroups
> to *opt-in* to receive these shares.
The former is because it makes no sense to deny all CPU/IO, the latter
consequence of that too.

> Now you apply memory pressure, what happens?. D isn't reclaimed, C is
> somewhat reclaimed, E is reclaimed hard. D will not page, C will page
> a little bit, E will page hard *with the higher IO priority of B*.
> 
> Now C is stuck behind E. This is a priority inversion.
This is how I understand the weights to work.

    A				
    `- B		io.weight=200
       `- D		io.weight=100 (e.g.)
       `- E		io.weight=100 (e.g.)
    `- C		io.weight=50

Whatever weights I assign to D and E, when only E and C compete, E will
have higher weight (200 to 50, work-conservacy of weights).

I don't think this inversion is wrong because E's work is still on
behalf of B.

Or did you mean that if protections were transformed (via effective
calculation) to have ratios only in the same range as io.weights
(1e-4..1e4 instead of 0..inf), then it'd prevent the inversion? (By
setting D,E weights in same ratios as D,E protections.)

> 1. Can you please make a practical use case for having scape goats or
>    donor groups to justify retaining what I consider to be an
>    unimportant artifact in the memory.low semantics?
    A.low=10G
    `- B.low=X   u=6G
    `- C.low=X   u=4G
    `- D.low=0G  u=5G

B,C   run the workload which should be protected
D     runs job that doesn't need any protection 
u     denotes usage
(I made the example with more than one important sibling to illustrate
usefulness of some implicit distribution X.)

When outer reclaim comes, reclaiming from B,C would be detrimental to
their performance, while impact on D is unimportant. (And induced IO
load on the rest (out of A) too.)

It's not possible to move D to the A's level, since only A is all what a
given user can control.

> 2. If you think opting out of hierarchically assigned resources is a
>    fundamentally important usecase, can you please either make an
>    argument why it should also apply to CPU and IO, or alternatively
>    explain in detail why they are meaningfully different?
I'd say that protected memory is a disposable resource in contrast with
CPU/IO. If you don't have latter, you don't progress; if you lack the
former, you are refaulting but can make progress. Even more, you should
be able to give up memory.min.

Michal
