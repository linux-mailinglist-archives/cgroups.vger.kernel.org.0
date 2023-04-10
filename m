Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C6B6DCD5E
	for <lists+cgroups@lfdr.de>; Tue, 11 Apr 2023 00:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjDJWUM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Apr 2023 18:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDJWUM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Apr 2023 18:20:12 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CB91BD;
        Mon, 10 Apr 2023 15:20:09 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id w11so6478483pjh.5;
        Mon, 10 Apr 2023 15:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681165209; x=1683757209;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBQKJUhH2Gii9FMxndSzAy3cZCpQYNgK0Nudh8KyJNE=;
        b=RBibHovbJDP5EyaXGVx3VqOaahujI+f4zS2jgY8LF1zYwY/yfbEGnf2fc00I0+/zVT
         IuXfEzC6QJtJx5ASu2CHGwQr+IZP/RX7gDmxwH0gpV4ZxVO9tQhKVVDkvPJJ6LvALS8H
         qlxpy+OQGsYdKP5KyuW2s9Nh1Uu5aTvXVYk67dLwL8fl6VtxZhFuAjKgkGmU5W2hKSFk
         MMF6htzttfFTXvQZcS4iPk7gtsb9Ji1MVchlRUKh0AnrCi3cIVEsXFZAF5fWCkfwoqFG
         uQWAFmytjPWv1P7kcWdEYkoxPTq7n9TUspCpbVEgfqETI2/kfgOedN3QTbtr5h+YY2lY
         OZrA==
X-Gm-Message-State: AAQBX9eK0LzwjODGx1ERFJT6VTyzBahYDvIose8/bs6enOEoTLZqg06Y
        0FfLRai6wKBbbp2Ecl+MxzjjohNtZ5k=
X-Google-Smtp-Source: AKy350aND5QUQdam7n8MlAf/uvDeh2XVV7bTfoVYUhXne0+Hb3d+mzUToSB7aRzzMO+o50vEwfXVxA==
X-Received: by 2002:a17:903:32cc:b0:1a1:97b5:c63e with SMTP id i12-20020a17090332cc00b001a197b5c63emr16669082plr.38.1681165208613;
        Mon, 10 Apr 2023 15:20:08 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:11fd:f446:f156:c8? ([2620:15c:211:201:11fd:f446:f156:c8])
        by smtp.gmail.com with ESMTPSA id z24-20020a1709028f9800b0019aeddce6casm6650723plo.205.2023.04.10.15.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 15:20:08 -0700 (PDT)
Message-ID: <783e293e-8e4e-7856-f492-395da2f5d376@acm.org>
Date:   Mon, 10 Apr 2023 15:20:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/3] blk-cgroup: some cleanup
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Chengming Zhou <zhouchengming@bytedance.com>, axboe@kernel.dk,
        tj@kernel.org
Cc:     paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20230406145050.49914-1-zhouchengming@bytedance.com>
 <cab869b1-1cba-5698-55eb-a93d0596c869@acm.org>
 <d23a6891-96f0-2ee0-70c7-869123d85362@huaweicloud.com>
 <8651fa1f-7f50-03c6-cd85-e61aa44d4927@acm.org>
In-Reply-To: <8651fa1f-7f50-03c6-cd85-e61aa44d4927@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/10/23 11:47, Bart Van Assche wrote:
> On 4/9/23 18:57, Yu Kuai wrote:
>> Hi, Bart
>>
>> 在 2023/04/08 2:41, Bart Van Assche 写道:
>>> On 4/6/23 07:50, Chengming Zhou wrote:
>>>> These are some cleanup patches of blk-cgroup. Thanks for review.
>>>
>>> With these patches applied, my kernel test VM crashes during boot. 
>>> The following crash disappears if I revert these patches:
>>>
>>> BUG: KASAN: null-ptr-deref in bio_associate_blkg_from_css+0x83/0x240
>>> Read of size 8 at addr 0000000000000518 by task blkid/5885
>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
>>> 1.16.0-debian-1.16.0-5 04/01/2014
>>> Call Trace:
>>>   dump_stack_lvl+0x4a/0x80
>>>   print_report+0x21e/0x260
>>>   kasan_report+0xc2/0xf0
>>>   __asan_load8+0x69/0x90
>>>   bio_associate_blkg_from_css+0x83/0x240
>>>   bfq_bio_bfqg+0xce/0x120 [bfq]
>>>   bfq_bic_update_cgroup+0x2f/0x3c0 [bfq]
>>>   bfq_init_rq+0x1e8/0xb10 [bfq]
>>>   bfq_insert_request.isra.0+0xa3/0x420 [bfq]
>>>   bfq_insert_requests+0xca/0xf0 [bfq]
>>>   blk_mq_dispatch_rq_list+0x4c0/0xb00
>>
>> I found this call trace quite weird, I can't figure out how
>> bfq_insert_requests can be called from blk_mq_dispatch_rq_list,
>> can you show the add2line result?
> 
> Hi Kuai,
> 
> Thanks for having taken a look. I ran my tests with this patch series on 
> top of Jens' for-next branch: "[PATCH v2 00/12] Submit zoned writes in 
> order" 
> (https://lore.kernel.org/linux-block/20230407235822.1672286-1-bvanassche@acm.org/T/#m4c8c7ca5a5627510dc1709847b11589e8791b6b6). I will take a closer look and see which of these two patch series needs to be adjusted.

(replying to my own e-mail)

I think I found the root cause: bio->bi_bdev is NULL for pass-through 
requests and BFQ doesn't like it that bio->bi_bdev is NULL. I will make 
sure that pass-through requests are not submitted to any I/O scheduler.

Thanks,

Bart.

