Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D313B855B
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 16:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhF3Owd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 10:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbhF3Owc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 10:52:32 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2055CC061756;
        Wed, 30 Jun 2021 07:50:03 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id p7so1218037qvn.5;
        Wed, 30 Jun 2021 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7non7Ht3wU/Vgs0c/H0HW+wlwkdFp/0NZ1g7sAhRaEc=;
        b=gGD9BAtpYOeepZdTbE3KHgAiQMcPPfpnG9JJlnbUMfEhlC8BfSFmt8miSEvOuIEZiB
         3rzRcjaUvadqxpFG1/UCWQxX3S4rZ592U9H9rz8afxfdqc1r2Rde8c8BEn9i7xgMhNDv
         JPyYE28nZZUx9+NLzRiuD3VmblJGAy13TwSeiDfi41Y1wHRqNK+gLcQjTZxfG2M1YsUZ
         0c2kCQtqWyTPbUPzKbLyuJMbmCzox2eNsaFegX5bjW/wN/jIK4/VDB9Z58im/s+xDGmz
         cCYbg8XIqnEdiJwNjEYwVOBbY9TWqJad9qQ5AqQ/TxIfy00Mt1Ykar5zkLmd3VYYunt6
         2M3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7non7Ht3wU/Vgs0c/H0HW+wlwkdFp/0NZ1g7sAhRaEc=;
        b=PDPMaTjq1k6GTeER9af4SASAxCKlnBWzj4eWr85gENLUVdWfEPb/76p1xLSBpApgxi
         hwnwadc+2ybQbM+RQzxyTvO8WQZyMOdEauz3cOoxH5ZejXmq2Ny4ev7oqCOLV7OXhGig
         cc4Qq4L+QlpoJ7EWHSMtrtvP4fmKVNir/IhAcqRKdN4TNDl77jM0SEIy1Z4u3ZsqW5E9
         ueU2sn7+XFPtW0YImxYzusV6rOZijeJ0iE1vA+Peao7tvRyYWyVtSz02jmP3XjgVKbDa
         cLtFp1nSIF+1NjYWCfn1sWz1pez1r8RfxSqlzJqgdBjvx+5N9+CkrimHGwwUdCBSU2vW
         F/Dg==
X-Gm-Message-State: AOAM532pvOHYbQWWMx5EqsDRJs0NrCkb2xGUs2VPNSxWhhmkGXF65/M1
        4VWHC2j7tVN9P+2dLJD1Nc0=
X-Google-Smtp-Source: ABdhPJzThHMaJANHAXxziTuH+SOn3cwvDIkQnU3dUtRtaQNsiFdcVi7NPiUTXYnhp8pT1LY+NU4BrQ==
X-Received: by 2002:a05:6214:21ab:: with SMTP id t11mr21581134qvc.26.1625064602268;
        Wed, 30 Jun 2021 07:50:02 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN ([2620:10d:c091:480::1:1008])
        by smtp.gmail.com with ESMTPSA id g4sm5047069qtb.50.2021.06.30.07.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 07:50:01 -0700 (PDT)
Date:   Wed, 30 Jun 2021 10:49:58 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] loop: Charge i/o to mem and blk cg
Message-ID: <YNyEltLABd17spxy@dschatzberg-fedora-PC0Y6AEN>
References: <20210610173944.1203706-1-schatzberg.dan@gmail.com>
 <20210610173944.1203706-4-schatzberg.dan@gmail.com>
 <YNXvr81YFzbaTxCb@blackbook>
 <YNnZ7hIRIk9dJDry@dschatzberg-fedora-PC0Y6AEN>
 <YNr1TYfBwR/tEpEJ@blackbook>
 <YNsoNeQNMmdplmtp@dschatzberg-fedora-PC0Y6AEN>
 <YNw8kRpT6R2emuhI@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNw8kRpT6R2emuhI@blackbook>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> This is how I understand it:
> 
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -996,6 +996,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
>         rb_insert_color(&worker->rb_node, &lo->worker_tree);
>  queue_work:
>         if (worker) {
> +               WARN_ON_ONCE(worker->blkcg_css != cmd->blkcg_css);

Yes, this is correct. Though the check here seems a bit obvious to me
- it must be correct because we assign worker above:

if (cur_worker->blkcg_css == cmd->blkcg_css) {
        worker = cur_worker;
        break;

or when we construct the worker:

worker->blkcg_css = cmd->blkcg_css;

I think this WARN_ON_ONCE check might be more interesting in
loop_process_work which invokes loop_handle_cmd and actually uses
cmd->blkcg_css. In any event, your understanding is correct here.

>                 /*
>                  * We need to remove from the idle list here while
>                  * holding the lock so that the idle timer doesn't
> @@ -2106,6 +2107,8 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>         cmd->memcg_css = NULL;
>  #ifdef CONFIG_BLK_CGROUP
>         if (rq->bio && rq->bio->bi_blkg) {
> +               /* reference to blkcg_css will be held by loop_worker (outlives
> +                * cmd) or it is the eternal root css */

Yes, this is correct. Feel free to add my Acked-by to such a patch
