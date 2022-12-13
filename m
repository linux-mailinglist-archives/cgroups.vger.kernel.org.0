Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D2A64B4BF
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 13:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbiLMMFY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 07:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiLMMFP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 07:05:15 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768A613D19;
        Tue, 13 Dec 2022 04:05:14 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id ud5so35957731ejc.4;
        Tue, 13 Dec 2022 04:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPYhp3/wRILILexYFSY+yQQrJNUGksGAZk9Xaob/A1M=;
        b=MsN5P/oTSUSAthyOPHkLCMrWFfnqs6cIKuDvLHsjWIl498xvs2CsicKiL4uG9+Q/jz
         GwFrzhO+ksGWwMH3pPmN6V45WDofSsh2jZBZRiMqE57Rw+bVCHSS+nK52h5/HsG4On11
         uimr6Fi/mmnCWxQpsrV86m+Dv0I+ZMLmBSPfQezi0Y9Ic+1HrW6iTqW1Fw0hRmotcwBC
         3pmR0touyg8v6z8l+wm0r6t6OLnzKcjiKZe83ghhUsebSAjzVib9DWVkb1rQxc3shRQk
         ka018Q7L8NRVY+QOocfTcAZETuv2QsTFf4KYu0dNeLsPpaNhCOoeBVf+FZWdK4tQkVnd
         dhiQ==
X-Gm-Message-State: ANoB5pmU4FC5jCnxqwkwTJ5KEwSyj2peFKPsoU20TXGYpWqGPsFdw9hv
        VKJ/lYTm/aMWLSbVfVu99b34Mbp92iU=
X-Google-Smtp-Source: AA0mqf7fbb16C/qDuFuaGmSH17c1nOYAmzUV0D19skLUZFRhLSqwwkXyO9hxWsPwTpNC1gcQ/YF/5A==
X-Received: by 2002:a17:907:7426:b0:7c0:e4b6:601d with SMTP id gj38-20020a170907742600b007c0e4b6601dmr14460477ejc.7.1670933113026;
        Tue, 13 Dec 2022 04:05:13 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090653c100b007ae38d837c5sm4564214ejo.174.2022.12.13.04.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 04:05:12 -0800 (PST)
Message-ID: <c7539121-c8fc-b4b7-b722-ead833420b2b@kernel.org>
Date:   Tue, 13 Dec 2022 13:05:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] block/blk-iocost (gcc13): cast enum members to int in
 prints
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>, 'Tejun Heo' <tj@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Martin Liska <mliska@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20221031114520.10518-1-jirislaby@kernel.org>
 <Y1++fLJXkeZgtXR2@infradead.org> <Y2AMcSPAJpj6obSA@slm.duckdns.org>
 <d833ad15-f458-d43d-cab7-de62ff54a939@kernel.org>
 <Y2FNa4bGhJoevRKT@slm.duckdns.org>
 <2b975ee3117e45aaa7882203cf9a4db8@AcuMS.aculab.com>
 <Y2Kaghnu/sPvl0+g@slm.duckdns.org> <Y2KePvYRRMOrqzOe@slm.duckdns.org>
 <320c939e-a3f0-1b1e-77e4-f3ecca00465d@kernel.org>
 <Y5ehU524daymEKgf@slm.duckdns.org>
 <f5220f08bd7f45248d718f1919503261@AcuMS.aculab.com>
 <9d2ead31-efab-cf49-08d4-1e613382d89f@kernel.org>
 <542d413b9d044474a34b6e7a40d70541@AcuMS.aculab.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <542d413b9d044474a34b6e7a40d70541@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 13. 12. 22, 12:50, David Laight wrote:
> From: Jiri Slaby
>> Sent: 13 December 2022 11:15
>>
>> On 13. 12. 22, 9:30, David Laight wrote:
>>> From: Tejun Heo <htejun@gmail.com> On Behalf Of 'Tejun Heo'
>>>> Sent: 12 December 2022 21:47
>>>> To: Jiri Slaby <jirislaby@kernel.org>
>>>> Cc: David Laight <David.Laight@ACULAB.COM>; Christoph Hellwig <hch@infradead.org>; linux-
>>>> kernel@vger.kernel.org; Martin Liska <mliska@suse.cz>; Josef Bacik <josef@toxicpanda.com>; Jens
>> Axboe
>>>> <axboe@kernel.dk>; cgroups@vger.kernel.org; linux-block@vger.kernel.org
>>>> Subject: Re: [PATCH] block/blk-iocost (gcc13): cast enum members to int in prints
>>>>
>>>> On Mon, Dec 12, 2022 at 01:14:31PM +0100, Jiri Slaby wrote:
>>>>>> If so, my suggestion is just sticking with the old behavior until we switch
>>>>>> to --std=g2x and then make one time adjustment at that point.
>>>>>
>>>>> So is the enum split OK under these circumstances?
>>>>
>>>> Oh man, it's kinda crazy that the compiler is changing in a way that the
>>>> same piece of code can't be compiled the same way across two adjoining
>>>> versions of the same compiler. But, yeah, if that's what gcc is gonna do and
>>>> splitting enums is the only way to be okay across the compiler versions,
>>>> there isn't any other choice we can make.
>>>
>>> It is also a silent code-breaker.
>>> Compile this for 32bit x86:
>>>
>>> enum { a = 1, b = ~0ull};
>>
>> But having ull in an enum is undefined anyway. C99 allows only int
>> constants. gnuC supports ulong expressions (IIRC).
> 
> gcc supports 'long long' as well - 64bit on 32bit systems.

Can you elaborate what's source of this? Gcc manual says this about enum 
values:

The integer type compatible with each enumerated type (C90 6.5.2.2, C99 
and C11 6.7.2.2).

Normally, the type is unsigned int if there are no negative values in 
the enumeration, otherwise int. If ‘-fshort-enums’ is specified, ..., 
otherwise it is the first of unsigned char, unsigned short and unsigned 
int that can represent all the values.

I.e. the documentation says uint is the highest possible enum value.

C2x/g2x also supports ulong (that's what it is all about). But we don't 
do c2x quite yet.

thanks,
-- 
-- 
js
suse labs

