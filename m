Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EC5433DB0
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 19:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhJSRsN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Oct 2021 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhJSRsN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Oct 2021 13:48:13 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812D9C06161C;
        Tue, 19 Oct 2021 10:46:00 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f21so14204967plb.3;
        Tue, 19 Oct 2021 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2MlySN5JbrqzxF/Em4ggjCL2GMkbXRbHLm4CFSB5M5I=;
        b=cNd6/BHJIRYcPDuXiiaGgGr4U3V9uE4qNprUYOv81pfog4kXAogbLT8Soi9Q5nMjyA
         3sEnP7x22YmWxIbl8dgVaHcT+99BrRLMrQQ/wd/FfiH9Q8WmGCHjq9q8esWhid5E7hws
         0SYmG/UVbn6H0J3YGQbXmWNCCCzOBnS0E3BN4du6DdvRVx5uW52BwLuGUW5c/Z8DDqvp
         IFrCKb/2BW9EYdF0EiiXz+xY63OC1DFoKna6vLrCaoOMO3HjUxWbh+K8DpRV235S7Bca
         tata+q2H+0kz2Lo9xTopCiziDO4CGZLfX1hzmLPCr1y/P+MTxnLcr8H0XyWp9axC7LOP
         1cNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2MlySN5JbrqzxF/Em4ggjCL2GMkbXRbHLm4CFSB5M5I=;
        b=KI/dOZAQf12/NGqloWkoYXZj6TcdPGGKPvXnm9G6C54pFPoKOMJNBGBUD2Jd5y6NdK
         28xBmoX5MsC055QkHcO44Ivm1DwAKSZk5C+mrTn1AE4I1ysEKH0zNF5kYMjUxu2AU1dt
         0V7yZs9CcslngN8UAmZ2qltZH/pGIS9SVLAIcCwWqyrQiqDhBiWOdk8EfekFjqnM6VMv
         2k6NXYd0I4+cwRV07FtpFAzG6pmfXt6olaY6tMRm6o4VhjeCSl8v7+keuM91q3y3zPsC
         dUzu302LCdtjUU6vsjHhnOafrDqkOczH7ieFDSjwFPmW9Yb6QSZyj3LOv56ExFkC7GyW
         exdg==
X-Gm-Message-State: AOAM531i5BviZUEwOn2zwfXf9eHecZcC/PHOoQ2ind7OW/8D6w+M9JGB
        9eFXqfCKKDVb5KI/SqRZAQIH40tr6Ma4DQ==
X-Google-Smtp-Source: ABdhPJz9AsSMiqpetjedULS1/fN+K0h+yk5otUwJeov984s4Rej5h0dUCETP3WbwUdEVuoNsc1oIyA==
X-Received: by 2002:a17:902:e883:b0:13f:1393:d185 with SMTP id w3-20020a170902e88300b0013f1393d185mr35147477plg.64.1634665559552;
        Tue, 19 Oct 2021 10:45:59 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id e20sm1545621pfv.59.2021.10.19.10.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 10:45:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Oct 2021 07:45:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Youfu Zhang <zhangyoufu@gmail.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [BUG] blk-throttle panic on 32bit machine after startup
Message-ID: <YW8EVVmrQpuiwyEC@slm.duckdns.org>
References: <CAEKhA2x1Qi3Ywaj9fzdsaChabqDSMe2m2441wReg_V=39_Cuhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEKhA2x1Qi3Ywaj9fzdsaChabqDSMe2m2441wReg_V=39_Cuhg@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 18, 2021 at 03:08:53PM +0800, Youfu Zhang wrote:
> Hi,
> 
> I ran into a kernel bug related to blk-throttle on CentOS 7 AltArch for i386.
> Userspace programs may panic the kernel if they hit the I/O limit
> within 5 minutes after startup.
> 
> Root cause:
> 1. jiffies was initialized to -300HZ during boot on 32bit machines
> 2. enable blkio cgroup hierarchy
>    __DEVEL__sane_behavior for cgroup v1 or default hierarchy for cgroup v2
>    EL7 kernel modified throtl_pd_init and always enable hierarchical throttling
> 3. enable & trigger blkio throttling within 5 minutes after startup
>    bio propagated from child tg to parent
> 4. enter throtl_start_new_slice_with_credit
>    if(time_after_eq(start, tg->slice_start[rw]))
>    aka. time_after_eq(0xFFFxxxxx, 0) does not hold
>    parent tg->slice_start[rw] was zero-initialized and not updated
> 5. enter throtl_trim_slice
>    BUG_ON(time_before(tg->slice_end[rw], tg->slice_start[rw]))
>    aka. time_before(0xFFFxxxxx, 0) triggers a panic

This doesn't reproduce on 5.14.

Thanks.

-- 
tejun
