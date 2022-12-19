Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707F865147B
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 21:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiLSU4M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Dec 2022 15:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiLSU4B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Dec 2022 15:56:01 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C286561;
        Mon, 19 Dec 2022 12:56:01 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 82so7054084pgc.0;
        Mon, 19 Dec 2022 12:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NakfROSMki8cV2nnpMoQ1MJIRum6ZgALihcXreebAZQ=;
        b=P9vTDBW4Z9V3T+vz64KijYP0mRwH/VSJa3JCdcPiIQ8AckWvIFsGQVP9FZKvi0ENkr
         1iFYZCLDOJljki+cWdV2+/aQdMYLTHmsVq0uLQ8/VGQcQORfO1eTRB4xyZi/viWROc1H
         Zpm2AvuHS8iRTJngk6WIbwIDOjlMe7N9wHr2/MPlcTPD8bUALFqvER4S0Cq4/zhB5RNG
         2nRPGHMhjgP99prOQ3hUchptv3SsOS/A+CYtVYvc5w55arPw+hxIrkBXcdSVD5wwonlD
         8LkK2tpGZVXLH58UsGQ1HdFqMn1ZcCj7+IJPojJSk3Qr5+CxgUnLSfzAUwBMBQwnPE8e
         IFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NakfROSMki8cV2nnpMoQ1MJIRum6ZgALihcXreebAZQ=;
        b=L1OOTNg3zItYfP9o0jlVZw8sPoLq4J6w7K0ehDc3/enMyGgxvafBHYdwntqILF2vOC
         0kyOGfPU4DmQcBO+3yFFLvIZErrxShnVtCXn6cOU/vTQdx9NZnP2g9Wx2oKdqC7bFOBi
         Emx/DQh2RHtb1mJ/Q2VuB34DQNlUjMle/VNSNfhj6VegDR/uMeszLW1z1paEDvuP9OTA
         DmMVZMW0KKpgzGNOr/+7UIKtZfAwPsZw1BcA31+jzAYQPMPXU44M5da34twmXaTp+9Bn
         p/wmS+QcFLG9z37pfzRhbt9WZ2JVbD0V3CIw/s2lAUdDGn774UrtOB0EL2GEA5tE188t
         2vpA==
X-Gm-Message-State: ANoB5pn55Z3ZL7CpYSruOmEcMCauwGPmi8DKop/hpVRr5j19emU46iNL
        ganhtikSijtmD5JWyJfyRTs=
X-Google-Smtp-Source: AA0mqf6x/yM7OIbELNQSHNQnxTbVe+Z7POs+RPh7fYMKmdoryFQiV4RgP8MP0Dewq1H0xH/Wqnjvlw==
X-Received: by 2002:aa7:8e4c:0:b0:56b:7b9f:5cb6 with SMTP id d12-20020aa78e4c000000b0056b7b9f5cb6mr45396562pfr.19.1671483360467;
        Mon, 19 Dec 2022 12:56:00 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 127-20020a621785000000b0056da073b2b7sm7047390pfx.210.2022.12.19.12.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:56:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 19 Dec 2022 10:55:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 0/4] blk-cgroup: synchronize del_gendisk() with
 configuring cgroup policy
Message-ID: <Y6DP3aOSad8+D1yY@slm.duckdns.org>
References: <20221217030908.1261787-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217030908.1261787-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Sat, Dec 17, 2022 at 11:09:04AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> iocost is initialized when it's configured the first time, and iocost
> initializing can race with del_gendisk(), which will cause null pointer
> dereference:
> 
> t1				t2
> ioc_qos_write
>  blk_iocost_init
>   rq_qos_add
>   				del_gendisk
>   				 rq_qos_exit
>   				 //iocost is removed from q->roqs
>   blkcg_activate_policy
>    pd_init_fn
>     ioc_pd_init
>      ioc = q_to_ioc(blkg->q)
>      //can't find iocost and return null
> 
> And iolatency is about to switch to the same lazy initialization.
> 
> This patchset fix this problem by synchronize rq_qos_add() and
> blkcg_activate_policy() with rq_qos_exit().

So, the patchset seems a bit overly complicated to me. What do you think
about the following?

* These init/exit paths are super cold path, just protecting them with a
  global mutex is probably enough. If we encounter a scalability problem,
  it's easy to fix down the line.

* If we're synchronizing this with a mutex anyway, no need to grab the
  queue_lock, right? rq_qos_add/del/exit() can all just hold the mutex.

* And we can keep the state tracking within rq_qos. When rq_qos_exit() is
  called, mark it so that future adds will fail - be that a special ->next
  value a queue flag or whatever.

Thanks.

-- 
tejun
