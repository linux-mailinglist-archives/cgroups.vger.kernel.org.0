Return-Path: <cgroups+bounces-2559-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6C58A7B24
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 05:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C16B1C21653
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 03:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E6D28DBF;
	Wed, 17 Apr 2024 03:57:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965864685;
	Wed, 17 Apr 2024 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713326227; cv=none; b=CQJ7KgViRVDyUQ7qIc/O5BZEFwkTzwGvqbc+IIsV6PwNDiJ6wXiZr4yw6UNLwLF9BlDDPP7964vyTHLH5XN+jwFTzE0x8967FjdCV6/W9hfTegXa/qwGn3RLmTcMxi1ulvY7O/tF772Fnf6R86jD329jQPwrAcvJUCiMBSMWdro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713326227; c=relaxed/simple;
	bh=PKWD7vbdejU793x1sasom1PgvsZwR9MEFIfZnc+KRUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P6ynLjPL/Eb4ydyJO9zCSYh3aHfAVTGoBPJAvnHptx+FcgWBx5eMsq+6oXLnTO88+t/CdX1Bj8RAfAUkQ9B+AoSNqJsH6x9VI2+pa66G9l3CRKECUIbQ4f3s5r23Xu4W8eS9B0WBJSwDzmmRgnLds227no6ckc3Ml6xkEb2VGWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VK6Y00PtKz4f3nV5;
	Wed, 17 Apr 2024 11:56:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EE6651A08FC;
	Wed, 17 Apr 2024 11:57:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RGESB9m5cPFKA--.12259S4;
	Wed, 17 Apr 2024 11:56:53 +0800 (CST)
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -next] cgroup_freezer: update comment for freezer_css_online()
Date: Wed, 17 Apr 2024 03:50:28 +0000
Message-Id: <20240417035028.884560-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RGESB9m5cPFKA--.12259S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JrykuF1DGFy7ZrWxXFW3trb_yoWDCFcEkw
	4xXr1jgr4vvr1j9w1Yy3ZYvanYgayxCryIkrs8Kr45Aas0yrn8JanrKryfXr4UXa1vgrn0
	y34kZrZ3trnFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbokYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
	0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

From: Xiu Jianfeng <xiujianfeng@huawei.com>

The freezer->lock was replaced by freezer_mutex in commit e5ced8ebb10c
("cgroup_freezer: replace freezer->lock with freezer_mutex"), so the
comment here is out-of-date, update it.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/legacy_freezer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 66d1708042a7..d598cc6ee92e 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -106,8 +106,7 @@ freezer_css_alloc(struct cgroup_subsys_state *parent_css)
  * @css: css being created
  *
  * We're committing to creation of @css.  Mark it online and inherit
- * parent's freezing state while holding both parent's and our
- * freezer->lock.
+ * parent's freezing state while holding cpus read lock and freezer_mutex.
  */
 static int freezer_css_online(struct cgroup_subsys_state *css)
 {
-- 
2.34.1


