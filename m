Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EEA63E24F
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 21:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiK3Uuc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 15:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiK3Uub (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 15:50:31 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1207E431;
        Wed, 30 Nov 2022 12:50:29 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o12so8937770pjo.4;
        Wed, 30 Nov 2022 12:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HY7HR+jxU6TKM04v8zsj6/Dqk0zLgSsOGTMBo35NxdY=;
        b=BP6ht7VEuPlqXkYDyD/Uy4Vfo9GZIQRn2NXCSz31myYLsS/qsm4c23xVx7FpBTlxCA
         Mr6yS7bSbO79UEnQYaajN846XpciQ/Dx3c82KEzkU1+FF7b9JAKqjn3U+iRH6ocXglja
         6qxlpvDHVlMAiqeX6pn57vP31gsUzuBJgcZ27+YDDI56REblo/n8ZFXvq5jG9F17zWFx
         9pSC5Kvn1zOUkaSY3dCXlpy2c2odJBfBI5PxT7DGYQX6IiasEmjB5wxXIgbn9HKndMFe
         TvQaedBj+0RUPVdLc/2trbZiy3bTD6Q4ZVfd+Uic6WfxL86VANrSHyVXe2CkucO3OcHa
         OCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY7HR+jxU6TKM04v8zsj6/Dqk0zLgSsOGTMBo35NxdY=;
        b=lGKng8RaNHh4lTE7qgir/y4BNCCsscdfItYrCo+4MjY9JrRc+iYM3b/3jCR+NqqEQc
         f/zVCra2HF1tJ3Wzv2uCBp05Uoqwtds00aOk0WFZLKDKx3U0lMOqZz6GaBlDm4Ii+LzQ
         ralJbZLdqIGT+P/1GzhbINNrhWf5jbx2d4x0wJ0prdNHkxOG4vD9RRZerm4xzbXQwfdO
         fK5GJcMfQJ2itJr4ehBSmtgt/17L9nvtC7MCNiY8qGaIJSqdO5v7EfSZc74cGQ02yQZ2
         4TSr2gKKjs8Wa+NotM5OI5hDKU6mfax4ndZVRezmpBh6os6r1GxvYq79GyP5hPu276Y1
         JrHg==
X-Gm-Message-State: ANoB5pmRRwwvoscGs1D7j8VRkn5eZbuv4W48REiBGmNi3qbxXWIP27cr
        P7IR9z43hDtOrbxRmeLLGdM=
X-Google-Smtp-Source: AA0mqf4kQbVJGQ+mtfgB9XlMLOfJIYT6+xkzZGNGUROWUtVztwRb3YTHLfunSpX4m0hgMa/EeIOV5Q==
X-Received: by 2002:a17:902:8e81:b0:188:4f86:e4d5 with SMTP id bg1-20020a1709028e8100b001884f86e4d5mr46097595plb.16.1669841429022;
        Wed, 30 Nov 2022 12:50:29 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id i20-20020a170902e49400b00168dadc7354sm1921642ple.78.2022.11.30.12.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:50:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 10:50:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Nan <linan122@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 8/9] block: fix null-pointer dereference in
 ioc_pd_init
Message-ID: <Y4fCE7XxcpDfWyDJ@slm.duckdns.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-9-linan122@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130132156.2836184-9-linan122@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 30, 2022 at 09:21:55PM +0800, Li Nan wrote:
> Remove block device when iocost is initializing may cause
> null-pointer dereference:
> 
> 	CPU1				   CPU2
>   ioc_qos_write
>    blkcg_conf_open_bdev
>     blkdev_get_no_open
>      kobject_get_unless_zero
>     blk_iocost_init
>      rq_qos_add
>   					del_gendisk
>   					 rq_qos_exit
>   					  q->rq_qos = rqos->next
>   					   //iocost is removed from q->roqs
>       blkcg_activate_policy
>        pd_init_fn
>         ioc_pd_init
>   	 ioc = q_to_ioc(blkg->q)
>  	  //cant find iocost and return null
> 
> Fix problem by moving rq_qos_exit() to disk_release(). ioc_qos_write() get
> bd_device.kobj in blkcg_conf_open_bdev(), so disk_release will not be
> actived until iocost initialization is complited.

I think it'd be better to make del_gendisk wait for these in-flight
operations because this might fix the above particular issue but now all the
policies are exposed to request_queue in a state it never expected before.

del_gendisk() is quiescing the queue around rq_qos_exit(), so maybe we can
piggyback on that and update blkcg_conf_open_bdev() to provide such
exclusion?

Thanks.

-- 
tejun
