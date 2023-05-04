Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042C16F64D3
	for <lists+cgroups@lfdr.de>; Thu,  4 May 2023 08:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjEDGVg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 May 2023 02:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEDGVf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 May 2023 02:21:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EBB198A;
        Wed,  3 May 2023 23:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EEV4A2euqpSIeKXuHLHCUtET3TmfqslPKI8OraMGh2M=; b=Fc3ToHirKdtr3r8sc3aqgus1nG
        bEncSEtMI/O87Wo9MYqGNpmvhouh6+Jr/Y7vXA0g74Zy7XfMCLTPiTCfadl8WpOkpkaghd6TiFsAH
        gCHGMjltQwdKL6wf+a243jLVorzaw0USjRDgVSmvBurP+7x05jHqaV7eWqrFFnUp6GUVDqdpr0+a5
        LqWxwQeqJ+z89tyuoieb+VVCguopLytE6w+9XtcxaheKSAmFzs6ILzCMQbwlVjooPF8FljV0+E6P5
        +aczBOVRvNHkJ9HAlDRTV+PEIYt8Ctq63KdshN8G+DEMGkRzx7ZMHdELAyWimDomr5YGTIGJ+weuj
        /OyQRKsQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puSKv-001eYq-2o;
        Thu, 04 May 2023 06:21:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5698E301326;
        Thu,  4 May 2023 08:21:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E336240701FD; Thu,  4 May 2023 08:21:05 +0200 (CEST)
Date:   Thu, 4 May 2023 08:21:05 +0200
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
Subject: Re: [PATCH v2 2/6] sched/cpuset: Bring back cpuset_mutex
Message-ID: <20230504062105.GD1734100@hirez.programming.kicks-ass.net>
References: <20230503072228.115707-1-juri.lelli@redhat.com>
 <20230503072228.115707-3-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503072228.115707-3-juri.lelli@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 03, 2023 at 09:22:24AM +0200, Juri Lelli wrote:
> Turns out percpu_cpuset_rwsem - commit 1243dc518c9d ("cgroup/cpuset:
> Convert cpuset_mutex to percpu_rwsem") - wasn't such a brilliant idea,
> as it has been reported to cause slowdowns in workloads that need to
> change cpuset configuration frequently and it is also not implementing
> priority inheritance (which causes troubles with realtime workloads).

What were they doing ? Dynamically adjusting the DL parameters?

