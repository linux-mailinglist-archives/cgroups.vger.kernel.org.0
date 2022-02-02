Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970924A760F
	for <lists+cgroups@lfdr.de>; Wed,  2 Feb 2022 17:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbiBBQiK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Feb 2022 11:38:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56236 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbiBBQiJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Feb 2022 11:38:09 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2941721100;
        Wed,  2 Feb 2022 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643819888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ovtEFN3zyuhZ84VATTXxeaX4XxbwY8ky/fQzl6DC/1E=;
        b=VbieOmiRhqEU6RioiXSYtTXq1pkpEM59XXP4jKGogGC6DPO62BFtWfjW0oxah/XnG4ZUpr
        fVcilnkkpeLfnCDqL24v6MCv/f+OzRTkaH1XJ7IPGKFxSvII98y0Pztp7ZHSXVDOgIndiB
        B908vNICOfe2bWd7yPqAP6oCJuqr0bA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 98642A3B8E;
        Wed,  2 Feb 2022 16:38:07 +0000 (UTC)
Date:   Wed, 2 Feb 2022 17:38:07 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 3/3] mm/page_owner: Dump memcg information
Message-ID: <YfqzbwAPKpshXSLK@dhcp22.suse.cz>
References: <20220129205315.478628-4-longman@redhat.com>
 <YfeuK5j7cbgM+Oo+@dhcp22.suse.cz>
 <YfgT/9tEREQNiiAN@cmpxchg.org>
 <YfgnUZQBRkqhrEIb@carbon.dhcp.thefacebook.com>
 <Yfgpknwr1tMnPkqh@dhcp22.suse.cz>
 <12686956-612d-d89b-5641-470d5e913090@redhat.com>
 <YfkQJ4QhfY0dICB9@dhcp22.suse.cz>
 <268a8bdf-4c70-b967-f34c-2293b54186f0@redhat.com>
 <YfpHbtffFi2x1L4p@dhcp22.suse.cz>
 <YfqpSPLC+LAdqbJX@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfqpSPLC+LAdqbJX@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 02-02-22 07:54:48, Roman Gushchin wrote:
> On Wed, Feb 02, 2022 at 09:57:18AM +0100, Michal Hocko wrote:
> > On Tue 01-02-22 11:41:19, Waiman Long wrote:
> > > 
> > > On 2/1/22 05:49, Michal Hocko wrote:
> > [...]
> > > > Could you be more specific? Offlined memcgs are still part of the
> > > > hierarchy IIRC. So it shouldn't be much more than iterating the whole
> > > > cgroup tree and collect interesting data about dead cgroups.
> > > 
> > > What I mean is that without piggybacking on top of page_owner, we will to
> > > add a lot more code to collect and display those information which may have
> > > some overhead of its own.
> > 
> > Yes, there is nothing like a free lunch. Page owner is certainly a tool
> > that can be used. My main concern is that this tool doesn't really
> > scale on large machines with a lots of memory. It will provide a very
> > detailed information but I am not sure this is particularly helpful to
> > most admins (why should people process tons of allocation backtraces in
> > the first place). Wouldn't it be sufficient to have per dead memcg stats
> > to see where the memory sits?
> > 
> > Accumulated offline memcgs is something that bothers more people and I
> > am really wondering whether we can do more for those people to evaluate
> > the current state.
> 
> Cgroup v2 has corresponding counters for years. Or do you mean something different?

Do we have anything more specific than nr_dying_descendants? I was
thinking about an interface which would provide paths and stats for dead
memcgs. But I have to confess I haven't really spent much time thinking
about how much work that would be. I am by no means against adding memcg
information to the page owner. I just think there must be a better way
to present resource consumption by dead memcgs.

-- 
Michal Hocko
SUSE Labs
