Return-Path: <cgroups+bounces-8148-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCE0AB49F8
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 05:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9436D19E83FA
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 03:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8219F1E0E0B;
	Tue, 13 May 2025 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fsod+VEy"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9E21DF97C
	for <cgroups@vger.kernel.org>; Tue, 13 May 2025 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106032; cv=none; b=gaAjjU50fpj+oAqR+Eu9z5+cR+JTF2ieeStLNhgwAMv3qgCpOBgGvg0Ino37piSUTXtXRfvan3pyZRvfxKEdyQliahohguNzh0Ky4lCqhyVVOT0L18Dp8R8a0+oNYVJ7UnN83kZ10em5A0vA8M5hQVM4J3vl6VlJzuWBgroaRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106032; c=relaxed/simple;
	bh=VNs9FPMzhf8zazFaa800LQaMlJPP89OGHWyxvsX0gWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmLO04ZDRodM3ShlAhQd4RySQXJBnOH2q1GZ6byK9oUDG4+8rrP/7uAt/aAb9bc6IwpU99SVyYchCZ9PtN2E7Ir6DRItMWnAs/+Al/27Hl33WsKJqKTF0cMf5VSXyPisQtIz55h1/Y5DAU4tb7JOsgZixApHj2PLEST6xsYvRPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fsod+VEy; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747106017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GXTE4pS6BF9sV5mPeyf6QZn/p+H6nbjslyn4BcRhdGI=;
	b=fsod+VEy1I0JSZeB2v3fX4N8+mvOIpWzAisX09rwYZcupI5wDatBPi9QzhMWInGbcyHpHO
	CS0cfnbsycQTdfk59F+1eFzWVlNLP7nRQsbrG0KlOt3lydbnsuHyhd+GRbi+2U0qk1Yvrc
	hQ5fF4K0jPNU/7gD+PHZYJ4z8DHXXis=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [RFC PATCH 0/7] memcg: make memcg stats irq safe
Date: Mon, 12 May 2025 20:13:09 -0700
Message-ID: <20250513031316.2147548-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series converts memcg stats to be irq safe i.e. memcg stats can be
updated in any context (task, softirq or hardirq) without disabling the
irqs.

This is still an RFC as I am not satisfied with the usage of atomic_*
ops in memcg_rstat_updated(). Second I still need to run performance
benchmarks (any suggestions/recommendations would be appreciated).
Sending this out early to get feedback.

This is based on latest mm-everything branch along with the nmi-safe
memcg series [1].

Link: http://lore.kernel.org/20250509232859.657525-1-shakeel.butt@linux.dev

Shakeel Butt (7):
  memcg: memcg_rstat_updated re-entrant safe against irqs
  memcg: move preempt disable to callers of memcg_rstat_updated
  memcg: make mod_memcg_state re-entrant safe against irqs
  memcg: make count_memcg_events re-entrant safe against irqs
  memcg: make __mod_memcg_lruvec_state re-entrant safe against irqs
  memcg: objcg stock trylock without irq disabling
  memcg: no stock lock for cpu hot-unplug

 include/linux/memcontrol.h |  41 +--------
 mm/memcontrol-v1.c         |   6 +-
 mm/memcontrol.c            | 167 +++++++++++++++----------------------
 mm/swap.c                  |   8 +-
 mm/vmscan.c                |  14 ++--
 5 files changed, 85 insertions(+), 151 deletions(-)

-- 
2.47.1


