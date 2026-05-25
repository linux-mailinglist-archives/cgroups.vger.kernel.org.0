Return-Path: <cgroups+bounces-16244-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vI8RKig/FGoXLQcAu9opvQ
	(envelope-from <cgroups+bounces-16244-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 14:23:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F45F5CA6A1
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 14:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBEB73016CBE
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 12:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245093815FE;
	Mon, 25 May 2026 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1Nu6j/Q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2A033D4EE
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711777; cv=none; b=tnlpcoWs674ql2vGZA6/Mo1ruyVVcwhtfUQt9SRfjVSDkVL9rT0ZxNl8iZMC1HiC7Tc/IPLu3Hvb/cs+9U7Utuu+6QVwkcd+WqjXQaZpd2uBQQGWUZ9dEBYRRxLYqRH4VrVIx1b1nBPP6WdNGErLajlD8mWNY71MmQqANlPDzHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711777; c=relaxed/simple;
	bh=Yo7Ky/LHGaqLpQiIGCLB/PsMXfu9aCIuIh28NNc4dd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c2EmLMnWz3DR6YCMM4KtipIPhokJ22hhqca3WVNw5rZQptasDdND/Y0gVjjaWzEc7HdObAePzGQ5wDyILkzD0mRuNsOJmgC2oQRaByswyn/bPGTrYXFmLzFnZfjo67wPY/7p92SUHYOsLCurRZzynkuHSJbjYKO9UeYNjuth3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1Nu6j/Q; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36974217d4eso6230032a91.2
        for <cgroups@vger.kernel.org>; Mon, 25 May 2026 05:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779711776; x=1780316576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IwuURQBEyX2Ow+eyi17IhR1pDynYjLjI1eOjjb4C8q8=;
        b=p1Nu6j/QC7nQggvFeVMBTSKaf2KLm9n6qHsWcXZDrhMA/FhAZI+cAUUvjUuk5S+v81
         odI0uwzZtZwfRR4OPajk9ISuAUmklAv7gUidppnO1fsjwxBXSaOiLJEjM3shHznfJ/Ox
         3pxj2ZKvvRkHu8JSgU+Y9FgbdfHrmu2m+ajfNlgy9NKugp1IuLKCAWNzTsvoMRGJAAu3
         mTIM7vzvSbCkWe6dbF1TzvID9dA/s04cU8Kn3RjUAmQ1+qAboDqlhtnXJ/7IhLOaWsBy
         jT4K7eyx9c66Um9FVkiICbjMzfp0aNLAYRHMPy1iF6DTNjAC3CU1KuI6pByPWXuUdCxT
         1avA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711776; x=1780316576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwuURQBEyX2Ow+eyi17IhR1pDynYjLjI1eOjjb4C8q8=;
        b=BKdRRloJMAMvRDp9OCJiJYNF5MXX8MipRAyai+L9a8mX/luge/sZiYWy5Ibbe36f/8
         gBwj3XAbVJZ6RBLoEhWmsEj+kKTLP4au1frGyqAzqMnnTcycJEMCyki6LEzclbHsVu/E
         MKc/5KtQKuok7sk7RisFvGf+KJkJvKlxTPqSLdIYMNjLLWH4F8C3W+guk9qjhzyBLif4
         46bLTFpGg56EtaZCqeRSk0NsvcYM9jfaXUuCLZ/CvX5YYPbeWrXanYbqs5JLWaMny/Ie
         di3AvLIrAEtwlaDRtFpPTgejltKfnEH2ECidlUMLhpU2yf1xET2h9zUc24ckKxzrp3lh
         fJ6A==
X-Gm-Message-State: AOJu0YzydXLF5KH7KBRwJRsRcNe9Epihmdtpcfnpocd7ceRZekrPlLck
	BhGxZm2H5qjepOPB+AwXAIBIiWXeoE7lJg7C2HMdDB5A9LrFwhzcWlbn
X-Gm-Gg: Acq92OHbAY7376fRJ5MYC+F1Lqwf9asd4QW0d2hBC/TSKCNnIpD97fE4MNY9Z7lEg+n
	TNpwN7qMB8gMwu4/5Vcw5LXOCJJoh2RlLzc7IOLS9EQCLaJuSnRo8TWCQsYz8JCk9qxaumiUCtN
	J8X9bOcIQX9vr3AQWiANoepczN8erx3PR0iQb9DhVRqNzyUXJOhbok1l+/o/V9/kRCYV9PJJ4R4
	pYKUm+Hr2eOb1F7s4BtNlwQDL6h1hUz+qc198TB21pXHOB8OFApn98KgMnszJt8+BK4ueOao6S7
	8OXq9ghWj/tltjiKEnvUe3eAki7I18UAMe49lXQGfItz34M0hNuz0j2sqPubBSsWd61IdnRfOcH
	b8FkslOpHgVp68zwJ+i+QJkSghDCSqGYESoj1VYVPreqWSeBOXskErXQM5cumKs92ttB9NH2UgG
	GWquE4UUohX6VI5kS2uUw2Rh9oBlV8tjILxZyEinwtduzOqLj7p+0=
X-Received: by 2002:a17:90b:384a:b0:368:d839:28d5 with SMTP id 98e67ed59e1d1-36a677fd1f8mr13345191a91.18.1779711776032;
        Mon, 25 May 2026 05:22:56 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c913a1sm8999131a91.15.2026.05.25.05.22.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 May 2026 05:22:55 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: akpm@linux-foundation.org,
	tj@kernel.org,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org,
	yosry@kernel.org,
	mkoutny@suse.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: [PATCH v2 0/4] mm/zswap: Implement per-cgroup proactive writeback
Date: Mon, 25 May 2026 20:22:38 +0800
Message-Id: <20260525122242.36127-1-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16244-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lixiang.com:email]
X-Rspamd-Queue-Id: 4F45F5CA6A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hao Jia <jiahao1@lixiang.com>

