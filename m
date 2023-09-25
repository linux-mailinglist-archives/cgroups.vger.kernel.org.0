Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACED57AD415
	for <lists+cgroups@lfdr.de>; Mon, 25 Sep 2023 11:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjIYJDS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Sep 2023 05:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjIYJDR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Sep 2023 05:03:17 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A435E8
        for <cgroups@vger.kernel.org>; Mon, 25 Sep 2023 02:03:11 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6c4b7e90e99so2934781a34.0
        for <cgroups@vger.kernel.org>; Mon, 25 Sep 2023 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1695632590; x=1696237390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqm4o8PPpVu6ukV6RI/eS1T+wtOMXG/bvIkWdbyHpRI=;
        b=FTvkBgjfHvoncZpkOX97gniJDTLG385fc+9N1R4RrPBtbPNYUab7gaWLl4PQ4jm0j9
         G4CxkKk3Nt0723qz4upJAn6bTBPXQzvmZoMxvTnTLLXWDOyfz0jgzb89RZOKujgdwF/5
         960fDCCB5F7Q56WsTM4ixue3LdnBnHNC7f2S9MowQBsMn2fYcwKJNWL/PIk56F6SF5v8
         0/jncluyM5NM/jNdWoMI9zPcAK0/k/H6IACyFX+Z8zLn4qmE9E7QIVktV0TXQ6ah/kFg
         7BOVkqqswH/X7R6KeUbQEkgKCt+waCKuGtRN1Lb5Iv69HLuu1GZDCNtdmhPB0PaocQyp
         e7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695632590; x=1696237390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mqm4o8PPpVu6ukV6RI/eS1T+wtOMXG/bvIkWdbyHpRI=;
        b=TmH7gGBRw3i5QnE3TKyNqpIKwgvtWvPKhlF0tQ/p0vfLWjhzODPIw0r11+bAp8QA7f
         2wJgp9DkdTaov4fynl0npsV9YFvPOIikkil7YDLsvt37a0Mxk5K0AZx28MgVGEtbN3+6
         9U1jxMna617YePJUM96xuqBaNq8kmBLjUHL7ejxkCDZ5gQ3FDdDDULUJXAxkHjRRMQKz
         XmdmxiwRaasEqkQHNlareRSbz/Ao1Z++Fnbnbk9JL6ImcVRNoADT5y5xx9Ke4VyX6Wj7
         0MHW6OkFfJ0+d8d0BzqbGni9DWKwpjM5fVSdVd1usMZ9cTeOO5rXIhkeSrD2ehZyKJhc
         I4aw==
X-Gm-Message-State: AOJu0YxVmxoEeHcluKf14JX8DHQPwhuak6jsoMdvVuaNRJsdZ9ex5ODX
        M4/okzw0/2DQ8DGjAsYsGZfVIg==
X-Google-Smtp-Source: AGHT+IGUxbpoVIyPXbUKGwXLR35c+NnV403oTx8h8lFbj7Ytyl8Gw1UGH0gm8+4LrdkRzBYen+9nzA==
X-Received: by 2002:a05:6358:2491:b0:13e:bf50:73af with SMTP id m17-20020a056358249100b0013ebf5073afmr6991409rwc.18.1695632590575;
        Mon, 25 Sep 2023 02:03:10 -0700 (PDT)
Received: from [10.54.24.10] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id p19-20020a639513000000b00578afd8e012sm6749481pgd.92.2023.09.25.02.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 02:03:10 -0700 (PDT)
Message-ID: <6b7af68c-2cfb-b789-4239-204be7c8ad7e@shopee.com>
Date:   Mon, 25 Sep 2023 17:03:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] memcg, oom: unmark under_oom after the oom killer is
 done
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20230922070529.362202-1-haifeng.xu@shopee.com>
 <ZRE9fAf1dId2U4cu@dhcp22.suse.cz>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZRE9fAf1dId2U4cu@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/9/25 15:57, Michal Hocko wrote:
> On Fri 22-09-23 07:05:28, Haifeng Xu wrote:
>> When application in userland receives oom notification from kernel
>> and reads the oom_control file, it's confusing that under_oom is 0
>> though the omm killer hasn't finished. The reason is that under_oom
>> is cleared before invoking mem_cgroup_out_of_memory(), so move the
>> action that unmark under_oom after completing oom handling. Therefore,
>> the value of under_oom won't mislead users.
> 
> I do not really remember why are we doing it this way but trying to track
> this down shows that we have been doing that since fb2a6fc56be6 ("mm:
> memcg: rework and document OOM waiting and wakeup"). So this is an
> established behavior for 10 years now. Do we really need to change it
> now? The interface is legacy and hopefully no new workloads are
> emerging.
> 
> I agree that the placement is surprising but I would rather not change
> that unless there is a very good reason for that. Do you have any actual
> workload which depends on the ordering? And if yes, how do you deal with
> timing when the consumer of the notification just gets woken up after
> mem_cgroup_out_of_memory completes?

yes, when the oom event is triggered, we check the under_oom every 10 seconds. If it
is cleared, then we create a new process with less memory allocation to avoid oom again.

> 
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
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
> 
