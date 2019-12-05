Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDEA91142B8
	for <lists+cgroups@lfdr.de>; Thu,  5 Dec 2019 15:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfLEObp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Dec 2019 09:31:45 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:38436 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbfLEObp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Dec 2019 09:31:45 -0500
Received: by mail-il1-f196.google.com with SMTP id u17so3172654ilq.5
        for <cgroups@vger.kernel.org>; Thu, 05 Dec 2019 06:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IgyIZsGkXhOyBGMyNdc+KtFv0dlQd6LCRsvdmK8SA0g=;
        b=svyy6NwwJUkG/aeIXKq3I1AJRSl/zcAzFj/2K4qqOekw1HPZXlVHMmxE2dKZPOpsGt
         cDTd2XPf/blqMySJiA6shLmjkgbxBjMjzbWhuybvaoFwbntoiH9TWhxO07jpHbclN24K
         0Nyra51whuUFSsSWGioTWRLyFTX5w685UgljNeyDLL+Mw1Ip3XsnhJfBiP3yae/2p2yK
         hinQfBLQPUvnLgmu636PXmuSvv3k3F/6UQZn0IWu/0YH/XI5v8Du9DOsxzgr0/3u+MoV
         54G1n2x1uTI5sTgtJwuFF6AOpqx23bWVU4innrWyRarSZQd3AohCLEXccY/F32KSK7Lw
         RA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IgyIZsGkXhOyBGMyNdc+KtFv0dlQd6LCRsvdmK8SA0g=;
        b=eEyxk2RiCtvLDSonb3NsgvR4FfwEEdX/n5rwy0CrFKmCYh+H8x9d7+fr6Cl9jN444M
         j21aDsgujOnOZZm0rRQSBvuyeDhZvpGozL+t+Ets10t6JuE5m+2p794etYiQR8hKdIQp
         oN4XUgfAsMFSDOKx/7O/C3TqM5HglFlfVGQyW0bf0K5+b127oRFu7PGiH3vp948zSlvO
         XsBL5GC0Pb6SHQoNZtf1OrH22TwAC0d84aDY2hZCAcgPHqUrt2Iw0mBNqwyEOjzlrxtL
         dS6ZNw694BH7jvN+y16AFAVVqQruHPb/cJCYbhje46wbPBEh34lwsxhele4U452rSGuq
         BMMQ==
X-Gm-Message-State: APjAAAWgJ4xuMieBLrBvnhztPtsVWcj6A8YXgl2Wp4jvAy6zXH7YlKEX
        cPTMdmB2vnVDZY3B6eQXW5X5NfcxaKFZWw==
X-Google-Smtp-Source: APXvYqxKm4XTwpnmBxasLpscBwsKRGggIS1DPAW/S2dfY1PoBHeecBwtM6YRFC4VKAlru82BkoxYYg==
X-Received: by 2002:a92:84ce:: with SMTP id y75mr8736595ilk.93.1575556304231;
        Thu, 05 Dec 2019 06:31:44 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s23sm2850121ild.48.2019.12.05.06.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 06:31:42 -0800 (PST)
Subject: Re: [PATCH] bfq-iosched: Ensure bio->bi_blkg is valid before using it
To:     Hou Tao <houtao1@huawei.com>, linux-block@vger.kernel.org,
        tj@kernel.org
Cc:     paolo.valente@linaro.org, cgroups@vger.kernel.org
References: <20191205125311.40616-1-houtao1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0f828dd3-c0d4-3a7f-8531-dc9ccfd18e32@kernel.dk>
Date:   Thu, 5 Dec 2019 07:31:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191205125311.40616-1-houtao1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/5/19 5:53 AM, Hou Tao wrote:
> bio->bi_blkg will be NULL when the issue of the request
> has bypassed the block layer as shown in the following oops:
> 
>  Internal error: Oops: 96000005 [#1] SMP
>  CPU: 17 PID: 2996 Comm: scsi_id Not tainted 5.4.0 #4
>  Call trace:
>   percpu_counter_add_batch+0x38/0x4c8
>   bfqg_stats_update_legacy_io+0x9c/0x280
>   bfq_insert_requests+0xbac/0x2190
>   blk_mq_sched_insert_request+0x288/0x670
>   blk_execute_rq_nowait+0x140/0x178
>   blk_execute_rq+0x8c/0x140
>   sg_io+0x604/0x9c0
>   scsi_cmd_ioctl+0xe38/0x10a8
>   scsi_cmd_blk_ioctl+0xac/0xe8
>   sd_ioctl+0xe4/0x238
>   blkdev_ioctl+0x590/0x20e0
>   block_ioctl+0x60/0x98
>   do_vfs_ioctl+0xe0/0x1b58
>   ksys_ioctl+0x80/0xd8
>   __arm64_sys_ioctl+0x40/0x78
>   el0_svc_handler+0xc4/0x270
> 
> so ensure its validity before using it.

Applied, thanks.

-- 
Jens Axboe

