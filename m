Return-Path: <cgroups+bounces-14769-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEaIL+nHsWnvFAAAu9opvQ
	(envelope-from <cgroups+bounces-14769-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 20:52:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA08269A1D
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 20:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29E54300A4E9
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 19:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA2537B02E;
	Wed, 11 Mar 2026 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnmGKMYx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341F37A4B2
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258719; cv=none; b=EEzlKosU/qkq41QtISjKQWOWHLF8MqPIujYRNS/U/0M3rWsdqgZqFKgxusCRh0zjGT9lU7cUaFQ6YSCmtmDdgu4JTOs/1kK/mgXhXOjnTDNApfsRAelJEDum0naHKGYh+xEKEKHOYpMZ6ihWGKKF6raaOre9AELUAg1TdnTo1EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258719; c=relaxed/simple;
	bh=2/WN+rUaGr+rojGU+gbqUBINEwtxu/oqu3Hvusx/7nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oc0VOqWyHVlfdtlqH56mMgdDeWOHeUvL/fyBBm0N2pgG3yoMTxW6hWp/7UTzf6YfSuRU/Sp5iesvBwZXgJ1+Yq6rLh0WPtM7wiUEXZn0iaEu9eSINIBeS/Ad20ybT6hMXYcUfYT7PWzJapJXuOP6aAfl0eTkk6QpMDJJvpW/8/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnmGKMYx; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4671cbce465so171449b6e.3
        for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 12:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773258714; x=1773863514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7aHPhdDyOXpYHbCyzKIIDvUmbmQ3BcfB3tK1FnL3jrw=;
        b=UnmGKMYxjhLRBj1ibHd8UAVdmmL9PmzzUQKE9uMIOFrvXvvC2KcVNqEIX5Vtge03kG
         Rk1dfkKZn4/IludvXrsJKvITXduoXU0YWdnDwdB0FYl+tizzWNGXL7+/KHOxJpKS4SYU
         0u2TC0LKKIMkzqrAwI2zZB8wzb2RjkJY5ugXv50/Ao0XA9GfV2mFRJI1CAVIddK365QU
         0/7Xk2uBzw2WILLDd3UJ2esMHl6Fr5qYBi3JjDIakRhr/SZv44SBkBUwKbnM1ikP9O42
         zLCXhs+USyPPzcJKq0Pl+TCY4e3Q9KRWL0h4Y5SigyoTh/NTwkxLwxZd7hMv3MrG8gTd
         2VMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258714; x=1773863514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aHPhdDyOXpYHbCyzKIIDvUmbmQ3BcfB3tK1FnL3jrw=;
        b=KpxmwPD/IVV0Z0KM2tclwvERThVmn/dmd/dbquSo7+eNLY/5SoyE8SUs32IajC7qN6
         Near3UwIPi2SUWnUh9f4hYmkJoNq0LKcnzPijIqvM2m2jLWQYElb1oOQhjqfl7SSqINk
         rKYE+UFba2Nw7H5hlS9cU469tiMZXEpEBJAWgFmdW/LFtOFmqq0dwuVG2mkoVRzOXAfU
         c1zDgW4TVOsvfgJZa0HUzTkk5+jXUPANdn2EKaZhRF9MHA81/aF24WQNMyQYDnJilhLE
         b53YMoxkH8FaUU3viUydi7KqF44rXaNkyPKIX3nyr0/Y1dLvSyDWMA6VqsGICJJe0oWo
         DT8w==
X-Forwarded-Encrypted: i=1; AJvYcCUTeOIUaailg17Nzo2PxX03mJd2KeufT2vk8HGF6NOyqsZRs/LwqMaBe4I9KZQf8XpMzma6/y+N@vger.kernel.org
X-Gm-Message-State: AOJu0YzBzonegJkTn42yKnaMZ4yNS172T3UFRnQ/7//6qo3SA2mZrdKy
	2YuhrXf2TkbFGNecqitrV1bAs2BABC2ptYJP0DU7zaw3XSspxOMn0Rvo
X-Gm-Gg: ATEYQzyV4nRbO7n3Gt12vXzVvjJZhwAn8UbXk2J9IIGRg1QdL8U/iY/HSa73OT+sjgb
	jyDDVaRSPqMyooXBMwFcEdWOxFEruwo0Ru6QDWRJbqJLBQsWO+S6ZZDAXQskyd34DXsHSaM3MFA
	0N4xsJOBW1L3NLUoNiXAjj4VLWfEz6EWhUSUEWesPf+2UD5uN5xTe55ZU4dEWLC9wI7YLpAL/22
	MOQ0CR6pK2lnyOhVLnL8qqcqMjHT3ur9EgK+Ak7MraA08McGcGO1EyLt4/9OZ/vUXnC6vOXq4Wp
	AkcWRDwOckTGP7UVM3qxUxI5jWNCuA1t5Sto4/+V8ApEGUX6nTOCvSGZ/7rXwOlhkhxKS19Y1TT
	jnAR1aVsnUdYA+BiTeO9+Gc9T6forpSpKT+RVrqJz1OOb2o3Kt0QA6oNC0QU06WD1kTtpCcH/GJ
	FIhb48udxs7H7zGFKZ14jn
X-Received: by 2002:a05:6808:14c6:b0:467:e7b:6fd5 with SMTP id 5614622812f47-4673359a676mr2487176b6e.41.1773258714266;
        Wed, 11 Mar 2026 12:51:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46734125bdasm1805164b6e.1.2026.03.11.12.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:51:53 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 00/11] mm/zswap, zsmalloc: Per-memcg-lruvec zswap accounting
