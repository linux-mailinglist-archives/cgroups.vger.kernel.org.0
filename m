Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBE24742E
	for <lists+cgroups@lfdr.de>; Sun, 16 Jun 2019 12:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfFPKQB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 16 Jun 2019 06:16:01 -0400
Received: from mx2.didichuxing.com ([36.110.17.22]:21516 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1725957AbfFPKQB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 16 Jun 2019 06:16:01 -0400
X-ASG-Debug-ID: 1560680158-0e408815c54ee7f0001-hhPYk8
Received: from BJEXCAS03.didichuxing.com (bogon [172.20.36.245]) by bsf01.didichuxing.com with ESMTP id 4a9xkZurduUrpmdc; Sun, 16 Jun 2019 18:15:58 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 16 Jun
 2019 18:15:57 +0800
Date:   Sun, 16 Jun 2019 18:15:56 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>, <hch@lst.de>,
        <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: [PATCH v2 4/4] nvme: add support weighted round robin queue
Message-ID: <0b0fa12a337f97a8cc878b58673b3eb619539174.1560679439.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v2 4/4] nvme: add support weighted round robin queue
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        bvanassche@acm.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
References: <cover.1560679439.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1560679439.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.245]
X-Barracuda-Start-Time: 1560680158
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 10633
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.72767
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Now nvme support five types hardware queue:
poll:		if io was marked for poll
wrr_low:	weighted round robin low
wrr_medium:	weighted round robin medium
wrr_high:	weighted round robin high
read:		for read, if blkcg's wrr is none and is not poll
defaut:		for write/flush, if blkcg's wrr is none and is not poll

for read, default and poll those submission queue's priority is medium by default;

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 drivers/nvme/host/pci.c   | 195 +++++++++++++++++++++++++++++++++-------------
 include/linux/interrupt.h |   2 +-
 2 files changed, 144 insertions(+), 53 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f562154551ce..ee9f3239f3e7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -73,16 +73,28 @@ static const struct kernel_param_ops queue_count_ops = {
 	.get = param_get_int,
 };
 
-static int write_queues;
-module_param_cb(write_queues, &queue_count_ops, &write_queues, 0644);
-MODULE_PARM_DESC(write_queues,
-	"Number of queues to use for writes. If not set, reads and writes "
+static int read_queues;
+module_param_cb(read_queues, &queue_count_ops, &read_queues, 0644);
+MODULE_PARM_DESC(read_queues,
+	"Number of queues to use for reads. If not set, reads and writes "
 	"will share a queue set.");
 
 static int poll_queues = 0;
 module_param_cb(poll_queues, &queue_count_ops, &poll_queues, 0644);
 MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
 
+static int wrr_high_queues = 0;
+module_param_cb(wrr_high_queues, &queue_count_ops, &wrr_high_queues, 0644);
+MODULE_PARM_DESC(wrr_high_queues, "Number of queues to use for WRR high.");
+
+static int wrr_medium_queues = 0;
+module_param_cb(wrr_medium_queues, &queue_count_ops, &wrr_medium_queues, 0644);
+MODULE_PARM_DESC(wrr_medium_queues, "Number of queues to use for WRR medium.");
+
+static int wrr_low_queues = 0;
+module_param_cb(wrr_low_queues, &queue_count_ops, &wrr_low_queues, 0644);
+MODULE_PARM_DESC(wrr_low_queues, "Number of queues to use for WRR low.");
+
 struct nvme_dev;
 struct nvme_queue;
 
@@ -226,9 +238,17 @@ struct nvme_iod {
 	struct scatterlist *sg;
 };
 
+static inline bool nvme_is_enable_wrr(struct nvme_dev *dev)
+{
+	return dev->io_queues[HCTX_TYPE_WRR_LOW] +
+		dev->io_queues[HCTX_TYPE_WRR_MEDIUM] +
+		dev->io_queues[HCTX_TYPE_WRR_HIGH] > 0;
+}
+
 static unsigned int max_io_queues(void)
 {
-	return num_possible_cpus() + write_queues + poll_queues;
+	return num_possible_cpus() + read_queues + poll_queues +
+		wrr_high_queues + wrr_medium_queues + wrr_low_queues;
 }
 
 static unsigned int max_queue_count(void)
@@ -1156,19 +1176,23 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 }
 
 static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
