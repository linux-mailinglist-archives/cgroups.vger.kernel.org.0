Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23C36CEBD3
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 16:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjC2Ojd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 10:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjC2OjM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 10:39:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7DF6A5F
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680100504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j6Qltz9GS2xYDRDWB9RaugYoeUKsxXmeQuDRMPnbUIY=;
        b=emkoH0Yd493ttonN89IldVIZGsmkpEJK/e+45YtmBXKMCmSbedWINogqsthzUUbicsZNzt
        3FVHmZh56EehreA7HpWfUFbJqorkMVQPB6k3loAHxYVT0Dv45WATX2Zza/3ojJV6wh2dZZ
        J5UO/9hNSIZ6oTSCz7Exk8br5m1jcXU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-H0iHVYIrNgqdLy-0xl9CJw-1; Wed, 29 Mar 2023 10:35:00 -0400
X-MC-Unique: H0iHVYIrNgqdLy-0xl9CJw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 545431C0512F;
        Wed, 29 Mar 2023 14:34:59 +0000 (UTC)
Received: from [10.22.34.224] (unknown [10.22.34.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE8FEC15BA0;
        Wed, 29 Mar 2023 14:34:57 +0000 (UTC)
Message-ID: <a7c4d685-a68c-5dc9-0911-3df2ce92e09d@redhat.com>
Date:   Wed, 29 Mar 2023 10:34:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/6] sched/deadline: cpuset: Rework DEADLINE bandwidth
 restoration
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
References: <20230329125558.255239-1-juri.lelli@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230329125558.255239-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/29/23 08:55, Juri Lelli wrote:
> Qais reported [1] that iterating over all tasks when rebuilding root
> domains for finding out which ones are DEADLINE and need their bandwidth
> correctly restored on such root domains can be a costly operation (10+
> ms delays on suspend-resume). He proposed we skip rebuilding root
> domains for certain operations, but that approach seemed arch specific
> and possibly prone to errors, as paths that ultimately trigger a rebuild
> might be quite convoluted (thanks Qais for spending time on this!).
>
> To fix the problem
>
>   01/06 - Rename functions deadline with DEADLINE accounting (cleanup
>           suggested by Qais) - no functional change
>   02/06 - Bring back cpuset_mutex (so that we have write access to cpusets
>           from scheduler operations - and we also fix some problems
>           associated to percpu_cpuset_rwsem)
>   03/06 - Keep track of the number of DEADLINE tasks belonging to each cpuset
>   04/06 - Create DL BW alloc, free & check overflow interface for bulk
>           bandwidth allocation/removal - no functional change
>   05/06 - Fix bandwidth allocation handling for cgroup operation
>           involving multiple tasks
>   06/06 - Use this information to only perform the costly iteration if
>           DEADLINE tasks are actually present in the cpuset for which a
>           corresponding root domain is being rebuilt
>
> With respect to the RFC posting [2]
>
>   1 - rename DEADLINE bandwidth accounting functions - Qais
>   2 - call inc/dec_dl_tasks_cs from switched_{to,from}_dl - Qais
>   3 - fix DEADLINE bandwidth allocation with multiple tasks - Waiman,
>       contributed by Dietmar
>
> This set is also available from
>
> https://github.com/jlelli/linux.git deadline/rework-cpusets
>
> Best,
> Juri
>
> 1 - https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
> 2 - https://lore.kernel.org/lkml/20230315121812.206079-1-juri.lelli@redhat.com/
>
> Dietmar Eggemann (2):
>    sched/deadline: Create DL BW alloc, free & check overflow interface
>    cgroup/cpuset: Free DL BW in case can_attach() fails
>
> Juri Lelli (4):
>    cgroup/cpuset: Rename functions dealing with DEADLINE accounting
>    sched/cpuset: Bring back cpuset_mutex
>    sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
>    cgroup/cpuset: Iterate only if DEADLINE tasks are present
>
>   include/linux/cpuset.h  |  12 ++-
>   include/linux/sched.h   |   4 +-
>   kernel/cgroup/cgroup.c  |   4 +
>   kernel/cgroup/cpuset.c  | 232 ++++++++++++++++++++++++++--------------
>   kernel/sched/core.c     |  41 ++++---
>   kernel/sched/deadline.c |  67 +++++++++---
>   kernel/sched/sched.h    |   2 +-
>   7 files changed, 240 insertions(+), 122 deletions(-)

Other than some minor issues that I have talked in earlier emails, the 
patch series looks good to me.

You can add my ack once the issues are fixed.

Acked-by: Waiman Long <longman@redhat.com>

