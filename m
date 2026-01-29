Return-Path: <cgroups+bounces-13517-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Go5ODaqe2m8HgIAu9opvQ
	(envelope-from <cgroups+bounces-13517-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 19:43:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E71B3AC2
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 19:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50E29300DF53
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 18:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98BE2F90C5;
	Thu, 29 Jan 2026 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EQTSuFqu"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DE82FBE0F
	for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769712089; cv=none; b=gWMiLvrcmct9MGZTN9z+M/WaTvWjzDWFunZaSy2C+XVbSXjX+s6158+pCUOBGoIzLqxMmGAWP6rHEAfY4hQ/43XmR44oMWPlhJpgRTjKytJYyWrJn3v9EHM+3hmMxtb/MDAvCmAQ3BIUyyJhM8UIySDdWx6oOa5ndaxsCS1Vl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769712089; c=relaxed/simple;
	bh=+ExvWFoTikYc/HLg4vWR4/vq/2/rFal2AzTRP9Izhy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxidJszZOYqBVJytSB7r3x0+7WpuxDOJ/FO8oxCQLB3CrQBEd7OrJE2b0g6+koiqI557qQf3pVjKCN5GOCgl54nMOzrjNmlnNct9bNZoygq9KM6y6/j8a3yRKWWqc1q93t9kAtLNa/AdXIdQwzSGaDubvxo84dJCFu7heg1ewmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EQTSuFqu; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769712084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xlnz6aumZlbTSchYue5J7VboFXhHLrpxFx7kxdM7jFE=;
	b=EQTSuFqu2W3JWsXY4FbUgQCd0SKbNN90pOEAd2Qp3H1CxbG+umwpCdeFrwFn5VozImAsV7
	P2i18zlTAQta3caaUmOBL2jwk+HHw6WVSXKd2mcH3MYqYrvfK+rEW73UDNfzPqey+njdS9
	ZCaq5KgPZNWPDSjkwN/KypqKs8hUWJM=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Rik van Riel <riel@surriel.com>,
	Song Liu <songliubraving@fb.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: khugepaged: fix NR_FILE_PAGES accounting in collapse_file()
Date: Thu, 29 Jan 2026 10:40:54 -0800
Message-ID: <20260129184054.910897-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,surriel.com,fb.com,kernel.org,gmail.com,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,meta.com,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13517-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 40E71B3AC2
X-Rspamd-Action: no action

In META's fleet, we are seeing high level cgroups with zero file memcg
stat but their descendants have non-zero file stat. This should not be
possible. On further inspection by looking at kernel data structures
though drgn, it was revealed that the high level cgroups have negative
file stat which was aggregated from their children.

Another interesting point was that this specific issue start happening
more often as we started deploying thp-always more widely which
indicates some correlation between file memory and THPs and indeed it
was found that file memcg stat accounting is buggy in the collapse code
path from the start.

When collapse_file() replaces small folios with a large THP, it fails to
properly update the NR_FILE_PAGES memcg stat for both the old folios
being freed and the new THP being added. It assumes the old and new
folios belong to the same cgroup. However this assumption breaks in
couple of scenarios:

1. Binary (executable) package downloader running in a different cgroup
   than the actual job executing the downloaded package.

2. File shared and mapped by processes running in different cgroups. One
   process read-in the file and the second process either through
   madvise(COLLAPSE) or khugepaged on behalf of second process
   collapsing the file.

So, the current code has two bugs:

1. For non-shmem files, NR_FILE_PAGES is never incremented for the new
   THP because nr_none is always 0 for non-shmem, and the stat update is
   inside the "if (nr_none)" block.

2. When freeing old folios, NR_FILE_PAGES is never decremented because
   folio->mapping is set to NULL directly without calling
   filemap_unaccount_folio().

These bugs cause incorrect per-memcg accounting when the process
triggering the collapse (MADV_COLLAPSE or khugepaged) belongs to a
different memcg than the process that originally faulted in the pages:

  - Process A (memcg X) reads file, creating 512 small page cache folios
    charged to memcg X (NR_FILE_PAGES += 512 for memcg X)

  - Process B (memcg Y) triggers collapse via MADV_COLLAPSE or khugepaged
    scans B's mm. The new THP is charged to memcg Y.

  - Old folios freed: NR_FILE_PAGES not decremented (bug)
    New THP added: NR_FILE_PAGES not incremented (bug)

  - Later, THP removed from page cache: NR_FILE_PAGES -= 512 for memcg Y

Result: memcg X has +512 inflated pages, memcg Y has -512 (negative!)

Fix this by:
1. Always incrementing NR_FILE_PAGES by HPAGE_PMD_NR for the new THP
2. Decrementing NR_FILE_PAGES for each old folio before clearing its
   mapping pointer

For shmem with holes (nr_none > 0), the net change is still +nr_none
since we decrement (HPAGE_PMD_NR - nr_none) old pages and increment
HPAGE_PMD_NR new pages.

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/khugepaged.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 1d994b6c58c6..1cf8e154e214 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2200,8 +2200,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	else
 		lruvec_stat_mod_folio(new_folio, NR_FILE_THPS, HPAGE_PMD_NR);
 
+	lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, HPAGE_PMD_NR);
 	if (nr_none) {
-		lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, nr_none);
 		/* nr_none is always 0 for non-shmem. */
 		lruvec_stat_mod_folio(new_folio, NR_SHMEM, nr_none);
 	}
@@ -2238,6 +2238,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	 */
 	list_for_each_entry_safe(folio, tmp, &pagelist, lru) {
 		list_del(&folio->lru);
+		lruvec_stat_mod_folio(folio, NR_FILE_PAGES,
+				      -folio_nr_pages(folio));
 		folio->mapping = NULL;
 		folio_clear_active(folio);
 		folio_clear_unevictable(folio);
-- 
2.47.3


