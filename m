Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5096469DDE5
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 11:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjBUK3r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 05:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjBUK3q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 05:29:46 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0900B448
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 02:29:45 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z10so1368885ple.6
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 02:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A6bq0cNZ1AfAVAWRtxraIczrguYU6xxumxI1OimKFcQ=;
        b=cTvBJZUXrr8VeSPaAd/OQA+aC9rJ1ogQGfjpWHh5OAYclK7SrwdWvEquQUueynfkvQ
         a3efwTPEAnGZBc0WnVX/Sf/cIN+IQouc4MrvflZTyKcv7Wume1MEDzSGxZcZysDAl+sE
         SVWMotA2T640xagoe44Qxr516z/1JAgBGMCO6Yp6ztVQcG3cGpzJlaeEmGcuk8WubaJW
         M/ALr4Xy17oe3KDqnqcWC5HaLx4BGaYDFhLCc7a7Fnivk1b9R9AqoyS65x3kUBhySLhF
         xVsCampZ1JzrKo55JLoUti7ABpU3exb9EdtbLC8mylSTrCs0xQaJfHgG7jYo3KA9dnEV
         MzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6bq0cNZ1AfAVAWRtxraIczrguYU6xxumxI1OimKFcQ=;
        b=UOJbOCgl2kcjkWssaDhQ9jPhgg1W7+hnEiZ2FtKtDyxhs420qJoxNrCuarpbq69afk
         XFN3Nlt+KpYATjgLeZgYySxhKraXk+orKwijEdmlxOXKXrCH5uYEMtp2pd7pK0zc2F++
         baic298RVAVEr0WOKK42TMANAL9iinrmTi+x9JNaeWZpouzIWtzsUQUQZW4UvCLnPxB2
         T1HKgFYsmIOGO1NhkZJT5lSStb4t2mdG2a2gsMxT6+ljUPMZPtpKxnMKonivt9FAFcJh
         Q3Nfs+eGwn+gBusVQEXuY0CnF0ie4LOgQ/Q3MVc04lnWaXtGyEpRC4Xo00nqy5rE0UEF
         OTYw==
X-Gm-Message-State: AO0yUKXw+hChDzxYU4lBQEkWnBLA06rVH081YGe87iezo7cwCu8cETU0
        3my/A1kw3USzwhHBOsye2udjM09M/F4XsC9M3vk=
X-Google-Smtp-Source: AK7set9wbCdH/nkJCOJHU3fJsl2GLKwTo19qpBlknnmESPkg0QqEOEjup5dFLBvBGufj4aVLSHmoEQ==
X-Received: by 2002:a17:90b:4b86:b0:234:106a:34ab with SMTP id lr6-20020a17090b4b8600b00234106a34abmr6031142pjb.6.1676975385411;
        Tue, 21 Feb 2023 02:29:45 -0800 (PST)
Received: from [10.54.24.141] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090acb0400b00234a2f6d9c0sm2722126pjt.57.2023.02.21.02.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 02:29:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------Spvi9DJXN5O0V9DKveeK2Vsh"
Message-ID: <82918a12-d83e-10c0-0e04-eec26657b699@shopee.com>
Date:   Tue, 21 Feb 2023 18:29:39 +0800
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
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <Y+uvRKo7OQ02yB4K@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is a multi-part message in MIME format.
--------------Spvi9DJXN5O0V9DKveeK2Vsh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023/2/14 23:56, Michal Hocko wrote:
> On Fri 10-02-23 09:45:50, Haifeng Xu wrote:
>> The high limit checks the memory usage from given memcg to root memcg.
>> However, there is no limit in root memcg. So this check makes no sense
>> and we can ignore it.
> 
> Is this check actually addining any benefit? Have you measured aby
> performance gains by this change?
> 
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>  mm/memcontrol.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 73afff8062f9..a31a56598f29 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2780,6 +2780,10 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>>  	do {
>>  		bool mem_high, swap_high;
>>  
>> +		/* There is no need for root memcg to check high limit */
>> +		if (mem_cgroup_is_root(memcg))
>> +			break;
>> +
>>  		mem_high = page_counter_read(&memcg->memory) >
>>  			READ_ONCE(memcg->memory.high);
>>  		swap_high = page_counter_read(&memcg->swap) >
>> -- 
>> 2.25.1
> 

test steps:
1. mkdir -p /sys/fs/cgroup/memory/test
2. echo $$ > /sys/fs/cgroup/memory/test/cgroup.procs
3. ./mmap_test

The test result show that with or without the patch, the time taken is almost the same.
--------------Spvi9DJXN5O0V9DKveeK2Vsh
Content-Type: text/plain; charset=UTF-8; name="mmap_test.c"
Content-Disposition: attachment; filename="mmap_test.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUg
PHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5j
bHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPGN0eXBlLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4K
I2luY2x1ZGUgPGludHR5cGVzLmg+CgojZGVmaW5lIFNJWkUgKDUgKiAxMDI0ICogMTAyNCAq
IDEwMjQpCgppbnQ2NF90IGN1cnJlbnRfdGltZV9tcygpIHsKICAgICBzdHJ1Y3QgdGltZXZh
bCB0aW1lOwogICAgIGdldHRpbWVvZmRheSgmdGltZSwgTlVMTCk7CiAgICAgaW50NjRfdCBz
MSA9IChpbnQ2NF90KSh0aW1lLnR2X3NlYykgKiAxMDAwOwogICAgIGludDY0X3QgczIgPSAo
dGltZS50dl91c2VjIC8gMTAwMCk7CiAgICAgcmV0dXJuIHMxICsgczI7Cn0KCmludCBtYWlu
KGludCBhcmdjLCBjaGFyKiBhcmd2W10pCnsKICAgICAgICB2b2lkICogYnVmOwogICAgICAg
IHNpemVfdCBzaXplID0gU0laRTsKICAgICAgICBpbnQ2NF90IHN0YXJ0LCBjb3N0OwoKICAg
ICAgICBidWYgPSBtbWFwKE5VTEwsIHNpemUsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsIE1B
UF9QUklWQVRFIHwgTUFQX0FOT04sIDAsIDApOwogICAgICAgIGlmIChidWYgPCAwICkgewog
ICAgICAgICAgICAgICAgcHJpbnRmKCJtbWFwIGZhaWxlZFxuIik7CiAgICAgICAgICAgICAg
ICBleGl0KC0xKTsKICAgICAgICB9CgogICAgICAgIHN0YXJ0ID0gY3VycmVudF90aW1lX21z
KCk7CgogICAgICAgIG1sb2NrKGJ1Ziwgc2l6ZSk7CgogICAgICAgIGNvc3QgPSBjdXJyZW50
X3RpbWVfbXMoKSAtIHN0YXJ0OwogICAgICAgIHByaW50ZigiY29zdDogJSIgUFJJZDY0ICIg
bXNcbiIsIGNvc3QpOwoKICAgICAgICBtdW5tYXAoYnVmLCBzaXplKTsKCiAgICAgICAgcmV0
dXJuIDA7Cn0K

--------------Spvi9DJXN5O0V9DKveeK2Vsh--
