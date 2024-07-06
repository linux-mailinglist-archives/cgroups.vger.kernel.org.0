Return-Path: <cgroups+bounces-3558-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256D392935B
	for <lists+cgroups@lfdr.de>; Sat,  6 Jul 2024 13:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FE51F21CE8
	for <lists+cgroups@lfdr.de>; Sat,  6 Jul 2024 11:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63846A33F;
	Sat,  6 Jul 2024 11:45:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6FC481D5;
	Sat,  6 Jul 2024 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720266336; cv=none; b=AQzCtCyzmOu4+KuCNMJoETKCpeUJdV5Sjao3NzPcCHg3tKm33UXD2jto6xLojY3ZFl7ARt2zDHRxH+wrchGormW5SPLG2cYe8yDWHuxJFxaSuNc+tbnOU+kAMS+iQT5Yg6/BDuBtzlVaMZm1Ik/0B/YTynlOgYSzononzpbQ71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720266336; c=relaxed/simple;
	bh=dvPIjigUQi/mcN9lemwwdOKYmiHueQFcRpQHDFRxpQs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E7J3m5WzIDuwSqH8Y5qoIzRZeIvlH4trXzNQ4RtcEnaZLgTTzsMFGEjYi1QFEETsAlddhQ8IuDhyeIvt6hTgzlLULDyp2P7mRG8Ov2ALesKY3+ocwOElXi/Mu+/uc7/h2Igc6CKsrmQNtM1Zq2bojzbl5tHopoqQzd/hL6ZTwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WGT3M3JgZz1T5Q7;
	Sat,  6 Jul 2024 19:40:47 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id C523D180AA6;
	Sat,  6 Jul 2024 19:45:24 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 6 Jul
 2024 19:45:24 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup: distinguish name and legacy_name when show /proc/cgroups
Date: Sat, 6 Jul 2024 11:38:30 +0000
Message-ID: <20240706113830.1612319-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)

Subsys_name may be different between v1 and v2. In cgroup v2
blk subsys_name is io, while it is named blkio in cgroup v1.
It better to distinguish name and legacy_name when we cat /proc/cgroups.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cgroup-v1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index b9dbf6bf2779..b29252ad91b6 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -677,7 +677,8 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 
 	for_each_subsys(ss, i)
 		seq_printf(m, "%s\t%d\t%d\t%d\n",
-			   ss->legacy_name, ss->root->hierarchy_id,
+			   ss->root == &cgrp_dfl_root ? ss->name : ss->legacy_name,
+			   ss->root->hierarchy_id,
 			   atomic_read(&ss->root->nr_cgrps),
 			   cgroup_ssid_enabled(i));
 
-- 
2.34.1


