Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46BB3BDC8F
	for <lists+cgroups@lfdr.de>; Tue,  6 Jul 2021 19:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhGFR7N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Jul 2021 13:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhGFR7N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Jul 2021 13:59:13 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC1C061574;
        Tue,  6 Jul 2021 10:56:33 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id u14so22110408pga.11;
        Tue, 06 Jul 2021 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XG//MamfUR6shTS4467vh766S9Op+itGfSMIx5as4Hs=;
        b=Ls3/wMIo360OeFOWB9ZaFy0FI3Zy4NCEqHG750gNi1+cgEu6ATJuCAO0N3O4PC592I
         fjFOsLmWhQboZoCSSq37rZrmmuU2LmYz9T2k7z++Th5GFxufHJoC3QFQpU6EKvpuU/Pv
         dL9NLTMEyU/vaz3QWeFesiy1nhn+9Vb9YjODUTLWRHvqPhlfCuV/uhej9/Po6RdjvVR0
         ozTF3hL1a7ZGy6nqzdTvHsCf0mJ+PbSlFzP4Rp9CVuG5LMO65lfrm+heU6qVeRDHqp8u
         iWv9VHZSYdUL/IMUmIQIttykWLZ6Xwq4G/J74aOCILk2XbidF1Gj+g+wS31pQFHo7ewI
         /LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XG//MamfUR6shTS4467vh766S9Op+itGfSMIx5as4Hs=;
        b=MBSaX8/XCWFKnAFJ7kZjJ2xcTxPK2E7aKhAOd1XzEoWqmW5Hr9N0MIyzabtalMoVQf
         G0wkBUw/DcQAZatrNZwWwtouTSeV+QDJnk1XHRNfyz3w1zC+JsdLHEF6mYEf9hZJo/pN
         8gW0V2FxO6SFtu+mkmPSBRoEchXoUBWiwYfPbOlzebsZH/L6CyanSZ8f1pTl1O7rtge9
         dw2ggqGHwVste+mUfKolZ4BpdmwJQBw4vpTSb4HU3wUzBA5OFF4zJQqs8Z/lbdUFk9C6
         xC4anSL7GyYYj8AAnOei2NGH9yu9kx0iURz6IVcFgrXksF39x/VzlJq92ixPyTWIRlO8
         bDyQ==
X-Gm-Message-State: AOAM531bMXqNxSoP3mgEFRaMZeD8rMxO+/uTiv9EgluSjsVqKRgzQk7t
        F0kS2XpNTF1b+kmJqwf4sUE=
X-Google-Smtp-Source: ABdhPJxfBI8lm3/w07zov/YIiaZdMBCj03oDNcnEPzBk4DIw5PVoT95c/eo3lzE5j9CzeB2/H2CJLQ==
X-Received: by 2002:a05:6a00:1305:b029:315:7312:2b0b with SMTP id j5-20020a056a001305b029031573122b0bmr21636417pfu.15.1625594193040;
        Tue, 06 Jul 2021 10:56:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:2d7f])
        by smtp.gmail.com with ESMTPSA id x19sm12986018pfp.115.2021.07.06.10.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:56:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Jul 2021 07:56:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] blk-cgroup: prevent rcu_sched detected stalls warnings
 while iterating blkgs
Message-ID: <YOSZTpTtKz2wyFO3@mtj.duckdns.org>
References: <20210702040444.1917834-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702040444.1917834-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Yu.

On Fri, Jul 02, 2021 at 12:04:44PM +0800, Yu Kuai wrote:
> blkcg_activate_policy() and blkcg_deactivate_policy() might have the
> same problem, fix them the same way.

Given that these are basically only called from module init/exit paths,
let's leave them alone for now.

> +#define BLKG_BATCH_OP_NUM 64

Can we do BLKG_DESTRY_BATCH_SIZE instead?

>  static void blkg_destroy_all(struct request_queue *q)
>  {
>  	struct blkcg_gq *blkg, *n;
> +	int count = BLKG_BATCH_OP_NUM;
>  
> +restart:
>  	spin_lock_irq(&q->queue_lock);
>  	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
>  		struct blkcg *blkcg = blkg->blkcg;
> @@ -430,6 +434,17 @@ static void blkg_destroy_all(struct request_queue *q)
>  		spin_lock(&blkcg->lock);
>  		blkg_destroy(blkg);
>  		spin_unlock(&blkcg->lock);
> +
> +		/*
> +		 * in order to avoid holding the spin lock for too long, release
> +		 * it when a batch of blkgs are destroyed.
> +		 */
> +		if (!(--count)) {
> +			count = BLKG_BATCH_OP_NUM;
> +			spin_unlock_irq(&q->queue_lock);
> +			cond_resched();
> +			goto restart;
> +		}
>  	}

This part looks good otherwise.

Thanks.

-- 
tejun
