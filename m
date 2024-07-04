Return-Path: <cgroups+bounces-3540-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDF2926F8A
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 08:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3B6285543
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 06:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327561A08CB;
	Thu,  4 Jul 2024 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C0sdWI3e"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8803A1A073A;
	Thu,  4 Jul 2024 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720074501; cv=none; b=IiDBT0aaOSJNywSF1WTFn9e0u99LBjeyTc02W0vdfsf3ZO7uppIvmkmy1ZH68eLNIiqKr0ybPJjy+4JCH3RuFPr7dZscd0J07gbUlFJiCOseArvFd8zaE+8rVsvPryzscfFSwfiS8U6jQWjaLuF3fz3e2lz7FUn+0GKVOT1kdzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720074501; c=relaxed/simple;
	bh=jmAGYAWvVFx29NTFX0+hp6ZS67rPGmxR57sTA7UFRoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=efMFjYrbsmB4I/mp1XnxlcgezTriLYgvcZgcsXC4WoZ9TYHt318754x2NV5wZmRsweMip3/VlPxZlFvev5YJGBTn8rXGihiLo77jGftLKvtYdTHU4yarpcdgB9P6ZezjpFoB8bIFSeRNzBQOarsO/am8q0Np7mqeEYG4dNsmBQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C0sdWI3e; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/Cug2
	j7MBohQB8bLgLOZuspJus1Qjeu0I4RhS1pDqn4=; b=C0sdWI3eNSX5q3mXkhJlr
	oEDDbeEmJuS4dyaEFOdwfGZkIRTP18Mqr8Qm1SrREi6fd/NahHf87qM5iy6MdzN6
	OMKBtojQYcuXVTKNB0/osm8t7i3zuTNMTKYQUweNbAKXYGb8V29iBtxcqPnjiIP3
	8cdj8J7bNDaD/zgbcTkYfo=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g3-2 (Coremail) with SMTP id _____wD3ny8uQIZmhJgTAg--.15986S2;
	Thu, 04 Jul 2024 14:24:46 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: tj@kernel.org,
	longman@redhat.com,
	mkoutny@suse.com
Cc: akpm@linux-foundation.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH-cpuset v11 0/2] Add Union-Find and use it to optimize cpuset
Date: Thu,  4 Jul 2024 14:24:42 +0800
Message-Id: <20240704062444.262211-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f9e55eb8-82a8-45f2-a949-1db182e95fc8@redhat.com>
References: <f9e55eb8-82a8-45f2-a949-1db182e95fc8@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3ny8uQIZmhJgTAg--.15986S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw15uF1rWF18AF4UXFyrJFb_yoWkZFgEgw
	4kXa4jkw1UZFn7WFWfCFyrtFW29rWj9ry0k3Z8tF47XF4DJwsrGrykJ3s8X3yUX3WDJr43
	JF98tr4xtrnFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUcyCJUUUUU==
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/xtbBcg4REGWXwAGx3AABsi

Hi all,

Based on Michal's suggestion, the following changes were made:
1. Changed Union-Find to union-find in all places except the title.
2. Optimized the logic of the uf_union function.
3. Modified places where csa[i]->node.parent was used directly.

To Longman,
Regarding the modifications for supporting cpuset merging in both cgroup
v1 and v2, do you mean that you will continue to complete them after my
patch is merged?

Kindly review.

Xavier (2):
  Union-Find: add a new module in kernel library
  cpuset: use Union-Find to optimize the merging of cpumasks

 Documentation/core-api/union_find.rst         | 102 ++++++++++++++++
 .../zh_CN/core-api/union_find.rst             |  87 +++++++++++++
 MAINTAINERS                                   |   9 ++
 include/linux/union_find.h                    |  41 +++++++
 kernel/cgroup/cpuset.c                        | 114 +++++++-----------
 lib/Makefile                                  |   2 +-
 lib/union_find.c                              |  49 ++++++++
 7 files changed, 333 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/core-api/union_find.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/union_find.rst
 create mode 100644 include/linux/union_find.h
 create mode 100644 lib/union_find.c

-- 
2.45.0


