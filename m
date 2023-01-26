Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B2467C4FA
	for <lists+cgroups@lfdr.de>; Thu, 26 Jan 2023 08:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjAZHlj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Jan 2023 02:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjAZHli (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Jan 2023 02:41:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10BA65F2D;
        Wed, 25 Jan 2023 23:41:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 973622210B;
        Thu, 26 Jan 2023 07:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674718895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mncfe4kJe4t7mpaj+aaMpUVysMSI3MXidyK6ywAzmc0=;
        b=UL/28di24psjPcStaP7/ABTZSBwBaZupgJJ4DSVAM8SvNGREBi1UxcQo4kxQu5V3ZGxb/7
        Ei7mT7wBbYdb4meO0r0bNG1opKAjusHwBxdas9X+gGIjnoIzyVR2Nh0wuaSJ0rT4jArO/G
        MqUFVoKMoss3rxA7mQ4/uxLXF8J05DM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 783FF1358A;
        Thu, 26 Jan 2023 07:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YUv4Gq8u0mOxHQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 26 Jan 2023 07:41:35 +0000
Date:   Thu, 26 Jan 2023 08:41:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 25-01-23 15:14:48, Roman Gushchin wrote:
> On Wed, Jan 25, 2023 at 03:22:00PM -0300, Marcelo Tosatti wrote:
> > On Wed, Jan 25, 2023 at 08:06:46AM -0300, Leonardo Brás wrote:
> > > On Wed, 2023-01-25 at 09:33 +0100, Michal Hocko wrote:
> > > > On Wed 25-01-23 04:34:57, Leonardo Bras wrote:
> > > > > Disclaimer:
> > > > > a - The cover letter got bigger than expected, so I had to split it in
> > > > >     sections to better organize myself. I am not very confortable with it.
> > > > > b - Performance numbers below did not include patch 5/5 (Remove flags
> > > > >     from memcg_stock_pcp), which could further improve performance for
> > > > >     drain_all_stock(), but I could only notice the optimization at the
> > > > >     last minute.
> > > > > 
> > > > > 
> > > > > 0 - Motivation:
> > > > > On current codebase, when drain_all_stock() is ran, it will schedule a
> > > > > drain_local_stock() for each cpu that has a percpu stock associated with a
> > > > > descendant of a given root_memcg.
> 
> Do you know what caused those drain_all_stock() calls? I wonder if we should look
> into why we have many of them and whether we really need them?
> 
> It's either some user's actions (e.g. reducing memory.max), either some memcg
> is entering pre-oom conditions. In the latter case a lot of drain calls can be
> scheduled without a good reason (assuming the cgroup contain multiple tasks running
> on multiple cpus).

I believe I've never got a specific answer to that. We
have discussed that in the previous version submission
(20221102020243.522358-1-leobras@redhat.com and specifically
Y2TQLavnLVd4qHMT@dhcp22.suse.cz). Leonardo has mentioned a mix of RT and
isolcpus. I was wondering about using memcgs in RT workloads because
that just sounds weird but let's say this is the case indeed. Then an RT
task or whatever task that is running on an isolated cpu can have pcp
charges.

> Essentially each cpu will try to grab the remains of the memory quota
> and move it locally. I wonder in such circumstances if we need to disable the pcp-caching
> on per-cgroup basis.

I think it would be more than sufficient to disable pcp charging on an
isolated cpu. This is not a per memcg property. I can imagine that
different tasks running in the same memcg can run on a mix of CPUs (e.g.
only part of it on isolated CPUs). It is a recipe for all sorts of
priority inversions but well, memcg and RT is there already.

> Generally speaking, draining of pcpu stocks is useful only if an idle cpu is holding some
> charges/memcg references (it might be not completely idle, but running some very special
> workload which is not doing any kernel allocations or a process belonging to the root memcg).
> In all other cases pcpu stock will be either drained naturally by an allocation from another
> memcg or an allocation from the same memcg will "restore" it, making draining useless.
> 
> We also can into drain_all_pages() opportunistically, without waiting for the result.
> On a busy system it's most likely useless, we might oom before scheduled works will be executed.

I think the primary objective is that no userspace unintended execution
happens on isolated cpus.
 
> I admit I planned to do some work around and even started, but then never had enough time to
> finish it.
> 
> Overall I'm somewhat resistant to an idea of making generic allocation & free paths slower
> for an improvement of stock draining. It's not a strong objection, but IMO we should avoid
> doing this without a really strong reason.

Are you OK with a simple opt out on isolated CPUs? That would make
charges slightly slower (atomic on the hierarchy counters vs. a single
pcp adjustment) but it would guarantee that the isolated workload is
predictable which is the primary objective AFAICS.
-- 
Michal Hocko
SUSE Labs
