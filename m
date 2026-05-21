Return-Path: <cgroups+bounces-16165-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEbiFiElD2paGgYAu9opvQ
	(envelope-from <cgroups+bounces-16165-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 17:30:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8365A85F9
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 17:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28FF533A7E42
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AAC360ECA;
	Thu, 21 May 2026 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="e8vsnfea"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AA92EA173
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375825; cv=none; b=leyhumuqQ46wrHK2ClaZN/11W/8oz+uRPydQiCEBeC6YnXQTecGL+J7i62BCfIi4hlC2vJjHGNKqfx774ju0hZhsQHZplIzdClJicncIz2r42bMLcpzniUW6554mnyhPfNRfcneFeFFtGECH6rYL6/f4KYXUQ5YqAUp9xgGFZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375825; c=relaxed/simple;
	bh=8jVwlAtJJZ3oX5gumM1iFSEddhqp6N/ZMyDyq/tRVzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUthuv1z+A37aKNRUUNFp3SK2JHZHeh6poXgOtvTS2FUbrJj0EK+1Ca/vpicU//qmgI7ZOk4ii4uyduspNChWk0ompar4L+8y5Q8mi2o/7He42WOt3P1XaSsFVJyqfzXTn8ckrVMtrQrLrVKNQvPQa/XLwpYceYehb2q6CQzBhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=e8vsnfea; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so3308278a91.2
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779375822; x=1779980622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKSDVbt2wf2LKZOjAtZQ3O/kSTJ20V0dNfrjFrOApYE=;
        b=e8vsnfeagH6RMnz0mfmMwCfl6GpaBr/oT/VIHdwsGhveoXIOTqYWw368JT4IJYK6hg
         0M7Tk/CteGy1pOSNtWHhHS3li4qouJRSLtkTDTDEuPoo7VZSTC0nfEuch1vnnB8EKQEu
         lk5YNAOoWr+3i/LzwSrTNIYp6A4Hg7X4hkX5hJEp0x4SyUZ2R5Zs/YXNHGvq0SoT6Glu
         85CGRNZKI4co0dHM7YRFjFN2ymrS833KoE/W1vkbQxEQ3O7l5Ik2K2hOGR7Zxfpnd3ef
         nX7kPh/A9N4DBJYGdPSFjWKtcHzubXp1kQcFUn1X6VbyCmpRhtW0i6MKEQdJaLoH37Y3
         cerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779375822; x=1779980622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKSDVbt2wf2LKZOjAtZQ3O/kSTJ20V0dNfrjFrOApYE=;
        b=qrvtyZh9ueLGHiG6HRVx2bmsPZcUP2wnzr7sU+K1sxr44hVNPZQBQXAHY2SsAue/ar
         AqDYx1CAxgz83AacYnPwNbw4s1PYbdqfXIDUwjQKKDnJJwKI1BsWdx1k6hXjN0DKJE4r
         64ZNAE5viFvlcTYstrHI8FPtC7gfA2i11h3zUY16XbjBz5G1L2WjUttW7TpejsXm6feB
         vi0TRwdeiOzDHMIBslCPr5IMYR4ZPP06QwDez6SPUgaK9SG3QxyfpvDyRSi7vG52JXaD
         5IP7QXSCTdMAG0ZFLcheeG0gs7XGvLIrRKY1haE4CNiVz/Sw+C3X53DaaXQtOFddtaSJ
         PqDA==
X-Forwarded-Encrypted: i=1; AFNElJ/kMOyhbG06GQfySwFCWqa1G4xqEljjHjhYVsLleEzdmk5Z16CM4om14lwSyOMPBfvWUKoeWOkC@vger.kernel.org
X-Gm-Message-State: AOJu0YzQBP0j9WCK8YWljxsG2jv4Pvgj5cO0MtS8na1ntuiakGhQxY3B
	MA8t05xbZj9nH/UBFrwaSl/EaYi73oHGVNMDOeLSGak0R/sQptEpWyoVO0TDRbknV60=
X-Gm-Gg: Acq92OELn4e95OllECYjNvNAY/So0JcxV+AKIMStio0eqRsPn72DaRyCQhHCwMP8ZOB
	gX4UvmsZhtajkOFdaIqdpeVM7gSAbr+4ndXU8QV/gNNib2jYLmX/ON27Ok21CS3ObmEKQPasqwa
	QbTa2hnvmcyzSTIxawOOFTe6JmikV/r0iAzGHq9E2A3ZVqZviQ168M6hI0rgdfqLWSG9JwXSMAM
	3RFiyKdVVuEYx0jeaj4av4C4VrOOapKScbx6ooEpi/vOAnU1a6jrnoGvQFxcjYXLGgYJxG6yBai
	VjwIZMagha8V+EN4a+gSiAUUa3H22scPqx/7PZJZ6f690TxKabS6zDudmie7Sl2ynCTh+uRX+n+
	QXJs4bZyHjTRf2GJ2aCDRQXsxxc+jqB/wyltbstDEw8+A5XpEERbpUqBbkCntnvkvL8JpXkod6E
	4yCTSgU2+U+8CQa3Ha+vgCm5nNLTou14kc
X-Received: by 2002:a17:90b:1348:b0:366:7dbd:cd50 with SMTP id 98e67ed59e1d1-36a45c6950amr3585113a91.27.1779375822054;
        Thu, 21 May 2026 08:03:42 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914abcbecc4sm107501985a.43.2026.05.21.08.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:03:40 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] mm: switch THP shrinker to list_lru
