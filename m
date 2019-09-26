Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28864BF218
	for <lists+cgroups@lfdr.de>; Thu, 26 Sep 2019 13:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfIZLt4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Sep 2019 07:49:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:50388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfIZLt4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 26 Sep 2019 07:49:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0D1EAEEC;
        Thu, 26 Sep 2019 11:49:54 +0000 (UTC)
Date:   Thu, 26 Sep 2019 13:49:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm: Proportional memory.{low,min} reclaim
Message-ID: <20190926114953.GA1224@dhcp22.suse.cz>
References: <20190124014455.GA6396@chrisdown.name>
 <20190128210031.GA31446@castle.DHCP.thefacebook.com>
 <20190128214213.GB15349@chrisdown.name>
 <20190128215230.GA32069@castle.DHCP.thefacebook.com>
 <20190715153527.86a3f6e65ecf5d501252dbf1@linux-foundation.org>
 <20190716172459.GB16575@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716172459.GB16575@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[Hmm, this one somehow slipped through. sorry about that]

On Tue 16-07-19 13:24:59, Johannes Weiner wrote:
> On Mon, Jul 15, 2019 at 03:35:27PM -0700, Andrew Morton wrote:
> > On Mon, 28 Jan 2019 21:52:40 +0000 Roman Gushchin <guro@fb.com> wrote:
> > 
> > > > Hmm, this isn't really a common situation that I'd thought about, but it
> > > > seems reasonable to make the boundaries when in low reclaim to be between
> > > > min and low, rather than 0 and low. I'll add another patch with that. Thanks
> > >
> > > It's not a stopper, so I'm perfectly fine with a follow-up patch.
> > 
> > Did this happen?
> > 
> > I'm still trying to get this five month old patchset unstuck :(.  The
> > review status is: 
> > 
> > [1/3] mm, memcg: proportional memory.{low,min} reclaim
> > Acked-by: Johannes
> > Reviewed-by: Roman
> > 
> > [2/3] mm, memcg: make memory.emin the baseline for utilisation determination
> > Acked-by: Johannes
> > 
> > [3/3] mm, memcg: make scan aggression always exclude protection
> > Reviewed-by: Roman
> 
> I forgot to send out the actual ack-tag on #, so I just did. I was
> involved in the discussions that led to that patch, the code looks
> good to me, and it's what we've been using internally for a while
> without any hiccups.
> 
> > I do have a note here that mhocko intended to take a closer look but I
> > don't recall whether that happened.
> 
> Michal acked #3 in 20190530065111.GC6703@dhcp22.suse.cz. Afaik not the
> others, but #3 also doesn't make a whole lot of sense without #1...
> 
> > a) say what the hell and merge them or
> > b) sit on them for another cycle or
> > c) drop them and ask Chris for a resend so we can start again.
> 
> Michal, would you have time to take another look this week? Otherwise,
> I think everyone who would review them has done so.

I do not remember objecting to this particular patch. I also admit I do
not remember much about it either. I am unlikely to get to review this
in more depth these days.

It seems more people have reviewed it already so just go ahead.
-- 
Michal Hocko
SUSE Labs
