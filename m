Return-Path: <cgroups+bounces-9250-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B7DB29784
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 05:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4411B196535F
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 03:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146D125DD0C;
	Mon, 18 Aug 2025 03:59:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B541519B4;
	Mon, 18 Aug 2025 03:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755489548; cv=none; b=P5FSaIirnIJyqlgvnyuTJqatghoSJJsh8sONxy5B1Gsy6PLZ6Bt+R5GdLcw/fMgOIvEc6UEztuHJDkq7Bz7Ujqomxm69Bp3jP9TkEfLFL1LtOAreZWnT0EZSQEZ+IdSRCuLgQdF3tJLq9tOSJmrYKJhY0U6r83I+/DL231YbGsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755489548; c=relaxed/simple;
	bh=MKwWHhOQEceDnyzx5lUtzSoEVw4UKIsvKOmLTDtqttU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=asjM9Ute02Q/mEZC6GtsZxV13ijsCJDxnyOlV3wmdhwDGNyoTnU+CjUUnRpgtRyVWW2VZbcMGfMcDcOSxMt2EAHWsq06AQYLma/5MIJsaoSH5xJJb+cGoThUfZhaLaV14mXt1wwPMwttQgzQ3r2wtScpMN7TE8J/So8x0hfkMPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c4zVL3JDyzYQvKx;
	Mon, 18 Aug 2025 11:59:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 105571A173E;
	Mon, 18 Aug 2025 11:59:05 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCnIhP+pKJot61AEA--.17966S2;
	Mon, 18 Aug 2025 11:59:04 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next v3 0/3] some optimization for cpuset
Date: Mon, 18 Aug 2025 03:44:27 +0000
Message-Id: <20250818034430.1304069-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIhP+pKJot61AEA--.17966S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1rtr4UGw4DCrWrGF1DGFg_yoW3Krc_AF
	W8ZFyvkr13JF4Sqayayr1rtrWvgw4UCrykAa4DtrsrZF9rArn3Ar1qyayFvr17ZF4fCr15
	uF9rCrn5J3Z7tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUotCzDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

This patch series contains several cpuset improvements:

1. Decouple cpuset and tmpmasks allocation/freeing.
2. Add cpuset_full_[un]lock helpers.

---
v3:
 - fix typos and comment errors.
 - rename cpus_read_cpuset_[un]lock to cpuset_full_[un]lock

v2:
 - dropped guard helper approach, nusing new helper instead.
 - added patches for decoupling cpuset/tmpmasks allocation

Chen Ridong (3):
  cpuset: decouple tmpmasks and cpumasks freeing in cgroup
  cpuset: separate tmpmasks and cpuset allocation logic
  cpuset: add helpers for cpus read and cpuset_mutex locks

 kernel/cgroup/cpuset-internal.h |   2 +
 kernel/cgroup/cpuset-v1.c       |  12 +-
 kernel/cgroup/cpuset.c          | 220 +++++++++++++++++---------------
 3 files changed, 122 insertions(+), 112 deletions(-)

-- 
2.34.1


