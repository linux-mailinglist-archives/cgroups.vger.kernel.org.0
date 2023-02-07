Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2648168D5F3
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 12:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjBGLtr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Feb 2023 06:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjBGLtq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Feb 2023 06:49:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0E57EF2;
        Tue,  7 Feb 2023 03:49:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BF6961341;
        Tue,  7 Feb 2023 11:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2447FC433EF;
        Tue,  7 Feb 2023 11:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675770584;
        bh=RgVgJCrLkTAvmwUYHcxZco9kHb4tcMhvYtkGp0jn4Uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tLvug3F3Minye5YXeEpg6rj46hLxC8/p8PnepfTsimLxWG/Th4ZPg+Gppcs2IcXjj
         YO/kg3jMl1KIODxpVAbL/icPosTwmqgKrebGucclQCTk0BUKZb+qDeIWX9uX0G6kiE
         vFO/v77bmwVwwMnmFrf7guquDrQDLKHmI6fbPJ17akGjL82op+LxtSRmVVl/h54+8Y
         Olta0cI33IiMJCCYZrEPuR/VE5rXtKwbD+zVYYSY0iioEp8sjr6VZbyBI7TrVoYUQi
         4TnJseDLpVDQuCvoCoUTCJyvrgYtEDJUd3jEQorADL8yVmZ4eVu2JtzvcTCvgImn24
         XbTwOQWCQqhTA==
Date:   Tue, 7 Feb 2023 12:49:41 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] sched/isolation: Merge individual nohz_full features
 into a common housekeeping flag
Message-ID: <Y+I61dp5qPkWK4s2@lothringen>
References: <20230203232409.163847-1-frederic@kernel.org>
 <20230203232409.163847-2-frederic@kernel.org>
 <20230206155107.GA31453@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230206155107.GA31453@blackbody.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 06, 2023 at 04:51:09PM +0100, Michal Koutný wrote:
> Hello Frederic.
> 
> On Sat, Feb 04, 2023 at 12:24:08AM +0100, Frederic Weisbecker <frederic@kernel.org> wrote:
> > The individual isolation features turned on by nohz_full were initially
> > split in order for each of them to be tunable through cpusets. However
> > plans have changed in favour of an interface (be it cpusets or sysctl)
> > grouping all these features to be turned on/off altogether.
> > Then should the need ever arise, the interface can still be expanded
> > to handle the individual isolation features.
> > 
> > Therefore the current isolation split between tick/timer/workqueue/rcu/
> > kthreads/misc doesn't make sense anymore.
> 
> Why it doesn't make sense? I think it's a useful annotation of
> respective operations wrt CPU isolation.

But what do we need these annotations for? The only outcome I've ever
seen with these is that it confuses everyone.

> 
> The grouping you did into HK_TYPE_KERNEL_NOISE (or even coarser) should
> IMO be done at the place where it'll be exposed into the favored
> interface (like it's with nohz_full=).

That being said I should reserve the grouping to HK_TYPE_KERNEL_NOISE when
I'll introduce the cpuset interface. This way I can add the support for
each part smoothly. For example first patch moves HK_TYPE_TIMER to
HK_TYPE_KERNEL_NOISE and unbound timers are supported by cpuset.kernel_noise,
second patch moves HK_TYPE_WQ to HK_TYPE_KERNEL_NOISE and unbound workqueues
are supported by cpuset.kernel_noise, etc until all of them turned by nohz_full=
are supported... This is what I'm doing in fact but I'm so slow to write this patchset...

Thanks.
