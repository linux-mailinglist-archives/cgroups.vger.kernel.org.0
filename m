Return-Path: <cgroups+bounces-4933-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646BF97EB0F
	for <lists+cgroups@lfdr.de>; Mon, 23 Sep 2024 13:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285D4280C76
	for <lists+cgroups@lfdr.de>; Mon, 23 Sep 2024 11:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475881991BF;
	Mon, 23 Sep 2024 11:52:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392680038;
	Mon, 23 Sep 2024 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092358; cv=none; b=Wmu+gqS7qoIpn7q9nKwLNfaj15Lkl1zCZRhSKr1vhCBQhw9PIOdMX+ewL00GKkyfyPDbouESgqcZqyUn/W03lbQ5blRqLZi+/1CUd58hCI7f/erdRM1mTNmhUCsCEzDWGd4exum66U8aTstJzqcVLhN+QxaHsahjyo8waPBbG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092358; c=relaxed/simple;
	bh=B86VIq0inyIrwQUi1LxfcSTlzGI3NY68FLTVbQhizAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NCsbn4MavIzmJEws2PxqlSpyoBJFOe5zr7EDLjolYJF/LqwEQtjfbMtpZ3AHecKYabV+MqPTwJINvBtqlV1N6EuNHQyKSNPDggiW+0zd8oIVgJq1BewI/sIwyNKkZJbRHLtPuZFDSZcQuqCDet70Wl8NQEIkNFyuUGo7LE+sHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XC1ZD5N8yz4f3jkj;
	Mon, 23 Sep 2024 19:52:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D96E61A092F;
	Mon, 23 Sep 2024 19:52:31 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgCHKYZlVvFmONo3CA--.32773S2;
	Mon, 23 Sep 2024 19:52:29 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	longman@redhat.com,
	mkoutny@suse.com,
	chenridong@huawei.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] add dedicated wq for cgroup bpf and adjust WQ_MAX_ACTIVE
Date: Mon, 23 Sep 2024 11:43:49 +0000
Message-Id: <20240923114352.4001560-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCHKYZlVvFmONo3CA--.32773S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWUCw15Zr4DWw1kWFW3Jrb_yoWkArXE93
	97uFyvvrykJF1jqasxKFn3uFWvkr4UJr1rJF1UtrsFqFnxXrn3uFs3tr90va18Za40qry5
	Aas3XrZ2qFnxJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The patch series add a dedicated workqueue for cgroup bpf destruction,
add adjust WQ_MAX_ACTIVE from 512 to 2048.

v5:
- use a dedicated workqueue for cgroup bpf destruction.
- update some messages for TJ's feedbacks.

v4:
- add a patch to document that saturating the system_wq is not permitted.
- add a patch to adjust WQ_MAX_ACTIVE from 512 to 2048.

v3:
- optimize commit msg.

Link v1: https://lore.kernel.org/cgroups/20240607110313.2230669-1-chenridong@huawei.com/
Link v2: https://lore.kernel.org/cgroups/20240719025232.2143638-1-chenridong@huawei.com/
Link v3: https://lore.kernel.org/cgroups/20240817093334.6062-1-chenridong@huawei.com/



Chen Ridong (3):
  cgroup/bpf: use a dedicated workqueue for cgroup bpf destruction
  workqueue: doc: Add a note saturating the system_wq is not permitted
  workqueue: Adjust WQ_MAX_ACTIVE from 512 to 2048

 Documentation/core-api/workqueue.rst |  9 +++++++--
 include/linux/workqueue.h            |  2 +-
 kernel/bpf/cgroup.c                  | 18 +++++++++++++++++-
 3 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.34.1


