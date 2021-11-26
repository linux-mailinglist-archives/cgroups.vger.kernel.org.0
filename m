Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A9E45EBE2
	for <lists+cgroups@lfdr.de>; Fri, 26 Nov 2021 11:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhKZKvo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Nov 2021 05:51:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33162 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhKZKtn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Nov 2021 05:49:43 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8E47A2191E;
        Fri, 26 Nov 2021 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637923589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9YdYQ/QDOZ9ujDOWQAlnJ0DA9EtWFPO4uXJDqWq55J8=;
        b=CVDzatEG+gWBqlCmhrJjzygJY+XwRfcK07I1UtlWI05DnbvL1DSrHPfAElyHrj4Ycr6QLt
        uweguk+nnzzfJjyGyX81qA8AH9BSS1VPauDyTa30l3lJwy/s1pSZdWw2tGzHPKs7ughFGJ
        wnne3H49SvTo+whWmQGnMAY12Krwf2E=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 77507A3B84;
        Fri, 26 Nov 2021 10:46:29 +0000 (UTC)
Date:   Fri, 26 Nov 2021 11:46:29 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: reduce spinlock contention in release_pages()
Message-ID: <YaC7BcTSijFj+bxR@dhcp22.suse.cz>
References: <20211124151915.GA6163@haolee.io>
 <YZ5o/VmU59evp65J@dhcp22.suse.cz>
 <CA+PpKPmy-u_BxYMCQOFyz78t2+3uM6nR9mQeX+MPyH6H2tOOHA@mail.gmail.com>
 <YZ8DZHERun6Fej2P@casper.infradead.org>
 <20211125080238.GA7356@haolee.io>
 <YZ9e3pzHKmn5nev0@dhcp22.suse.cz>
 <20211125123133.GA7758@haolee.io>
 <YZ+bI1fNpKar0bSU@dhcp22.suse.cz>
 <CA+PpKP=hsuBmvv09OcD2Nct8B8Cqa03UfKFHAHzKxwE0SXGP4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PpKP=hsuBmvv09OcD2Nct8B8Cqa03UfKFHAHzKxwE0SXGP4g@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 26-11-21 14:50:44, Hao Lee wrote:
> On Thu, Nov 25, 2021 at 10:18 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > Could you share more about requirements for those? Why is unmapping in
> > any of their hot paths which really require low latencies? Because as
> > long as unmapping requires a shared resource - like lru lock - then you
> > have a bottle necks.
> 
> We deploy best-effort (BE) jobs (e.g. bigdata, machine learning) and
> latency-critical (LC) jobs (e.g. map navigation, payments services) on the
> same servers to improve resource utilization. The running time of BE jobs are
> very short, but its memory consumption is large, and these jobs will run
> periodically. The LC jobs are long-run services and are sensitive to delays
> because jitters may cause customer churn.

Have you tried to isolate those workloads by memory cgroups? That could
help for lru lock at least. You are likely going to hit other locks on
the way though. E.g. zone lock in the page allocator but that might be
less problematic in the end. If you isolate your long running services
to a different NUMA node then you can get even less interaction.

> If a batch of BE jobs are finished simultaneously, lots of memory are freed,
> and spinlock contentions happen. BE jobs don't care about these contentions,
> but contentions cause them to spend more time in kernel mode, and thus, LC
> jobs running on the same cpu cores will be delayed and jitters occur. (The
> kernel preemption is disabled on our servers, and we try not to separate
> LC/BE using cpuset in order to achieve "complete mixture deployment"). Then
> LC services people will complain about the poor service stability. This
> scenario has occurred several times, so we want to find a way to avoid it.

It will be hard and a constant fight to get reasonably low latencies on
a non preemptible kernel. It would likely be better to partition CPUs
between latency sensitive and BE jobs. I can see how that might not be
really practical but especially with non-preemptible kernels you have a
large space for priority inversions that is hard to forsee or contain.
-- 
Michal Hocko
SUSE Labs
