Return-Path: <cgroups+bounces-16422-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGFEMTKFGWouxQgAu9opvQ
	(envelope-from <cgroups+bounces-16422-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:23:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DBD60232E
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A15730E0274
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 12:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E509D3CF680;
	Fri, 29 May 2026 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NMBX8Oi3"
X-Original-To: cgroups@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138663B7752;
	Fri, 29 May 2026 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057045; cv=none; b=mimYtVXMIfhVsPLI5akrlz4wInyVW1U96XyZaGVEIxuXVXX98vlKqaNNrkZ61vKNDnkfXzgiHc+NR7bhDzH4j/UBkMtLmAbTMEiebEaiOUZM0QecA+f4c/3Yk+jwPT5LbOCGBoyAgvEBbA0qgi7dXGB6h0H47AvcfkqApYeH0Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057045; c=relaxed/simple;
	bh=2XWDmCnV6kk2MxS+wV0lu+dIwW/HUCmBzAnDFnqFJtU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=J4OBkW7kp56l9PgjRLJUN6DbQpMp5aSU4yahSe/lPTwkEgPTbtR5RfqRur137SdYlTEn6/vIb8M3JzkoHUjDcx9P/wEdv2UGQBW33tEWYzhyJJwdtJm+8TwEvwiEApauABYcxo4slHeyiiIPMiPOpddTp77WOLA5ZMIE8hQoYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NMBX8Oi3; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780057035; bh=TQCHoLM8U9tVWW8Tlb6iZC9KTC9D3mCOEdsmVLWTGcw=;
	h=From:To:Cc:Subject:Date;
	b=NMBX8Oi3wMP6rjH9u5yCkMnZGXv78tr8Nr50YxHfOxCOpG2HLLwbcw4gIH01HTM0Z
	 UY+/UVXkADUUDKkzl4VvyOOLqginszbMI2YJGT9fgRyGQx5QX1+fqvVemIT8TXQBqP
	 pOuPEeg3nnBkPP8+VAqpkt6Zj/0cQor2MdEw/wPY=
Received: from node68.. ([166.111.236.25])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 44BA509C; Fri, 29 May 2026 20:17:11 +0800
X-QQ-mid: xmsmtpt1780057031tq300lfll
Message-ID: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com>
X-QQ-XMAILINFO: OQjltBcbYeaf7saNfZdyqVYHXLfijFEy2Z1ODhLjxXdYxC/JMHKeXYPoVKbp8U
	 CXLQpDbP7o0LHmXvJhqqFX+/N4x41MK6x01aUN+zl5oFlnj3J+b77bo/vvsrrOahfTsy2dCxf2gO
	 laSsrjw5h4ZSm00Mkmm5XBnZzbMm8SiBmCeHMtFQBivV6eZGXb1udBHUWQYma5wFiZtC/9ISPJOV
	 j1VMDx81sEIL24ab22nhfb9IMzeRUPTcfO7aBds8ow78L8rAoJgYgnEM2OlEVIuxqfWq8AYCYKUz
	 90VFgm9R6uRu2LlnZ1U918YpRN2F7P/0fSVrl/3ua6ky1GfyRsK6QuxoDYOO12PnthiAFgFTQMLD
	 xIUSzSPdbcEdsJfEsosYgGgVlVwG9toA/M4oCl3xJ632vVs8zM/UtUgvmAWCqydZDUwShHFIS7hB
	 BpG5fu1rk1WVE7SIRfF205AD0Klm4m4ZDAfamaLVnsR7vefRtglgV4Lms38U8HEKULdMD/bu8gBN
	 mz7FrtYpPCUDT46p9IsOL8UGLnBV7CSYKhqgMo/F3TZDlxP7urWIdA6yrT5YhLEIIHBvsKmxaHNe
	 1HTWh4jgDgbuFYtRQ4JloycgO2ErRjlCDAEiR57uAx2mZcjpU7ZegmbUD29+fbjKVuOYydpCc64t
	 5RnEgKfkYW0kzbVWQETfEc/QwiTW5IIwg1JWafIMRyxpSkKtyS8a9kmH90NQDzRH2p3SiqC7I+Wq
	 0BRbOsmiljCxcFGwNmFdwfqgYXUkFweZTCexJML3VuyQ4AChUnTeFqssKpMvu6GS8diRySk/kNP3
	 TztSmaV3tx1yp+/6vfRseTkm3uyL6TDvc+LCiNTbXz2aAc2JogGTHs/VMSjZtmZ9b8EoT3Va01A7
	 fVbdxbk9MQmVrRWh3aBPsywRDfYvRMS4AatZ9Z5Dw0GO+A/d/cW9gSVIZiyog43I08DbzEAqsCbK
	 RBP1qHtU6b1/3jPg3lxgsbVzRLCQ200zVljfH8ALFEyIVgNFSngQ422sC1rsN3rHzH6+NflDo99I
	 dOxP+KYmIx6w6kPVaS++pvqCXUmFIddSKE9VmmPKvmCAc2v/pHDngVJ5N50iM=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: fujunjie <fujunjie1@qq.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@meta.com>,
	Kairui Song <kasong@tencent.com>,
	Usama Arif <usamaarif642@gmail.com>
Cc: Chris Li <chrisl@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v2 0/9] mm: support zswap-backed large folio swapin
Date: Fri, 29 May 2026 12:17:11 +0000
X-OQ-MSGID: <20260529121711.4114537-1-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16422-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[linux-foundation.org,kvack.org,meta.com,tencent.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,gmail.com,google.com,linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fujunjie1@qq.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,qq.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 27DBD60232E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This RFC explores large-folio swapin for ranges that are still fully backed
by zswap.

Large swapin is currently disabled once zswap is in the picture. Anonymous
faults stop considering large orders after zswap has ever been enabled,
shmem does the same, and zswap_load() refuses large swapcache folios. That
keeps mixed zswap/disk cases safe, but it also loses the dense case where
every slot in an aligned 64K range is still resident in zswap.

The series keeps the policy in common swapin code:

  - zswap reports backend facts and provides the large-folio load helper.
  - swapin_sync() filters candidate orders by backend range.
  - all-disk and zeromap ranges keep the existing Kairui large-swapin path.
  - mixed zswap/disk ranges stay order-0.
  - all-zswap ranges may use a 64K folio after locality admission.
  - anon provides locality evidence from VMA hints and PTE young density.
  - shmem starts with explicit VMA-hint evidence only.
  - swap readahead uses its existing VMA/cluster window as locality
    evidence; it does not also run the anon PTE-young rule.

The backend range probe is only a snapshot. If the backend changes after a
fresh large swapcache folio is allocated, the common path drops that folio
and falls back to order-0. zswap_load() can also return -EAGAIN for the
same retry path. If a late fault retry keeps the large folio in swapcache
instead of deleting it, the cgroup v1 memsw swap owner is committed before
returning.

This is mTHP/large-folio swapin. The mappings installed by do_swap_page()
are still PTE mappings, not PMD mappings. The expected win is fewer faults,
batched PTE/rmap work, and preserving the large folio across zswapin
instead of rebuilding the working set as order-0 pages.

Prior art: Usama Arif posted a related RFC on 2024-10-18:

  mm: zswap: add support for zswapin of large folios
  https://lore.kernel.org/linux-mm/20241018105026.2521366-1-usamaarif642@gmail.com/

This RFC keeps the same broad goal, but moves admission into common swapin
code. zswap does not decide the policy. Mixed zswap/disk ranges are
rejected before large IO, and the first cap is 64K.

This is a rewrite of the RFC posted on 2026-05-08:

  [RFC PATCH 0/5] mm: support zswap-backed anonymous large folio swapin
  https://lore.kernel.org/linux-mm/tencent_8B437BE4F586C162950BF71954316C1EDB05@qq.com/

The v1 series was anonymous-only and kept too much of the policy near the
anon fault and zswap paths. This version is rebuilt on top of Kairui Song's
common swapin infrastructure. It keeps admission in common swapin code,
rejects mixed zswap/disk large ranges, and adds separate locality producers
for anon, shmem and swap readahead.

Performance and behavior
========================

The A/B tables are 10-run measurements. Elapsed values are seconds,
shown as mean +/- sample standard deviation. "phase" or "refault" is the
measured refault subphase. "zswpin" counts zswap loads. "pswpin" counts
swap-ins from the real swap device; pswpin=0 means the refaults were served
by zswap even when a disk swap device was configured. "RFC 64K" is the mean
number of successful 64K swapins.

The numbers below show where the large path is used and where it is
rejected.

zram-backed zswap microbench, 64K mTHP, 8G guest:

+-----------------+----------------+----------------+--------+--------+--------+----------+
| workload        | base elapsed   | RFC elapsed    | delta  | phase  | zswpin | RFC 64K  |
+-----------------+----------------+----------------+--------+--------+--------+----------+
| usama_1g        | 11.260+/-0.235 | 10.301+/-0.140 | -8.5%  | -22.2% | 1.000x | 16381.1  |
| nohint_seq64    |  4.398+/-0.085 |  4.025+/-0.022 | -8.5%  | -21.1% | 1.000x |  6221.1  |
| seqhint_seq64   |  4.283+/-0.060 |  3.948+/-0.062 | -7.8%  | -20.6% | 1.000x |  6223.5  |
| stride64_sparse |  3.095+/-0.051 |  3.086+/-0.025 | -0.3%  |  +5.8% | 1.002x |     1.0  |
| random64_sparse |  3.095+/-0.046 |  3.076+/-0.016 | -0.6%  |  +0.7% | 1.001x |     0.0  |
| random64_full   |  4.423+/-0.067 |  4.405+/-0.018 | -0.4%  |  +0.1% | 1.000x |     0.0  |
+-----------------+----------------+----------------+--------+--------+--------+----------+

The usama_1g row follows the shape of the 2024 RFC benchmark: allocate 1G,
fill it with compressible per-page data, reclaim it through memory.reclaim,
then time the full integrity-check refault. The seq64 rows use a 512M
target and 768M of pressure. "sparse" touches one 4K page per 64K region, while
"full" touches every 4K page. "seqhint" uses MADV_SEQUENTIAL; "nohint" does
not.

Virtio-block swap device present, zswap enabled:

+-----------------+---------------+---------------+--------+---------+--------+--------+---------+
| workload        | base elapsed  | RFC elapsed   | delta  | refault | pswpin | zswpin | RFC 64K |
+-----------------+---------------+---------------+--------+---------+--------+--------+---------+
| seq64           | 4.399+/-0.100 | 4.279+/-0.216 | -2.7%  | -10.5%  | 0      | 1.000x | 3110.7  |
| stride64_sparse | 3.103+/-0.047 | 3.119+/-0.086 | +0.5%  |  +6.2%  | 0      | 0.999x |    0.0  |
| random64_sparse | 3.142+/-0.112 | 3.097+/-0.030 | -1.4%  |  -2.2%  | 0      | 0.999x |    0.1  |
| random64_full   | 4.473+/-0.147 | 4.445+/-0.088 | -0.6%  |  +0.9%  | 0      | 1.000x |    0.4  |
+-----------------+---------------+---------------+--------+---------+--------+--------+---------+

This run uses a real block swap device, but the refaulted data stayed in
zswap. It covers the all-zswap hit path with disk swap configured, not disk
read IO.

Virtio-block pressure/mixed run, zswap max_pool_percent=1,
low-compressibility full fill:

+-------------------------------+---------------+---------------+--------+---------+----------------+------------+---------+----------+
| workload                      | base elapsed  | RFC elapsed   | delta  | refault | pswpin base/RFC | RFC zswpin | RFC 64K | fallback |
+-------------------------------+---------------+---------------+--------+---------+----------------+------------+---------+----------+
| seq64_full_pressure           | 5.908+/-0.195 | 5.790+/-0.235 | -2.0%  |  +3.0%  | 90258/99038    | 20327      |   0.0   | 3730     |
| random64_sparse_full_pressure | 5.104+/-0.069 | 5.068+/-0.090 | -0.7%  |  -9.1%  |  6201/6196     |  1297      |   0.0   |    0     |
+-------------------------------+---------------+---------------+--------+---------+----------------+------------+---------+----------+

This run reaches the disk-backed path: pswpin is non-zero in both base and
RFC. It is mainly fallback coverage. The RFC does not install 64K folios
for these disk/mixed-heavy ranges.

Policy matrix, virtio-block swap device present:

+------------------------------+----+------+--------+--------+-------+----------+
| case                         | pc | hint | pswpin | zswpin | zswpwb| 64K in   |
+------------------------------+----+------+--------+--------+-------+----------+
| pc0_seq                      | 0  | none | 0      | 99559  | 0     | 0        |
| pc3_seq                      | 3  | none | 0      | 99498  | 0     | 0        |
| pc4_seq                      | 4  | none | 0      | 99512  | 0     | 3109     |
| pc5_seq                      | 5  | none | 0      | 99657  | 0     | 3113     |
| hint_none_random_sparse      | 5  | none | 0      |  6265  | 0     | 0        |
| hint_random_seq              | 5  | rand | 0      | 99488  | 0     | 0        |
| mixed_seq_full               | 5  | none | 97725  | 20147  | 84    | 569      |
| mixed_random_sparse_full     | 5  | none |  6230  |  1302  | 0     | 0        |
+------------------------------+----+------+--------+--------+-------+----------+

The pc rows show the readahead-window gate. The hint_random_seq row shows
the explicit random hint veto. The mixed rows use a small zswap pool to
force disk/zswap split backing; most mixed ranges are rejected, while any
remaining 64K successes were all-zswap at the time of the fault.

Kbuild pressure, zram swap, 384M memcg:

+----------------------+----------+----------+--------+--------+----------+
| setup                | base     | RFC      | delta  | zswpin | RFC 64K  |
+----------------------+----------+----------+--------+--------+----------+
| zram swap, 384M memcg| 2060.323 | 2047.516 | -0.6%  | 0.991x | 2797     |
+----------------------+----------+----------+--------+--------+----------+

This is a single-run zram pressure smoke. It did not show Kbuild
regression, and the RFC run installed 64K zswap-backed folios. The result
should not be read as a tuned-performance claim.

Kbuild pressure, virtio-block swap device, 512M memcg:

+-------------------------+----------+----------+--------+--------+----------+
| setup                   | base     | RFC      | delta  | pswpin | RFC 64K  |
+-------------------------+----------+----------+--------+--------+----------+
| disk swap, 512M memcg   | 1420.671 | 1409.263 | -0.8%  | 0      | 7497     |
+-------------------------+----------+----------+--------+--------+----------+

This is a single-run pressure smoke. The disk-swap Kbuild run also stayed
on the all-zswap hit path, so it is pressure coverage with a disk swap device
present rather than proof of disk-read large swapin.

Shmem smoke, tmpfs huge=always, 64K shmem mTHP:

+----------------------------+---------------+---------+-------------+----------+
| case                       | refault hint  | touched | 64K shmem   | 64K in   |
+----------------------------+---------------+---------+-------------+----------+
| nohint_seq                 | none          | 65536   | 4096        | 0        |
| seq_refault_hint           | sequential    | 65536   | 4096        | 4096     |
| random_refault_hint_sparse | random        |  4096   | 4096        | 0        |
+----------------------------+---------------+---------+-------------+----------+

That matches the current shmem producer: explicit sequential refault hints
allow large zswap swapin; no hint and random hints do not.

What this RFC does not establish
================================

The 64K cap is deliberate, but it is not tuned. The anon PTE-young rule is
only anon evidence. Shmem has the framework and explicit VMA hints in this
RFC, not a page-cache locality producer. For larger orders, the anon
producer should probably use bounded sampling instead of walking every PTE
in a 1M or larger candidate range. The mixed-backend tests cover fallback
behavior, but this series does not add mixed zswap/disk large IO.

Changes since RFC v1:

  - rebuilt the series on Kairui Song's common swapin/swap-table work;
  - moved large-swapin admission into common swapin code;
  - made zswap provide range facts and fully-zswap-backed folio loads;
  - rejected mixed zswap/disk large ranges before large IO;
  - capped zswap-backed swapin at 64K for this RFC;
  - added locality producers for anon, shmem hints and swap readahead;
  - covered cgroup v1 memsw accounting in speculative large-swapcache
    fallback paths;
  - added 10-run microbench data, mixed-backend pressure tests, shmem
    smoke tests, and zram/disk Kbuild pressure data.

fujunjie (9):
  mm/zswap: expose range state for swapin policy
  mm: let swap_read_folio() report retryable zswap races
  mm/zswap: support fully zswap-backed large folio loads
  mm: admit large swapin by backend range in swapin_sync()
  mm: add common locality admission for zswap large swapin
  mm: provide anon locality evidence for zswap large swapin
  mm/shmem: provide VMA-hint locality for zswap large swapin
  mm: try all-zswap large swapin within swap readahead windows
  docs: mm: update THP swapin counter descriptions

 Documentation/admin-guide/mm/transhuge.rst |  11 +-
 include/linux/zswap.h                      |  26 +
 mm/memcontrol-v1.c                         |   8 +-
 mm/memory.c                                | 269 +++++++-
 mm/page_io.c                               |  19 +-
 mm/shmem.c                                 |  42 +-
 mm/swap.h                                  |  21 +-
 mm/swap_state.c                            | 681 +++++++++++++++++++--
 mm/swapfile.c                              |   2 +-
 mm/zswap.c                                 | 149 ++++-
 10 files changed, 1099 insertions(+), 129 deletions(-)


base-commit: 404fb4f38e8f38469dfff4df0205c9d18eeb1f57
-- 
2.34.1


