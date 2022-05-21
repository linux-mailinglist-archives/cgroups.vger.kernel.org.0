Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE052FC54
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 14:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbiEUMVf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 08:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238188AbiEUMVe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 08:21:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DEB1FA77
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 05:21:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p8so9787208pfh.8
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 05:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gfHmtlCQtYvyaOp3BTWx/NwfcevCZ/dQvENt+OCB6OU=;
        b=i1Z7sKvKg/r7Fu90Re3JGKGo4OH8g8Rh6cF/OLtxysHA/ntRqQvqKVSVq2oF1hT6L4
         cNnY4wBcAg9kqs771D/Xc0PAxFm6ZZUDIHEvQjJlLqiY3ZTF1MkvntDJylyJoP3yjEBy
         aEgkl0OIh0MepffoSk4c1rEgxTlrxXHO0w8y7AoWrX0RPPOstSM83S7ponJCoxe2/3Fk
         cwTavtZmoY0/bOt2sJHHNhlb66apetZalZEVahMDSTFRMRHJpK3IFC3Iowh6/6VEjb2O
         U9kKXX8EL0eVtbcvNrYJg2Z3WKlp5dK6tZVXG5aOLhqu829Yw3YQXHKun68AuCwVTcgC
         vCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gfHmtlCQtYvyaOp3BTWx/NwfcevCZ/dQvENt+OCB6OU=;
        b=BPwwjnhzOXddSUJaFvE/rJBQ+7xO6oOzWvMF4LwU0X82hdCmitOrRO7jvkDZkK0B0l
         SdBLKZAQo0YL7go2BdFvknSykCySOcgzOLE0WPzIb294eoTS9KsoFnzfsn8jJB0tPecJ
         +YWIRmzWuh0cto/u0NuUAfcDD1kXuEIQM3M+2BsWhs+GJ0p7mV8z8+00pJJ8c8u2ebuJ
         my737Gmy//SeF2sXDkBhyskdlWueuIGfgSf6bVYV0G0JFIDfQ2n+4Z+QQf1Vpq1iNRwd
         6ndEwgWRl/mZe4cqThhcIpDSGVkLMREvQsV7PIODKs1UdRx1rL5XFTqfD9kpYVRpNWzc
         hvIQ==
X-Gm-Message-State: AOAM532NjKAA5VkrGMMVOAyfd9/gjFAU7Qkhg5MdBzPvwj0Dxoh6EC6b
        /eXshCj/N7gefuk8rjnwdglNnw==
X-Google-Smtp-Source: ABdhPJw+5j9W+uGqvyx64pvj2Pi9VtZZrzR4LWDDdBMSzozlbeja1Pr6gXBE/S71yWDyxP7HGY8Qjg==
X-Received: by 2002:a63:3c05:0:b0:3f2:6ea8:aff2 with SMTP id j5-20020a633c05000000b003f26ea8aff2mr12765049pga.340.1653135689908;
        Sat, 21 May 2022 05:21:29 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t71-20020a63784a000000b003db610ebdd0sm1403982pgc.65.2022.05.21.05.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 05:21:29 -0700 (PDT)
Message-ID: <d5a90a08-1ac6-587a-e900-0436bd45543a@kernel.dk>
Date:   Sat, 21 May 2022 06:21:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH -next v5 0/3] support concurrent sync io for bfq on a
 specail occasion
Content-Language: en-US
To:     "yukuai (C)" <yukuai3@huawei.com>, paolo.valente@linaro.org
Cc:     jack@suse.cz, tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220428120837.3737765-1-yukuai3@huawei.com>
 <d50df657-d859-79cf-c292-412eaa383d2c@huawei.com>
 <61b67d5e-829c-8130-7bda-81615d654829@huawei.com>
 <81411289-e13c-20f5-df63-c059babca57a@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <81411289-e13c-20f5-df63-c059babca57a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/21/22 1:22 AM, yukuai (C) wrote:
> 在 2022/05/14 17:29, yukuai (C) 写道:
>> 在 2022/05/05 9:00, yukuai (C) 写道:
>>> Hi, Paolo
>>>
>>> Can you take a look at this patchset? It has been quite a long time
>>> since we spotted this problem...
>>>
>>
>> friendly ping ...
> friendly ping ...

I can't speak for Paolo, but I've mentioned before that the majority
of your messages end up in my spam. That's still the case, in fact
I just marked maybe 10 of them as not spam.

You really need to get this issued sorted out, or you will continue
to have patches ignore because folks may simply not see them.

-- 
Jens Axboe

