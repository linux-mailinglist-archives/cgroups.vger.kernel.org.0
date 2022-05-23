Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997CB53108F
	for <lists+cgroups@lfdr.de>; Mon, 23 May 2022 15:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbiEWMhF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 May 2022 08:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbiEWMhC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 May 2022 08:37:02 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF46D4CD79
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 05:37:00 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h186so13557146pgc.3
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L18DlrO1XtDATl5hYjR3u+d9RECswhbrU+Pb38Js3ks=;
        b=JPrsnrHfNbDWW8uJ6kKFgzO5szuJhqQJLtNpQJjh4Q321Oq3Dg2PJSwb344Snwl0aT
         6XvysX8RCg64WjCOz9hKQCekBRzdVnbvnWZBx2vl3DXsfMe6252Nh/8UA0xydXuCjfqP
         hqi4H3Vo0ZxSzk6qfBC+lAtshlsEebYPectaMGWkwKMpy2wxiHUF+F3GGuw9mtS5n/5C
         Om9NqySHY1pJx59ONDkraeOaSRduGCCNMnv/46+11kwCRSfHgKx7ht5oIBpJIa49jrqG
         bIPVZrHUwUVxzhPBrU+ujxfWluAP7f+yhsnBPpTNa2rq8GcRlJCw9MZ0qGRfGJ2nmu9C
         faUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L18DlrO1XtDATl5hYjR3u+d9RECswhbrU+Pb38Js3ks=;
        b=x4HWYZ1kk9Ir/3W1mQJq+2mbFyosFyFG2+xJnlF1VPaZkVPSfQO57HiOu9pSWtv/yi
         6iuI/z9MzIZt8zZkg+4nbgrqUdJSAJcHJakT5qq8KaVRtFTQOVrCULPRy2Tbyb1gPY1x
         DbMBmJdoHNNOvdq8WdW9GwtMcpLNzDPX++RQJbJ/bGbVWgjOwz9lufCp3ZYUO2N72Oak
         FbbXKjaLfNpLwuryS4vys/xYhtltQ+R/nFJYc/uFX+tq/LATAYAciembChZXuRM0awde
         2y5JQr7BMLt/9r3sEZ4pxrK7LHoI8DbjQ68s5rlhayVwdktoDLftrvqdP8OKXGTo/Uad
         DnDg==
X-Gm-Message-State: AOAM532IWgxcd0PcCK+2tvlCC5QWNPb1m5TKZd6ptJvDgKKNqK5a7RiP
        jv9EmUAnGjg4NtUlwkWAcetD1w==
X-Google-Smtp-Source: ABdhPJz+Ih+6rif1P5tA46q5pJ1od0Rs4C8Ji7Eb8o9LdISTbXYMMTGTFtnK3wBVca3+wPcuaXSpPQ==
X-Received: by 2002:a63:2209:0:b0:3ab:113b:9a2b with SMTP id i9-20020a632209000000b003ab113b9a2bmr20357561pgi.235.1653309420117;
        Mon, 23 May 2022 05:37:00 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i7-20020a1709026ac700b0015e8d4eb25asm5000680plt.164.2022.05.23.05.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 05:36:59 -0700 (PDT)
Message-ID: <25f6703e-9e10-75d9-a893-6df1e6b75254@kernel.dk>
Date:   Mon, 23 May 2022 06:36:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH -next v5 0/3] support concurrent sync io for bfq on a
 specail occasion
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, "yukuai (C)" <yukuai3@huawei.com>
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
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220523085902.wmxoebyq3crerecr@quack3.lan>
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

On 5/23/22 2:59 AM, Jan Kara wrote:
> On Mon 23-05-22 09:10:38, yukuai (C) wrote:
>> ? 2022/05/21 20:21, Jens Axboe ??:
>>> On 5/21/22 1:22 AM, yukuai (C) wrote:
>>>> ? 2022/05/14 17:29, yukuai (C) ??:
>>>>> ? 2022/05/05 9:00, yukuai (C) ??:
>>>>>> Hi, Paolo
>>>>>>
>>>>>> Can you take a look at this patchset? It has been quite a long time
>>>>>> since we spotted this problem...
>>>>>>
>>>>>
>>>>> friendly ping ...
>>>> friendly ping ...
>>>
>>> I can't speak for Paolo, but I've mentioned before that the majority
>>> of your messages end up in my spam. That's still the case, in fact
>>> I just marked maybe 10 of them as not spam.
>>>
>>> You really need to get this issued sorted out, or you will continue
>>> to have patches ignore because folks may simply not see them.
>>>
>> Hi,
>>
>> Thanks for your notice.
>>
>> Is it just me or do you see someone else's messages from *huawei.com
>> end up in spam? I tried to seek help from our IT support, however, they
>> didn't find anything unusual...
> 
> So actually I have noticed that a lot of (valid) email from huawei.com (not
> just you) ends up in the spam mailbox. For me direct messages usually pass
> (likely matching SPF records for originating mail server save the email
> from going to spam) but messages going through mailing lists are flagged as
> spam because the emails are missing valid DKIM signature but huawei.com
> DMARC config says there should be DKIM signature (even direct messages are
> missing DKIM so this does not seem as a mailing list configuration issue).
> So this seems as some misconfiguration of the mails on huawei.com side
> (likely missing DKIM signing of outgoing email).

SPF/DKIM was indeed a problem earlier for yukaui patches, but I don't
see that anymore. Maybe it's still an issue for some emails, from them
or Huawei in general?

-- 
Jens Axboe

