Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F19A4A49CF
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 16:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiAaPGe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 10:06:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60448 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiAaPGd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 10:06:33 -0500
Date:   Mon, 31 Jan 2022 16:06:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643641592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w0NFiv/w/Cs5H22tLULVbOiZiCXLk9Q8Uppqq+mmVWE=;
        b=ITwPnNVNsBPallxs5zUMi9DOOpAhk6imEl29XzDT9MGobpamlZEVxC0uwSPXiwyoAqtOuN
        Hrwl3I5fISii+Y/OSbWmGCc6EQERKZdXnhx/vPX4nTQqUQk4qyit5lxFOo5iWifIhWj1ph
        WoTtowcpcyOyip8EKhw5RpLPnvAtJ1tjClZFVuHC9xg3yqt47DMJ+dI4GPCqXOlOkTiB5+
        HP2Nt28QdqUkdNgDhBG/SV77OyQyT1jkxb6VmdKdZ/JMkNIXqV14SVHCfEDhSZcAbv3Xuf
        YohzS0CvFocKMugUENcXzjz+0oMSMD0gLABmWKAfDXO06HABuUjiymEQtKZHfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643641592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w0NFiv/w/Cs5H22tLULVbOiZiCXLk9Q8Uppqq+mmVWE=;
        b=kDAzeZihk9torF7OFmhGe5sb/Dan/+Ie9U+8pJm4pG3edO3Y116sFbfMFGf++mfgG7JzSV
        x53bPvamwbn6AGCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/4] mm/memcg: Add a local_lock_t for IRQ and TASK object.
Message-ID: <Yff69slA4UTz5Q1Y@linutronix.de>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-4-bigeasy@linutronix.de>
 <7f4928b8-16e2-88b3-2688-1519a19653a9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f4928b8-16e2-88b3-2688-1519a19653a9@suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-01-26 17:57:14 [+0100], Vlastimil Babka wrote:
> > - drain_obj_stock() gets a memcg_stock_pcp passed if the stock_lock has been
> >   acquired (instead of the task_obj_lock) to avoid recursive locking later
> >   in refill_stock().
> 
> Looks like this was maybe true in some previous version but now
> drain_obj_stock() gets a bool parameter that is passed to
> obj_cgroup_uncharge_pages(). But drain_local_stock() uses a NULL or
> stock_pcp for that bool parameter which is weird.

buh. Sorry, that is a left over and should have been true/false instead.

> > - drain_all_stock() disables preemption via get_cpu() and then invokes
> >   drain_local_stock() if it is the local CPU to avoid scheduling a worker
> >   (which invokes the same function). Disabling preemption here is
> >   problematic due to the sleeping locks in drain_local_stock().
> >   This can be avoided by always scheduling a worker, even for the local
> >   CPU. Using cpus_read_lock() stabilizes cpu_online_mask which ensures
> >   that no worker is scheduled for an offline CPU. Since there is no
> >   flush_work(), it is still possible that a worker is invoked on the wrong
> >   CPU but it is okay since it operates always on the local-CPU data.
> > 
> > - drain_local_stock() is always invoked as a worker so it can be optimized
> >   by removing in_task() (it is always true) and avoiding the "irq_save"
> >   variant because interrupts are always enabled here. Operating on
> >   task_obj first allows to acquire the lock_lock_t without lockdep
> >   complains.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> The problem is that this pattern where get_obj_stock() sets a
> stock_lock_acquried bool and this is passed down and acted upon elsewhere,
> is a well known massive red flag for Linus :/
> Maybe we should indeed just revert 559271146efc, as Michal noted there were
> no hard numbers to justify it, and in previous discussion it seemed to
> surface that the costs of irq disable/enable are not that bad on recent cpus
> as assumed?

I added some number, fell free re-run.
Let me know if a revert is preferred or you want to keep that so that I
can prepare the patches accordingly before posting.

> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -260,8 +260,10 @@ bool mem_cgroup_kmem_disabled(void)
> >  	return cgroup_memory_nokmem;
> >  }
> >  
> > +struct memcg_stock_pcp;
> 
> Seems this forward declaration is unused.
you, thanks.

Sebastian
