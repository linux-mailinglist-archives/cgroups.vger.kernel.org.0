Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2349B69E238
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 15:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjBUOWY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 09:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjBUOWS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 09:22:18 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254BF2B28E
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 06:21:56 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id ky4so6357633plb.3
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 06:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flPFw0D3KpcP6j/qLwV4RKv74RjgOZhXW58bNnl0IIg=;
        b=DshPrdq9zPn2WIl+z3nj6W4ilUqSYOm65cgTLYZoKgyRyls987vrjwB342gfw1goD5
         wuhD3QhsHkyOIgm3+aX9ZkgljdlDBITg9AC59tPuLDYtR9iTYasBr4DpVDAtKLt0qBxf
         Qpoiw1lsKXL+Gfu0D+bkyskvbz1iHA2JcVA7X21hieGXlcEueNQnbqSR+WHhiL1SiA6z
         1sIF9+FDEVnk9OG2A89vDYtMqCMT+CZF6ngCPZ+fKgcMnO9/khYb1zBz3K6Utg6dU5Xb
         EFPbhVz1EZzFwPFm2Cd7VJKmLdDBEbYmbyWC2PwUtD02HCunHu+MaLRr49YFvetzfD6P
         3fHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=flPFw0D3KpcP6j/qLwV4RKv74RjgOZhXW58bNnl0IIg=;
        b=dQ2iwghINrVKDv0paCQsD35wiSaneaEOXk90hUsy1vrXuRelR/rLxLTLXbLBhWOLXu
         BrPCKDzE6XFxfL7QHnBRIbb1WnbtoNGO/kbPNSwxumQt1h+QzD+BZWD+LHK4+0V546V+
         UxzFXbg+AhZI3vjz8J8iSiVhu8MsZB778LL0VFu+V/GfNYRWKeLLefbyDS9Bxz3uKlUJ
         2MLG0YesQVB9IPpy+OQgIfvJ5xmOiESy8xxIixAHz3YSd26fyJRy5QwxpmC93IMlLPHj
         nv+XeCec/sScoeHNWYfioJTgPoFi3j9qLJm4zO+MjzRMXnRR/PijiHjYtaPXvzwjtCf6
         fuJA==
X-Gm-Message-State: AO0yUKXsIk1OyzdProNhrenSbZLIEK8HukKNNf+DuekqXFFo26GdW9MK
        joQ1FcO65UD76HnhoqLAIiY1IA==
X-Google-Smtp-Source: AK7set9OvfKGBfEHb/fNoLcdiMo9L6i96QOM7MaqQW7tWfU5KEqjbWOCpXxlppXA+E+0xd65dev+HQ==
X-Received: by 2002:a05:6a21:339b:b0:ad:67fa:8e50 with SMTP id yy27-20020a056a21339b00b000ad67fa8e50mr6057668pzb.57.1676989310284;
        Tue, 21 Feb 2023 06:21:50 -0800 (PST)
Received: from [10.54.29.226] (static-ip-147-99-134-202.rev.dyxnet.com. [202.134.99.147])
        by smtp.gmail.com with ESMTPSA id q65-20020a632a44000000b004efe1f24522sm3231075pgq.23.2023.02.21.06.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 06:21:49 -0800 (PST)
Message-ID: <99bdfbec-2de4-b432-9649-09557d3f95d6@shopee.com>
Date:   Tue, 21 Feb 2023 22:21:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] mm/memcg: Skip high limit check in root memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230210094550.5125-1-haifeng.xu@shopee.com>
 <Y+uvRKo7OQ02yB4K@dhcp22.suse.cz>
 <82918a12-d83e-10c0-0e04-eec26657b699@shopee.com>
 <Y/S3GHT1P6awZaPb@dhcp22.suse.cz>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <Y/S3GHT1P6awZaPb@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/2/21 20:20, Michal Hocko wrote:
> On Tue 21-02-23 18:29:39, Haifeng Xu wrote:
>>
>>
>> On 2023/2/14 23:56, Michal Hocko wrote:
>>> On Fri 10-02-23 09:45:50, Haifeng Xu wrote:
>>>> The high limit checks the memory usage from given memcg to root memcg.
>>>> However, there is no limit in root memcg. So this check makes no sense
>>>> and we can ignore it.
>>>
>>> Is this check actually addining any benefit? Have you measured aby
>>> performance gains by this change?
>>>
>>>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>>>> ---
>>>>  mm/memcontrol.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>> index 73afff8062f9..a31a56598f29 100644
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>> @@ -2780,6 +2780,10 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>>>>  	do {
>>>>  		bool mem_high, swap_high;
>>>>  
>>>> +		/* There is no need for root memcg to check high limit */
>>>> +		if (mem_cgroup_is_root(memcg))
>>>> +			break;
>>>> +
>>>>  		mem_high = page_counter_read(&memcg->memory) >
>>>>  			READ_ONCE(memcg->memory.high);
>>>>  		swap_high = page_counter_read(&memcg->swap) >
>>>> -- 
>>>> 2.25.1
>>>
>>
>> test steps:
>> 1. mkdir -p /sys/fs/cgroup/memory/test
>> 2. echo $$ > /sys/fs/cgroup/memory/test/cgroup.procs
>> 3. ./mmap_test
>>
>> The test result show that with or without the patch, the time taken is almost the same.
> 
> This is in line with my expectation. So the question is whether the
> additional check is really worth it. 

This patch doesn't bring any obvious benifit or harm, but the high limit check in root memcg seems a little weird.
Maybe we can add this check？It all depends on your viewpoint.

Thanks.
 
