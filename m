Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3BE67D547
	for <lists+cgroups@lfdr.de>; Thu, 26 Jan 2023 20:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjAZTUw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Jan 2023 14:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjAZTUv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Jan 2023 14:20:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B299420686;
        Thu, 26 Jan 2023 11:20:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 67AF721EE6;
        Thu, 26 Jan 2023 19:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674760847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZdMVCCJMvU9M4O/mfRN6zr0JYO93D/H3jiZOXlAsN8=;
        b=DIGdmxISieQdRrwLNw3LlmeoAc//xicN6OWmYLUZSAy1U8+3WkjnxB83NPHNFst2UfNqhQ
        5EYS9kT+98gjXX87triED/Wqc+H8qGXxSN1jr90JCBibCPVTVGzR4e8BH6ebDd1Jr+XS3x
        Y1bxrYJh5ZL81p0/pPGxcAnxW/peDNw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D811139B3;
        Thu, 26 Jan 2023 19:20:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QE3kDI/S0mMnGwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 26 Jan 2023 19:20:47 +0000
Date:   Thu, 26 Jan 2023 20:20:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9LSjnNEEUiF/70R@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
 <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
 <Y9LAf4pRyClZ1vfx@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9LAf4pRyClZ1vfx@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 26-01-23 15:03:43, Marcelo Tosatti wrote:
> On Thu, Jan 26, 2023 at 08:41:34AM +0100, Michal Hocko wrote:
> > On Wed 25-01-23 15:14:48, Roman Gushchin wrote:
> > > On Wed, Jan 25, 2023 at 03:22:00PM -0300, Marcelo Tosatti wrote:
> > > > On Wed, Jan 25, 2023 at 08:06:46AM -0300, Leonardo Brás wrote:
> > > > > On Wed, 2023-01-25 at 09:33 +0100, Michal Hocko wrote:
> > > > > > On Wed 25-01-23 04:34:57, Leonardo Bras wrote:
> > > > > > > Disclaimer:
> > > > > > > a - The cover letter got bigger than expected, so I had to split it in
> > > > > > >     sections to better organize myself. I am not very confortable with it.
> > > > > > > b - Performance numbers below did not include patch 5/5 (Remove flags
> > > > > > >     from memcg_stock_pcp), which could further improve performance for
> > > > > > >     drain_all_stock(), but I could only notice the optimization at the
> > > > > > >     last minute.
> > > > > > > 
> > > > > > > 
> > > > > > > 0 - Motivation:
> > > > > > > On current codebase, when drain_all_stock() is ran, it will schedule a
> > > > > > > drain_local_stock() for each cpu that has a percpu stock associated with a
> > > > > > > descendant of a given root_memcg.
> > > 
> > > Do you know what caused those drain_all_stock() calls? I wonder if we should look
> > > into why we have many of them and whether we really need them?
> > > 
> > > It's either some user's actions (e.g. reducing memory.max), either some memcg
> > > is entering pre-oom conditions. In the latter case a lot of drain calls can be
> > > scheduled without a good reason (assuming the cgroup contain multiple tasks running
> > > on multiple cpus).
> > 
> > I believe I've never got a specific answer to that. We
> > have discussed that in the previous version submission
> > (20221102020243.522358-1-leobras@redhat.com and specifically
> > Y2TQLavnLVd4qHMT@dhcp22.suse.cz). Leonardo has mentioned a mix of RT and
> > isolcpus. I was wondering about using memcgs in RT workloads because
> > that just sounds weird but let's say this is the case indeed. 
> 
> This could be the case. You can consider an "edge device" where it is
> necessary to run a RT workload. It might also be useful to run 
> non realtime applications on the same system.
> 
> > Then an RT task or whatever task that is running on an isolated
> > cpu can have pcp charges.
> 
> Usually the RT task (or more specifically the realtime sensitive loop
> of the application) runs entirely on userspace. But i suppose there
> could be charges on application startup.

What is the role of memcg then? If the memory limit is in place and the
workload doesn't fit in then it will get reclaimed during start up and
memory would need to be refaulted if not mlocked. If it is mlocked then
the limit cannot be enforced and the start up would likely fail as a
result of the memcg oom killer.

[...]
> > > Overall I'm somewhat resistant to an idea of making generic allocation & free paths slower
> > > for an improvement of stock draining. It's not a strong objection, but IMO we should avoid
> > > doing this without a really strong reason.
> > 
> > Are you OK with a simple opt out on isolated CPUs? That would make
> > charges slightly slower (atomic on the hierarchy counters vs. a single
> > pcp adjustment) but it would guarantee that the isolated workload is
> > predictable which is the primary objective AFAICS.
> 
> This would make isolated CPUs "second class citizens": it would be nice
> to be able to execute non realtime apps on isolated CPUs as well
> (think of different periods of time during a day, one where 
> more realtime apps are required, another where less 
> realtime apps are required).

An alternative requires to make the current implementation that is
lockless to use locks and introduce potential lock contention. This
could be harmful to regular workloads. Not using pcp caching would make
a fast path using few atomics rather than local pcp update. That is not
a terrible cost to pay for special cased workloads which use isolcpus.
Really we are not talking about a massive cost to be payed. At least
nobody has shown that in any numbers.

> Concrete example: think of a computer handling vRAN traffic near a 
> cell tower. The traffic (therefore amount of processing required
> by realtime applications) might vary during the day.
> 
> User might want to run containers that depend on good memcg charging
> performance on isolated CPUs.

What kind of role would memcg play here? Do you want to memory constrain
that workload?
-- 
Michal Hocko
SUSE Labs
