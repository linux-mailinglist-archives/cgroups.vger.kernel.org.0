Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09B2765330
	for <lists+cgroups@lfdr.de>; Thu, 27 Jul 2023 14:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjG0MFx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jul 2023 08:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjG0MFx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jul 2023 08:05:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030BC2D4F
        for <cgroups@vger.kernel.org>; Thu, 27 Jul 2023 05:05:52 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8ad356f03so5097335ad.1
        for <cgroups@vger.kernel.org>; Thu, 27 Jul 2023 05:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690459551; x=1691064351;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwmFLONIOYK7ou7AxfGRdP9bRNPLFN3Vwa8VGbk/YHs=;
        b=RNxfAkB6CcRACh5rhHmxAkp5vnYxV0AIKYF3lzqbywIos8+89XoAyQG6m7j5hjiqcM
         CPyTO3A/iGiPxbvlAI4tI/As2dYzjeRzzrvZHIW7x8C5FrH5LJVdY/4E4JVWFGwmsqpa
         A2fifj2199zlUpSaS5tbjy5FkA0apVj36cYh0Dlf/r/W/69gQ5orqMxT6quUdZZmiYQm
         G93bbPe1CZwS72g+ua9mlFrnYY/b2XsGr4rhqJ2NgSlNjn7IcppvsbppQ+D4YEA8tIxx
         8KzNLstuu1PHSSiky5j9/8sJnK+WDW84Tr46OyhI2Iz9NmKXbBAfE8PkV7e+kDdMjb2O
         1F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690459551; x=1691064351;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BwmFLONIOYK7ou7AxfGRdP9bRNPLFN3Vwa8VGbk/YHs=;
        b=RAcyaBMBe5yiDF42IfeJa6EQRE5Rp91M+SOJaIt+zcoZ+o59QKyIvoYpGOGPZ38z+I
         ou/HdsJ3xqAkv91WdWePxJouJcLWz/2I68b+6pPjPEdecPkQCUCDseHirZ+R4XTNzrCD
         +gzm379tRdkElDqs4t0FoGjUHjEhZ9fwmJ7u8k5OjzPMZdlEdTIqKRvWNUnR035iqn7D
         IRUmWM9Y9VQ8Kyj5aPriaUvecYD4e2hHVnwUPlQ/t9DxeJgPHX+e6QT5Nd+LLpSrCno7
         hHVM4024tEFWe9C+2pszyMf7bOVVdjo/spXTuFcCiCsxsJxyBdO9HT19L09ZnuiTa586
         c5Pw==
X-Gm-Message-State: ABy/qLb5QGeB6beSBCLNTVNUi4iOY36PSJkjmDP9EvgJ4P9sd/zR3tIm
        KEhZUhQ+YyhcUbPqC2O6wzjYFw==
X-Google-Smtp-Source: APBJJlFjJHOftyjOvJAGevlCpI+03ZofFgqqbos+NnQhswgcV75ZqE3w1ltXd+wMTUeA0zFvSuVFeQ==
X-Received: by 2002:a17:902:9a0b:b0:1b8:9f6a:39de with SMTP id v11-20020a1709029a0b00b001b89f6a39demr3969803plp.65.1690459551262;
        Thu, 27 Jul 2023 05:05:51 -0700 (PDT)
Received: from [10.85.115.102] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090aec0f00b0025bdc3454c6sm2703969pjy.8.2023.07.27.05.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 05:05:50 -0700 (PDT)
Message-ID: <3d2b68bf-9f40-c779-dcfd-4cf9939edecc@bytedance.com>
Date:   Thu, 27 Jul 2023 20:05:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [External] Re: [PATCH] cgroup/rstat: record the cumulative
 per-cpu time of cgroup and its descendants
From:   Hao Jia <jiahao.os@bytedance.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230717093612.40846-1-jiahao.os@bytedance.com>
 <ZLWb-LsBD041hMvr@slm.duckdns.org>
 <2655026d-6ae4-c14c-95b0-4177eefa434f@bytedance.com>
 <ZLcJ1nH8KzWzoQWj@slm.duckdns.org>
 <b4424767-dce7-08a9-3759-43cc9dfa4273@bytedance.com>
In-Reply-To: <b4424767-dce7-08a9-3759-43cc9dfa4273@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/7/19 Hao Jia wrote:
> 
> 
> On 2023/7/19 Tejun Heo wrote:
>> On Tue, Jul 18, 2023 at 06:08:50PM +0800, Hao Jia wrote:
>>> https://github.com/jiaozhouxiaojia/cgv2-stat-percpu_test/tree/main
>>
>> So, we run `stress -c 1` for 1 second in the asdf/test0 cgroup and
>> asdf/cpu.stat correctly reports the cumulative usage. After removing
>> asdf/test0 cgroup, asdf's usage_usec is still there. What's missing here?
> 
> Sorry, some of my expressions may have misled you.
> 
> Yes, cpu.stat will display the cumulative **global** cpu time of the 
> cgroup and its descendants (the corresponding kernel variable is 
> "cgrp->bstat"), and it will not be lost when the child cgroup is removed.
> 
> Similarly, we need a **per-cpu** variable to record the accumulated 
> per-cpu time of cgroup and its descendants.
> The existing kernel variable "cgroup_rstat_cpu(cgrp, cpu)->bstat" is not 
> satisfied, it only records the per-cpu time of cgroup itself,
> So I try to add "cgroup_rstat_cpu(cgrp, cpu)->cumul_bstat" to record 
> per-cpu time of cgroup and its descendants.
> 
> In order to verify the correctness of my patch, I wrote a kernel module 
> to compare the results of calculating the per-cpu time of cgroup and its 
> descendants in two ways:
>    Method 1. Traverse and add the per-cpu rstatc->bstat of cgroup and 
> each of its descendants.
>    Method 2. Directly read "cgroup_rstat_cpu(cgrp, cpu)->cumul_bstat" in 
> the kernel.
> 
> When the child cgroup is not removed, the results calculated by the two 
> methods should be equal.
> 
>> What are you adding?
> I want to add a **per-cpu variable** to record the cumulative per-cpu 
> time of cgroup and its descendants, which is similar to the variable 
> "cgrp->bstat", but it is a per-cpu variable.
> It is very useful and convenient for calculating the usage of cgroup on 
> each cpu, and its behavior is similar to the "cpuacct.usage*" interface 
> of cgroup v1.
> 

Hello Tejun,

I don't know if I explained it clearly, and do you understand what I mean?

Would you mind adding a variable like this to facilitate per-cpu usage 
calculations and migration from cgroup v1 to cgroup v2?

Thanks,
Hao
