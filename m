Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EE6530FB8
	for <lists+cgroups@lfdr.de>; Mon, 23 May 2022 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiEWMgh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 May 2022 08:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbiEWMgP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 May 2022 08:36:15 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42981140C9
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 05:36:06 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id j21so13347058pga.13
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=INkfgsb8DgkgWmtKMANQ1Vo1QXhIfhnDd/K2kDPrH3Q=;
        b=1fhqz3+apWfJ+ZsEhTE6mAVaEw1c/7DNg5ozDW0PFTFoPjcNQOq1PewkdDlvrMsykq
         zYigUM7hOavb8VqDpEuzNufWasevbXmlT6JhI1F/KHvLNxI23r+ANzri4beDnNmNEL13
         ODquPR328ZY4b40JXwFPQTOnTnwYkbGYWED9ZOV5MeVDmCJrfQPqUoJFL7W7Y48MHVtx
         BnpWrbGRb4TRH9+dWCJo8TrBOSVnWQ+NMpzcn0l3qKbGeVKPKOffJedFeiBSm8MDr5s6
         IuVdKGNPEhNpBRS154C67LLzdc0nq4Z/9VZCWPjPwJ9aAKXm0EQahgtm9sGMSkF1DvIm
         VMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=INkfgsb8DgkgWmtKMANQ1Vo1QXhIfhnDd/K2kDPrH3Q=;
        b=TyfY2GjyfclIGqgKfIi67gN06iPmLC4OHS8DKAUF3i69Llp0RvuCFq3RPbtATyIdtB
         NOkJLvcgof8WahJ61PYhl6+VTR2/h0+xOiB1aE2WEIYwKzw2tqsxh90v86oS01lluUVh
         pPdnfeB5lzRbRHEJ6Gc9Wcqz23dK8BgE9/cJHCJviSsubnhSNGFymH85SN70XUMg4H7y
         JTNA5GGnrb7eLlQXClNrfEO7QatBps35vbYpPd1M+ng+8oZzUALtUogugZBPdAUn8YH4
         mDVOd7ncvWQZ+KghC3UJ9KcJAEag1QRT85mbPqsa98Qh2oy2Shoy0h20Ig8hnu0LvAah
         O4nQ==
X-Gm-Message-State: AOAM530uE13ckN3367cf7ubq+Zor/AjAVJuzlLdlW516U7w5BteyGnBw
        R/o0XCsA/SYslBa0G4kymLu+Nw==
X-Google-Smtp-Source: ABdhPJxgbS504JkLNi1GG1RBkkzpmYhy4T9e/1i/En0Pu2KHyWvPQjZQaaYP37Mzz2R5Jcq9YxVMNg==
X-Received: by 2002:a63:cd0b:0:b0:3c6:afc0:32a6 with SMTP id i11-20020a63cd0b000000b003c6afc032a6mr19958954pgg.436.1653309365142;
        Mon, 23 May 2022 05:36:05 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b24-20020a056a0002d800b0050dc76281besm7012750pft.152.2022.05.23.05.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 05:36:04 -0700 (PDT)
Message-ID: <dfd2ac0b-74da-85f4-ff66-2eb307578d93@kernel.dk>
Date:   Mon, 23 May 2022 06:36:03 -0600
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
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1172d00f-0843-1d7c-721f-fdb60a0945cb@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/23/22 2:18 AM, Yu Kuai wrote:
> ? 2022/05/23 9:24, Jens Axboe ??:
>> On 5/22/22 7:10 PM, yukuai (C) wrote:
>>> ? 2022/05/21 20:21, Jens Axboe ??:
>>>> On 5/21/22 1:22 AM, yukuai (C) wrote:
>>>>> ? 2022/05/14 17:29, yukuai (C) ??:
>>>>>> ? 2022/05/05 9:00, yukuai (C) ??:
>>>>>>> Hi, Paolo
>>>>>>>
>>>>>>> Can you take a look at this patchset? It has been quite a long time
>>>>>>> since we spotted this problem...
>>>>>>>
>>>>>>
>>>>>> friendly ping ...
>>>>> friendly ping ...
>>>>
>>>> I can't speak for Paolo, but I've mentioned before that the majority
>>>> of your messages end up in my spam. That's still the case, in fact
>>>> I just marked maybe 10 of them as not spam.
>>>>
>>>> You really need to get this issued sorted out, or you will continue
>>>> to have patches ignore because folks may simply not see them.
>>>>
>>> Hi,
>>>
>>> Thanks for your notice.
>>>
>>> Is it just me or do you see someone else's messages from *huawei.com
>>> end up in spam? I tried to seek help from our IT support, however, they
>>> didn't find anything unusual...
>>
>> Not sure, I think it's just you. It may be the name as well "yukuai (C)"
> Hi, Jens
> 
> I just change this default name "yukuai (C)" to "Yu Kuai", can you
> please have a check if following emails still go to spam?
> 
> https://lore.kernel.org/all/20220523082633.2324980-1-yukuai3@huawei.com/

These did not go into spam, were delivered just fine.

-- 
Jens Axboe

