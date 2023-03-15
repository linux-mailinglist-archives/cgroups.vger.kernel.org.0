Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78A6BB6C0
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 15:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjCOO5Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 10:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjCOO4x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 10:56:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31906151A
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 07:56:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v16so17632198wrn.0
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1678892117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZabwygkIwaPkH1+zXM510MIMS3ybA3ZKy/VPsc/fej0=;
        b=LAe0+2HZbcS22v6Go0o8VDxrhU6u6tvB0jA1ySBIMjzMmYM/fMnxdxTB+6VxbuBmRc
         DeeLT5EoBXj2arciyQbcEurkG+jaDk0+BehhoH1nHSbhVM+uFcmm/L8TPrWM9OWTVlO/
         swWGr7oIZVeLEr/jTYIfDZcFTJ5TkD6KE63FGTLFBzNHA/GxM9YEsfccsUtcPnzRg2pM
         bDVnDmrLPr7Ty6V8FY1xayPkFSu28eOa0XmF1c8K73QO/drOJn+Eyt8w/YO4uIWu045t
         FnGxxgjS8+/0xy9lDBxKPx7iR8PWFzV0X6VPFdk1SAx/xdDnPAIcvOiMbpKYoAkezhPF
         ESVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678892117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZabwygkIwaPkH1+zXM510MIMS3ybA3ZKy/VPsc/fej0=;
        b=vLbDmz5n6Ed5FFPA7N0WuzwY2dKQiKhqrtBk0Svi4gJphX7VpYinYszf5DHrsm9IYi
         YJ68f5ZnC9xY9FuJUuAjw/9p9i4zLxcrLkSIUKgFsqlYnvsMaoLau1kyOBz5QZuZRIab
         wYrSqptFYQ3Ausg0cliAeO55aCZ2/DEDPMBfVDIJBJC7VkPtcUF1x80Cywpv2qqa5CRj
         sIGP2rucj/+BhxGtMisKRXRti0D10wW3Q/g/KnXv2vuweEEn39pOZPgGOhyKsUcrva44
         SZhfDVoJwSaUjWoqL/c6efN92B4jUCTaliyX8hldojV+QupmPF8+CmL5NcOKEEBEHpjR
         He2Q==
X-Gm-Message-State: AO0yUKVXL+dhRY6S6IuF99z2R3MaZuVjZ53F1RzXKQSUqC528SwMJU0c
        DapDOQIyKABZc36vrYrASYj0kQ==
X-Google-Smtp-Source: AK7set9QkWlafCS8xdBT35f959X0l/jxMZODWyOkbBqxHqFc75QW1s6iqvU/Ssd2Zqi/7HSubsKStw==
X-Received: by 2002:a5d:6a0e:0:b0:2ce:ac20:3634 with SMTP id m14-20020a5d6a0e000000b002ceac203634mr2142793wru.57.1678892116960;
        Wed, 15 Mar 2023 07:55:16 -0700 (PDT)
Received: from airbuntu (host86-168-251-3.range86-168.btcentralplus.com. [86.168.251.3])
        by smtp.gmail.com with ESMTPSA id w17-20020adfd4d1000000b002c70ce264bfsm4806723wrk.76.2023.03.15.07.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:55:16 -0700 (PDT)
Date:   Wed, 15 Mar 2023 14:55:14 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
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
Subject: Re: [RFC PATCH 0/3] sched/deadline: cpuset: Rework DEADLINE
 bandwidth restoration
Message-ID: <20230315145514.vjoypwadprvpgwam@airbuntu>
References: <20230315121812.206079-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230315121812.206079-1-juri.lelli@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 03/15/23 12:18, Juri Lelli wrote:
> Qais reported [1] that iterating over all tasks when rebuilding root
> domains for finding out which ones are DEADLINE and need their bandwidth
> correctly restored on such root domains can be a costly operation (10+
> ms delays on suspend-resume). He proposed we skip rebuilding root
> domains for certain operations, but that approach seemed arch specific
> and possibly prone to errors, as paths that ultimately trigger a rebuild
> might be quite convoluted (thanks Qais for spending time on this!).

Thanks a lot for this! And sorry I couldn't provide something better.

> 
> To fix the problem I instead would propose we
> 
>  1 - Bring back cpuset_mutex (so that we have write access to cpusets
>      from scheduler operations - and we also fix some problems
>      associated to percpu_cpuset_rwsem)
>  2 - Keep track of the number of DEADLINE tasks belonging to each cpuset
>  3 - Use this information to only perform the costly iteration if
>      DEADLINE tasks are actually present in the cpuset for which a
>      corresponding root domain is being rebuilt

nit:

Would you consider adding another patch to rename the functions?
rebuild_root_domains() and update_tasks_root_domain() are deadline accounting
specific functions and don't actually rebuild root domains.


Thanks!

--
Qais Yousef

> 
> This set is also available from
> 
> https://github.com/jlelli/linux.git deadline/rework-cpusets
> 
> Feedback is more than welcome.
> 
> Best,
> Juri
> 
> 1 - https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
> 
> Juri Lelli (3):
>   sched/cpuset: Bring back cpuset_mutex
>   sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
>   cgroup/cpuset: Iterate only if DEADLINE tasks are present
> 
>  include/linux/cpuset.h |  12 ++-
>  kernel/cgroup/cgroup.c |   4 +
>  kernel/cgroup/cpuset.c | 175 +++++++++++++++++++++++------------------
>  kernel/sched/core.c    |  32 ++++++--
>  4 files changed, 137 insertions(+), 86 deletions(-)
> 
> -- 
> 2.39.2
> 
