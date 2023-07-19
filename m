Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0379E758BB4
	for <lists+cgroups@lfdr.de>; Wed, 19 Jul 2023 05:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGSDB5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Jul 2023 23:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjGSDBz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Jul 2023 23:01:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2831BCF
        for <cgroups@vger.kernel.org>; Tue, 18 Jul 2023 20:01:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so4291648b3a.0
        for <cgroups@vger.kernel.org>; Tue, 18 Jul 2023 20:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689735713; x=1692327713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irp3EPa33LK85QAbTktFpig5JEBTIWbUT4zOa4f8pKI=;
        b=B76s3XuCZrrPV4rWry1FvWh5MrG3pQP4cQK0XiWE+UaqR5NoSB6OcVsURRvVhqwujr
         4HcIOY1tuqZauHG+Z3H+EyGTqw5NfFK0nSMuIAYjNmwRMw4NoWEUHO88XEYAKGaXDKLR
         4LeexLiowvf11fQ5xGQrSNVQKmsESazLiHQo4Y7J+OOa6kfjoFP+v5Hbgd4TF4kjxMQJ
         IV7lHdZbBMgWsdR5PimtHWmeuo+Sc5D4LhaFJrr/opbxUdHUvHQSHn2sZ8800PEf1HXn
         17rUqRAm01DJV2Cm9PZG45JI+a+31nYWdkzv0qGsNYNS163N7PziWMMMeGBlNl/9gQTP
         uAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689735713; x=1692327713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=irp3EPa33LK85QAbTktFpig5JEBTIWbUT4zOa4f8pKI=;
        b=CM+hr2+x+iwBBAPFbPobpkzbNGVbpuabKbdlyxDyayMubNaCWxL8Jwm26FdMcoLqpT
         kqOqUhhcjRNWkxHPFYdfI0STDsWlLFBRtEr9m+888PILkcaSIkLO3D9J+Gc5QEKt/DeG
         Rmt0kOzifFcs+jFSku9Iv2zJ0SsimDR09CEPFf5aRrXxcVNPPaxVIUVxLIS2ycd/PG8v
         nVP7MvuTTj3qOyAgLigtADgmHEJuA0QN+0MJQdUzNjnYocycB2JV4PF08MqgN6O4LzSM
         bxQhYSai+Rloqvq9KdmTOBVrDzJfXDYOZBqGASaugPnRttYypHosQgWQ4KYp4qfNkDHT
         BuSw==
X-Gm-Message-State: ABy/qLagkOcd656JUnG7k7gYn76p8IkrjC0BQ7/RKE8K7BlXFbK95HWO
        y372b5Utp46GjKvRn3vpEY2eWg==
X-Google-Smtp-Source: APBJJlFGenWZLBnBPUNEL75np9UL/1Ou3Xpj6s1x1kDq4GWQrcTml0C4VCalszw7CxTdgW84Wywo0Q==
X-Received: by 2002:a05:6a20:7348:b0:133:6e6e:2b11 with SMTP id v8-20020a056a20734800b001336e6e2b11mr18317819pzc.2.1689735713474;
        Tue, 18 Jul 2023 20:01:53 -0700 (PDT)
Received: from [10.85.115.102] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7804a000000b0065dd1e7c2c1sm2170024pfm.63.2023.07.18.20.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 20:01:53 -0700 (PDT)
Message-ID: <b4424767-dce7-08a9-3759-43cc9dfa4273@bytedance.com>
Date:   Wed, 19 Jul 2023 11:01:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [External] Re: [PATCH] cgroup/rstat: record the cumulative
 per-cpu time of cgroup and its descendants
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230717093612.40846-1-jiahao.os@bytedance.com>
 <ZLWb-LsBD041hMvr@slm.duckdns.org>
 <2655026d-6ae4-c14c-95b0-4177eefa434f@bytedance.com>
 <ZLcJ1nH8KzWzoQWj@slm.duckdns.org>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <ZLcJ1nH8KzWzoQWj@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/7/19 Tejun Heo wrote:
> On Tue, Jul 18, 2023 at 06:08:50PM +0800, Hao Jia wrote:
>> https://github.com/jiaozhouxiaojia/cgv2-stat-percpu_test/tree/main
> 
> So, we run `stress -c 1` for 1 second in the asdf/test0 cgroup and
> asdf/cpu.stat correctly reports the cumulative usage. After removing
> asdf/test0 cgroup, asdf's usage_usec is still there. What's missing here?

Sorry, some of my expressions may have misled you.

Yes, cpu.stat will display the cumulative **global** cpu time of the 
cgroup and its descendants (the corresponding kernel variable is 
"cgrp->bstat"), and it will not be lost when the child cgroup is removed.

Similarly, we need a **per-cpu** variable to record the accumulated 
per-cpu time of cgroup and its descendants.
The existing kernel variable "cgroup_rstat_cpu(cgrp, cpu)->bstat" is not 
satisfied, it only records the per-cpu time of cgroup itself,
So I try to add "cgroup_rstat_cpu(cgrp, cpu)->cumul_bstat" to record 
per-cpu time of cgroup and its descendants.

In order to verify the correctness of my patch, I wrote a kernel module 
to compare the results of calculating the per-cpu time of cgroup and its 
descendants in two ways:
   Method 1. Traverse and add the per-cpu rstatc->bstat of cgroup and 
each of its descendants.
   Method 2. Directly read "cgroup_rstat_cpu(cgrp, cpu)->cumul_bstat" in 
the kernel.

When the child cgroup is not removed, the results calculated by the two 
methods should be equal.

> What are you adding?
I want to add a **per-cpu variable** to record the cumulative per-cpu 
time of cgroup and its descendants, which is similar to the variable 
"cgrp->bstat", but it is a per-cpu variable.
It is very useful and convenient for calculating the usage of cgroup on 
each cpu, and its behavior is similar to the "cpuacct.usage*" interface 
of cgroup v1.

Thanks,
Hao