Date: Wed, 11 Mar 2026 12:51:37 -0700
Message-ID: <20260311195153.4013476-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,gmail.com,kernel.org,oracle.com,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	TAGGED_FROM(0.00)[bounces-14769-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DA08269A1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

INTRODUCTION
============
The current design for zswap and zsmalloc leaves a clean divide between
layers of the memory stack. At the higher level, we have zswap, which
interacts directly with memory consumers, compression algorithms, and
handles memory usage accounting via memcg limits. At the lower level,
we have zsmalloc, which handles the page allocation and migration of
physical pages.

While this logical separation simplifies the codebase, it leaves
problems for accounting that requires both memory cgroup awareness and
physical memory location. To name a few:

 - On tiered systems, it is impossible to understand how much toptier
   memory a cgroup is using, since zswap has no understanding of where
   the compressed memory is physically stored.
   + With SeongJae Park's work to store incompressible pages as-is in
     zswap [1], the size of compressed memory can become non-trivial,
     and easily consume a meaningful portion of memory.

 - cgroups that restrict memory nodes have no control over which nodes
   their zswapped objects live on. This can lead to unexpectedly high
   fault times for workloads, who must eat the remote access latency
   cost of retrieving the compressed object from a remote node.
   + Nhat Pham addressed this issue via a best-effort attempt to place
     compressed objects in the same page as the original page, but this
     cannot guarantee complete isolation [2].

 - On the flip side, zsmalloc's ignorance of cgroup also makes its
   shrinker memcg-unaware, which can lead to ineffective reclaim when
   pressure is localized to a single cgroup.

Until recently, zpool acted as another layer of indirection between
zswap and zsmalloc, which made bridging memcg and physical location
difficult. Now that zsmalloc is the only allocator backend for zswap and
zram [3], it is possible to move memory-cgroup accounting to the
zsmalloc layer.

Introduce a new per-zspage array of objcg pointers to track
per-memcg-lruvec memory usage by zswap, while leaving zram users
mostly unaffected.

In addition, move the accounting of memcg charges from the consumer
layer (zswap, zram) to the zsmalloc layer. Stat indices are
parameterized at pool creation time, meaning future consumers that wish
to account memory statistics can do so using the compressed object
memory accounting infrastructure introduced here.

PERFORMANCE
===========
The experiments were performed across 5 trials on a 2-NUMA machine.

Experiment 1
Node-bound workload, churning memory by allocating 2GB in 1GB cgroup.
0.638% regression, standard deviation: +/- 0.603%

Experiment 2:
Writeback with zswap pressure
0.295% gain, standard deviation: +/- 0.456%

Experiment 3:
1 cgroup, 2 workloads each bound to a NUMA node.
2.126% regression, standard deviation: +/- 3.008%

Experiment 4:
Reading memory.stat 10000x
1.464% gain, standard deviation: +/- 2.239%

Experiment 5:
Reading memory.numa_stat 10000x
0.281% gain, standard deviation: +/- 1.878%

It seems like all of the gains or regressions are mostly within the
standard deviation. I would like to note that workloads that span NUMA
nodes may see some contention as the zsmalloc migration path becomes
more expensive.

PATCH OUTLINE
=============
Patches 1 and 2 are small cleanups that make the codebase consistent and
easier to digest.

Patch 3 introduces memcg accounting-awareness to struct zs_pool, and
allows consumers to provide the memcg stat item indices that should be
accounted. The awareness is not functional at this point.

Patches 4, 5, and 6 allocate and populate the new zspage->objcgs field
with compressed objects' obj_cgroups. zswap_entry->objcgs is removed
and redirected to look at the zspage for memcg information.

Patch 7 moves the charging and lifetime management of obj_cgroups to the
zsmalloc layer, which leaves zswwap only as a plumbing layer to hand
cgroup information to zsmalloc at compression time.

Patches 8 and 9 introduce node counters and memcg-lruvec counters for
zswap.

Patches 10 and 11 handle charge migrations for the two types of compressed
object migration in zsmalloc. Special care is taken for compressed
objects that span multiple nodes.

CHANGELOG V1 [4] --> V2
=======================
A lot has changed from v1 and v2, thanks to the generous suggestions
from reviewers.
- Harry Yoo's suggestion to make the objcgs array per-zspage instead of
  per-zpdesc simplified much of the code needed to handle boundary
  cases. By moving the array to be per-zspage, much of the index
  translation (from per-zspage to per-zpdesc) has been simplified. Note
  that this does make the reverse true (per-zpdesc to per-zspage is
  harder now), but the only case this really matters is during the
  charge migration case in patch 10. Thank you Harry!

- Yosry Ahmed's suggestion to make memcg awareness a per-zspool decision
  has simplified much of the #ifdef casing needed, which makes the code
  a lot easier to follow (and makes changes less invasive for zram).

- Yosry Ahmed's suggestion to parameterize the memcg stat indices as
  zs_pool parameter makes the awkward hardcoding of zswap stat indices
  in zsmalloc code more natural & leaves room for future consumers to
  follow. Thank you Yosry!

- Shakeel Butt's suggestion to turn the objcgs array from an unsigned
  long to an objcgs ** pointer made the code much cleaner. However,
  after moving the pointer from zpdesc to zspage, there is now no longer
  a need to tag the pointer. Thank you, Shakeel!

- v1 only handled the migration case for single compressed objects.
  Patch 10 in v2 is written to handle the migration case for zpdesc
  replacement.
  + Special-casing compressed objects living at the boundary are a tad
    bit harder with per-zspage objcgs. I felt that this difficulty was
    outweighed by the simplification in the "typical" write/free case,
    though. 

REVIEWERS NOTE
==============
Patches 10 and 11 are a bit hairy, since they have to deal with special
casing scenarios for objects that span pages. I originally implemented a
very simple approach which uses the existing zs_charge_objcg functions,
but later realized that these migration paths take spin locks and
therefore cannot accept obj_cgroup_charge going to sleep.

The workaround is less elegant, but gets the job done. Feedback on these
two commits would be greatly appreciated!

[1] https://lore.kernel.org/linux-mm/20250822190817.49287-1-sj@kernel.org/
[2] https://lore.kernel.org/linux-mm/20250402204416.3435994-1-nphamcs@gmail.com/#t3
[3] https://lore.kernel.org/linux-mm/20250829162212.208258-1-hannes@cmpxchg.org/
[4] https://lore.kernel.org/all/20260226192936.3190275-1-joshua.hahnjy@gmail.com/

Joshua Hahn (11):
  mm/zsmalloc: Rename zs_object_copy to zs_obj_copy
  mm/zsmalloc: Make all obj_idx unsigned ints
  mm/zsmalloc: Introduce conditional memcg awareness to zs_pool
  mm/zsmalloc: Introduce objcgs pointer in struct zspage
  mm/zsmalloc: Store obj_cgroup pointer in zspage
  mm/zsmalloc, zswap: Redirect zswap_entry->objcg to zspage
  mm/zsmalloc, zswap: Handle objcg charging and lifetime in zsmalloc
  mm/memcontrol: Track MEMCG_ZSWAPPED in bytes
  mm/vmstat, memcontrol: Track ZSWAP_B, ZSWAPPED_B per-memcg-lruvec
  mm/zsmalloc: Handle single object charge migration in migrate_zspage
  mm/zsmalloc: Handle charge migration in zpdesc substitution

 drivers/block/zram/zram_drv.c |  10 +-
 include/linux/memcontrol.h    |  20 +-
 include/linux/mmzone.h        |   2 +
 include/linux/zsmalloc.h      |   9 +-
 mm/memcontrol.c               |  75 ++-----
 mm/vmstat.c                   |   2 +
 mm/zsmalloc.c                 | 381 ++++++++++++++++++++++++++++++++--
 mm/zswap.c                    |  66 +++---
 8 files changed, 431 insertions(+), 134 deletions(-)

-- 
2.52.0


