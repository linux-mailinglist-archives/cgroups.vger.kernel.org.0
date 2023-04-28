Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096FA6F167E
	for <lists+cgroups@lfdr.de>; Fri, 28 Apr 2023 13:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjD1LWV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Apr 2023 07:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjD1LWV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Apr 2023 07:22:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916B526B9
        for <cgroups@vger.kernel.org>; Fri, 28 Apr 2023 04:22:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2fc3f1d6f8cso6161023f8f.3
        for <cgroups@vger.kernel.org>; Fri, 28 Apr 2023 04:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1682680938; x=1685272938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJgSTzgu9YtliSGCYghLe0j5dXYcDcHesNq23aEuzOY=;
        b=JzUGb2nbnQdOEy+fCVy1d07ZMcLNqZcFnocE+qzql7z90iPjdixMT6M4TPzfRwLFwj
         4Fyqm5ke4Jk8pGzUBoA5KlH9jafEccsaekRgtzViTM8/v2fjj2ApEQdz0kOjx29YDiFf
         VLQFJu4z1dN2zyik04Hg5s5rYgl7Q2py/yW3yrB2An+MNwFmz6rRK0LC/m+muXZBxBck
         xlCbtJD8HiKGpWHCsnKdpYlZuoVefRHQlGQn520OE7NmX0OI+tCyNnVXEkd8Mprves0v
         hfqJFT3y6RAyCMsuSrDEyPsP3zaFQ9TEPG8pJ62+oQZ3ZdwcYS4dKrTunmcRkgPWlFu0
         FlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682680938; x=1685272938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJgSTzgu9YtliSGCYghLe0j5dXYcDcHesNq23aEuzOY=;
        b=UxxHmrUBkswI0NlAgkwhs52zPh0vyaYmurhIvmcuM+/GiqdD3/SGnWHcH4S/Aep/Jl
         s2uNNa89t8WAkquYRSVpYownGVkgivudH8rpc/+JDszDSF28G2AvI+7E1gsjMDUFbUTs
         Fqp54KjXCmWe1CNfNujRtVj4JdHFC9jN0KLTuWaNyhlRBjPfWz8W3nEfkZkfKOTXtret
         kXUFT0Tya4c5W5IRyzlMm1Y3HmsFAW/b7KcywjkeM0GNWvcmyOl7DLKbqxCYvSyzmeIZ
         rNXDqfDolBGpWOh3QNdtnVP6VU6F7bK4wVZPbgpOkygzRMDOj06h5zM6FzKAOQtEnjo2
         rRgw==
X-Gm-Message-State: AC+VfDwaQlFb7WcxkIJU6x3lBdJ16M1bYRxQsA1CDU4AnvneCjGBIRVX
        Yi7uXsW3nEMtCF/xDB9bNAlR0g==
X-Google-Smtp-Source: ACHHUZ46FKfHw7Wbog8Bl1L81IHin1MlXlUbC8ahQWZEJ0IXJgskxA8IQzIeuUmU0e33kSivR5zKWA==
X-Received: by 2002:a5d:56c6:0:b0:2ee:da1c:381a with SMTP id m6-20020a5d56c6000000b002eeda1c381amr3549607wrw.69.1682680938097;
        Fri, 28 Apr 2023 04:22:18 -0700 (PDT)
Received: from airbuntu ([104.132.45.110])
        by smtp.gmail.com with ESMTPSA id m2-20020a056000008200b002f53fa16239sm20851726wrx.103.2023.04.28.04.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 04:22:17 -0700 (PDT)
Date:   Fri, 28 Apr 2023 12:22:16 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
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
        Sudeep Holla <sudeep.holla@arm.com>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        zhiguo.niu@uniissoc.com
Subject: Re: [PATCH 2/6] sched/cpuset: Bring back cpuset_mutex
Message-ID: <20230428112216.cftofdixwbl4hufm@airbuntu>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-3-juri.lelli@redhat.com>
 <fa585497-5c6d-f0ed-bdda-c71a81d315ad@redhat.com>
 <ZEkRq9iGkYP/8T5w@localhost.localdomain>
 <d53a8af3-46e7-fe6e-5cdd-0421796f80d2@redhat.com>
 <CAB8ipk-ns=d+jNkKi1sjkSQmQidziCj34COkHZt6ZkRiG47HHA@mail.gmail.com>
 <ZEoN1wq47uhE201p@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZEoN1wq47uhE201p@localhost.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 04/27/23 07:53, Juri Lelli wrote:
> Hi,
> 
> On 27/04/23 10:58, Xuewen Yan wrote:
> > HI Juri,
> > 
> > Would this patch be merged tobe stable-rc? In kernel5.15, we also find
> > that the rwsem would be blocked for a long  time, when we change the
> > task's cpuset cgroup.
> > And when we revert to the mutex, the delay would disappear.
> 
> Honestly, I'm not sure. This change is mostly improving performance, but
> it is also true that it's fixing some priority inheritance corner cases.
> So, I'm not sure it qualifies for stable, but it would be probably good to
> have it there.

I'm under the impression we need the whole lot back to stable, no? I'm not sure
if we can decouple this patch from the rest.

FWIW, I did my testing on 5.15 - so we can definitely help with the backport
and testing for 5.15 and 5.10.


Thanks!

--
Qais Yousef
