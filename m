Return-Path: <cgroups+bounces-6740-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE4FA49295
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 08:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A487188C912
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 07:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAE31CBA02;
	Fri, 28 Feb 2025 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E2SKyJN0"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AB51D61B5
	for <cgroups@vger.kernel.org>; Fri, 28 Feb 2025 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729519; cv=none; b=EomfY4KguTddqB+1fnUXqySktoJP4gaSAjnQMOOByyN03GH/axcP10KzBPlolgh5rqagscjwEILN2mSfSIVwcy6thYZjI3tw3KatR6rQOzSkw2j/WatvqAYu2tiEbLr5ZeqW6Qx6lsey1v936t0GXUDNx7XBqOlMSjpoqLJTY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729519; c=relaxed/simple;
	bh=YbxiJgh//V6HS62UyIXWJH2MQ2ulVcmvIDjZqAr4BEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPdh2Foz/LbiQ+kaqa+bl8gwTTlq/O6ef/dlyAZ/6x3Gme9xzeJElCDXOEJKAclxoqZJxME7Q+CI9A8Fb2ac3CMklFVtr1Nqsk7lcX6ztSXK442miH9MTy3C+G8N4IpOUyVUMfgpRDOyrn6QCWU2SACgAEWEhZQDD6T7CqLM9SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E2SKyJN0; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740729505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O7F/3Ya/AEmguVMS5nHCW+NuZ60GHkFjlot2gy9xy64=;
	b=E2SKyJN0ia87HJuoz5mh6QnWLq0XPUQ96/PWMYOUQM2oqqFp0zsnTltRm47VUTh6ZKVujc
	PXWmEDyRR4QfePpIiKUAC1pjFBLDyIdmszdFbwxzhUE3gcC4dTu5KmoH/UmXBFv81hgIKi
	GikJ3LORmiv+1HSBtiR3OVAbxS4zavc=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 0/3] page_counter cleanup and size reduction
Date: Thu, 27 Feb 2025 23:58:05 -0800
Message-ID: <20250228075808.207484-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The commit c6f53ed8f213a ("mm, memcg: cg2 memory{.swap,}.peak write
handlers") has accidently increased the size of struct page_counter.
This series rearrange the fields to reduce its size and also has some
cleanups.

Shakeel Butt (3):
  memcg: don't call propagate_protected_usage() for v1
  page_counter: track failcnt only for legacy cgroups
  page_counter: reduce struct page_counter size

 include/linux/page_counter.h |  9 ++++++---
 mm/hugetlb_cgroup.c          | 31 ++++++++++++++-----------------
 mm/memcontrol.c              | 17 +++++++++++++----
 mm/page_counter.c            |  4 +++-
 4 files changed, 36 insertions(+), 25 deletions(-)

-- 
2.43.5


