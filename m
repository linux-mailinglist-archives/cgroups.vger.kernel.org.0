Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FE16724AF
	for <lists+cgroups@lfdr.de>; Wed, 18 Jan 2023 18:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjARRS4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Jan 2023 12:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjARRSe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Jan 2023 12:18:34 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6027C5866E;
        Wed, 18 Jan 2023 09:18:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k18so13520167pll.5;
        Wed, 18 Jan 2023 09:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jlTZEN1utYn3NK0RDj87Oh5/DtKY5pKiAHoIwQXuHc=;
        b=nyNGxdNG/Zdzr9E1yPijuDXODjLQQP6MdAGR3XhLofQhx+8VjEZOWff7AFSFOdqB0t
         bSi1cCaNAEo4ddCyQc3RjvRDMlgVrDbpNUWDlPQq6bqKzi8O7feqKReVTbWWkXFxRbC2
         2RXYw3mjH01Cg2RVqfJ5wPB/aib/zg0Ejq2WJkvHyETy/nczZnHWL1WJ8khb1yyba6eH
         J9IUn8KI/mx+yTnU8zvDkfXdey6dujH9rpmkeljkfhQSXnYT3N999Nn96+B0+GxHHfwb
         bZ/fRxJTUXLnvmdOagmBRJwdNedvLCXNhwSTJXIDLV7tLm510U9mQrjWipTL8PnIe7eW
         t16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jlTZEN1utYn3NK0RDj87Oh5/DtKY5pKiAHoIwQXuHc=;
        b=ZWIAdWQGm2LJqhpMQp8mNcYGUR3gECHko0nRVef7E2SPbXiHroaBDP0nS+mJUiX1OL
         Zi6jTN+G17+mYMjpTkOZZj2qYuyyqNViqlFhDG9dsH1y1ASyicofefxj3WgZjwTOh+VX
         iqeLdbSIAzgTo8hWqL1UVVfkjQ7rdpXr633ieSCHJ4ymCuv1SAoP+ESBFR3jgGwtsn6M
         vxxFCoGLpkgCQUIU/mDQdEQSewGeGZHbNAZ09bnfikj9g9CcJ2dR3DNZrWMFTPdPAs/0
         uaE6JaPPHdMuCJa1cZOCmgCDSfmaKF5rC1LufBure8F2tIv5yyT8CEC2kHUsxQLgk8bq
         SrZg==
X-Gm-Message-State: AFqh2koaQvEhsD+0dDPzlwRLOhG/SoCJzgkmScCcOp5DH7M/av3e7iPS
        C6eJYcvRHy5t/rRdQigM0lI=
X-Google-Smtp-Source: AMrXdXtk5+xT2JpBMcaiPR9gEitjqMsVakvU8GdIIpcVvpJkia+JffwlkRrdOd6YMMpwJOBtCh6y2A==
X-Received: by 2002:a05:6a20:d2c6:b0:af:7b32:4deb with SMTP id ir6-20020a056a20d2c600b000af7b324debmr7647788pzb.4.1674062310983;
        Wed, 18 Jan 2023 09:18:30 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q11-20020a65494b000000b0047850cecbdesm19214707pgs.69.2023.01.18.09.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:18:30 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 18 Jan 2023 07:18:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 4/5] blk-iocost: fix divide by 0 error in calc_lcoefs()
Message-ID: <Y8gp5ZeHbs/U1Qfe@slm.duckdns.org>
References: <20230117070806.3857142-1-yukuai1@huaweicloud.com>
 <20230117070806.3857142-5-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117070806.3857142-5-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 17, 2023 at 03:08:05PM +0800, Yu Kuai wrote:
> From: Li Nan <linan122@huawei.com>
> 
> echo max of u64 to cost.model can cause divide by 0 error.
> 
>   # echo 8:0 rbps=18446744073709551615 > /sys/fs/cgroup/io.cost.model
> 
>   divide error: 0000 [#1] PREEMPT SMP
>   RIP: 0010:calc_lcoefs+0x4c/0xc0
>   Call Trace:
>    <TASK>
>    ioc_refresh_params+0x2b3/0x4f0
>    ioc_cost_model_write+0x3cb/0x4c0
>    ? _copy_from_iter+0x6d/0x6c0
>    ? kernfs_fop_write_iter+0xfc/0x270
>    cgroup_file_write+0xa0/0x200
>    kernfs_fop_write_iter+0x17d/0x270
>    vfs_write+0x414/0x620
>    ksys_write+0x73/0x160
>    __x64_sys_write+0x1e/0x30
>    do_syscall_64+0x35/0x80
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> calc_lcoefs() uses the input value of cost.model in DIV_ROUND_UP_ULL,
> overflow would happen if bps plus IOC_PAGE_SIZE is greater than
> ULLONG_MAX, it can cause divide by 0 error.
> 
> Fix the problem by setting basecost
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