-						struct nvme_queue *nvmeq)
+					struct nvme_queue *nvmeq, int wrr)
 {
 	struct nvme_ctrl *ctrl = &dev->ctrl;
 	struct nvme_command c;
 	int flags = NVME_QUEUE_PHYS_CONTIG;
 
-	/*
-	 * Some drives have a bug that auto-enables WRRU if MEDIUM isn't
-	 * set. Since URGENT priority is zeroes, it makes all queues
-	 * URGENT.
-	 */
-	if (ctrl->quirks & NVME_QUIRK_MEDIUM_PRIO_SQ)
-		flags |= NVME_SQ_PRIO_MEDIUM;
+	if (!nvme_is_enable_wrr(dev)) {
+		/*
+		 * Some drives have a bug that auto-enables WRRU if MEDIUM isn't
+		 * set. Since URGENT priority is zeroes, it makes all queues
+		 * URGENT.
+		 */
+		if (ctrl->quirks & NVME_QUIRK_MEDIUM_PRIO_SQ)
+			flags |= NVME_SQ_PRIO_MEDIUM;
+	} else {
+		flags |= wrr;
+	}
 
 	/*
 	 * Note: we (ab)use the fact that the prp fields survive if no data
@@ -1534,11 +1558,46 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	wmb(); /* ensure the first interrupt sees the initialization */
 }
 
-static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
+static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
-	int result;
+	int start, end, result, wrr;
+	bool polled = false;
 	u16 vector = 0;
