Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECE867C0A8
	for <lists+cgroups@lfdr.de>; Thu, 26 Jan 2023 00:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjAYXPJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Jan 2023 18:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjAYXPJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Jan 2023 18:15:09 -0500
Received: from out-243.mta0.migadu.com (out-243.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3E54521E
        for <cgroups@vger.kernel.org>; Wed, 25 Jan 2023 15:15:07 -0800 (PST)
Date:   Wed, 25 Jan 2023 15:14:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674688503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQas9hJPH93Zr57s1dcc7T+g336s2ZkXNkxopiNZy5Y=;
        b=L++sVVFKgB2QgSfUln8N4pW6K99/uC71K7MHO0eTNd2gOjxQp1AktmI+V60pLnLZKq6KFC
        hACk9uz3DsoIitBsOXZt7BIu60/uMI/JLjE4PEEUb0PdbUDFsVn25UofpY3G6aCVyuS6ma
        52wkIVgDt+qNHn0YlWdzI9qQ/UE4CgA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9FzSBw10MGXm2TK@tpad>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 25, 2023 at 03:22:00PM -0300, Marcelo Tosatti wrote:
> On Wed, Jan 25, 2023 at 08:06:46AM -0300, Leonardo Brás wrote:
> > On Wed, 2023-01-25 at 09:33 +0100, Michal Hocko wrote:
> > > On Wed 25-01-23 04:34:57, Leonardo Bras wrote:
> > > > Disclaimer:
> > > > a - The cover letter got bigger than expected, so I had to split it in
> > > >     sections to better organize myself. I am not very confortable with it.
> > > > b - Performance numbers below did not include patch 5/5 (Remove flags
> > > >     from memcg_stock_pcp), which could further improve performance for
> > > >     drain_all_stock(), but I could only notice the optimization at the
> > > >     last minute.
> > > > 
> > > > 
> > > > 0 - Motivation:
> > > > On current codebase, when drain_all_stock() is ran, it will schedule a
> > > > drain_local_stock() for each cpu that has a percpu stock associated with a
> > > > descendant of a given root_memcg.

Do you know what caused those drain_all_stock() calls? I wonder if we should look
into why we have many of them and whether we really need them?

It's either some user's actions (e.g. reducing memory.max), either some memcg
is entering pre-oom conditions. In the latter case a lot of drain calls can be
scheduled without a good reason (assuming the cgroup contain multiple tasks running
on multiple cpus). Essentially each cpu will try to grab the remains of the memory quota
and move it locally. I wonder in such circumstances if we need to disable the pcp-caching
on per-cgroup basis.

Generally speaking, draining of pcpu stocks is useful only if an idle cpu is holding some
charges/memcg references (it might be not completely idle, but running some very special
workload which is not doing any kernel allocations or a process belonging to the root memcg).
In all other cases pcpu stock will be either drained naturally by an allocation from another
memcg or an allocation from the same memcg will "restore" it, making draining useless.

We also can into drain_all_pages() opportunistically, without waiting for the result.
On a busy system it's most likely useless, we might oom before scheduled works will be executed.

I admit I planned to do some work around and even started, but then never had enough time to
finish it.

Overall I'm somewhat resistant to an idea of making generic allocation & free paths slower
for an improvement of stock draining. It's not a strong objection, but IMO we should avoid
doing this without a really strong reason.

Thanks!
