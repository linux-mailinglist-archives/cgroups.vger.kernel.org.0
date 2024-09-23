Return-Path: <cgroups+bounces-4932-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CFE97EB0E
	for <lists+cgroups@lfdr.de>; Mon, 23 Sep 2024 13:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B111F21DE6
	for <lists+cgroups@lfdr.de>; Mon, 23 Sep 2024 11:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190861990D2;
	Mon, 23 Sep 2024 11:52:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4388F1E487;
	Mon, 23 Sep 2024 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092357; cv=none; b=jwOv5wIScwq5rzqHXFbT6TU4ahFln3mD9XmypGq4IYpuUn1zo3jb4uQTxXXu2m2mAEsI754oxk7sYOq7kTse7ChYxLdf3Qvhylkq0goy/d0vbOi+uP1qd+eI6l5nJjLmNpDb6272A24hzQqwPU1boGJKk12c9sODRWkocdSwENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092357; c=relaxed/simple;
	bh=DXjWKYOvianPpA+tLa3PnY1A5CKhCzCbcmyYGiVBebg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p88jG/ujyIhx1IiVQ7XAENpGilMRJJEb/um6ML3JeLQg124ET/J44yTzZ1IeNeyx7pfFuj/WhmZCnpouH22ZBm2tqzmDJdUWPKuSCRcgTuaKU8wHA9WgVDylDI/+fSP2jfyreBf4knnhJNSzKDVoAGwtBSscSfnhijas0790fFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XC1Z71V0Sz4f3lDG;
	Mon, 23 Sep 2024 19:52:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0F35E1A018D;
	Mon, 23 Sep 2024 19:52:32 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgCHKYZlVvFmONo3CA--.32773S5;
	Mon, 23 Sep 2024 19:52:31 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	longman@redhat.com,
	mkoutny@suse.com,
	chenridong@huawei.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] workqueue: Adjust WQ_MAX_ACTIVE from 512 to 2048
Date: Mon, 23 Sep 2024 11:43:52 +0000
Message-Id: <20240923114352.4001560-4-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240923114352.4001560-1-chenridong@huaweicloud.com>
References: <20240923114352.4001560-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCHKYZlVvFmONo3CA--.32773S5
X-Coremail-Antispam: 1UD129KBjvJXoW7AF17GFy3WFyxAFW3tr1UJrb_yoW8Cr1DpF
	Z3Cr48ta1fWFyYk34kJw1xJry8GayUCF4DKFZ2gr10v3W5ZrWv9F47Kr1Yva4kJryDZF95
	uFW2grZ0y3yjvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwhFxUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

WQ_MAX_ACTIVE is currently set to 512, which was established approximately
15 yeas ago. However, with the significant increase in machine sizes and
capabilities, the previous limit of 256 concurrent tasks is no longer
sufficient. Therefore, we propose to increase WQ_MAX_ACTIVE to 2048.
and WQ_DFL_ACTIVE is 1024 now.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 Documentation/core-api/workqueue.rst | 4 ++--
 include/linux/workqueue.h            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 9de622188f2f..c6a8ac2530e9 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -245,8 +245,8 @@ CPU which can be assigned to the work items of a wq. For example, with
 at the same time per CPU. This is always a per-CPU attribute, even for
 unbound workqueues.
 
-The maximum limit for ``@max_active`` is 512 and the default value used
-when 0 is specified is 256. These values are chosen sufficiently high
+The maximum limit for ``@max_active`` is 2048 and the default value used
+when 0 is specified is 1024. These values are chosen sufficiently high
 such that they are not the limiting factor while providing protection in
 runaway cases.
 
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 59c2695e12e7..b0dc957c3e56 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -412,7 +412,7 @@ enum wq_flags {
 };
 
 enum wq_consts {
-	WQ_MAX_ACTIVE		= 512,	  /* I like 512, better ideas? */
+	WQ_MAX_ACTIVE		= 2048,	  /* I like 2048, better ideas? */
 	WQ_UNBOUND_MAX_ACTIVE	= WQ_MAX_ACTIVE,
 	WQ_DFL_ACTIVE		= WQ_MAX_ACTIVE / 2,
 
-- 
2.34.1


