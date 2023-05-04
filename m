Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7B36F64D1
	for <lists+cgroups@lfdr.de>; Thu,  4 May 2023 08:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjEDGTf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 May 2023 02:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjEDGTe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 May 2023 02:19:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED7A198A;
        Wed,  3 May 2023 23:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DfqWiyDRGB40eGYe2jGNPAj11jBf4uHEb5kd/1AH73Y=; b=jh1G+T4BkA9Hqha86rr270atlB
        5VwBCL/FYuqlZsXl0tN57xUIihlHNN0hXZdhYF5obHg6NpfSugsRblLNfQpxC9YVbxj6uIRzHsddp
        KTBcXsnS9sPUo1O2QKsEvkTK3lGpdlNDQ0mSvgXDxXeFdghOK40WtYgfhXV79NTqsA3nUnp0I969U
        CMC3kIZOlR0BJRQO/CAEg9xEanUSQQ8Wk+Q0NR0s4hMKnb6KBoE+w9bEonYDEwg7IrhgW7OV4pfsL
        p5QLXOChTN+p5HhuP/ExTFbYwLe4NO5TcFy+X+sWCWDmc2UetTwys0ulbOrEaa4exgcA1Ce8chbzI
        h/w1z1vg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puSIh-001eUc-10;
        Thu, 04 May 2023 06:18:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81A733006DA;
        Thu,  4 May 2023 08:18:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 346F823BD3ADF; Thu,  4 May 2023 08:18:42 +0200 (CEST)
Date:   Thu, 4 May 2023 08:18:42 +0200
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
Message-ID: <20230504061842.GC1734100@hirez.programming.kicks-ass.net>
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

>  /*
> - * There are two global locks guarding cpuset structures - cpuset_rwsem and
> + * There are two global locks guarding cpuset structures - cpuset_mutex and
>   * callback_lock. We also require taking task_lock() when dereferencing a
>   * task's cpuset pointer. See "The task_lock() exception", at the end of this
> - * comment.  The cpuset code uses only cpuset_rwsem write lock.  Other
> - * kernel subsystems can use cpuset_read_lock()/cpuset_read_unlock() to
> - * prevent change to cpuset structures.
> + * comment.  The cpuset code uses only cpuset_mutex. Other kernel subsystems
> + * can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
> + * structures.
>   *
>   * A task must hold both locks to modify cpusets.  If a task holds
> - * cpuset_rwsem, it blocks others wanting that rwsem, ensuring that it
> - * is the only task able to also acquire callback_lock and be able to
> - * modify cpusets.  It can perform various checks on the cpuset structure
> - * first, knowing nothing will change.  It can also allocate memory while
> - * just holding cpuset_rwsem.  While it is performing these checks, various
> - * callback routines can briefly acquire callback_lock to query cpusets.
> - * Once it is ready to make the changes, it takes callback_lock, blocking
> - * everyone else.
> + * cpuset_mutex, it blocks others, ensuring that it is the only task able to
> + * also acquire callback_lock and be able to modify cpusets.  It can perform
> + * various checks on the cpuset structure first, knowing nothing will change.
> + * It can also allocate memory while just holding cpuset_mutex.  While it is
> + * performing these checks, various callback routines can briefly acquire
> + * callback_lock to query cpusets.  Once it is ready to make the changes, it
> + * takes callback_lock, blocking everyone else.
>   *
>   * Calls to the kernel memory allocator can not be made while holding
>   * callback_lock, as that would risk double tripping on callback_lock
> @@ -403,16 +402,16 @@ static struct cpuset top_cpuset = {
>   * guidelines for accessing subsystem state in kernel/cgroup.c
>   */
>  
> -DEFINE_STATIC_PERCPU_RWSEM(cpuset_rwsem);
> +static DEFINE_MUTEX(cpuset_mutex);

Perhaps extend the comment to state you explicitly want a mutex for PI
etc.. ?
