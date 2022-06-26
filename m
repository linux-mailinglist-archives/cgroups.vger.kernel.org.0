Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D6855AFCF
	for <lists+cgroups@lfdr.de>; Sun, 26 Jun 2022 09:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiFZHLg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Jun 2022 03:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiFZHLf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Jun 2022 03:11:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311E313DE6
        for <cgroups@vger.kernel.org>; Sun, 26 Jun 2022 00:11:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j21so11477521lfe.1
        for <cgroups@vger.kernel.org>; Sun, 26 Jun 2022 00:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IBedsG9Q5xgkDI4Di1vJ798mBW+tiuIsna2FmqI3oz8=;
        b=BROfm7VbE1SLLJAAQRbRMYSFFuYVMx32Rq+TL06HlNfW5yYfeyzp7rFodfTjhMjslf
         0kC1417O0TcfoXi1Kqm4Gt20jySLwoxrWnqXsZUbwc6hInzvpw4nSCdGJOPaVRItWqO4
         J8qLBhnW1aIyqh8xBUjsDdMn3k0mfnUqDgSj7zSiqU3iHUOp7lOBno8nMLR8CbxLOACn
         f61afhZ2Ix88+32NTl/aBBhRUibW0rTfgoY4jnRvVHf6inQrRlyQpYJEiRBTUA2mmDkf
         4i/mRGDfvXof4eGvNcvi1Jpo9sBrvqsSwZVMzm2uGpOwcABIac+++DEDXAsWzuaol1lu
         lkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IBedsG9Q5xgkDI4Di1vJ798mBW+tiuIsna2FmqI3oz8=;
        b=bvTzdBMXOGxIgp7sEKB5lAK40X2Uk1O7781qhNURzlLfC+4cb/NSGQg3il+cyvB5g0
         42bjBlaC+5yTJbBY8YBpGGREus+denfmjmBrt7AUVtAa0QowP96vMk2pLq1UwBVyx8Vr
         cIjTfya8o/iW5c/d9ooUCapLe1xwUgzWsjV9G9xr2HUh6aQHcY+uHPyQGUMMYoCkQjci
         KmmIwLSwRdsbKrM0K27nGCNIYe3YHLgAIilJIYg9T4FXJIfEIqQf8Bb0Vcy5RxrHumpI
         66PS8zqmwjm7WVPjl0BCC4xoRlbwm8f6a1VvhONjKEgN6aIJAca3do9eAC3qHJe42+Vc
         QxJg==
X-Gm-Message-State: AJIora+MbtVAGrV2tPmDgrzMqKfqpdIKiHG81q7QbmeTUzK8rdj/zF4f
        CH2L0R5l5peT6p8tZA6sA9aGOg==
X-Google-Smtp-Source: AGRyM1vXA1oEPxIc8sDac5VdTBnwUc4JmX5iCt4wthxe7yU+h8n385bEl/WmrImHFr0+iq1iRjfILg==
X-Received: by 2002:a05:6512:22c1:b0:479:54b6:8281 with SMTP id g1-20020a05651222c100b0047954b68281mr5076178lfu.291.1656227492453;
        Sun, 26 Jun 2022 00:11:32 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id b22-20020a056512305600b0047da6e495b1sm1246277lfb.4.2022.06.26.00.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 00:11:32 -0700 (PDT)
Message-ID: <186d5b5b-a082-3814-9963-bf57dfe08511@openvz.org>
Date:   Sun, 26 Jun 2022 10:11:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC] memcg: notify about global mem_cgroup_id space
 depletion
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <YrXDV7uPpmDigh3G@dhcp22.suse.cz>
 <c53e1df0-5174-66de-23cc-18797f0b512d@openvz.org> <Yre8tNUY8vBrO0yl@castle>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <Yre8tNUY8vBrO0yl@castle>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/26/22 04:56, Roman Gushchin wrote:
> On Sat, Jun 25, 2022 at 05:04:27PM +0300, Vasily Averin wrote:
>> Currently host owner is not informed about the exhaustion of the
>> global mem_cgroup_id space. When this happens, systemd cannot
>> start a new service, but nothing points to the real cause of
>> this failure.
>>
>> Signed-off-by: Vasily Averin <vvs@openvz.org>
>> ---
>>  mm/memcontrol.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index d4c606a06bcd..5229321636f2 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -5317,6 +5317,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>>  				 1, MEM_CGROUP_ID_MAX + 1, GFP_KERNEL);
>>  	if (memcg->id.id < 0) {
>>  		error = memcg->id.id;
>> +		pr_notice_ratelimited("mem_cgroup_id space is exhausted\n");
>>  		goto fail;
>>  	}
> 
> Hm, in this case it should return -ENOSPC and it's a very unique return code.
> If it's not returned from the mkdir() call, we should fix this.
> Otherwise it's up to systemd to handle it properly.
> 
> I'm not opposing for adding a warning, but parsing dmesg is not how
> the error handling should be done.

I'm agree,  I think it's a good idea. Moreover I think it makes sense to
use -ENOSPC  when the local cgroup's limit is reached.
Currently cgroup_mkdir() returns -EAGAIN, this looks strange for me.

        if (!cgroup_check_hierarchy_limits(parent)) {
                ret = -EAGAIN;
                goto out_unlock;
        }

Thank you,
	Vasily Averin
