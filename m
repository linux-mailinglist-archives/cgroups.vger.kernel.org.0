Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BA467D96F
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 00:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjAZXM5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Jan 2023 18:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjAZXM4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Jan 2023 18:12:56 -0500
Received: from out-84.mta0.migadu.com (out-84.mta0.migadu.com [IPv6:2001:41d0:1004:224b::54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE0FEF82
        for <cgroups@vger.kernel.org>; Thu, 26 Jan 2023 15:12:54 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:12:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674774772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n7M1bfJLC4Rcsy/Y/usaqBvuQAjlpdOFXty5eUdj7PU=;
        b=paF0N/iKfvlcN9yEEM/b2TNNUDXisDdGcz0WAIRf6cjejS0WzLPSni7TNGvbneMeKyzDyj
        Lebr5WBZ2hHo/G7w6N+e4AuL7TZD6obbBxM+8Sp8zk0464GNq3oxk2qH50NdUF/jGCuI0o
        X0rTkDGfQwBBfQ8Dxmnb/f/xbQMWc8E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9MI42NSLooyVZNu@P9FQF9L96D.corp.robot.car>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
 <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 26, 2023 at 08:41:34AM +0100, Michal Hocko wrote:
> On Wed 25-01-23 15:14:48, Roman Gushchin wrote:
> > On Wed, Jan 25, 2023 at 03:22:00PM -0300, Marcelo Tosatti wrote:
> > > On Wed, Jan 25, 2023 at 08:06:46AM -0300, Leonardo Brás wrote:
> > > > On Wed, 2023-01-25 at 09:33 +0100, Michal Hocko wrote:
> > > > > On Wed 25-01-23 04:34:57, Leonardo Bras wrote:
> > > > > > Disclaimer:
> > > > > > a - The cover letter got bigger than expected, so I had to split it in
> > > > > >     sections to better organize myself. I am not very confortable with it.
> > > > > > b - Performance numbers below did not include patch 5/5 (Remove flags
> > > > > >     from memcg_stock_pcp), which could further improve performance for
> > > > > >     drain_all_stock(), but I could only notice the optimization at the
> > > > > >     last minute.
> > > > > > 
> > > > > > 
> > > > > > 0 - Motivation:
> > > > > > On current codebase, when drain_all_stock() is ran, it will schedule a
> > > > > > drain_local_stock() for each cpu that has a percpu stock associated with a
> > > > > > descendant of a given root_memcg.
> > 
> > Do you know what caused those drain_all_stock() calls? I wonder if we should look
> > into why we have many of them and whether we really need them?
> > 
> > It's either some user's actions (e.g. reducing memory.max), either some memcg
> > is entering pre-oom conditions. In the latter case a lot of drain calls can be
> > scheduled without a good reason (assuming the cgroup contain multiple tasks running
> > on multiple cpus).
> 
> I believe I've never got a specific answer to that. We
> have discussed that in the previous version submission
> (20221102020243.522358-1-leobras@redhat.com and specifically
> Y2TQLavnLVd4qHMT@dhcp22.suse.cz). Leonardo has mentioned a mix of RT and
> isolcpus. I was wondering about using memcgs in RT workloads because
> that just sounds weird but let's say this is the case indeed. Then an RT
> task or whatever task that is running on an isolated cpu can have pcp
> charges.
> 
> > Essentially each cpu will try to grab the remains of the memory quota
> > and move it locally. I wonder in such circumstances if we need to disable the pcp-caching
> > on per-cgroup basis.
> 
> I think it would be more than sufficient to disable pcp charging on an
> isolated cpu.

It might have significant performance consequences.

I'd rather opt out of stock draining for isolated cpus: it might slightly reduce
the accuracy of memory limits and slightly increase the memory footprint (all
those dying memcgs...), but the impact will be limited. Actually it is limited
by the number of cpus.

> This is not a per memcg property.

Sure, my point was that in pre-oom condition several cpus might try to consolidate
the remains of the memory quota, actually working against each other. Separate issue,
which might be a reason why there are many flush attempts in the case we discuss.

Thanks!
