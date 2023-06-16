Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890687328D2
	for <lists+cgroups@lfdr.de>; Fri, 16 Jun 2023 09:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbjFPH2E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jun 2023 03:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjFPH2C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Jun 2023 03:28:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661D41FF9
        for <cgroups@vger.kernel.org>; Fri, 16 Jun 2023 00:27:36 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b3ce6607cbso3518525ad.2
        for <cgroups@vger.kernel.org>; Fri, 16 Jun 2023 00:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686900456; x=1689492456;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9nn1acQnmBrxxKtKr0fIyJP3cG1pp8tJvpkDo6e+3KI=;
        b=VRySI+g5OyhFq3+xJSt3XxtxCawIas+z+Lic4uM27Z/udSbrXCTBXMbmW3AmwIUo/g
         +j64SzyuI3pM64/QBgs69XNPGhOiAnEjKd6QtJiH1liw/ezSt6iX9shVnsA95OXnchOh
         9JvQ6UQRi5s4QwwA7Ua701jbMXoPDsn53P3dOg+psguoZBsLTojgzvwwyEy8UdhAuk71
         ojp4elmyT5+Dm/h2WqZsUNvIm63ZHNQ2j7KP4DKglGusmxmVk8EFDp2wFt7xMuAuKHbj
         IRMA0WEPlxSgbgehJyNbJGm9KVDEcvEkN2yP5QuROXtcc5BpmvVpV0ZDyvA8ehpR3gUI
         s+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686900456; x=1689492456;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nn1acQnmBrxxKtKr0fIyJP3cG1pp8tJvpkDo6e+3KI=;
        b=FY3NA37aoAre2gO6uamcDOrOsq84aSLOetwtHHmkDbTfDVLRYBRNhE7b+jI2lbNyAm
         UFgYkzQX7TP+llQEz+TomWhkAHTGUqD837xctsyMvWhewmdtU7nUwAoi+PVlrTl0ga6h
         UciJ8K1WFngI0pATHeT37gUMzQfWBscWV8XT7PEEql5Blf/hgpBpzV5zT8jCNZBfpL2n
         7lVCNTz7X+0jROEWrwwfCpfN2BdRIVWEyXXt+RJ+iOpEVFaXfCfcN68FVR9SHf/wy7q9
         zvsWH8/fVbf010n5a6pSIXW/zOH48OynBzp48ubYye01B3e+R5t70B48gaEpy+qKiYYP
         uXnA==
X-Gm-Message-State: AC+VfDwMmgour5Zb7FEqANjS+k2xmRqMtCPWkK2RLQ+Zp7pDp7PnjQAE
        eQA29wGaSPTLKGlAvLENtOWXpQ==
X-Google-Smtp-Source: ACHHUZ4Te5AMaBMV4npizDm9kAcBpyZOp8TbKLvyw8d9l0goDJOvXNEARkOTk+KEZVqTMAkytPeHmA==
X-Received: by 2002:a17:902:d386:b0:1b3:f8db:6f0c with SMTP id e6-20020a170902d38600b001b3f8db6f0cmr1151225pld.58.1686900455916;
        Fri, 16 Jun 2023 00:27:35 -0700 (PDT)
Received: from [10.254.80.225] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902ced200b001b02713a301sm10913613plg.181.2023.06.16.00.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:27:35 -0700 (PDT)
Message-ID: <42285da4-ea80-78ca-4c71-6562170614c8@bytedance.com>
Date:   Fri, 16 Jun 2023 15:27:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH net-next] sock: Propose socket.urgent for sockmem
 isolation
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Eric Dumazet <edumazet@google.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Christian Warloe <cwarloe@google.com>,
        Wei Wang <weiwan@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Xin Long <lucien.xin@gmail.com>,
        Jason Xing <kernelxing@tencent.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
References: <20230609082712.34889-1-wuyun.abel@bytedance.com>
 <CANn89i+Qqq5nV0oRLh_KEHRV6VmSbS5PsSvayVHBi52FbB=sKA@mail.gmail.com>
 <b879d810-132b-38ab-c13d-30fabdc8954a@bytedance.com>
Content-Language: en-US
In-Reply-To: <b879d810-132b-38ab-c13d-30fabdc8954a@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Gentle ping :)

Any suggestions for memory over-committed scenario?

Thanks,
	Abel

On 6/13/23 2:46 PM, Abel Wu wrote:
> On 6/9/23 5:07 PM, Eric Dumazet wrote:
>> On Fri, Jun 9, 2023 at 10:28 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>>
>>> This is just a PoC patch intended to resume the discussion about
>>> tcpmem isolation opened by Google in LPC'22 [1].
>>>
>>> We are facing the same problem that the global shared threshold can
>>> cause isolation issues. Low priority jobs can hog TCP memory and
>>> adversely impact higher priority jobs. What's worse is that these
>>> low priority jobs usually have smaller cpu weights leading to poor
>>> ability to consume rx data.
>>>
>>> To tackle this problem, an interface for non-root cgroup memory
>>> controller named 'socket.urgent' is proposed. It determines whether
>>> the sockets of this cgroup and its descendants can escape from the
>>> constrains or not under global socket memory pressure.
>>>
>>> The 'urgent' semantics will not take effect under memcg pressure in
>>> order to protect against worse memstalls, thus will be the same as
>>> before without this patch.
>>>
>>> This proposal doesn't remove protocal's threshold as we found it
>>> useful in restraining memory defragment. As aforementioned the low
>>> priority jobs can hog lots of memory, which is unreclaimable and
>>> unmovable, for some time due to small cpu weight.
>>>
>>> So in practice we allow high priority jobs with net-memcg accounting
>>> enabled to escape the global constrains if the net-memcg itselt is
>>> not under pressure. While for lower priority jobs, the budget will
>>> be tightened as the memory usage of 'urgent' jobs increases. In this
>>> way we can finally achieve:
>>>
>>>    - Important jobs won't be priority inversed by the background
>>>      jobs in terms of socket memory pressure/limit.
>>>
>>>    - Global constrains are still effective, but only on non-urgent
>>>      jobs, useful for admins on policy decision on defrag.
>>>
>>> Comments/Ideas are welcomed, thanks!
>>>
>>
>> This seems to go in a complete opposite direction than memcg promises.
>>
>> Can we fix memcg, so that :
>>
>> Each group can use the memory it was provisioned (this includes TCP 
>> buffers)
> 
> Yes, but might not be easy once memory gets over-committed (which is
> common in modern data-centers). So as a tradeoff, we intend to put
> harder constraint on memory allocation for low priority jobs. Or else
> if every job can use its provisioned memory, than there will be more
> memstalls blocking random jobs which could be the important ones.
> Either way hurts performance, but the difference is whose performance
> gets hurt.
> 
> Memory protection (memory.{min,low}) helps the important jobs less
> affected by memstalls. But once low priority jobs use lots of kernel
> memory like sockmem, the protection might become much less efficient.
> 
>>
>> Global tcp_memory can disappear (set tcp_mem to infinity)
