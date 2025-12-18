Return-Path: <cgroups+bounces-12492-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E71CCB3E6
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 10:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89E6E300A352
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 09:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B4F31158A;
	Thu, 18 Dec 2025 09:46:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44130F93D;
	Thu, 18 Dec 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051201; cv=none; b=VmlJjMPnjYQXtkpiF8TShxSy0yZKDGwaaL5EcQfEy5i4Qi5a4XuQpDTKHljyUrqt8B5xybHxo85ecEr/1KDEc+FctMkcLYnd+1wNF9QY8oGlw4nPVrzFoqf9yzj/yQ652nfLMnl7z6F9nOtl1UoEhebvbKj+lj3qYLXybbj+xX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051201; c=relaxed/simple;
	bh=iGlWuQNOsBjwjVrz/y/m4l9JTIs5vu0A6APQ0ZuGMyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GIb/PSzJKbZmcZYm53XiKSgG9oJTWd5Z/5d0es0eWlAA7kQMKdvkJB2tR/y6+GZulats5A9Y7ocn577mWIiy/zTmv+bK8CRGKzGDoyv4iyLjEcAFztGEnOYQmy134w3fXDAeYbX3t7EZlqMCb/qgvuljejMUvgnGRDZszAFWiPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dX5Qp25SNzKHM02;
	Thu, 18 Dec 2025 17:46:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B5C9140575;
	Thu, 18 Dec 2025 17:46:36 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgA35vZxzUNpHcJzAg--.22754S2;
	Thu, 18 Dec 2025 17:46:36 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next v2 0/6] cpuset: further separate v1 and v2 implementations
Date: Thu, 18 Dec 2025 09:31:35 +0000
Message-Id: <20251218093141.2687291-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA35vZxzUNpHcJzAg--.22754S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyDJFyUXw1kGw13CFWUXFb_yoW8CF45pF
	93GFW3Xr1UCr1xuwnavw4UZrySqw4xJFWUtF13KryxAFsrA3WUCry293Z3ZryUuFy2krWj
	qF47tr4YgFyqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUU
	UUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Most of the v1-specific code has already been moved to cpuset-v1.c, but
some parts remain in cpuset.c, such as the handling of CS_SPREAD_PAGE,
CS_SPREAD_SLAB, and CGRP_CPUSET_CLONE_CHILDREN. These can also be moved
to cpuset-v1.c.

Additionally, several cpuset members are specific to v1, including
fmeter, relax_domain_level, and the uf_node node. These should only be
visible when v1 support is enabled (CONFIG_CPUSETS_V1).

This series relocates the remaining v1-specific code to cpuset-v1.c and
guards v1-only members with CONFIG_CPUSETS_V1.

The most significant change is the separation of generate_sched_domains()
into v1 and v2 versions. For v1, the original function is preserved
with v2-specific code removed, keeping it largely unchanged since v1 is
deprecated and receives minimal future updates. For v2, all v1-specific
code has been removed, resulting in a much simpler and more maintainable
implementation.

---

v2:
patch1: remame assert_cpuset_lock_held to lockdep_assert_cpuset_lock_held.
patch5: remove some unnecessary v1 code.
patch6: add comment before the goto generate_doms label in the v2 version.

Chen Ridong (6):
  cpuset: add lockdep_assert_cpuset_lock_held helper
  cpuset: add cpuset1_online_css helper for v1-specific operations
  cpuset: add cpuset1_init helper for v1 initialization
  cpuset: move update_domain_attr_tree to cpuset_v1.c
  cpuset: separate generate_sched_domains for v1 and v2
  cpuset: remove v1-specific code from generate_sched_domains

 include/linux/cpuset.h          |   2 +
 kernel/cgroup/cpuset-internal.h |  42 +++++-
 kernel/cgroup/cpuset-v1.c       | 241 +++++++++++++++++++++++++++++-
 kernel/cgroup/cpuset.c          | 253 +++++---------------------------
 4 files changed, 312 insertions(+), 226 deletions(-)

-- 
2.34.1


