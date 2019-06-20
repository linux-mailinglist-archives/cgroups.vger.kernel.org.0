Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 409CB4D027
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2019 16:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbfFTOQT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jun 2019 10:16:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35406 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfFTOQT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jun 2019 10:16:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so1769181pfd.2;
        Thu, 20 Jun 2019 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JX8bg31yby0J9Wcl6LtK7Ir+iC18LOMFEP9KmGrcSb4=;
        b=B5ZViM+Ze0QlX28FY2X8Iypcio5Swec6G71h1/6O7zHXU47Wn/gdLlzzl8m+MWo6h1
         S2MzeNT9bNRWNJ8jUwDi9B+X+KIZVQPKGQovqzGyjM3/cZv2bJf+u0v4Om3KVehUgtlm
         qCL+jdA4TCvIySabL2cRZXcZHCInxFRhoyXYKYLjm/mLMBUXN34O6yfF2YyDoToKpb3X
         F6b8e2tmNskibCU9atvxgbEvbHetNxMTrbxNjmVYq1T6st56fJA/gYlfWVfa0zQZ7tRi
         8tMoxq1hzQNQBEzUhY5r9eBVFVZ/zxrmeK8PcS6MPeSG+VwWx3DfsQcMfDu6KBHZ6xEs
         F1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JX8bg31yby0J9Wcl6LtK7Ir+iC18LOMFEP9KmGrcSb4=;
        b=kSAT9Jhm+0Lzhof636gLQCQ5T0ZClSutWrX0f4bkOo4S71XEXqNSfuuC2wC06AfQyE
         EwWMa0m8keIU84ZfBRskeZBbPoBz2cB2r8VnogA2+Z5aRQTVcDNR4D28ISHkLmMaBBwA
         /V5HFdddDaGWQ3bszOA3Dg/wnY38GjOhDFuYGz2y0E/DDI+NTdQNB9NCflZhASesagjZ
         ISo+JFGj7/uss35qe4RGZwK+wZmJOlcqH3/7btCuSZkCbEVbSlxfxAsA2NPkY0IpaiHQ
         7dxY9HwkCfepYOYtikMKdm8ICRFlQku69q/qAV3dyeqZzIPPlDzauG2xTfbXlwECxd+5
         kcgQ==
X-Gm-Message-State: APjAAAVm9eiuXxwx4ufFo/Ej71yduXys0+a35Yc0GI6+/MbPiJP+y0xw
        hEz8IYdDMKvCbooP0sNwIpE=
X-Google-Smtp-Source: APXvYqwFozTTWSzq7lbHiL9Y1OXNIOn1v7INL7+KjCanKhQ4LlwOMk69TcG97nUFXMY8lnSPC29WHQ==
X-Received: by 2002:a17:90a:26a1:: with SMTP id m30mr3408246pje.59.1561040178055;
        Thu, 20 Jun 2019 07:16:18 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id k3sm21434890pgo.81.2019.06.20.07.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 07:16:17 -0700 (PDT)
Date:   Thu, 20 Jun 2019 23:16:14 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Weiping Zhang <zhangweiping@didiglobal.com>
Cc:     axboe@kernel.dk, tj@kernel.org, hch@lst.de, bvanassche@acm.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
Subject: Re: [PATCH v2 4/4] nvme: add support weighted round robin queue
Message-ID: <20190620141614.GB12032@minwooim-desktop>
References: <cover.1560679439.git.zhangweiping@didiglobal.com>
 <0b0fa12a337f97a8cc878b58673b3eb619539174.1560679439.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b0fa12a337f97a8cc878b58673b3eb619539174.1560679439.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> -static int write_queues;
