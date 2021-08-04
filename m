Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3F73DFCF7
	for <lists+cgroups@lfdr.de>; Wed,  4 Aug 2021 10:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbhHDIdz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Aug 2021 04:33:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56044 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbhHDIdz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Aug 2021 04:33:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C95182010B;
        Wed,  4 Aug 2021 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628066021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8fZuu5IPh8/NDuL9TS9G3aL/MepY8Xyguc7Af8DztIg=;
        b=ouxwYpdxC1RedfFp8dj0o3PNLQCFDo9OUoIE7ySDg/ScOugzvVH0ZKfgL4NMwE/lCvtVat
        LPIEqispUA9aIH2ESfpT3QYs1eQEEC/YhjAYan/dVOC9c9eEiPuVyfJNyvaOoSuS81rgzT
        J5Y4CLyDH2KnTqWZVkfZB0LHCTFyGQM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 44DFBA3B89;
        Wed,  4 Aug 2021 08:33:41 +0000 (UTC)
Date:   Wed, 4 Aug 2021 10:33:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Luis Goncalves <lgoncalv@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/memcg: Disable task obj_stock for PREEMPT_RT
Message-ID: <YQpQ43VrlqsOhXKd@dhcp22.suse.cz>
References: <20210803175519.22298-1-longman@redhat.com>
 <87h7g62jxm.ffs@tglx>
 <93dfe0d4-c687-93f8-da75-c5d3c9bd0ac7@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93dfe0d4-c687-93f8-da75-c5d3c9bd0ac7@suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 04-08-21 09:39:23, Vlastimil Babka wrote:
> On 8/4/21 1:21 AM, Thomas Gleixner wrote:
> > 	/*
> > 	 * The only protection from memory hotplug vs. drain_stock races is
> > 	 * that we always operate on local CPU stock here with IRQ disabled
> > 	 */
> > -	local_irq_save(flags);
> > +	local_lock_irqsave(memcg_stock_lock, flags);
> >         ...
> > 	if (use_task_obj_stock())
> >   		drain_obj_stock(&stock->task_obj);
> > 
> > which is incomprehensible garbage.
> > 
> > The comment above the existing local_irq_save() is garbage w/o any local
> > lock conversion already today (and even before the commit which
> > introduced stock::task_obj) simply because that comment does not explain
> > the why.
> 
> Michal, this seems to be your comment from commit 72f0184c8a00 ("mm, memcg:
> remove hotplug locking from try_charge"). Was "memory hotplug" a mistake,
> because the rest of the commit is about cpu hotplug, and I don't really see a
> memory hotplug connection there?

This part of the changelog tried to explain that part IIRC
"
    We can get rid of {get,put}_online_cpus, fortunately.  We do not have to
    be worried about races with memory hotplug because drain_local_stock,
    which is called from both the WQ draining and the memory hotplug
    contexts, is always operating on the local cpu stock with IRQs disabled.
"

Now I have to admit I do not remember all the details and from a quick
look the memory hotplug doesn't seem to be draining memcg pcp stock.
Maybe this has been removed since then. The only stock draining outside
of the memcg code seems to be memcg_hotplug_cpu_dead callback. That
would indicate that I really meant the cpu hotplug here indeed.

-- 
Michal Hocko
SUSE Labs
