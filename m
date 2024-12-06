Return-Path: <cgroups+bounces-5772-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD519E6389
	for <lists+cgroups@lfdr.de>; Fri,  6 Dec 2024 02:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67DB188593A
	for <lists+cgroups@lfdr.de>; Fri,  6 Dec 2024 01:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8FE14A09F;
	Fri,  6 Dec 2024 01:45:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E81714A4D1;
	Fri,  6 Dec 2024 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449513; cv=none; b=O3TdHhkjHPNiY8esI0+YxWxQVKkbfbXfWp36SzSWjKEJFe0geP9iZ8mpvgX6zIQ0kAkXVMyoQizQaBg8rTpD83abyx5dMGurklhAa5zagS4f6PVGOG9IFGDRtI9r88I8uqfhYq3VsRoxoMk5/xrRkt/KVyGfSDDVv0y9nNnqP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449513; c=relaxed/simple;
	bh=FdjO5+1U4DJIrmps4/q0FKHWopDE6PC3w3NXPF+NO0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L5uvxfikBTxTX3jNntp0XRUWwUOqdRlk/AqsMXPH3BPdrJcV/jT0uQBHMX884gTgmkpbmE3AAnTcAHRnrMCMXXEPjp071FnhUHjwf5yHboF8VCVvWTMFV2lbsex3vQN9aqM5SEMJa4iKXvaaN5ljCeo2gtUUWpV/TgMTUcTCG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y4Db44dh4z4f3jqZ;
	Fri,  6 Dec 2024 09:44:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A010B1A0A22;
	Fri,  6 Dec 2024 09:45:02 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgD30oYKV1JnkkskDw--.31315S3;
	Fri, 06 Dec 2024 09:45:02 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	davidf@vimeo.com,
	vbabka@suse.cz
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [next -v1 1/5] memcg: use OFP_PEAK_UNSET instead of -1
Date: Fri,  6 Dec 2024 01:35:08 +0000
Message-Id: <20241206013512.2883617-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206013512.2883617-1-chenridong@huaweicloud.com>
References: <20241206013512.2883617-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD30oYKV1JnkkskDw--.31315S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWrJF48XF4kAF15tw4UXFb_yoWxKrg_uF
	97Kr1Dur15J34Sk3WqyrySvFn2yF1Uuw1DKw15tw13AF9Yq3sYvF1kXr4Fvry8ZrW3try3
	uwsYqayqgr12kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb9AYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x07jjuWdUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The 'OFP_PEAK_UNSET' has been defined, use it instead of '-1'.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..fc18633aba5d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4014,7 +4014,7 @@ static ssize_t peak_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
 			WRITE_ONCE(peer_ctx->value, usage);
 
 	/* initial write, register watcher */
-	if (ofp->value == -1)
+	if (ofp->value == OFP_PEAK_UNSET)
 		list_add(&ofp->list, watchers);
 
 	WRITE_ONCE(ofp->value, usage);
-- 
2.34.1


