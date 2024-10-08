Return-Path: <cgroups+bounces-5067-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E16F99473D
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 13:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF751C2625C
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 11:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76ED1DF273;
	Tue,  8 Oct 2024 11:33:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A41DED4C;
	Tue,  8 Oct 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387215; cv=none; b=JzVXu4Lf6/T+srS+W/R0zZpGWJZIFvDlRAheMJLppWjWlT5hqsZEAMqwckA4Uc50GUGA0JsyPaGOpYqGc4OkR5QrZroCoqgYaDMHnvXnjHkWorsHs+4yxW7nx1feU66l2PF6ahdAhTdSDVfmGhOgV7KACevNPyOVGfqtQPMnVIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387215; c=relaxed/simple;
	bh=r52NoDC0OdcgHEGx6rJiBaq4EWHBLJdtHAloZ1U4kKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MUpaRxP/3Lhy44FiI2/VgKKiupcoDkW6QX0KKMjiazzHHHDTrwwW73OjHj6AA6qTHER5dZzQam2YJFvNecdEwOOUgCy9aY0JGZgU/8mn/UZJA8rG9C4PChihub+bdgiiuqKIic8/1mRbFGDm6fImueyw0Uk7yURmiN7fO7TT8sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XNDRC2Kk4z4f3l20;
	Tue,  8 Oct 2024 19:33:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C91E81A07BA;
	Tue,  8 Oct 2024 19:33:28 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgAnqMRuGAVnI_ERDg--.13677S4;
	Tue, 08 Oct 2024 19:33:28 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	roman.gushchin@linux.dev,
	mkoutny@suse.com
Cc: bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenridong@huawei.com
Subject: [PATCH v6 2/3] workqueue: doc: Add a note saturating the system_wq is not permitted
Date: Tue,  8 Oct 2024 11:24:57 +0000
Message-Id: <20241008112458.49387-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008112458.49387-1-chenridong@huaweicloud.com>
References: <20241008112458.49387-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnqMRuGAVnI_ERDg--.13677S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1xGF13Cw48Cw4DKFyxuFg_yoW8JFy3pr
	W3CFyav3WxJr12ka4kXr47WFy7GF18GFsrGFs7tw1IvFn8A3s7Kw4xKryrta4DJr95uFW8
	ZFZ2v3s0y34jvrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0jN
	t3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

If something is expected to generate large number of concurrent works,
it should utilize its own dedicated workqueue rather than system wq.
Because this may saturate system_wq and potentially block other's works.
eg, cgroup release work. Let's document this as a note.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 Documentation/core-api/workqueue.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 16f861c9791e..2b813f80ce39 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -357,6 +357,11 @@ Guidelines
   difference in execution characteristics between using a dedicated wq
   and a system wq.
 
+  Note: If something may generate more than @max_active outstanding
+  work items (do stress test your producers), it may saturate a system
+  wq and potentially lead to deadlock. It should utilize its own
+  dedicated workqueue rather than the system wq.
+
 * Unless work items are expected to consume a huge amount of CPU
   cycles, using a bound wq is usually beneficial due to the increased
   level of locality in wq operations and work item execution.
-- 
2.34.1


