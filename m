Return-Path: <cgroups+bounces-4260-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F5A95235E
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 22:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE092283C76
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 20:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB401C3F0A;
	Wed, 14 Aug 2024 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AJfNgRYr"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA091BC070
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723667323; cv=none; b=Qs+iFEZgsa9S6EWadRUewWWwyJdHA88gYuWDVpl8jBqf/AhSu/0QREX2MCVxwyhwGQ/TVEBHru12pNSTbTfye8KHV6moaqpfMG/QglKyLiohgQHNTRR/USbxXJ91mt42+O2dyQAvM0OGiwNvTwW18Tz8cZ0BgRs5EN+RlPlT/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723667323; c=relaxed/simple;
	bh=XzE1ETz+K8hWzd8XuZBOx9nJvyzMkZFbTiv9VgDNEYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aZqmF5B/BNKF1huXoo6FNk77RFLe0VRB753QAk7MiBC5+fmwx83Z9TW9cIevyDNxC02jw8D9lnruaB2EGZc+TCO+hjP31QpKdzNHtq6lqsf6Ta4TjiHXqN7KASPCGe+ueSHZZTdRONnieAOCPe1jU5RFXwE1g2HjrJJ2/x1cKJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AJfNgRYr; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723667318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8gT4k+nD+2NAHDmmysXrg4dME6CJs31TJGIKLth2C9I=;
	b=AJfNgRYryjyvLTKl8nFxk2llPbLLEUCbVoJ0Bg7PZVSavwWkDL0LoYgAucyExysKC9SObv
	rztZzgdpsRVbWzlbdQhf3c4VChzNm8G1DVKJ46tDNN/ijscZTmOiEvTfd8ak3X5ig6olV0
	cQZuYGhMKOAxwvUuJV6WKJdBWehWelo=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 0/4] memcg: initiate deprecation of v1 features
Date: Wed, 14 Aug 2024 13:28:21 -0700
Message-ID: <20240814202825.2694077-1-shakeel.butt@linux.dev>
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

 .../admin-guide/cgroup-v1/memory.rst          | 32 +++++++++++++++----
 mm/memcontrol-v1.c                            | 16 ++++++++++
 2 files changed, 42 insertions(+), 6 deletions(-)

-- 
2.43.5


