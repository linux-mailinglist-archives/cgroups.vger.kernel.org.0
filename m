Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA8DE50E04
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2019 16:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfFXO36 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jun 2019 10:29:58 -0400
Received: from mx1.didichuxing.com ([111.202.154.82]:9659 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1728564AbfFXO34 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jun 2019 10:29:56 -0400
X-ASG-Debug-ID: 1561386591-0e41086a0a178680001-hhPYk8
Received: from BJEXCAS001.didichuxing.com (bjexcas001.didichuxing.com [172.20.1.41]) by bsf02.didichuxing.com with ESMTP id vrgBafSzQtjI9WBK; Mon, 24 Jun 2019 22:29:51 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 22:29:51 +0800
Date:   Mon, 24 Jun 2019 22:29:50 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>, <hch@lst.de>,
        <bvanassche@acm.org>, <keith.busch@intel.com>,
        <minwoo.im.dev@gmail.com>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
Subject: [PATCH v3 5/5] nvme: add support weighted round robin queue
Message-ID: <6e3b0f511a291dd0ce570a6cc5393e10d4509d0e.1561385989.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v3 5/5] nvme: add support weighted round robin queue
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        bvanassche@acm.org, keith.busch@intel.com, minwoo.im.dev@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1561385989.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bjexcas001.didichuxing.com[172.20.1.41]
X-Barracuda-Start-Time: 1561386591
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 16052
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0039 1.0000 -1.9955
X-Barracuda-Spam-Score: -2.00
X-Barracuda-Spam-Status: No, SCORE=-2.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.73067
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch enalbe Weithed Round Robin if nvme device support it.
We add four module parameters wrr_urgent_queues, wrr_high_queeus,
wrr_medium_queues, wrr_low_queues to control the number of queues for
specified priority. If device doesn't support WRR, all these four
parameters will be forced reset to 0. If device support WRR, but
all of these four parameters are 0, nvme dirver will not enable WRR
when set CC.EN to 1.

Now nvme support five types hardware queue:
poll:		if io was marked for poll
wrr_low:	weighted round robin low
wrr_medium:	weighted round robin medium
wrr_high:	weighted round robin high
wrr_urgent:	weighted round robin urgent
read:		io read, if blkcg's wrr is none and the io is not poll
defaut:		for write/flush, if blkcg's wrr is none and is not poll

The read, default and poll submission queue's priority is medium, when
nvme's wrr was enabled.

Test result:

CPU:    Intel(R) Xeon(R) Platinum 8160 CPU @ 2.10GHz
NVME:   Intel SSDPE2KX020T8 P4510 2TB

[root@tmp-201812-d1802-818396173 low]# nvme show-regs /dev/nvme0n1
cap     : 2078030fff
version : 10200
intms   : 0
intmc   : 0
cc      : 460801
csts    : 1
nssr    : 0
aqa     : 1f001f
asq     : 5f7cc08000
acq     : 5f5ac23000
cmbloc  : 0
cmbsz   : 0

Run fio-1, fio-2, fio-3 in parallel,

For RR(round robin) these three fio nearly get same iops or bps,
if we set blkio.wrr for different priority, the WRR "high" will
get more iops/bps than "medium" and "low".

RR:
fio-1: echo "259:0 none" > /sys/fs/cgroup/blkio/high/blkio.wrr
fio-2: echo "259:0 none" > /sys/fs/cgroup/blkio/medium/blkio.wrr
fio-3: echo "259:0 none" > /sys/fs/cgroup/blkio/low/blkio.wrr

WRR:
fio-1: echo "259:0 high" > /sys/fs/cgroup/blkio/high/blkio.wrr
fio-2: echo "259:0 medium" > /sys/fs/cgroup/blkio/medium/blkio.wrr
fio-3: echo "259:0 low" > /sys/fs/cgroup/blkio/low/blkio.wrr

rwtest=randread
fio --bs=4k --ioengine=libaio --iodepth=32 --filename=/dev/nvme0n1 \
--direct=1 --runtime=60 --numjobs=8 --rw=$rwtest --name=test \
--group_reporting

Randread 4K     RR              WRR
-------------------------------------------------------
fio-1:          220 k           395 k
fio-2:          220 k           197 k
fio-3:          220 k           66  k