> -module_param_cb(write_queues, &queue_count_ops, &write_queues, 0644);
> -MODULE_PARM_DESC(write_queues,
> -	"Number of queues to use for writes. If not set, reads and writes "
> +static int read_queues;
> +module_param_cb(read_queues, &queue_count_ops, &read_queues, 0644);
> +MODULE_PARM_DESC(read_queues,
> +	"Number of queues to use for reads. If not set, reads and writes "
>  	"will share a queue set.");

Before starting my review for this, I'd like to talk about this part
first.  It would be better if you can split this change from this commit
into a new one because it just replaced the write_queues with
read_queues which is directly mapped to HCTX_TYPE_READ.  This change
might not be critical for the WRR implementation.

>  
>  static int poll_queues = 0;
>  module_param_cb(poll_queues, &queue_count_ops, &poll_queues, 0644);
>  MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
>  
> +static int wrr_high_queues = 0;

Nitpick here: maybe we don't need to 0-initialize static variables
explicitly.

> +module_param_cb(wrr_high_queues, &queue_count_ops, &wrr_high_queues, 0644);
> +MODULE_PARM_DESC(wrr_high_queues, "Number of queues to use for WRR high.");
> +
> +static int wrr_medium_queues = 0;
> +module_param_cb(wrr_medium_queues, &queue_count_ops, &wrr_medium_queues, 0644);
> +MODULE_PARM_DESC(wrr_medium_queues, "Number of queues to use for WRR medium.");
> +
> +static int wrr_low_queues = 0;
> +module_param_cb(wrr_low_queues, &queue_count_ops, &wrr_low_queues, 0644);
> +MODULE_PARM_DESC(wrr_low_queues, "Number of queues to use for WRR low.");
> +
>  struct nvme_dev;
>  struct nvme_queue;
>  
> @@ -226,9 +238,17 @@ struct nvme_iod {
>  	struct scatterlist *sg;
>  };
>  
> +static inline bool nvme_is_enable_wrr(struct nvme_dev *dev)
> +{
> +	return dev->io_queues[HCTX_TYPE_WRR_LOW] +
> +		dev->io_queues[HCTX_TYPE_WRR_MEDIUM] +
> +		dev->io_queues[HCTX_TYPE_WRR_HIGH] > 0;
> +}

It looks like that it might be confused with AMS(Arbitration Mechanism
Selected) in CC or CAP?  If it meant how many irqs for the sets were
allocated, then can we have this function with another name like:
	nvme_is_wrr_allocated or something indicating the irqsets

> +
>  static unsigned int max_io_queues(void)
>  {
> -	return num_possible_cpus() + write_queues + poll_queues;
> +	return num_possible_cpus() + read_queues + poll_queues +
> +		wrr_high_queues + wrr_medium_queues + wrr_low_queues;
>  }
>  
>  static unsigned int max_queue_count(void)
> @@ -1534,11 +1558,46 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
>  	wmb(); /* ensure the first interrupt sees the initialization */
>  }
>  
> -static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
> +static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
>  {
>  	struct nvme_dev *dev = nvmeq->dev;
> -	int result;
> +	int start, end, result, wrr;
> +	bool polled = false;
>  	u16 vector = 0;
> +	enum hctx_type type;
> +
> +	/* 0 for admain queue, io queue index >= 1 */
> +	start = 1;
> +	/* get hardware context type base on qid */
> +	for (type = HCTX_TYPE_DEFAULT; type < HCTX_MAX_TYPES; type++) {
> +		end = start + dev->io_queues[type] - 1;
> +		if (qid >= start && qid <= end)
> +			break;
> +		start = end + 1;
> +	}
> +
> +	if (nvme_is_enable_wrr(dev)) {

I think we need to check not only the irqset allocations, but also if the
device is really supports WRR or not.

> +		/* set read,poll,default to medium by default */
> +		switch (type) {
> +		case HCTX_TYPE_POLL:
> +			polled = true;

Question: Is poll-queue not avilable to be used in case of !WRR?

> +		case HCTX_TYPE_DEFAULT:
> +		case HCTX_TYPE_READ:
> +		case HCTX_TYPE_WRR_MEDIUM:
> +			wrr = NVME_SQ_PRIO_MEDIUM;

Also it seems like it could be named like flags because it will show the
SQ priority.  What do you think?

> +			break;
> +		case HCTX_TYPE_WRR_LOW:
> +			wrr = NVME_SQ_PRIO_LOW;
> +			break;
> +		case HCTX_TYPE_WRR_HIGH:
> +			wrr = NVME_SQ_PRIO_HIGH;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	} else {
> +		wrr = 0;

Would it be different with the following value ?
	NVME_SQ_PRIO_URGENT     = (0 << 1)
If it means no WRR, then can it be avoided the value which is already
defined ?

> +	}
>  
>  	clear_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
>  

> @@ -2028,35 +2079,73 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
>  static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
>  {
>  	struct nvme_dev *dev = affd->priv;
> -	unsigned int nr_read_queues;
> +	unsigned int nr_total, nr, nr_read, nr_default;
> +	unsigned int nr_wrr_high, nr_wrr_medium, nr_wrr_low;
> +	unsigned int nr_sets;
>  
>  	/*
>  	 * If there is no interupt available for queues, ensure that
>  	 * the default queue is set to 1. The affinity set size is
>  	 * also set to one, but the irq core ignores it for this case.
> -	 *
> -	 * If only one interrupt is available or 'write_queue' == 0, combine
> -	 * write and read queues.
> -	 *
> -	 * If 'write_queues' > 0, ensure it leaves room for at least one read
> -	 * queue.
>  	 */
> -	if (!nrirqs) {
> +	if (!nrirqs)
>  		nrirqs = 1;
> -		nr_read_queues = 0;
> -	} else if (nrirqs == 1 || !write_queues) {
> -		nr_read_queues = 0;
> -	} else if (write_queues >= nrirqs) {
> -		nr_read_queues = 1;
> -	} else {
> -		nr_read_queues = nrirqs - write_queues;
> -	}
>  
> -	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
> -	affd->set_size[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
> -	dev->io_queues[HCTX_TYPE_READ] = nr_read_queues;
> -	affd->set_size[HCTX_TYPE_READ] = nr_read_queues;
> -	affd->nr_sets = nr_read_queues ? 2 : 1;
> +	nr_total = nrirqs;
> +
> +	nr_read = nr_wrr_high = nr_wrr_medium = nr_wrr_low = 0;
> +
> +	/* set default to 1, add all the rest queue to default at last */
> +	nr = nr_default = 1;
> +	nr_sets = 1;
> +
> +	nr_total -= nr;
> +	if (!nr_total)
> +		goto done;
> +
> +	/* read queues */
> +	nr_sets++;
> +	nr_read = nr = read_queues > nr_total ? nr_total : read_queues;
> +	nr_total -= nr;
> +	if (!nr_total)
> +		goto done;
> +
> +	/* wrr low queues */
> +	nr_sets++;
> +	nr_wrr_low = nr = wrr_low_queues > nr_total ? nr_total : wrr_low_queues;
> +	nr_total -= nr;
> +	if (!nr_total)
> +		goto done;
> +
> +	/* wrr medium queues */
> +	nr_sets++;
> +	nr_wrr_medium = nr = wrr_medium_queues > nr_total ? nr_total : wrr_medium_queues;

It looks like exceeded 80 chracters here.

> +	nr_total -= nr;
> +	if (!nr_total)
> +		goto done;
> +
> +	/* wrr high queues */
> +	nr_sets++;
> +	nr_wrr_high = nr = wrr_high_queues > nr_total ? nr_total : wrr_high_queues;
> +	nr_wrr_high = nr = wrr_high_queues > nr_total ? nr_total : wrr_high_queues;

Here also.

If I misunderstood something here, please feel free to let me know.

Thanks,
