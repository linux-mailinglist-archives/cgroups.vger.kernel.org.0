Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE487ABEBD
	for <lists+cgroups@lfdr.de>; Sat, 23 Sep 2023 10:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjIWIFx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Sep 2023 04:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjIWIFv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Sep 2023 04:05:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE4A197
        for <cgroups@vger.kernel.org>; Sat, 23 Sep 2023 01:05:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c5dd017b30so23953525ad.0
        for <cgroups@vger.kernel.org>; Sat, 23 Sep 2023 01:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1695456345; x=1696061145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRuWP6V8GVdoPyHzIkm8uWRv8cNgAdi6Pry1OPgErIE=;
        b=Rx6ILTNU+v8MPpL/ylURc6kK4vqs5NAroOseeaVM55fvhkUn+qHxyD7uzTFnq3Q7SV
         sJPrj8RK33Adug1bQRRVo7F6+phLGV4BKjyTv8ycgfDkVwchVOlNK/FtkYnrZFO2NzyG
         Lztl7cOm93z1FhA2Ajt3++0dCWWBgY0tTW/2SKeEI2rDTLsaJBmSorBBOg+lmhQp3HLO
         lCph7XJZrgYDiy6Mi2/5s5QlDBAbsd+8UHpCUJTSLBsftwd3X9HpbyvxiOo0P8ELcTZ+
         8FSsZzaJwver0OnaM7gpPTdXJ++1KLxpCceU0Kc4mbXsPLGud0OAS36Ix5fL+STjXj5l
         +hKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695456345; x=1696061145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xRuWP6V8GVdoPyHzIkm8uWRv8cNgAdi6Pry1OPgErIE=;
        b=skY445uQH+L8oWnZOKaSJvr6lPk5inxheb3eDEny6c02E83CaC9j9L42cQkThZHFc9
         XuqAACLiqMhCYLyr+DxFLaynEkuOYsHVi0M9P32OILlRx/BUa3fGfAhHwRfbY3/BPym8
         Oq1LDzTampiGbpQ5hkcolhY93Lw7suDqKQVOApiQTPCYQrUi3tllesp7ZHxDCwbvKHX8
         UD+/NRYCak0vUaUciilpD77cBDJKn3xIVBrHmLf0wcsfo2740uMsCVluyRMjbPILON0D
         CUl50IT+8Gnji0lKIfC2N3RSYAMbSXcpUct4UnccZWrVfED+X5C4cUtBT3SkmvZpHPwb
         skdw==
X-Gm-Message-State: AOJu0Yz6W0Ep9DFcn9AQFHLivI3GG/9VJOWmqcTTmFMIwss31tQR0plX
        Qcy8ke6HvGOXz400T+Za+CDSf0DsO3EUvRs+0C8ncT+s
X-Google-Smtp-Source: AGHT+IEGd0oFJCKOMeWZDGGi84ezRnWKiyqjOkPKk44G7pbYp03GcotsS6id9lIjRoMgawz1mqmfrA==
X-Received: by 2002:a17:903:120b:b0:1bc:edd:e891 with SMTP id l11-20020a170903120b00b001bc0edde891mr6672240plh.1.1695456344787;
        Sat, 23 Sep 2023 01:05:44 -0700 (PDT)
Received: from [10.12.184.30] ([103.114.192.135])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001b89b1b99fasm4772708pls.243.2023.09.23.01.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 01:05:44 -0700 (PDT)
Message-ID: <94eea77c-2786-794e-ac2b-71a48966b5db@shopee.com>
Date:   Sat, 23 Sep 2023 16:05:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] memcg, oom: unmark under_oom after the oom killer is
 done
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20230922070529.362202-1-haifeng.xu@shopee.com>
 <ZQ4giCbTqUpmKWAa@P9FQF9L96D.corp.robot.car>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZQ4giCbTqUpmKWAa@P9FQF9L96D.corp.robot.car>
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



On 2023/9/23 07:17, Roman Gushchin wrote:
> On Fri, Sep 22, 2023 at 07:05:28AM +0000, Haifeng Xu wrote:
>> When application in userland receives oom notification from kernel
>> and reads the oom_control file, it's confusing that under_oom is 0
>> though the omm killer hasn't finished. The reason is that under_oom
>> is cleared before invoking mem_cgroup_out_of_memory(), so move the
>> action that unmark under_oom after completing oom handling. Therefore,
>> the value of under_oom won't mislead users.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> 
> Makes sense to me.
> 
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Thanks!

OK,thanks. But I forgot to cc mailing list and akpm. I'll resend a new mail later.

> 
>> ---
>>  mm/memcontrol.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index e8ca4bdcb03c..0b6ed63504ca 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1970,8 +1970,8 @@ static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
>>  	if (locked)
>>  		mem_cgroup_oom_notify(memcg);
>>  
>> -	mem_cgroup_unmark_under_oom(memcg);
>>  	ret = mem_cgroup_out_of_memory(memcg, mask, order);
>> +	mem_cgroup_unmark_under_oom(memcg);
>>  
>>  	if (locked)
>>  		mem_cgroup_oom_unlock(memcg);
>> -- 
>> 2.25.1
>>
