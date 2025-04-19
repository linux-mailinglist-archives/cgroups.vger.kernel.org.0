Return-Path: <cgroups+bounces-7656-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE71A941C4
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 07:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39B7189D881
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 05:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8FA15DBBA;
	Sat, 19 Apr 2025 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oPx+/ssZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520A94685
	for <cgroups@vger.kernel.org>; Sat, 19 Apr 2025 05:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745041111; cv=none; b=DTQLKG3qIsbdohs1jA/qQuOHRmLVlo+xejNrP1A59aRgQAJkCTwZV/IXgw16OC1cLbIoiVgrMbk7s1XSZjirfYlKRNTuHKcwgb6wGjxyu8X5cdLZCq4GyCW3I5dX5/B2H0AyWnGrAgMFwUB+2o3ZnHdVbs5h9rpK53NcKjp8GC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745041111; c=relaxed/simple;
	bh=uL1WQ8LK/h/Zb0dv5e4SK8N1OJRo5H6PcHtr36ik/kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=coeNxVq8liUMGgGkUqS80D8QAjBRO6aZQ1oRBD/tKDVnBunrYLNRSIFLul3pruPxsCJAxYSUgX8k//7aU/LBPCtkCyLLIQNrL5fKZQURqO/c5a0AwKqhOIsUniq+jd//MF+/94op9TGbrZaJUbgzn1KN9F0WJ3RAMsRZqIujuSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oPx+/ssZ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8fb83e137so20903306d6.0
        for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 22:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745041108; x=1745645908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MkF0JOp4lFK4CnPP02hYvjuEDN2qDsBOK7lNPu8eYOE=;
        b=oPx+/ssZl8TTDo9a1Vq/Psr++/IDJCmRbs/7nr+1BWu70a8HmpHJBW8gsAO6m9lepS
         reQrLfrq53zkcHKgqEoh50gh5wziEn+LnLqGDGLBZSIl/3y6XsN49a4odCjuPAmsNF+U
         ooIp2E5i/lowxXLgDsufX0smLf1XVmNf80qWLiRjrERFcg8Kx8OntPeb3Y13cDL6AcQQ
         E9u9Sfnhm77O6K3PKGkTbpD51xF8UIt4X9IIzQlozbcAD9uBl4i4vU+yLcCJq683+moN
         jUoXVV5OFTnc23JkHKMI87AEe4oDUx6tk0QTF1ZAOZADU+5kv0ClbJF3dq1goZFNDYRm
         lWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745041108; x=1745645908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkF0JOp4lFK4CnPP02hYvjuEDN2qDsBOK7lNPu8eYOE=;
        b=SxlWcZBiv3A+h0NPbYoAWwuJEciEArui0Kj9worqdAdCtgNrwnbf2DxEja5jjx7YMR
         nwSCdayQjVq0gns1ozfNsNQGyxAth/o77TkVrUVQdVFoy/9wv3KYdwPKamSn1Mw8DL7s
         5WeUT50LnLea7vgYUTB2uI2DqgHq9sngj2xEscN/vQ2E310fKTvdgypCWcf+RbCAULsV
         Z6kMKj0L+u4NSg7z0feNLnoXZa8/6+f3w/Fn8PJ5/vzD6FHtSkRUbAkW3PNNdzg3D+YI
         W53goGGcJBx13+xuZH6fByXcHEQUPcM+QLIzGR2nMCnkuOQNBJ4f/GrkKet4ebRO0CRw
         pa+Q==
X-Gm-Message-State: AOJu0YzVljRVeP+Nl5KV6EG+KvE0yOO3UaznWOu+bL/N0E6bchMrYqse
	DFTA+fbExVZWEgnzXLPF80zLrGaZC4FIX8OFLxVCpsyevEOd2sT5J8aOkbd3QXM=
X-Gm-Gg: ASbGnctsVPyybMux3wjiyQHPpB9Ht2OzMKKcfsvPzs+tAf3dl3vU36YO1TYhbSPMWCU
	VEsc84p84M8aLuU1UAf3ZCGGgCz9NdZxzJFR8bL6f/HE5/Lre96yoEeBQsk+GhZjild3DeHmlwp
	3sKhTGgdYBa3m9S85HVgQmbJzXkQJtN/kPYmznEhD883ymnXWbuw1uJZFPc1nODPpB3JeOwpnAR
	hAKAsCaYxn19NPBf9BnzLLRfNedR02CftBjHbDOHUHh1V3xUNGOxKeqzOc1ZBG9qRQSg6u8LXxt
	0qQ7UAUKpvTJNT1f9W6qHuDzXFLGPBkLFLdgMdWLEFJp1RVqx+7o9NShvSaXMZUbFwjzIcOrfvJ
	f8rk+0iUvfqiYG/hch4K6RYIY4gEc
X-Google-Smtp-Source: AGHT+IFM1C8EHqGpWDsCzXLvWukyQ89UOjGIyccxMnRe93dLXZg+F0y81hHRlPy4r6OD3LG/0BMeZA==
X-Received: by 2002:a0c:e5ce:0:b0:6f2:d4ed:c549 with SMTP id 6a1803df08f44-6f2d4edc58dmr1306516d6.20.1745041108076;
        Fri, 18 Apr 2025 22:38:28 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b30c65sm18341956d6.51.2025.04.18.22.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 22:38:27 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	akpm@linux-foundation.org
Subject: [PATCH v3 0/2] vmscan: enforce mems_effective during demotion
Date: Sat, 19 Apr 2025 01:38:22 -0400
Message-ID: <20250419053824.1601470-1-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change reclaim to respect cpuset.mems_effective during demotion when
possible. Presently, reclaim explicitly ignores cpuset.mems_effective
when demoting, which may cause the cpuset settings to violated.

Implement cpuset_node_allowed() to check the cpuset.mems_effective
associated wih the mem_cgroup of the lruvec being scanned.

This requires renaming the existing cpuset_node_allowed() to be
cpuset_current_now_allowed() - which is more descriptive anyway - to
implement the new cpuset_node_allowed() which takes a target cgroup.

v3:
- remove cgroup indirection, call cpuset directly from memcontrol
- put mem_cgroup_node_allowed in memcontrol.c to reduce cpuset.h
  include scope
- return true if mems_effective is empty, and don't walk the parents
  as recommended by Waiman Long.

Gregory Price (2):
  cpuset: rename cpuset_node_allowed to cpuset_current_node_allowed
  vmscan,cgroup: apply mems_effective to reclaim

 .../ABI/testing/sysfs-kernel-mm-numa          | 14 ++++---
 include/linux/cpuset.h                        |  9 +++-
 include/linux/memcontrol.h                    |  6 +++
 kernel/cgroup/cpuset.c                        | 25 ++++++++++-
 mm/memcontrol.c                               |  6 +++
 mm/page_alloc.c                               |  4 +-
 mm/vmscan.c                                   | 41 +++++++++++--------
 7 files changed, 78 insertions(+), 27 deletions(-)

-- 
2.49.0


