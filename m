Return-Path: <cgroups+bounces-7972-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1379AA67BC
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 02:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244CA1BC7AF5
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 00:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E7DB674;
	Fri,  2 May 2025 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D8tt3RXU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F58801
	for <cgroups@vger.kernel.org>; Fri,  2 May 2025 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746145094; cv=none; b=bv8JaYBUgGn8WVQqIvCNxb1MjNyUdPwYY3NninC791luBmLnUAFttvm9jmoylhNhdPjG0Gg0MLBcxlnDG1IyVD9MKkQmHJqv8K1PhruYndW3sn0j2CyMpqG9RYfIt3+vb2KsNQLXrgrIWoAGLbAbnNsnO5pF3cJ+/hPzveF38Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746145094; c=relaxed/simple;
	bh=aIoHjI9HKI+b6DfSq2WbNBqXIXZUgfmVBMRzreKb8N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0hmLBcW3srFvnJqrdTAyNhYuzvQCQiXrMoaUKG1Otqab87gmCku9k82ZH1qxVkl5YND9qdXkFivHtw6xvfMO/mBo9W2aN0rQDTTZS9p8ZNfeVho45XuGuH9HZBFZwV58UdjNy048zW7VNN18CZguh96PeVUg0M5ngtf7Fou2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D8tt3RXU; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746145081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FAQQHMseiTFfB73eqU9yeUG42Iz5JnWxEBkUeFyyRhs=;
	b=D8tt3RXUQ8nh+AvmKFaVtfB8LLsU/KucHvhWR/6JdnA9RGI+k7bI+ghFCtFuO4SU5kueaI
	YmVJBOLxIf5nbTqCAgYjbXvwCBu2/AT5v+Z8cKmAAG+CYi0S+/P9ujlNNicbhznV9FwTJm
	I5+Z1oYoYcdDmDOcc/Kz0R0zwTDFbRQ=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 0/3] memcg: decouple memcg and objcg stocks
Date: Thu,  1 May 2025 17:17:39 -0700
Message-ID: <20250502001742.3087558-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The per-cpu memcg charge cache and objcg charge cache are coupled in a
single struct memcg_stock_pcp and a single local lock is used to protect
both of the caches. This makes memcg charging and objcg charging nmi
safe challenging. Decoupling memcg and objcg stocks would allow us to
make them nmi safe and even work without disabling irqs independently.
This series completely decouples memcg and objcg stocks.

Changes since v1:
- Drop first patch as requested by Alexei.
- Remove preempt_disable() usage as suggested by Vlastimil.

Shakeel Butt (3):
  memcg: separate local_trylock for memcg and obj
  memcg: completely decouple memcg and obj stocks
  memcg: no irq disable for memcg stock lock

 mm/memcontrol.c | 159 +++++++++++++++++++++++++++++-------------------
 1 file changed, 97 insertions(+), 62 deletions(-)

-- 
2.47.1


