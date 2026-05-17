Return-Path: <cgroups+bounces-16010-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9pEDLiLiCWokuAQAu9opvQ
	(envelope-from <cgroups+bounces-16010-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 17:43:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13376562127
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 17:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AABB3045A90
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FADA3BD246;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6ohR27T"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E2C3B9604;
	Sun, 17 May 2026 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032389; cv=none; b=badZJg14MxxcKpFBdmlqIJlJTbevDMW+4YjKQIsnhRltPvfOaXm+EMBJKulA9VSg1lSHyAcuByqFGakdkUDmwX2vsc1gZn9VlZHr43LZpH0w1Os73XvrVdrD+LcLywPgIhYLC7T7sb1oo8U5AXAZDhM7OKe09dwM36MBK5zP8VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032389; c=relaxed/simple;
	bh=HOQoFVcJQQw1qsYaDyBIUm7Bruv614kawN5bFHpz2ig=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FqCyeqB7x51KwWn/32XZwVObx0ybGBfSPGEEjc4uRUhJrXVIPbZKaucEkDph2O8DbsD/ywf8W+9LOFvw4rcFNOgrmdDFeuUCaw+sICmtp+eqRSenfXWY87d+kuAGnz7pLjNdme0epBXhwuvnkOSfRjmRmct28VPxrRrkXys0otQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6ohR27T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93DE5C2BCB0;
	Sun, 17 May 2026 15:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779032388;
	bh=HOQoFVcJQQw1qsYaDyBIUm7Bruv614kawN5bFHpz2ig=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=S6ohR27T8HnO+q3YluMoTXeCRRAXwNBv6bdk9J9Q0jjXKO6OqJCsRZVq5ylRjyjth
	 ZwUDU7zH8B3OVNrgs3QpKp1/zSCLGpTCVZqtgDhTvgG5UaF4QxBgz8+v7Ia6p/UtI4
	 sHCgmG5u+KSEXtLIavttryH0Rw2YGeIMeH/U2RsTwtL/XxnHBXqMvDHCJymQ1X7Mc0
	 qSU8kEbPWxzPmi4ZB+rpwH6DzttQ5o9oxhG2foYpPlSe7jZHgEW+bzr0dk+Aps5noI
	 t3LwAAb21RIQtWzZSD+x9hjn1/VMyQCOgQfVAX6rWMjiQ1SNbo0/J4vLl0HBVZK7y8
	 AQk/uinpOI5BQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80157CD4F3D;
	Sun, 17 May 2026 15:39:48 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Subject: [PATCH v5 00/12] mm, swap: swap table phase IV: unify allocation
 and reduce static metadata
Date: Sun, 17 May 2026 23:39:39 +0800
Message-Id: <20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XPQW7CMBCF4asgr3HlmYyxzYp7VCwcZ1IslSSKI
 xcU5e44dEEblm+k75dmFonHyEkcd7MYOccU+64Mvd+JcPHdF8vYlC1Q4UEBgEw/fpCTr79ZDiS
 dZXZYe28CiWKGkdt4e/Y+z2VfYpr68f7MZ1ivvyVEtSllkEqCIuN0A86CPk3cBe6mj9BfxdrK+
 PIEZutx9aYtWoEmtO+++uNx+0muiscWK6OdN4c6vHt6eQ1666n4FmpybEl72/z3y7I8ALAFmGh
 sAQAA
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
 Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Yosry Ahmed <yosry@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779032385; l=6878;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=Yo/KeeDl/gBTDmA1BNP9TneN6E9dK8IEKyHla6LQWNw=;
 b=RUeY0aaNeQw+Ef/5Ftnfxmbj/rQuTIh5cfUj05zmQudQoO9TE71PdgxpMvvbsLihRHuuvX+xt
 eXTACL0NKG+AFDGhLBu0CWijwe1Fi20WChs0VLjKEhiVboGyYPancUe
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Rspamd-Queue-Id: 13376562127
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16010-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,vger.kernel.org,tencent.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tencent.com:mid,tencent.com:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

This series unifies the allocation and charging of anon and shmem swap
in folios, provides better synchronization, consolidates the metadata
management, hence dropping the static array and map, and improves the
performance. The static metadata overhead is now close to zero, and
workload performance is slightly improved.

For example, mounting a 1TB swap device saves about 512MB of memory:

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

Memory usage is ~512M lower, and we now have a close to 0 static
overhead. It was about 2 bytes per slot before, now roughly 0.09375
bytes per slot (48 bytes ci info per cluster, which is 512 slots).

Performance test is also looking good, testing Redis in a 2G VM using
6G ZRAM as swap:

valkey-server --maxmemory 2560M
redis-benchmark -r 3000000 -n 3000000 -d 1024 -c 12 -P 32 -t get

Before: 3385017.283654 RPS
After:  3433309.307292 RPS (1.42% better)

Testing with build kernel under global pressure on a 48c96t system,
limiting the total memory to 8G, using 12G ZRAM, 24 test runs,
enabling THP:

make -j96, using defconfig

Before: user time 2904.59s system time 4773.99s
After:  user time 2909.38s system time 4641.55s (2.77% better)

Testing with usemem on a 32c machine using 48G brd ramdisk and 16G
RAM, 12 test run:

usemem --init-time -O -y -x -n 48 1G

Before: Throughput (Sum): 6482.58 MB/s Free Latency: 371371.67us
After:  Throughput (Sum): 6539.28 MB/s Free Latency: 363059.88us

Seems similar, or slightly better.

This series also reduces memory thrashing, I no longer see any:
"Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF", it was
shown several times during stress testing before this series when under
great pressure:

Before: grep -Ri VM_FAULT_OOM <test logs> | wc -l => 18
After:  grep -Ri VM_FAULT_OOM <test logs> | wc -l => 0

Signed-off-by: Kairui Song <kasong@tencent.com>
---
Changes in v5:
- Fix error with !CONFIG_TRANSPARENT_HUGEPAGE:
  https://lore.kernel.org/linux-mm/agcdxIFQ8QBI9R6z@KASONG-MC4/
  The actual fix applied is different since the posted one forgot to
  check `orders` as loop breaking condition.
- Improve mem policy interleave in patch 5:
  https://lore.kernel.org/linux-mm/CAMgjq7AqKskE5UVivTEdPzmTa09_aapWZM7JeSshhmf-4GYbZw@mail.gmail.com/
- Retest is still looking good.
- Link to v4: https://patch.msgid.link/20260515-swap-table-p4-v4-0-f1b49e845a8d@tencent.com

Changes in v4:
- Rebased on latest mm-unstable and re-test, benchmark results are
  basically the same so mostly kept unchanged. Changes in v4 are code
  style and very minor behavior change.
- Improve a few commit messages, rename a few variables as suggested by
  [ Chris Li ].
- Rename thp_limit_gfp_mask to thp_shmem_limit_gfp_mask as suggested by
  [ Zi Yan ].
- Cleanup a few allocation and code style issue [ YoungJun Park ]
- Remove the forced fallback in swap_cache_alloc_folio, the caller will
  pass in the exact orders to be used. [ Baolin Wang ]
- Rename swapin_entry to swapin_sync, it's only used by synchronization
  devices at this moment and describes what it does better
  [ David Hildenbrand ]
- Link to v3: https://patch.msgid.link/20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com

Changes in v3:
- This is based on mm-unstable, also applies to mm-new, and has no
  conflict with YoungJun's tier series, and only trivial conflict with
  Baoquan's swapops due to filename change.
- Fix zero map build issue on 32 bit archs [ YoungJun Park ]
- Cleanup memcg table allocation helpers [ YoungJun Park ]
- Fix WARN for non NUMA build:
  https://lore.kernel.org/linux-mm/CAMgjq7ANih7u7SJB8uWcQHS8XRJySNRc3ti9V-SVey0nGE3gLQ@mail.gmail.com/
- Improve of commit messages.
- Re-test several tests, the conclusion is the same as v2.
- Link to v2: https://patch.msgid.link/20260417-swap-table-p4-v2-0-17f5d1015428@tencent.com

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

---
Kairui Song (12):
      mm, swap: simplify swap cache allocation helper
      mm, swap: move common swap cache operations into standalone helpers
      mm/huge_memory: move THP gfp limit helper into header
      mm, swap: add support for stable large allocation in swap cache directly
      mm, swap: unify large folio allocation
      mm/memcg, swap: tidy up cgroup v1 memsw swap helpers
      mm, swap: support flexible batch freeing of slots in different memcgs
      mm, swap: delay and unify memcg lookup and charging for swapin
      mm, swap: consolidate cluster allocation helpers
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
 mm/internal.h               |  11 +-
 mm/memcontrol-v1.c          |  66 ++++--
 mm/memcontrol.c             |  31 ++-
 mm/memory.c                 |  91 ++------
 mm/page_io.c                |  61 +++++-
 mm/shmem.c                  | 130 +++--------
 mm/swap.h                   |  91 +++-----
 mm/swap_cgroup.c            | 174 ---------------
 mm/swap_state.c             | 523 +++++++++++++++++++++++++-------------------
 mm/swap_table.h             | 179 ++++++++++++---
 mm/swapfile.c               | 215 +++++++++---------
 mm/vmscan.c                 |   2 +-
 mm/zswap.c                  |  25 +--
 20 files changed, 814 insertions(+), 903 deletions(-)
---
base-commit: 444fc9435e57157fcf30fc99aee44997f3458641
change-id: 20260111-swap-table-p4-98ee92baa7c4

Best regards,
--  
Kairui Song <kasong@tencent.com>



