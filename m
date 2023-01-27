Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE3567F257
	for <lists+cgroups@lfdr.de>; Sat, 28 Jan 2023 00:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjA0XkP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 18:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjA0XkL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 18:40:11 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC268715D;
        Fri, 27 Jan 2023 15:40:03 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 144so4307187pfv.11;
        Fri, 27 Jan 2023 15:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHHdtG+qXLcunlXNSfmfexDXB5Ie4ZWaLHsKQA0ypsg=;
        b=kWP7axAIAtVonz+dlVJ3RVeoMAQb5wNQDtnG8ZL+p+cDNkrcqxHDH+2wR9e2YdY7Y5
         VuXfcsYd3QMZJ9br4KDhGElnbKo4U4ew3/2by/ku8JmUV906waHSDKvCz6gGVyMRwn5B
         pnlf+idt8VvHUr/bGyz/Y2YKZDmrYEIXUFmJQbJLIpJlBDDPIxfQlqTdCatge49SgsQx
         BpcOUGflTFSTupzdJcmuIAYjZjdcl3yemUwlXQ1rm1RdviEX80BAbNnFi+v+mLabqzVJ
         zOur3OntiXiWboeV6v2XdDQ+fe/MHZL+AK2hsJTxXY/sEhduIApf5gmE/oiNi/uZKRMw
         YC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHHdtG+qXLcunlXNSfmfexDXB5Ie4ZWaLHsKQA0ypsg=;
        b=DytM/khs/NnWXsvf0Qh9hbUGDkUkNYxnmvNo5yvSpnOng1+IXyeJFYBmb3TkX5kx6p
         hJB6g3ZpUrCHeuJzK876EnuLcB1uaqgoESzgmunN7/NjKNocY9GceQhg99mckUNwXFb5
         8EC8Tct3MouIqzIeOP1mlQ6n/LBthHL1Zorl3BM+ZSP1h/hXU0MyvoWjGlCDCZDceYZJ
         Hf5gX/s1uaTpS/gzsu8PQzcyctzLMK/ljHqvhiFSQGnxJddpva4/bjeLIF7L40EvX810
         rhDZdYhNiOvBRFzMp2nd0hDybXSCjgi/qZdjihx3rXLadqgxlETtfi4oNhvuKoLyHRpf
         MtKA==
X-Gm-Message-State: AO0yUKXX2tC762LUYh4RamLw1tFTktKC8I1S5jnAt22+xgSlSqsooNPL
        M36bl6+PRMrzu8EqxlZEGeY=
X-Google-Smtp-Source: AK7set8qQJFmTKkPtU6UYKh0jVCdPX/nc0PR8EzOvrCbShEy1W5LsgEx3oNiUKcF0XR5V1+wPA0tfA==
X-Received: by 2002:a62:1d55:0:b0:592:4d85:ecb1 with SMTP id d82-20020a621d55000000b005924d85ecb1mr6004251pfd.33.1674862802731;
        Fri, 27 Jan 2023 15:40:02 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q6-20020aa79826000000b00592543d7363sm2650724pfl.1.2023.01.27.15.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 15:40:02 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 27 Jan 2023 13:40:00 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 05/15] blk-cgroup: store a gendisk to throttle in struct
 task_struct
Message-ID: <Y9Rg0GuNAmJPlDri@slm.duckdns.org>
References: <20230124065716.152286-1-hch@lst.de>
 <20230124065716.152286-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124065716.152286-6-hch@lst.de>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 24, 2023 at 07:57:05AM +0100, Christoph Hellwig wrote:
>  void blkcg_maybe_throttle_current(void)
>  {
> -	struct request_queue *q = current->throttle_queue;
> +	struct gendisk *disk = current->throttle_disk;
>  	struct blkcg *blkcg;
>  	struct blkcg_gq *blkg;
>  	bool use_memdelay = current->use_memdelay;
>  
> -	if (!q)
> +	if (!disk)
>  		return;
>  
> -	current->throttle_queue = NULL;
> +	current->throttle_disk = NULL;
>  	current->use_memdelay = false;
>  
> +	if (test_bit(GD_DEAD, &disk->state))
> +		goto out_put_disk;
...
> @@ -1835,18 +1839,15 @@ void blkcg_maybe_throttle_current(void)
>   */
>  void blkcg_schedule_throttle(struct gendisk *disk, bool use_memdelay)
>  {
> -	struct request_queue *q = disk->queue;
> -
>  	if (unlikely(current->flags & PF_KTHREAD))
>  		return;
>  
> -	if (current->throttle_queue != q) {
> -		if (!blk_get_queue(q))
> -			return;
> +	if (current->throttle_disk != disk) {
> +		get_device(disk_to_dev(disk));

So, we're shifting the dead test from schedule to the actual throttle path,
which makes sense but I think this should at least be mentioned in the
description if not put in its own patch.

Thanks.

-- 
tejun
