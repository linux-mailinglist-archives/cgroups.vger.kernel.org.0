Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5037D50DF6
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2019 16:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfFXO3J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jun 2019 10:29:09 -0400
Received: from mx1.didichuxing.com ([111.202.154.82]:12970 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1726749AbfFXO3J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jun 2019 10:29:09 -0400
X-ASG-Debug-ID: 1561386547-0e40886efb18f3b0001-hhPYk8
Received: from BJEXCAS05.didichuxing.com (bogon [172.20.36.127]) by bsf01.didichuxing.com with ESMTP id QZ9Rl3n5RC25VWHP; Mon, 24 Jun 2019 22:29:07 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 22:29:06 +0800
Date:   Mon, 24 Jun 2019 22:29:05 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>, <hch@lst.de>,
        <bvanassche@acm.org>, <keith.busch@intel.com>,
        <minwoo.im.dev@gmail.com>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
Subject: [PATCH v3 2/5] nvme: add get_ams for nvme_ctrl_ops
Message-ID: <2c916063e19cc3f33376d7bb0fb8a5ff10ea42db.1561385989.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v3 2/5] nvme: add get_ams for nvme_ctrl_ops
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
X-Barracuda-Connect: bogon[172.20.36.127]
X-Barracuda-Start-Time: 1561386547
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 3241
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.73067
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The get_ams() will return the AMS(Arbitration Mechanism Selected)
from the driver.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 drivers/nvme/host/core.c | 9 ++++++++-
 drivers/nvme/host/nvme.h | 1 +
 drivers/nvme/host/pci.c  | 6 ++++++
 include/linux/nvme.h     | 1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b2dd4e391f5c..4cb781e73123 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1943,6 +1943,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
 	 */
 	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12, page_shift = 12;
 	int ret;
+	u32 ams = NVME_CC_AMS_RR;
 
 	if (page_shift < dev_page_min) {
 		dev_err(ctrl->device,
@@ -1951,11 +1952,17 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
 		return -ENODEV;
 	}
 
+	/* get Arbitration Mechanism Selected */
+	if (ctrl->ops->get_ams) {
+		ctrl->ops->get_ams(ctrl, &ams);
+		ams &= NVME_CC_AMS_MASK;
+	}
+
 	ctrl->page_size = 1 << page_shift;
 
 	ctrl->ctrl_config = NVME_CC_CSS_NVM;
 	ctrl->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
-	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
+	ctrl->ctrl_config |= ams | NVME_CC_SHN_NONE;
 	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ea45d7d393ad..9c7e9217f78b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -369,6 +369,7 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
+	void (*get_ams)(struct nvme_ctrl *ctrl, u32 *ams);
 };
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 189352081994..5d84241f0214 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2627,6 +2627,11 @@ static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 	return snprintf(buf, size, "%s", dev_name(&pdev->dev));
 }
 
+static void nvme_pci_get_ams(struct nvme_ctrl *ctrl, u32 *ams)
+{
+	*ams = NVME_CC_AMS_RR;
+}
+
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
@@ -2638,6 +2643,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.free_ctrl		= nvme_pci_free_ctrl,
 	.submit_async_event	= nvme_pci_submit_async_event,
 	.get_address		= nvme_pci_get_address,
+	.get_ams		= nvme_pci_get_ams,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index da5f696aec00..8f71451fc2fa 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -156,6 +156,7 @@ enum {
 	NVME_CC_AMS_RR		= 0 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_WRRU	= 1 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_VS		= 7 << NVME_CC_AMS_SHIFT,
+	NVME_CC_AMS_MASK	= 7 << NVME_CC_AMS_SHIFT,
 	NVME_CC_SHN_NONE	= 0 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_NORMAL	= 1 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_ABRUPT	= 2 << NVME_CC_SHN_SHIFT,
-- 
2.14.1

