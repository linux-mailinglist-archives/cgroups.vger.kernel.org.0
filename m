Return-Path: <cgroups+bounces-6259-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075A6A1B10F
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 08:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAE43A65EC
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 07:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA4B1DB133;
	Fri, 24 Jan 2025 07:46:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363801D95BE;
	Fri, 24 Jan 2025 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737704773; cv=none; b=BpYzefaKnTJP+SE+lOJue/xwNvrPaFMG+nizw4UIc+KqTHN/xYn7UAWsy5qQkw6mmK6YW2GJzXKkk2dStQVgvwKyYwNCn25IkeqHl4MltbnyCqjmWRvX4Q6iit4xd9Rr5KLK/U3iIU60+/tvOeXqWRzt2IiMU2LmNabtTZIIeGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737704773; c=relaxed/simple;
	bh=xOnQw+BtHC71i6Cc8tDcU9OM6ahlZFaLrJXfpYqoOQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eKGALPJEWLBFSK1aKeAQXJkLA9uCYGSV68/BsMf3QGXjcJ92/rwv7huaQ2ok27MhZw1V7ncz2xTUOoO/Ss2dLYPCHZrcxpUJgR0WI9KXei31pAgnX7tl66iV3QJmZ0KHsvYbhNd70OsUCEkbim2HYoA0/juZwequ3l7AuTyfE5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YfVH53pYgz4f3jsv;
	Fri, 24 Jan 2025 15:45:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0E2D11A0F8D;
	Fri, 24 Jan 2025 15:46:09 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP1 (Coremail) with SMTP id cCh0CgBHqnozRZNn89xFBw--.58969S2;
	Fri, 24 Jan 2025 15:46:08 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	davidf@vimeo.com,
	vbabka@suse.cz,
	mkoutny@suse.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH -v4 next 0/4] Some cleanup for memcg
Date: Fri, 24 Jan 2025 07:35:10 +0000
Message-Id: <20250124073514.2375622-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHqnozRZNn89xFBw--.58969S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF43XrWDKFW7tryUZF18Xwb_yoWDuFg_KF
	Z7ZFy7Kw1jgFWUXFW2kr48JFW2kw45Zry5GF1jqr43ta43tw1qvFsrWrWrZr1rZwsIkF45
	Ary5J397CwnFyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UQ6p9UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Some cleanup for memcg.

In this series, patches 1-3 have been reviewed.
Patch 4 is new, which adds CONFIG_MEMCG_V1 for the local functions,
suggested by Johannes Weiner.

---

v3->v4:
 - keep the 'local' functions in the memcontrol-v1.c and add
   CONFIG_MEMCG_V1 for them.

v2->v3:
 - move the wrapper function definitions to header files.
 - add a patch to move the 'local' functions to the memcontrol-v1.c.

v1->v2:
 - drop the patch 'simplify the mem_cgroup_update_lru_size function'.
 - for patch 3, rename '__refill_obj_stock' to replace_stock_objcg, and
   keep the 'objcg equal' check in the calling functions.

Chen Ridong (4):
  memcg: use OFP_PEAK_UNSET instead of -1
  memcg: call the free function when allocation of pn fails
  memcg: factor out the replace_stock_objcg function
  memcg: add CONFIG_MEMCG_V1 for 'local' functions

 mm/memcontrol-v1.h |  6 ++---
 mm/memcontrol.c    | 61 ++++++++++++++++++++++++++--------------------
 2 files changed, 38 insertions(+), 29 deletions(-)

-- 
2.34.1


