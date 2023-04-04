Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC7A6D6DA0
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 22:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjDDUJU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 16:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjDDUJT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 16:09:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5350198E
        for <cgroups@vger.kernel.org>; Tue,  4 Apr 2023 13:09:12 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso20785106wmo.0
        for <cgroups@vger.kernel.org>; Tue, 04 Apr 2023 13:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1680638951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHa2YuwGHdarAAiMk1og5R7L6o7idQvUnJX2z9eCeX4=;
        b=suhopf6Duc7KaYoyMZ4+D6ZLGbwrP5YpWGxvE6qzST17brhCVvVgvh0BhBnIeK89jy
         Azqz+miC0BBFkvUmhVnUOA0Q8m6QtHVrqsAlgwZQII75k0bHcHAPFQN2evjlRLmIqofl
         eUI96Bo8z5GlOkNLhKLLtA4W40vQ4tCDvno2MaGTbm7Rk6RXfTTjk6PWbzd0WUqgV8Nz
         5DTa/xhKTSCkXbrh9CsXi7qc5nJI59qwfYPE+oj5O/uTU/BpVZLxdLa5KAjl4WBtqxGV
         kf1eJF6FwXSywiLqrG68dKYSdbyBjyv2ZNMBhyhjJXIgvS6pifZ55Ae/AmVOxGbhQhfP
         s/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680638951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHa2YuwGHdarAAiMk1og5R7L6o7idQvUnJX2z9eCeX4=;
        b=0X46iUadMLbGuIes5X7ZRMQ3RVMS/QIFShAgK3yU1kc93Rqt6QGzuX38g/E+UOXJoy
         6OixwB6E33v9ykjWbXXUqFni0Km9qp3gQT87MMrezTvOBCFUZ2olLfsfir6qMFbv5H6x
         KmKMn2F8LVLZvi+xM9gIUwPrPFLiqQ1PYfMnZU+gDw5NRjdudOG7Vk1NnkDA7i771227
         zVadZ9LswJqH6AsxxUlfCv2MQ209ETowB32YdzchLNoel40q+emfpoDjNy24yjopLeEF
         8Xibylg5z+7G3au7K/pKXk+Pt6vlWK9Dcz2osP9CsyNkNKgQwVZr4SJWglFfbcva66Oi
         tUHg==
X-Gm-Message-State: AAQBX9dfL4ri1QU+T3/Ap375WAQOLxe7DCUUkpe/nWopHEAKZQPs9UQ3
        Sn5Cg6OYszuYO3UULGPb2SAqcw==
X-Google-Smtp-Source: AKy350ayY6UWE8QoWQs9523o/wjmvd24yVlTAR7wLRcGuj2htSaB5YsHfprNKlCcN+g85LraOqkxxA==
X-Received: by 2002:a05:600c:2b8c:b0:3f0:3a9a:516e with SMTP id j12-20020a05600c2b8c00b003f03a9a516emr3242864wmc.15.1680638951138;
        Tue, 04 Apr 2023 13:09:11 -0700 (PDT)
Received: from airbuntu (host86-163-35-64.range86-163.btcentralplus.com. [86.163.35.64])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003f0373d077csm2856990wmc.47.2023.04.04.13.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:09:10 -0700 (PDT)
Date:   Tue, 4 Apr 2023 21:09:09 +0100
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
Subject: Re: [PATCH 0/6] sched/deadline: cpuset: Rework DEADLINE bandwidth
 restoration
Message-ID: <20230404200909.krwq36nx36ktm2sh@airbuntu>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230329125558.255239-1-juri.lelli@redhat.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 03/29/23 14:55, Juri Lelli wrote:
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
>  01/06 - Rename functions deadline with DEADLINE accounting (cleanup
>          suggested by Qais) - no functional change
>  02/06 - Bring back cpuset_mutex (so that we have write access to cpusets
>          from scheduler operations - and we also fix some problems
>          associated to percpu_cpuset_rwsem)
>  03/06 - Keep track of the number of DEADLINE tasks belonging to each cpuset
>  04/06 - Create DL BW alloc, free & check overflow interface for bulk
>          bandwidth allocation/removal - no functional change 
>  05/06 - Fix bandwidth allocation handling for cgroup operation
>          involving multiple tasks
>  06/06 - Use this information to only perform the costly iteration if
>          DEADLINE tasks are actually present in the cpuset for which a
>          corresponding root domain is being rebuilt
> 
> With respect to the RFC posting [2]
> 
>  1 - rename DEADLINE bandwidth accounting functions - Qais
>  2 - call inc/dec_dl_tasks_cs from switched_{to,from}_dl - Qais
>  3 - fix DEADLINE bandwidth allocation with multiple tasks - Waiman,
>      contributed by Dietmar
> 
> This set is also available from
> 
> https://github.com/jlelli/linux.git deadline/rework-cpusets

Thanks a lot Juri!

I picked up the updated series and applied them to a 5.10 kernel and tested the
issue is fixed. Replied with my reviewed-and-tested-bys to some of the patches
already.

I haven't looked much at Dietmar's patches and while they were part of the
test, but there are no dl tasks on the system so I felt hesitant to say
I tested that part.


Cheers

--
Qais Yousef
