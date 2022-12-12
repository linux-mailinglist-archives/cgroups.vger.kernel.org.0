Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BE864AB36
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 00:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiLLXKv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 18:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbiLLXKp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 18:10:45 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F363615A08;
        Mon, 12 Dec 2022 15:10:28 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so209474pjb.0;
        Mon, 12 Dec 2022 15:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZDS6utjeiGgDa4ROrpBjFTGSUb0kKrpSXUgc52VtJQ=;
        b=UHxmfk1YIHXsZ85vl3BmRcLrv+A1Wp3ORhoNKMvbeYIUXxQ4ia3UjLJZKbeNpzf3ft
         PQrFrZEd5zgvcWqD2VNQxlOCIQtzLLs6fHCfeKAon4O6OKOA23xekPOnaoNTHHZ1wupA
         AOZ+YkdKvIoKQ5xbffbb4q6KJfp1BQT3cGhb5ywjnEgH+9PXk/AVhBOs0XATIRRLwkt3
         Wi/8WSCzOjyBTAOfyjs2giiLdVrQRhsv8mNdsWVl1WXZqe2BQr5U31iu1I5VPO/PsfIn
         L7QQipFlfPjM4sXnc/uLQCbhOnwaf8oZunAZU2sD4G8JV88hECgQVfv3v2adMDXzqJkH
         X6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZDS6utjeiGgDa4ROrpBjFTGSUb0kKrpSXUgc52VtJQ=;
        b=q56PFwAJFpn67fiIJwsk2nkXMhUM+XvUDmMrRJ5ktiAdVJ21HcMTEGEqxxprFALrbi
         f1Oz1KuaovBi19JFBYzoH819zxM0uG25MowOQcshVWdCtDJaZvfTtQ6avQGbLZjEq6UR
         MSyEg0zplnc9AvXuZrQJmFOoDBm+H/tCW2Hc0ZNNzDDK1x74KDh1jmoPVeMLCOfgPcvl
         7EXZp+olfIxtJ+P+reQ3Hfy3qR67gM6xiFK2YODe4GyhGTe86zspHptLQ5xdLR8IWsYm
         KHO+eUbkSDSpbSqy3ObqwuKElSGm/q2tYvPgT2Azt3WEU0XjGuGJ22KDhdGcrKj2KGZj
         IbfQ==
X-Gm-Message-State: ANoB5plfTQXaN7QlhogR29M2TkzFKjo8rRb5hB+iquy5/nEktpskpHa1
        fjjm5fg0H1jEEewi08bnubg=
X-Google-Smtp-Source: AA0mqf4dX47XWg36tSlsw3uOrSOdDmX4a8d2eb2XWQOYvVEOWQndD62o05X2yFvK3vHbJiCU2LFhsA==
X-Received: by 2002:a17:902:e743:b0:187:34f6:3323 with SMTP id p3-20020a170902e74300b0018734f63323mr27073672plf.59.1670886628320;
        Mon, 12 Dec 2022 15:10:28 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b00189caf296e6sm6881132plb.279.2022.12.12.15.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 15:10:27 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 13:10:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Li Nan <linan122@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next v2 8/9] block: fix null-pointer dereference in
 ioc_pd_init
Message-ID: <Y5e04oKUEEBXqaar@slm.duckdns.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-9-linan122@huawei.com>
 <Y4fCE7XxcpDfWyDJ@slm.duckdns.org>
 <9ca2b7ab-7fd3-a9a3-12a6-021a78886b54@huaweicloud.com>
 <Y4h94m8QMPtS4xJV@slm.duckdns.org>
 <431dcb3f-4572-7fd0-9e5d-90b6c34d577c@huaweicloud.com>
 <Y4iCbuALBBGLODWI@slm.duckdns.org>
 <96487803-12cc-a694-0099-784106596fd1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96487803-12cc-a694-0099-784106596fd1@huaweicloud.com>
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

On Mon, Dec 05, 2022 at 05:32:17PM +0800, Yu Kuai wrote:
> 1) queue_lock is held to protect rq_qos_add() and rq_qos_del(), whlie
> it's not held to protect rq_qos_exit(), which is absolutely not safe
> because they can be called concurrently by configuring iocost and
> removing device.
> I'm thinking about holding the lock to fetch the list and reset
> q->rq_qos first:
> 
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index 88f0fe7dcf54..271ad65eebd9 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -288,9 +288,15 @@ void rq_qos_wait(struct rq_wait *rqw, void
> *private_data,
> 
>  void rq_qos_exit(struct request_queue *q)
>  {
> -       while (q->rq_qos) {
> -               struct rq_qos *rqos = q->rq_qos;
> -               q->rq_qos = rqos->next;
> +       struct rq_qos *rqos;
> +
> +       spin_lock_irq(&q->queue_lock);
> +       rqos = q->rq_qos;
> +       q->rq_qos = NULL;
> +       spin_unlock_irq(&q->queue_lock);
> +
> +       while (rqos) {
>                 rqos->ops->exit(rqos);
> +               rqos = rqos->next;
>         }
>  }
> 
> 2) rq_qos_add() can still succeed after rq_qos_exit() is done, which
> will cause memory leak. Hence a checking is required beforing adding
> to q->rq_qos. I'm thinking about flag QUEUE_FLAG_DYING first, but the
> flag will not set if disk state is not marked GD_OWNS_QUEUE. Since
> blk_unregister_queue() is called before rq_qos_exit(), use the queue
> flag QUEUE_FLAG_REGISTERED should be OK.
> 
> For the current problem that device can be removed while initializing
> , I'm thinking about some possible solutions:
> 
> Since bfq is initialized in elevator initialization, and others are
> in queue initialization, such problem is only possible in iocost, hence
> it make sense to fix it in iocost:

So, iolatency is likely to switch to similar lazy init scheme, so we better
fix it in the rq_qos / core block layer.

...
> 3) Or is it better to fix it in the higher level? For example:
> add a new restriction that blkcg_deactivate_policy() should be called
> with blkcg_activate_policy() in pairs, and blkcg_deactivate_policy()
> will wait for blkcg_activate_policy() to finish. Something like:
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index ef4fef1af909..6266f702157f 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1410,7 +1410,7 @@ int blkcg_activate_policy(struct request_queue *q,
>         struct blkcg_gq *blkg, *pinned_blkg = NULL;
>         int ret;
> 
> -       if (blkcg_policy_enabled(q, pol))
> +       if (WARN_ON_ONCE(blkcg_policy_enabled(q, pol)))
>                 return 0;
> 
>         if (queue_is_mq(q))
> @@ -1477,6 +1477,8 @@ int blkcg_activate_policy(struct request_queue *q,
>                 blkg_put(pinned_blkg);
>         if (pd_prealloc)
>                 pol->pd_free_fn(pd_prealloc);
> +       if (!ret)
> +               wake_up(q->policy_waitq);
>         return ret;
> 
>  enomem:
> @@ -1512,7 +1514,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
>         struct blkcg_gq *blkg;
> 
>         if (!blkcg_policy_enabled(q, pol))
> -               return;
> +               wait_event(q->policy_waitq, blkcg_policy_enabled(q, pol));
>    wait_event(q->xxx, blkcg_policy_enabled(q, pol));

Yeah, along this line but hopefully something simpler like a mutex.

Thanks.

-- 
tejun
