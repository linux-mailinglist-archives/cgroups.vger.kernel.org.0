Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D43409B36
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 19:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbhIMRv5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 13:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbhIMRvv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 13:51:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377D3C061574;
        Mon, 13 Sep 2021 10:50:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so32184pjw.2;
        Mon, 13 Sep 2021 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GXuhVb2mAgwRJ4d5JAgKMNDM1IDwp61QdPvAadqK8Do=;
        b=YxPJcxJPOqB7IuMrPYi3hee6d8psUNevLnc8b5zSKyMPh/QH6j6uM1pwEEHFl2bH0c
         4Nt+YQwlZBISDoy0cC8Qaa8FgTFtqbs1ajc9BgSCwutdtly6qzs4NuYa6VufizF78Jx+
         J7cBmNXde423BBLs6dYRM9oA6vtq8eWLkfj7AiFjxZuQYjU2eDEG5YEm2RlmSUdu1edt
         o+NzGdJcVK28vrqlyvtQtFVrTYD8c9XaNK9UZj59Ky+ms6qH9J3taiiJUBXhtGVn5lh6
         qeSszGBEFIqWgxJah0ZN2BrQ9bNwSnWCgwLq4Dk/eup0bNu8nTAGHPS8QPLtIA28LkA8
         1OIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GXuhVb2mAgwRJ4d5JAgKMNDM1IDwp61QdPvAadqK8Do=;
        b=5eWlnj0AJ8i9ia/fOKAPgf7grg1ANwrXs7v13o4aH28TGGQWb1aAL1AeRpEnTnZSQo
         3zDoWWUDPMCvcPTw4nm91WOB0VXdx+P72WONGCAlYe/h/9ONIs3n9p+EaXkEibjjEmLy
         fRYTrCMP/LuSlaqqMCUIolMkiPhmJuV3BlVcwVfdzVh6oUVgvrSmpJ5M6GKazEBSLHMy
         a5SdEa9aNqEahlR43JjT3KbknOh8xqT4cHi7/hS4oEgwuC7U25sTKQL2o6hFctLx1snj
         0UXI8LduSlyF7LTKjdMxAI7sbu69X2/WeXpgOxrfEl4ffakp4oh3RGmTj3Bm6c7F4Ix1
         cJEw==
X-Gm-Message-State: AOAM533RBKMsVDpFlE2alRfzIpqN7APhWIKgzmxJRprIL+TGpMWKt/HE
        Svpz68cK4hEO1O5++IXbIbw=
X-Google-Smtp-Source: ABdhPJxDaLvyFuEV0RRw9hCw8Y9Gd90fUgrgsbS3tY2e6TLX6/LRlFgi910RMbQO5E1jaC5MbrLr6g==
X-Received: by 2002:a17:903:1207:b0:138:e2f9:6c98 with SMTP id l7-20020a170903120700b00138e2f96c98mr11782268plh.11.1631555434543;
        Mon, 13 Sep 2021 10:50:34 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id e11sm1772938pfv.201.2021.09.13.10.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 10:50:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 07:50:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Jinlin <lijinlin3@huawei.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, louhongxiang@huawei.com
Subject: Re: [PATCH v2] block, bfq: fix UAF in bfq_io_set_weight_legacy()
Message-ID: <YT+PaFSxfcJAgTs7@slm.duckdns.org>
References: <20210910034642.2838054-1-lijinlin3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910034642.2838054-1-lijinlin3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Sep 10, 2021 at 11:46:42AM +0800, Li Jinlin wrote:
> Freeing bfqg is protected by queue lock in blkcg_deactivate_policy(), 
> but getting/using bfqg is protected by blkcg lock in
> bfq_io_set_weight_legacy(). If bfq_io_set_weight_legacy() get bfqg
> before freeing bfqg and use bfqg in the after, the use-after-free
> will occur.
> 
> CPU0                             CPU1
> blkcg_deactivate_policy
>   spin_lock_irq(&q->queue_lock)
>                                  bfq_io_set_weight_legacy  
>                                    spin_lock_irq(&blkcg->lock)
>                                    blkg_to_bfqg(blkg)
>                                      pd_to_bfqg(blkg->pd[pol->plid])
>                                      ^^^^^^blkg->pd[pol->plid] != NULL
>                                            bfqg != NULL
>   pol->pd_free_fn(blkg->pd[pol->plid])
>     pd_to_bfqg(blkg->pd[pol->plid])
>     bfqg_put(bfqg)
>       kfree(bfqg)
>   blkg->pd[pol->plid] = NULL
>   spin_unlock_irq(q->queue_lock);
>                                    bfq_group_set_weight(bfqg, val, 0)
>                                      bfqg->entity.new_weight
>                                      ^^^^^^trigger uaf here 
>                                    spin_unlock_irq(&blkcg->lock);
> 
> To fix this use-after-free, instead of holding blkcg->lock while
> walking ->blkg_list and getting/using bfqg, RCU walk ->blkg_list and
> hold the blkg's queue lock while getting/using bfqg.

I think this is a bug in blkcg_deactivate_policy() than the other way
around. blkgs are protected by both q and blkcg locks and holding either
should stabilize them. The blkcg lock nests inside q lock, so I think
blkcg_deactivate_policy() just needs to grab the matching blkcg lock before
trying to destroy blkgs.

Thanks.

-- 
tejun
