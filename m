Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8F067D453
	for <lists+cgroups@lfdr.de>; Thu, 26 Jan 2023 19:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjAZSiP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Jan 2023 13:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjAZSiK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Jan 2023 13:38:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7687C48A12
        for <cgroups@vger.kernel.org>; Thu, 26 Jan 2023 10:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674758237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8a5V2BYq9UP1RYMhw23cgt6o5VR9Kg9O+b7IjGs+oHs=;
        b=Xf9I4wHJC1gUUtMapRknsH4efL6SHhaamgscG7tM8Aiq+ogEHWOEie0QbmH6JZRYdGV6te
        j7VbUxq+N10u3ALrzQEQe4giqc/aDGBHtm2l2tAlRjaM+wadVf8hG1TyIkW8h/V1GZzqNf
        Ir+ksHaw26qabbF+ETU0b4oK3v888tI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-LadZCE_4Pd2ISTYMta3MVA-1; Thu, 26 Jan 2023 13:37:13 -0500
X-MC-Unique: LadZCE_4Pd2ISTYMta3MVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5C9F857F82;
        Thu, 26 Jan 2023 18:37:12 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CAC12166B26;
        Thu, 26 Jan 2023 18:37:12 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 8108A403D528D; Thu, 26 Jan 2023 15:03:43 -0300 (-03)
Date:   Thu, 26 Jan 2023 15:03:43 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9LAf4pRyClZ1vfx@tpad>
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
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
> that just sounds weird but let's say this is the case indeed. 

This could be the case. You can consider an "edge device" where it is
necessary to run a RT workload. It might also be useful to run 
non realtime applications on the same system.

> Then an RT task or whatever task that is running on an isolated
> cpu can have pcp charges.

Usually the RT task (or more specifically the realtime sensitive loop
of the application) runs entirely on userspace. But i suppose there
could be charges on application startup.

> > Essentially each cpu will try to grab the remains of the memory quota
> > and move it locally. I wonder in such circumstances if we need to disable the pcp-caching
> > on per-cgroup basis.
> 
> I think it would be more than sufficient to disable pcp charging on an
> isolated cpu. This is not a per memcg property. I can imagine that
> different tasks running in the same memcg can run on a mix of CPUs (e.g.
> only part of it on isolated CPUs). It is a recipe for all sorts of
> priority inversions but well, memcg and RT is there already.

I suppose the more general the solution, the better.

> > Generally speaking, draining of pcpu stocks is useful only if an idle cpu is holding some
> > charges/memcg references (it might be not completely idle, but running some very special
> > workload which is not doing any kernel allocations or a process belonging to the root memcg).
> > In all other cases pcpu stock will be either drained naturally by an allocation from another
> > memcg or an allocation from the same memcg will "restore" it, making draining useless.
> > 
> > We also can into drain_all_pages() opportunistically, without waiting for the result.
> > On a busy system it's most likely useless, we might oom before scheduled works will be executed.
> 
> I think the primary objective is that no userspace unintended execution
> happens on isolated cpus.

No interruptions to the userspace code (time sensitive code) running on
isolated CPUs: no IPIs, no task switches.

> > I admit I planned to do some work around and even started, but then never had enough time to
> > finish it.
> > 
> > Overall I'm somewhat resistant to an idea of making generic allocation & free paths slower
> > for an improvement of stock draining. It's not a strong objection, but IMO we should avoid
> > doing this without a really strong reason.
> 
> Are you OK with a simple opt out on isolated CPUs? That would make
> charges slightly slower (atomic on the hierarchy counters vs. a single
> pcp adjustment) but it would guarantee that the isolated workload is
> predictable which is the primary objective AFAICS.

This would make isolated CPUs "second class citizens": it would be nice
to be able to execute non realtime apps on isolated CPUs as well
(think of different periods of time during a day, one where 
more realtime apps are required, another where less 
realtime apps are required).

Concrete example: think of a computer handling vRAN traffic near a 
cell tower. The traffic (therefore amount of processing required
by realtime applications) might vary during the day.

User might want to run containers that depend on good memcg charging
performance on isolated CPUs.

