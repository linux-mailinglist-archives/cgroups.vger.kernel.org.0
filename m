Return-Path: <cgroups+bounces-1179-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2028354B4
	for <lists+cgroups@lfdr.de>; Sun, 21 Jan 2024 07:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9BC1F2371E
	for <lists+cgroups@lfdr.de>; Sun, 21 Jan 2024 06:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557236135;
	Sun, 21 Jan 2024 06:13:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E02FBF0;
	Sun, 21 Jan 2024 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705817636; cv=none; b=eWYu4SHn3nyFVC+EN9gLnP/ZYp20DC6532WbPH26l9qocIOzEza9nHe3Ovt7KA+NVh8BX9oq6RN2SNy1HAN90SGEjGllcBJj8wTCnsbSRjQ71wTwnSE2BuBrz+G9PQuiOZWfFFPek56/+H+xp5YkL4QCXWVkI3VxuZEYtvodw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705817636; c=relaxed/simple;
	bh=zWi6IXc9w1aSdxovTTnpQLwjJKktzyOvnzXmRiOlmvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uOe5oMU6slMF0A2ygmDZf2cIhTiSWZ0+clNnrqQtfOYCwcER2oOW5TNh0duRuQeXkd65PM5T4x/A6oRIIWirzm8QkcG5z2fIP4CKcXAUZjMX+Cia6UVmMwmx5hhBtgDcZf2NOOO7uGVzRlso8/Nw4HD/jT7mphwa4DO5+fjR5HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ict.ac.cn; spf=pass smtp.mailfrom=ict.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ict.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ict.ac.cn
Received: from localhost.localdomain (unknown [125.59.207.199])
	by APP-05 (Coremail) with SMTP id zQCowAD3_moQtqxlgCh9CA--.59803S2;
	Sun, 21 Jan 2024 14:13:39 +0800 (CST)
From: lixinyu20s@ict.ac.cn
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	tj@kernel.org,
	Xinyu Li <lixinyu20s@ict.ac.cn>
Subject: [PATCH] docs: cgroup-v1: add missing code-block tags
Date: Sun, 21 Jan 2024 14:13:36 +0800
Message-Id: <20240121061336.3500233-1-lixinyu20s@ict.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3_moQtqxlgCh9CA--.59803S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF18tFyfurWDAF15WrW5GFg_yoW8Cr1Upr
	9rJryakw13GF9Fkr4xAa1DZr17tw1kWrWj9ryxJw4fGrnxW34xWryIgr1Yqws7ur4fJay8
	ZrW7XF9Ivr4jg3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvI14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC
	0wCY02Avz4vE5cC_GF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
	9x0JUrGYLUUUUU=
X-CM-SenderInfo: pol0x0t1xsi2g6lf3hldfou0/

From: Xinyu Li <lixinyu20s@ict.ac.cn>

Hugetlb.rst lacks two code-block tags, causing a formatting issue.

Signed-off-by: Xinyu Li <lixinyu20s@ict.ac.cn>
---
 .../admin-guide/cgroup-v1/hugetlb.rst         | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
index 0fa724d82abb..493a8e386700 100644
--- a/Documentation/admin-guide/cgroup-v1/hugetlb.rst
+++ b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
@@ -65,10 +65,12 @@ files include::
 
 1. Page fault accounting
 
-hugetlb.<hugepagesize>.limit_in_bytes
-hugetlb.<hugepagesize>.max_usage_in_bytes
-hugetlb.<hugepagesize>.usage_in_bytes
-hugetlb.<hugepagesize>.failcnt
+::
+
+  hugetlb.<hugepagesize>.limit_in_bytes
+  hugetlb.<hugepagesize>.max_usage_in_bytes
+  hugetlb.<hugepagesize>.usage_in_bytes
+  hugetlb.<hugepagesize>.failcnt
 
 The HugeTLB controller allows users to limit the HugeTLB usage (page fault) per
 control group and enforces the limit during page fault. Since HugeTLB
@@ -82,10 +84,12 @@ getting SIGBUS.
 
 2. Reservation accounting
 
-hugetlb.<hugepagesize>.rsvd.limit_in_bytes
-hugetlb.<hugepagesize>.rsvd.max_usage_in_bytes
-hugetlb.<hugepagesize>.rsvd.usage_in_bytes
-hugetlb.<hugepagesize>.rsvd.failcnt
+::
+
+  hugetlb.<hugepagesize>.rsvd.limit_in_bytes
+  hugetlb.<hugepagesize>.rsvd.max_usage_in_bytes
+  hugetlb.<hugepagesize>.rsvd.usage_in_bytes
+  hugetlb.<hugepagesize>.rsvd.failcnt
 
 The HugeTLB controller allows to limit the HugeTLB reservations per control
 group and enforces the controller limit at reservation time and at the fault of
-- 
2.34.1


