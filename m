Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1526DB45C
	for <lists+cgroups@lfdr.de>; Fri,  7 Apr 2023 21:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjDGTpx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Apr 2023 15:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDGTpw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Apr 2023 15:45:52 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875079028;
        Fri,  7 Apr 2023 12:45:50 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1a51d304648so498825ad.3;
        Fri, 07 Apr 2023 12:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680896750; x=1683488750;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWghzBfKuQahtLumYRFLf1CL+ff9yd1SjNGPejMxZk8=;
        b=rkYhPdfx26R6YooQeIUmRf+PnwngkGGje8A2PlgFRnFYtlT8QHJ9SW0bgiaj1wcsCw
         fRCxCkKkJ1WbmfyibzsUX4DpcrWHwT4SIUlkEfVtOZYTCRbtG9RmIkelN2C+rCHSG5zd
         qMUhjClmIWzSAslaS8qBR3k8mEw8/m2uX4i6+kLX0z2nWQ7VH3v3l2YEhh5YOJNtY5Cy
         mUasTz1GLrOvLl83lUpIEZQG7jfuW0KNvKK/i8zDBWqSY9q3J9OlgFaI87tR+7Tc3D4W
         C0rA/kGZWxEv/pJCZEIvO+hkjQsPGwJqUMV1LkBtS4bpBNmClIfrT6M16N75hv5wvIJM
         vpOA==
X-Gm-Message-State: AAQBX9eD9B6IBKsv/sws+/VM2+xsgtO8hUiLAqwiHNyHVcDhgGrVi41+
        7rPGx3mAZvo1KDFaDKglSL0YjOEvXoQ=
X-Google-Smtp-Source: AKy350Zvf+ZYs9X20b1qMpn53sbWEJeeG8LMZ6lU+gEvqgWHqGO3zOmD3Xp5o3DiTs1Lha5jhvsRAg==
X-Received: by 2002:aa7:8bd1:0:b0:62a:9d6f:98dc with SMTP id s17-20020aa78bd1000000b0062a9d6f98dcmr3444446pfd.11.1680896749761;
        Fri, 07 Apr 2023 12:45:49 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:f2c:4ac2:6000:5900? ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id f27-20020a631f1b000000b0051322ab5ccdsm3001289pgf.28.2023.04.07.12.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 12:45:49 -0700 (PDT)
Message-ID: <63cf4e4f-764b-8634-b29f-30d45bed1ca5@acm.org>
Date:   Fri, 7 Apr 2023 12:45:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 0/3] blk-cgroup: some cleanup
To:     Jens Axboe <axboe@kernel.dk>,
        Chengming Zhou <zhouchengming@bytedance.com>, tj@kernel.org
Cc:     paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230406145050.49914-1-zhouchengming@bytedance.com>
 <cab869b1-1cba-5698-55eb-a93d0596c869@acm.org>
 <1416b648-188f-873a-08b3-c8e8494ab1a7@kernel.dk>
Content-Language: en-US
In-Reply-To: <1416b648-188f-873a-08b3-c8e8494ab1a7@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/7/23 11:44, Jens Axboe wrote:
> On 4/7/23 12:41 PM, Bart Van Assche wrote:
>> On 4/6/23 07:50, Chengming Zhou wrote:
>>> These are some cleanup patches of blk-cgroup. Thanks for review.
>>
>> With these patches applied, my kernel test VM crashes during boot. The following crash disappears if I revert these patches:
>>
>> BUG: KASAN: null-ptr-deref in bio_associate_blkg_from_css+0x83/0x240
> 
> Would be useful in the report to know where that is, as it doesn't include
> the code output.

Hi Jens,

This is what gdb tells me about the crash address:

$ gdb vmlinux
(gdb) list *(bio_associate_blkg_from_css+0x83)
0xffffffff81856923 is in bio_associate_blkg_from_css (./include/linux/blkdev.h:865).
860     int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
861                             unsigned int flags);
862
863     static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
864     {
865             return bdev->bd_queue;  /* this is never NULL */
866     }
867
868     /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
869     const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);

Thanks,

Bart.
