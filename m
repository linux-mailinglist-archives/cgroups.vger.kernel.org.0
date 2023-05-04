Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3776F64E6
	for <lists+cgroups@lfdr.de>; Thu,  4 May 2023 08:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjEDGYj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 May 2023 02:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjEDGYi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 May 2023 02:24:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036BE26BE;
        Wed,  3 May 2023 23:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j16Bh52nzyJO9VnirYe2+W5J9gGnfrNEg+DqgmtGTK4=; b=o39RDzof6y4haLdWTv/dU4Ezo1
        00lekUFPh1bpwrIBOFfrFQtxvnmNYxA+cPAl3zBtS5pnDMARzaEnn+hmjQGcfjyrMrafdnp56iHaB
        jCU4qImPx1pTrvi3mVZQIVDHBvy/8bmRNgI3TQa0qOK3AH3GMSynPqiy7ueCFYCjgW3u/AOhW/SHl
        1KCW0DPlxbZcmJSFtRGXN2sPMGjdh3wyyP68Ly28Da3f6DAp1AKKXuyDvLWV6vq75DXF4J5eOyH+r
        GCcSGtu4wI3BzOk2U/Yz1J2rnxpbodfdOOwaOT/rg8p0YjccZWbaRM/gyWRIqIutipwdiXuRhyIi2
        hMejCuGA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puSNk-001ebz-1p;
        Thu, 04 May 2023 06:24:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7CF9301326;
        Thu,  4 May 2023 08:23:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8ACBF24080DDC; Thu,  4 May 2023 08:23:59 +0200 (CEST)
Date:   Thu, 4 May 2023 08:23:59 +0200
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
Subject: Re: [PATCH v2 5/6] sched/deadline: Create DL BW alloc, free & check
 overflow interface
Message-ID: <20230504062359.GE1734100@hirez.programming.kicks-ass.net>
References: <20230503072228.115707-1-juri.lelli@redhat.com>
 <20230503072228.115707-6-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503072228.115707-6-juri.lelli@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 03, 2023 at 09:22:27AM +0200, Juri Lelli wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> Rework the existing dl_cpu_busy() interface which offers DL BW overflow
> checking and per-task DL BW allocation.
> 
> Add dl_bw_free() as an interface to be able to free DL BW.
> It will be used to allow freeing of the DL BW request done during
> cpuset_can_attach() in case multiple controllers are attached to the
> cgroup next to the cpuset controller and one of the non-cpuset
> can_attach() fails.
> 
> dl_bw_alloc() (and dl_bw_free()) now take a `u64 dl_bw` parameter
> instead of `struct task_struct *p` used in dl_cpu_busy().  This allows
> to allocate DL BW for a set of tasks too rater than only for a single
> task.
> 

Changlog fails the 'why' test.
