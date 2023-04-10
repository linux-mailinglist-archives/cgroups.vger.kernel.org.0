Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A6E6DCB17
	for <lists+cgroups@lfdr.de>; Mon, 10 Apr 2023 20:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjDJSr5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Apr 2023 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjDJSrw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Apr 2023 14:47:52 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B8C2681;
        Mon, 10 Apr 2023 11:47:36 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1a516fb6523so6046405ad.3;
        Mon, 10 Apr 2023 11:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681152456; x=1683744456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/wrJEyb3+a5lpb9UjwwVTGaTVjn/LL/vtD2/dCiZU4=;
        b=DE343F7BngaV9MvL6eAOZkUZvoN5WJAumbJNHV6VZr/HKqsFJdRUwtYGYDTWqXLpfm
         E3Pd2t4ahKDKGdLgdJNxt/vThcaF9znQ7LcqgTGjNN2F3tTNceVjNIfT6riVw8nJE6it
         +XqJhAwdMhHkVjHIRaplVGCgiVJ/MZAHu9CX5Zdc7fn+VbhZ3EiVtDywszqLf6F2gFxW
         Yrftcgl+JyM8NqqcdgmPmfwF4KPBIDeH+NjukTj10rPk41k0pUjTiiYat9xGbNqraIOy
         WsT6mJyjF/yPSFuFcCGEfpP7gzBOoVau+KGQWNsm52BAfCz9oFqPtW7Te6pNdz+30pF8
         20Kg==
X-Gm-Message-State: AAQBX9fPRL51Gf1+15niiWLqdMsh2m84nFzf5Y76WK9dwPF7uLyL7PMa
        lwwW0oIFXCduRQOLTu5fev57wByLP/E=
X-Google-Smtp-Source: AKy350a4CGttKjH82H1GT39L5QH6vMdJ13DyQS6yhURvvr3pOQ2/1rMO+0PW0lVNC+4IOkAFdlWP0g==
X-Received: by 2002:aa7:98c2:0:b0:639:9089:798e with SMTP id e2-20020aa798c2000000b006399089798emr2854426pfm.19.1681152455834;
        Mon, 10 Apr 2023 11:47:35 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:11fd:f446:f156:c8? ([2620:15c:211:201:11fd:f446:f156:c8])
        by smtp.gmail.com with ESMTPSA id h10-20020aa786ca000000b006334699ee51sm4563579pfo.47.2023.04.10.11.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 11:47:35 -0700 (PDT)
Message-ID: <8651fa1f-7f50-03c6-cd85-e61aa44d4927@acm.org>
Date:   Mon, 10 Apr 2023 11:47:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/3] blk-cgroup: some cleanup
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Chengming Zhou <zhouchengming@bytedance.com>, axboe@kernel.dk,
        tj@kernel.org
Cc:     paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20230406145050.49914-1-zhouchengming@bytedance.com>
 <cab869b1-1cba-5698-55eb-a93d0596c869@acm.org>
 <d23a6891-96f0-2ee0-70c7-869123d85362@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d23a6891-96f0-2ee0-70c7-869123d85362@huaweicloud.com>
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

On 4/9/23 18:57, Yu Kuai wrote:
> Hi, Bart
> 
> 在 2023/04/08 2:41, Bart Van Assche 写道:
>> On 4/6/23 07:50, Chengming Zhou wrote:
>>> These are some cleanup patches of blk-cgroup. Thanks for review.
>>
>> With these patches applied, my kernel test VM crashes during boot. The 
>> following crash disappears if I revert these patches:
>>
>> BUG: KASAN: null-ptr-deref in bio_associate_blkg_from_css+0x83/0x240
>> Read of size 8 at addr 0000000000000518 by task blkid/5885
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
>> 1.16.0-debian-1.16.0-5 04/01/2014
>> Call Trace:
>>   dump_stack_lvl+0x4a/0x80
>>   print_report+0x21e/0x260
>>   kasan_report+0xc2/0xf0
>>   __asan_load8+0x69/0x90
>>   bio_associate_blkg_from_css+0x83/0x240
>>   bfq_bio_bfqg+0xce/0x120 [bfq]
>>   bfq_bic_update_cgroup+0x2f/0x3c0 [bfq]
>>   bfq_init_rq+0x1e8/0xb10 [bfq]
>>   bfq_insert_request.isra.0+0xa3/0x420 [bfq]
>>   bfq_insert_requests+0xca/0xf0 [bfq]
>>   blk_mq_dispatch_rq_list+0x4c0/0xb00
> 
> I found this call trace quite weird, I can't figure out how
> bfq_insert_requests can be called from blk_mq_dispatch_rq_list,
> can you show the add2line result?

Hi Kuai,

Thanks for having taken a look. I ran my tests with this patch series on 
top of Jens' for-next branch: "[PATCH v2 00/12] Submit zoned writes in 
order" 
(https://lore.kernel.org/linux-block/20230407235822.1672286-1-bvanassche@acm.org/T/#m4c8c7ca5a5627510dc1709847b11589e8791b6b6). 
I will take a closer look and see which of these two patch series needs 
to be adjusted.

Bart.

