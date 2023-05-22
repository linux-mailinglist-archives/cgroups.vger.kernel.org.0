Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1979D70CBD3
	for <lists+cgroups@lfdr.de>; Mon, 22 May 2023 23:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbjEVVAM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 May 2023 17:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbjEVU7t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 May 2023 16:59:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6565120;
        Mon, 22 May 2023 13:59:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d1e96c082so3535234b3a.1;
        Mon, 22 May 2023 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684789174; x=1687381174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REd5LAfz4pnrlWJeTXd7TNxPZb5If45Ls7fcUl4wW74=;
        b=lRz3eawJzzyIYWWtoGkyPPVw4Nh3+OLy6jFJMU+raeIShsezJRKl644EXFjT8VXibp
         HtJYoF9JEJBg1ClhPIoL6RiIcabDVfxMQPhGwQIHtkl7W0bHy7yjiwWYtoFH9LBHhYOU
         JEiONdLbci65yJjPkYqVHntuJUL81Tsa0epXl5zHQ1Oe8SuyaMT1EvhdvIUB2HjHhQHl
         Vs28CO3mP8kL3yjk9PfS8QV4l6+YVEYuPDyAMycXEGEcuUDzt+xC/uWjuHpt/UNCHrz/
         BYyWPHtO5gNxmtmuteRhpakBhlwavqOtp7CZh4twewBcTdi8yL/m+ozPxlptx9Fyn0o1
         tmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684789174; x=1687381174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REd5LAfz4pnrlWJeTXd7TNxPZb5If45Ls7fcUl4wW74=;
        b=aS7Si1t31RxhxwtgA+ydLkgARGOQay8G3lZB4i3Mpx37mOk5sf8YZLOONiGoAoyumA
         RliBDB5+Wuk1jocXc3Vl2UuRyzvMblR5O+XtXCUIeOjTnoCshkuTZlWlp1Im1/5IcPDG
         T9SkUEUBWVD+ExL0ix+IzsUO69hv/LFpA5WHwHTNjNHLcB2Zp8UumvhW4iWVP8vlc1Ya
         iXJqJuZ47T1NjHvu6SZPH3aawUGVLejB4IT1xXI/nXd+sDS8/TGDqTN2OfZ8AY8co+OE
         fPzpbuuEDlnkXNMk8gRwlvY+Sy8/+aFKEjOEawHnBUMlk6qyImC+rXPsKMXOLEJhoo/V
         +URA==
X-Gm-Message-State: AC+VfDyGvWZWEDsCJcAx3SU/BQg3Fx728VNVpgK2UKGEI/TZ4pZWKTXT
        ixyXFbQ85Zp3IChYiT/zcfzU8bYtT7c=
X-Google-Smtp-Source: ACHHUZ62p+fet8YNvDAvQD8XHEQO/LJcmHtalvyR/EUUpdMx3CiCSyB2OzQAqQTfXGXwV3TSV2WBRg==
X-Received: by 2002:a05:6a21:100e:b0:ec:d7cf:bcf7 with SMTP id nk14-20020a056a21100e00b000ecd7cfbcf7mr12191695pzb.17.1684789174047;
        Mon, 22 May 2023 13:59:34 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:39c])
        by smtp.gmail.com with ESMTPSA id i14-20020a63cd0e000000b005287a0560c9sm4835896pgg.1.2023.05.22.13.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:59:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 22 May 2023 10:59:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH for-6.4/block] block/rq_qos: protect rq_qos apis with a
 new lock
Message-ID: <ZGvXs8zmXcxsxL9D@slm.duckdns.org>
References: <20230414084008.2085155-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414084008.2085155-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 14, 2023 at 04:40:08PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> commit 50e34d78815e ("block: disable the elevator int del_gendisk")
> move rq_qos_exit() from disk_release() to del_gendisk(), this will
> introduce some problems:
> 
> 1) If rq_qos_add() is triggered by enabling iocost/iolatency through
>    cgroupfs, then it can concurrent with del_gendisk(), it's not safe to
>    write 'q->rq_qos' concurrently.
> 
> 2) Activate cgroup policy that is relied on rq_qos will call
>    rq_qos_add() and blkcg_activate_policy(), and if rq_qos_exit() is
>    called in the middle, null-ptr-dereference will be triggered in
>    blkcg_activate_policy().
> 
> 3) blkg_conf_open_bdev() can call blkdev_get_no_open() first to find the
>    disk, then if rq_qos_exit() from del_gendisk() is done before
>    rq_qos_add(), then memory will be leaked.
> 
> This patch add a new disk level mutex 'rq_qos_mutex':
> 
> 1) The lock will protect rq_qos_exit() directly.
> 
> 2) For wbt that doesn't relied on blk-cgroup, rq_qos_add() can only be
>    called from disk initialization for now because wbt can't be
>    destructed until rq_qos_exit(), so it's safe not to protect wbt for
>    now. Hoever, in case that rq_qos dynamically destruction is supported
>    in the furture, this patch also protect rq_qos_add() from wbt_init()
>    directly, this is enough because blk-sysfs already synchronize
>    writers with disk removal.
> 
> 3) For iocost and iolatency, in order to synchronize disk removal and
>    cgroup configuration, the lock is held after blkdev_get_no_open()
>    from blkg_conf_open_bdev(), and is released in blkg_conf_exit().
>    In order to fix the above memory leak, disk_live() is checked after
>    holding the new lock.
> 
> Fixes: 50e34d78815e ("block: disable the elevator int del_gendisk")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
