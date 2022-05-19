Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E48052D0B6
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 12:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiESKm7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 06:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiESKm6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 06:42:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0173AEE19
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 03:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652956976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kvMeEsiv+LVL0/x98g8vYJ8UrLJ8yrZkVIlvlaQ/zNw=;
        b=M3nLtp7fz3MDK2B1lltioVWjI/5VHoTA/yBhWCmfBuCb4nbfVklxaoP6bzNAJqRNQhKXfF
        AN8793dqu7SPTXr6liNBEFdNBtZV0zWxX2w39kp5t1Q3F1hKwcZAxENiCdGzYxAeYPAVl7
        EhTvJUWrzeZ5ykPoMSKYObCKtaqf+4A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-RIA59FtANtCJd9guTTow3g-1; Thu, 19 May 2022 06:42:53 -0400
X-MC-Unique: RIA59FtANtCJd9guTTow3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66C81384F808;
        Thu, 19 May 2022 10:42:53 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 548171410DD5;
        Thu, 19 May 2022 10:42:46 +0000 (UTC)
Date:   Thu, 19 May 2022 18:42:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, geert@linux-m68k.org,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next v3 1/2] blk-throttle: fix that io throttle can only
 work for single bio
Message-ID: <YoYfIWlQ6ckWJOP0@T590>
References: <20220519085811.879097-1-yukuai3@huawei.com>
 <20220519085811.879097-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519085811.879097-2-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 19, 2022 at 04:58:10PM +0800, Yu Kuai wrote:
> commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
> introduce a new problem, for example:
> 
> [root@localhost ~]# echo "8:0 1024" > /sys/fs/cgroup/blkio/blkio.throttle.write_bps_device
> [root@localhost ~]# echo $$ > /sys/fs/cgroup/blkio/cgroup.procs
> [root@localhost ~]# dd if=/dev/zero of=/dev/sda bs=10k count=1 oflag=direct &
> [1] 620
> [root@localhost ~]# dd if=/dev/zero of=/dev/sda bs=10k count=1 oflag=direct &
> [2] 626
> [root@localhost ~]# 1+0 records in
> 1+0 records out
> 10240 bytes (10 kB, 10 KiB) copied, 10.0038 s, 1.0 kB/s1+0 records in
> 1+0 records out
> 
> 10240 bytes (10 kB, 10 KiB) copied, 9.23076 s, 1.1 kB/s
> -> the second bio is issued after 10s instead of 20s.
> 
> This is because if some bios are already queued, current bio is queued
> directly and the flag 'BIO_THROTTLED' is set. And later, when former
> bios are dispatched, this bio will be dispatched without waiting at all,
> this is due to tg_with_in_bps_limit() return 0 for this bio.
> 
> In order to fix the problem, don't skip flaged bio in
> tg_with_in_bps_limit(), and for the problem that split bio can be
> double accounted, compensate the over-accounting in __blk_throtl_bio().
> 
> Fixes: 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

