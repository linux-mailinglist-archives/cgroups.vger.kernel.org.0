Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8E163EDD9
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 11:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiLAKbs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 05:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiLAKbg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 05:31:36 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6ADA06D4;
        Thu,  1 Dec 2022 02:31:13 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 82so1335031pgc.0;
        Thu, 01 Dec 2022 02:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lC4h75dh+3IE6iSBYmQlNa7ll+YBh2sVpnAtr9WVaso=;
        b=ByAibcDVmt0W60dpTosow7EH8me0TGKi/eAI5Q9Gl9tW3HldQqJ+STDuyGLZKEHYt5
         EkpSGrBvOhXN1tpEbZOtx3srwDQqvvwAOaZ9ecOEaTYOoARoNQjZdrhH5V6WrPI0SZag
         6Y3BBsvFy7GVPIeyXZfOqAFKJa8sSbBYZRV7VfdzEVw1i0Iv02CJbW22NFsrmFt7mPUD
         Em/4mvLH+4Jdn/eoxHuhu9hncj5SQ2QLM9wmt0noqqCbyKEtDMnlM/ff3Dq2lzCplqGb
         gq/uzYiNUAEJn//sorb8I+sbppA4HfKd5LA2lb2UdttoLs0w1Kcje7BU5LYvhxPIr9Vs
         OE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lC4h75dh+3IE6iSBYmQlNa7ll+YBh2sVpnAtr9WVaso=;
        b=VzCWNh7DdSf8M9N7bRWso46XAkpZCdmRQd6qQCra2qYOASITqE+QMwxIOSw89J1McV
         P5WRFtgHpXBtPeY8M9znHRPIGVlRTonY4/gui7hV2xgGfinGgFIsBjHuf/ucdXUDpLDz
         nGS2jyOrKmM0cCLxDrc7+IzYK3tsMc2CkV3w8YqKy6wRc7dQUh5Q4ySL/zvx5uCt7L1M
         U7DXpQXTrs8VE4zO/1XZzEP3oPnlPo6PFi/EPrLoTk0HuVGBnOGNI2ctP3e9qcmAAmhe
         ED4zHUXaFM3PrRs5e71Z0G2dn+/2BRIxXvSje0HjWSAbE+wMnmoaZiYuFVRQWZ81STny
         U2ew==
X-Gm-Message-State: ANoB5pmYLC1gvof9J48+v6oG1BPemmpeWYYKcRudqhh0t+c8n7mKNpHd
        rrckTbdlRkqbxdYA0eOo+5U=
X-Google-Smtp-Source: AA0mqf68leKiPAJyvCCFaB+9KbGEykpF/Fd7aASl3jgDQ9lo+HfhKCMXFbJ7H827s0G71AafpwvxSw==
X-Received: by 2002:a63:1915:0:b0:477:3803:674f with SMTP id z21-20020a631915000000b004773803674fmr39052188pgl.469.1669890672382;
        Thu, 01 Dec 2022 02:31:12 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z186-20020a6265c3000000b0056bc5ad4862sm2908916pfb.28.2022.12.01.02.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:31:12 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 1 Dec 2022 00:31:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Nan <linan122@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next v2 8/9] block: fix null-pointer dereference in
 ioc_pd_init
Message-ID: <Y4iCbuALBBGLODWI@slm.duckdns.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-9-linan122@huawei.com>
 <Y4fCE7XxcpDfWyDJ@slm.duckdns.org>
 <9ca2b7ab-7fd3-a9a3-12a6-021a78886b54@huaweicloud.com>
 <Y4h94m8QMPtS4xJV@slm.duckdns.org>
 <431dcb3f-4572-7fd0-9e5d-90b6c34d577c@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <431dcb3f-4572-7fd0-9e5d-90b6c34d577c@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 01, 2022 at 06:23:16PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2022/12/01 18:11, Tejun Heo 写道:
> > On Thu, Dec 01, 2022 at 10:12:13AM +0800, Yu Kuai wrote:
> > > 1) By mentioning that "del_gendisk() is quiescing the queue", do you
> > > suggest to add rcu_read_lock()? This seems wrong because blk_iocost_init
> > > requires memory allocation.
> > 
> > Quiescing uses SRCU so that should be fine but I'm not sure whether this is
> > the right one to piggyback on. Jens should have a better idea.
> > 
> > Thanks.
> > 
> 
> Currently SRCU is used if BLK_MQ_F_BLOCKING set, otherwise RCU is used.
> 
> dispatch:
> #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) \
> do {                                                            \
>         if ((q)->tag_set->flags & BLK_MQ_F_BLOCKING) {          \
>                 int srcu_idx;                                   \
>                                                                 \
>                 might_sleep_if(check_sleep);                    \
>                 srcu_idx = srcu_read_lock((q)->tag_set->srcu);  \
>                 (dispatch_ops);                                 \
>                 srcu_read_unlock((q)->tag_set->srcu, srcu_idx); \
>         } else {                                                \
>                 rcu_read_lock();                                \
>                 (dispatch_ops);                                 \
>                 rcu_read_unlock();                              \
>         }                                                       \
> } while (0)
> 
> quiesce:
> void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set)
> {
>         if (set->flags & BLK_MQ_F_BLOCKING)
>                 synchronize_srcu(set->srcu);
>         else
>                 synchronize_rcu();
> }

Oh I see. Unfortunately, I don't know what to do off the top of my head.

Thanks.

-- 
tejun
