Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF2C2C403F
	for <lists+cgroups@lfdr.de>; Wed, 25 Nov 2020 13:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgKYMdU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Nov 2020 07:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKYMdT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Nov 2020 07:33:19 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD2AC0613D4;
        Wed, 25 Nov 2020 04:33:12 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so1404627qtb.10;
        Wed, 25 Nov 2020 04:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H3aqrBY6oYhCd62SVodU601+HB4mzl3pG4lUcfT04Cg=;
        b=m8eiXGIffxTQcl9qWmpoUZgBsSzJBJL+g8a+25Jt5FKxrq5reTIQJIvOqHam06ytUT
         +AVBi6gElJoegN0PJweNe4OCeUoDzFODyFHPyIln49wZ5mShP7YmWW3JcvzSHisvU3RY
         HvY920z0TDVKvZHVGUl0hW04u6KPVUTYgkRsiSfEQ5wXOQlIapC1e1DPv6ahx8onYMVI
         RK3uA/nnhPE9+aELC01Cnp4okGEgdmF1asc72P2GBtujVywjnmfE22z+BSjYMM6mL8Q6
         c9LsElOYkPJODDqa7BlptGqmUGWMtnSAY3T7eNQCvLF8h3PLrE397W3APYrR+NuKSx2g
         3d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=H3aqrBY6oYhCd62SVodU601+HB4mzl3pG4lUcfT04Cg=;
        b=BI6cbfed42i6bo1We2KRaaxHDJcLlfR+Kq+bl+Zi/Cv78i/NipGuewMcSUpFM/LQNL
         VDd2JOybOQCYBCBmvBet2vzdL9GOpZZZyR10oTWfdBBi/7RH+74xqxg8MZnDncShXrlv
         W2tDXjBYLey79nFLZFyVl+iX6Eb9pfkglT4AwDSi6hfUbyIKJ/lioK+p6fY1yEDKIMEf
         xCFFfItOywsDbxaQ4mypXJtcaHvNX7D/tQlROXorXffDEo92P+cu/Cpj8Vax+YrwBKpq
         tzpsG538/GEVcvwvi7eT74l/GInS/UITBVLJGievB+giAhSMHewABpRLNT7uoG/FO+nG
         8I6w==
X-Gm-Message-State: AOAM53125sVVZcShwwr2oMioNmWX8beh4eFXVaA763HLqqUZ2lkfmNEd
        whV9Ko0GcDBZU9jedmW9A84=
X-Google-Smtp-Source: ABdhPJzocuRXVD+bPmrqSjVXD61c/mr1QuassCJZAWcu3BRdBXPc1L3HjKV+b5/kdsWDa9hsVQr+qg==
X-Received: by 2002:ac8:7a87:: with SMTP id x7mr2792856qtr.253.1606307591437;
        Wed, 25 Nov 2020 04:33:11 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id a123sm2264134qkc.52.2020.11.25.04.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:33:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 07:32:48 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com, houtao1@huawei.com
Subject: Re: [RFC PATCH] blk-cgroup: prevent rcu_sched detected stalls
 warnings in blkg_destroy_all()
Message-ID: <X75O8BNVSX3ZE86w@mtj.duckdns.org>
References: <20201121083420.3857433-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121083420.3857433-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

Thanks for the fix. A couple comments below.

On Sat, Nov 21, 2020 at 04:34:20PM +0800, Yu Kuai wrote:
> +#define BLKG_DESTROY_BATH 4096

I think you meant BLKG_DESTROY_BATCH.

>  static void blkg_destroy_all(struct request_queue *q)
>  {
>  	struct blkcg_gq *blkg, *n;
> +	int count = BLKG_DESTROY_BATH;

But might as well just write 4096 here.

>  	spin_lock_irq(&q->queue_lock);
>  	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
>  		struct blkcg *blkcg = blkg->blkcg;
>  
> +		/*
> +		 * If the list is too long, the loop can took a long time,
> +		 * thus relese the lock for a while when a batch of blkcg
> +		 * were destroyed.
> +		 */
> +		if (!(--count)) {
> +			count = BLKG_DESTROY_BATH;
> +			spin_unlock_irq(&q->queue_lock);
> +			cond_resched();
> +			spin_lock_irq(&q->queue_lock);

You can't continue iteration after dropping both locks. You'd have to jump
out of loop and start list_for_each_entry_safe() again.

> +		}
>  		spin_lock(&blkcg->lock);
>  		blkg_destroy(blkg);
>  		spin_unlock(&blkcg->lock);

Thanks.

-- 
tejun