Date: Thu, 21 May 2026 11:02:06 -0400
Message-ID: <20260521150330.1955924-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16165-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CD8365A85F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is version 4 of switching the THP shrinker to list_lru.

Changes in v4:
- guard folio_memcg_alloc_deferred() with mem_cgroup_disabled() to fix
  NULL deref in __memcg_list_lru_alloc() when booting with
  cgroup_disable=memory (e.g., kdump capture kernel) -- reported and
  tested by Mikhail Zaslonko on s390 and x86
- flatten if (folio) branches in alloc_swap_folio() and alloc_anon_folio()
  in a prep patch so the list_lru allocation additions are a clean minimal
  diff (Lorenzo)
- folio_memcg_alloc_deferred() moved out of alloc_charge_folio() into the
  anon-only collapse_huge_page() path; collapse_file() shares that helper
  but its pages don't go on the THP shrinker queue (David)
- guard folio_memcg_alloc_deferred() with order > 1; mTHPs below order-2
  can't be queued on the deferred split list (David)
- make deferred_split_lru static, hide behind folio_memcg_alloc_deferred()
  wrapper with GFP_KERNEL (Lorenzo)
- rename l -> lru throughout huge_memory.c (Lorenzo)
- kdoc for folio_memcg_list_lru_alloc() (Lorenzo)
- list_lru_lock_irq()/unlock_irq()/add_irq() irq-disabling variants;
  use list_lru_add_irq() in deferred_split_scan() (Lorenzo)
- reorder shrinker_free() before list_lru_destroy() (Lorenzo)

Changes in v3:
- dedicated lockdep_key for irqsafe deferred_split_lru.lock (syzbot)
- conditional list_lru ops in __folio_freeze_and_split_unmapped() (syzbot)
- annotate runs of inscrutable false, NULL, false function arguments (David)
- rename to folio_memcg_list_lru_alloc() (David)

Changes in v2:
- explicit rcu_read_lock() in __folio_freeze_and_split_unmapped() (Usama)
- split out list_lru prep bits (Dave)

The open-coded deferred split queue has issues. It's not NUMA-aware
(when cgroup is enabled), and it's more complicated in the callsites
interacting with it. Switching to list_lru fixes the NUMA problem and
streamlines things. It also simplifies planned shrinker work.

Patches 1-4 are cleanups and small refactors in list_lru code. They're
basically independent, but make the THP shrinker conversion easier.

Patch 5 extends the list_lru API to allow the caller to control the
locking scope. The THP shrinker has private state it needs to keep
synchronized with the LRU state.

Patch 6 extends the list_lru API with a convenience helper to do
list_lru head allocation (memcg_list_lru_alloc) when coming from a
folio. Anon THPs are instantiated in several places, and with the
folio reparenting patches pending, folio_memcg() access is now a more
delicate dance. This avoids having to replicate that dance everywhere.

Patch 7 flattens the folio allocation retry loops in alloc_swap_folio()
and alloc_anon_folio() without functional change, in preparation for
patch 8.

Patch 8 finally switches the deferred_split_queue to list_lru.

Based on mm-unstable.

 include/linux/huge_mm.h    |   7 +-
 include/linux/list_lru.h   |  68 +++++++++
 include/linux/memcontrol.h |   4 -
 include/linux/mmzone.h     |  12 --
 mm/huge_memory.c           | 355 ++++++++++++++-----------------------------
 mm/internal.h              |   2 +-
 mm/khugepaged.c            |   3 +
 mm/list_lru.c              | 220 ++++++++++++++++++---------
 mm/memcontrol.c            |  12 +-
 mm/memory.c                |  52 ++++---
 mm/mm_init.c               |  15 --
 11 files changed, 374 insertions(+), 376 deletions(-)


