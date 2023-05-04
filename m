Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F266F64ED
	for <lists+cgroups@lfdr.de>; Thu,  4 May 2023 08:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjEDG0C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 May 2023 02:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjEDG0B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 May 2023 02:26:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D362711;
        Wed,  3 May 2023 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0/lxZ8I0MqaXMk8+g9Fw5CznOe/fTSlnGEVclllXyGY=; b=Nmoo9DOynuVqyJyVqry90thHKV
        Z+yPBe6q31aq5C6MMqg5enWpGfzLFtFtUEbOADD6Ata6S6MaGcfkurnjQTri1b5KFMXNrmhKeclYX
        fT1aGJ7SYPluxWOS4VB/G3zsloLe08DAymZDKigbYLtFBwza7o4+bMgqey1hTpAOsa9KO4YD5eRjE
        z8DtaptWM+YgWtMhEPnhaK7LkLnj20eXT409FJpreMrB9vQYMepvQ6zcCGv+vUTARCmNHdebFaNXt
        qImtBxyuAwZvvhKPrpNErVKMISyH+FKBlICudJY885hjLPY98Z6tBNC11gq3FXfFO8hKFya1ymZVF
        MVZk602g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1puSP8-00AJgG-Kd; Thu, 04 May 2023 06:25:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 261DB301326;
        Thu,  4 May 2023 08:25:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13927240EB55F; Thu,  4 May 2023 08:25:26 +0200 (CEST)
Date:   Thu, 4 May 2023 08:25:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 0/6] sched/deadline: cpuset: Rework DEADLINE bandwidth
 restoration
Message-ID: <20230504062525.GF1734100@hirez.programming.kicks-ass.net>
References: <20230503072228.115707-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503072228.115707-1-juri.lelli@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 03, 2023 at 09:22:22AM +0200, Juri Lelli wrote:

> Dietmar Eggemann (2):
>   sched/deadline: Create DL BW alloc, free & check overflow interface
>   cgroup/cpuset: Free DL BW in case can_attach() fails
> 
> Juri Lelli (4):
>   cgroup/cpuset: Rename functions dealing with DEADLINE accounting
>   sched/cpuset: Bring back cpuset_mutex
>   sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
>   cgroup/cpuset: Iterate only if DEADLINE tasks are present
> 
>  include/linux/cpuset.h  |  12 +-
>  include/linux/sched.h   |   4 +-
>  kernel/cgroup/cgroup.c  |   4 +
>  kernel/cgroup/cpuset.c  | 242 ++++++++++++++++++++++++++--------------
>  kernel/sched/core.c     |  41 +++----
>  kernel/sched/deadline.c |  67 ++++++++---
>  kernel/sched/sched.h    |   2 +-
>  7 files changed, 244 insertions(+), 128 deletions(-)

Aside from a few niggles, these look fine to me. Who were you expecting
to merge these, tj or me?


