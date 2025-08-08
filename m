Return-Path: <cgroups+bounces-9026-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F4EB1E5B7
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 11:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9963BDA6A
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD05E26E70E;
	Fri,  8 Aug 2025 09:39:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A29526AAB2;
	Fri,  8 Aug 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754645985; cv=none; b=BCjWxgbPCivXL4j9Xjj+0M+6WG6LSqZgozhmcdE2b5UAc02OH+3Gfjn4NwgYVlVzh3xe4sg0l7WxhsaH4VgZeJWqmx3TWodTjaVpOJhcctjBvIhL2ilt3DnHEYya9ozCtqaABtd05RAglkd38RxxudUNcywasCJYwDnNO/80Wjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754645985; c=relaxed/simple;
	bh=5CfI4XvynZwvr40M7GsPB0Pq2bvqxRwdnQ6OwP/wkBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rSzliXZavZsQUrT6seFwsDKj1ByYlmjv+hOhQcrexlGPBbg4j4AIDTrA45gW5cXUo7+EFmFHLf8sDriGwNTXPXv4yv3a39CC1qj8olsPCnMIQqnScOF/20M3Fn+lhBPzTh5C+UZxkn6aZ0G67gomZRfd7DndKDA7ye/0zSxrkoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4byzWx5rJVzKHMsF;
	Fri,  8 Aug 2025 17:39:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E50531A0359;
	Fri,  8 Aug 2025 17:39:40 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCXo7XPxZVooOS_Cw--.51716S2;
	Fri, 08 Aug 2025 17:39:40 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	longman@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 0/4] some optimization for cpuset
Date: Fri,  8 Aug 2025 09:25:11 +0000
Message-Id: <20250808092515.764820-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXo7XPxZVooOS_Cw--.51716S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFW7uw4Dtryktw43ury7Awb_yoWfGFc_Aa
	y8ZFyDtry7JFWSqa4Utrs0yFWDKr4UCr18A3WktrWayFnrA3ZxXw4ay3yjqrnFvFs7Ar1U
	JasrKrs5Xw1DJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUxo7KDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

This patch series includes the following improvements:

1. Removes the redundant CS_ONLINE flag.
2. Introduces new helper functions guard_cpuset() and
   guard_cpus_read_and_cpuset().
3. Replaces manual locking patterns with the new guard helpers.

Chen Ridong (4):
  cpuset: remove redundant CS_ONLINE flag
  cpuset: add helpers for cpuset related locks
  cpuset: use guard_cpus_read_and_cpuset to make code concise
  cpuset: replace cpuset_lock() with guard_cpuset()

 include/linux/cgroup.h          |  5 ++++
 include/linux/cpuset.h          |  3 +-
 kernel/cgroup/cpuset-internal.h |  5 ++--
 kernel/cgroup/cpuset-v1.c       | 22 +++++---------
 kernel/cgroup/cpuset.c          | 52 ++++++++++-----------------------
 kernel/sched/syscalls.c         | 15 ++++------
 6 files changed, 37 insertions(+), 65 deletions(-)

-- 
2.34.1


