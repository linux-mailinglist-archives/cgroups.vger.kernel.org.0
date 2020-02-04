Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0757A15149F
	for <lists+cgroups@lfdr.de>; Tue,  4 Feb 2020 04:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBDDb3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Feb 2020 22:31:29 -0500
Received: from mx2.didiglobal.com ([111.202.154.82]:18500 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1726984AbgBDDb3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Feb 2020 22:31:29 -0500
X-ASG-Debug-ID: 1580787085-0e41082815a90740001-hhPYk8
Received: from mail.didiglobal.com (localhost [172.20.36.203]) by bsf02.didichuxing.com with ESMTP id rF6RfuAHUpzw13RK; Tue, 04 Feb 2020 11:31:25 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 11:31:24 +0800
Date:   Tue, 4 Feb 2020 11:31:18 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>, <hch@lst.de>,
        <bvanassche@acm.org>, <kbusch@kernel.org>,
        <minwoo.im.dev@gmail.com>, <tglx@linutronix.de>,
        <ming.lei@redhat.com>, <edmund.nadolski@intel.com>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
Subject: [PATCH v5 2/4] nvme: add get_ams for nvme_ctrl_ops
Message-ID: <7295788131026077d5dcd004763571bc506df3cb.1580786525.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v5 2/4] nvme: add get_ams for nvme_ctrl_ops
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        bvanassche@acm.org, kbusch@kernel.org, minwoo.im.dev@gmail.com,
        tglx@linutronix.de, ming.lei@redhat.com, edmund.nadolski@intel.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1580786525.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS02.didichuxing.com (172.20.36.211) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.203]
X-Barracuda-Start-Time: 1580787085
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 3211
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.79763
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
index 6ec03507da68..2275f1756369 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2119,6 +2119,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	 */
 	unsigned dev_page_min, page_shift = 12;
 	int ret;
+	u32 ams = NVME_CC_AMS_RR;
 
 	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
 	if (ret) {
@@ -2134,11 +2135,17 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
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
index 1024fec7914c..a1df74f2eed3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -407,6 +407,7 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
+	void (*get_ams)(struct nvme_ctrl *ctrl, u32 *ams);
 };
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 445c2ee2a01d..e460c7310187 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2688,6 +2688,11 @@ static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
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
@@ -2699,6 +2704,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.free_ctrl		= nvme_pci_free_ctrl,
 	.submit_async_event	= nvme_pci_submit_async_event,
 	.get_address		= nvme_pci_get_address,
+	.get_ams		= nvme_pci_get_ams,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3d5189f46cb1..6fe9121e4d27 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -171,6 +171,7 @@ enum {
 	NVME_CC_AMS_RR		= 0 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_WRRU	= 1 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_VS		= 7 << NVME_CC_AMS_SHIFT,
+	NVME_CC_AMS_MASK	= 7 << NVME_CC_AMS_SHIFT,
 	NVME_CC_SHN_NONE	= 0 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_NORMAL	= 1 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_ABRUPT	= 2 << NVME_CC_SHN_SHIFT,
-- 
2.14.1

