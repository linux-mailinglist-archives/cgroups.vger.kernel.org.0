Return-Path: <cgroups+bounces-4275-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2944952520
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 00:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA3C283D8A
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 22:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83521448E1;
	Wed, 14 Aug 2024 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZEahO8ce"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0B222309
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672830; cv=none; b=kFhPnXupFygl/ErbM/gEktRXUgzy9LLDEtG2hHXkCpam0qSfC6UYOTOKO53ZdH6Crb9EqTQW4I8ajzL5ip1qWPEr5sLzVKLEJuUINywBeirO3cgsXAD+kzhhNXGmaoMzwq9oKlVJR5yjQY3ask+P+TNOcV1j6ucekEhRG49Xu4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672830; c=relaxed/simple;
	bh=Hy2l3Kd5vIwYKC14jEEHBL6OIlOn3yABUUqjBVOB1g0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K7u3sDAgex+8N+pQAYbJbtcj07OJHYFZSdVPwRB8O7d+4MxolayH+DAn3V0tShT6dqngJxwFZlPpWzgCwrWvSkGdNpbUNgHEKHxIifzyrrFKm0w9Wfj1+y9i0h9D/jHcy5JjwLdiudpVLhiC3MkY5J/863CM59EYTOIZKemTnZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZEahO8ce; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723672825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RykrRFaWygVplCfW2DFKnLZ0ZDIXWFKLYuy58Z4lhbY=;
	b=ZEahO8ce1aa/WeNbU8zA/ORH4wa9+aHg+yIhsqdMFKaR8b5q40Dj9XV+JCY6rNpQyQnswY
	gRfttltGnLqTpVVcKjowhfCMDeqZB5Ruz4/8DHEOYKGel1XTe+UfQORbGBoQUUoTeDpsL+
	nq690nUKpVtlz1ItMcJxvOwpHSPZaDA=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH v2 0/4] memcg: initiate deprecation of v1 features
Date: Wed, 14 Aug 2024 15:00:17 -0700
Message-ID: <20240814220021.3208384-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Let start the deprecation process of the memcg v1 features which we
discussed during LSFMMBPF 2024 [1]. For now add the warnings to collect
the information on how the current users are using these features. Next
we will work on providing better alternatives in v2 (if needed) and
fully deprecate these features.

Link: https://lwn.net/Articles/974575 [1]

Shakeel Butt (4):
  memcg: initiate deprecation of v1 tcp accounting
  memcg: initiate deprecation of v1 soft limit
  memcg: initiate deprecation of oom_control
  memcg: initiate deprecation of pressure_level

Changes since v1:
- Fix build (T.J. Mercier)
- Fix documentation

 .../admin-guide/cgroup-v1/memory.rst          | 32 +++++++++++++++----
 mm/memcontrol-v1.c                            | 16 ++++++++++
 2 files changed, 42 insertions(+), 6 deletions(-)

-- 
2.43.5


