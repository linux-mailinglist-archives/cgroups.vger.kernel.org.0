Return-Path: <cgroups+bounces-9325-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B342B31033
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 09:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA5C170B94
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 07:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB192E7BB9;
	Fri, 22 Aug 2025 07:22:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4E320B81B;
	Fri, 22 Aug 2025 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847323; cv=none; b=jjNvIVQ2AqKLZIwGlpaN7JdW+A0wFJznIJpRE5UPYc+bIwGM/mfYMDKMc7KLkAwGPankzejRNJoN/5ynXCTiNoh56GiL3ssOdu+QBdt6juPbDoLF3OfuvUln6MhOpFZe+erX08tcFJzzpZbqXiLtQDf02QDruuXelpc4wrfD1HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847323; c=relaxed/simple;
	bh=6yXR7/dWYvpigX0xoDj/uxAD36UrFMZ2fILrRzrxXt8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hZpxmv89fkHmky74b0izn2R3NX/y7M8EQIRuxj0Nfp+BATEBLGu7RFSDxtIc9vyVPMV8TMukKAwH/+GOdJ8jtXfjykkMNeRd6WjCsqePZv8s7b4NmWuo58QXB9JNQq4UO9/nH0hn515iCJq10yhCwND1UEJDEX/ugqVCpuRtC64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c7Wpd1kjbzYQvvc;
	Fri, 22 Aug 2025 15:22:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C02ED1A0F9B;
	Fri, 22 Aug 2025 15:21:59 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgC3w7WJGqho3fPWEQ--.9949S2;
	Fri, 22 Aug 2025 15:21:59 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: gregkh@linuxfoundation.org,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	peterz@infradead.org,
	zhouchengming@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com,
	libaokun1@huawei.com
Subject: [PATCH v2 0/2] kernfs: Fix UAF in PSI polling when open file is released
Date: Fri, 22 Aug 2025 07:07:13 +0000
Message-Id: <20250822070715.1565236-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3w7WJGqho3fPWEQ--.9949S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY-7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

This series fixes a use-after-free issue triggered when disabling and
enabling cgroup PSI.

---
v2:
 - Add kernfs_get_active_of() to safely acquire active references for
   kernfs open files suggested by Tj.
 - Split into two patches as suggested by Greg.

Chen Ridong (2):
  kernfs: Fix UAF in polling when open file is released
  cgroup/psi: Set of->priv to NULL upon file release

 fs/kernfs/file.c       | 58 +++++++++++++++++++++++++++---------------
 kernel/cgroup/cgroup.c |  1 +
 2 files changed, 39 insertions(+), 20 deletions(-)

-- 
2.34.1


