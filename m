Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3AE67DE0E
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 07:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjA0G6l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 01:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjA0G6h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 01:58:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918F01E5E4;
        Thu, 26 Jan 2023 22:58:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2EAAD21BB3;
        Fri, 27 Jan 2023 06:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674802714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g+E5xBJ3UOLpBqu7Q/7w5cQuQLqZh3v0sZZi4etorHM=;
        b=YGGNoTNQSsBG2crAEEf577da9ZlMzCQfCzd1kLQO55iHcOKNihErXr7ZcEAiMcI3Nhh4OP
        Po3w6eO0WJ6HNVdNfx5oWkuZax3loRjgY6iHwTSCaqhEVGvHYBknYbOSpV4VkJ4h2CvyAp
        V4rM4uxPXKoxjeLA7/drrCxbfEz8Wb4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C31C1336F;
        Fri, 27 Jan 2023 06:58:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fJ2xABp202OPUAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 27 Jan 2023 06:58:34 +0000
Date:   Fri, 27 Jan 2023 07:58:32 +0100
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
Message-ID: <Y9N2GC9Vk2k68Svs@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
 <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
 <Y9LAf4pRyClZ1vfx@tpad>
 <Y9LSjnNEEUiF/70R@dhcp22.suse.cz>
 <Y9MbkuBDI+08AtgN@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9MbkuBDI+08AtgN@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 26-01-23 21:32:18, Marcelo Tosatti wrote:
> On Thu, Jan 26, 2023 at 08:20:46PM +0100, Michal Hocko wrote:
> > On Thu 26-01-23 15:03:43, Marcelo Tosatti wrote:
> > > On Thu, Jan 26, 2023 at 08:41:34AM +0100, Michal Hocko wrote:
> > > > On Wed 25-01-23 15:14:48, Roman Gushchin wrote:
> > > > > On Wed, Jan 25, 2023 at 03:22:00PM -0300, Marcelo Tosatti wrote:
> > > > > > On Wed, Jan 25, 2023 at 08:06:46AM -0300, Leonardo Brás wrote:
> > > > > > > On Wed, 2023-01-25 at 09:33 +0100, Michal Hocko wrote:
> > > > > > > > On Wed 25-01-23 04:34:57, Leonardo Bras wrote:
> > > > > > > > > Disclaimer:
> > > > > > > > > a - The cover letter got bigger than expected, so I had to split it in
> > > > > > > > >     sections to better organize myself. I am not very confortable with it.
> > > > > > > > > b - Performance numbers below did not include patch 5/5 (Remove flags
> > > > > > > > >     from memcg_stock_pcp), which could further improve performance for
> > > > > > > > >     drain_all_stock(), but I could only notice the optimization at the
> > > > > > > > >     last minute.
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 0 - Motivation:
> > > > > > > > > On current codebase, when drain_all_stock() is ran, it will schedule a
> > > > > > > > > drain_local_stock() for each cpu that has a percpu stock associated with a
> > > > > > > > > descendant of a given root_memcg.
> > > > > 
> > > > > Do you know what caused those drain_all_stock() calls? I wonder if we should look
> > > > > into why we have many of them and whether we really need them?
> > > > > 
> > > > > It's either some user's actions (e.g. reducing memory.max), either some memcg
> > > > > is entering pre-oom conditions. In the latter case a lot of drain calls can be
> > > > > scheduled without a good reason (assuming the cgroup contain multiple tasks running
> > > > > on multiple cpus).
> > > > 
> > > > I believe I've never got a specific answer to that. We
> > > > have discussed that in the previous version submission
> > > > (20221102020243.522358-1-leobras@redhat.com and specifically
> > > > Y2TQLavnLVd4qHMT@dhcp22.suse.cz). Leonardo has mentioned a mix of RT and
> > > > isolcpus. I was wondering about using memcgs in RT workloads because
> > > > that just sounds weird but let's say this is the case indeed. 
> > > 
> > > This could be the case. You can consider an "edge device" where it is
> > > necessary to run a RT workload. It might also be useful to run 
> > > non realtime applications on the same system.
> > > 
> > > > Then an RT task or whatever task that is running on an isolated
> > > > cpu can have pcp charges.
> > > 
> > > Usually the RT task (or more specifically the realtime sensitive loop
> > > of the application) runs entirely on userspace. But i suppose there
> > > could be charges on application startup.
> > 
> > What is the role of memcg then? If the memory limit is in place and the
> > workload doesn't fit in then it will get reclaimed during start up and
> > memory would need to be refaulted if not mlocked. If it is mlocked then
> > the limit cannot be enforced and the start up would likely fail as a
> > result of the memcg oom killer.
> 
> 1) Application which is not time sensitive executes on isolated CPU,
> with memcg control enabled. Per-CPU stock is created.
> 
> 2) App with memcg control enabled exits, per-CPU stock is not drained.
> 
> 3) Latency sensitive application starts, isolated per-CPU has stock to
> be drained, and:
> 
> /*
>  * Drains all per-CPU charge caches for given root_memcg resp. subtree
>  * of the hierarchy under it.
>  */
> static void drain_all_stock(struct mem_cgroup *root_memcg)

No, this is not really answering my question. See
Y9LQ615H13RmG7wL@dhcp22.suse.cz which already explains how the draining
would be triggered. This is not really happening on any operation.

I am really asking for specific workloads which are running multiple
processes on a mix of isolated and non-isolated cpus yet they share
memcg so that they can interfere. The consequences of the common memcg
are described above.
-- 
Michal Hocko
SUSE Labs
