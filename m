Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76FC63E242
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 21:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiK3UmS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 15:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiK3UmR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 15:42:17 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B3E64A3C;
        Wed, 30 Nov 2022 12:42:16 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id h28so4341904pfq.9;
        Wed, 30 Nov 2022 12:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRiXbnbK/Q1F4+mT6/8iecEnTJ4rVIRUMTLO6vZSP0U=;
        b=a7uQvELPQf41UY3d1GLOaGp74BzQq3uslTfVIAR2Nz0P5TgkgJkSBC0HyZ0A5gDTLD
         tkuybQjLUVTgkCX92AibStZwbL/aoL5X5hKhcH/ABIe2b0lWsF+xTygcUMHPPEkpAZSU
         5eC7HSVOTKWKeVniYtE57w4dTbCqXah8gnylGrOi5cB0LMA8nVXQZxioQxh6YVfS9Vfe
         n/SyThpfeIeDhkq3HXqkVBAVig/27wyxaHkWjEWD5YRgXALdg4QEpKVaZy1hMnDDZ7Su
         Xjl+/slVMQ50UfzDJJAjEdjubt27rVSfNKU7Iur5CHSv42zIHMbkVckeCwlibg11BSjw
         BoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRiXbnbK/Q1F4+mT6/8iecEnTJ4rVIRUMTLO6vZSP0U=;
        b=dE3/ksscroKpfVM/bapTsaGUuaIRKIpqZSdvfO9IfwRg+Ofpydyfx8mfj9U/xyiyNb
         BwE36nmcMHQI8p7BBcI5/U1wmQ72BXtLN/HLG6t++3LtqkpgkWs6MIJEjPDHHtMqMhBP
         OSKW4NMp1gRngTxI31Ia2o2+PHnqZAf0Hbr7t5/alvHPzVrh/fHgrEDR11sE2pVw+Jo+
         xDWNbtGMnOcXyMiKrBdfh/pv73oNRo9wh69s9jO6KuawW+q01pVqZBKZKLQ6DulY4AR3
         LI6M020FRKtOW9BEih9G13dRpQD4x8EK24nYGeCLEol5PAhzOr3AwSPNggiklqr4z7fR
         Mn0A==
X-Gm-Message-State: ANoB5pmJwAC24M9iuWF1UnvR6Mi6qBdfrQC2/BNhV2wgxSGXeN8RsfA2
        L3p7Cb1ujKSHrQD/dAyLgtw=
X-Google-Smtp-Source: AA0mqf6GEdwTaIQgrXNbkCnws9ZGAVJGotCd8jpAOwnxxIqsmv9r2/4C3QscTg8Qj5AVTeQQBIq1EQ==
X-Received: by 2002:aa7:8b4d:0:b0:56c:411f:b699 with SMTP id i13-20020aa78b4d000000b0056c411fb699mr43313444pfd.48.1669840936057;
        Wed, 30 Nov 2022 12:42:16 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id na12-20020a17090b4c0c00b002192a60e900sm3538091pjb.47.2022.11.30.12.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:42:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 10:42:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Nan <linan122@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 7/9] blk-iocost: fix UAF in ioc_pd_free
Message-ID: <Y4fAJpKcVL7Q9hgY@slm.duckdns.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-8-linan122@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130132156.2836184-8-linan122@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 30, 2022 at 09:21:54PM +0800, Li Nan wrote:
> 	T1		     T2			T3
>   //delete device
>   del_gendisk
>    bdi_unregister
>     bdi_remove_from_list
>      synchronize_rcu_expedited
> 
> 		         //rmdir cgroup
> 		         blkcg_destroy_blkgs
> 		          blkg_destroy
> 		           percpu_ref_kill
> 		            blkg_release
> 		             call_rcu
>    rq_qos_exit
>     ioc_rqos_exit
>      kfree(ioc)
> 					   __blkg_release
> 					    blkg_free
> 					     blkg_free_workfn
> 					      pd_free_fn
> 					       ioc_pd_free
> 						spin_lock_irqsave
> 						 ->ioc is freed
> 
> Fix the problem by moving the operation on ioc in ioc_pd_free() to
> ioc_pd_offline(), and just free resource in ioc_pd_free() like iolatency
> and throttle.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>

I wonder what we really wanna do is pinning ioc while blkgs are still around
but I think this should work too.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
