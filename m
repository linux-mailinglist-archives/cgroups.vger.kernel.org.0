Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADD14A6D3E
	for <lists+cgroups@lfdr.de>; Wed,  2 Feb 2022 09:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245199AbiBBIt1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Feb 2022 03:49:27 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54072 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbiBBItY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Feb 2022 03:49:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 432671F387;
        Wed,  2 Feb 2022 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643791763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uj3gqmhmxT0/8qIyyTuABinVyydthZchHF9YkHvzo/g=;
        b=MbQJswZIX+EiURMoKwicXpRnnLwkLLPJob3/zWIB3426QLtPskCoUmNYrTHbX3VSzGYdJ0
        UeGfP2COlUEwGoHsMc7o0vMEC32yS49Rejf7cWr+optBf+HokmCeyYQV/mwiJBu4WEg3Qf
        1bNQ8rMQolgQL+F+q2qxhoysPrGUZ1Y=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B477CA3B9A;
        Wed,  2 Feb 2022 08:49:22 +0000 (UTC)
Date:   Wed, 2 Feb 2022 09:49:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>, Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v3 3/4] mm/page_owner: Print memcg information
Message-ID: <YfpFkVLBb0GsDFsi@dhcp22.suse.cz>
References: <20220131192308.608837-1-longman@redhat.com>
 <20220131192308.608837-4-longman@redhat.com>
 <YfkRS75D3xcqLT85@dhcp22.suse.cz>
 <33be132c-874d-1061-9003-50942275b221@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33be132c-874d-1061-9003-50942275b221@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 01-02-22 12:04:37, Waiman Long wrote:
> On 2/1/22 05:54, Michal Hocko wrote:
> > On Mon 31-01-22 14:23:07, Waiman Long wrote:
> > > It was found that a number of offlined memcgs were not freed because
> > > they were pinned by some charged pages that were present. Even "echo
> > > 1 > /proc/sys/vm/drop_caches" wasn't able to free those pages. These
> > > offlined but not freed memcgs tend to increase in number over time with
> > > the side effect that percpu memory consumption as shown in /proc/meminfo
> > > also increases over time.
> > > 
> > > In order to find out more information about those pages that pin
> > > offlined memcgs, the page_owner feature is extended to print memory
> > > cgroup information especially whether the cgroup is offlined or not.
> > > 
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > Acked-by: David Rientjes <rientjes@google.com>
> > > ---
> > >   mm/page_owner.c | 39 +++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 39 insertions(+)
> > > 
> > > diff --git a/mm/page_owner.c b/mm/page_owner.c
> > > index 28dac73e0542..a471c74c7fe0 100644
> > > --- a/mm/page_owner.c
> > > +++ b/mm/page_owner.c
> > > @@ -10,6 +10,7 @@
> > >   #include <linux/migrate.h>
> > >   #include <linux/stackdepot.h>
> > >   #include <linux/seq_file.h>
> > > +#include <linux/memcontrol.h>
> > >   #include <linux/sched/clock.h>
> > >   #include "internal.h"
> > > @@ -325,6 +326,42 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
> > >   	seq_putc(m, '\n');
> > >   }
> > > +#ifdef CONFIG_MEMCG
> > > +/*
> > > + * Looking for memcg information and print it out
> > > + */
> > > +static inline void print_page_owner_memcg(char *kbuf, size_t count, int *pret,
> > > +					  struct page *page)
> > > +{
> > > +	unsigned long memcg_data = READ_ONCE(page->memcg_data);
> > > +	struct mem_cgroup *memcg;
> > > +	bool onlined;
> > > +	char name[80];
> > > +
> > > +	if (!memcg_data)
> > > +		return;
> > > +
> > > +	if (memcg_data & MEMCG_DATA_OBJCGS)
> > > +		*pret += scnprintf(kbuf + *pret, count - *pret,
> > > +				"Slab cache page\n");
> > > +
> > > +	memcg = page_memcg_check(page);
> > > +	if (!memcg)
> > > +		return;
> > > +
> > > +	onlined = (memcg->css.flags & CSS_ONLINE);
> > > +	cgroup_name(memcg->css.cgroup, name, sizeof(name));
> > > +	*pret += scnprintf(kbuf + *pret, count - *pret,
> > > +			"Charged %sto %smemcg %s\n",
> > > +			PageMemcgKmem(page) ? "(via objcg) " : "",
> > > +			onlined ? "" : "offlined ",
> > > +			name);
> > I have asked in the previous version already but what makes the memcg
> > stable (why it cannot go away and be reallocated for something else)
> > while you are trying to get its name?
> 
> The memcg is not going away as long as the page isn't freed unless if it is
> indirectly connected via objcg. Of course, there can be a race between the
> page is going to be freed while the page_owner information is being
> displayed.

Right. And that means that cgtoup_name can go off the rail and wander
through memory correct?

> One solution is to add a simple bit lock to each of the
> page_owner structure and acquire the lock when it is being written to or
> read from.

I do not really see how a bit lock could prevent memcg from going away.
On the other hand I think RCU read lock should be sufficient to keep the
memcg from going away completely.

> Anyway a lot of these debugging aids or tools don't eliminate all
> the race conditions that affect the accuracy of the displayed information. I
> can add a patch to eliminate this direct memcg race if you think this is
> necessary.

I do not mind inaccurate information. That is natural but reading
through a freed memory can be really harmfull. So this really need to be
sorted out.
-- 
Michal Hocko
SUSE Labs