Zswap currently writes back pages to backing swap reactively, triggered
either by the shrinker or by the pool reaching its size limit. Although
proactive memory reclaim can automatically write back a portion of zswap
pages via the shrinker, it cannot explicitly control the amount of
writeback for a specific memory cgroup. Moreover, proactive memory reclaim
may not always be triggered during a steady state.

In certain scenarios, it is desirable to trigger writeback in advance to
free up memory. For example, users may want to prepare for an upcoming
memory-intensive workload by flushing cold memory to the backing storage
when the system is relatively idle.

This patch series introduces a "zswap_writeback_only" key to memory.reclaim
cgroup interface, allowing users to proactively write back cold compressed
pages from zswap to the backing swap device. When specified, this key
bypasses standard memory reclaim and exclusively performs proactive zswap
writeback up to the requested budget. If omitted, the default reclaim
behavior remains unchanged.

Example usage:
  # Write back 100MB of pages from zswap to the backing swap
  echo "100M zswap_writeback_only" > memory.reclaim

Patch 1: Move the global zswap shrink cursor into struct mem_cgroup as a
  per-memcg zswap_wb_iter, so patch 2 can scope writeback to a given memcg
  and make forward progress across its subtree on repeated invocations.

Patch 2: Extend the memory.reclaim cgroup v2 interface with a new
  "zswap_writeback_only" key, allowing users to trigger proactive zswap
  writeback up to a requested budget.

Patch 3: Add a zswpwb_proactive counter to memory.stat and /proc/vmstat
  to track the number of writebacks triggered by proactive writeback.

Patch 4: Add tests for zswap proactive writeback.

v1->v2:
    - As suggested by Yosry and Nhat, extend the memory.reclaim cgroup v2
      interface with a "zswap_writeback_only" key instead of adding a new
      dedicated cgroup interface.
    - Update the zswap documentation and add selftests for proactive writeback.

[v1] https://lore.kernel.org/all/20260511105149.75584-1-jiahao.kernel@gmail.com

Hao Jia (4):
  mm/zswap: Make shrink_worker writeback cursor per-memcg
  mm/zswap: Implement proactive writeback
  mm/zswap: Add per-memcg stat for proactive writeback
  selftests/cgroup: Add tests for zswap proactive writeback

 Documentation/admin-guide/cgroup-v2.rst     |  22 +-
 Documentation/admin-guide/mm/zswap.rst      |  11 +-
 include/linux/memcontrol.h                  |   3 +
 include/linux/vm_event_item.h               |   1 +
 include/linux/zswap.h                       |  16 ++
 mm/memcontrol.c                             |   4 +
 mm/vmscan.c                                 |  14 +
 mm/vmstat.c                                 |   1 +
 mm/zswap.c                                  | 292 +++++++++++++++++---
 tools/testing/selftests/cgroup/test_zswap.c | 161 ++++++++++-
 10 files changed, 470 insertions(+), 55 deletions(-)

-- 
2.34.1


