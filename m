Return-Path: <cgroups+bounces-13568-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OWKjHeb7fWkmUwIAu9opvQ
	(envelope-from <cgroups+bounces-13568-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 13:56:06 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBC9C1D62
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 13:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FDEB300B76F
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 12:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B9E258EE0;
	Sat, 31 Jan 2026 12:56:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E414238C08
	for <cgroups@vger.kernel.org>; Sat, 31 Jan 2026 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769864160; cv=none; b=aUbKV0NUKeTDlBsqtd52QjG7Ky+hYdGRtETcy2tQSe+QDom0Kyjyu7enZOAUo374ZPYttlqByi0vH6z5ChqEmUk4PFjI8ydFTT+64AFcGH/BgQTPzxS3jr6BP9aUfCSxn4hS72h7vimuepg+Ikt6aRsDpDdJItrFjH6OIr/i6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769864160; c=relaxed/simple;
	bh=6sh9/SsNPFwh1psv1DghrbRPZnqRaruJuDn4SyJ+qdE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BEz2OIrTC6u/vq4yvNUaAUmjcpHqVc7CkGVgXyNspgWj0W4GVUD9Zjh6TIF8kYPZcubHZX7IS/CFdmbTiTg/f9DOLGugAJT07Fj6/M/bR0kouYD1L4hwvG4j3O2vwUWoGkFfZTr399EpqUEE/x6f3rEVH0hwMhg+68BawlTAYvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 31 Jan 2026 21:55:45 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gunho.lee@lge.com,
	youngjun.park@lge.com,
	taejoon.song@lge.com
Subject: [RFC PATCH v3 0/5] mm/swap, memcg: Introduce swap tiers for cgroup based swap control
Date: Sat, 31 Jan 2026 21:54:49 +0900
Message-Id: <20260131125454.3187546-1-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,vger.kernel.org,kvack.org,lge.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13568-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CBC9C1D62
X-Rspamd-Action: no action

This is the third version of the RFC for the "Swap Tiers" concept,
incorporating LPC 2025 feedback and subsequent bug fixes.

Previous approach: https://lore.kernel.org/linux-mm/20250716202006.3640584-1-youngjun.park@lge.com/
RFC v2: https://lore.kernel.org/linux-mm/20260126065242.1221862-1-youngjun.park@lge.com/
RFC v1: https://lore.kernel.org/linux-mm/20251109124947.1101520-1-youngjun.park@lge.com/

v3 addresses bug fixes found during testing and adds clarifications to
improve patch reviewability.

Overview (Recap)
================
Swap Tiers enable cgroup-based swap device assignment by grouping swap
devices into named tiers. This allows faster devices (e.g., SSD) to be
dedicated to latency-sensitive workloads while slower devices (e.g., HDD,
network) serve background tasks. The concept was suggested by Chris Li.

Key Changes after LPC 2025(RFC v1)
==================================
The most significant change in v2 was adopting strict cgroup hierarchy
semantics based on LPC 2025 feedback. 

v1 allowed children to explicitly select tiers ("+tier") regardless of
parent configuration, violating standard cgroup principles.

v2 enforces proper hierarchy: child configurations are always subsets of
parent. Default is all tiers enabled; use "-tier" to exclude.

Example:
  Global: SSD, HDD, NET
  Parent: -HDD → uses SSD, NET
  Child: -SSD → uses NET (intersection)

  If SSD deleted: Child uses NET (exclusions reset)
  If NEW added: All cgroups use it by default

This ensures children cannot access resources denied by ancestors,
matching standard cgroup behavior.

For detailed rationale, see v2 RFC and LPC presentation.

Changes in RFC v3
=================
- Fixed swap_alloc_fast() tier eligibility check
- Fixed tier_mask restoration on error paths  
- Fixed priority -1 tier deletion bug
- Fixed !CONFIG_MEMCG build failures
- Improved commit messages
- Fix improper error handling
- Fixed coding style violations
- Fixed tier deletion propagation to cgroups

Changes in RFC v2
=================
- Strict cgroup hierarchy compliance (LPC 2025 feedback)
- Percpu swap device cache to preserve fastpath performance (Kairui Song, Baoquan He)
- Simplified tier structure (Chris Li)
- Removed explicit "+" selection; default is all tiers, use "-" to exclude  (Chris Li)
- Removed CONFIG_SWAP_TIER; now base kernel feature (Chris Li)
- Effective tier calculation moved to configuration time (swap.tiers write)
- Mixed operation support for "+" and "-" in /sys/kernel/mm/swap/tiers (Chris Li)
- Commit reorganization for clarity (Chris Li)
- Added tier priority modification support
- Added documentation for swap tiers concept and usage (Chris Li)

Real-world Results
==================
App preloading on our internal platform using NBD as separate tier.
(Our first real-world use case. We plan to refine and expand this usage.)

Without separate swap tier,
- Cannot selectively avoid default flash swap, unable to reduce flash wear and lifespan issues.
- Can't selectively assign NBD to specific apps that need it.

Result (cold launch vs. preloaded):
- Streaming App A: 13.17s → 4.18s (68% faster)
- Streaming App B: 5.60s → 1.12s (80% faster)  
- E-commerce App C: 10.25s → 2.00s (80% faster)

Performance validation against baseline (no tiers configured) shows
negligible overhead (<1%) in kernel build and vm-scalability benchmarks.
Detailed results in v2 cover letter.

Any feedback welcome.
Youngjun Park

Youngjun Park (5):
  mm: swap: introduce swap tier infrastructure
  mm: swap: associate swap devices with tiers
  mm: memcontrol: add interface for swap tier selection
  mm, swap: change back to use each swap device's percpu cluster
  mm, swap: introduce percpu swap device cache to avoid fragmentation

 Documentation/admin-guide/cgroup-v2.rst |  27 ++
 Documentation/mm/swap-tier.rst          | 109 ++++++
 MAINTAINERS                             |   2 +
 include/linux/memcontrol.h              |   3 +-
 include/linux/swap.h                    |  17 +-
 mm/Makefile                             |   2 +-
 mm/memcontrol.c                         |  85 +++++
 mm/swap.h                               |   4 +
 mm/swap_state.c                         |  72 ++++
 mm/swap_tier.c                          | 469 ++++++++++++++++++++++++
 mm/swap_tier.h                          |  84 +++++
 mm/swapfile.c                           | 133 +++----
 12 files changed, 938 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/mm/swap-tier.rst
 create mode 100644 mm/swap_tier.c
 create mode 100644 mm/swap_tier.h

base-commit: 5a3704ed2dce0b54a7f038b765bb752b87ee8cc2
-- 
2.34.1

