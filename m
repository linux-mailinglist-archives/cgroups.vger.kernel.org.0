Return-Path: <cgroups+bounces-10346-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2623CB915D2
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 15:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB40018A5D69
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 13:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DF130C35F;
	Mon, 22 Sep 2025 13:17:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEB02FFFA9;
	Mon, 22 Sep 2025 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547078; cv=none; b=HnguW7afvjUwRyQ08GAgyJMzJsH8IJVIug7NLq0FZmVWQjFJbf1uYgNS06C/JM8h4SMg1sVz1daKmSm0WOhx4sUuXMaUCZeXF7vi0MXRRcb1BjcQ7+tQIR86zx9yZQ/zJhkAQL5RizdjKOmP23LvDiHmaykRJpFCUijSuH92RXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547078; c=relaxed/simple;
	bh=efJGHGCHhV+obYIiiG66T6XohqvtYfdqB+tVJXDGaCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iyQUKdUzxGTDoxCK4OyCtOQi/PUegtV0LsTY7CJXqD0UexDqnLJ9OSa+u02HBV5eEHBtdbWpNHojrW/GkyHRESc3x8vIu71Mnzz2D7/861kOV4C8tTkgvNccxcuSbGVbTUfHQ9+c/iyc08YEAqEY60Bo9NO8hIpcS5MC7jzxlH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cVkDs6hpPzYQvS8;
	Mon, 22 Sep 2025 21:17:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 452871A17FD;
	Mon, 22 Sep 2025 21:17:54 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCH0hZ3TNFoBhXHAQ--.54770S3;
	Mon, 22 Sep 2025 21:17:54 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 1/3] cpuset: remove redundant special case for null input in node mask update
Date: Mon, 22 Sep 2025 13:02:31 +0000
Message-Id: <20250922130233.3237521-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922130233.3237521-1-chenridong@huaweicloud.com>
References: <20250922130233.3237521-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCH0hZ3TNFoBhXHAQ--.54770S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWDWF4DXFy5Gr1DGry8Zrb_yoW8XFy5pF
	W3Ga12krWrJF1akws5t39xWFy7K3W8JFW3tFsIqw1fCasIy3ZFkF1DWasxAFW7JF93uay5
	Jr4FyrW0939rt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	7qjgUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The nodelist_parse function already handles empty nodemask input
appropriately, making it unnecessary to handle this case separately
during the node mask update process.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 535174ed7126..20dface3c3e0 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2847,22 +2847,16 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
 
 	/*
 	 * An empty mems_allowed is ok iff there are no tasks in the cpuset.
-	 * Since nodelist_parse() fails on an empty mask, we special case
-	 * that parsing.  The validate_change() call ensures that cpusets
-	 * with tasks have memory.
+	 * The validate_change() call ensures that cpusets with tasks have memory.
 	 */
-	if (!*buf) {
-		nodes_clear(trialcs->mems_allowed);
-	} else {
-		retval = nodelist_parse(buf, trialcs->mems_allowed);
-		if (retval < 0)
-			goto done;
+	retval = nodelist_parse(buf, trialcs->mems_allowed);
+	if (retval < 0)
+		goto done;
 
-		if (!nodes_subset(trialcs->mems_allowed,
-				  top_cpuset.mems_allowed)) {
-			retval = -EINVAL;
-			goto done;
-		}
+	if (!nodes_subset(trialcs->mems_allowed,
+			  top_cpuset.mems_allowed)) {
+		retval = -EINVAL;
+		goto done;
 	}
 
 	if (nodes_equal(cs->mems_allowed, trialcs->mems_allowed)) {
-- 
2.34.1


