Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C974539D18
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 08:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349808AbiFAGQQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 02:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbiFAGQP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 02:16:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596A172E3A
        for <cgroups@vger.kernel.org>; Tue, 31 May 2022 23:16:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u3so859134wrg.3
        for <cgroups@vger.kernel.org>; Tue, 31 May 2022 23:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vUroyxhPDzujIL+srQrQJbzj1rBmcTjbEH4aNuHu6u8=;
        b=QDJd+JMtSbictp3JXuSTnUcFtrUT8VgQ8R4hk/9xlsI/xQieNS7UamrA41uiFJDkE0
         XgXgIUC97MDtbIyS67TN33hdGqO8YaB+srytVD+PJ14E7d7vsrFEhpMTzqWyXGrzVlFm
         kDRVuH3aEqSRdWf/O74FOrdH7KOZfsmBdqoh5qFApkyER06xLe6zCZiQ8H9iQe2zY55u
         eyn6hIdNB1JF2C6qhvvOjwehBoCsMjCLsgLH3zNYlhWCw8WVu/pKywVfU8cKQu2miYWf
         vIx2rrFhgSljAMJPD5g2A07ERmaAmjazqSRuhq2OHA3MjJTsglOO8+RMT4T1VMeObNF6
         ZyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vUroyxhPDzujIL+srQrQJbzj1rBmcTjbEH4aNuHu6u8=;
        b=zgj33DbYXsA/29w71GiDL/hlCtR7vI77tVzO5/rbLbfgfILe/ZECJAO8ZhpVOhvZt5
         YUjEzno0CbMa3FyWTTpPn1tRKQhxQ3PeN94WJIcIJ7fA+PiVW4gm6DwsjV6ye0K7lrKc
         MEyi/BBBla3FAP49qAnhdPb4JqaVX6eZj5gv0vNDZOp3qWoE26rLM3loQWuoGA23HzN1
         EJ5QxRr2Zp4GgLJqw1tSmq9INplGrUCFjOwWP6uplq03q5Y93A13lOnEPpH7Cyk1Zc31
         gDn26yV9CKiVntinWpFh7KvnOQAmJtNl/oC2mx6zNFQK0mlvLMR33S3wiOw2TwbByw3n
         nMwQ==
X-Gm-Message-State: AOAM533I7nbnBMV1I0bjTYmiIDImYV8fYC1vylCk4XTXBhcXZPNgAl4s
        dtBP7sX6LPgMTo06pKnTSFEpGg==
X-Google-Smtp-Source: ABdhPJymVvDLqx+/1DvfStNIMCuy4P2eY1dbazYi71Vp6xbE1/EYlA1FwV6n4UNJYRhaRUEHGJ1WWA==
X-Received: by 2002:a05:6000:384:b0:210:28d:29f1 with SMTP id u4-20020a056000038400b00210028d29f1mr28708376wrf.512.1654064172802;
        Tue, 31 May 2022 23:16:12 -0700 (PDT)
Received: from [10.188.163.71] (cust-east-parth2-46-193-73-98.wb.wifirst.net. [46.193.73.98])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d6e01000000b0020d03c14b9csm617451wrz.1.2022.05.31.23.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 23:16:12 -0700 (PDT)
Message-ID: <03b3a6bc-586a-2b45-a60c-5ab81076bf13@kernel.dk>
Date:   Wed, 1 Jun 2022 00:16:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH -next v5 0/3] support concurrent sync io for bfq on a
 specail occasion
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
Cc:     paolo.valente@linaro.org, tj@kernel.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220428120837.3737765-1-yukuai3@huawei.com>
 <d50df657-d859-79cf-c292-412eaa383d2c@huawei.com>
 <61b67d5e-829c-8130-7bda-81615d654829@huawei.com>
 <81411289-e13c-20f5-df63-c059babca57a@huawei.com>
 <d5a90a08-1ac6-587a-e900-0436bd45543a@kernel.dk>
 <55919e29-1f22-e8aa-f3d2-08c57d9e1c22@huawei.com>
 <20220523085902.wmxoebyq3crerecr@quack3.lan>
 <25f6703e-9e10-75d9-a893-6df1e6b75254@kernel.dk>
 <20220523152516.7sr247i3bzwhr44w@quack3.lan>
 <13ad158e-7859-ca61-209e-7d1fe99d0bdb@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <13ad158e-7859-ca61-209e-7d1fe99d0bdb@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/23/22 7:13 PM, Yu Kuai wrote:
> ? 2022/05/23 23:25, Jan Kara ??:
>> On Mon 23-05-22 06:36:58, Jens Axboe wrote:
>>> On 5/23/22 2:59 AM, Jan Kara wrote:
>>>> On Mon 23-05-22 09:10:38, yukuai (C) wrote:
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
>>>> So actually I have noticed that a lot of (valid) email from huawei.com (not
>>>> just you) ends up in the spam mailbox. For me direct messages usually pass
>>>> (likely matching SPF records for originating mail server save the email
>>>> from going to spam) but messages going through mailing lists are flagged as
>>>> spam because the emails are missing valid DKIM signature but huawei.com
>>>> DMARC config says there should be DKIM signature (even direct messages are
>>>> missing DKIM so this does not seem as a mailing list configuration issue).
>>>> So this seems as some misconfiguration of the mails on huawei.com side
>>>> (likely missing DKIM signing of outgoing email).
>>>
>>> SPF/DKIM was indeed a problem earlier for yukaui patches, but I don't
>>> see that anymore. Maybe it's still an issue for some emails, from them
>>> or Huawei in general?
>>
>> Hum, for me all emails from Huawei I've received even today fail the DKIM
>> check. After some more digging there is interesting inconsistency in DMARC
>> configuration for huawei.com domain. There is DMARC record for huawei.com
>> like:
>>
>> huawei.com.        600    IN    TXT    "v=DMARC1;p=none;rua=mailto:dmarc@edm.huawei.com"
>>
>> which means no DKIM is required but _dmarc.huawei.com has:
>>
>> _dmarc.huawei.com.    600    IN    TXT    "v=DMARC1;p=quarantine;ruf=mailto:dmarc@huawei.com;rua=mailto:dmarc@huawei.com"
>>
>> which says that DKIM is required. I guess this inconsistency may be the
>> reason why there are problems with DKIM validation for senders from
>> huawei.com. Yu Kuai, can you perhaps take this to your IT support to fix
>> this? Either make sure huawei.com emails get properly signed with DKIM or
>> remove the 'quarantine' record from _dmarc.huawei.com. Thanks!
> Of course, I'll try to contact our IT support.

I second that, pretty much every email has been going into spam since, I
guess you just had a few lucky ones. Looks like Jan is right, it's a
server side configuration error that's causing this, and it's still
happening

-- 
Jens Axboe

