Return-Path: <cgroups+bounces-6209-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3179A147F8
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 03:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE59A16A6F3
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 02:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB531F5611;
	Fri, 17 Jan 2025 02:14:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA5A25A65B;
	Fri, 17 Jan 2025 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737080099; cv=none; b=ohrG/Fs5+qgP2fURZ87R2R/ZJL6k3M8eGQnQ24MjsBRC5qdtli3StYDWIWsT1OjIUMNUy2NiMtd5cpIPuwhL6QsRRQIk+qxB/P92e+cAx6v8BfLeUE3cQjfmcX/CPTCqnaxeka6sWwnOQqsTNicRfKqMnnMVYUlGM05op4m//UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737080099; c=relaxed/simple;
	bh=rZqLUl8mRweRtYaD0sn1J9F0l4tnFVQxbFpGONjle4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lOLMxvFdn2eXRQg5R5o9IcwBn5DiyTmxa1BFGvlDyCOtBvKW3bY+w5HV5QBJC3Sf/9GUE888aLtgQWdXc0ADMf96Ee5BDacZghTHeN88mizmpykuwZQ3HeysljNf5KUzxmxjKoXHtxyMyQOMqdmh8OMvuyOLc0SoK/IRHQGPJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YZ2t020Hfz4f3jMK;
	Fri, 17 Jan 2025 09:57:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id EC1B21A0E3E;
	Fri, 17 Jan 2025 09:57:33 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCnsWT7uIln8NWrBA--.20802S2;
	Fri, 17 Jan 2025 09:57:33 +0800 (CST)
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
Subject: [PATCH v3 next 0/5] Some cleanup for memcg
Date: Fri, 17 Jan 2025 01:46:40 +0000
Message-Id: <20250117014645.1673127-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnsWT7uIln8NWrBA--.20802S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF43XrykAw45Wr15ZF4rAFb_yoWfKFc_KF
	97AFy7tw42gryUJFy2kr45JFy2kan8A34DG3WjqF43tasxtw1q9FnF9FW8Zr18X3y3Cr4Y
	vr98Jw4kWw129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUOBMKDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Some cleanup for memcg

---

v2->v3:
 - move the wrapper function definitions to header files.
 - add a patch to move the 'local' functions to the memcontrol-v1.c.

v1->v2:
 - drop the patch 'simplify the mem_cgroup_update_lru_size function'.
 - for patch 3, rename '__refill_obj_stock' to replace_stock_objcg, and
   keep the 'objcg equal' check in the calling functions.

Chen Ridong (5):
  memcg: use OFP_PEAK_UNSET instead of -1
  memcg: call the free function when allocation of pn fails
  memcg: factor out the replace_stock_objcg function
  memcg: factor out stat(event)/stat_local(event_local) reading
    functions
  memcg: move the 'local' functions to memcontrol-v1.c

 include/linux/memcontrol.h |  25 +++++--
 mm/memcontrol-v1.c         |  17 +++++
 mm/memcontrol-v1.h         |  11 ++--
 mm/memcontrol.c            | 130 ++++++++++++-------------------------
 4 files changed, 86 insertions(+), 97 deletions(-)

-- 
2.34.1


