Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16992BB89B
	for <lists+cgroups@lfdr.de>; Fri, 20 Nov 2020 22:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgKTVvu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Nov 2020 16:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgKTVvu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Nov 2020 16:51:50 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2CAC0613CF;
        Fri, 20 Nov 2020 13:51:50 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id i13so8445348pgm.9;
        Fri, 20 Nov 2020 13:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DMZDqk3EJTuLlBttmZxfIGencN4dIvpRMnJMaj5PBvU=;
        b=sRT77v23nRDxyQSyZSuMgmdeaEAoyhj7Z59RWqMDuKoYEnw5wtqRSqfEpVjc9Hdx30
         d4qXl/FXmc5VUCfMBuuLVUo9qFy2UzVgtq9799+9c5xAlIYHz05JFa1AAbLlmGnQyWIY
         SAaQiZcNv9M7IhIXFK3ttWB/RUOJo4lFekX35PZhHQ12Hz/BPTj7YwvGyQPHgFpINSch
         8nEHkLVUcKsJ5AWntGnKbwb8jz1wjrFE/18RxCcg7aKHI3adYFjJfL2NIYYdexnhq/6X
         H+FtqU4coAoCuH1JrxNDtaJ+V64XjjINgYfp/nhmxYJ8QJBWVZ2lK0deeBQHHfVIwX7P
         qEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DMZDqk3EJTuLlBttmZxfIGencN4dIvpRMnJMaj5PBvU=;
        b=PQumrgpqUUZcrUrD0OD9nSRi2umZJ10aaJXl1ENEWzpwHn5iW5UCmxFzLBqnap+j/d
         NQCz6hQpXmV4ILvrftkR/anMIIF4P+oZQ75FqhH7NnzlXV4Nbnmd8Salr+yV2SMawvbO
         oDTZkNjVGLeaYhyWCP2ueh5PLre1i8nz3Syw5PmGjxt7KdK8Rb8fROpew9qCctFGMwRH
         YZKtV61dkzCpz5fa9ZVBoNqzpKZ+phXcWgz+Qe70W43gll5UXv2l9Odi0jb5cFG4i/l2
         QOj3i8EtMv6uQjDOZYy4A7Z45NG912+Wbb7AjXokB9qVRIVEWt2dyAp4c5cIoZgiUvCU
         aw8w==
X-Gm-Message-State: AOAM531mqusEPVugPkDP7CoNUkEmimJkuIJuUKkRe2uNb3gkTxDGgRq6
        nTZkotweu5yYXwEtG5dX6OML+HkdnvM=
X-Google-Smtp-Source: ABdhPJzTM+m7K00QasW+CUKrFf9wSBg2cvJbboS9htreZKHu4KGgAwPq5WC6PEM+L1fECUWiTSUNUQ==
X-Received: by 2002:a62:7cd3:0:b029:18b:8c56:91eb with SMTP id x202-20020a627cd30000b029018b8c5691ebmr15451198pfc.23.1605909110033;
        Fri, 20 Nov 2020 13:51:50 -0800 (PST)
Received: from localhost (g133.220-213-56.ppp.wakwak.ne.jp. [220.213.56.133])
        by smtp.gmail.com with ESMTPSA id r66sm3410197pfc.114.2020.11.20.13.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:51:49 -0800 (PST)
Date:   Sat, 21 Nov 2020 06:51:47 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, newella@fb.com
Subject: Re: [PATCH 03/27] blk-iocost: use local[64]_t for percpu stat
Message-ID: <20201120215147.GB961977@lianli.shorne-pla.net>
References: <20200901185257.645114-1-tj@kernel.org>
 <20200901185257.645114-4-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901185257.645114-4-tj@kernel.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 01, 2020 at 02:52:33PM -0400, Tejun Heo wrote:
> blk-iocost has been reading percpu stat counters from remote cpus which on
> some archs can lead to torn reads in really rare occassions. Use local[64]_t
> for those counters.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  block/blk-iocost.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index d37b55db2409..e2266e7692b4 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -179,6 +179,8 @@
>  #include <linux/parser.h>
>  #include <linux/sched/signal.h>
>  #include <linux/blk-cgroup.h>
> +#include <asm/local.h>
> +#include <asm/local64.h>

Hi Tejun,

FYI, I am just noticing this but this breaks my allyesconfig build
on OpenRISC; as 32-bit arch/openrisc doesn't define local64.h

In general local64 is slow on 32-bit architectures, would that
be a problem with the usage here?  Are the calls to local64_*
below on critical paths?

Either way I will submit a patch in include generic local64.h
on OpenRISC, I confirmed it fixes the build.  I do not know of anyone
using cgroups on OpenRISC systems.

-Stafford

