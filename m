Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFB440A386
	for <lists+cgroups@lfdr.de>; Tue, 14 Sep 2021 04:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbhINCZU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 22:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbhINCZT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 22:25:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C33C061574;
        Mon, 13 Sep 2021 19:24:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w19so6315586pfn.12;
        Mon, 13 Sep 2021 19:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6bHeWjV3HGfhLob3U0wkIQ8wiGJnN6iWzgMWgki4WRA=;
        b=KDkT9e32/Y9iJjHHqek7M4egxwe+SRvGz5YRzUEkoBI+GO2NmGzFfAIzOi1trat/2d
         iC6xrRNW6XHGrwX5yKWRp4xAO575uxyYMHEyAKHtl37YY/360gEy3hx/UvRKMqJU14th
         4Nd1+yHQkAxwbvrkLPmPn2TJviUwPvGGpSMipipQB6C3j1Gbs4iPSeodJf+WEqzCoTqY
         v8+OfagxpSQPqhkwIh1pfZr4u+jC7zZXyL4r3mAvH81vHNIbKHMJs9RGsIkomamQCaQq
         cZghOvUn9cFgiLkWwNpcMIN6TDKV1FMq21JNGH5uf9tFd0e/t0C2NfOAs+vGO2+tM6yn
         jEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6bHeWjV3HGfhLob3U0wkIQ8wiGJnN6iWzgMWgki4WRA=;
        b=RktSgj0Wm64Fsc5DMKj5FqiPywwKHV1V0npIEVOFZW9IslkYBlkIM3f81iwTOAr17t
         iGVv7BTKlXwipLlKWJC6itRZXMCq7nP1Hk1qCZHr4oZ2BupjyBfkaDe3f49Tx1g/x7Si
         q1LE5qhMWbiJfAguEzFvkBxEdc+isynjYID5sHvTTq3Hor8o/uj/5DFcUk07tzC/fk8f
         KRkQrOGFiE8ZCsYwA9SBUgDw1FbNxFqPKVRRLjXlNtVReYJgBXaKq5WeOz9GyKQ07F1U
         NAWS7YPY40ku7ed88+LO7e/d8AWLT5WQxW2BfWtAxMvlYpxJjDEw9QXZ8aijJVL1URFh
         cxyg==
X-Gm-Message-State: AOAM532Ahaa3kU4BwecbRipVCkv0LQk1isCxgJgyPgwuMPC0/Y1/GVoF
        MUqu1hm1lgvBv/75v31nwd3ChpQCxCtfbQ==
X-Google-Smtp-Source: ABdhPJznYYgoZbjQNv8p8/lJ1ILows+/lwtewj9vGKlUNhcTZ5D5Ve/FSOR7smfZ5r7yfwXXaluIhw==
X-Received: by 2002:a62:ddd8:0:b0:435:4de8:2652 with SMTP id w207-20020a62ddd8000000b004354de82652mr2424526pff.53.1631586242271;
        Mon, 13 Sep 2021 19:24:02 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.116])
        by smtp.gmail.com with ESMTPSA id r4sm8012126pjm.50.2021.09.13.19.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 19:24:01 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] misc_cgroup: introduce misc.events and
 misc_events.local
To:     Vipin Sharma <vipinsh@google.com>, Tejun Heo <tj@kernel.org>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
References: <50b83893065acaef2a9bc3f91c03812dc872f316.1631504710.git.brookxu@tencent.com>
 <CAHVum0dmTULvzD6dhr4Jzow-M1ATi-ubDkO5wQR=RQmWtt_78w@mail.gmail.com>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <b62597e9-72c4-563e-fdc7-3315569502f0@gmail.com>
Date:   Tue, 14 Sep 2021 10:23:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHVum0dmTULvzD6dhr4Jzow-M1ATi-ubDkO5wQR=RQmWtt_78w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thanks for your time.

Vipin Sharma wrote on 2021/9/14 12:51 上午:
> On Sun, Sep 12, 2021 at 10:01 PM brookxu <brookxu.cn@gmail.com> wrote:
>>
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> Introduce misc.events and misc.events.local to make it easier for
> 
> I thought Tejun only gave go ahead for misc.events and not for
> misc.events.local.
> 

Maybe I missed something. I think events.local is somewhat useful. For
example, the events of node A is large. If we need to determine whether
it is caused by the max of node A, if there is no events.local, then we
need to traverse the events of the child nodes and compare them with
node A. This is a bit complicated. If there is events.local, we can do
it very easily. Should we keep the events.local interface？

>> us to understand the pressure of resources. The main idea comes
>> from mem_cgroup. Currently only the 'max' event is implemented,
>> which indicates the times the resource exceeds the limit.
>>
> 
> For future emails, please provide the links to previous discussions
> like [1], [2],...
> 
>> @@ -36,6 +41,8 @@ enum misc_res_type {
>>  struct misc_res {
>>         unsigned long max;
>>         atomic_long_t usage;
>> +       atomic_long_t events[MISC_CG_EVENT_TYPES];
> 
> Since there is only one event type for now, my recommendation is to
> not use the array and just use a single atomic_long_t.
> 
>>
>> +static const char *const misc_event_name[] = {
>> +       "max"
>> +};
>> +
> 
> We will not need it if you remove the array in struct misc_res.

All right, thanks.

> Thanks
> Vipin
> 
