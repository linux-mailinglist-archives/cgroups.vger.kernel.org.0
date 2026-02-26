Return-Path: <cgroups+bounces-14440-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BK5AIGgoGlVlAQAu9opvQ
	(envelope-from <cgroups+bounces-14440-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 20:35:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 706CD1AE6BC
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 20:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 793DF30F7E08
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 19:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290A544CF2A;
	Thu, 26 Feb 2026 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcnLBdpr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD792423A8E
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134181; cv=none; b=Uwa13Fn7Q88tt9JCwbEtJd2shsdE90XWHdZQBQ/YOy7pZcHivFi/BifBgTHq9zJb4Je2Pkkdaqjtgpl44F1r07mwx5eJXyHE0XOCPbnh6Dmuhn0fI1OPfDLqpOImMEjKmwpWxNLprx6eYSnL1iL8xANmAdlDjfdpr9USoAfPaVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134181; c=relaxed/simple;
	bh=ZdlDkTKjnXNgim5fvDAs8eRO7tVH7SG/4iGWsBd1uts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNce37DY32YCrgx3CnKgR3yMS2nfPROHmQrYTezDo0xXbIALPovmLgcZG/Xr2ja+n79zf7g3lkl1iSyVhTY5A8CSmN0OYNH+ypDo+AtuOOdbRtCKhkaYF98UgmMPhKrqjtnJAwIDv2jS9CPZGWmuZkgHEuI7sMDrGuHw3vGyXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcnLBdpr; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-464ba2bb3aeso348668b6e.1
        for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 11:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134179; x=1772738979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AADVg9qc0LmRgS4Sxkhna0+iWY0MK1VRsyPEGxGIkaA=;
        b=UcnLBdprFaEXwODqHMAKGvKC2E3y/FeEp42toSIxAwrto1HNlAuQZjj/0ar5+j7wRE
         PwZFTfODuOHEWUtv9h6/HQPfNu8cKv5Qv7nW04QnuNngFKWUtAYiwYHKmMB/xSagBny0
         xJp5NlWvK50RQLfMiT0vA5XA2aQQkLEj9/Xjf3iL5X4TeszebU2rW3CRpqIoNuyv6CVv
         29OnmqQOZGKUB/tZXQ8gA5tkaVje2gjkFJlWg8wPWKZms0TdAgIIXYjIWD4Sy7961gTl
         27GwfUMNI3oGbey7DitDJjem8GPB3V5+hL19fLfQpsFJflCjxeUq+f/9RVKSicVOCjbc
         H3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134179; x=1772738979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AADVg9qc0LmRgS4Sxkhna0+iWY0MK1VRsyPEGxGIkaA=;
        b=Ronz1br9bibPZAr3kHWa1n3AKxPlBBzHRKuGmD8LnwnfL+TGojC+Rd7u7Mm1P8iFwT
         CQJX3OnnGaDlC3d3AqkoicBjfpIz6S+nDE87rwiQvjzd4ZgxUiUbNFMTn5ltebT9LhdW
         /98p7nJKojmOe31YavKsOSpYI0TDBdsQgH0pXv9S1jAq0Kdc8oait6K1elG1bCQH66P6
         8QKVDQdFn4dxNsx/VncIFqdaLIwp42yzoAeTtrrhGJCzajC/YkECW/vUjkp44QiGYxbU
         l3bCgQxTz05xqvoC1nr3aFfYNTNAPjUlcvfdtiTLx2wUVBBjoA9Rbp2eBUUU+Ne/1mwL
         PwsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH8e3btXm7g52783rdQA9IUKtbglmUs490H2O9asU2UaxWnwPiPMdIgi6cdaB7uUzWSFgktF5s@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvCpzgRk2JRrzAZqxbM19WqXplKpbAtVHmEibAN5+BK2jmJKV
	mx9M6eC/L7d/jzq5ugNeZUgL0MzZbAxgpdoE76vh+YCKfIaUagFijfVP
X-Gm-Gg: ATEYQzxTEpAZnTEKsTXhfzmw8u0SnYyWgXU3V6qfM40F2rQMvNC8cCKV8hQibzeusxJ
	WIsi0l+O/nM4+feoGozF+4Y4+a195P7Ytv0EXhURVNtdpSAAlz8QK6P+QNHe5+D4OmWBnLojTU/
	kwTyWHaQNW196FG8RYCU9iK23YtV1Oo/7lMAgOuWXI+PFbMq3dXctDHNJXC2OLZ5GBgHl3Sv7ig
	Wuel8fIHSeJw2vVMt0L8ouOkDHgOwek3BB+JvmoX61TP4baRIYSjQE9QOZJJ4efhEa3kskOuHuU
	101587wuPl8eMQ5RMwQOqTKQWievENfN431lQBdwPS46u5tCKuFc8H0eadgyOkTQhrE55hKppt0
	QWRmc5PTFvAlrFidvshqwtYqi72qmRWd5Mh6OWwM854i0HjH9FDI+XuiokMzXrDL51qZSwMEyyR
	iataOj00pzW7nFHjnvNoeqjQ==
X-Received: by 2002:a05:6808:5143:b0:45f:ea8:4184 with SMTP id 5614622812f47-464bed8fce7mr134294b6e.13.1772134179339;
        Thu, 26 Feb 2026 11:29:39 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb5e417fsm450688b6e.16.2026.02.26.11.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:29:37 -0800 (PST)
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
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 0/8] mm/zswap, zsmalloc: Per-memcg-lruvec zswap accounting
Date: Thu, 26 Feb 2026 11:29:23 -0800
Message-ID: <20260226192936.3190275-1-joshua.hahnjy@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,gmail.com,kernel.org,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	TAGGED_FROM(0.00)[bounces-14440-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 706CD1AE6BC
X-Rspamd-Action: no action

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

Introduce a new per-zpdesc array of objcg pointers to track
per-memcg-lruvec memory usage by zswap, while leaving zram users
unaffected.

This creates one source of truth for NR_ZSWAP, and more accurate
accounting for NR_ZSWAPPED.

This brings sizeof(struct zpdesc) from 56 bytes to 64 bytes, but this
increase in size is unseen by the rest of the system because zpdesc
overlays struct page. Implementation details and care taken to handle
the page->memcg_data field can be found in patch 3.

In addition, move the accounting of memcg charges to the zsmalloc layer,
whose only user is zswap at the moment.

PATCH OUTLINE
=============
Patches 1 and 2 are small cleanups that make the codebase consistent and
easier to digest.

Patches 3, 4, and 5 allocate and populate the new zpdesc->objcgs field
with compressed objects' obj_cgroups. zswap_entry->objcgs is removed,
and redirected to look at the zspage for memcg information.

Patch 6 moves the charging and lifetime management of obj_cgroups to
the zsmalloc layer, which leaves zswap only as a plumbing layer to hand
cgroup information to zsmalloc.

Patches 7 and 8 introduce node counters and memcg-lruvec counters for
zswap. Special care is taken for compressed objects that span multiple
nodes.

[1] https://lore.kernel.org/linux-mm/20250822190817.49287-1-sj@kernel.org/
[2] https://lore.kernel.org/linux-mm/20250402204416.3435994-1-nphamcs@gmail.com/#t3
[3] https://lore.kernel.org/linux-mm/20250829162212.208258-1-hannes@cmpxchg.org/
[4] https://lore.kernel.org/linux-mm/c8bc2dce-d4ec-c16e-8df4-2624c48cfc06@google.com/

Joshua Hahn (8):
  mm/zsmalloc: Rename zs_object_copy to zs_obj_copy
  mm/zsmalloc: Make all obj_idx unsigned ints
  mm/zsmalloc: Introduce objcgs pointer in struct zpdesc
  mm/zsmalloc: Store obj_cgroup pointer in zpdesc
  mm/zsmalloc,zswap: Redirect zswap_entry->obcg to zpdesc
  mm/zsmalloc, zswap: Handle objcg charging and lifetime in zsmalloc
  mm/memcontrol: Track MEMCG_ZSWAPPED in bytes
  mm/vmstat, memcontrol: Track ZSWAP_B, ZSWAPPED_B per-memcg-lruvec

 drivers/block/zram/zram_drv.c |  17 +-
 include/linux/memcontrol.h    |  15 +-
 include/linux/mmzone.h        |   2 +
 include/linux/zsmalloc.h      |   6 +-
 mm/memcontrol.c               |  68 ++------
 mm/vmstat.c                   |   2 +
 mm/zpdesc.h                   |  25 ++-
 mm/zsmalloc.c                 | 282 ++++++++++++++++++++++++++++++++--
 mm/zswap.c                    |  67 ++++----
 9 files changed, 345 insertions(+), 139 deletions(-)

-- 
2.47.3


