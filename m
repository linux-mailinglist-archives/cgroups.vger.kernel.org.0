Return-Path: <cgroups+bounces-15322-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yD3uGhcs4WmQqAAAu9opvQ
	(envelope-from <cgroups+bounces-15322-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 20:36:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C26C6413C68
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 20:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 255E4303743F
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF49338592;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbroIOnr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5199331195C;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776364483; cv=none; b=FPvWrfJtF5nFBJfV5lZIY5lSP7WZX569Dp1ZrPfOkZEcPC5tzQKbcR4zQ1I6tWxG7lPTmxVc930VE7uY7UfT6qJ4QwnesTvaH4JgaEoVtQo951WXLRnp1Pn6T9Y3r6Xpi+4yVFjI8uUJdMvchXKlWy/UMqnNNPRat0ug/TN0yDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776364483; c=relaxed/simple;
	bh=BXHKITIYR9dCL2Vx1b1VPQ93m5+HvBPWS+sjmunJ/Dc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tMKBSMpV6bjOe9Ub+hchyB4bV4+N6brKuHRWkHHhp328MUKFQ9Hf/cBuhD5t0Fn8vQISL13PiMr4x3wv4s8KCOBe0dxhJxAkUVQkplUA4Kn/I3gs3JTYw/iOuVm1tQ6MjgFaj+hkq530t6t1A5S9CIp9mWQTLwn/7HhTULELjAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbroIOnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEB22C2BCAF;
	Thu, 16 Apr 2026 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776364483;
	bh=BXHKITIYR9dCL2Vx1b1VPQ93m5+HvBPWS+sjmunJ/Dc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NbroIOnrLU5kas0PZdzFYUMIs1J5gD74b13aTHTKfge8ly4Wuha6A+6t92vgNWl6A
	 oW15AUdhyOSfaJYv0o2W4kzOqRPZo0K94/jgBICHXznnVd4fpvN5rP1icFf49z2Mol
	 Yu+ddV5wU11U+F07Osuh7smb/S4KTM1AEvrpAlQVnsYWBTRvnROhOFgek02wzgq+Ba
	 tTHGTQiOzLi2l7kx6rzaq+35un27XKwJVXz1uUKmC8deJJsRddK5UUTfjyrVqDo4jw
	 xxepa8qugG55fnjZ+EWZUS8oQ0N/imO5LhUeqhXj3nevLwabRWbOpOh8x6+hX21T9t
	 hyNUz4P1DI5KQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58FBF8D755;
	Thu, 16 Apr 2026 18:34:42 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Subject: [PATCH v2 00/11] mm, swap: swap table phase IV: unify allocation
 and reduce static metadata
Date: Fri, 17 Apr 2026 02:34:30 +0800
Message-Id: <20260417-swap-table-p4-v2-0-17f5d1015428@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MQQ6CMBCF4auQWTum04BQV9zDsChllCZamrapG
 sLdrbhz+b/kfStEDpYjnKsVAmcb7eJKyEMFZtbuxmin0iCFPAkiwvjUHpMe74y+RtUxKzlq3Zo
 ayscHvtrX7l2G0rONaQnvnc/0XX+SlOJPyoQCSdStaiZSHTV9YmfYpaNZHjBs2/YBk6KawqwAA
 AA=
X-Change-ID: 20260111-swap-table-p4-98ee92baa7c4
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Youngjun Park <youngjun.park@lge.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>, 
 Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 Yosry Ahmed <yosry@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776364480; l=5811;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=BXHKITIYR9dCL2Vx1b1VPQ93m5+HvBPWS+sjmunJ/Dc=;
 b=IU5E1/nRV4QCH5MXlxelv6ZepS2DIxshXrThYr+GU3vZV76EwpKD55OJiQKsoOeLOme/rvOqv
 AbmPyQcE1FWBc8clLt+w8aonn2iblhYd0HhfMKtPKy7o2K78lRxcY2M
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15322-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,tencent.com,arm.com,suse.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tencent.com:replyto,tencent.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C26C6413C68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series unifies the allocation and charging of anon and shmem swap
in folios, provides better synchronization, consolidates the metadata
management, hence dropping the static cgroup array, and improves the
performance. The static metadata overhead is now close to zero, and
workload performance is slightly improved.

The swap cgroup static array is gone, eliminating most static swap data.
For example, for mounting a 1TB swap device, this saves about 512MB of
memory:

Before:
free -m
          total   used      free   shared   buff/cache   available
Mem:       1464    805       346        1          382         658
Swap:   1048575      0   1048575

After:
free -m
          total   used      free   shared   buff/cache   available
Mem:       1464    277       899         1         356        1187
Swap:   1048575      0   1048575

Memory usage is ~512M lower, and we now have a close to 0 static overhead. It was about 2 bytes per slot before, now roughly 0.09375 bytes per slot (48 bytes ci info per cluster, which is 512 slots).

Performance test is also looking good, testing Redis in a 1.5G VM using
5G ZRAM as swap:

valkey-server --maxmemory 2560M
redis-benchmark -r 3000000 -n 3000000 -d 1024 -c 12 -P 32 -t get

Before: 3048028.953125 RPS
After:  3068843.321429 RPS (0.68% better)

Testing with build kernel under global pressure on a 48c96t system,
limiting the total memory to 8G, using 12G ZRAM, 24 test runs,
enabling THP:

make -j96, using defconfig

Before: user time 2904.59s system time 4773.99s
After:  user time 2909.38s system time 4641.55s (2.77% better)

Testing with usemem on a 32c machine using 48G ramdisk and 16G RAM, 6
test run:

usemem --init-time -O -y -x -n 48 1G

Before: Throughput (Sum): 6011.33 MB/s Free Latency: 401097.13us
After:  Throughput (Sum): 6078.67 MB/s Free Latency: 390860.36us

Seems similar, or slightly better.

This series also reduces memory thrashing, I no longer see any:
"Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF", it was
shown several times during stress testing before this series when under
great pressure.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
Changes in v2:
- Drop the RFC prefix and also the RFC part.
- Now there is zero change to cgroup or refault tracking, RFC v1 changed
  some cgroup behavior. To archive that v2 use a standalone memcg_table
  for each cluster. It can be dropped or better optimized later if we
  have a better solution. The performance gain is partly cancelled
  compared to RFC v1 since we now need an extra allocation for free cluster
  isolation and peak memory usage is 2 bytes higher. But still looking
  good. That table size is accetable (1024 bytes), no RCU needed, and
  fits for kmalloc. Even if we keep it as it is in the future,
  it's still accetable.
- Link to v1: https://lore.kernel.org/r/20260220-swap-table-p4-v1-0-104795d19815@tencent.com

To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Youngjun Park <youngjun.park@lge.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosry@kernel.org>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Hugh Dickins <hughd@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org

---
Kairui Song (11):
      mm, swap: simplify swap cache allocation helper
      mm, swap: move common swap cache operations into standalone helpers
      mm/huge_memory: move THP gfp limit helper into header
      mm, swap: add support for stable large allocation in swap cache directly
      mm, swap: unify large folio allocation
      mm/memcg, swap: tidy up cgroup v1 memsw swap helpers
      mm, swap: support flexible batch freeing of slots in different memcg
      mm/swap: delay and unify memcg lookup and charging for swapin
      mm/memcg, swap: store cgroup id in cluster table directly
      mm/memcg: remove no longer used swap cgroup array
      mm, swap: merge zeromap into swap table

 MAINTAINERS                 |   1 -
 include/linux/huge_mm.h     |  30 +++
 include/linux/memcontrol.h  |  16 +-
 include/linux/swap.h        |  19 +-
 include/linux/swap_cgroup.h |  47 ----
 mm/Makefile                 |   3 -
 mm/huge_memory.c            |   2 +-
 mm/internal.h               |   5 -
 mm/memcontrol-v1.c          |  66 ++++--
 mm/memcontrol.c             |  32 +--
 mm/memory.c                 |  88 ++------
 mm/page_io.c                |  58 ++++-
 mm/shmem.c                  | 122 +++--------
 mm/swap.h                   |  72 ++----
 mm/swap_cgroup.c            | 172 ---------------
 mm/swap_state.c             | 519 +++++++++++++++++++++++++-------------------
 mm/swap_table.h             | 134 ++++++++++--
 mm/swapfile.c               | 121 +++++++----
 mm/vmscan.c                 |   2 +-
 mm/zswap.c                  |  25 +--
 20 files changed, 709 insertions(+), 825 deletions(-)
---
base-commit: db2a1695b2b6feb071b47b72e61d0359bf1524bf
change-id: 20260111-swap-table-p4-98ee92baa7c4

Best regards,
--  
Kairui Song <kasong@tencent.com>



