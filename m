Return-Path: <cgroups+bounces-2948-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713C28C80E7
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 08:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E41F1C20F58
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 06:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C46A134A6;
	Fri, 17 May 2024 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cHa/WkRA"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1921913AC5;
	Fri, 17 May 2024 06:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715927112; cv=none; b=F2cllDP+mqROoSeL78tIMgzRrXlewtGfx/PgnU+3hY4kYUcAD6v3H3pooBP6tE2S3BN/UX7c47P5gquN9KHL4y7eCp8dsNNsMFy/9z84mbVvf15V6R8y6hwRpo0BPuLX+u9xkPatKWgWfycnJmtiqe46D+MJoimb5t4Wwgjo2Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715927112; c=relaxed/simple;
	bh=fh4WwPUAdmk3bzl1TBfQSECk5v1gX7NZDqFuBoZ0beE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d3csVTjVQ/NmEUAIMeSgAKSpoN4kYYi5MlKvdz06WBc5eblKxeqJTw2p377dCbpuf7Ov7mO6yuj9BU9pl31RJu+sbF8ZlUJLhSGooZO7r7+dia0og8cE9H5MrysIF7B4bU+RKoAAzCyN04hhTkWbZpqSo0hTQQpkXtPYcj5cSqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cHa/WkRA; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3af1U
	0H/g2zUdtLmuWBn6FIU+1LQ1Dqa4JirWL1awz4=; b=cHa/WkRAbqrbslbb0dKFX
	uEvT4TDH/6YlzD7Iggj6Xt2f55sVE4d39+DZ/lJHC+vKH4F+Fv7W92LB7pdbSbY+
	tgriFkWA/xdi0Rb4C91rvB+Uc3ihuHrByHA0PRrEgDMQU+fC2oG4xJt43ehR5tGk
	ujTb32ihzyJwzhTLhYibtg=
Received: from localhost.localdomain (unknown [111.35.185.173])
	by gzga-smtp-mta-g3-3 (Coremail) with SMTP id _____wDnl10m+EZmsKT0Ag--.57131S4;
	Fri, 17 May 2024 14:24:43 +0800 (CST)
From: David Wang <00107082@163.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] kernel/cgroup: cleanup cgroup_base_files when fail to add cgroup_psi_files
Date: Fri, 17 May 2024 14:24:05 +0800
Message-Id: <20240517062405.115253-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnl10m+EZmsKT0Ag--.57131S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWkWFy5GrWkur1Dtr1fZwb_yoWfArg_Z3
	4IvFn2grWfA3y7KanIvws5GrWxGr4Fqr9Yvr1UGrsrJF1UJr98JwnxJrn8Jrsxua1kGr1D
	Cr9rKrs7trn7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAwI63UUUUU==
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEAngqmVOEAsnowABsm

Even though css_clear_dir would be called to cleanup
all existing cgroup files when css_populate_dir failed,
reclaiming newly created cgroup files before
css_populate_dir returns with failure makes code more
consistent.

Signed-off-by: David Wang <00107082@163.com>
---
 kernel/cgroup/cgroup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a66c088c851c..6c255b5a331f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1744,8 +1744,11 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
 			if (cgroup_psi_enabled()) {
 				ret = cgroup_addrm_files(css, cgrp,
 							 cgroup_psi_files, true);
-				if (ret < 0)
+				if (ret < 0) {
+					cgroup_addrm_files(css, cgrp,
+							   cgroup_base_files, false);
 					return ret;
+				}
 			}
 		} else {
 			ret = cgroup_addrm_files(css, cgrp,
-- 
2.39.2


