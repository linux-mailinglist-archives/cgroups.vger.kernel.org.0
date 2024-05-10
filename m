Return-Path: <cgroups+bounces-2852-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59DB8C1EB6
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 09:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A3A1F22BAA
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 07:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CCA15EFB4;
	Fri, 10 May 2024 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKNosrfb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF78515ECDF;
	Fri, 10 May 2024 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325073; cv=none; b=rRwhMsSlcvRmL6s9VUnKJ9+Rl8SRAr2SILVRhZrW+jT9dHCoW/9XjNwcIF7XAKQjFsafLokTQnT4T8LCF6m47cRTahY+veJw/Z7GgvgbRha8lxCULzgF/DCRtw/nm0v8PCX+nvYlXHfn62T/Q9grH4oLscLAQ3fLNk0JBtbx2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325073; c=relaxed/simple;
	bh=9vkE8mzX9h2u+gdWiRVG95GW1btLhJ18wAPQIaicwYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A654SHrxp39oxzaiXwzlOvCvcTia8XfBQoP1xkggY3tGXDhPfA+EKiYraogV/iKn6D79NzBNEyVWOD4VqN3cbbIPw7SpZjw0osiNdFwhYJazLDBBxrWJxjWdw7Akg/fqh7bxzBIQflZNiJr1+zj/DNw6kbiqIdggjYAv+uK/XRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKNosrfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330CEC2BD11;
	Fri, 10 May 2024 07:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715325073;
	bh=9vkE8mzX9h2u+gdWiRVG95GW1btLhJ18wAPQIaicwYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EKNosrfbFzAYrRQmfKu/KoccpQD6WXfe3PcX6fBoVrQiRXF2CKooNkxcaJChX12aB
	 q00nMPeTfle4ByAM49solZffzTS3cI27Gyv3arCCSJ/n8VyXlhG96kyvREBv/8WTe9
	 zyf8RxER+/lDbbmkWsbB8F3hXXf6AFD6AhkWnUJ1jPaypXgQiE4xBak1RWvgOoM1Zu
	 o11rYCDmYy9mFurkg54ddjFZzD/uHDV8asfI4BD2igR0HCnrJrvT9IeDr6JKZ+CHa0
	 tA49+jFRoVQgKlfDMlxISVukAsWI/ee9mYeqlZdPs0qXV/daZG38WpwweGiHh3rH3x
	 j4uGzW6wQDung==
Message-ID: <fcda2351-9ba7-4121-a993-184a4c02f9a6@kernel.org>
Date: Fri, 10 May 2024 16:11:10 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] block: track per-node I/O latency
To: John Meneghini <jmeneghi@redhat.com>, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, emilne@redhat.com, hare@kernel.org
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, aviv.coro@ibm.com
References: <20240403141756.88233-1-hare@kernel.org>
 <20240509204324.832846-2-jmeneghi@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240509204324.832846-2-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/24 05:43, John Meneghini wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Add a new option 'BLK_NODE_LATENCY' to track per-node I/O latency.
> This can be used by I/O schedulers to determine the 'best' queue
> to send I/O to.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> 
> Cleaned up checkpatch warnings and updated MAINTAINERS.

This note should be before Hannes SoB. E.g:

[John] Fixed checkpatch warnings and updated MAINTAINERS.

> 
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> ---
>  MAINTAINERS            |   1 +
>  block/Kconfig          |   9 +
>  block/Makefile         |   1 +
>  block/blk-mq-debugfs.c |   2 +
>  block/blk-nlatency.c   | 389 +++++++++++++++++++++++++++++++++++++++++
>  block/blk-rq-qos.h     |   6 +
>  include/linux/blk-mq.h |  11 ++
>  7 files changed, 419 insertions(+)
>  create mode 100644 block/blk-nlatency.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7c121493f43d..a4634365c82f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5405,6 +5405,7 @@ F:	block/bfq-cgroup.c
>  F:	block/blk-cgroup.c
>  F:	block/blk-iocost.c
>  F:	block/blk-iolatency.c
> +F:	block/blk-nlatency.c
>  F:	block/blk-throttle.c
>  F:	include/linux/blk-cgroup.h
>  
> diff --git a/block/Kconfig b/block/Kconfig
> index 1de4682d48cc..641ed39d609c 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -186,6 +186,15 @@ config BLK_CGROUP_IOPRIO
>  	scheduler and block devices process requests. Only some I/O schedulers
>  	and some block devices support I/O priorities.
>  
> +config BLK_NODE_LATENCY
> +	bool "Track per-node I/O latency"
> +	help
> +	Enable per-node I/O latency tracking for multipathing. This uses the
> +	blk-nodelat latency tracker to provide latencies for each node, and schedules
> +	I/O on the path with the least latency for the submitting node. This can be
> +	used by I/O schedulers to determine the node with the least latency. Currently
> +	only supports nvme over fabrics devices.
> +
>  config BLK_DEBUG_FS
>  	bool "Block layer debugging information in debugfs"
>  	default y
> diff --git a/block/Makefile b/block/Makefile
> index 46ada9dc8bbf..9d2e71a3e36f 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
>  obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= blk-ioprio.o
>  obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
>  obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= blk-iocost.o
> +obj-$(CONFIG_BLK_NODE_LATENCY) += blk-nlatency.o

