Return-Path: <cgroups+bounces-2893-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E26F8C5AA6
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 19:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612FF1C21C6E
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 17:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E1F181BA1;
	Tue, 14 May 2024 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5lp5U9B"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327F18131D
	for <cgroups@vger.kernel.org>; Tue, 14 May 2024 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709224; cv=none; b=C0hJh90J/f8BVT+VWvak5M+29rL+GEVd6BVQ+I/0uijrAzaUFeNRuIuhfP9/bjNeB2Y3yysJAXMre+F25mdHQBtd+G3DT2/uk9jUJirn9HUwmXt4b7OtRPxnmw4D4b4lq3cussEfsj/hGZt13ERmk8QgWa/NFl0wngVutWtFzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709224; c=relaxed/simple;
	bh=Q7hAj9aWN4FPMfURj721Lexj13X0WDjGnjxEI0jSZ8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=Hup/xB8wDUfWmmDWv+FDimda8vCq7ZPg1vcwxki8pUOt21tTQv9inMZ4pb7TZUF+Cc7L1UWn8FNwUySCSONv+Y0VBiS7DXWw5RxPANbtVfnJrW2HJQt/Cr/QfcbJrkrmEHg8qr5616CwiuwobG6M39hmFM4AWA0P+A6inFcNfQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5lp5U9B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715709221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kumEGQnJWJG7jTUKOQ63w/Usm47ya7G4ljqiH1pkRFg=;
	b=R5lp5U9BB5jwnGMTi19mLgSCyHxO8sH4AZJ1FBsedFCkY3FfgyuZmTHXV2jcZRSKZLyTt5
	Z8FctZD9H7ru+TOE2cc4S2wO5OQ9pCgwqbhVpYeo1FC3rQy3a34EpaolPFAX4IBKwzs1oQ
	IXkhcs4bQ9rLl9qQBAv5kIOSGcRt30Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-LtXqz-vqM1W_RfyGOHnoTA-1; Tue,
 14 May 2024 13:53:34 -0400
X-MC-Unique: LtXqz-vqM1W_RfyGOHnoTA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4983B38000A3;
	Tue, 14 May 2024 17:53:33 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.2.17.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2D843400EAF;
	Tue, 14 May 2024 17:53:32 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com,
	hare@kernel.org
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com
Subject: [PATCH v4 4/6] block: track per-node I/O latency
Date: Tue, 14 May 2024 13:53:20 -0400
Message-Id: <20240514175322.19073-5-jmeneghi@redhat.com>
In-Reply-To: <20240514175322.19073-1-jmeneghi@redhat.com>
References: <20240514175322.19073-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

From: Hannes Reinecke <hare@kernel.org>

Add a new option 'BLK_NODE_LATENCY' to track per-node I/O latency.
This can be used by I/O schedulers to determine the 'best' queue
to send I/O to.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
[jmeneghi: cleaned up checkpatch warnings and updated MAINTAINERS]
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 MAINTAINERS            |   1 +
 block/Kconfig          |   9 +
 block/Makefile         |   1 +
 block/blk-mq-debugfs.c |   2 +
 block/blk-nlatency.c   | 389 +++++++++++++++++++++++++++++++++++++++++
 block/blk-rq-qos.h     |   6 +
 include/linux/blk-mq.h |  11 ++
 7 files changed, 419 insertions(+)
 create mode 100644 block/blk-nlatency.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..a4634365c82f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5405,6 +5405,7 @@ F:	block/bfq-cgroup.c
 F:	block/blk-cgroup.c
 F:	block/blk-iocost.c
 F:	block/blk-iolatency.c
+F:	block/blk-nlatency.c
 F:	block/blk-throttle.c
 F:	include/linux/blk-cgroup.h
 
diff --git a/block/Kconfig b/block/Kconfig
index d47398ae9824..d8edb4506769 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -185,6 +185,15 @@ config BLK_CGROUP_IOPRIO
 	scheduler and block devices process requests. Only some I/O schedulers
 	and some block devices support I/O priorities.
 
+config BLK_NODE_LATENCY
+	bool "Track per-node I/O latency"
+	help
+	Enable per-node I/O latency tracking for multipathing. This uses the
+	blk-nodelat latency tracker to provide latencies for each node, and schedules
+	I/O on the path with the least latency for the submitting node. This can be
+	used by I/O schedulers to determine the node with the least latency. Currently
+	only supports nvme over fabrics devices.
+
 config BLK_DEBUG_FS
 	bool "Block layer debugging information in debugfs"
 	default y
diff --git a/block/Makefile b/block/Makefile
index 168150b9c510..043d979de8fe 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
 obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= blk-ioprio.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
 obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= blk-iocost.o
