Return-Path: <cgroups+bounces-7054-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665C9A6090A
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 07:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A573F17FC30
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 06:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC58F17BEC5;
	Fri, 14 Mar 2025 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MIKlJBrB"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4368170A2C
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 06:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932939; cv=none; b=b1cKDdiJiunyeAblETmpj2rycqxnUAWYiW8KYwxts/bZTD/cjdRTEURqdquCvyqyYm0XFFUM3QxIJ8p/rYTOAhLVYHOjIMbjmfX5zn4vO4OvNVaYTW7IHn8YHLnAV6v8l/XCNUHwn+BKWIc9MS7WthnvvcYDrppCWFk8B+6hMSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932939; c=relaxed/simple;
	bh=t0q6tCfb5aLK49AyK224Jyy8xTG6pfdL7DwD+2mGnGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QxFddgzUrQIKSUTobPJNTNJg8enwmfKElPKUipaRZCGxHymc779cwFqK3o8S34nutQqqWbRWH93oKK3xgl1MGUgxJPHLJOAcFKJpBbTrwr7hAcIsAlvbQzaP8ILnGJt9BYfMgrLDNNs5wFqWBPSnSVSNhW15EUka+PKwOKVpc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MIKlJBrB; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741932925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Eu8GFcaNlIm/mZEbW8LGnu3Cvr98HXwjng+s1ev2tdA=;
	b=MIKlJBrB40QTtUSONJTitPPBat/UxVCt6AJhw42tzhlwbf+dv3Iw4gVkNywouvZ9Dfhmnh
	JQYXq/RwhmB5p82urP5fgbyFl5xJiq4bFgminvU++NlVXtxYPCRSJ5TLyHTmXvImXOO99F
	vGwt47IJUbrmTfTMmCdbo4qKKDE9aTc=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [RFC PATCH 00/10] memcg: stock code cleanups
Date: Thu, 13 Mar 2025 23:15:01 -0700
Message-ID: <20250314061511.1308152-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This is a cleanup series (first 7 patches) is trying to simplify the
memcg stock code, particularly it tries to remove unnecessary
dependencies. The last 3 patches are a prototype to make per-cpu memcg
stock work without disabling irqs.

My plan is to send out the first 7 cleanup patches separately for the
next release window and iterate more on the last 3 patches plus add
functionality for multiple memcgs.

This series is based on next-20250313 plus two following patches:

Link: https://lore.kernel.org/all/20250312222552.3284173-1-shakeel.butt@linux.dev/
Link: https://lore.kernel.org/all/20250313054812.2185900-1-shakeel.butt@linux.dev/

 to simply the memcg stock code

Shakeel Butt (10):
  memcg: remove root memcg check from refill_stock
  memcg: decouple drain_obj_stock from local stock
  memcg: introduce memcg_uncharge
  memcg: manually inline __refill_stock
  memcg: no refilling stock from obj_cgroup_release
  memcg: do obj_cgroup_put inside drain_obj_stock
  memcg: use __mod_memcg_state in drain_obj_stock
  memcg: assert in_task for couple of local_lock holders
  memcg: trylock stock for objcg
  memcg: no more irq disabling for stock locks

 mm/memcontrol.c | 201 +++++++++++++++++++++++++++---------------------
 1 file changed, 112 insertions(+), 89 deletions(-)

-- 
2.47.1