+	enum hctx_type type;
+
+	/* 0 for admain queue, io queue index >= 1 */
+	start = 1;
+	/* get hardware context type base on qid */
+	for (type = HCTX_TYPE_DEFAULT; type < HCTX_MAX_TYPES; type++) {
+		end = start + dev->io_queues[type] - 1;
+		if (qid >= start && qid <= end)
+			break;
+		start = end + 1;
+	}
+
+	if (nvme_is_enable_wrr(dev)) {
+		/* set read,poll,default to medium by default */
+		switch (type) {
+		case HCTX_TYPE_POLL:
+			polled = true;
+		case HCTX_TYPE_DEFAULT:
+		case HCTX_TYPE_READ:
+		case HCTX_TYPE_WRR_MEDIUM:
+			wrr = NVME_SQ_PRIO_MEDIUM;
+			break;
+		case HCTX_TYPE_WRR_LOW:
+			wrr = NVME_SQ_PRIO_LOW;
+			break;
+		case HCTX_TYPE_WRR_HIGH:
+			wrr = NVME_SQ_PRIO_HIGH;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		wrr = 0;
+	}
 
 	clear_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
 
@@ -1555,7 +1614,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	if (result)
 		return result;
 
-	result = adapter_alloc_sq(dev, qid, nvmeq);
+	result = adapter_alloc_sq(dev, qid, nvmeq, wrr);
 	if (result < 0)
 		return result;
 	else if (result)
@@ -1726,7 +1785,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 
 static int nvme_create_io_queues(struct nvme_dev *dev)
 {
-	unsigned i, max, rw_queues;
+	unsigned i, max;
 	int ret = 0;
 
 	for (i = dev->ctrl.queue_count; i <= dev->max_qid; i++) {
@@ -1737,17 +1796,9 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	}
 
 	max = min(dev->max_qid, dev->ctrl.queue_count - 1);
-	if (max != 1 && dev->io_queues[HCTX_TYPE_POLL]) {
-		rw_queues = dev->io_queues[HCTX_TYPE_DEFAULT] +
-				dev->io_queues[HCTX_TYPE_READ];
-	} else {
-		rw_queues = max;
-	}
 
 	for (i = dev->online_queues; i <= max; i++) {
-		bool polled = i > rw_queues;
-
-		ret = nvme_create_queue(&dev->queues[i], i, polled);
+		ret = nvme_create_queue(&dev->queues[i], i);
 		if (ret)
 			break;
 	}
@@ -2028,35 +2079,73 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
 {
 	struct nvme_dev *dev = affd->priv;
-	unsigned int nr_read_queues;
+	unsigned int nr_total, nr, nr_read, nr_default;
+	unsigned int nr_wrr_high, nr_wrr_medium, nr_wrr_low;
+	unsigned int nr_sets;
 
 	/*
 	 * If there is no interupt available for queues, ensure that
 	 * the default queue is set to 1. The affinity set size is
 	 * also set to one, but the irq core ignores it for this case.
-	 *
-	 * If only one interrupt is available or 'write_queue' == 0, combine
-	 * write and read queues.
-	 *
-	 * If 'write_queues' > 0, ensure it leaves room for at least one read
-	 * queue.
 	 */
-	if (!nrirqs) {
+	if (!nrirqs)
 		nrirqs = 1;
-		nr_read_queues = 0;
-	} else if (nrirqs == 1 || !write_queues) {
-		nr_read_queues = 0;
-	} else if (write_queues >= nrirqs) {
-		nr_read_queues = 1;
-	} else {
-		nr_read_queues = nrirqs - write_queues;
-	}
 
-	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
-	affd->set_size[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
-	dev->io_queues[HCTX_TYPE_READ] = nr_read_queues;
-	affd->set_size[HCTX_TYPE_READ] = nr_read_queues;
-	affd->nr_sets = nr_read_queues ? 2 : 1;
+	nr_total = nrirqs;
+
+	nr_read = nr_wrr_high = nr_wrr_medium = nr_wrr_low = 0;
+
+	/* set default to 1, add all the rest queue to default at last */
+	nr = nr_default = 1;
+	nr_sets = 1;
+
+	nr_total -= nr;
+	if (!nr_total)
+		goto done;
+
+	/* read queues */
+	nr_sets++;
+	nr_read = nr = read_queues > nr_total ? nr_total : read_queues;
+	nr_total -= nr;
+	if (!nr_total)
+		goto done;
+
+	/* wrr low queues */
+	nr_sets++;
+	nr_wrr_low = nr = wrr_low_queues > nr_total ? nr_total : wrr_low_queues;
+	nr_total -= nr;
+	if (!nr_total)
+		goto done;
+
+	/* wrr medium queues */
+	nr_sets++;
+	nr_wrr_medium = nr = wrr_medium_queues > nr_total ? nr_total : wrr_medium_queues;
+	nr_total -= nr;
+	if (!nr_total)
+		goto done;
+
+	/* wrr high queues */
+	nr_sets++;
+	nr_wrr_high = nr = wrr_high_queues > nr_total ? nr_total : wrr_high_queues;
+	nr_total -= nr;
+	if (!nr_total)
+		goto done;
+
+	/* set all the rest queue to default */
+	nr_default += nr_total;
+
+done:
+	dev->io_queues[HCTX_TYPE_DEFAULT] = nr_default;
+	affd->set_size[HCTX_TYPE_DEFAULT] = nr_default;
+	dev->io_queues[HCTX_TYPE_READ] = nr_read;
+	affd->set_size[HCTX_TYPE_READ] = nr_read;
+	dev->io_queues[HCTX_TYPE_WRR_LOW] = nr_wrr_low;
+	affd->set_size[HCTX_TYPE_WRR_LOW] = nr_wrr_low;
+	dev->io_queues[HCTX_TYPE_WRR_MEDIUM] = nr_wrr_medium;
+	affd->set_size[HCTX_TYPE_WRR_MEDIUM] = nr_wrr_medium;
+	dev->io_queues[HCTX_TYPE_WRR_HIGH] = nr_wrr_high;
+	affd->set_size[HCTX_TYPE_WRR_HIGH] = nr_wrr_high;
+	affd->nr_sets = nr_sets;
 }
 
 static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
@@ -2171,10 +2260,14 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		nvme_suspend_io_queues(dev);
 		goto retry;
 	}
-	dev_info(dev->ctrl.device, "%d/%d/%d default/read/poll queues\n",
+	dev_info(dev->ctrl.device, "%d/%d/%d/%d/%d/%d "
+			"default/read/poll/wrr_low/wrr_medium/wrr_high queues\n",
 					dev->io_queues[HCTX_TYPE_DEFAULT],
 					dev->io_queues[HCTX_TYPE_READ],
-					dev->io_queues[HCTX_TYPE_POLL]);
+					dev->io_queues[HCTX_TYPE_POLL],
+					dev->io_queues[HCTX_TYPE_WRR_LOW],
+					dev->io_queues[HCTX_TYPE_WRR_MEDIUM],
+					dev->io_queues[HCTX_TYPE_WRR_HIGH]);
 	return 0;
 }
 
@@ -2263,9 +2356,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	if (!dev->ctrl.tagset) {
 		dev->tagset.ops = &nvme_mq_ops;
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
-		dev->tagset.nr_maps = 2; /* default + read */
-		if (dev->io_queues[HCTX_TYPE_POLL])
-			dev->tagset.nr_maps++;
+		dev->tagset.nr_maps = HCTX_MAX_TYPES;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
 		dev->tagset.numa_node = dev_to_node(dev->dev);
 		dev->tagset.queue_depth =
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c7eef32e7739..ea726c2f95cc 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -259,7 +259,7 @@ struct irq_affinity_notify {
 	void (*release)(struct kref *ref);
 };
 
-#define	IRQ_AFFINITY_MAX_SETS  4
+#define	IRQ_AFFINITY_MAX_SETS  7
 
 /**
  * struct irq_affinity - Description for automatic irq affinity assignements
-- 
2.14.1

