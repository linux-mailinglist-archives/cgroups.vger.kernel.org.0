Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09D14D1E46
	for <lists+cgroups@lfdr.de>; Tue,  8 Mar 2022 18:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiCHROe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Mar 2022 12:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348641AbiCHROd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Mar 2022 12:14:33 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8B822515;
        Tue,  8 Mar 2022 09:13:36 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id o26so17017322pgb.8;
        Tue, 08 Mar 2022 09:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uo3YhUMbdaePnU6cb6jJ/A2E7AHW+1jZYWhnJKd7Sk8=;
        b=P4W2XgegdlmpihJbSspGRSZg95TKVpuUFPXs2xm3bmYsLkzpnCFD8V8AYKzsxGW0cP
         S/IhhZBfcKVEKOCNK9ws2cYY5BQWpxdtRmP8AKvfjdKBGiZ71RZpuiWmvd1aWOL9/Lae
         A2NMN5Mb9mVCnq9PoDhT5+9VSSLzlFatI1X/QSlVO4CBeCM8a/K+z02OsYDIcw9OxUfa
         8/vSQ00ge8dPW0NM/TF2EuUNOqDKggkq4SbDQ21FnDAPSEe750WzGf8E7Jq+zVGDu1GX
         YDw+Lwg3Pwxx+/hNBD7B0irfd+nWC/JyJJJAI5YuDEQZOZSTLHXcJyz+RInJzu7RlRAI
         IBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uo3YhUMbdaePnU6cb6jJ/A2E7AHW+1jZYWhnJKd7Sk8=;
        b=bPP0Rz8eWb17k97ASUxEIcr3ydfKGOJTwtOYBh22egxTkisqIYZTXaqYMUdviTVw+N
         UWEG+cBx77w5esfXkHSLpliIvuj1J8SfzkfRsp+qz/fvJ3aq0osuue9lFS0i+HZKMU2R
         FoXvdvbPK+R/lAt4J04I1UOYTaNqoTnulYmuE7et0rx8mctmofIl9UlW1XND/vpdgolI
         wczNv5ggzfFnalpomA5JbbbJoPTQJ6x41IvWb8mWaWaYSPz2AALaMujfL8Q4yLAI8KSd
         APlSvf7tT+16l8QCJmKVXSrcTorvRDvB16u9iICCmAhIeO0fdFSugCPjHvr05I39OMXN
         tFgA==
X-Gm-Message-State: AOAM5335XOGD3jhhjLVbeZYJs5JTv6oZ8yq1MlpjB12psdzcbvusf31m
        sXvOBagD5lgka/unhRpI9uw=
X-Google-Smtp-Source: ABdhPJwiD4bS9auZXfFq1SaSTK4AukkNRczlbBRrL9XVoGcs96/LK3AH+2ndsakyBnrYsnMICnGAcA==
X-Received: by 2002:a63:114:0:b0:380:29f7:a97a with SMTP id 20-20020a630114000000b0038029f7a97amr11133349pgb.361.1646759616090;
        Tue, 08 Mar 2022 09:13:36 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id b5-20020a056a000cc500b004f6ff0f51f4sm8336121pfv.5.2022.03.08.09.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:13:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 8 Mar 2022 07:13:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michael Wang <yun.wang@linux.alibaba.com>,
        Cruz Zhao <cruzzhao@linux.alibaba.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Vipin Sharma <vipinsh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Introduce group balancer
Message-ID: <YieOvaqJeEW2lta/@slm.duckdns.org>
References: <20220308092629.40431-1-dtcccc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308092629.40431-1-dtcccc@linux.alibaba.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Mar 08, 2022 at 05:26:25PM +0800, Tianchen Ding wrote:
> Modern platform are growing fast on CPU numbers. To achieve better
> utility of CPU resource, multiple apps are starting to sharing the CPUs.
> 
> What we need is a way to ease confliction in share mode,
> make groups as exclusive as possible, to gain both performance
> and resource efficiency.
> 
> The main idea of group balancer is to fulfill this requirement
> by balancing groups of tasks among groups of CPUs, consider this
> as a dynamic demi-exclusive mode. Task trigger work to settle it's
> group into a proper partition (minimum predicted load), then try
> migrate itself into it. To gradually settle groups into the most
> exclusively partition.
> 
> GB can be seen as an optimize policy based on load balance,
> it obeys the main idea of load balance and makes adjustment
> based on that.
> 
> Our test on ARM64 platform with 128 CPUs shows that,
> throughput of sysbench memory is improved about 25%,
> and redis-benchmark is improved up to about 10%.

The motivation makes sense to me but I'm not sure this is the right way to
architecture it. We already have the framework to do all these - the sched
domains and the load balancer. Architecturally, what the suggested patchset
is doing is building a separate load balancer on top of cpuset after using
cpuset to disable the existing load balancer, which is rather obviously
convoluted.

* AFAICS, none of what the suggested code does is all that complicated or
  needs a lot of input from userspace. it should be possible to parametrize
  the existing load balancer to behave better.

* If, for some reason, you need more customizable behavior in terms of cpu
  allocation, which is what cpuset is for, maybe it'd be better to build the
  load balancer in userspace. That'd fit way better with how cgroup is used
  in general and with threaded cgroups, it should fit nicely with everything
  else.

Thanks.

-- 
tejun