Let's keep the alignment please.

>  obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
>  obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
>  bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 94668e72ab09..cb38228b95d8 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -762,6 +762,8 @@ static const char *rq_qos_id_to_name(enum rq_qos_id id)
>  		return "latency";
>  	case RQ_QOS_COST:
>  		return "cost";
> +	case RQ_QOS_NLAT:
> +		return "node-latency";
>  	}
>  	return "unknown";
>  }
> diff --git a/block/blk-nlatency.c b/block/blk-nlatency.c
> new file mode 100644
> index 000000000000..219c3f636d76
> --- /dev/null
> +++ b/block/blk-nlatency.c
> @@ -0,0 +1,389 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Per-node request latency tracking.
> + *
> + * Copyright (C) 2023 Hannes Reinecke
> + *
> + * A simple per-node latency tracker for use by I/O scheduler.
> + * Latencies are measures over 'win_usec' microseconds and stored per node.
> + * If the number of measurements falls below 'lowat' the measurement is
> + * assumed to be unreliable and will become 'stale'.
> + * These 'stale' latencies can be 'decayed', where during each measurement
> + * interval the 'stale' latency value is decreased by 'decay' percent.
> + * Once the 'stale' latency reaches zero it will be updated by the
> + * measured latency.
> + */
> +#include <linux/kernel.h>
> +#include <linux/blk_types.h>
> +#include <linux/slab.h>
> +
> +#include "blk-stat.h"
> +#include "blk-rq-qos.h"
> +#include "blk.h"
> +
> +#define NLAT_DEFAULT_LOWAT 2
> +#define NLAT_DEFAULT_DECAY 50
> +
> +struct rq_nlat {
> +	struct rq_qos rqos;
> +
> +	u64 win_usec;		/* latency measurement window in microseconds */

Using microseconds forces you to do costly multiplications and divisions by
1000. Why not keep things in nanoseconds ?

> +	unsigned int lowat;	/* Low Watermark latency measurement */
> +	unsigned int decay;	/* Percentage for 'decaying' latencies */
> +	bool enabled;
> +
> +	struct blk_stat_callback *cb;
> +
> +	unsigned int num;
> +	u64 *latency;
> +	unsigned int *samples;
> +};
> +
> +static inline struct rq_nlat *RQNLAT(struct rq_qos *rqos)
> +{
> +	return container_of(rqos, struct rq_nlat, rqos);
> +}
> +
> +static u64 nlat_default_latency_usec(struct request_queue *q)
> +{
> +	/*
> +	 * We default to 2msec for non-rotational storage, and 75msec
> +	 * for rotational storage.
> +	 */
> +	if (blk_queue_nonrot(q))
> +		return 2000ULL;
> +	else

No need for this else.

> +		return 75000ULL;
> +}
> +
> +static void nlat_timer_fn(struct blk_stat_callback *cb)
> +{
> +	struct rq_nlat *nlat = cb->data;
> +	int n;
> +
> +	for (n = 0; n < cb->buckets; n++) {
> +		if (cb->stat[n].nr_samples < nlat->lowat) {
> +			/*
> +			 * 'decay' the latency by the specified
> +			 * percentage to ensure the queues are
> +			 * being tested to balance out temporary
> +			 * latency spikes.
> +			 */
> +			nlat->latency[n] =
> +				div64_u64(nlat->latency[n] * nlat->decay, 100);
> +		} else
> +			nlat->latency[n] = cb->stat[n].mean;

Missing the curly brackets around the else block.
Nit: n is a rather unusual name for a loop index. Why not the usual "i" ? Does
notmatter much though.

> +		nlat->samples[n] = cb->stat[n].nr_samples;
> +	}
> +	if (nlat->enabled)
> +		blk_stat_activate_nsecs(nlat->cb, nlat->win_usec * 1000);
> +}
> +
> +static int nlat_bucket_node(const struct request *rq)
> +{
> +	if (!rq->mq_ctx)
> +		return -1;
> +	return cpu_to_node(blk_mq_rq_cpu((struct request *)rq));
> +}
> +
> +static void nlat_exit(struct rq_qos *rqos)
> +{
> +	struct rq_nlat *nlat = RQNLAT(rqos);
> +
> +	blk_stat_remove_callback(nlat->rqos.disk->queue, nlat->cb);
> +	blk_stat_free_callback(nlat->cb);
> +	kfree(nlat->samples);
> +	kfree(nlat->latency);
> +	kfree(nlat);
> +}
> +
> +#ifdef CONFIG_BLK_DEBUG_FS
> +static int nlat_win_usec_show(void *data, struct seq_file *m)
> +{
> +	struct rq_qos *rqos = data;
> +	struct rq_nlat *nlat = RQNLAT(rqos);
> +
> +	seq_printf(m, "%llu\n", nlat->win_usec);
> +	return 0;
> +}
> +
> +static ssize_t nlat_win_usec_write(void *data, const char __user *buf,
> +			size_t count, loff_t *ppos)
> +{
> +	struct rq_qos *rqos = data;
> +	struct rq_nlat *nlat = RQNLAT(rqos);
> +	char val[16] = { };
> +	u64 usec;
> +	int err;
> +
> +	if (blk_queue_dying(nlat->rqos.disk->queue))
> +		return -ENOENT;
> +
> +	if (count >= sizeof(val))
> +		return -EINVAL;
> +
> +	if (copy_from_user(val, buf, count))
> +		return -EFAULT;
> +
> +	err = kstrtoull(val, 10, &usec);
> +	if (err)
> +		return err;
> +	blk_stat_deactivate(nlat->cb);
> +	nlat->win_usec = usec;
> +	blk_stat_activate_nsecs(nlat->cb, nlat->win_usec * 1000);
> +
> +	return count;
> +}
> +
> +static int nlat_lowat_show(void *data, struct seq_file *m)
> +{
> +	struct rq_qos *rqos = data;
> +	struct rq_nlat *nlat = RQNLAT(rqos);
> +
> +	seq_printf(m, "%u\n", nlat->lowat);
> +	return 0;
> +}
> +
> +static ssize_t nlat_lowat_write(void *data, const char __user *buf,
> +			size_t count, loff_t *ppos)
> +{
> +	struct rq_qos *rqos = data;
> +	struct rq_nlat *nlat = RQNLAT(rqos);
> +	char val[16] = { };
> +	unsigned int lowat;
> +	int err;
> +
> +	if (blk_queue_dying(nlat->rqos.disk->queue))
> +		return -ENOENT;
> +
> +	if (count >= sizeof(val))
> +		return -EINVAL;
> +
> +	if (copy_from_user(val, buf, count))
> +		return -EFAULT;
> +
> +	err = kstrtouint(val, 10, &lowat);
> +	if (err)
> +		return err;
> +	blk_stat_deactivate(nlat->cb);
> +	nlat->lowat = lowat;
> +	blk_stat_activate_nsecs(nlat->cb, nlat->win_usec * 1000);
> +
> +	return count;
> +}
> +
> +static int nlat_decay_show(void *data, struct seq_file *m)
> +{
> +	struct rq_qos *rqos = data;
> +	struct rq_nlat *nlat = RQNLAT(rqos);
> +
> +	seq_printf(m, "%u\n", nlat->decay);
> +	return 0;
> +}
> +
> +static ssize_t nlat_decay_write(void *data, const char __user *buf,
> +			size_t count, loff_t *ppos)
> +{
> +	struct rq_qos *rqos = data;
> +	struct rq_nlat *nlat = RQNLAT(rqos);
> +	char val[16] = { };
> +	unsigned int decay;
> +	int err;
> +
> +	if (blk_queue_dying(nlat->rqos.disk->queue))
> +		return -ENOENT;
> +
> +	if (count >= sizeof(val))
> +		return -EINVAL;
> +
> +	if (copy_from_user(val, buf, count))
> +		return -EFAULT;
> +
> +	err = kstrtouint(val, 10, &decay);
> +	if (err)
> +		return err;
> +	if (decay > 100)
> +		return -EINVAL;
> +	blk_stat_deactivate(nlat->cb);
> +	nlat->decay = decay;
> +	blk_stat_activate_nsecs(nlat->cb, nlat->win_usec * 1000);
> +
> +	return count;
> +}
> +
> +static int nlat_enabled_show(void *data, struct seq_file *m)
> +{
> +	struct rq_qos *rqos = data;
> +	struct rq_nlat *nlat = RQNLAT(rqos);
> +
> +	seq_printf(m, "%d\n", nlat->enabled);
> +	return 0;
> +}
> +
> +static int nlat_id_show(void *data, struct seq_file *m)
> +{
> +	struct rq_qos *rqos = data;
> +
> +	seq_printf(m, "%u\n", rqos->id);
> +	return 0;
> +}
> +
> +static int nlat_latency_show(void *data, struct seq_file *m)
> +{
> +	struct rq_qos *rqos = data;
> +	struct rq_nlat *nlat = RQNLAT(rqos);
> +	int n;
> +
> +	if (!nlat->enabled)
> +		return 0;
> +
> +	for (n = 0; n < nlat->num; n++) {
> +		if (n > 0)
> +			seq_puts(m, " ");
> +		seq_printf(m, "%llu", nlat->latency[n]);
> +	}
> +	seq_puts(m, "\n");
> +	return 0;
> +}
> +
> +static int nlat_samples_show(void *data, struct seq_file *m)
> +{
> +	struct rq_qos *rqos = data;
> +	struct rq_nlat *nlat = RQNLAT(rqos);
> +	int n;
> +
> +	if (!nlat->enabled)
> +		return 0;
> +
> +	for (n = 0; n < nlat->num; n++) {
> +		if (n > 0)
> +			seq_puts(m, " ");
> +		seq_printf(m, "%u", nlat->samples[n]);
> +	}
> +	seq_puts(m, "\n");
> +	return 0;
> +}
> +
> +static const struct blk_mq_debugfs_attr nlat_debugfs_attrs[] = {
> +	{"win_usec", 0600, nlat_win_usec_show, nlat_win_usec_write},
> +	{"lowat", 0600, nlat_lowat_show, nlat_lowat_write},
> +	{"decay", 0600, nlat_decay_show, nlat_decay_write},
> +	{"enabled", 0400, nlat_enabled_show},
> +	{"id", 0400, nlat_id_show},
> +	{"latency", 0400, nlat_latency_show},
> +	{"samples", 0400, nlat_samples_show},
> +	{},
> +};
> +#endif
> +
> +static const struct rq_qos_ops nlat_rqos_ops = {
> +	.exit = nlat_exit,
> +#ifdef CONFIG_BLK_DEBUG_FS
> +	.debugfs_attrs = nlat_debugfs_attrs,
> +#endif
> +};
> +
> +u64 blk_nlat_latency(struct gendisk *disk, int node)
> +{
> +	struct rq_qos *rqos;
> +	struct rq_nlat *nlat;
> +
> +	rqos = nlat_rq_qos(disk->queue);
> +	if (!rqos)
> +		return 0;
> +	nlat = RQNLAT(rqos);
> +	if (node > nlat->num)
> +		return 0;
> +
> +	return div64_u64(nlat->latency[node], 1000);

See comment at the top. Why not keep everything in nanoseconds to avoid this
costly division ?

> +}
> +EXPORT_SYMBOL_GPL(blk_nlat_latency);
> +
> +int blk_nlat_enable(struct gendisk *disk)
> +{
> +	struct rq_qos *rqos;
> +	struct rq_nlat *nlat;
> +
> +	/* Latency tracking not enabled? */
> +	rqos = nlat_rq_qos(disk->queue);
> +	if (!rqos)
> +		return -EINVAL;
> +	nlat = RQNLAT(rqos);
> +	if (nlat->enabled)
> +		return 0;
> +
> +	/* Queue not registered? Maybe shutting down... */
> +	if (!blk_queue_registered(disk->queue))
> +		return -EAGAIN;
> +
> +	nlat->enabled = true;
> +	memset(nlat->latency, 0, sizeof(u64) * nlat->num);
> +	memset(nlat->samples, 0, sizeof(unsigned int) * nlat->num);
> +	blk_stat_activate_nsecs(nlat->cb, nlat->win_usec * 1000);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(blk_nlat_enable);
> +
> +void blk_nlat_disable(struct gendisk *disk)
> +{
> +	struct rq_qos *rqos = nlat_rq_qos(disk->queue);
> +	struct rq_nlat *nlat;
> +
> +	if (!rqos)
> +		return;
> +	nlat = RQNLAT(rqos);
> +	if (nlat->enabled) {
> +		blk_stat_deactivate(nlat->cb);
> +		nlat->enabled = false;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(blk_nlat_disable);
> +
> +int blk_nlat_init(struct gendisk *disk)
> +{
> +	struct rq_nlat *nlat;
> +	int ret = -ENOMEM;
> +
> +	nlat = kzalloc(sizeof(*nlat), GFP_KERNEL);
> +	if (!nlat)
> +		return -ENOMEM;
> +
> +	nlat->num = num_possible_nodes();
> +	nlat->lowat = NLAT_DEFAULT_LOWAT;
> +	nlat->decay = NLAT_DEFAULT_DECAY;
> +	nlat->win_usec = nlat_default_latency_usec(disk->queue);
> +
> +	nlat->latency = kcalloc(nlat->num, sizeof(u64), GFP_KERNEL);
> +	if (!nlat->latency)
> +		goto err_free;
> +	nlat->samples = kcalloc(nlat->num, sizeof(unsigned int), GFP_KERNEL);
> +	if (!nlat->samples)
> +		goto err_free;
> +	nlat->cb = blk_stat_alloc_callback(nlat_timer_fn, nlat_bucket_node,
> +					   nlat->num, nlat);
> +	if (!nlat->cb)
> +		goto err_free;
> +
> +	/*
> +	 * Assign rwb and add the stats callback.
> +	 */

This can be a single line comment.

> +	mutex_lock(&disk->queue->rq_qos_mutex);
> +	ret = rq_qos_add(&nlat->rqos, disk, RQ_QOS_NLAT, &nlat_rqos_ops);
> +	mutex_unlock(&disk->queue->rq_qos_mutex);
> +	if (ret)
> +		goto err_free_cb;
> +
> +	blk_stat_add_callback(disk->queue, nlat->cb);
> +
> +	return 0;
> +
> +err_free_cb:
> +	blk_stat_free_callback(nlat->cb);
> +err_free:
> +	kfree(nlat->samples);
> +	kfree(nlat->latency);
> +	kfree(nlat);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(blk_nlat_init);
> diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
> index 37245c97ee61..2fc11ced0c00 100644
> --- a/block/blk-rq-qos.h
> +++ b/block/blk-rq-qos.h
> @@ -17,6 +17,7 @@ enum rq_qos_id {
>  	RQ_QOS_WBT,
>  	RQ_QOS_LATENCY,
>  	RQ_QOS_COST,
> +	RQ_QOS_NLAT,
>  };
>  
>  struct rq_wait {
> @@ -79,6 +80,11 @@ static inline struct rq_qos *iolat_rq_qos(struct request_queue *q)
>  	return rq_qos_id(q, RQ_QOS_LATENCY);
>  }
>  
> +static inline struct rq_qos *nlat_rq_qos(struct request_queue *q)
> +{
> +	return rq_qos_id(q, RQ_QOS_NLAT);
> +}
> +
>  static inline void rq_wait_init(struct rq_wait *rq_wait)
>  {
>  	atomic_set(&rq_wait->inflight, 0);
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index d3d8fd8e229b..1f3829627f1b 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -1231,4 +1231,15 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
>  }
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  
> +#ifdef CONFIG_BLK_NODE_LATENCY
> +int blk_nlat_enable(struct gendisk *disk);
> +void blk_nlat_disable(struct gendisk *disk);
> +u64 blk_nlat_latency(struct gendisk *disk, int node);
> +int blk_nlat_init(struct gendisk *disk);
> +#else
> +static inline int blk_nlat_enable(struct gendisk *disk) { return 0; }
> +static inline void blk_nlat_disable(struct gendisk *disk) {}
> +static inline u64 blk_nlat_latency(struct gendisk *disk, int node) { return 0; }
> +static inline int blk_nlat_init(struct gendisk *disk) { return -EOPNOTSUPP; }
> +#endif
>  #endif /* BLK_MQ_H */

-- 
Damien Le Moal
Western Digital Research


