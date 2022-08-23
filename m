Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA8259EC41
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 21:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiHWTZp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 15:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiHWTZE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 15:25:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A872FF8F7F;
        Tue, 23 Aug 2022 11:08:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bf22so14695195pjb.4;
        Tue, 23 Aug 2022 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=jMrD17BOV98jk73P9NMr/PINIPRYYcJU7k+IUzeRBQA=;
        b=or9uvjfPOCaGwdBvw+hLIyR+yPC8qv//wqrLKeu8hWnasHqJPxFAr1OVi/nGYJLywp
         4MoXa1LsfePr3nTkMbdtLI+IIspnZMLsg8bqwRMUUEqBd2ssYPK8QnOpYFK/IpAFeTVk
         tn64l35YiVkrtVNO4kyUZD+0EXEi91pcE8wAb9ypz3/y5QOVxs3wElkyEk+38AVMafrS
         ahsKWdGxRWW+g1JQLLufAZfYq1uq8sPr3d8KbcqW3PzONzMmPwvw6LXY3OaevoGU06hM
         A6tFf73jfJRDoM2yFxjVc5Z3mUccQu0q2RfXya7Mwi/J8iGRgI6XlTWQwMPma1mNzTb9
         Ubog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=jMrD17BOV98jk73P9NMr/PINIPRYYcJU7k+IUzeRBQA=;
        b=JwF1rQGT6kZatHIyngNKPApwg4sZ/SJhjiraI0AWVMie3tDTvNABmWthhO+3OL/F9p
         EZtEreibiXdopnd7C/iJ1avO6HnWrmJKHKJFP1IWwMxgrWTJkO0bZEeOhMoUk8cDhDMm
         EJiaw4ZQEuJSsuRbE6CDZ1bWz1dH+hV2oWvF72loexO/V3g7qZYKEWqTuxe+y3EHYlU6
         N543YZV+AiGy+oOxnw/qa/KeZYutzXWdn33g5wlOzC+Prt98DCg2Vgeygsj3JycWmYaW
         j6H3+Y3T4zitStigpD6+vkxK7AnA16Bgp4qou/T96WvuskTkhm0MT2cQqUhTYwaa6aZB
         8+LQ==
X-Gm-Message-State: ACgBeo1bDHcqM6SgPf2rcPWpis2wBVEkc5fzknnNJR44E+9USf9IxlOJ
        ydma8YogjzAyGP+jvJGxS04=
X-Google-Smtp-Source: AA6agR75j2GexfOpwOkO0RFn915LlyGgM+hyKnxNrC0WHWf3OtVsk0ilgv5CUtmtUQWo7g+Wn74h2Q==
X-Received: by 2002:a17:90a:e614:b0:1fb:6b1b:66e5 with SMTP id j20-20020a17090ae61400b001fb6b1b66e5mr3121072pjy.72.1661278125040;
        Tue, 23 Aug 2022 11:08:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:90fa])
        by smtp.gmail.com with ESMTPSA id a1-20020a17090a688100b001fa9739d951sm12100003pjd.33.2022.08.23.11.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:08:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 Aug 2022 08:08:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, mkoutny@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v8 4/4] blk-throttle: fix io hung due to configuration
 updates
Message-ID: <YwUXq9XO4TstKJ66@slm.duckdns.org>
References: <20220823033130.874230-1-yukuai1@huaweicloud.com>
 <20220823033130.874230-5-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823033130.874230-5-yukuai1@huaweicloud.com>
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

On Tue, Aug 23, 2022 at 11:31:30AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> If new configuration is submitted while a bio is throttled, then new
> waiting time is recalculated regardless that the bio might already wait
> for some time:
> 
> tg_conf_updated
>  throtl_start_new_slice
>   tg_update_disptime
>   throtl_schedule_next_dispatch
> 
> Then io hung can be triggered by always submmiting new configuration
> before the throttled bio is dispatched.
> 
> Fix the problem by respecting the time that throttled bio already waited.
> In order to do that, add new fields to record how many bytes/io are
> waited, and use it to calculate wait time for throttled bio under new
> configuration.
> 
> Some simple test:
> 1)
> cd /sys/fs/cgroup/blkio/
> echo $$ > cgroup.procs
> echo "8:0 2048" > blkio.throttle.write_bps_device
> {
>         sleep 2
>         echo "8:0 1024" > blkio.throttle.write_bps_device
> } &
> dd if=/dev/zero of=/dev/sda bs=8k count=1 oflag=direct
> 
> 2)
> cd /sys/fs/cgroup/blkio/
> echo $$ > cgroup.procs
> echo "8:0 1024" > blkio.throttle.write_bps_device
> {
>         sleep 4
>         echo "8:0 2048" > blkio.throttle.write_bps_device
> } &
> dd if=/dev/zero of=/dev/sda bs=8k count=1 oflag=direct
> 
> test results: io finish time
> 	before this patch	with this patch
> 1)	10s			6s
> 2)	8s			6s
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

For 2-4,

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
