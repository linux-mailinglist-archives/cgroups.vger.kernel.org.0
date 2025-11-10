Return-Path: <cgroups+bounces-11702-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A16C44C0E
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 03:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE59C4E2480
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 02:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52313231C9F;
	Mon, 10 Nov 2025 02:07:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C2C72606;
	Mon, 10 Nov 2025 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762740463; cv=none; b=TQGVh/VGdRA+ilv/teAX7rgik/UCwiFMrQ/GjSMtyJOhbxCG1eDsSd5dvKEMxY5qYR6CKNcRo3h3r6Liy5BY9LcBoiS2fu/pSj/xdMmv1h7bnn4DLJj60ajcoQC3lrBwKc+uk7Y8q/tu3BM4BWwgEvM4suYTx1NUEpRzYXv0V5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762740463; c=relaxed/simple;
	bh=6TzXyx5esCmsNqVDllLvszkBYn2B0eITB4euU4RI3Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q7yDbZcnEu6jjkYBsFDmddi0Vxw+5GCCrhQiis9yq0aKsrjxPynkErgOKqRgjDAW6hF+m/p3pgJAk1BZqGQrHBPktcq7bDIOdLlqW1KJXeSncPPgpGCNDS42gwXXm0ZMVvyTXbBY2QLQu4KxnUNYM3VOc7UcQWHSHvondkfSZg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d4Y2N0VNVzYQth8;
	Mon, 10 Nov 2025 10:07:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 639431A12C7;
	Mon, 10 Nov 2025 10:07:32 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP1 (Coremail) with SMTP id cCh0CgBXkUrUSBFpPBDaAA--.6382S2;
	Mon, 10 Nov 2025 10:07:32 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 0/3] cpuset: code cleanups
Date: Mon, 10 Nov 2025 01:52:25 +0000
Message-Id: <20251110015228.897736-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXkUrUSBFpPBDaAA--.6382S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWUZw18tr48JFyDCry3Jwb_yoW3JFb_AF
	y8ta45tr9rXFyIka47AF1ftayqkF47CF1qya4rtw45Ary3AFn3JrsY9rW2qr93uFZYqr1U
	J3sYyFZ5Zr1qvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UpyxiUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Patch 1 simplifies the error handling path in cpuset_set_nodes() by
returning directly on failure, eliminating an unnecessary jump.

Patch 2 removes the global remote_children list and replaces it with
a boolean remote_partition flag, which provides a more direct way
to identify remote partitions.

Patch 3 removes need_rebuild_sched_domains.

Chen Ridong (3):
  cpuset: simplify node setting on error
  cpuset: remove global remote_children list
  cpuset: remove need_rebuild_sched_domains

 kernel/cgroup/cpuset-internal.h |  4 ++--
 kernel/cgroup/cpuset.c          | 41 ++++++++++++---------------------
 2 files changed, 17 insertions(+), 28 deletions(-)

-- 
2.34.1


