Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C73A6113B8
	for <lists+cgroups@lfdr.de>; Fri, 28 Oct 2022 15:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJ1N4z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Oct 2022 09:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJ1N4y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Oct 2022 09:56:54 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458F336DCE
        for <cgroups@vger.kernel.org>; Fri, 28 Oct 2022 06:56:53 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id x16so2966672ilm.5
        for <cgroups@vger.kernel.org>; Fri, 28 Oct 2022 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNmbf1DrFhGYblawzk2OE47DJTJRUcUrHVQAL/CfprY=;
        b=dG6ulbLayOltV06VckG15ZM5FJG6iiZzromr13Dxi9USxiXVkCtDGqYIAKXSbEjEsg
         6/4zFI9eNDP16ioOt8eBqfK8LLHx9YAtHYAYPLbwGmmU5UBbzmoybUtx16fyzkvhSzR3
         HPY9oV/7QoeTtkKuooaEE+gZnrMu+aqm39boPj7zzGFLLvQJ6VBcsZBBqut7VaIb/buj
         q895fmC/zzzcl+kzWfQ5az43Fi57FG/UVkb72MqRQqVdXSkkuM09YdFcOS8Tska1OEc5
         j3FPfxhv11zq8/5nlaYYCS0Zbo0fVkH/+r+h15pChOem9+8KkNlUI3gQ8khWOzAEmFqK
         kHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNmbf1DrFhGYblawzk2OE47DJTJRUcUrHVQAL/CfprY=;
        b=1zDJsDRWZ2i85iJrHshu1DMg9S96hLlTtWSU4+Qu1IZZ9gt5czxnVfszr5w3Lhd2wN
         bOpIAi7RvElVQm1ZZAkg1xixC+MM7ouqQUanc5tJie6qRlWwFR+gtHcTgANG4xfTbf0B
         8iXvy3OC43uCfqYJ8VpN5AzLQA49d8yhlEbF4d88bpMEU0SGJMTjVfvppso8C0XW/Mxb
         9VlPTr+owMhJaMVUs8C8MRL1kg45Sl1t+dcAvftouP/unRS5U6Driac5pNnXAd6sy5wh
         nkuLE32e8ffDMXY0+vgLC0XdbcEOfqAdITO5FabXNGt7X+JQs/WZIHCP/RvRAXjF6B2X
         zPvA==
X-Gm-Message-State: ACrzQf284aVkDXXbbyf2F6Tqa7bAz0tgGuQyb9VlpJTMp8ChhhvyCShb
        1cTMBnfodNtg2C2N3K1MkivLtU+6H3iDJaMG
X-Google-Smtp-Source: AMsMyM67Rc2FdwlFNx71PR911GhNj2eaxZcauUCfpYlVrbJm9CnlVNFcL7nioQrLtCwqwEdextZnag==
X-Received: by 2002:a05:6e02:1e02:b0:2fc:6288:e6e6 with SMTP id g2-20020a056e021e0200b002fc6288e6e6mr35376483ila.172.1666965412619;
        Fri, 28 Oct 2022 06:56:52 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k11-20020a0566022a4b00b006bba42f7822sm1704584iov.52.2022.10.28.06.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:56:51 -0700 (PDT)
Message-ID: <60b91c39-1e54-ac8b-5e9e-db7e46ca2d60@kernel.dk>
Date:   Fri, 28 Oct 2022 07:56:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RFC][PATCH v2 04/31] timers: block: Use del_timer_shutdown()
 before freeing timer
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, drbd-dev@lists.linbit.com,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20221027150525.753064657@goodmis.org>
 <20221027150925.819019339@goodmis.org>
 <20221027111944.39b3a80c@gandalf.local.home> <Y1uSG/7VXWLNlxlt@infradead.org>
 <20221028062414.7859f787@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221028062414.7859f787@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/28/22 4:24 AM, Steven Rostedt wrote:
> On Fri, 28 Oct 2022 01:26:03 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
>> This is just a single patch out of apparently 31, which claims that
>> something that doesn't even exist in mainline must be used without any
>> explanation.  How do you expect anyone to be able to review it?
> 
>   https://lore.kernel.org/all/20221027150525.753064657@goodmis.org/
> 
> Only the first patch is relevant to you. I guess the Cc list would have
> been too big to Cc everyone that was Cc'd in the series.

No it's not, because how on earth would anyone know what the change does
if you only see the simple s/name/newname change? The patch is useless
by itself.

-- 
Jens Axboe


