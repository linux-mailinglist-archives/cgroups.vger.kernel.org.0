Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F4966064E
	for <lists+cgroups@lfdr.de>; Fri,  6 Jan 2023 19:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbjAFSXb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Jan 2023 13:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbjAFSXa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Jan 2023 13:23:30 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100382AC0;
        Fri,  6 Jan 2023 10:23:30 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p24so2450545plw.11;
        Fri, 06 Jan 2023 10:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FviiSBK5p0B4z+PC3fKC8+sEAADVb45SBnYPZfnLnEY=;
        b=OV2BDC9JXxEtkmQOPrOeD3bwcQtCLLjCUmlAiID2R9QRkow5CEhZf+zKDwvAPy4lhL
         0+S5/f5rhE0cHTLytLdC04LYcWbZG0JtV3cI3T+M6D/kdT1dvI3xqyjSsEl+8dC09BIs
         8f130BruK0EHVNtD/HofxHMcznp3LwowZq3HTaHLnsO5X1jeSY8zf8iO4k5BfGp9Kk3U
         Rehva+a0ZqY6Zy6AZyFt+k1wVqGs8PMKeQ9p/qz/WyLSRSbIGfIU7VjRXxDZBb+T5Nvm
         9JjJT8oCy8Icc4vEUsFLn0e4W/JQAL8ztmFh20lB+H8rqDJP9nhXkfcFCFpHk/4tpK/o
         C/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FviiSBK5p0B4z+PC3fKC8+sEAADVb45SBnYPZfnLnEY=;
        b=Z989Ji7pzg98NUuObYovXUm/O6QsTURfgw0kMiur/bKewNUBlcIX59KYutOa+Q1R4U
         DhO5rF/1PUDGxbJoYOiIjFLEEjaYCZiao1EOShE/hBsrZTCuIpIjKvF/y231rF/vnJwQ
         p5a4pdkcM8wis/lLKaUJGKP0yj0/2TiYfBj6ArmMCyr2Vy9WUtaefxNf/ZxrldUwTYhQ
         ZVbslXo5q5fcvusKyknBy1i2WbjEfZ0MYdFCQDNP0de15XSbdGGxGTH3WCDHDLmPP7sT
         ZvT++e5SXf5oVCJUZjK46/CKKwLy4Mkz7ElN6rWKhBoBEVwkLmGgdiY8Tch0JF3Isk+w
         1k3w==
X-Gm-Message-State: AFqh2ko/e8Aip2ktoQMcAGINqPaxuz5cq7hBkALHMEH1Ebky/o/GerHa
        aB09k5+r7WBRw+wr1yr4fdA=
X-Google-Smtp-Source: AMrXdXvEBsfFy7YH3z9vS77Ex8Ne7t0OVp5HgCYNgtSpehvmaN+Zds4rjTyykj1B0ehpiZQ1E84Zng==
X-Received: by 2002:a05:6a20:3d1a:b0:a4:b2e4:c561 with SMTP id y26-20020a056a203d1a00b000a4b2e4c561mr83779504pzi.51.1673029409205;
        Fri, 06 Jan 2023 10:23:29 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7972d000000b00561d79f1064sm1422424pfg.57.2023.01.06.10.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 10:23:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 6 Jan 2023 08:23:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next 3/4] block/rq_qos: use a global mutex to protect
 rq_qos apis
Message-ID: <Y7hnH9GT6D469Vuu@slm.duckdns.org>
References: <20230104085354.2343590-1-yukuai1@huaweicloud.com>
 <20230104085354.2343590-4-yukuai1@huaweicloud.com>
 <Y7XyIzGptuqO8EAt@slm.duckdns.org>
 <Y7YZnM/nqb0gxOei@slm.duckdns.org>
 <df2f7a60-467f-08ce-2a3e-1dc7853424aa@huaweicloud.com>
 <Y7cYKdOwSlfHtj7t@slm.duckdns.org>
 <ef55a0f1-d3c2-3979-963e-2fa10ba3c2ff@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef55a0f1-d3c2-3979-963e-2fa10ba3c2ff@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Jan 06, 2023 at 09:33:26AM +0800, Yu Kuai wrote:
> > wbt's lazy init is tied to one of the block device sysfs files, right? So,
> > it *should* already be protected against device removal.
> 
> That seems not true, I don't think q->sysfs_lock can protect that,
> consider that queue_wb_lat_store() doesn't check if del_gendisk() is
> called or not:
> 
> t1: wbt lazy init		t2: remove device
> queue_attr_store
> 				del_gendisk
> 				blk_unregister_queue
> 				 mutex_lock(&q->sysfs_lock)
> 			         ...
> 				 mutex_unlock(&q->sysfs_lock);
> 				rq_qos_exit
>  mutex_lock(&q->sysfs_lock);
>   queue_wb_lat_store
>   wbt_init
>    rq_qos_add
>  mutex_unlock(&q->sysfs_lock);

So, it's not sysfs_lock but sysfs file deletion. When a kernfs, which backs
sysfs, file is removed, it disables future operations and drains all
inflight ones before returning, so you remove the interface files before
cleaning up the object that it interacts with, you don't have to worry about
racing against file operations as none can be in flight at that point.

> I tried to comfirm that by adding following delay:
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 93d9e9c9a6ea..101c33cb0a2b 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -11,6 +11,7 @@
>  #include <linux/blktrace_api.h>
>  #include <linux/blk-mq.h>
>  #include <linux/debugfs.h>
> +#include <linux/delay.h>
> 
>  #include "blk.h"
>  #include "blk-mq.h"
> @@ -734,6 +735,8 @@ queue_attr_store(struct kobject *kobj, struct attribute
> *attr,
>         if (!entry->store)
>                 return -EIO;
> 
> +       msleep(10000);
> +
>         mutex_lock(&q->sysfs_lock);
>         res = entry->store(q, page, length);
>         mutex_unlock(&q->sysfs_lock);
> 
> And then do the following test:
> 
> 1) echo 10000 > /sys/block/sdb/queue/wbt_lat_usec &
> 2) echo 1 > /sys/block/sda/device/delete
> 
> Then, following bug is triggered:
> 
> [   51.923642] BUG: unable to handle page fault for address:
> ffffffffffffffed
> [   51.924294] #PF: supervisor read access in kernel mode
> [   51.924773] #PF: error_code(0x0000) - not-present page
> [   51.925252] PGD 1820b067 P4D 1820b067 PUD 1820d067 PMD 0
> [   51.925754] Oops: 0000 [#1] PREEMPT SMP
> [   51.926123] CPU: 1 PID: 539 Comm: bash Tainted: G        W
> 6.2.0-rc1-next-202212267
> [   51.927124] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> ?-20190727_073836-b4
> [   51.928334] RIP: 0010:__rq_qos_issue+0x30/0x60

This indicates that we aren't getting the destruction order right. It could
be that there are other reasons why the ordering is like this and we might
have to synchronize separately.

Sorry that I've been asking you to go round and round but block device
add/remove paths have always been really tricky and we wanna avoid adding
more complications if at all possible. Can you see why the device is being
destroyed before the queue attr is removed?

Thanks.

-- 
tejun
