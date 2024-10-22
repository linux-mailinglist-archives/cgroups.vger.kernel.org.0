Return-Path: <cgroups+bounces-5180-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7389AA18F
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 13:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6D81F236A7
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 11:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647D619CCF5;
	Tue, 22 Oct 2024 11:58:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973D19CC32
	for <cgroups@vger.kernel.org>; Tue, 22 Oct 2024 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598308; cv=none; b=nuu8g5ODSFA4CsduBElwdjUvHFoISY8NUE8T7rUe5TuOvADEgevrn2GnMu/bEBoYpPAodqKQb0xA2cy04XbUHfBwP1jW0N6rzd/qX7V72gu70mtZgFVYZ1Q/QrEuHgxBDdRvP1Nyap1NOTKHq3Uste/cpo9voMdGm3PCq4Awcao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598308; c=relaxed/simple;
	bh=vapUWn7Z/N1UbshnDpuCmPnFVPIPqQ9R8bkaqK6LUUU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ibWjhUq5iw4Vf7uwF6SWyNUepvouOzXRKwWPkXSS0z5vI6083b/XzXSAiqq/hXXH1M2A01a0u2p1P5jmRy4K+MNze4TazzJlH1Xud9Hccai/loRcMiBT4JuJ/FH+XcSEt0lhCYXK3/0+RzBWmsNNVARwRg6UMo2BpMWACDJT4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXrKR2Hgfz4f3nV5
	for <cgroups@vger.kernel.org>; Tue, 22 Oct 2024 19:58:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7F8251A058E
	for <cgroups@vger.kernel.org>; Tue, 22 Oct 2024 19:58:21 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgAXtoJTkxdnHcucEg--.31107S2;
	Tue, 22 Oct 2024 19:58:21 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	longman@redhat.com,
	adityakali@google.com,
	sergeh@kernel.org,
	mkoutny@suse.com,
	guro@fb.com
Cc: cgroups@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH -next v4 0/2] Some optimizations about freezer
Date: Tue, 22 Oct 2024 11:49:44 +0000
Message-Id: <20241022114946.811862-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXtoJTkxdnHcucEg--.31107S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYm7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wASzI0E
	04IjxsIE14AKx2xKxwAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr
	I_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0E
	wIxGrwACI402YVCY1x02628vn2kIc2xKxwAKzVC20s0267AEwI8IwI0ExsIj0wCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r1j6r18MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The e_freeze flag has been changed to a bool type, which will reduce
unnecessary looping when the freezer state does not change. This patch
set adds helpers to make the code more concise.

Both patch 1 and patch 2 have been reviewed by Michal Koutný.
The patch for v3 was dropped, because there was no good idea to make the
code much more readable and reduce unesessary loops.

---

v4:
- drop patch 3, which may make the "cgroup_propagate_frozen" function hard
  to read.

v3:
- fix build warnings reported-by kernel test robot.

v2:
- open code inside the loop of cgroup_freeze instead of inline function.
- add helper to make code concise.
- remove selftest script(There are hierarchy test in test_freeze.c, I
  think that is enough for this series).

Chen Ridong (2):
  cgroup/freezer: Reduce redundant traversal for cgroup_freeze
  cgroup/freezer: Add cgroup CGRP_FROZEN flag update helper

 include/linux/cgroup-defs.h |  2 +-
 kernel/cgroup/freezer.c     | 97 ++++++++++++++++++-------------------
 2 files changed, 47 insertions(+), 52 deletions(-)

-- 
2.34.1


