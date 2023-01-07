Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D82B660C78
	for <lists+cgroups@lfdr.de>; Sat,  7 Jan 2023 05:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbjAGEpJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Jan 2023 23:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbjAGEpE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Jan 2023 23:45:04 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E488462E
        for <cgroups@vger.kernel.org>; Fri,  6 Jan 2023 20:44:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id q64so3453108pjq.4
        for <cgroups@vger.kernel.org>; Fri, 06 Jan 2023 20:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeUPS2iKNE5OrN4vW8ZJQleZwh3WJYgGdDBNvXHEJYc=;
        b=OGcIprLg/imeJCuDYwJBLKaKHytu+oosVJno5w7Yr3wgiFgmnzXnr1Nl+0w6dZkuyj
         bVWz/aMUwD5CuH5eRpIOyK9e60S5jbQ8rDUhqFOksAKbNucMI6FMlI6PuVkyS847mbQS
         lYrSoXAVHGN8q9pRHISuHJO2Dmf1gDsJ/8tILU2M10Jm3/73zvNFOJ61PUtHJX5c7tF7
         B6YLPAHPVtXAsti0eDHGXuyKa4kCHvyeoLqkTBM/b5YXCi+SMlSSvdIPh96dTo02SLVq
         hsWCrzmn0M0liCwxM2oJDLgOLTk9d0X2uG4kYtSCQftSFfueOy3Q65jwAGwlUV7sH4SP
         8LMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZeUPS2iKNE5OrN4vW8ZJQleZwh3WJYgGdDBNvXHEJYc=;
        b=5/SZUvXkSIKewv16A0XRoObjPHjKjdSPAH8MQjeOwHcadru8ppIlXU5ibK/ZbaTUrT
         yPGq8nk7haKEwSdUjdEG/rNSONpBF3HHNz/GG77Z/LV/vFkEhMN+vmVM8cV3ZRDtlvFt
         SB6RKJ6qoCDmJ0GL+7uC1/UxJ9cTjGJH3yFVmhrZrStKkAUijvNZRBXG1daY5YLY9kPf
         CEept8/CBORUykSlfEfnMzhCUqpRNVCe6EQI++GOmjYl513fCk+0EyPswPZgxNhUbOCv
         QL8ifSMzapgzj6NlOcdNPpzX4eoz6kTL6SWAimfw5pBMxc0/UQ9Dtg1puUTj67klMVf+
         6PSQ==
X-Gm-Message-State: AFqh2kqDf93LH3dfeD0hvuQSei28tzGuh1B+Ujz1C77vBcAjrkc0klZr
        jfElv3qNNIl5i3aI5B8wFDjUIg==
X-Google-Smtp-Source: AMrXdXtXiqi91oaCK8p4McWzuikKF9pIEcPcAY6x5BQyBDS6NQ0R2lbIDYHL/bt6PClbzNw4gptUOw==
X-Received: by 2002:a05:6a20:3d16:b0:9d:efbf:48c7 with SMTP id y22-20020a056a203d1600b0009defbf48c7mr84529944pzi.11.1673066680306;
        Fri, 06 Jan 2023 20:44:40 -0800 (PST)
Received: from [10.255.208.163] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902d14100b00186b3c3e2dasm1722418plt.155.2023.01.06.20.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 20:44:40 -0800 (PST)
Message-ID: <e499f088-8ed9-2e19-b2e5-efaa4f9738f0@bytedance.com>
Date:   Sat, 7 Jan 2023 12:44:35 +0800
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
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <Y7hlX4T1UOmQHiGf@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2023/1/7 上午2:15, Tejun Heo 写道:
> Hello,
> 
> On Sat, Jan 07, 2023 at 02:07:38AM +0800, hanjinke wrote:
>> In our internal scenario, iocost has been deployed as the main io isolation
>> method and is gradually spreading。
> 
> Ah, glad to hear. If you don't mind sharing, how are you configuring iocost
> currently? How do you derive the parameters?
> 

For cost.model setting, We first use the tools iocost provided to test 
the benchmark model parameters of different types of disks online, and 
then save these benchmark parameters to a parametric Model Table. During 
the deployment process, pull and set the corresponding model parameters 
according to the type of disk.

The setting of cost.qos should be considered slightly more，we need to 
make some compromises between overall disk throughput and io latency.
The average disk utilization of the entire disk on a specific business 
and the RLA（if it is io sensitive） of key businesses will be taken as 
important input considerations. The cost.qos will be dynamically 
fine-tuned according to the health status monitoring of key businesses.

For cost.weight setting, high-priority services  will gain greater 
advantages through weight settings to deal with a large number of io 
requests in a short period of time. It works fine as work-conservation
of iocost works well according to our observation.

These practices can be done better and I look forward to your better 
suggestions.


> blk-throttle has a lot of issues which may be difficult to address. Even the
> way it's configured is pretty difficult to scale across different hardware /
> application combinations and we've neglected its control performance and
> behavior (like handling of shared IOs) for quite a while.
> 
> While iocost's work-conserving control does address a lot of the use cases
> we see today, it's likely that we'll need hard limits more in the future
> too. I've been thinking about implementing io.max on top of iocost. There
> are some challenges around dynamic vrate adj semantics but it's kinda
> attractive because iocost already has the concept of total device capacity.

Indeed in our multi-tenancy scenario, the hard limits are necessary.

Jinke
Thanks.

