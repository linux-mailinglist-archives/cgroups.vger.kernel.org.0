Return-Path: <cgroups+bounces-14178-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCEUA+TwnGkaMQQAu9opvQ
	(envelope-from <cgroups+bounces-14178-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 01:29:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 836881803B7
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 01:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B171330FED72
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 00:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6642C21A447;
	Tue, 24 Feb 2026 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZF9p1GW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E128478F59
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892859; cv=none; b=p28ihEeYZ8kpgwmmKSnA4HjXZWloF/Rz1MNZm/OEOA7oIEH/ibpW1ZVPS8hZPk6RULRRogPCmo3lg+XNcDc/i12N0GIwYsB2xzGvYn4Pr2EM2BelcXgxrqeS3PO7lPsArYQNBcAqTNvnObE1X1dbQpFr4VTMkQLJl2E5vpYIaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892859; c=relaxed/simple;
	bh=E8aK7KidsxhYI9fT3xeIpRXL2fMl/FJi1hO1vuu1bMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDSuLkXbvzrLhWgDinM+THyoEDHs0YbvLvbyzVJxn9e2MPQGECep6W5vxMFyVvXYnGNOnNfoF3MTV5NquTOYTiDOO1dz34zc3hTpu0XdgXSVr3Cc7cT+t3gRwi+TPLM6oD3ON2zkRhIU044dw4R+ankIljEYgxLMZe0f4VVZv/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZF9p1GW; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5fadd5d4319so3650473137.1
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 16:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771892857; x=1772497657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r71zDlsdwqZwuXP6L6SMlSArsf0mkKQK+1/SxbuvMeM=;
        b=GZF9p1GWHeEHdA2aVWbd7ggVKuz0Iy02BBgBLKB0wJ4mZJ8mdsNgJEyC3imOktrPk/
         w5NO3m9HbmIpgAeWBHP3rKnVViYhB9H2l8vJunE8kSKuZWDmyzrxRCmk4BU1jjL3MX4Y
         CEaeeh8sw0nbff4NpqexV3/fRANQCumbOpMqNbxVvHLaDjRk/0nJP09thtdiNd91xJfG
         z+lyBJ7nSrYsoGd+d+awSLemLDidk2TydTjlTGKhPsxJWUMRlFAse/XZkdDCyxWyRz1A
         SgNCz8AfSLwbA1GNt2MBkhzYK7sdE4Z2D0h6824sG7Qonzicg4feLUKE2Vmt6gOCK2KC
         KpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771892857; x=1772497657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r71zDlsdwqZwuXP6L6SMlSArsf0mkKQK+1/SxbuvMeM=;
        b=vgm5ItRQOqKIUjq4aJKBKNNTq3Iej68byDPAuO/2aKqpbvqsDVK+Ia0gJ9dgSBV/ht
         usnu5GhjTy2wXnVhxnzvkue6lUZgcdZKOC06c94TtPd15A2H19prtZs6X6WOO5Oax/30
         NgE3ywymDyVBLZv9wHqOrzw2/4lTqs/M78+aUpHHmuZkek+hrgzwp6sY6phYw9Jw8T85
         NRSXzgF5bnP32zlTbkEU+EtdgVzD5jZgmUn1S9wH1tYMAOlfME4fvKu2dXoGCVNrphfO
         ck87sGQvNHf8SZLVMNS2W0OG3hZfn2IpMPjIHZqEuAPFLA+8M2j50XwmedenXWNCp9qp
         Mczg==
X-Forwarded-Encrypted: i=1; AJvYcCVEXCsyguukWtbUn1rMMA0Rz900xEpiJx+jh4CHotuJfJ5K+NNvz8FPfEgqttELbUvyoVHJZDlr@vger.kernel.org
X-Gm-Message-State: AOJu0YxmV1kZarsKlPwLJ7wCDoFqUygaUY6fHa0BGHlZYfEo4ViE4eSq
	2p1GsM3E9T1uC+2DVXcLigN1Z6i9wi8j4F/P8UMEjEORTGy3RRJ3FbiZ
X-Gm-Gg: ATEYQzzT2yZNiDX2pRgqvLvw9nyfmHs940/qivWt9JZI4JA3amVjlWYhtrC5rZfWYdG
	V/Pe8nRdrWvmPGS7DccQCiHFX577qx2YhQWDQ+xnTvMPVEyuQTC/umQ6HUgykzfWKI9r+/LoF65
	qS+38ngp5p3ryUA+EwbHoYXyXZUy0G6xtx/nRuaNrtHmb922lY2UXkEjB5JPYQYn0fT5oapE7i4
	+E5D1ICj4GI+Rgw2IFbA+p9373zJsoLGAmWG0F6+NquNxaHH80e8P2giSlGCvaFpj3WzjBw3L4b
	5yGex5VVmmoSuyCWKdJm8HBtFvnX43cJ1U0jx4BSUuB8HLfc228n7mSPw/m8hkc+9HrNVBQZBfR
	AfRQbV3LhYvZTComjiaQhDaggVk+Lj5GptQmEJm0U4ZTWLrCcfVerL2pCP3s1z7U9qbdm60cWuq
	TWtDPeSI78vUCA/1OFnf1deIeDhl02uI6o
X-Received: by 2002:a05:6820:2d0b:b0:679:92c7:2c07 with SMTP id 006d021491bc7-679c42784famr5858006eaf.29.1771886313849;
        Mon, 23 Feb 2026 14:38:33 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c5630a4bsm7167922eaf.2.2026.02.23.14.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:38:31 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: 
Cc: Gregory Price <gourry@gourry.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Michal Koutny <mkoutny@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 0/6] mm/memcontrol: Make memcg limits tier-aware
Date: Mon, 23 Feb 2026 14:38:23 -0800
Message-ID: <20260223223830.586018-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14178-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 836881803B7
X-Rspamd-Action: no action

