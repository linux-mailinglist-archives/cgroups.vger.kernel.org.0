Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3CE72DA1B
	for <lists+cgroups@lfdr.de>; Tue, 13 Jun 2023 08:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbjFMGrX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Jun 2023 02:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbjFMGrU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Jun 2023 02:47:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5CC171F
        for <cgroups@vger.kernel.org>; Mon, 12 Jun 2023 23:47:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b3ce6607cbso16458765ad.2
        for <cgroups@vger.kernel.org>; Mon, 12 Jun 2023 23:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686638830; x=1689230830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIt7yjEGnPmfSnSW7ej7mUT8lTrDwLThOBy1DhvgW+8=;
        b=cOnUQuywUfCqQExpNyKzwnRKwjIhzVJw961gL0WjaMUc+Sv1fmcEnvEmTIQY5ecCgP
         dio5TjN0kwdQPlpGXydTOGeB2Jwc9fCu8IM/ZJZfVOXmCfHY7hWy95VXW8COKOIncsY3
         YhRPSXXbHRhta7HJwgme9EHTPGSZRqp3nvHJ33t7hr5/oUUQvAubZRJ6ydRJQNZ0dik2
         uz9rxO/887/0vqThciHPE3nO4EFbXj/dtWgIb4AJp2eRSAyx9v+DHatVow/sGRdTgAf6
         663cJpcmuQEjmH/xCk9pAdmevfYljg9kOThryDFU6YHrUdDNwVQrMJutUGIvVc/8CyFd
         RS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686638830; x=1689230830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIt7yjEGnPmfSnSW7ej7mUT8lTrDwLThOBy1DhvgW+8=;
        b=f4xLhgf/HQPzn+74RWKoNNXPKFud2aFR3B9iEMqzZ4uXqn1EUIg7W2EDZ+zrAbDjdm
         9/ztP8QombxGYyU+O8W7SwfQ6YVGUiMaX2qICk0AXg1xxTftBzg/GnyAwGLgELVvl1G7
         yL4JqDDTFOBPh2xv4JZWxxm8n3pBnbN3UfBKBZhxlVAT9mxNzIPvKa8AYGF6S9QaICCc
         2V0G+OBKbbG1OLvKoPmbvARVR7P5JS2M5rUX4on0UN6hcs8VJT4O9aEr/aQpJa4+TwLN
         EKwp+ndKzqUTOU0yJEVMo4oYipk2Rn+ceENYloMeVl1FybktbPNwlCzR7yUxcFA2yVjp
         dYUw==
X-Gm-Message-State: AC+VfDy3EW2uFYkKvsYIAZ1UDzZva7durv6paFGpidAx4L+PBva25cM/
        Y6SmROmv3V37m0GfKKb/6VHOuA==
X-Google-Smtp-Source: ACHHUZ7bvw7gDPT5w7dEDzgHUImPLFOHNZvKiKPuXbCulZUw6cilIxqVTvrX9TmmTPnSHMz90PRE1w==
X-Received: by 2002:a17:903:41ce:b0:1b1:ac87:b47a with SMTP id u14-20020a17090341ce00b001b1ac87b47amr10834923ple.65.1686638829727;
        Mon, 12 Jun 2023 23:47:09 -0700 (PDT)
Received: from [10.254.80.225] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902b49400b001a980a23804sm9401790plr.4.2023.06.12.23.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 23:47:09 -0700 (PDT)
Message-ID: <554cd1a7-83a3-ae49-0770-2321c79472a1@bytedance.com>
Date:   Tue, 13 Jun 2023 14:46:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: Re: [RFC PATCH net-next] sock: Propose socket.urgent for sockmem
 isolation
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>,
        Eric Dumazet <edumazet@google.com>
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
 <CALvZod4BuY=kHnQov6Ho+UT0_0oG6nEX1Z-pU-f4Yt9w7-=5Hg@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CALvZod4BuY=kHnQov6Ho+UT0_0oG6nEX1Z-pU-f4Yt9w7-=5Hg@mail.gmail.com>
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

On 6/10/23 1:53 AM, Shakeel Butt wrote:
> On Fri, Jun 9, 2023 at 2:07 PM Eric Dumazet <edumazet@google.com> wrote:
>>
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
>>>    - Important jobs won't be priority inversed by the background
>>>      jobs in terms of socket memory pressure/limit.
>>>
>>>    - Global constrains are still effective, but only on non-urgent
>>>      jobs, useful for admins on policy decision on defrag.
>>>
>>> Comments/Ideas are welcomed, thanks!
>>>
>>
>> This seems to go in a complete opposite direction than memcg promises.
>>
>> Can we fix memcg, so that :
>>
>> Each group can use the memory it was provisioned (this includes TCP buffers)
>>
>> Global tcp_memory can disappear (set tcp_mem to infinity)
> 
> I agree with Eric and this is exactly how we at Google overcome the
> isolation issue. We have set tcp_mem to unlimited and enabled memcg
> accounting of network memory (by surgically incorporating v2 semantics
> of network memory accounting in our v1 environment).
> 
> I do have one question though:
> 
>> This proposal doesn't remove protocal's threshold as we found it
>> useful in restraining memory defragment.
> 
> Can you explain how you find the global tcp limit useful? What does
> memory defragment mean?

We co-locate different kinds of jobs with different priority in cgroups,
among which there are some background jobs can have lots of net data to
process, e.g. training jobs. These background jobs usually don't have
enough cpu bandwidth to consume the rx data in time if more important
jobs are running simultaneously. The data can be accumulated to eat up
some or all of the provisioned memory. These unreclaimable memory could
gradually fragment whole memory. We have already found many such cases
in production environment.

Maybe it's not proper to use the word 'defragment' as what we do is to
try to prevent from fragmentation rather than defrag like compaction.
With global tcp_mem pressure/limit and socket.urgent, we are able to
achieve this goal, at least at some extent.

And not only global tcp limit, the pressure threshold could also make
something like priority inversion happen. We monitored top20 priority
jobs and found their performance reduced by 2~9% when under global tcp
memory pressure (and sometimes the majority of sk_memory_allocated()
can be contributed by the low priority jobs). Although this has nothing
to do with 'memory defrag'.
