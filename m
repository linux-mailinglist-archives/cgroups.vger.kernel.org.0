Return-Path: <cgroups+bounces-5065-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AE6994735
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 13:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD2D283598
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 11:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9105B1DEFE3;
	Tue,  8 Oct 2024 11:33:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CFD1DED47;
	Tue,  8 Oct 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387214; cv=none; b=JxgJ2rDUbYKc7GEu/hVVMxqylX0KQbV4yw+JeN/5/pQVQ8zXV2Ao/yBH46l5VBp7bJQromiBhjtH8nOLTXk2natepPfO9Uzsi3Dgogxk5kayKs31TS/lyHlL+R4qtP0vnyAdvM9alny9cyZ5NBKYZNwWgn2fUC/W/eE7AUmAEmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387214; c=relaxed/simple;
	bh=b3qvlnotsPnCAt8MBT1OpBKEQciC8kBvbqiG3Y4Qo2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r7lywky6Q3XKv4P5zNkpKs85IUgiHfGIxEj3JU2V5aZun9i8dnHKKJkU3KzrQtwwaj5FOpJG48MxqyL6zZl8g+Xgey0sWZTea1aa72SbLeuDK91hFMnHjFqu+ZuiWwRpO2HfFoNmsJHB9YhHSulRVwKRlD5BFCmIaaVQ8qQWEWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XNDRC2Sgtz4f3l26;
	Tue,  8 Oct 2024 19:33:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D56161A0568;
	Tue,  8 Oct 2024 19:33:28 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgAnqMRuGAVnI_ERDg--.13677S5;
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
Subject: [PATCH v6 3/3] workqueue: Adjust WQ_MAX_ACTIVE from 512 to 2048
Date: Tue,  8 Oct 2024 11:24:58 +0000
Message-Id: <20241008112458.49387-4-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAnqMRuGAVnI_ERDg--.13677S5
X-Coremail-Antispam: 1UD129KBjvJXoW7AF17GFy3WFyxAFW3tr1UJrb_yoW8Cr1DpF
	s3Cr18ta1fWFyYk34kGw17Jry8GFWUCFsrKFs2gw10v3W5ZrWv9F4xKr1Yva4kJryDZFZ5
	uFW2grZ0y3yjvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
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
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Ru
	WJUUUUU==
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
index 2b813f80ce39..e295835fc116 100644
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


