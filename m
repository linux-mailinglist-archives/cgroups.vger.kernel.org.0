Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E0A7ABEB5
	for <lists+cgroups@lfdr.de>; Sat, 23 Sep 2023 10:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjIWIB2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Sep 2023 04:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjIWIB0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Sep 2023 04:01:26 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B94180
        for <cgroups@vger.kernel.org>; Sat, 23 Sep 2023 01:01:20 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3aa1446066aso2247073b6e.1
        for <cgroups@vger.kernel.org>; Sat, 23 Sep 2023 01:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1695456080; x=1696060880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//ZPpaDq66gMwAPM04xisJ28uaG0yhnKLXXS/is+y1c=;
        b=d2TsDG5jUx+RkDgIAOo4rjzQUbdR6b9IhOuBugAmWOs2Nj+4sOIy4oMvSaGuag5zBj
         rFAYOCy+ZWksOcVNvBvkRVWsgYzuPMWzcRwaHjW+Z6WyiyJWkMsQrqWObJ5PnaVM07L7
         IeocHcaGLBmk5q3EpXA4zvuh9UHs42C51FuIbb3haushQ22iiIXVWq+zW4IZs/NgzB4L
         Z6E+4avGJiKW+ujLIRUlsWLU2p9dsewsBTmPiBMNffBqPf1V/H1oZhcGJslvashx8Ign
         dxhixuZd/Z5CY7ccjziqLWhBPIHw1xcy/FbkxcH4Cb0vpaqemuhazhiI8ejxcAZ5lJlw
         fzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695456080; x=1696060880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=//ZPpaDq66gMwAPM04xisJ28uaG0yhnKLXXS/is+y1c=;
        b=XksVe2OLRo4a/hWZ609niF6DavzlJoF6qBawmcOsheV513U39RKFFtODgcm7+/RX3b
         Odxc9FQMbhDq+fNQrw0tqTGt3+IgBmK9fDNiPFdoMhenDIpuNvaiRaeBzoSsMgEyDmeS
         HxDAh/ec7g0yJFW8o2bwZMwnaueXFTd4ImXpJ0tqaxz8HWDjyXfPOOcrtznl09ppuYLJ
         Tyw6ore2St5zAD48cHHbGA66bJUDIOw0H9lcu1ES49Lj0+pRhYfbAM2hky7Eg+GFCSD9
         +zoOpywaiYDeP1mm4bUjEJ8lN1slXwht6klrWhlGZescwQh3sTeCZiVFJzUr6F8/S8sd
         mnAg==
X-Gm-Message-State: AOJu0Ywe92428SzJY6uvMU66p5Egcms+2kuSTR1n2xU4INNKozCkGvbD
        qiGSEr5spOWZkAUZCK7LOAQ7pA==
X-Google-Smtp-Source: AGHT+IEstjwhWO5KwiOJ9P9hHZo8Yk77qpTPnCglcI4FA9O16oBKfkyqhZxRTcI/W5XNdiWIi2U07w==
X-Received: by 2002:a05:6808:3d2:b0:3a7:4ce4:cb8e with SMTP id o18-20020a05680803d200b003a74ce4cb8emr2231587oie.42.1695456080094;
        Sat, 23 Sep 2023 01:01:20 -0700 (PDT)
Received: from [10.12.184.30] ([143.92.127.236])
        by smtp.gmail.com with ESMTPSA id g16-20020a1709029f9000b001c22292ad7esm4736135plq.232.2023.09.23.01.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 01:01:19 -0700 (PDT)
Message-ID: <94c2a462-1d4e-e6e8-0e31-babcbc459836@shopee.com>
Date:   Sat, 23 Sep 2023 16:01:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] memcg, oom: do not wake up memcg_oom_waitq if
 waitqueue is empty
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20230922070529.362202-2-haifeng.xu@shopee.com>
 <ZQ4hsQRp31RXMOfv@P9FQF9L96D.corp.robot.car>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZQ4hsQRp31RXMOfv@P9FQF9L96D.corp.robot.car>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/9/23 07:22, Roman Gushchin wrote:
> On Fri, Sep 22, 2023 at 07:05:29AM +0000, Haifeng Xu wrote:
>> Only when memcg oom killer is disabled, the task which triggers memecg
>> oom handling will sleep on a waitqueue. Except this case, the waitqueue
>> is empty though under_oom is true. There is no need to step into wake
>> up path when resolve the oom situation. So add a check that whether the
>> waitqueue is empty.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>  mm/memcontrol.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 0b6ed63504ca..2bb98ff5be3d 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1918,7 +1918,7 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
>>  	 * achieved by invoking mem_cgroup_mark_under_oom() before
>>  	 * triggering notification.
>>  	 */
>> -	if (memcg && memcg->under_oom)
>> +	if (memcg && memcg->under_oom && !list_empty(&memcg_oom_waitq.head))
>>  		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
> 
> This change looks questionable to me:
> 1) it's not obvious that this racy check is fine. can an oom event be
>    missed because of a race here? why not?

The oom event can't be missed, because the OOM task has been put on the waitqueue before marking the hierarchy as
under OOM(can be seen in mem_cgroup_oom_synchronize()).

> 2) is there any measurable impact?

No. 

it's not a hot path, so I'd keep it
>    simple.

ok, thanks.

> 
> Thanks!
