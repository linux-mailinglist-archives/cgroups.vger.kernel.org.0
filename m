Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A2D168490
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2020 18:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgBURM6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Feb 2020 12:12:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:39640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgBURM6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 21 Feb 2020 12:12:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 76F9BAC37;
        Fri, 21 Feb 2020 17:12:57 +0000 (UTC)
Date:   Fri, 21 Feb 2020 18:12:56 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200221171256.GB23476@blackbody.suse.cz>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219200718.15696-4-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 19, 2019 at 03:07:18PM -0500, Johannes Weiner <hannes@cmpxchg.org> wrote:
> Unfortunately, this limitation makes it impossible to protect an
> entire subtree from another without forcing the user to make explicit
> protection allocations all the way to the leaf cgroups - something
> that is highly undesirable in real life scenarios.
I see that the jobs in descedant cgroups don't know (or care) what
protection is above them and hence the implicit distribution is sensible
here.

However, the protection your case requires can already be reached thanks
to the the hierachical capping and overcommit normalization -- you can
set memory.low to "max" at all the non-caring descendants.
IIUC, that is the same as setting zeroes (after your patch) and relying
on the recursive distribution of unused protection -- or is there a
mistake in my reasoning?

So in my view, the recursive distribution doesn't bring anything new,
however, its new semantics of memory.low doesn't allow turning the
protection off in a protected subtree (delegating the decision to
distribute protection within parent bounds is IMO a valid use case).

Regards,
Michal
