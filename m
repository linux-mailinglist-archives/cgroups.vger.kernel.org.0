Return-Path: <cgroups+bounces-12329-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B3CCB4742
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 02:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5A35300160D
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 01:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1DE23D2B4;
	Thu, 11 Dec 2025 01:45:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920D2475CB;
	Thu, 11 Dec 2025 01:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765417521; cv=none; b=VdJb7DmBILBPQFdejY0EN+cyBhPcKG62W629he8LehQH6JLaN1HOWNv+fbqhZZg5PBDlB494RpHjk+HCA3HVejOdQlYx/auPL5pt7brXDZsZmTsVWTEYnEEVxzpPLk9eLl6Y0IYI/nJtfTGv6wrqDFp7RSQmMifvRiDToqMPq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765417521; c=relaxed/simple;
	bh=QIgjUEjW9KhmJmhTx2ES4BSwE+tU2CutkzkTw7y51ww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z31qbCp/NbuzICTJ5uAYe6vqiGYTjuXEDkK1fEA9gfKRABAgbZJJK9sHPBe3UzJB6IQ64npIOO1MS47CAKeWzCpNiVk17asKATgetyoOhN4yPPBFflcfuXXXlD8xoTQqsOFkGx4IIaUnbESd3p3tsTbbh6On8OkejcUPaLrMwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dRb3g3mD3zKHMMD;
	Thu, 11 Dec 2025 09:44:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 65AD11A1938;
	Thu, 11 Dec 2025 09:45:16 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgB3VlAgIjpp39lLBQ--.49534S2;
	Thu, 11 Dec 2025 09:45:16 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	david@kernel.org,
	zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next v3 0/2] memcg cleanups
Date: Thu, 11 Dec 2025 01:30:17 +0000
Message-Id: <20251211013019.2080004-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB3VlAgIjpp39lLBQ--.49534S2
X-Coremail-Antispam: 1UD129KBjvdXoWrAw45Zr15tw43GF1UCw17KFg_yoWxWFX_Ca
	yIya45trW7WFyrCF9Fyr1fXFWjkF4Utr1jy3Z5Jr4UXFy7tw15XFnrurWUur1xZFs8Ja4U
	J34DJF48Wr1I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRiSdgUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

1/2 moves mem_cgroup_usage() to memcontrol-v1.c
2/2 removes mem_cgroup_size()

Both are code moves/removals with no behavior change.

---

Change from v2:
1. get usage via mem_cgroup_protection and eliminate ifdef.

Chen Ridong (2):
  memcg: move mem_cgroup_usage memcontrol-v1.c
  memcg: remove mem_cgroup_size()

 include/linux/memcontrol.h | 18 +++++++-----------
 mm/memcontrol-v1.c         | 22 ++++++++++++++++++++++
 mm/memcontrol-v1.h         |  2 --
 mm/memcontrol.c            | 27 ---------------------------
 mm/vmscan.c                |  9 ++++-----
 5 files changed, 33 insertions(+), 45 deletions(-)

-- 
2.34.1


