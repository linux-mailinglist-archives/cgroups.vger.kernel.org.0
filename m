Return-Path: <cgroups+bounces-7608-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 901CDA916BD
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 10:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2836719E14E2
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 08:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D6F22424D;
	Thu, 17 Apr 2025 08:44:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A52185BE;
	Thu, 17 Apr 2025 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744879445; cv=none; b=J0abJUXZXKsBcrsXFru9yO50UXMsK/EticnKfIntg2vhp9mobGrq/FDE/jNTpdUWRkfmuqcZ4oxz6Dhzp6iYXt6ko+vAjk+PcNCfIfss5L8++o8bwlXQP9IoyTpcROD0v/g5FJx89D5+aHFUSJc9BoA49ljvOAGnhghLKZJ+bMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744879445; c=relaxed/simple;
	bh=Ledhki07hrWxgXV+eMTlsDCZ4m+0NqsxcuxuzAsI5tI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cf0vydORZ57j4Tt9WZaD82ryAny3X8FV2h+6/oOZ2zvdhTK2FVIH7tlRGcTNZ61pGOsxy+oSMVhFaJDlWeyl7Axbw0HwfkoTupgfeVngRWit5exgBKKG60Y8PIQI5LQhhkcIie8ZiE/wvmPAF+cQJDJ99ScqLlfjTaflmKR+uik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAAnzTlHvwBog7+ACQ--.9690S2;
	Thu, 17 Apr 2025 16:43:51 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] mm: memcontrol: remove unnecessary NULL check before free_percpu()
Date: Thu, 17 Apr 2025 16:43:30 +0800
Message-Id: <20250417084330.937380-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnzTlHvwBog7+ACQ--.9690S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw43Ww4fGr1fKw4UGw4UJwb_yoWxCwc_uF
	Wkta4kKr1UAryFkr9rAw1SyFy2va909ayIqF4jqry7JFykt3s8u3y7KrW7Xr1kWFyDJay7
	KryDJF47WFy2kjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHlksUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

free_percpu() checks for NULL pointers internally.
Remove unneeded NULL check here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 mm/memcontrol-v1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 4a9cf27a70af..54c49cbfc968 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -2198,8 +2198,7 @@ bool memcg1_alloc_events(struct mem_cgroup *memcg)
 
 void memcg1_free_events(struct mem_cgroup *memcg)
 {
-	if (memcg->events_percpu)
-		free_percpu(memcg->events_percpu);
+	free_percpu(memcg->events_percpu);
 }
 
 static int __init memcg1_init(void)
-- 
2.25.1


