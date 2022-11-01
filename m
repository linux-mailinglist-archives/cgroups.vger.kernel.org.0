Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1490614466
	for <lists+cgroups@lfdr.de>; Tue,  1 Nov 2022 06:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiKAFrC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 01:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiKAFrA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 01:47:00 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BB513DFE;
        Mon, 31 Oct 2022 22:46:59 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id l32so8305464wms.2;
        Mon, 31 Oct 2022 22:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1nOOZythsV2g8dI/k40n8Y3Bwl44ga7mCUJ7dmyDVA=;
        b=hExMakRCE2evZY01bxMW0G8VFkY4KVPXH+pgAsKPiF2d434pReI653/UBc0lL1AtuJ
         K/cAI7ZJ9ToLD+U8f8gdi/4uQZDYnZ2Qy/GkYaYreH9tHCcylo8MoJgsy2W2OYdp4dcs
         XOs25KA1nS4nWIkPwnSk+AfhHifWFWV5qujfTKIvIwnAnote+9GceeY/1adWIjxunfTH
         LV8ipX9uIHIDUzWfe7+uHxYTlASMjiC7SGkm/Ys4Qg/Ufakgnt0FGLsANLhJSUhUTb7s
         CcGuuhM9DtMA5ANbO3YVGs3IMx5elo7FvMXx48wi/To/+vepQbpRqaq0vUEmMyErgVPd
         bzww==
X-Gm-Message-State: ACrzQf3MU8UHMzIIBPFdTApCoxkkcQR2EZ4E6Fs77ELy4Tl0NYpUrYzr
        kzgFMX4WF1OSitZTNn6WjqM=
X-Google-Smtp-Source: AMsMyM5pTbJRsY//OK1Fm0CiekBIolyy8s4KyEyQuT/BY5M8i3/7oSGGuYVOjgemAmEWvS/jiAA93A==
X-Received: by 2002:a05:600c:1819:b0:3cf:63fe:944a with SMTP id n25-20020a05600c181900b003cf63fe944amr10108150wmp.17.1667281618063;
        Mon, 31 Oct 2022 22:46:58 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id u7-20020adfed47000000b002366f9bd717sm10941188wro.45.2022.10.31.22.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 22:46:57 -0700 (PDT)
Message-ID: <d833ad15-f458-d43d-cab7-de62ff54a939@kernel.org>
Date:   Tue, 1 Nov 2022 06:46:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20221031114520.10518-1-jirislaby@kernel.org>
 <Y1++fLJXkeZgtXR2@infradead.org> <Y2AMcSPAJpj6obSA@slm.duckdns.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] block/blk-iocost (gcc13): cast enum members to int in
 prints
In-Reply-To: <Y2AMcSPAJpj6obSA@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 31. 10. 22, 18:57, Tejun Heo wrote:
> On Mon, Oct 31, 2022 at 05:24:28AM -0700, Christoph Hellwig wrote:
>> On Mon, Oct 31, 2022 at 12:45:20PM +0100, Jiri Slaby (SUSE) wrote:
>>> Cast the enum members to int when printing them.
>>>
>>> Alternatively, we can cast them to ulong (to silence gcc < 12) and use %lu.
>>> Alternatively, we can move VTIME_PER_SEC away from the enum.
>>
>> Yes, either split the enum or just use a define.  But casts are a big
>> code smell and should be avoided if there is a reasonable alternative.
> 
> enums are so much better for debugging and other instrumentation stuff. The
> only requirement for the enum types is that they're big enough to express
> all the members and we can use whatever printf format letter which matches
> the type in use. The problem here is that the compiler behavior is different
> depending on the compiler version, which kinda sucks.

Yes. The real problem is that using anything else then an INT_MIN <= x 
<= INT_MAX _constant_ in an enum is undefined in ANSI C < 2x (in 
particular, 1 << x is undefined too). gcc manual defines unsigned int on 
the top of that as defined too (so this holds for our -std=g*).

> I suppose the most reasonable thing to do here is just splitting them into
> separate enum definitions. Does anyone know how this behavior change came to
> be?

C2x which introduces un/signed long enums. See the bug I linked in the 
commit log:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36113

The change is also turned on in < C2x on purpose. AIUI, unless there is 
too much breakage. So we'd need to sort it out in (rather distant) 
future anyway (when we come up to -std=g2x).

> Do we know whether clang is gonna be changed the same way?

In C2x, Likely. In < C2x, dunno what'd be the default.

thanks,
-- 
js
suse labs

