Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFCB45DC3B
	for <lists+cgroups@lfdr.de>; Thu, 25 Nov 2021 15:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbhKYOX2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Nov 2021 09:23:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44194 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355742AbhKYOV2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Nov 2021 09:21:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D8B011FD37;
        Thu, 25 Nov 2021 14:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637849895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fckFfgFa8qXGEAjTFGoz2effd/pptP+QUjZ3+vDhTZ4=;
        b=XwqAiikMkWlu0NhIFgmkq+N1tsPjWjxOFghmi/GzBT/nXIntvExIdc1lRrbj+1pKeUt8nF
        HMIzdKRJYF/YhzdwI4k9N7ZnO+O26hw8hK/I9be3UIzLrUOjad6wTk8GXXUnZqvF9p2cPx
        +EouxiQUyqBk8AbBJs2vEZkqF4Iz9d4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9B3F2A3B84;
        Thu, 25 Nov 2021 14:18:15 +0000 (UTC)
Date:   Thu, 25 Nov 2021 15:18:11 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: reduce spinlock contention in release_pages()
Message-ID: <YZ+bI1fNpKar0bSU@dhcp22.suse.cz>
References: <20211124151915.GA6163@haolee.io>
 <YZ5o/VmU59evp65J@dhcp22.suse.cz>
 <CA+PpKPmy-u_BxYMCQOFyz78t2+3uM6nR9mQeX+MPyH6H2tOOHA@mail.gmail.com>
 <YZ8DZHERun6Fej2P@casper.infradead.org>
 <20211125080238.GA7356@haolee.io>
 <YZ9e3pzHKmn5nev0@dhcp22.suse.cz>
 <20211125123133.GA7758@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125123133.GA7758@haolee.io>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 25-11-21 12:31:33, Hao Lee wrote:
> On Thu, Nov 25, 2021 at 11:01:02AM +0100, Michal Hocko wrote:
> > On Thu 25-11-21 08:02:38, Hao Lee wrote:
> > > On Thu, Nov 25, 2021 at 03:30:44AM +0000, Matthew Wilcox wrote:
> > > > On Thu, Nov 25, 2021 at 11:24:02AM +0800, Hao Lee wrote:
> > > > > On Thu, Nov 25, 2021 at 12:31 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > We do batch currently so no single task should be
> > > > > > able to monopolize the cpu for too long. Why this is not sufficient?
> > > > > 
> > > > > uncharge and unref indeed take advantage of the batch process, but
> > > > > del_from_lru needs more time to complete. Several tasks will contend
> > > > > spinlock in the loop if nr is very large.
> > > > 
> > > > Is SWAP_CLUSTER_MAX too large?  Or does your architecture's spinlock
> > > > implementation need to be fixed?
> > > > 
> > > 
> > > My testing server is x86_64 with 5.16-rc2. The spinlock should be normal.
> > > 
> > > I think lock_batch is not the point. lock_batch only break spinning time
> > > into small parts, but it doesn't reduce spinning time. The thing may get
> > > worse if lock_batch is very small.
> > > 
> > > Here is an example about two tasks contending spinlock. Let's assume each
> > > task need a total of 4 seconds in critical section to complete its work.
> > > 
> > > Example1:
> > > 
> > > lock_batch = x
> > > 
> > > task A      taskB
> > > hold 4s     wait 4s
> > >             hold 4s
> > > 
> > > total waiting time is 4s.
> > 
> > 4s holding time is _way_ too long and something that this path should
> > never really reach. We are talking about SWAP_CLUSTER_MAX worth of LRU
> > pages. Sure there might be a bunch of pages freed that are not on LRU
> > but those are only added to a list. So again what is the actual problem?
> > 
> 
> The measurement unit in my example may not be rigorous and may confuse you.
> What I mean is the batch processing can only gives each task fairness to
> compete for this spinlock, but it can't reduce the wasted cpu cycles during
> spinning waiting, no matter what the batch size is.

Correct. But isn't that a nature of pretty much any spinlock based
contention? There is not really much to be done except for removing the
lock. Batching helps to amortize the spinning for the actual useful work
so that the spinning is not predominant. Trylocking to reduce that
spinning can be helpful only if you _know_ that other useful work could
be done and that you do not dalay the locked work way to much. This is a
tricky balance to make.

> No matter what the
> lock_batch is set, the following perf report won't change much. Many cpu
> cycles are wasted on spinning. Other tasks running on the same cores will be
> delayed, which is unacceptable for our latency-critical jobs.

Could you share more about requirements for those? Why is unmapping in
any of their hot paths which really require low latencies? Because as
long as unmapping requires a shared resource - like lru lock - then you
have a bottle necks.

> I'm trying to
> find if it's possible to reduce the delay and the contention , after all,
> 59.50% is too high. This is why I post the thoughtless `cond_resched()`
> approach.

What is the base for that 59.5%? Also how representative this is for
your sensitive workload?
 
> Here is the perf report when executing ./usemem -j 4096 -n 20 10g -s 5
> 
> +   59.50%  usemem           [kernel.vmlinux]               [k] native_queued_spin_lock_slowpath
> +    4.36%  usemem           [kernel.vmlinux]               [k] check_preemption_disabled
> +    4.31%  usemem           [kernel.vmlinux]               [k] free_pcppages_bulk
> +    3.11%  usemem           [kernel.vmlinux]               [k] release_pages
> +    2.12%  usemem           [kernel.vmlinux]               [k] __mod_memcg_lruvec_state
> +    2.02%  usemem           [kernel.vmlinux]               [k] __list_del_entry_valid
> +    1.98%  usemem           [kernel.vmlinux]               [k] __mod_node_page_state
> +    1.67%  usemem           [kernel.vmlinux]               [k] unmap_page_range
> +    1.51%  usemem           [kernel.vmlinux]               [k] __mod_zone_page_state
-- 
Michal Hocko
SUSE Labs
