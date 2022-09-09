Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38715B2C49
	for <lists+cgroups@lfdr.de>; Fri,  9 Sep 2022 04:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiIIC4K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Sep 2022 22:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIIC4J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Sep 2022 22:56:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BA7E2907
        for <cgroups@vger.kernel.org>; Thu,  8 Sep 2022 19:56:06 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so282116pjl.0
        for <cgroups@vger.kernel.org>; Thu, 08 Sep 2022 19:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=y9sXSthHGZ5f1Zt1Dk1XSseRcGMxGjw9uUNwvIsGKDI=;
        b=2mvvMyi/o6zU9l1XeMBP8CZ2WYZ3PjBpPUURYIw2udqDtXqevpogy7SMEEO7vF2Pq7
         NAozEsoicGmGag7zAZVo9vCukik1+3KTfWfh6MlTWeDH+8KxE9E7oN/TRenRXMu6owU3
         uJ4i2kWK8FeI2Ecq1Rv6p5H0DZ2XQUVkPnm+5iEqeeuA3Wv8Us8BFZU0TmtbXKk/GEOt
         M59HU7y22WrnC4S6rHNbKCyqutGTchEKLePXuN3RkOF/TEzz/CLB3MXwOBh2co4rp+B4
         TrRgLfuBWBj8NqcHZIM0fsk6dUV8c7/9BMctmrveupD9nqtc1pTs/cwDKlw8cBU+ddLM
         3huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=y9sXSthHGZ5f1Zt1Dk1XSseRcGMxGjw9uUNwvIsGKDI=;
        b=epooIDdmIye3zUF4+oqbkTW/aspYct7jCI/10l3uNa1P85IqlivoC7lnJmboIMHBAO
         Xqh2yioaz08EdEGh3mQk8/zkKrEHkXRhDH1OM043SBYwbsC9/VC4nnT8cTTHO7gsiTNs
         9ZKq8A27zlWOZdIqCwt5NTlg6xDUKWGxusZPzbvG+ngUwbZIhFERytqHK0WwycPC1APX
         tIXxPCKYjIehr70QbBOBPG1tGi00gvzqPblraVPbVHAs2W7yW+dacbUGvqQ/DkMqiMYf
         pi59z2taBksmrrBiTrCDq/MtHTxtnhTWr+LAVZyM2JaAZEBHyWh0TDxYNPYo2empLjAw
         LaBw==
X-Gm-Message-State: ACgBeo3aUa8dNNbYLRqpTOrEJaHNablpUPaBu5evw+u83YQ8IMxh6Mxj
        FT5JBXU0si0K8j/fPj/O47wHIw==
X-Google-Smtp-Source: AA6agR6RG4TKxRMoD9khjfuQrRTANMcH9NwgOzdGFd5iQJ7xz1K14X0x+gTN1m7I2VAoF75FFMespA==
X-Received: by 2002:a17:902:7791:b0:173:3dc2:3bb9 with SMTP id o17-20020a170902779100b001733dc23bb9mr11726542pll.153.1662692165711;
        Thu, 08 Sep 2022 19:56:05 -0700 (PDT)
Received: from [10.4.159.81] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 44-20020a17090a0faf00b00200461cfa99sm2501821pjz.11.2022.09.08.19.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 19:56:05 -0700 (PDT)
Message-ID: <fa5e5a79-aa1a-a009-d0c8-0a39380a71b6@bytedance.com>
Date:   Fri, 9 Sep 2022 10:55:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH] cgroup/cpuset: Add a new isolated
 mems.policy type.
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com,
        wuyun.abel@bytedance.com
References: <20220904040241.1708-1-hezhongkun.hzk@bytedance.com>
 <YxWbBYZKDTrkmlOe@dhcp22.suse.cz>
 <0e5f380b-9201-0f56-9144-ce8449491fc8@bytedance.com>
 <YxXUjvWmZoG9vVNV@dhcp22.suse.cz>
 <ca5e57fd-4699-2cec-b328-3d6bac43c8ef@bytedance.com>
 <Yxc+HZ6rjcR535oN@dhcp22.suse.cz>
 <93d76370-6c43-5560-9a5f-f76a8cc979e0@bytedance.com>
 <YxmXeC7te2HAi4dX@dhcp22.suse.cz>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <YxmXeC7te2HAi4dX@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> On Wed 07-09-22 21:50:24, Zhongkun He wrote:
> [...]
>>> Do you really need to change the policy itself or only the effective
>>> nodemask? Do you need any other policy than bind and preferred?
>>
>> Yes, we need to change the policy, not only his nodemask. we really want
>> policy is interleave, and extend it to weight-interleave.
>> Say something like the following
>> 			node       weight
>>      interleave:		 0-3       1:1:1:1  default one by one
>>      weight-interleave:   0-3       1:2:4:6  alloc pages by weight
>> 					    (User set weight.)
>> In the actual usecase, the remaining resources of each node are different,
>> and the use of interleave cannot maximize the use of resources.
> 
> OK, this seems a separate topic. It would be good to start by proposing
> that new policy in isolation with the semantic description.
> 
>> Back to the previous question.
>>> The question is how to implement that with a sensible semantic.
>>
>> Thanks for your analysis and suggestions.It is really difficult to add
>> policy directly to cgroup for the hierarchical enforcement. It would be a
>> good idea to add pidfd_set_mempolicy.
> 
> Are you going to pursue that path?
>   
>> Also, there is a new idea.
>> We can try to separate the elements of mempolicy and use them independently.
>> Mempolicy has two meanings:
>>      nodes:which nodes to use(nodes,0-3), we can use cpuset's effective_mems
>> directly.
>>      mode:how to use them(bind,prefer,etc). change the mode to a
>> cpuset->flags,such as CS_INTERLEAVE。
>> task_struct->mems_allowed is equal to cpuset->effective_mems,which is
>> hierarchical enforcement。CS_INTERLEAVE can also be updated into tasks，
>> just like other flags(CS_SPREAD_PAGE).
>> When a process needs to allocate memory, it can find the appropriate node to
>> allocate pages according to the flag and mems_allowed.
> 
> I am not sure I see the advantage as the mode and nodes are always
> closely coupled. You cannot really have one wihtout the other.
> 

Hi Michal, thanks for your suggestion and reply.

 > Are you going to pursue that path?

Yes，I'll give it a try as it makes sense to modify the policy dynamically.

Thanks.
