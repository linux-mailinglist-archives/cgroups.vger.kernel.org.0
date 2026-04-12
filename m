Return-Path: <cgroups+bounces-15230-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFYFBrvr22lZIwkAu9opvQ
	(envelope-from <cgroups+bounces-15230-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:00:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 784163E58DA
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF4F300B05E
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 18:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6237379EE8;
	Sun, 12 Apr 2026 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxfu5tG4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B36CA5A;
	Sun, 12 Apr 2026 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020397; cv=none; b=XBMBOOASaRkM7ZnmW84JRwx6ujEPKRAJ5pcwV4TBDd+mwG8vjEtvOTXvzQBJf/PJfuVAJ1zkxJqOxB22dLzadC9xjlXDAWu2xv47uObOrtJSK8RPXljBQap+dMuU8Lj3IvC8/psQ5L/h3AgDTAZhlwEAs3h4juLO7apMAtD3Yck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020397; c=relaxed/simple;
	bh=c5nX17VEd6pfb8YBjWIDLaDupaE+dxyisObEf1BO9qU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fADszMghgw1pWywUU935VkP2vI8G+XObBYrq19Xo3cm2LLlmNa2e97bf0YEg0S5CWg4ubWS80AGvu2CBXOiPKfp36Fc8TV5f2wS9AnggI9be7/xb0FZdIwaY476u/jLKFMTbR6eu33y1GKx8IpE2xqwI6T0Cs3+DPKWdCCBp4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxfu5tG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BE5C19424;
	Sun, 12 Apr 2026 18:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776020397;
	bh=c5nX17VEd6pfb8YBjWIDLaDupaE+dxyisObEf1BO9qU=;
	h=From:Subject:Date:To:Cc:From;
	b=lxfu5tG4r1oBXYBsWqkORgXMFdEEWDR1s2ofUH+NE9ImdK8k4lw9lqbaSRhOUoQ2Q
	 99CzxakPFcjKWNYyVZcbfwyAiIQe+KcTS5G0jWUfyz7f1XqXd/RoE+LOVV7N1wzZYb
	 bXna0M/w7a7Xc3ZmXjwGtk5UiMyabygE/pFLUWjhkm4Qy+//1yGoLPjNS8TAox4t8a
	 +a2TU2+kx+Mp+kiv+EEPK6Fb8rXXk2Dd+S/w+0YM/gh4WcrXt8NLxIjCxiaoVt6/Qt
	 cc341LiNqvQpTQyqp1QU8uT1SkuxMXtGBb7JTL8bGZTvcn17/Vo6k8FGz32GNT42K6
	 rAoDjru9ItEOg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH RFC 00/13] mm/rmap: support arbitrary folio mappings
Date: Sun, 12 Apr 2026 20:59:31 +0200
Message-Id: <20260412-mapcount-v1-0-05e8dfab52e0@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJPr22kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY2MD3dzEguT80rwSXWMjAzOzZDMLcwNDAyWg8oKi1LTMCrBR0UpBbs5
 KsbW1AN0GLIlfAAAA
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Brendan Jackman <jackmanb@google.com>, 
 Zi Yan <ziy@nvidia.com>, Pedro Falcato <pfalcato@suse.de>, 
 Matthew Wilcox <willy@infradead.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15230-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 784163E58DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series is related to my LSF/MM/BPF topic:

	[LSF/MM/BPF TOPIC] Towards removing CONFIG_PAGE_MAPCOUNT [1]

And does the following things:

(a) Gets rid of CONFIG_PAGE_MAPCOUNT, stopping rmap-related code to no
    longer use page->_mapcount.

(b) Converts the entire mapcount to a "total mapped pages" counter, that
    can trivially be used to calculate the per-page average mapcount in
    a folio.

(c) Cleans up the code heavily,

(d) Teaches RMAP code to support arbitrary folio mappings: For example,
    supporting PMD-mapping of folios that span multiple PMDs.

Initially, I wanted to use a PMD + PUD mapcount, but once I realized that
we can do the same thing much easier with a "total mapped pages" counters,
I tried that. And was surprised how clean it looks.

More details in the last patch.

Functional Changes
------------------

The kernel now always behaves like CONFIG_PAGE_NO_MAPCOUNT currently
does, in particular:

(1) System/node/memcg stats account large folios as fully mapped as soon
    as a single page is mapped, instead of the precise number of pages
    a partially-mapped folio has mapped. For example, this affects
    "AnonPages:", "Mapped:" and "Shmem" in /proc/meminfo.

