Return-Path: <cgroups+bounces-16236-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AdmBnPkE2rhHAcAu9opvQ
	(envelope-from <cgroups+bounces-16236-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 07:56:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B71435C6164
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 07:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9897D301E6F9
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 05:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A257835DA4F;
	Mon, 25 May 2026 05:55:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224DC358388;
	Mon, 25 May 2026 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779688526; cv=none; b=Hw9JwYyyonIFQ80u2ZDm5/Hqq/EKwtfN6SBepFxPjFCj2vN8sn8Mf6RZJTVF8RFFBY/EDkja+IQMwrLFvnzlo9zDMAQEWhhVa7EKImnS0xcnFswQkh1rcmltg+wQ2G/GRgnub7UC9n+9TqdnKEgcszLwW/5LBDoJf0ggXMYzgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779688526; c=relaxed/simple;
	bh=I1+habOundZQgdNLV9VslcVCMh+H+J2qzcWE/AowYhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fqrJmlC22rqYgP5FvdyElM0Pl9ynbahRsKUpucBs9NWuEfUtvG6DeqamIGzQOTkiyh74kgLKmWBUG3GM+3a2b7iA5chfaZd/6eNRwZHlOuBQMAEtV0D8NpNmqmlcgmSHBWoFe0d5hSByGq9on71wNFl1oZYLgk5JE/bdXp8Pd4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4dec37c257fe11f1aa26b74ffac11d73-20260525
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8de69fd4-0ea2-4770-aaa4-ddbf5cdfc56b,IP:20,
	URL:0,TC:0,Content:23,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:43
X-CID-INFO: VERSION:1.3.12,REQID:8de69fd4-0ea2-4770-aaa4-ddbf5cdfc56b,IP:20,UR
	L:0,TC:0,Content:23,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:43
X-CID-META: VersionHash:e7bac3a,CLOUDID:8161a34e669e110c1c649da8a479e606,BulkI
	D:260525135519QNAVDQDK,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	865|898,TC:nil,Content:4|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4dec37c257fe11f1aa26b74ffac11d73-20260525
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1526677625; Mon, 25 May 2026 13:55:16 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	cgroups@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [RFC PATCH rdma-next 0/5] cgroup/rdma: add per-type resource accounting for QP, MR and MR memory
Date: Mon, 25 May 2026 13:55:01 +0800
Message-ID: <20260525055506.2002985-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	DMARC_NA(0.00)[kylinos.cn];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16236-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: B71435C6164
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently the RDMA cgroup only tracks two aggregate counters:
hca_handle and hca_object.  This is too coarse for real-world
deployment: a tenant can exhaust all HCA objects by creating nothing
but QPs, while the administrator has no way to impose separate limits
on QP count, MR count, or the cumulative memory registered through
MRs.

This RFC series adds per-type resource counters for three new
resource types on top of the existing hca_handle / hca_object:

  - qp      - Queue Pair count
  - mr      - Memory Region count
  - mr_mem  - Cumulative MR memory size in bytes

After this series an administrator can set limits like:

    echo "mlx5_0 qp=100 mr=500 mr_mem=1073741824" > rdma.max

Design decisions that I would appreciate feedback on:

  1. Dual charging: the existing hca_object charge is retained for
     QP and MR objects.  The per-type counter is charged in addition.
     This keeps backward compatibility - existing deployments that rely
     on hca_object limits continue to work.  An alternative would be
     to replace hca_object with per-type counters entirely, but that
     breaks the ABI.

  2. MR memory is byte-based: unlike QP/MR which are simple counts,
     mr_mem tracks the actual length parameter passed at MR
     registration time (both ioctl and legacy verbs paths).  This
     required changing the internal accounting from int to s64.  The
     match_int parser is replaced with a match_s64 helper using
     kstrtoll.

  3. Charging point for mr_mem: the byte charge happens after the
     MR is created but before the uobject is finalized, so that the
     error path can deregister the MR cleanly.  The charged byte count
     is stored in uobj->rdmacg_mr_mem_bytes so that the generic
     destroy / abort paths can uncharge without knowing the MR length.

  4. Overflow protection: the s64 addition in rdmacg_try_charge()
     checks for both overflow (new < old) and limit exceedance.

Open questions:

  - Should hca_object be deprecated in favor of the per-type counters,
    or should we keep dual charging indefinitely?

  - The mr_mem counter tracks the length requested by the user, not
    the actual pinned pages.  A process that registers a large MR but
    only touches a subset still consumes the full quota.  Is this the
    right semantic, or should we instead track pinned_page_counts?

This is marked RFC because the cgroup ABI change (new resource types)
is hard to revoke once merged, and I want to make sure the above
design choices are aligned with the maintainers' expectations before
proceeding to a formal submission.

Tao Cui (5):
  cgroup/rdma: extend charge/uncharge API with s64 amount parameter
  cgroup/rdma: add QP per-type resource counting
  cgroup/rdma: add MR per-type resource counting
  cgroup/rdma: add MR memory size per-type resource counting
  cgroup/rdma: update cgroup resource list for QP, MR and MR_MEM

 Documentation/admin-guide/cgroup-v2.rst       |  19 ++-
 drivers/infiniband/core/cgroup.c              |  10 +-
 drivers/infiniband/core/core_priv.h           |  12 +-
 drivers/infiniband/core/rdma_core.c           |  48 +++++-
 drivers/infiniband/core/uverbs_cmd.c          |  16 +-
 drivers/infiniband/core/uverbs_std_types_mr.c |  32 ++++
 include/linux/cgroup_rdma.h                   |  10 +-
 include/rdma/ib_verbs.h                       |   2 +
 kernel/cgroup/rdma.c                          | 151 ++++++++++++++----
 9 files changed, 243 insertions(+), 57 deletions(-)

-- 
2.43.0


