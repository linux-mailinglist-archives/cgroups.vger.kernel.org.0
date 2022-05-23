Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4977553137A
	for <lists+cgroups@lfdr.de>; Mon, 23 May 2022 18:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbiEWN3I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 May 2022 09:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiEWN3G (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 May 2022 09:29:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA1A3BA7C
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 06:29:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso17518228pjj.4
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 06:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C3bZbEaAq3Xu1O+OItJ+lvJSF2o3pyc0onzZAOeeJCk=;
        b=mIybBL1U6Elcn4NFipNHc5oYx+P5Xk/K0gsj85ZVi5o0E3KwuASAj4EvcTaDp/36nj
         jP1tJ4Jbnb4vasuwpfNDRsYJbfLxNA06dWhQ47QuAk/4RciDwvzHhvr4ZfEclYuY07jK
         fyswcaPhtbpzv+HtgMjrpL14+hJxbjhHfys+P4F2FtOj+8fSuy/Ge9UahGkhgN3nyn5G
         tcnNDsRQCe3AVMSUSp371ndlhVm2cueqcTjzWm4bmNxdo1wQse2nsxh9wEw/7THhxzz2
         fsLXjpoEBx0WzKoOA3XUajKrGaIzhE1D5ZQ3bAfiHNHr18QdHkYwLtje3LghS5hTLHY5
         8shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C3bZbEaAq3Xu1O+OItJ+lvJSF2o3pyc0onzZAOeeJCk=;
        b=mB0d5MSpGHLsbBv4RGr17kvqCCWTpKPPzXFDM0A7Lhr3oMep4TXqckq3ORyo0pREf5
         bwR0NC1Fige5lvvGKGDF5zb3mtniWEbm7rPjFAeXznA83Vp6GrYnvs7XRYWkwWLqFYEg
         0IE1dnXA9rsHA6vhoUjz0HIVTJ2Mu+x6w+dQrh5WeTIKqVXINuQuu+Ddj4q4mYmROcDK
         eRlz59f53UXvxJWnqYDyVKlnJdhDRrB0CAUZOBMZyVyvIhUvlc4XNt4P8XIFhpFIr18A
         TfhiNHYCKFAWBvgL4f4EL3WutbdJd0/XCH/UO/lR012IEQ5DbpkbK5nJ8UqZkUlj986b
         scpw==
X-Gm-Message-State: AOAM533GKML3SIivQeWOlRz12gdDirVM9Tlo9FgNWwxVnFiEhN5bW9jG
        JroztFQuRFRruhw1n2OE1QgHUg==
X-Google-Smtp-Source: ABdhPJyb765pKTXIFpPUXz3mbvBfvf4qGd0h2/E1/qyzdrr0Bi3GVvZ4dyys9lszdqnXxEVrTyP2Dw==
X-Received: by 2002:a17:902:e3d4:b0:162:23a7:a7e7 with SMTP id r20-20020a170902e3d400b0016223a7a7e7mr5406661ple.32.1653312542991;
        Mon, 23 May 2022 06:29:02 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c2-20020a62f842000000b0051800111b2fsm7347132pfm.216.2022.05.23.06.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 06:29:02 -0700 (PDT)
Message-ID: <f1a08877-e27f-6520-272d-a3e6598f97b9@kernel.dk>
Date:   Mon, 23 May 2022 07:29:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH -next v5 0/3] support concurrent sync io for bfq on a
 specail occasion
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, paolo.valente@linaro.org
Cc:     jack@suse.cz, tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220428120837.3737765-1-yukuai3@huawei.com>
 <d50df657-d859-79cf-c292-412eaa383d2c@huawei.com>
 <61b67d5e-829c-8130-7bda-81615d654829@huawei.com>
 <81411289-e13c-20f5-df63-c059babca57a@huawei.com>
 <d5a90a08-1ac6-587a-e900-0436bd45543a@kernel.dk>
 <55919e29-1f22-e8aa-f3d2-08c57d9e1c22@huawei.com>
 <b32ed748-a141-862c-ed35-debb474962ed@kernel.dk>
 <1172d00f-0843-1d7c-721f-fdb60a0945cb@huawei.com>
 <dfd2ac0b-74da-85f4-ff66-2eb307578d93@kernel.dk>
 <8f0b5115-6a96-d5eb-5243-0be832cf121b@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8f0b5115-6a96-d5eb-5243-0be832cf121b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/23/22 6:58 AM, Yu Kuai wrote:
> ? 2022/05/23 20:36, Jens Axboe ??:
>> On 5/23/22 2:18 AM, Yu Kuai wrote:
>>> ? 2022/05/23 9:24, Jens Axboe ??:
>>>> On 5/22/22 7:10 PM, yukuai (C) wrote:
>>>>> ? 2022/05/21 20:21, Jens Axboe ??:
>>>>>> On 5/21/22 1:22 AM, yukuai (C) wrote:
>>>>>>> ? 2022/05/14 17:29, yukuai (C) ??:
>>>>>>>> ? 2022/05/05 9:00, yukuai (C) ??:
>>>>>>>>> Hi, Paolo
>>>>>>>>>
>>>>>>>>> Can you take a look at this patchset? It has been quite a long time
>>>>>>>>> since we spotted this problem...
>>>>>>>>>
>>>>>>>>
>>>>>>>> friendly ping ...
>>>>>>> friendly ping ...
>>>>>>
>>>>>> I can't speak for Paolo, but I've mentioned before that the majority
>>>>>> of your messages end up in my spam. That's still the case, in fact
>>>>>> I just marked maybe 10 of them as not spam.
>>>>>>
>>>>>> You really need to get this issued sorted out, or you will continue
>>>>>> to have patches ignore because folks may simply not see them.
>>>>>>
>>>>> Hi,
>>>>>
>>>>> Thanks for your notice.
>>>>>
>>>>> Is it just me or do you see someone else's messages from *huawei.com
>>>>> end up in spam? I tried to seek help from our IT support, however, they
>>>>> didn't find anything unusual...
>>>>
>>>> Not sure, I think it's just you. It may be the name as well "yukuai (C)"
>>> Hi, Jens
>>>
>>> I just change this default name "yukuai (C)" to "Yu Kuai", can you
>>> please have a check if following emails still go to spam?
>>>
>>> https://lore.kernel.org/all/20220523082633.2324980-1-yukuai3@huawei.com/
>>
>> These did not go into spam, were delivered just fine.
>>
> Cheers for solving this, I'll resend this patchset just in case they are
> in spam for Paolo...

Let's hope it's solved, you never know with gmail... But that series did
go through fine as well, fwiw.

-- 
Jens Axboe