Memory cgroups provide an interface that allow multiple workloads on a
host to co-exist, and establish both weak and strong memory isolation
guarantees. For large servers and small embedded systems alike, memcgs
provide an effective way to provide a baseline quality of service for
protected workloads.

This works, because for the most part, all memory is equal (except for
zram / zswap). Restricting a cgroup's memory footprint restricts how
much it can hurt other workloads competing for memory. Likewise, setting
memory.low or memory.min limits can provide weak and strong guarantees
to the performance of a cgroup.

However, on systems with tiered memory (e.g. CXL / compressed memory),
the quality of service guarantees that memcg limits enforced become less
effective, as memcg has no awareness of the physical location of its
charged memory. In other words, a workload that is well-behaved within
its memcg limits may still be hurting the performance of other
well-behaving workloads on the system by hogging more than its
"fair share" of toptier memory.

Introduce tier-aware memcg limits, which scale memory.low/high to
reflect the ratio of toptier:total memory the cgroup has access.

Take the following scenario as an example:
On a host with 3:1 toptier:lowtier, say 150G toptier, and 50Glowtier,
setting a cgroup's limits to:
	memory.min:  15G
	memory.low:  20G
	memory.high: 40G
	memory.max:  50G

Will be enforced at the toptier as:
	memory.min:          15G
	memory.toptier_low:  15G (20 * 150/200)
	memory.toptier_high: 30G (40 * 150/200)
	memory.max:          50G

Let's say that there are 4 such cgroups on the host. Previously, it would
be possible for 3 hosts to completely take over all of DRAM, while one
cgroup could only access the lowtier memory. In the perspective of a
tier-agnostic memcg limit enforcement, the three cgroups are all
well-behaved, consuming within their memory limits.

This is not to say that the scenario above is incorrect. In fact, for
letting the hottest cgroups run in DRAM while pushing out colder cgroups
to lowtier memory lets the system perform the most aggregate work total.

But for other scenarios, the target might not be maximizing aggregate
work, but maximizing the minimum performance guarantee for each
individual workload (think hosts shared across different users, such as
VM hosting services).

To reflect these two scenarios, introduce a sysctl tier_aware_memcg,
which allows the host to toggle between enforcing and overlooking
toptier memcg limit breaches.

This work is inspired & based off of Kaiyang Zhao's work from 2024 [1],
where he referred to this concept as "memory tiering fairness".
The biggest difference in the implementations lie in how toptier memory
is tracked; in his implementation, an lruvec stat aggregation is done on
each usage check, while in this implementation, a new cacheline is
introduced in page_coutner to keep track of toptier usage (Kaiyang also
introduces a new cachline in page_counter, but only uses it to cache
capacity and thresholds). This implementation also extends the memory
limit enforcement to memory.high as well.

[1] https://lore.kernel.org/linux-mm/20240920221202.1734227-1-kaiyang2@cs.cmu.edu/

---
Joshua Hahn (6):
  mm/memory-tiers: Introduce tier-aware memcg limit sysfs
  mm/page_counter: Introduce tiered memory awareness to page_counter
  mm/memory-tiers, memcontrol: Introduce toptier capacity updates
  mm/memcontrol: Charge and uncharge from toptier
  mm/memcontrol, page_counter: Make memory.low tier-aware
  mm/memcontrol: Make memory.high tier-aware

 include/linux/memcontrol.h   |  21 ++++-
 include/linux/memory-tiers.h |  30 +++++++
 include/linux/page_counter.h |  31 ++++++-
 include/linux/swap.h         |   3 +-
 kernel/cgroup/cpuset.c       |   2 +-
 kernel/cgroup/dmem.c         |   2 +-
 mm/memcontrol-v1.c           |   6 +-
 mm/memcontrol.c              | 155 +++++++++++++++++++++++++++++++----
 mm/memory-tiers.c            |  63 ++++++++++++++
 mm/page_counter.c            |  77 ++++++++++++++++-
 mm/vmscan.c                  |  24 ++++--
 11 files changed, 376 insertions(+), 38 deletions(-)

-- 
2.47.3


