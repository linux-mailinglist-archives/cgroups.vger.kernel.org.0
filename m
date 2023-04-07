Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697316DB2F3
	for <lists+cgroups@lfdr.de>; Fri,  7 Apr 2023 20:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjDGSlp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Apr 2023 14:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDGSlo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Apr 2023 14:41:44 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04E0A27B;
        Fri,  7 Apr 2023 11:41:43 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id q2so4553093pll.7;
        Fri, 07 Apr 2023 11:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680892903; x=1683484903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oRwt6N4ADa78EEH+o6Pc1K4R7YlHGK3pUj1aovOcq4=;
        b=BYlLjGct7FTDQdPy7SYv8wL32dfvMWGrWukpge0DOHBK7o4Es5RbFKEUTTHWK1uIxw
         0ZBDghJA97ZyCiTgoXmG302oyuR87ALdt2KW2rCUB5xle/Ijfjn7bb2WFExyWH8WOiL6
         kUJGDlhb5MAMJ9luI9EN5BssivioSwzFkc5w4OpJGeP5GIniPaYlMfMYceA+KvlhtW1S
         sN5vsQdrnh8yBBPRXryL68wfa8IHLg4SKi89MF4dfZ60cko8Mvwwq1onn6CEsYwH0WuI
         W6CWR9ibxbeKqwRbpPdYYKW45dYg44/IFYkp/jBRGeGTVV5KMMbwT1L29CyDcEsgTHM1
         cPzw==
X-Gm-Message-State: AAQBX9djcmeYiU/57zv5SZOYddRVEzfbnDf3tXuFPwXIJmzPYNndE5JG
        UWfa7aeZHRR1+s90GOAh2kI=
X-Google-Smtp-Source: AKy350avvsGl4zVwBPa4ui2T1sZ4b1Ps6ohOFXIaaoS82O6uuIVf9A7ZONzjgA2v9hGpemFWz7IBig==
X-Received: by 2002:a05:6a20:4f27:b0:dd:ee39:5e90 with SMTP id gi39-20020a056a204f2700b000ddee395e90mr2655675pzb.23.1680892903272;
        Fri, 07 Apr 2023 11:41:43 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:f2c:4ac2:6000:5900? ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id u16-20020aa78490000000b00628e9871c24sm3342377pfn.183.2023.04.07.11.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 11:41:42 -0700 (PDT)
Message-ID: <cab869b1-1cba-5698-55eb-a93d0596c869@acm.org>
Date:   Fri, 7 Apr 2023 11:41:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/3] blk-cgroup: some cleanup
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, axboe@kernel.dk,
        tj@kernel.org
Cc:     paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230406145050.49914-1-zhouchengming@bytedance.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230406145050.49914-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/6/23 07:50, Chengming Zhou wrote:
> These are some cleanup patches of blk-cgroup. Thanks for review.

With these patches applied, my kernel test VM crashes during boot. The 
following crash disappears if I revert these patches:

BUG: KASAN: null-ptr-deref in bio_associate_blkg_from_css+0x83/0x240
Read of size 8 at addr 0000000000000518 by task blkid/5885
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
  dump_stack_lvl+0x4a/0x80
  print_report+0x21e/0x260
  kasan_report+0xc2/0xf0
  __asan_load8+0x69/0x90
  bio_associate_blkg_from_css+0x83/0x240
  bfq_bio_bfqg+0xce/0x120 [bfq]
  bfq_bic_update_cgroup+0x2f/0x3c0 [bfq]
  bfq_init_rq+0x1e8/0xb10 [bfq]
  bfq_insert_request.isra.0+0xa3/0x420 [bfq]
  bfq_insert_requests+0xca/0xf0 [bfq]
  blk_mq_dispatch_rq_list+0x4c0/0xb00
  __blk_mq_sched_dispatch_requests+0x15e/0x200
  blk_mq_sched_dispatch_requests+0x8b/0xc0
  __blk_mq_run_hw_queue+0x3ff/0x500
  __blk_mq_delay_run_hw_queue+0x23a/0x300
  blk_mq_run_hw_queue+0x14e/0x350
  blk_mq_sched_insert_request+0x181/0x1f0
  blk_execute_rq+0xf4/0x300
  scsi_execute_cmd+0x23e/0x350
  sr_do_ioctl+0x173/0x3d0 [sr_mod]
  sr_packet+0x60/0x90 [sr_mod]
  cdrom_get_track_info.constprop.0+0x125/0x170 [cdrom]
  cdrom_get_last_written+0x1d4/0x2d0 [cdrom]
  mmc_ioctl_cdrom_last_written+0x85/0x120 [cdrom]
  mmc_ioctl+0x10b/0x1d0 [cdrom]
  cdrom_ioctl+0xa66/0x1270 [cdrom]
  sr_block_ioctl+0xee/0x130 [sr_mod]
  blkdev_ioctl+0x1bb/0x3f0
  __x64_sys_ioctl+0xc7/0xe0
  do_syscall_64+0x34/0x80
  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Bart.
