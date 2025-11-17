Return-Path: <cgroups+bounces-12012-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D42C622DB
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 04:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30DB13A4070
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 03:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7775526738B;
	Mon, 17 Nov 2025 03:01:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F39244687;
	Mon, 17 Nov 2025 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348508; cv=none; b=Ek0wZ6pxj9HkdP7yIDc5/is10+YEob/5OV/CxGwK2gcOpy6JJuD+HqynONO9NkcwYrvZG8/5ilb+bUSspHbo+w9QnNQnUUGwkZ9KPlwdzkLFwbJJhXCzkZt2FSv7FD5d3k5JslRdM4r+bdHd60BPQsam/Bg4ZE8LzpR2ZjaEJeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348508; c=relaxed/simple;
	bh=KaXxufi6am8CSJEMN7gZoT7SpDaxr5a3WGQda8jI9xg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=D6ubjyOnEGXZtCPbxPCjLAMh0Ux6db2rRCsQoWDe0P9MFmEK7S9MMn+fkjJFn8QuLhaltdo891Ha6OUgrI16NILGakMUI9DXVzKNAuv35FGuplLmQSK8Wfe4LZf+kjVJi/2Cgfha3zlzKj3zU9Z7heLejLxiaRZpfr6w1Ch5pIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d8svX5yqwzKHMLV;
	Mon, 17 Nov 2025 11:01:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5B1DF1A07BD;
	Mon, 17 Nov 2025 11:01:37 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgA3lHr5jxpp+kwRBA--.27716S2;
	Mon, 17 Nov 2025 11:01:37 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 00/21] cpuset: rework local partition logic
Date: Mon, 17 Nov 2025 02:46:06 +0000
Message-Id: <20251117024627.1128037-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3lHr5jxpp+kwRBA--.27716S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr15CrWxZFWUAr4DJw1DKFg_yoW5KFy7pF
	y3GaySyryUGFy5C39rXa1xAw4Fgw4DJa4Utwnru348Xr1ayw1vyFy0v395ZayUWr9rZr1U
	Z3ZrWr48X3WUuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The current local partition implementation consolidates all operations
(enable, disable, invalidate, and update) within the large
update_parent_effective_cpumask() function, which exceeds 300 lines.
This monolithic approach has become increasingly difficult to understand
and maintain. Additionally, partition-related fields are updated in
multiple locations, leading to redundant code and potential corner case
oversights.

This patch series refactors the local partition logic by separating
operations into dedicated functions: local_partition_enable(),
local_partition_disable(), and local_partition_update(), creating
symmetry with the existing remote partition infrastructure.

The series is organized as follows:

1. Infrastructure Preparation (Patches 1-2):
   - Code cleanup and preparation for the refactoring work

2. Introduce partition operation helpers (Patches 3-5):
   - Introduce out partition_enable(), partition_disable(), and
     partition_update() functions.

3. Use new helpers for remote partition (Patches 6-8)

4. Local Partition Implementation (Patches 9-12):
   - Separate update_parent_effective_cpumask() into dedicated functions:
     * local_partition_enable()
     * local_partition_disable()
     * local_partition_update()

5. Optimization and Cleanup (Patches 13-21):
   - Remove redundant partition-related operations
   - Additional optimizations based on the new architecture

base-commit: 6d7e7251d03f98f26f2ee0dfd21bb0a0480a2178

---

Changes from RFC v2:
1. Dropped the bugfix (already merged/fixed upstream)
2. Rebased onto next
3. Introduced partition_switch to handle root state switches
4. Directly use local_partition_disable()—no longer first introduce
   local_partition_invalidate() before unifying the two
5. Incorporated modifications based on Longman's suggestions

Changes in RFC v1:
1. Added bugfix for root partition isolcpus at series start.
2. Completed helper function implementations when first introduced.
3. Split larger patches into smaller, more reviewable units.
4. Incorporated feedback from Longman.

Chen Ridong (21):
  cpuset: add early empty cpumask check in partition_xcpus_add/del
  cpuset: generalize the validate_partition() interface
  cpuset: introduce partition_enable()
  cpuset: introduce partition_disable()
  cpuset: introduce partition_update()
  cpuset: use partition_enable() for remote partition enablement
  cpuset: use partition_disable() for remote partition disablement
  cpuset: use partition_update() for remote partition update
  cpuset: introduce local_partition_enable()
  cpuset: introduce local_partition_disable()
  cpuset: user local_partition_disable() to invalidate local partition
  cpuset: introduce local_partition_update()
  cpuset: remove update_parent_effective_cpumask
  cpuset: remove redundant partition field updates
  cpuset: simplify partition update logic for hotplug tasks
  cpuset: use partition_disable for compute_partition_effective_cpumask
  cpuset: use validate_local_partition in local_partition_enable
  cpuset: introduce validate_remote_partition
  cpuset: simplify the update_prstate() function
  cpuset: remove prs_err clear when notify_partition_change
  cpuset: Remove unnecessary validation in partition_cpus_change

 kernel/cgroup/cpuset.c | 1014 ++++++++++++++++++----------------------
 1 file changed, 453 insertions(+), 561 deletions(-)

-- 
2.34.1