rwtest=randwrite
fio --bs=4k --ioengine=libaio --iodepth=32 --filename=/dev/nvme0n1 \
--direct=1 --runtime=60 --numjobs=8 --rw=$rwtest --name=test \
--group_reporting

Randwrite 4K    RR              WRR
-------------------------------------------------------
fio-1:          150 k           295 k
fio-2:          150 k           148 k
fio-3:          150 k           51  k

rwtest=read
fio --bs=512k --ioengine=libaio --iodepth=32 --filename=/dev/nvme0n1 \
--direct=1 --runtime=60 --numjobs=8 --rw=$rwtest --name=test \
--group_reporting

read 512K       RR              WRR
-------------------------------------------------------
fio-1:          963 MiB/s       1704 MiB/s
fio-2:          950 MiB/s       850  MiB/s
fio-3:          961 MiB/s       284  MiB/s

rwtest=read
fio --bs=512k --ioengine=libaio --iodepth=32 --filename=/dev/nvme0n1 \
--direct=1 --runtime=60 --numjobs=8 --rw=$rwtest --name=test \
--group_reporting

write 512K      RR              WRR
-------------------------------------------------------
fio-1:          890 MiB/s       1150 MiB/s
fio-2:          871 MiB/s       595  MiB/s
fio-3:          895 MiB/s       188  MiB/s

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 drivers/nvme/host/nvme.h  |   1 +
 drivers/nvme/host/pci.c   | 228 ++++++++++++++++++++++++++++++++++++++--------
 include/linux/interrupt.h |   2 +-
 include/linux/nvme.h      |   2 +
 4 files changed, 192 insertions(+), 41 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9c7e9217f78b..2960d3bfa9bf 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -212,6 +212,7 @@ struct nvme_ctrl {
 	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;
+	bool wrr_enabled;
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
 	struct nvme_effects_log *effects;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a3c9bb72d90e..d4aaa4e87312 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -78,6 +78,22 @@ static int poll_queues;
 module_param(poll_queues, int, 0644);
 MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
 
+static int wrr_low_queues;
+module_param(wrr_low_queues, int, 0644);
+MODULE_PARM_DESC(wrr_low_queues, "Number of WRR low queues.");
+
+static int wrr_medium_queues;
+module_param(wrr_medium_queues, int, 0644);
+MODULE_PARM_DESC(wrr_medium_queues, "Number of WRR medium queues.");
+
+static int wrr_high_queues;
+module_param(wrr_high_queues, int, 0644);
+MODULE_PARM_DESC(wrr_high_queues, "Number of WRR high queues.");
+
+static int wrr_urgent_queues;
+module_param(wrr_urgent_queues, int, 0644);
+MODULE_PARM_DESC(wrr_urgent_queues, "Number of WRR urgent queues.");
+
 struct nvme_dev;
 struct nvme_queue;
 
@@ -209,6 +225,14 @@ struct nvme_iod {
 	struct scatterlist *sg;
 };
 
+static inline bool nvme_is_wrr_allocated(struct nvme_dev *dev)
+{
+	return dev->io_queues[HCTX_TYPE_WRR_LOW] +
+		dev->io_queues[HCTX_TYPE_WRR_MEDIUM] +
+		dev->io_queues[HCTX_TYPE_WRR_HIGH] +
+		dev->io_queues[HCTX_TYPE_WRR_URGENT] > 0;
+}
+
 static unsigned int max_io_queues(void)
 {
 	return num_possible_cpus() + read_queues + poll_queues;
@@ -1139,19 +1163,23 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 }
 
 static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
-						struct nvme_queue *nvmeq)
+					struct nvme_queue *nvmeq, int wrr_flag)
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
+	if (!dev->ctrl.wrr_enabled && !nvme_is_wrr_allocated(dev)) {
+		/*
+		 * Some drives have a bug that auto-enables WRRU if MEDIUM isn't
+		 * set. Since URGENT priority is zeroes, it makes all queues
+		 * URGENT.
+		 */
+		if (ctrl->quirks & NVME_QUIRK_MEDIUM_PRIO_SQ)
+			flags |= NVME_SQ_PRIO_MEDIUM;
+	} else {
+		flags |= wrr_flag;
+	}
 
 	/*
 	 * Note: we (ab)use the fact that the prp fields survive if no data
@@ -1517,11 +1545,51 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	wmb(); /* ensure the first interrupt sees the initialization */
 }
 
