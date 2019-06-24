Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEAD250DFC
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2019 16:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfFXO3l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jun 2019 10:29:41 -0400
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:6412 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S1727078AbfFXO3l (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jun 2019 10:29:41 -0400
X-ASG-Debug-ID: 1561386577-0e40886efc18f480001-hhPYk8
Received: from BJEXCAS08.didichuxing.com (bogon [172.20.36.203]) by bsf01.didichuxing.com with ESMTP id UooTDiNe2MZyyI4j; Mon, 24 Jun 2019 22:29:37 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 22:29:37 +0800
Date:   Mon, 24 Jun 2019 22:29:36 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <tglx@linutronix.de>, <axboe@kernel.dk>, <tj@kernel.org>,
        <hch@lst.de>, <bvanassche@acm.org>, <keith.busch@intel.com>,
        <minwoo.im.dev@gmail.com>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/5] genirq/affinity: allow driver's discontigous affinity
 set
Message-ID: <1ead341c6d603cf138aed62e31091f257cb19981.1561385989.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v3 4/5] genirq/affinity: allow driver's discontigous affinity
 set
Mail-Followup-To: tglx@linutronix.de, axboe@kernel.dk, tj@kernel.org,
        hch@lst.de, bvanassche@acm.org, keith.busch@intel.com,
        minwoo.im.dev@gmail.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1561385989.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.203]
X-Barracuda-Start-Time: 1561386577
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 756
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0002 1.0000 -2.0200
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

The driver may implement multiple affinity set, and some of
are empty, for this case we just skip them.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 kernel/irq/affinity.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f18cd5aa33e8..6d964fe0fbd8 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -295,6 +295,10 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
+		/* skip empty affinity set */
+		if (this_vecs == 0)
+			continue;
+
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
 					       curvec, masks);
 		if (ret) {
-- 
2.14.1

