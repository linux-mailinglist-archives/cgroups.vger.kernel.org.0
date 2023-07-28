Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C724766D8C
	for <lists+cgroups@lfdr.de>; Fri, 28 Jul 2023 14:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjG1Mpj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jul 2023 08:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjG1Mpj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jul 2023 08:45:39 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC05CE78
        for <cgroups@vger.kernel.org>; Fri, 28 Jul 2023 05:45:13 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a426e70575so1383179b6e.0
        for <cgroups@vger.kernel.org>; Fri, 28 Jul 2023 05:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690548313; x=1691153113;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dZhd6Z+1TRytPTwd9c5Pl7JGaMAas8iSnbHYztoIY+I=;
        b=TgN5QPu9YYBwRx1weOr/WieWPm5UErXX8Yl2ZnYRnuydyDECUF4gTKm/YstmY5l56B
         +wnzxryDqAXht0H4tNvFivjOPlHsYMJXJT16Ya4FZKhXjvLU+tu2ANlM2Hnggey8OizN
         kDKwNfr3/H1DGnnb8CFZ3Da0gxp96slSEQTjWN+YY002DAwTEY+vBkU5qAN2XCWJu/gT
         esYhuHCDSJ7t6D7godXKexmEfaiKr8p6lUWl2qVGZEu58BKWOAgb1Dxwj7NUCNOh0esu
         0woAXuC1jDCs0SqpMA1m8vH5WR568aWfDh6ShMuQiWhHo8Rn/ZYpvSR8Y3tRNJRX9GW7
         st9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690548313; x=1691153113;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZhd6Z+1TRytPTwd9c5Pl7JGaMAas8iSnbHYztoIY+I=;
        b=WZ6lSCU3JQGJrUGKuMXkFHRto2iQn8xH0gafe/KLJhN0gjDialTIRzLyKzINcKUTpL
         D12Jj928XeS1wFXWpQ4MNOMJThBtvJNcotGGji33Zs1Tl7yEBxJxOqt2Vtf9+JB3JcFG
         E2CirU4O4g80rXHtAFWH/6GyjS7RVi2JFjFPDNhbEavhFQ5aJWQtGkIDxiC2t/0JC1Hj
         kYMandm0Lhn4nsW6L3e0S5gPQK9W/hLaHVHy8P4ApF/F5k717LjvJ4fsecF1xzWR/E0P
         u0zHTlDTO0JxDSQy9dZaZnzfLUFCZzpo8QwOk/Bp97sDOhnUqmjDkpaiOIHyxf5+JnWU
         Wb9A==
X-Gm-Message-State: ABy/qLYnb5cfGOKDMXGzahzebwIbROIi8LkqPCf0God8d3g40+NNUgjo
        N4WkRzNsUGAoSzW0V3n3lSrfqg==
X-Google-Smtp-Source: APBJJlF4g9xuHBTxSNvuB+rX75MGVV2iZ9M7FOEM/W01jL7dos+/qDXYGULWfOSaRyQ0x7r2zW5CBw==
X-Received: by 2002:a05:6808:e82:b0:3a4:6b13:b721 with SMTP id k2-20020a0568080e8200b003a46b13b721mr2742390oil.46.1690548313043;
        Fri, 28 Jul 2023 05:45:13 -0700 (PDT)
Received: from [10.254.173.0] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id ep11-20020a17090ae64b00b00262eccfa29fsm4145574pjb.33.2023.07.28.05.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 05:45:12 -0700 (PDT)
Message-ID: <e2929fb0-35e6-b213-0ba1-15fa7282e3f4@bytedance.com>
Date:   Fri, 28 Jul 2023 20:45:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.1
From:   Abel Wu <wuyun.abel@bytedance.com>
Subject: Re: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators of
 sockmem pressure
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Breno Leitao <leitao@debian.org>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
 <ZLsg1wklldKkVI2Z@P9FQF9L96D.corp.robot.car>
 <58e75f44-16e3-a40a-4c8a-0f61bbf393f9@bytedance.com>
 <ZMCLTQgVT68jwbVh@P9FQF9L96D>
 <29de901f-ae4c-a900-a553-17ec4f096f0e@bytedance.com>
 <ZMG39B6B41yLAu9r@P9FQF9L96D>
Content-Language: en-US
In-Reply-To: <ZMG39B6B41yLAu9r@P9FQF9L96D>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/27/23 8:19 AM, Roman Gushchin wrote:
> On Wed, Jul 26, 2023 at 04:44:24PM +0800, Abel Wu wrote:
>> On 7/26/23 10:56 AM, Roman Gushchin wrote:
>>> On Mon, Jul 24, 2023 at 11:47:02AM +0800, Abel Wu wrote:
>>>> Hi Roman, thanks for taking time to have a look!
>>>>>
>>>>> Overall I think it's a good idea to clean these things up and thank you
>>>>> for working on this. But I wonder if we can make the next step and leave only
>>>>> one mechanism for both cgroup v1 and v2 instead of having this weird setup
>>>>> where memcg->socket_pressure is set differently from different paths on cgroup
>>>>> v1 and v2.
>>>>
>>>> There is some difficulty in unifying the mechanism for both cgroup
>>>> designs. Throttling socket memory allocation when memcg is under
>>>> pressure only makes sense when socket memory and other usages are
>>>> sharing the same limit, which is not true for cgroupv1. Thoughts?
>>>
>>> I see... Generally speaking cgroup v1 is considered frozen, so we can leave it
>>> as it is, except when it creates an unnecessary complexity in the code.
>>
>> Are you suggesting that the 2nd patch can be ignored and keep
>> ->tcpmem_pressure as it is? Or keep the 2nd patch and add some
>> explanation around as you suggested in last reply?
> 
> I suggest to split a code refactoring (which is not expected to bring any
> functional changes) and an actual change of the behavior on cgroup v1.
> Re the refactoring: I see a lot of value in adding comments and make the
> code more readable, I don't see that much value in merging two variables.
> But if it comes organically with the code simplification - nice.

I see, thanks for the clarification!

> 
>>> I'm curious, was your work driven by some real-world problem or a desire to clean
>>> up the code? Both are valid reasons of course.
>>
>> We (a cloud service provider) are migrating users to cgroupv2,
>> but encountered some problems among which the socket memory
>> really puts us in a difficult situation. There is no specific
>> threshold for socket memory in cgroupv2 and relies largely on
>> workloads doing traffic control themselves.
>>
>> Say one workload behaves fine in cgroupv1 with 10G of ->memory
>> and 1G of ->tcpmem, but will suck (or even be OOMed) in cgroupv2
>> with 11G of ->memory due to burst memory usage on socket.
>>
>> It's rational for the workloads to build some traffic control
>> to better utilize the resources they bought, but from kernel's
>> point of view it's also reasonable to suppress the allocation
>> of socket memory once there is a shortage of free memory, given
>> that performance degradation is better than failure.
> 
> Yeah, I can see it. But Idk if it's too workload-specific to have
> a single-policy-fits-all-cases approach.
> E.g. some workloads might prefer to have a portion of pagecache
> being reclaimed.
> What do you think?

Now the memcg is considered to be under pressure if the number of
pages reclaimed is much less than desired. I doubt it could be a
win in such case to spend more time on reclaiming while letting
socket continue to allocate memory (which could make things worse),
compared to relieving reclaim pressure and putting time on its real
work.

Best,
	Abel
