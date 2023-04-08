Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779886DB89C
	for <lists+cgroups@lfdr.de>; Sat,  8 Apr 2023 05:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjDHDhe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Apr 2023 23:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDHDhd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Apr 2023 23:37:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE0CBBBE
        for <cgroups@vger.kernel.org>; Fri,  7 Apr 2023 20:37:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bp17-20020a17090b0c1100b0023f187954acso254252pjb.2
        for <cgroups@vger.kernel.org>; Fri, 07 Apr 2023 20:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680925027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUr3g5RxycMk/Z/8YgiC7z+3mZOPJTD8hF1viU2CvKI=;
        b=KO8Wo1RKtPs8FCd9uOQ3HSdEJLz0AeQpyuNJxk84XNXR4ysAn/Bs9fJdt4MrRZhglH
         xjYswepMFWJpcmsHzhYT7bjyF+/uEeRQucCHnXpxjyBr6Y498Z1EAasLmsU0pk24vg4B
         fUL0gfqQ7uwj0YzmkdgGFEu/FsQxlIl0ofKAIS0OqC8ksAtLQaBc3EP1li/iZKYX1zew
         VSOMZPf39/iQErDAMEAkDkoZkQ+jBRC0PEIRb3LDNSUjZ9GtJsfFhGCYodFBf2zBHq2F
         bJ3HlyoXaSunpaD1VhRQ6YdOS541gmDTNPjm14KqtWwEoBupNgtzpUhcVWd0lO6xTYsU
         w3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680925027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUr3g5RxycMk/Z/8YgiC7z+3mZOPJTD8hF1viU2CvKI=;
        b=aJhC9yCZB/Ub8gKdslLk58kRKy3rWt0eC67hz+pa/bNdZzIRHm2nCFYuNz7fbdPlSN
         krga+bwR5nDHNLDZqSBL17vAj8iUdOMTjN5h0TUq3RepjcdZtxW9xNrQLYxvERM5EdyF
         g/JWpFf3NipF7QgqJWjXtQ2BW1SV7b0oHI0DvlZiZi2zr+Q6l4FnAzbEoBw+hCovhgZU
         vgKOtPzI+7jzx+F85WS22sEp6MQglsr/IEeqC6AcdhfS0ZXyoCUrm6ENEdMMMnGvi5sM
         e8zGQ6oUb6mekt/oGGZvE5fUqMIUkF5EO5c8yQHgeY7EGKFrDy5Z6MjpTubVgQE4DDW7
         ta+Q==
X-Gm-Message-State: AAQBX9d8BIUdBz5H4NjAsf4cy+Bo3pNHz2WlPrEtJ1LUAgXJwuSU9ySY
        Rpt4mpwsSxBJtp3Rr03CRiKdXA==
X-Google-Smtp-Source: AKy350bSPo5n2xg9Si8L2oY2DOc4s1aEPsRBL5HoP0vlxwjKQCnthKr7tydpTL3bOEWzpUeS8k2eMw==
X-Received: by 2002:a17:90a:ba8c:b0:233:d12f:f43a with SMTP id t12-20020a17090aba8c00b00233d12ff43amr5104759pjr.1.1680925026743;
        Fri, 07 Apr 2023 20:37:06 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e6a:3a30:91c6:a74e:1ca9:6039? ([2409:8a28:e6a:3a30:91c6:a74e:1ca9:6039])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090a1fcd00b00240d4521958sm3441636pjz.18.2023.04.07.20.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 20:37:06 -0700 (PDT)
Message-ID: <1a64eaea-50ea-f273-b0a1-a6eb8483beac@bytedance.com>
Date:   Sat, 8 Apr 2023 11:37:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [External] Re: [PATCH v2 0/3] blk-cgroup: some cleanup
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, tj@kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230406145050.49914-1-zhouchengming@bytedance.com>
 <cab869b1-1cba-5698-55eb-a93d0596c869@acm.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <cab869b1-1cba-5698-55eb-a93d0596c869@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/4/8 02:41, Bart Van Assche wrote:
> On 4/6/23 07:50, Chengming Zhou wrote:
>> These are some cleanup patches of blk-cgroup. Thanks for review.
> 
> With these patches applied, my kernel test VM crashes during boot. The following crash disappears if I revert these patches:

Thanks for the report.
I will try to reproduce it first and look into this today.

> 
> BUG: KASAN: null-ptr-deref in bio_associate_blkg_from_css+0x83/0x240
> Read of size 8 at addr 0000000000000518 by task blkid/5885
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> Call Trace:
>  dump_stack_lvl+0x4a/0x80
>  print_report+0x21e/0x260
>  kasan_report+0xc2/0xf0
>  __asan_load8+0x69/0x90
>  bio_associate_blkg_from_css+0x83/0x240
>  bfq_bio_bfqg+0xce/0x120 [bfq]
>  bfq_bic_update_cgroup+0x2f/0x3c0 [bfq]
>  bfq_init_rq+0x1e8/0xb10 [bfq]
>  bfq_insert_request.isra.0+0xa3/0x420 [bfq]
>  bfq_insert_requests+0xca/0xf0 [bfq]
>  blk_mq_dispatch_rq_list+0x4c0/0xb00
>  __blk_mq_sched_dispatch_requests+0x15e/0x200
>  blk_mq_sched_dispatch_requests+0x8b/0xc0
>  __blk_mq_run_hw_queue+0x3ff/0x500
>  __blk_mq_delay_run_hw_queue+0x23a/0x300
>  blk_mq_run_hw_queue+0x14e/0x350
>  blk_mq_sched_insert_request+0x181/0x1f0
>  blk_execute_rq+0xf4/0x300
>  scsi_execute_cmd+0x23e/0x350
>  sr_do_ioctl+0x173/0x3d0 [sr_mod]
>  sr_packet+0x60/0x90 [sr_mod]
>  cdrom_get_track_info.constprop.0+0x125/0x170 [cdrom]
>  cdrom_get_last_written+0x1d4/0x2d0 [cdrom]
>  mmc_ioctl_cdrom_last_written+0x85/0x120 [cdrom]
>  mmc_ioctl+0x10b/0x1d0 [cdrom]
>  cdrom_ioctl+0xa66/0x1270 [cdrom]
>  sr_block_ioctl+0xee/0x130 [sr_mod]
>  blkdev_ioctl+0x1bb/0x3f0
>  __x64_sys_ioctl+0xc7/0xe0
>  do_syscall_64+0x34/0x80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Bart.
