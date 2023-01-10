Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0792C664139
	for <lists+cgroups@lfdr.de>; Tue, 10 Jan 2023 14:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjAJNHz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Jan 2023 08:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjAJNHx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Jan 2023 08:07:53 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A583158D2B
        for <cgroups@vger.kernel.org>; Tue, 10 Jan 2023 05:07:31 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 36so8165164pgp.10
        for <cgroups@vger.kernel.org>; Tue, 10 Jan 2023 05:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0b3RSYe8mQauTsHJUs6ykMcTgur4za2xftvbQNqIJa0=;
        b=RLUlg0vAPGTz4hMSALnOAbA95CQ2QhiAPu67CW1t5ndi5fYQvoHNRfl2s9mmbfxynC
         n5Hl26i2wnPo3Po7VVrtnQueuJ9LNMFdRz54SOR0UzQpuEPMsDS42Z/bO4BEb4COnlqZ
         Yhl/RGwxFnAkY+cH1otEhavspwfCl0FOYahc2kH+YxTr3TQTFwyb+jOHwd6AbOmhbT/k
         UrCTqXrRr5OpYjY6+L/mYlkYPUtgEqwUoG1lp5ywtifFjrif5++oGbE8puNRSkItokP8
         ieNDdz1XkqTFKhhlST3mTca31Q50kVpZqKIC7YfgyJEYf+TFUH4gcW9m3mBKjOdd53dv
         s+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0b3RSYe8mQauTsHJUs6ykMcTgur4za2xftvbQNqIJa0=;
        b=yRC4LAxrhsFKzu9FHxzLfM7H/rzLcy28pYX5ZfHIwCtfWQyyWLI1jfyqlHUAsD4W25
         uJXCCMibJdmxJSYGXQtcqOOcsM2/R7823L7sRqGkACuEG4IlGEDejOm/pKW6zRXfDNfw
         tNR+6x1bDo5CXNce4Qzpcv753qIWnkNo1ozC+m5ZXzB3p0e/IoUZ2M4YsOmJQ5cjio9U
         fcBuQvJh0my0EWngLOeJqDEVMm7xZPS1eua3KdM1jdj3x1oihivlU7T276huuiSMvBpD
         noJzbXVmd+aMtxJScaDezFE/3AzNBUbMvdWjc/1IP76arwWkN57vE1NHUWOE9p5QZUk6
         k1kA==
X-Gm-Message-State: AFqh2kq0mAq3uGQBOUNGOxDCaPCDfF/3P17w7t9DWRt+VgDbMkU1+I/j
        u1BBxhjNt8nZ7hAbnJNz5YRmkQ==
X-Google-Smtp-Source: AMrXdXuOnsxeqzWi+BrT/XazxVd/FkhSHxizdXq9xmqS2MG3LGJFCe4KApI5JgYxg1Fm6XPKXt5zLA==
X-Received: by 2002:aa7:85c8:0:b0:588:14ce:7e64 with SMTP id z8-20020aa785c8000000b0058814ce7e64mr7017731pfn.30.1673356051158;
        Tue, 10 Jan 2023 05:07:31 -0800 (PST)
Received: from [10.3.157.223] ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id v67-20020a622f46000000b00581ad007a9fsm8004776pfv.153.2023.01.10.05.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 05:07:30 -0800 (PST)
Message-ID: <f9b8e682-92aa-c39c-4d91-d77d104e0767@bytedance.com>
Date:   Tue, 10 Jan 2023 21:07:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [External] Re: [PATCH v3] blk-throtl: Introduce sync and async
 queues for blk-throtl
To:     Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
 <20230106153813.4ttyuikzaagkk2sc@quack3> <Y7hTHZQYsCX6EHIN@slm.duckdns.org>
 <c839ba6c-80ac-6d92-af64-5c0e1956ae93@bytedance.com>
 <Y7hlX4T1UOmQHiGf@slm.duckdns.org>
 <e499f088-8ed9-2e19-b2e5-efaa4f9738f0@bytedance.com>
 <Y7xYJfRLSMYk9tj9@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <Y7xYJfRLSMYk9tj9@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2023/1/10 上午2:08, Tejun Heo 写道:
> Hello,
> 
> On Sat, Jan 07, 2023 at 12:44:35PM +0800, hanjinke wrote:
>> For cost.model setting, We first use the tools iocost provided to test the
>> benchmark model parameters of different types of disks online, and then save
>> these benchmark parameters to a parametric Model Table. During the
>> deployment process, pull and set the corresponding model parameters
>> according to the type of disk.
>>
>> The setting of cost.qos should be considered slightly more，we need to make
>> some compromises between overall disk throughput and io latency.
>> The average disk utilization of the entire disk on a specific business and
>> the RLA（if it is io sensitive） of key businesses will be taken as
>> important input considerations. The cost.qos will be dynamically fine-tuned
>> according to the health status monitoring of key businesses.
> 
> Ah, I see. Do you use the latency targets and min/max ranges or just fixate
> the vrate by setting min == max?

Currently we use the former.

> 
>> For cost.weight setting, high-priority services  will gain greater
>> advantages through weight settings to deal with a large number of io
>> requests in a short period of time. It works fine as work-conservation
>> of iocost works well according to our observation.
> 
> Glad to hear.
> 
>> These practices can be done better and I look forward to your better
>> suggestions.
> 
> It's still in progress but resctl-bench's iocost-tune benchmark is what
> we're starting to use:
> 
>   https://github.com/facebookexperimental/resctl-demo/blob/main/resctl-bench/doc/iocost-tune.md
> 
> The benchmark takes like 6 hours and what it does is probing the whole vrate
> range looking for behavior inflection points given the scenario of
> protecting a latency sensitive workload against memory leak. On completion,
> it provides several solutions based on the behavior observed.
> 
> The benchmark is destructive (to the content on the target ssd) and can be
> tricky to set up. There's installable image to help setting up and running
> the benchmark:
> 
>   https://github.com/iocost-benchmark/resctl-demo-image-recipe/actions
> 
> The eventual goal is collecting these benchmark results in the following git
> repo:
> 
>   https://github.com/iocost-benchmark/iocost-benchmarks
> 
> which generates hwdb files describing all the found solution and make
> systemd apply the appropriate configuration on boot automatically.
> 
> It's still all a work in progress but hopefully we should be able to
> configure iocost reasonably on boot on most SSDs.
> 
> Thanks.
> 

These methodologies are worthy of our study and will definitely help our 
future deployment of iocost. Thanks a lot.

Thanks.

