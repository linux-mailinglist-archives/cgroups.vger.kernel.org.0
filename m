Return-Path: <cgroups+bounces-6124-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDDFA106BA
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 13:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497BE16549C
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 12:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DC0234CE8;
	Tue, 14 Jan 2025 12:36:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F79520F999;
	Tue, 14 Jan 2025 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858165; cv=none; b=fgZofXDOmdja4cFIL5gAkCyuO2FGLDa/gAK1ReA3aMhAxRY0FgMEAZASkTIQKtkpby+3nxJbNFMD5GXuV0rg2fv2EZFFTq/gRcs95H0HfWlxgwo08A4BNHVhGBbzcpl+dIRiR+U5di3P8lGEPSHNzGFQYExIkK2h11d2+Twc25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858165; c=relaxed/simple;
	bh=HwAlG3pV9Hiu2YL1xRmOze6FsyrYJdNOzpQ1PVXAPJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xztw57Vb6y3Q4UgA3na8+dt52PaPwefVh1WoqmZ6AaAXQP50efLsOA0WmZ9NCn91IaWvLHoVd2cFMayZtVvdoJ4mvTWga8Nb0QgSMCMnV4+9Itjz8+t5/SxlpCGNuBJdTzIFCZv8GL95utUDZRAwMCQ4xWt/q18j1GHF8NIwN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YXTB15FX9z4f3jM8;
	Tue, 14 Jan 2025 20:35:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5923B1A1299;
	Tue, 14 Jan 2025 20:35:59 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgB3F8IhWoZnN4KvAw--.1325S2;
	Tue, 14 Jan 2025 20:35:59 +0800 (CST)
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
Subject: [PATCH -v2 next 0/4] Some cleanup for memcg
Date: Tue, 14 Jan 2025 12:25:15 +0000
Message-Id: <20250114122519.1404275-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3F8IhWoZnN4KvAw--.1325S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF43XrWfJr43Xr15trWrKrg_yoWxZrg_Ga
	s7XFy7Kw12vF1aya4vkr4UCFyxKw45JryDGF1jqF43tasxJw1kZF12qF45Zr1xZ3yIkF4Y
	vrn8Jan7Ww12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Some cleanup for memcg.

---
v1->v2:
 - drop the patch 'simplify the mem_cgroup_update_lru_size function'.
 - for patch 3, rename '__refill_obj_stock' to replace_stock_objcg, and
   keep the 'objcg equal' check in the calling functions.

Chen Ridong (4):
  memcg: use OFP_PEAK_UNSET instead of -1
  memcg: call the free function when allocation of pn fails
  memcg: factor out the replace_stock_objcg function
  memcg: factor out stat(event)/stat_local(event_local) reading
    functions

 mm/memcontrol.c | 127 ++++++++++++++++++++++--------------------------
 1 file changed, 59 insertions(+), 68 deletions(-)

-- 
2.34.1


