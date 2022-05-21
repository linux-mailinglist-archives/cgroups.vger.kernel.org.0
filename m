Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF5352FEAC
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 19:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiEUR6n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 13:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241561AbiEUR6k (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 13:58:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76BB644D0
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 10:58:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p22so19150202lfo.10
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 10:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=Q66Lzs3M5kOo/8VJybpmTwF9IYF2g+3dQsdn1hpx9NQ=;
        b=QCTfmXQGadwwlQM7hEIdm50KOXHwYga0OF/NGlbgOk3004UEHV2j12kft+vGwKwWir
         wRilZT8O9unVC1Xau1Q/xJ/oXjKUn097Ca9N477mVVb4T+K+qMPT9zUfhK0U696onLrH
         0os54gYtDt7QmTh2QJVp0zVX+VOwBBN3tTEji9jfwScy0wauB/MKvMR9weEQeZu99gcl
         S6q0/FQT5dVQFSiYwCJOEzJUVh2eXtxNXRkNhlzUj8VPMJ4+JVhxhMspOoclfnBCfr0o
         JdQNunNe+PYOALJWx7fSQNgpOjodEVLFipBmw9+pinSFfPkeFtfzzVFHvhyVXcuEKFmZ
         Cu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Q66Lzs3M5kOo/8VJybpmTwF9IYF2g+3dQsdn1hpx9NQ=;
        b=T59LLyARku2LmQHvoKXFpUrI3BCiFw5jvvkj1axjtt9CoNpKV/8hiAVhhXIa+zg1bI
         WuS1yh5qB7GS5toUxcAhBWCT+b456PLvJoD/S85+jnnoDj5i5QC42i8XL3b9jQUzqFWX
         UREjmhy5ocBlv7jhCq3tBGQA11BylygZYa8jZZQrxKyvpXYDIe/e2hjGc2dLB3vHgqoz
         X87x0+Ic96OJDYCo4tftpTNa2AqMUF5uY8jSFeBsuKYc49DBN/HMsZWe4PDpiHtBtWsD
         iFEc2y1b+LxBvs53nbD/C+tH//GOxACAR3Pw2EfCZybpsWRRGu6l5TKgJ3MNs1MvLDaj
         DyWw==
X-Gm-Message-State: AOAM530OLWCX7nASpL1wLilsXn6MJdqI5F1O8N4FpiJwUgInLC6dXCCm
        dY743U5y8mfRpG3BKCtHv5VKWQ==
X-Google-Smtp-Source: ABdhPJyB9B+bG3bgVBta8/fXq6YFYitnbNXhL8nlLKB83LEun2rtCldE5J3VJc5xMYhCSzqLebY3cg==
X-Received: by 2002:a05:6512:3403:b0:475:afe3:740b with SMTP id i3-20020a056512340300b00475afe3740bmr10998844lfr.436.1653155917305;
        Sat, 21 May 2022 10:58:37 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id r5-20020a2e94c5000000b0024f3d1dae91sm799624ljh.25.2022.05.21.10.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 10:58:36 -0700 (PDT)
Message-ID: <6c980ae0-9731-ba89-d04f-cd55a6badc24@openvz.org>
Date:   Sat, 21 May 2022 20:58:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH mm v2 6/9] memcg: enable accounting for percpu allocation
 of struct cgroup_rstat_cpu
Content-Language: en-US
From:   Vasily Averin <vvs@openvz.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
References: <Yn6aL3cO7VdrmHHp@carbon>
 <c0d01d6e-530c-9be3-1c9b-67a7f8ea09be@openvz.org>
In-Reply-To: <c0d01d6e-530c-9be3-1c9b-67a7f8ea09be@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/21/22 19:38, Vasily Averin wrote:
> struct cgroup_rstat_cpu is percpu allocated for each new cgroup and
> can consume a significant portion of all allocated memory on nodes
> with a large number of CPUs.
> 
> Common part of the cgroup creation:
> Allocs  Alloc   $1*$2   Sum	Allocation
> number  size
> --------------------------------------------
> 16  ~   352     5632    5632    KERNFS
> 1   +   4096    4096    9728    (cgroup_mkdir+0xe4)
> 1       584     584     10312   (radix_tree_node_alloc.constprop.0+0x89)
> 1       192     192     10504   (__d_alloc+0x29)
> 2       72      144     10648   (avc_alloc_node+0x27)
> 2       64      128     10776   (percpu_ref_init+0x6a)
> 1       64      64      10840   (memcg_list_lru_alloc+0x21a)
> percpu:
> 1   +   192     192     192     call_site=psi_cgroup_alloc+0x1e
> 1   +   96      96      288     call_site=cgroup_rstat_init+0x5f
> 2       12      24      312     call_site=percpu_ref_init+0x23
> 1       6       6       318     call_site=__percpu_counter_init+0x22
> 
>  '+' -- to be accounted,
>  '~' -- partially accounted
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> ---
>  kernel/cgroup/rstat.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 24b5c2ab5598..f76cb63ae2e0 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -257,7 +257,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
>  
>  	/* the root cgrp has rstat_cpu preallocated */
>  	if (!cgrp->rstat_cpu) {
> -		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
> +		cgrp->rstat_cpu = alloc_percpu_gfp(struct cgroup_rstat_cpu
"," was lost here
> +						   GFP_KERNEL_ACCOUNT);
>  		if (!cgrp->rstat_cpu)
>  			return -ENOMEM;
>  	}

