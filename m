Return-Path: <cgroups+bounces-12958-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D48FAD00E19
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 04:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D8B8302C13C
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 03:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4465281503;
	Thu,  8 Jan 2026 03:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u0wDgVKZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51816145355
	for <cgroups@vger.kernel.org>; Thu,  8 Jan 2026 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767843171; cv=none; b=pGf16eWbYyv1c+HqxIJ1I+kXp1bNDnbskQyuYfj2rkXV/2Hs/SYsWZfmQFAWZs9I52UiMHN8acB6C6vxE79bd1dzmKpE8wORbBzKjpAvgvw4Es57N71l2RM68J7CH7cYwSPrMgm5X2Ka0hm6MckWsWItgRoDrz7xdrwayhM8uiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767843171; c=relaxed/simple;
	bh=9JBbWmTH96Cmq+82N16gONcZj3kcx3AiPUO2FGeZD6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bqQ9UAbtpXiPMvbV2+br1iDZo1Szt9ZS8+b82YaT7o2qnemEoo0WaQ99hKOojkePMor9+QqtCj04fygdoelheLD18MVOVrWhzXwXMzl2d444uVq9cOZem5p02BrOKXWlKDscatloAtYzWsItkabbppYa3N0jfNGbvapIZsinqKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u0wDgVKZ; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11f3b5411c7so10168201c88.1
        for <cgroups@vger.kernel.org>; Wed, 07 Jan 2026 19:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767843169; x=1768447969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESVCnXmqmRAQ5ODTER3FAbfmr9FGldplMCss/ukq60A=;
        b=u0wDgVKZbREiBz+BRqkcfB+cNvjHWID+TFXOReryGr4DAEhf8r7Gb6wwvPaxwghKYr
         aJttHYyS166F8gZ5XdJURGb0v5DGyvORKp8iZ+aUAX430ooHj7ZXhPdu1N9jBo/drlRb
         +RdpOzml+ByLQcUGFTGXBSHhOLybHBtc0m4zhHE5tCGQUGEZgC1TyejGmC9NFN7Buqu0
         v8JoI/tHpPB6bLieFxdPp5jIgm+AzJZpRVNeZhrSo0qG46cANTvmSQwvUMIcQOoxG4Od
         7WSltz61to2sMfGHtMZ9bmjomefFop2NKhRBIuqhnTBIvCLYQc3L5SAKeFHuFh+zXcMx
         kHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767843169; x=1768447969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESVCnXmqmRAQ5ODTER3FAbfmr9FGldplMCss/ukq60A=;
        b=jMCmeRfUlZgziD5Z9Bm69GWUp4GJSNlXmZ5RPeJfVfwaM0hyJlzpkk/Lt3O+vhD1nf
         zqjqJmVTqudmt6GZ2ISZo5XqXKL3/p+HQJ51txZC5c/vM/MUVky16pzmULTcV+SMc57S
         hSE7tHqjd7OXmh5bEbXYEhC6IpWtgxR302JUW7I2wxOJiC4O0cjakcn06wIPQ6XSSOsv
         NGGYYap/yv259Jd0QgWbSJD77mue3p4FVyn0pthEesKGds8yUIo1mpqIQWwLEqlX42/W
         NnITNy9V4qKq6k1Iu8F8A7EEbRQQuK3WT+53u46sJkGFbb0+nm1fuCeDMU0FBuQC6rAZ
         sHfw==
X-Forwarded-Encrypted: i=1; AJvYcCXblIZV/uiFJJfzIT6hnZn6JW+9BxuI/kTD2rRnHzwTLzfjUUb7rhvg1fFnPF90cZsmxRh4pOc0@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKZ3MyCEnYY2yflEHHiYb9EvgmrKQXc5p2l0OEG+GPzKDqzMF
	BlQLFm719Tba6iAgNqEHCqbWIGpUYSKE8p1BwDXHJj7FPNcuCZSazprCU+5b0zeBWa+PKhu5g4W
	bVUA17JdrK4ZKJQ==
X-Google-Smtp-Source: AGHT+IHrHf9fQdWJM0zf8KVA8vtxEJSCgjeMUhdBV5auR7muROG41/P3KxOzRQbybgRMtKfRwajiaD1GuyIrkw==
X-Received: from dlbrs6.prod.google.com ([2002:a05:7022:f686:b0:11b:b064:f5dc])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:e08:b0:11b:4351:2687 with SMTP id a92af1059eb24-121f8ad0889mr4234493c88.17.1767843169334;
 Wed, 07 Jan 2026 19:32:49 -0800 (PST)
Date: Thu,  8 Jan 2026 03:32:45 +0000
In-Reply-To: <20260106075703.1420072-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260106075703.1420072-1-bingjiao@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108033248.2791579-1-bingjiao@google.com>
Subject: [PATCH v7 0/2] mm/vmscan: fix demotion targets checks in reclaim/demotion
From: Bing Jiao <bingjiao@google.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, gourry@gourry.net, 
	longman@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	tj@kernel.org, mkoutny@suse.com, david@kernel.org, zhengqi.arch@bytedance.com, 
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com, 
	chenridong@huaweicloud.com, yuanchu@google.com, weixugc@google.com, 
	cgroups@vger.kernel.org, joshua.hahnjy@gmail.com, bingjiao@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

I am sorry for issuing a new patch version after v6 has been merged into
mm-hotfixes-unstable.

Main updates in v7:

1. Fixed a bug in v6.

   Specifically, next_demotion_node() may return NUMA_NO_NODE if nodes
   were hot-unplugged. V6 directly checks
   node_isset(target_nid, allowed_mask), which will cause out-of-boundary
   bug if target_nid is NUMA_NO_NODE (-1).

2. Preferred node selection.

   [Patch 1/2] originally implemented a random selection from
   allowed nodes if the preferred node from next_demotion_node()
   was missing from mems_allowed. This behavior contradicts the
   purpose of migration_target_control.nid, which is intended to
   identify the preferred node nearest to the source.

   To resolve this inconsistency, incorporat the preferred node
   selection patch into this series.


If there is a consensus among reviewers to backport Patch 2/2
alongside Patch 1/2, they can be combined.
Otherwise, I will post Patch 2/2 in another series.

Many thanks!

Best regards,
Bing

Bing Jiao (2):
  mm/vmscan: fix demotion targets checks in reclaim/demotion
  mm/vmscan: select the closest preferred node in demote_folio_list()

 include/linux/cpuset.h       |  6 ++--
 include/linux/memcontrol.h   |  6 ++--
 include/linux/memory-tiers.h |  6 ++--
 kernel/cgroup/cpuset.c       | 54 ++++++++++++++++++++++++------------
 mm/memcontrol.c              | 16 +++++++++--
 mm/memory-tiers.c            | 11 +++++---
 mm/vmscan.c                  | 49 +++++++++++++++++++++++++-------
 7 files changed, 105 insertions(+), 43 deletions(-)

--
2.52.0.457.g6b5491de43-goog


