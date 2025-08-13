Return-Path: <cgroups+bounces-9124-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD16DB2449E
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 10:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B252C3B7D8A
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 08:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E6A2F0C60;
	Wed, 13 Aug 2025 08:43:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ADC2EE61B;
	Wed, 13 Aug 2025 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074613; cv=none; b=EqfMpmrtZ2TsOYg8Fu/fpEqFeQU9KW6oH+swTW5aL5BvlJC06/MFBYfdztldzYd66+QPEfaez4hHWJtBi3zXWVQOQdXoUhS/5HmkcBlyawf0VmBZGgzFHnnkLZDwPQ/1c2KMEm4XCIbP434UV3iQulLX4lQl92wfGD5pP2l5+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074613; c=relaxed/simple;
	bh=zKL4LWe+NZJchVarBwSDy44Dax0HqQmItn3IJz2vG90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HprRzT0OATPJDPeV+yB+yxPsrjyfH28k8Be8N/joPuueSBG41ITNVb5XLc5CICbEfo1i+mDojs4OTybuoMNciutXnU2IxTxElR4M2oj8PQ9QZogboGcEdhN0hUQAgL11wh3K/ReLYs95CcI/6aPJq9mGoPRvfPEYj2NCCyIQR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c222n5MXczYQvC0;
	Wed, 13 Aug 2025 16:43:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 59CBA1A0EF7;
	Wed, 13 Aug 2025 16:43:28 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgBHDg8qUJxoaYwdDg--.28644S2;
	Wed, 13 Aug 2025 16:43:28 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	longman@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com,
	christophe.jaillet@wanadoo.fr
Subject: [-next v2 0/4] some optimization for cpuset
Date: Wed, 13 Aug 2025 08:29:00 +0000
Message-Id: <20250813082904.1091651-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHDg8qUJxoaYwdDg--.28644S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1UJry5GF47WF1kXFyDAwb_yoW3Kwb_CF
	W8XFyDKry3Ja1Sqayayrn5tFWkKr4UCryDKa4qvr43ZFnrArn3Xw4qy3yFqry7ZFn3Crn8
	ZF9rArn5J39rXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

This patch series contains several cpuset improvements:

1. Remove redundant CS_ONLINE flag.
2. Decouple cpuset and tmpmasks allocation/freeing.
3. Add cpus_read_cpuset_[un]lock() helpers.

---
v2:
 - dropped guard helper approach, nusing new helper instead.
 - added patches for decoupling cpuset/tmpmasks allocation

Chen Ridong (4):
  cpuset: remove redundant CS_ONLINE flag
  cpuset: decouple tmpmaks and cpumaks of cs free
  cpuset: separate tmpmasks and cpuset allocation logic
  cpuset: add helpers for cpus read and cpuset_mutex locks

 include/linux/cgroup.h          |   5 +
 kernel/cgroup/cpuset-internal.h |   5 +-
 kernel/cgroup/cpuset-v1.c       |  12 +-
 kernel/cgroup/cpuset.c          | 212 ++++++++++++++++----------------
 4 files changed, 117 insertions(+), 117 deletions(-)

-- 
2.34.1


