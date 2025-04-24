Return-Path: <cgroups+bounces-7809-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52536A9B928
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 22:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF619A695F
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 20:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9DC223DCE;
	Thu, 24 Apr 2025 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YW9kjI8q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85321D5B1
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526493; cv=none; b=HF1+TPvcieIYd2HLiDeQNaVMYY/aElR1VhsDo7Rp2xKoyqyey0+ukwG/sqAMUp0UmkjPNoGgLAXaJAm3OAHscWj8CGtHcAlk6RU0d+uIh+BvwPnzY2/6/ImYg6R0kxed1s1P2VAeXVIFhwIUs5FQgTGHedv89mbc3VZs94+D4Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526493; c=relaxed/simple;
	bh=nUFNqBNv+jufOcKVj7RmbeiHI2hKBO+NtzgiTALsO9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i5C4IUswzbBiy+o2t1q3EBwOOxdQypD8kysDjVzvluwO3+xI5UasMG6gzZleuZiLvcDiCNGJjyBEuSa8nKTASTeBj6naFV+PacVNvOWsq0CvLIh/vCMHW6kmoo64U8NA9W2smx8FDF4PKrGwZ/s4QjDzgr4IQp8cXfNNZZlEe2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YW9kjI8q; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4774d68c670so24368331cf.0
        for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 13:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745526489; x=1746131289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mkCigXxCd0yRpiiW/yUceKBlwamXBSHFGuFjCjP5s7s=;
        b=YW9kjI8q9QMd4YJJCPBbObAS2u94pWVlxESckm5tA9kUDsx6VxjqUot5IHDFvss4Jx
         blw0OiWka7DuwVQJWoKKbFe0cWVgJ08flAJf/cqifzv55QWJlbLj4DF8ogc74cxB0BMF
         N1AtbvYajxs6BvA4P14RuNiXKAZvD/7JCJQaHzoFS7xqW8pTOwO6hdsz/YzG6v5k79sG
         mQ/nvqfbbTJZxt5cY07q/nJ7hMdZZ4KQNV4svXhJpaVZHwOfFjCeze30aAmMCh3WIq94
         tBg6woQ7Sl63aOXh14bXhNGeMHFrFX9T6ENVMcCV3SJRSJExRZhC1pyqqxOGplgIXQ3g
         XOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745526489; x=1746131289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkCigXxCd0yRpiiW/yUceKBlwamXBSHFGuFjCjP5s7s=;
        b=LCRzGZ3+NcLZS+DykQaCnXYYhYlR5Iu6+DWPLSouTxjfyYxRez5I0jl854ve9PPTh0
         7PoU8e6F/LXMJW1LBiKNZ5CSvTPXokjG4tu17bqgm6pIoMfIdbHV38MjtRmn311VfdFw
         rQ+CbQU9oc5aAFPPS5pXD09B2ve+hOfhBjkGdh8e/9M6ZAzzUkeIUcgj+EalmLmSkhod
         Aa8acz4jPMNaFE++jKvWFnqGUIpXHHAUKnjtkwVC0+UJ0XmFqBQfFKo+kHHJ4mqBPjs8
         zmiXUcIpbJ2AsTQzEeGRfM0El3XsKo4VFG5H7l/Istc3rrGYGxHjstqRl8fADyjIUAeC
         PgkA==
X-Gm-Message-State: AOJu0YyfHu/gGrUBkaEV9rRM+4wleWs74gQ/FaLkmutOcjCJWIDWxMAK
	1TlxHkSSp1lUPNDATp1KgNilKyvkpv4vZPC9DtQcogTJzdI59+yj8cg0hvAqVaY=
X-Gm-Gg: ASbGnctoU0AE2ecdV4/269o88R+gUmJPM4apYYfKbEy7TX6CBcgxL56BW3esrOu4dBo
	apqmdwDksOy23lcPWkbPuBDDkEI5uIBiRxNbvGwJXqii63TYhmss1WlNde8MN+mGRxEUUK4/kEj
	W2B2L+ZcCPIa/w1LMbDUEzJAeBZU38011rBgyxeF+GiSDSAevD6t3s8W6YkV/oAnKQuHE2hMLQF
	XKpvIfgF6wbsDOWAy9ec2Z6GrbeCBPdrnMpAkGgH1d0FysrODpbi+cLKS3b953ppSZYsWCYLIWv
	dPCm9UKLFHYw62+cwlqHlEZiHroiba+z1kmtegWk7njL2Ens/sTlGu86qbFOMggOG2CFsX4eOTV
	d3y1r6pcI42GuVrB6LMOR/917GnNoayiOePzTOgc=
X-Google-Smtp-Source: AGHT+IEQgccSv5KrYCLIeOkBb6hapQoRMYw3UOEbhpsi+8eTQdTpyiaSKOTPM0LAX5hq1LPrjnY5Fw==
X-Received: by 2002:ac8:7d4d:0:b0:477:6f28:8c16 with SMTP id d75a77b69052e-47fb96e6a40mr17377611cf.6.1745526489664;
        Thu, 24 Apr 2025 13:28:09 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9ebeb870sm16091691cf.5.2025.04.24.13.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 13:28:09 -0700 (PDT)
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
Subject: [PATCH v5 0/2] vmscan: enforce mems_effective during demotion
Date: Thu, 24 Apr 2025 16:28:04 -0400
Message-ID: <20250424202806.52632-1-gourry@gourry.net>
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
associated wih the mem_cgroup of the lruvec being scanned. This only
applies to cgroup/cpuset v2, as cpuset exists in a different hierarchy
than mem_cgroup in v1.

This requires renaming the existing cpuset_node_allowed() to be
cpuset_current_now_allowed() - which is more descriptive anyway - to
implement the new cpuset_node_allowed() which takes a target cgroup.

v5:
- squash drop rcu_read_lock fixlet into second patch,
- changelog fixups

---
(apologies for the spam, did not drop a reply-to)

Gregory Price (2):
  cpuset: rename cpuset_node_allowed to cpuset_current_node_allowed
  vmscan,cgroup: apply mems_effective to reclaim

 .../ABI/testing/sysfs-kernel-mm-numa          | 16 +++++---
 include/linux/cpuset.h                        |  9 +++-
 include/linux/memcontrol.h                    |  6 +++
 kernel/cgroup/cpuset.c                        | 40 +++++++++++++++++-
 mm/memcontrol.c                               |  6 +++
 mm/page_alloc.c                               |  4 +-
 mm/vmscan.c                                   | 41 +++++++++++--------
 7 files changed, 94 insertions(+), 28 deletions(-)

-- 
2.49.0

