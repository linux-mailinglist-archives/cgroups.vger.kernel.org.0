Return-Path: <cgroups+bounces-16420-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAwoFK9XGWqCvggAu9opvQ
	(envelope-from <cgroups+bounces-16420-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 11:09:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 091385FFB3D
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 11:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B04B309D380
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08F53BBA1A;
	Fri, 29 May 2026 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kSr+qF2v"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F43BA22E
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045681; cv=none; b=qNJiw89BcmL8XCg3aO43v3a4IeXo5NFXUtokjCv5OHjcpyYEASZb+rRqoM56pb9C83UByG+G31TtumgjcSrBzVuYiL3ntVrnM6eUdnj1bBYDuDBPazpcqldCucZJJGvu/ZaD24rbga/MW+898q4Ex6jR/A/ox6GGpcX7P4dw5ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045681; c=relaxed/simple;
	bh=QFJ3jZPuLzz4cgAvH+lI4rf+q+2dlZJEBGn8x0mV3us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P33ghf7hTbgdREacNBWS/lx6h+14DBnR3CUBitxJOQJyEM9TXSB+YCOcygCc2drq8jAAYQZx9SScc1mW9Z5JqmiviqTiGg6HO7ZePba+rmbtWGNPfrPlFQy7VOUyYPYnAflndPtfYR4XEH2PTDu9wVA9a/Od/FXz6P9LOY9Db0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kSr+qF2v; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780045668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vIvD+tH8GardrAeKrBNHrByBYjz1cKNJeWoucOPY6/8=;
	b=kSr+qF2vh+aTNnPPbeUEB/WywSiJucZo5qK+L0/Xgjufi7rbPFpXCpbCU9XDw+CZ/ztbck
	mlZHhz3kX/l3lgA/LcwTk9ckCSOc/E3gEZNeq1uE2P3pXpB4WMuk7Ykrkq98SxeEb7VAum
	I41p4Md3k4vPk64olozpCvF++XSdcpw=
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	cgroups@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH rdma-next v2 0/3] cgroup/rdma: add MR memory size resource tracking
Date: Fri, 29 May 2026 17:07:30 +0800
Message-ID: <20260529090733.2242822-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16420-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 091385FFB3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tao Cui <cuitao@kylinos.cn>

Currently the RDMA cgroup only tracks two aggregate counters:
hca_handle and hca_object.  The real scarce resource in multi-tenant
deployments is pinned memory: how much physical memory gets registered
through MRs.  The existing hca_object counter is too coarse to capture
this.

This series adds a single new resource type:

  - mr_mem  - Cumulative MR memory size in bytes

The per-object-type counters (qp, mr) from RFC v1 have been removed
per review feedback [1]: modern NICs pool objects from the same memory
pool so the distinction between QP count and MR count is not
meaningful for resource limiting.  hca_object remains sufficient for
coarse object accounting.

After this series, an administrator can set limits like:

    echo "mlx5_0 mr_mem=1073741824" > rdma.max

Design
~~~~~~

mr_mem is not page-level ownership tracking; it is object-based
accounting tied to the MR lifetime:

  - charged at MR registration time
  - uncharged at MR destruction time
  - the charge is pinned to the cgroup that created the MR for the
    entire lifetime of the MR object

This model intentionally defines accounting semantics around MR
object lifetime rather than page ownership:

1. fork(): fork() does not duplicate MR objects.  Even though the
   child inherits the uverbs fd and can access the parent's ucontext,
   the MR remains a single kernel object.  The charge is tied to the
   MR object, not to the number of processes that can reach it, so
   no splitting or re-accounting is needed.

2. Cgroup migration: mr_mem follows the same semantics as the existing
   hca_object; charge at creation time against the invoking task's
   cgroup, uncharge at destruction time.  The RDMA cgroup does not
   implement can_attach/attach callbacks today, so charges do not
   migrate with the task.  This is a known limitation that applies
   equally to hca_handle and hca_object.  mr_mem does not introduce
   any new complication here.

3. Overlap with memory cgroup: mr_mem does not count process memory
   usage; it represents a per-device DMA registration budget: the
   amount of memory this cgroup may register through a given HCA.
   This is a different dimension from what memory cgroup tracks.  An
   administrator might set mr_mem limits differently per device, which
   memory cgroup cannot express.

   In particular, mr_mem tracks the registered memory range associated
   with the MR rather than exact dynamically pinned pages (e.g. for
   ODP MRs).  This is a stable, policy-oriented approximation of
   registration footprint, not an attempt at precise physical page
   accounting.

Tao Cui (3):
  cgroup/rdma: extend charge/uncharge API with s64 amount parameter
  cgroup/rdma: add MR memory size resource tracking
  cgroup/rdma: update cgroup resource list for MR_MEM

 Documentation/admin-guide/cgroup-v2.rst       |  21 ++--
 drivers/infiniband/core/cgroup.c              |  10 +-
 drivers/infiniband/core/core_priv.h           |  12 +-
 drivers/infiniband/core/rdma_core.c           |  20 +++-
 drivers/infiniband/core/uverbs_cmd.c          |  61 +++++++++-
 drivers/infiniband/core/uverbs_std_types_mr.c |  37 ++++++
 include/linux/cgroup_rdma.h                   |   8 +-
 include/rdma/ib_verbs.h                       |   1 +
 kernel/cgroup/rdma.c                          | 108 +++++++++++++-----
 9 files changed, 219 insertions(+), 59 deletions(-)

---
Changes from RFC v1:

  - Removed RDMACG_RESOURCE_QP and RDMACG_RESOURCE_MR per-type
    counters following review feedback from Jason Gunthorpe [1].
  - Retained only RDMACG_RESOURCE_MR_MEM as the sole new resource.
  - Added detailed semantic notes to the commit messages addressing
    fork(), cgroup migration, and overlap with memory cgroup [2].
  - Renamed patches to reflect the narrower scope.

[1] https://lore.kernel.org/all/20260525134314.GI7702@ziepe.ca/
[2] https://lore.kernel.org/all/20260528075537.2170697-1-cuitao@kylinos.cn/
-- 
2.43.0


