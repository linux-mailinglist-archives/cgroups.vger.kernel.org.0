Return-Path: <cgroups+bounces-4931-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B2D97EB0C
	for <lists+cgroups@lfdr.de>; Mon, 23 Sep 2024 13:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15ACF280E3A
	for <lists+cgroups@lfdr.de>; Mon, 23 Sep 2024 11:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDAE198E63;
	Mon, 23 Sep 2024 11:52:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D78002A;
	Mon, 23 Sep 2024 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092357; cv=none; b=TXjbyc4Bz7P9kJT0zD33HP4I13fgAtIbfkiQCARJn1m3J3y5aFgCVPpZ+MdJarlPlJwKfDIVrR244YAAEd3RfMwiFQ3jHACHrS2zC46Vrbt2Z1TDPnWQbmpIa5e8ybyFMaO83fma6mzbMUCqX/WEBXO/aSuKXuBLFvFiCYw67Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092357; c=relaxed/simple;
	bh=BBff3cyxB2P0r+iByxqTQCiR3m+KKIyM0RieOmJ1nBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=anjAk+R9p77rX+9YFXX5HG2idsVuvz0w5UEOMy+Yrjd7fHW7QIH1L4wRL+DoY7w+OjelrAag27nBOrDYSfFyv2vWmeZqMkny4lxWdsFPvcS7EZ7D66KCdaEbYR0uUvBq3FrwZt25L7RdRQQIHSEPQLsGxLbNygw3QjWUdGadEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XC1ZD67KYz4f3jq9;
	Mon, 23 Sep 2024 19:52:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 00E4C1A0359;
	Mon, 23 Sep 2024 19:52:31 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgCHKYZlVvFmONo3CA--.32773S4;
	Mon, 23 Sep 2024 19:52:31 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	longman@redhat.com,
	mkoutny@suse.com,
	chenridong@huawei.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] workqueue: doc: Add a note saturating the system_wq is not permitted
Date: Mon, 23 Sep 2024 11:43:51 +0000
Message-Id: <20240923114352.4001560-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240923114352.4001560-1-chenridong@huaweicloud.com>
References: <20240923114352.4001560-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCHKYZlVvFmONo3CA--.32773S4
X-Coremail-Antispam: 1UD129KBjvJXoWrKry3XF4UCFWUGry7tF43Wrg_yoW8JF17pr
	WfCF1aqw1kJr12kas5JrnruFy7GF18CFsrGFs7t3yIvFn8Jr92gw1xKryFqas8JryfuFy8
	ZF92q3s0y34jvrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcTmhUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

If something is expected to generate large number of concurrent works,
it should utilize its own dedicated workqueue rather than system wq.
Because this may saturate system_wq and potentially block other's works.
eg, cgroup release work. Let's document this as a note.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 Documentation/core-api/workqueue.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 16f861c9791e..9de622188f2f 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -357,6 +357,11 @@ Guidelines
   difference in execution characteristics between using a dedicated wq
   and a system wq.
 
+  Note: If something is expected to generate a large number of concurrent
+  works, it should utilize its own dedicated workqueue rather than
+  system wq. Because this may saturate system_wq and potentially lead
+  to deadlock.
+
 * Unless work items are expected to consume a huge amount of CPU
   cycles, using a bound wq is usually beneficial due to the increased
   level of locality in wq operations and work item execution.
-- 
2.34.1


