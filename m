Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD1C14B422
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2020 13:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgA1M2P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jan 2020 07:28:15 -0500
Received: from mx2.didiglobal.com ([111.202.154.82]:31950 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1725948AbgA1M2P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jan 2020 07:28:15 -0500
X-ASG-Debug-ID: 1580212421-0e40884f7314c6d30001-hhPYk8
Received: from mail.didiglobal.com (localhost [172.20.36.207]) by bsf01.didichuxing.com with ESMTP id WvI5Fr8csBiVuXnK; Tue, 28 Jan 2020 19:53:41 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan
 2020 19:53:41 +0800
Date:   Tue, 28 Jan 2020 19:53:40 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>, <hch@lst.de>,
        <bvanassche@acm.org>, <keith.busch@intel.com>,
        <minwoo.im.dev@gmail.com>, <tglx@linutronix.de>,
        <edmund.nadolski@intel.com>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
Subject: [PATCH v4 4/5] genirq/affinity: allow driver's discontigous affinity
 set
Message-ID: <c044e71afa25fdf65ca9abd21f8a5032e1b424eb.1580211965.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v4 4/5] genirq/affinity: allow driver's discontigous affinity
 set
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        bvanassche@acm.org, keith.busch@intel.com, minwoo.im.dev@gmail.com,
        tglx@linutronix.de, edmund.nadolski@intel.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <cover.1580211965.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1580211965.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS01.didichuxing.com (172.20.36.235) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.207]
X-Barracuda-Start-Time: 1580212421
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 977
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.79617
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

nvme driver will add 4 sets for supporting NVMe weighted round robin,
and some of these sets may be empty(depends on user configuration),
so each particular set is assigned one static index for avoiding the
management trouble, then the empty set will be been by
irq_create_affinity_masks(). This patch make API more compatible.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 kernel/irq/affinity.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4d89ad4fae3b..83154615cc9d 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -462,6 +462,10 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
+		/* skip empty affinity set */
+		if (this_vecs == 0)
+			continue;
+
 		ret = irq_build_affinity_masks(curvec, this_vecs,
 					       curvec, masks);
 		if (ret) {
-- 
2.14.1