>  #include "blk-rq-qos.h"
>  #include "blk-stat.h"
>  #include "blk-wbt.h"
> @@ -373,8 +375,8 @@ struct ioc_params {
>  };
>  
>  struct ioc_missed {
> -	u32				nr_met;
> -	u32				nr_missed;
> +	local_t				nr_met;
> +	local_t				nr_missed;
>  	u32				last_met;
>  	u32				last_missed;
>  };
> @@ -382,7 +384,7 @@ struct ioc_missed {
>  struct ioc_pcpu_stat {
>  	struct ioc_missed		missed[2];
>  
> -	u64				rq_wait_ns;
> +	local64_t			rq_wait_ns;
>  	u64				last_rq_wait_ns;
>  };
>  
> @@ -1278,8 +1280,8 @@ static void ioc_lat_stat(struct ioc *ioc, u32 *missed_ppm_ar, u32 *rq_wait_pct_p
>  		u64 this_rq_wait_ns;
>  
>  		for (rw = READ; rw <= WRITE; rw++) {
> -			u32 this_met = READ_ONCE(stat->missed[rw].nr_met);
> -			u32 this_missed = READ_ONCE(stat->missed[rw].nr_missed);
> +			u32 this_met = local_read(&stat->missed[rw].nr_met);
> +			u32 this_missed = local_read(&stat->missed[rw].nr_missed);
>  
>  			nr_met[rw] += this_met - stat->missed[rw].last_met;
>  			nr_missed[rw] += this_missed - stat->missed[rw].last_missed;
> @@ -1287,7 +1289,7 @@ static void ioc_lat_stat(struct ioc *ioc, u32 *missed_ppm_ar, u32 *rq_wait_pct_p
>  			stat->missed[rw].last_missed = this_missed;
>  		}
>  
> -		this_rq_wait_ns = READ_ONCE(stat->rq_wait_ns);
> +		this_rq_wait_ns = local64_read(&stat->rq_wait_ns);
>  		rq_wait_ns += this_rq_wait_ns - stat->last_rq_wait_ns;
>  		stat->last_rq_wait_ns = this_rq_wait_ns;
>  	}
> @@ -1908,6 +1910,7 @@ static void ioc_rqos_done_bio(struct rq_qos *rqos, struct bio *bio)
>  static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
>  {
>  	struct ioc *ioc = rqos_to_ioc(rqos);
> +	struct ioc_pcpu_stat *ccs;
>  	u64 on_q_ns, rq_wait_ns, size_nsec;
>  	int pidx, rw;
>  
> @@ -1931,13 +1934,17 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
>  	rq_wait_ns = rq->start_time_ns - rq->alloc_time_ns;
>  	size_nsec = div64_u64(calc_size_vtime_cost(rq, ioc), VTIME_PER_NSEC);
>  
> +	ccs = get_cpu_ptr(ioc->pcpu_stat);
> +
>  	if (on_q_ns <= size_nsec ||
>  	    on_q_ns - size_nsec <= ioc->params.qos[pidx] * NSEC_PER_USEC)
> -		this_cpu_inc(ioc->pcpu_stat->missed[rw].nr_met);
> +		local_inc(&ccs->missed[rw].nr_met);
>  	else
> -		this_cpu_inc(ioc->pcpu_stat->missed[rw].nr_missed);
> +		local_inc(&ccs->missed[rw].nr_missed);
> +
> +	local64_add(rq_wait_ns, &ccs->rq_wait_ns);
>  
> -	this_cpu_add(ioc->pcpu_stat->rq_wait_ns, rq_wait_ns);
> +	put_cpu_ptr(ccs);
>  }
>  
>  static void ioc_rqos_queue_depth_changed(struct rq_qos *rqos)
> @@ -1977,7 +1984,7 @@ static int blk_iocost_init(struct request_queue *q)
>  {
>  	struct ioc *ioc;
>  	struct rq_qos *rqos;
> -	int ret;
> +	int i, cpu, ret;
>  
>  	ioc = kzalloc(sizeof(*ioc), GFP_KERNEL);
>  	if (!ioc)
> @@ -1989,6 +1996,16 @@ static int blk_iocost_init(struct request_queue *q)
>  		return -ENOMEM;
>  	}
>  
> +	for_each_possible_cpu(cpu) {
> +		struct ioc_pcpu_stat *ccs = per_cpu_ptr(ioc->pcpu_stat, cpu);
> +
> +		for (i = 0; i < ARRAY_SIZE(ccs->missed); i++) {
> +			local_set(&ccs->missed[i].nr_met, 0);
> +			local_set(&ccs->missed[i].nr_missed, 0);
> +		}
> +		local64_set(&ccs->rq_wait_ns, 0);
> +	}
> +
>  	rqos = &ioc->rqos;
>  	rqos->id = RQ_QOS_COST;
>  	rqos->ops = &ioc_rqos_ops;
> -- 
> 2.26.2
> 