(2) "mapmax" part of /proc/$PID/numa_maps uses the average page mapcount
    in a folio instead of the effective page mapcount.

(3) Determining the PM_MMAP_EXCLUSIVE flag for /proc/$PID/pagemap is based on
    folio_maybe_mapped_shared() instead of the effective page mapcount.

(4) /proc/kpagecount exposes the average page mapcount in a folio
    instead of the effective page mapcount.

(5) Calculating the Pss for /proc/$PID/smaps and /proc/$PID/smaps_rollup
    uses the average page mapcount in a folio instead of the effective
    page mapcount.

(6) Calculating the Uss for /proc/$PID/smaps and /proc/$PID/smaps_rollup
    uses folio_maybe_mapped_shared() instead of the effective page
    mapcount.

(7) Detecting partially-mapped anonymous folios uses the average
    page-page mapcount. This implies that we cannot detect partial
    mappings of shared anonymous folios in all cases.

TODOs
-----

Partially-mapped folios:

If deemed relevant, we could detect more partially-mapped shared
anonymous folios on the memory reclaim path (e.g., during access-bit
harvesting) and flag them accordingly, so they can get deferred-split.
We might also just let the deferred splitting logic perform more such
scanning of possible candidates.

Mapcount overflows:

It may already be possible to overflow a large folio's mapcount
(+refcount). With this series, it may be possible to overflow
"total mapped pages" on 32bit; and I'd like to avoid making it an
unsigned long long on 32bit.

In a distant future, we may want a 64bit mapcountv value, but for
the time being (no relevant use cases), we should likely reject new
folio mappings if there is the possibility for mapcount +
"total mapped pages" overflows early. I assume doing some basic checks
during fork() + file folio mapping should be good enough (e.g., stop
once it would turn negative).

This series saw only very basic testing on 64bit and no performance
fine-tuning yet.

[1] https://lore.kernel.org/all/fe6afcc3-7539-4650-863b-04d971e89cfb@kernel.org/

---
David Hildenbrand (Arm) (13):
      mm/rmap: remove folio->_nr_pages_mapped
      fs/proc/task_mmu: remove CONFIG_PAGE_MAPCOUNT handling for "mapmax"
      fs/proc/page: remove CONFIG_PAGE_MAPCOUNT handling for kpagecount
      fs/proc/task_mmu: remove CONFIG_PAGE_MAPCOUNT handling for PM_MMAP_EXCLUSIVE
      fs/proc/task_mmu: remove mapcount comment in smaps_account()
      fs/proc/task_mmu: remove CONFIG_PAGE_MAPCOUNT handling in smaps_account()
      mm/rmap: remove CONFIG_PAGE_MAPCOUNT
      mm: re-consolidate folio->_entire_mapcount
      mm: move _large_mapcount to _mapcount in page[1] of a large folio
      mm: re-consolidate folio->_pincount
      mm/rmap: stop using the entire mapcount for hugetlb folios
      mm/rmap: large mapcount interface cleanups
      mm/rmap: support arbitrary folio mappings

 Documentation/admin-guide/cgroup-v1/memory.rst |   6 +-
 Documentation/admin-guide/cgroup-v2.rst        |  13 +-
 Documentation/admin-guide/mm/pagemap.rst       |  30 ++-
 Documentation/filesystems/proc.rst             |  41 ++--
 Documentation/mm/transhuge.rst                 |  29 +--
 fs/proc/internal.h                             |  58 +----
 fs/proc/page.c                                 |  10 +-
 fs/proc/task_mmu.c                             |  69 ++----
 include/linux/mm.h                             |  37 +--
 include/linux/mm_types.h                       |  22 +-
 include/linux/pgtable.h                        |  22 ++
 include/linux/rmap.h                           | 221 ++++++++----------
 mm/Kconfig                                     |  17 --
 mm/debug.c                                     |  10 +-
 mm/internal.h                                  |  30 +--
 mm/memory.c                                    |   3 +-
 mm/page_alloc.c                                |  31 +--
 mm/rmap.c                                      | 302 ++++++++-----------------
 18 files changed, 325 insertions(+), 626 deletions(-)
---
base-commit: 196ab4af58d724f24335fed3da62920c3cea945f
change-id: 20260330-mapcount-32066c687010

Best regards,
-- 
David Hildenbrand (Arm) <david@kernel.org>