+obj-$(CONFIG_BLK_NODE_LATENCY) += blk-nlatency.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
 obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
 bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 770c0c2b72fa..bc2541428e81 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -761,6 +761,8 @@ static const char *rq_qos_id_to_name(enum rq_qos_id id)
 		return "latency";
 	case RQ_QOS_COST:
 		return "cost";
+	case RQ_QOS_NLAT:
+		return "node-latency";
 	}
 	return "unknown";
 }
diff --git a/block/blk-nlatency.c b/block/blk-nlatency.c
new file mode 100644
index 000000000000..219c3f636d76
--- /dev/null
+++ b/block/blk-nlatency.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Per-node request latency tracking.
+ *
+ * Copyright (C) 2023 Hannes Reinecke
+ *
+ * A simple per-node latency tracker for use by I/O scheduler.
+ * Latencies are measures over 'win_usec' microseconds and stored per node.
+ * If the number of measurements falls below 'lowat' the measurement is
+ * assumed to be unreliable and will become 'stale'.
+ * These 'stale' latencies can be 'decayed', where during each measurement
+ * interval the 'stale' latency value is decreased by 'decay' percent.
+ * Once the 'stale' latency reaches zero it will be updated by the
+ * measured latency.
+ */
+#include <linux/kernel.h>
+#include <linux/blk_types.h>
+#include <linux/slab.h>
+
+#include "blk-stat.h"
+#include "blk-rq-qos.h"
+#include "blk.h"
+
+#define NLAT_DEFAULT_LOWAT 2
+#define NLAT_DEFAULT_DECAY 50
+
+struct rq_nlat {
+	struct rq_qos rqos;
+
+	u64 win_usec;		/* latency measurement window in microseconds */
+	unsigned int lowat;	/* Low Watermark latency measurement */
+	unsigned int decay;	/* Percentage for 'decaying' latencies */
+	bool enabled;
+
+	struct blk_stat_callback *cb;
+
+	unsigned int num;
+	u64 *latency;
+	unsigned int *samples;
+};
+
+static inline struct rq_nlat *RQNLAT(struct rq_qos *rqos)
+{
+	return container_of(rqos, struct rq_nlat, rqos);
+}
+
+static u64 nlat_default_latency_usec(struct request_queue *q)
+{
+	/*
+	 * We default to 2msec for non-rotational storage, and 75msec
+	 * for rotational storage.
+	 */
+	if (blk_queue_nonrot(q))
+		return 2000ULL;
+	else
+		return 75000ULL;
+}
+
+static void nlat_timer_fn(struct blk_stat_callback *cb)
+{
+	struct rq_nlat *nlat = cb->data;
+	int n;
+
+	for (n = 0; n < cb->buckets; n++) {
+		if (cb->stat[n].nr_samples < nlat->lowat) {
+			/*
+			 * 'decay' the latency by the specified
+			 * percentage to ensure the queues are
+			 * being tested to balance out temporary
+			 * latency spikes.
+			 */
+			nlat->latency[n] =
+				div64_u64(nlat->latency[n] * nlat->decay, 100);
+		} else
+			nlat->latency[n] = cb->stat[n].mean;
+		nlat->samples[n] = cb->stat[n].nr_samples;
+	}
+	if (nlat->enabled)
+		blk_stat_activate_nsecs(nlat->cb, nlat->win_usec * 1000);
+}
+
+static int nlat_bucket_node(const struct request *rq)
+{
+	if (!rq->mq_ctx)
+		return -1;
+	return cpu_to_node(blk_mq_rq_cpu((struct request *)rq));
+}
+
+static void nlat_exit(struct rq_qos *rqos)
+{
+	struct rq_nlat *nlat = RQNLAT(rqos);
+
+	blk_stat_remove_callback(nlat->rqos.disk->queue, nlat->cb);
+	blk_stat_free_callback(nlat->cb);
+	kfree(nlat->samples);
+	kfree(nlat->latency);
+	kfree(nlat);
+}
+
+#ifdef CONFIG_BLK_DEBUG_FS
+static int nlat_win_usec_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+
+	seq_printf(m, "%llu\n", nlat->win_usec);
+	return 0;
+}
+
+static ssize_t nlat_win_usec_write(void *data, const char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+	char val[16] = { };
+	u64 usec;
+	int err;
+
+	if (blk_queue_dying(nlat->rqos.disk->queue))
+		return -ENOENT;
+
+	if (count >= sizeof(val))
+		return -EINVAL;
+
+	if (copy_from_user(val, buf, count))
+		return -EFAULT;
+
+	err = kstrtoull(val, 10, &usec);
+	if (err)
+		return err;
+	blk_stat_deactivate(nlat->cb);
+	nlat->win_usec = usec;
+	blk_stat_activate_nsecs(nlat->cb, nlat->win_usec * 1000);
+
+	return count;
+}
+
+static int nlat_lowat_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+
+	seq_printf(m, "%u\n", nlat->lowat);
+	return 0;
+}
+
+static ssize_t nlat_lowat_write(void *data, const char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+	char val[16] = { };
+	unsigned int lowat;
+	int err;
+
+	if (blk_queue_dying(nlat->rqos.disk->queue))
+		return -ENOENT;
+
+	if (count >= sizeof(val))
+		return -EINVAL;
+
+	if (copy_from_user(val, buf, count))
+		return -EFAULT;
+
+	err = kstrtouint(val, 10, &lowat);
+	if (err)
+		return err;
+	blk_stat_deactivate(nlat->cb);
+	nlat->lowat = lowat;
+	blk_stat_activate_nsecs(nlat->cb, nlat->win_usec * 1000);
+
+	return count;
+}
+
+static int nlat_decay_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+
+	seq_printf(m, "%u\n", nlat->decay);
+	return 0;
+}
+
+static ssize_t nlat_decay_write(void *data, const char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+	char val[16] = { };
+	unsigned int decay;
+	int err;
+
+	if (blk_queue_dying(nlat->rqos.disk->queue))
+		return -ENOENT;
+
+	if (count >= sizeof(val))
+		return -EINVAL;
+
+	if (copy_from_user(val, buf, count))
+		return -EFAULT;
+
+	err = kstrtouint(val, 10, &decay);
+	if (err)
+		return err;
+	if (decay > 100)
+		return -EINVAL;
+	blk_stat_deactivate(nlat->cb);
+	nlat->decay = decay;
+	blk_stat_activate_nsecs(nlat->cb, nlat->win_usec * 1000);
+
+	return count;
+}
+
+static int nlat_enabled_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+
+	seq_printf(m, "%d\n", nlat->enabled);
+	return 0;
+}
+
+static int nlat_id_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+
+	seq_printf(m, "%u\n", rqos->id);
+	return 0;
+}
+
+static int nlat_latency_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+	int n;
+
+	if (!nlat->enabled)
+		return 0;
+
+	for (n = 0; n < nlat->num; n++) {
+		if (n > 0)
+			seq_puts(m, " ");
+		seq_printf(m, "%llu", nlat->latency[n]);
+	}
+	seq_puts(m, "\n");
+	return 0;
+}
+
+static int nlat_samples_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+	int n;
+
+	if (!nlat->enabled)
+		return 0;
+
+	for (n = 0; n < nlat->num; n++) {
+		if (n > 0)
+			seq_puts(m, " ");
+		seq_printf(m, "%u", nlat->samples[n]);
+	}
+	seq_puts(m, "\n");
+	return 0;
+}
+
+static const struct blk_mq_debugfs_attr nlat_debugfs_attrs[] = {
+	{"win_usec", 0600, nlat_win_usec_show, nlat_win_usec_write},
+	{"lowat", 0600, nlat_lowat_show, nlat_lowat_write},
+	{"decay", 0600, nlat_decay_show, nlat_decay_write},
+	{"enabled", 0400, nlat_enabled_show},
+	{"id", 0400, nlat_id_show},
+	{"latency", 0400, nlat_latency_show},
+	{"samples", 0400, nlat_samples_show},
+	{},
+};
+#endif
+
+static const struct rq_qos_ops nlat_rqos_ops = {
+	.exit = nlat_exit,
+#ifdef CONFIG_BLK_DEBUG_FS
+	.debugfs_attrs = nlat_debugfs_attrs,
+#endif
+};
+
+u64 blk_nlat_latency(struct gendisk *disk, int node)
+{
+	struct rq_qos *rqos;
+	struct rq_nlat *nlat;
+
+	rqos = nlat_rq_qos(disk->queue);
+	if (!rqos)
+		return 0;
+	nlat = RQNLAT(rqos);
+	if (node > nlat->num)
+		return 0;
+
+	return div64_u64(nlat->latency[node], 1000);
+}
+EXPORT_SYMBOL_GPL(blk_nlat_latency);
+
+int blk_nlat_enable(struct gendisk *disk)
+{
+	struct rq_qos *rqos;
+	struct rq_nlat *nlat;
+
+	/* Latency tracking not enabled? */
+	rqos = nlat_rq_qos(disk->queue);
+	if (!rqos)
+		return -EINVAL;
+	nlat = RQNLAT(rqos);
+	if (nlat->enabled)
+		return 0;
+
+	/* Queue not registered? Maybe shutting down... */
+	if (!blk_queue_registered(disk->queue))
+		return -EAGAIN;
+
+	nlat->enabled = true;
+	memset(nlat->latency, 0, sizeof(u64) * nlat->num);
+	memset(nlat->samples, 0, sizeof(unsigned int) * nlat->num);
+	blk_stat_activate_nsecs(nlat->cb, nlat->win_usec * 1000);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(blk_nlat_enable);
+
+void blk_nlat_disable(struct gendisk *disk)
+{
+	struct rq_qos *rqos = nlat_rq_qos(disk->queue);
+	struct rq_nlat *nlat;
+
+	if (!rqos)
+		return;
+	nlat = RQNLAT(rqos);
+	if (nlat->enabled) {
+		blk_stat_deactivate(nlat->cb);
+		nlat->enabled = false;
+	}
+}
+EXPORT_SYMBOL_GPL(blk_nlat_disable);
+
+int blk_nlat_init(struct gendisk *disk)
+{
+	struct rq_nlat *nlat;
+	int ret = -ENOMEM;
+
+	nlat = kzalloc(sizeof(*nlat), GFP_KERNEL);
+	if (!nlat)
+		return -ENOMEM;
+
+	nlat->num = num_possible_nodes();
+	nlat->lowat = NLAT_DEFAULT_LOWAT;
+	nlat->decay = NLAT_DEFAULT_DECAY;
+	nlat->win_usec = nlat_default_latency_usec(disk->queue);
+
+	nlat->latency = kcalloc(nlat->num, sizeof(u64), GFP_KERNEL);
+	if (!nlat->latency)
+		goto err_free;
+	nlat->samples = kcalloc(nlat->num, sizeof(unsigned int), GFP_KERNEL);
+	if (!nlat->samples)
+		goto err_free;
+	nlat->cb = blk_stat_alloc_callback(nlat_timer_fn, nlat_bucket_node,
+					   nlat->num, nlat);
+	if (!nlat->cb)
+		goto err_free;
+
+	/*
+	 * Assign rwb and add the stats callback.
+	 */
+	mutex_lock(&disk->queue->rq_qos_mutex);
+	ret = rq_qos_add(&nlat->rqos, disk, RQ_QOS_NLAT, &nlat_rqos_ops);
+	mutex_unlock(&disk->queue->rq_qos_mutex);
+	if (ret)
+		goto err_free_cb;
+
+	blk_stat_add_callback(disk->queue, nlat->cb);
+
+	return 0;
+
+err_free_cb:
+	blk_stat_free_callback(nlat->cb);
+err_free:
+	kfree(nlat->samples);
+	kfree(nlat->latency);
+	kfree(nlat);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blk_nlat_init);
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 37245c97ee61..2fc11ced0c00 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -17,6 +17,7 @@ enum rq_qos_id {
 	RQ_QOS_WBT,
 	RQ_QOS_LATENCY,
 	RQ_QOS_COST,
+	RQ_QOS_NLAT,
 };
 
 struct rq_wait {
@@ -79,6 +80,11 @@ static inline struct rq_qos *iolat_rq_qos(struct request_queue *q)
 	return rq_qos_id(q, RQ_QOS_LATENCY);
 }
 
+static inline struct rq_qos *nlat_rq_qos(struct request_queue *q)
+{
+	return rq_qos_id(q, RQ_QOS_NLAT);
+}
+
 static inline void rq_wait_init(struct rq_wait *rq_wait)
 {
 	atomic_set(&rq_wait->inflight, 0);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 89ba6b16fe8b..925e8c19bedb 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1150,4 +1150,15 @@ static inline int blk_rq_map_sg(struct request_queue *q, struct request *rq,
 }
 void blk_dump_rq_flags(struct request *, char *);
 
+#ifdef CONFIG_BLK_NODE_LATENCY
+int blk_nlat_enable(struct gendisk *disk);
+void blk_nlat_disable(struct gendisk *disk);
+u64 blk_nlat_latency(struct gendisk *disk, int node);
+int blk_nlat_init(struct gendisk *disk);
+#else
+static inline int blk_nlat_enable(struct gendisk *disk) { return 0; }
+static inline void blk_nlat_disable(struct gendisk *disk) {}
+static inline u64 blk_nlat_latency(struct gendisk *disk, int node) { return 0; }
+static inline int blk_nlat_init(struct gendisk *disk) { return -EOPNOTSUPP; }
+#endif
 #endif /* BLK_MQ_H */
-- 
2.39.3


