Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA404649E7E
	for <lists+cgroups@lfdr.de>; Mon, 12 Dec 2022 13:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiLLMOj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 07:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiLLMOg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 07:14:36 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3D9D4C;
        Mon, 12 Dec 2022 04:14:35 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id l11so12559295edb.4;
        Mon, 12 Dec 2022 04:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lE6rZOS9ffH/Yk3dYNMYdk596yZemDJvPNi7MI+99fc=;
        b=wnBZ9r/FllzC/yJIVEmUOXCq7I6LwZdd5Ex+Yg26YM7CxqsSXw+gZgRZ1Xi7FNENuR
         0FgQaF3p6nRRsH2/MICEle6LWXpGRSNI1/bxmgsZzpaGfAo3pih8Eyb86fBjyD/kqOBg
         JnW32jqoRTDMgLYWSlJOEFi6nMqZClp7Vmalunkq4yHVibfkpN4A5EXnTVuQ+f4q6E3s
         zAZZmR6XBBTBF8LS6AHwvx/+xWHtx9Zk4jwBzCXVyvuLM3rfLJldvVLYQEOe068YiUfz
         IlBDFuY5vwla4g2lmwyUeC4MVuDZs1p5MmDsjG5q77I+a3MWjIGq25UjqEJo26C0jB3A
         lmpQ==
X-Gm-Message-State: ANoB5plh0DbbZgdmkz8bH6sUEyCr8lJYOIL05sC4OyAzCgDako0CLdod
        oMTBmiB1oOP0pCcr0umit8DnHtx4a2I=
X-Google-Smtp-Source: AA0mqf5cQ1XTq4teqMLyzufekz56JM7/B1EWW7eTmW9tnCed3w16O9QrHsNa0l5R4gTL/V4YViR3Bw==
X-Received: by 2002:aa7:c614:0:b0:46c:ab70:c009 with SMTP id h20-20020aa7c614000000b0046cab70c009mr13965869edq.27.1670847273463;
        Mon, 12 Dec 2022 04:14:33 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id s25-20020aa7d799000000b0045b910b0542sm3695122edq.15.2022.12.12.04.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 04:14:32 -0800 (PST)
Message-ID: <320c939e-a3f0-1b1e-77e4-f3ecca00465d@kernel.org>
Date:   Mon, 12 Dec 2022 13:14:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     'Tejun Heo' <tj@kernel.org>, David Laight <David.Laight@aculab.com>
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
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] block/blk-iocost (gcc13): cast enum members to int in
 prints
In-Reply-To: <Y2KePvYRRMOrqzOe@slm.duckdns.org>
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

On 02. 11. 22, 17:43, 'Tejun Heo' wrote:
> On Wed, Nov 02, 2022 at 06:27:46AM -1000, 'Tejun Heo' wrote:
>> On Wed, Nov 02, 2022 at 08:35:34AM +0000, David Laight wrote:
>>> I think the enums have to be split.
>>> There will be other side effects of promoting the constants to 64bit
>>> that are much more difficult to detect than the warnings from printf.
>>
>> idk, I think I can just add LLU to everything and it should be fine.
>>
>>> I'm also not sure whether the type is even consistent for 32bit
>>> and 64bit builds.
>>> Casts are (sort of) horrid.
>>
>> Yeah, I don't think casts are the solution either. Lemme add LLU to
>> everything and see how it works.
> 
> So adding LLU to initializers don't make the specific enum's type follow
> suit. I guess type determination is really based on the value range. Oh man,
> what a mess.
> 
> If we end up having to split the enum defs, that's what we'll do but this
> doesn't sense to me. It's one thing to make one time adjustment when we
> adopt -std=g2x. That's fine, but it makes no sense for the compiler to
> change type behavior underneath existing code bases in a way that prevents
> the same code to mean the same thing in adjacent and recent compiler
> versions. Even if gcc goes for that for whatever reason, there gotta be an
> option to keep the original behavior, right?

Unfortunately not, see:
   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107405#c8
(linked also from the commit log). We'd use such an option if there were 
one.

> If so, my suggestion is just sticking with the old behavior until we switch
> to --std=g2x and then make one time adjustment at that point.

So is the enum split OK under these circumstances?

thanks,
-- 
js
suse labs

