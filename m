Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D58121833
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2019 14:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfEQMdN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 08:33:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:59664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728365AbfEQMdN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 17 May 2019 08:33:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D0C2AF7C;
        Fri, 17 May 2019 12:33:11 +0000 (UTC)
Date:   Fri, 17 May 2019 14:33:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, mm-commits@vger.kernel.org,
        tj@kernel.org, guro@fb.com, dennis@kernel.org,
        chris@chrisdown.name,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: + mm-consider-subtrees-in-memoryevents.patch added to -mm tree
Message-ID: <20190517123310.GI6836@dhcp22.suse.cz>
References: <20190212224542.ZW63a%akpm@linux-foundation.org>
 <20190213124729.GI4525@dhcp22.suse.cz>
 <20190516175655.GA25818@cmpxchg.org>
 <20190516180932.GA13208@dhcp22.suse.cz>
 <20190516193943.GA26439@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516193943.GA26439@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 16-05-19 15:39:43, Johannes Weiner wrote:
> On Thu, May 16, 2019 at 08:10:42PM +0200, Michal Hocko wrote:
> > On Thu 16-05-19 13:56:55, Johannes Weiner wrote:
> > > On Wed, Feb 13, 2019 at 01:47:29PM +0100, Michal Hocko wrote:
[...]
> > > > FTR: As I've already said here [1] I can live with this change as long
> > > > as there is a larger consensus among cgroup v2 users. So let's give this
> > > > some more time before merging to see whether there is such a consensus.
> > > > 
> > > > [1] http://lkml.kernel.org/r/20190201102515.GK11599@dhcp22.suse.cz
> > > 
> > > It's been three months without any objections.
> > 
> > It's been three months without any _feedback_ from anybody. It might
> > very well be true that people just do not read these emails or do not
> > care one way or another.
> 
> This is exactly the type of stuff that Mel was talking about at LSFMM
> not even two weeks ago. How one objection, however absurd, can cause
> "controversy" and block an effort to address a mistake we have made in
> the past that is now actively causing problems for real users.
> 
> And now after stalling this fix for three months to wait for unlikely
> objections, you're moving the goal post. This is frustrating.

I see your frustration but I find the above wording really unfair. Let me
remind you that this is a considerable user visible change in the
semantic and that always has to be evaluated carefuly. A change that would
clearly regress anybody who rely on the current semantic. This is not an
internal implementation detail kinda thing.

I have suggested an option for the new behavior to be opt-in which
would be a regression safe option. You keep insisting that we absolutely
have to have hierarchical reporting by default for consistency reasons.
I do understand that argument but when I weigh consistency vs. potential
regression risk I rather go a conservative way. This is a traditional
way how we deal with semantic changes like this. There are always
exceptions possible and that is why I wanted to hear from other users of
cgroup v2, even from those who are not directly affected now.

If you feel so stronly about this topic and the suggested opt-in is an
absolute no-go then you are free to override my opinion here. I haven't
Nacked this patch.

> Nobody else is speaking up because the current user base is very small
> and because the idea that anybody has developed against and is relying
> on the current problematic behavior is completely contrived. In
> reality, the behavior surprises people and causes production issues.

I strongly suspect users usually do not follow discussions on our
mailing lists. They only come up later when something breaks and that
is too late. I do realize that this makes the above call for a wider
consensus harder but a lack of upstream bug reports also suggests that
people do not care or simply haven't noticed any issues due to way how
they use the said interface (maybe deeper hierarchies are not that
common).

> > > Can we merge this for
> > > v5.2 please? We still have users complaining about this inconsistent
> > > behavior (the last one was yesterday) and we'd rather not carry any
> > > out of tree patches.
> > 
> > Could you point me to those complains or is this something internal?
> 
> It's something internal, unfortunately, or I'd link to it.
> 
> In this report yesterday, the user missed OOM kills that occured in
> nested subgroups of individual job components. They monitor the entire
> job status and health at the top-level "job" cgroup: total memory
> usage, VM activity and trends from memory.stat, pressure for cpu, io,
> memory etc. All of these are recursive. They assumed they could
> monitor memory.events likewise and were left in the assumption that
> everything was fine when in reality there was OOM killing going on in
> one of the leaves.

This kind of argument has been already mentioned during the discussion
and I understand it.
-- 
Michal Hocko
SUSE Labs
