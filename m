Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D464B3F4
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 12:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiLMLQc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 06:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbiLMLPn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 06:15:43 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CD1E4C;
        Tue, 13 Dec 2022 03:15:07 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id u19so17155940ejm.8;
        Tue, 13 Dec 2022 03:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxAbmC5fTjrJjV2pr7W0uw74csIsAjG9pytfI1WxJUI=;
        b=f4Bzn5C1xckKlqT5014puwng2kD1E2/F4R2LPJBkKi5fyiSKUCgk3qlhN0w+M3YRw8
         R2qBtROLfXXYXfW/CaOW8tVaZ1IvxgzIef448d2VEy0/bGr2SQGvZWc/WQsjMnWl9Uih
         JPiKxX4UEbtTTfF7PAJn4FL3owWaEEEnmcj1n6eWrAQljH7IKZcvkotFF87yqEZF0Dg1
         OJUGHjbABmzWtQfB3GBoTcEZqVvHsSZljsvhEtoesWzE4jK+j6gFNTsiJnXEEbFmjiHJ
         MPj+z8Bo8R+0ytTp83MU+N2xI+5BmbitlSmrYttAsSjDoivADrQb3nOKIYhaJbR16tHv
         d/iQ==
X-Gm-Message-State: ANoB5pks9Wu9jfXco/7mfwkUb4dVht1zFSE9JlNwzB7aR0z/zoGb256N
        eDXvMfqqayvL+vu8tI2nYOk=
X-Google-Smtp-Source: AA0mqf7k1PUD5wczDK8PXN/VI6k3wtfoATIqdvkLuEay8VuzZbEuikeolbb22HXRTTkIcT+gQkSg8w==
X-Received: by 2002:a17:907:d609:b0:7c1:4fea:cf2 with SMTP id wd9-20020a170907d60900b007c14fea0cf2mr11156996ejc.0.1670930106256;
        Tue, 13 Dec 2022 03:15:06 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id bq19-20020a170906d0d300b007bf5250b515sm4414853ejb.29.2022.12.13.03.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 03:15:05 -0800 (PST)
Message-ID: <9d2ead31-efab-cf49-08d4-1e613382d89f@kernel.org>
Date:   Tue, 13 Dec 2022 12:15:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] block/blk-iocost (gcc13): cast enum members to int in
 prints
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
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <f5220f08bd7f45248d718f1919503261@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 13. 12. 22, 9:30, David Laight wrote:
> From: Tejun Heo <htejun@gmail.com> On Behalf Of 'Tejun Heo'
>> Sent: 12 December 2022 21:47
>> To: Jiri Slaby <jirislaby@kernel.org>
>> Cc: David Laight <David.Laight@ACULAB.COM>; Christoph Hellwig <hch@infradead.org>; linux-
>> kernel@vger.kernel.org; Martin Liska <mliska@suse.cz>; Josef Bacik <josef@toxicpanda.com>; Jens Axboe
>> <axboe@kernel.dk>; cgroups@vger.kernel.org; linux-block@vger.kernel.org
>> Subject: Re: [PATCH] block/blk-iocost (gcc13): cast enum members to int in prints
>>
>> On Mon, Dec 12, 2022 at 01:14:31PM +0100, Jiri Slaby wrote:
>>>> If so, my suggestion is just sticking with the old behavior until we switch
>>>> to --std=g2x and then make one time adjustment at that point.
>>>
>>> So is the enum split OK under these circumstances?
>>
>> Oh man, it's kinda crazy that the compiler is changing in a way that the
>> same piece of code can't be compiled the same way across two adjoining
>> versions of the same compiler. But, yeah, if that's what gcc is gonna do and
>> splitting enums is the only way to be okay across the compiler versions,
>> there isn't any other choice we can make.
> 
> It is also a silent code-breaker.
> Compile this for 32bit x86:
> 
> enum { a = 1, b = ~0ull};

But having ull in an enum is undefined anyway. C99 allows only int 
constants. gnuC supports ulong expressions (IIRC).

> extern int foo(int, ...);
> int f(void)
> {
>      return foo(0, a, 2);
> }
> 
> gcc13 pushes an extra zero onto the stack between the 1 and 2.

So this is sort of "expected".

thanks,
-- 
js
suse labs

