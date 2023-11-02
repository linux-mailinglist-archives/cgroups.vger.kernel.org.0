Return-Path: <cgroups+bounces-159-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7C37DED65
	for <lists+cgroups@lfdr.de>; Thu,  2 Nov 2023 08:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F311C20EA0
	for <lists+cgroups@lfdr.de>; Thu,  2 Nov 2023 07:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087C86AB8;
	Thu,  2 Nov 2023 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12063BF
	for <cgroups@vger.kernel.org>; Thu,  2 Nov 2023 07:33:09 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932E4E4
	for <cgroups@vger.kernel.org>; Thu,  2 Nov 2023 00:33:07 -0700 (PDT)
X-UUID: a1961b9757e149fcb78196082f4117f7-20231102
X-CID-CACHE: Type:Local,Time:202311021531+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:8efcbc2f-71d8-4717-8ee9-fc58ec854658,IP:15,
	URL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,A
	CTION:release,TS:-35
X-CID-INFO: VERSION:1.1.32,REQID:8efcbc2f-71d8-4717-8ee9-fc58ec854658,IP:15,UR
	L:0,TC:0,Content:-5,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-35
X-CID-META: VersionHash:5f78ec9,CLOUDID:9d65985f-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|102,TC:nil,Content
	:0,EDM:2,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: a1961b9757e149fcb78196082f4117f7-20231102
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.169)] by mailgw
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 451962185; Thu, 02 Nov 2023 15:32:53 +0800
From: Li Wang <liwang@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH] cgroup: return EINVAL in cgroup_subtree_control_write()
Date: Thu,  2 Nov 2023 15:32:50 +0800
Message-Id: <20231102073250.49357-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If add into the cgroup.subtree_control file with a subsystem
name which is beyond the scope of the ones in the parent's
cgroup.subtree_control file, the response is ’no such file or
directory', which is confusing since the cgroup.subtree_control
file is present, return EINVAL in this case.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 484adb375b15..77c1324ce0c1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3391,7 +3391,7 @@ static ssize_t cgroup_subtree_control_write(struct kernfs_open_file *of,
 			}
 
 			if (!(cgroup_control(cgrp) & (1 << ssid))) {
-				ret = -ENOENT;
+				ret = -EINVAL;
 				goto out_unlock;
 			}
 		} else if (disable & (1 << ssid)) {
-- 
2.34.1


