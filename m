Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EE2673E5B
	for <lists+cgroups@lfdr.de>; Thu, 19 Jan 2023 17:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjASQQA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Jan 2023 11:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjASQP7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Jan 2023 11:15:59 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62EC8A63;
        Thu, 19 Jan 2023 08:15:58 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id z13so2749404plg.6;
        Thu, 19 Jan 2023 08:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ae6CLA/wyp/IvxNOrUUr/ZjdhSOngZFFYXXmGXpC8Eo=;
        b=IHB4k/BCpN5sgx7Si8MmzTbFCivgZU+rJneogVjYsDfEIK9Z03JTHrf+NRUAAjBV6j
         le9FgFaerU+8HdJ8/cF3P4PUTaJ7NduhYrsyULClMw+M38tARHzdUegH3US59Ru9HpRi
         M3mmkyFOa+I6j6zZ+drM9VxU0fmrxERrcei5iEBQUkPAwEW0Ah8alPIVjPblmz9jY74S
         gnT22G4f13X5F0ExocvzTFlib3QcpSXseTC3YwSJMlXTJnEWM+boHGUkV4HgSkXCDi7y
         DcDyLOQfSr42qNBkzng4sdtwAhXb2o/2M8effxXUzeBEtd2sAdPgswgOSgEpFGPOsxaZ
         f1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ae6CLA/wyp/IvxNOrUUr/ZjdhSOngZFFYXXmGXpC8Eo=;
        b=0dZ5dKiXTvlloMF7eDmE9v8IBr+6fPn7SaejlNPRu0fuozlliQAf4SD/jjlifDex1f
         drgf1OBr3LMYYdIPhX1shxZyk0dAk52lRygh+gn1Ab2q1ir5dThoQsfGzfN1JxC/ZqvS
         qp4BGX0tfYosH5uu/6ZREdddlAlqpTQ+PI6lzzNUSeEW8mP3Tn3IJ0WAt0cUbmazW84s
         0o3wiwTOlECpGFUH3XHrYfzgrpb5+1s/W3P+/xZ03uJWNK7sNNGo/uuVdLKj2zUMgGTl
         B+88xArj8pfktB7nbbb3k7T4L/d3Fe9AL0Jo1Zw02vtzwoPbdf629vdUnA6WidW87hpV
         HR2w==
X-Gm-Message-State: AFqh2kou3/JoB75SXZ7odhA/9Q2AKXseurWKuevscgnjwNd74r2F/cnR
        SYh2lqFMVJJnE+flDR7LqP0=
X-Google-Smtp-Source: AMrXdXspFzzS2HXhwJrLcJG5i/Aallzz9+C7ZBwTLaOY7D1XGy5hDDKJwlvUa55ER8X7YauF7UHgxg==
X-Received: by 2002:a05:6a20:2a9a:b0:a5:6e3d:107b with SMTP id v26-20020a056a202a9a00b000a56e3d107bmr16265430pzh.0.1674144957813;
        Thu, 19 Jan 2023 08:15:57 -0800 (PST)
Received: from localhost ([2600:380:4a69:c93e:fcd6:9a91:e25c:65a6])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b00186e34524e3sm25324085ple.136.2023.01.19.08.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 08:15:57 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 19 Jan 2023 06:15:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v3 3/3] blk-cgroup: synchronize pd_free_fn() from
 blkg_free_workfn() and blkcg_deactivate_policy()
Message-ID: <Y8lsuwtrCYE9jiHb@slm.duckdns.org>
References: <20230119110350.2287325-1-yukuai1@huaweicloud.com>
 <20230119110350.2287325-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119110350.2287325-4-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 19, 2023 at 07:03:50PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently parent pd can be freed before child pd:
> 
> t1: remove cgroup C1
> blkcg_destroy_blkgs
>  blkg_destroy
>   list_del_init(&blkg->q_node)
>   // remove blkg from queue list
>   percpu_ref_kill(&blkg->refcnt)
>    blkg_release
>     call_rcu
> 
> t2: from t1
> __blkg_release
>  blkg_free
>   schedule_work
> 			t4: deactivate policy
> 			blkcg_deactivate_policy
> 			 pd_free_fn
> 			 // parent of C1 is freed first
> t3: from t2
>  blkg_free_workfn
>   pd_free_fn
> 
> If policy(for example, ioc_timer_fn() from iocost) access parent pd from
> child pd after pd_offline_fn(), then UAF can be triggered.
> 
> Fix the problem by delaying 'list_del_init(&blkg->q_node)' from
> blkg_destroy() to blkg_free_workfn(), and using a new disk level mutex to
> synchronize blkg_free_workfn() and blkcg_deactivate_policy().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