-static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
+static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
-	int result;
+	int start, end, result, wrr_flag;
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
+	if (type == HCTX_TYPE_POLL)
+		polled = true;
+
+	if (dev->ctrl.wrr_enabled && nvme_is_wrr_allocated(dev)) {
+		/* set read,poll,default to medium by default */
+		switch (type) {
+		case HCTX_TYPE_WRR_LOW:
+			wrr_flag = NVME_SQ_PRIO_LOW;
+			break;
+		case HCTX_TYPE_WRR_MEDIUM:
+		case HCTX_TYPE_POLL:
+		case HCTX_TYPE_DEFAULT:
+		case HCTX_TYPE_READ:
+			wrr_flag = NVME_SQ_PRIO_MEDIUM;
+			break;
+		case HCTX_TYPE_WRR_HIGH:
+			wrr_flag = NVME_SQ_PRIO_HIGH;
+			break;
+		case HCTX_TYPE_WRR_URGENT:
+			wrr_flag = NVME_SQ_PRIO_URGENT;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		wrr_flag = NVME_SQ_PRIO_IGNORE;
+	}
 
 	clear_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
 
@@ -1538,7 +1606,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	if (result)
 		return result;
 
-	result = adapter_alloc_sq(dev, qid, nvmeq);
+	result = adapter_alloc_sq(dev, qid, nvmeq, wrr_flag);
 	if (result < 0)
 		return result;
 	else if (result)
@@ -1709,7 +1777,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 
 static int nvme_create_io_queues(struct nvme_dev *dev)
 {
-	unsigned i, max, rw_queues;
+	unsigned i, max;
 	int ret = 0;
 
 	for (i = dev->ctrl.queue_count; i <= dev->max_qid; i++) {
@@ -1720,17 +1788,9 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
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
@@ -2011,7 +2071,10 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
 {
 	struct nvme_dev *dev = affd->priv;
-	unsigned int nr_read_queues;
+	unsigned int nr_total, nr, nr_read, nr_default;
+	unsigned int nr_wrr_urgent, nr_wrr_high, nr_wrr_medium, nr_wrr_low;
+	unsigned int nr_sets;
+
 
 	/*
 	 * If there is no interupt available for queues, ensure that
@@ -2024,20 +2087,75 @@ static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
 	 * If 'read_queues' > 0, ensure it leaves room for at least one write
 	 * queue.
 	 */
-	if (!nrirqs || nrirqs == 1) {
+	if (!nrirqs)
 		nrirqs = 1;
-		nr_read_queues = 0;
-	} else if (read_queues >= nrirqs) {
-		nr_read_queues = nrirqs - 1;
-	} else {
-		nr_read_queues = read_queues;
-	}
 
-	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
-	affd->set_size[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
-	dev->io_queues[HCTX_TYPE_READ] = nr_read_queues;
-	affd->set_size[HCTX_TYPE_READ] = nr_read_queues;
-	affd->nr_sets = nr_read_queues ? 2 : 1;
+	nr_total = nrirqs;
+
+	nr_read = nr_wrr_urgent = nr_wrr_high = nr_wrr_medium = nr_wrr_low = 0;
+
+	/* set default to 1, add all the rest queue to default at last */
+	nr = nr_default = 1;
+	nr_sets = 1;
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
+	nr_wrr_medium = nr =
+		wrr_medium_queues > nr_total ? nr_total : wrr_medium_queues;
+	nr_total -= nr;
+	if (!nr_total)
+		goto done;
+
+	/* wrr high queues */
+	nr_sets++;
+	nr_wrr_high = nr =
+		wrr_high_queues > nr_total ? nr_total : wrr_high_queues;
+	nr_total -= nr;
+	if (!nr_total)
+		goto done;
+
+	/* wrr urgent queues */
+	nr_sets++;
+	nr_wrr_urgent = nr =
+		wrr_urgent_queues > nr_total ? nr_total : wrr_urgent_queues;
+	nr_total -= nr;
+	if (!nr_total)
+		goto done;
+
+	/* add all the rest queue to default */
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
+	dev->io_queues[HCTX_TYPE_WRR_URGENT] = nr_wrr_urgent;
+	affd->set_size[HCTX_TYPE_WRR_URGENT] = nr_wrr_urgent;
+	affd->nr_sets = nr_sets;
 }
 
 static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
@@ -2070,6 +2188,10 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	/* Initialize for the single interrupt case */
 	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
 	dev->io_queues[HCTX_TYPE_READ] = 0;
+	dev->io_queues[HCTX_TYPE_WRR_LOW] = 0;
+	dev->io_queues[HCTX_TYPE_WRR_MEDIUM] = 0;
+	dev->io_queues[HCTX_TYPE_WRR_HIGH] = 0;
+	dev->io_queues[HCTX_TYPE_WRR_URGENT] = 0;
 
 	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
 			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
@@ -2156,10 +2278,15 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		nvme_suspend_io_queues(dev);
 		goto retry;
 	}
-	dev_info(dev->ctrl.device, "%d/%d/%d default/read/poll queues\n",
+	dev_info(dev->ctrl.device, "%d/%d/%d/%d/%d/%d/%d "
+			"default/read/poll/low/medium/high/urgent queues\n",
 					dev->io_queues[HCTX_TYPE_DEFAULT],
 					dev->io_queues[HCTX_TYPE_READ],
-					dev->io_queues[HCTX_TYPE_POLL]);
+					dev->io_queues[HCTX_TYPE_POLL],
+					dev->io_queues[HCTX_TYPE_WRR_LOW],
+					dev->io_queues[HCTX_TYPE_WRR_MEDIUM],
+					dev->io_queues[HCTX_TYPE_WRR_HIGH],
+					dev->io_queues[HCTX_TYPE_WRR_URGENT]);
 	return 0;
 }
 
@@ -2248,9 +2375,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
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
@@ -2627,7 +2752,30 @@ static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 
 static void nvme_pci_get_ams(struct nvme_ctrl *ctrl, u32 *ams)
 {
-	*ams = NVME_CC_AMS_RR;
+	/* if deivce doesn't support WRR, force reset wrr queues to 0 */
+	if (!NVME_CAP_AMS_WRRU(ctrl->cap)) {
+		wrr_low_queues = 0;
+		wrr_medium_queues = 0;
+		wrr_high_queues = 0;
+		wrr_urgent_queues = 0;
+
+		*ams = NVME_CC_AMS_RR;
+		ctrl->wrr_enabled = false;
+		return;
+	}
+
+	/*
+	 * if device support WRR, check wrr queue count, all wrr queues are
+	 * 0, don't enable device's WRR.
+	 */
+	if ((wrr_low_queues + wrr_medium_queues + wrr_high_queues +
+				wrr_urgent_queues) > 0) {
+		*ams = NVME_CC_AMS_WRRU;
+		ctrl->wrr_enabled = true;
+	} else {
+		*ams = NVME_CC_AMS_RR;
+		ctrl->wrr_enabled = false;
+	}
 }
 
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
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
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 8f71451fc2fa..59b91a38d323 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -113,6 +113,7 @@ enum {
 };
 
 #define NVME_CAP_MQES(cap)	((cap) & 0xffff)
+#define NVME_CAP_AMS_WRRU(cap)	((cap) & (1 << 17))
 #define NVME_CAP_TIMEOUT(cap)	(((cap) >> 24) & 0xff)
 #define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
 #define NVME_CAP_NSSRC(cap)	(((cap) >> 36) & 0x1)
@@ -844,6 +845,7 @@ enum {
 	NVME_SQ_PRIO_HIGH	= (1 << 1),
 	NVME_SQ_PRIO_MEDIUM	= (2 << 1),
 	NVME_SQ_PRIO_LOW	= (3 << 1),
+	NVME_SQ_PRIO_IGNORE	= NVME_SQ_PRIO_URGENT,
 	NVME_FEAT_ARBITRATION	= 0x01,
 	NVME_FEAT_POWER_MGMT	= 0x02,
 	NVME_FEAT_LBA_RANGE	= 0x03,
-- 
2.14.1

