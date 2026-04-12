Return-Path: <cgroups+bounces-15235-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPO5EHHs22mLIwkAu9opvQ
	(envelope-from <cgroups+bounces-15235-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:03:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D41183E59CD
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70C073040197
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0915437BE8B;
	Sun, 12 Apr 2026 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1Mdcr8m"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA51F36655B;
	Sun, 12 Apr 2026 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020430; cv=none; b=BocsIYfDERXy4YxMQ2zmIHCS1qnl96pQRii9yfj8gSzd+rouzms7kjXM9aWwoRzpoyZbF8PxqkfnvxU1oHkxLIy/G417dxGMzZmebzdrWbiziDx/2R4RKi8vTimm0WXJTnmzAgORchL0LWnudN9GOzrF55YWaUcmt/ppfsaQLQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020430; c=relaxed/simple;
	bh=9fGCFaYmiOtu98w+dglbaRj6ZG+ZWxVZAKKzaNaEbNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SaBEaooE3sLsu2GmZf2H7igbI7/ddgVQCGaK3YWZ7Ugvea3eRAHizH02w/DOEeJLBU61hz+ChqNR5FRiZnO6f36YQ1yQrPIA2fs3PtmDw0lj0fcyy0Jy25MGnZ/jG0gn9kRR9F0CrBWZcF03TAUMq0uBWCan/LvoXHqRoyKPcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1Mdcr8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBE1C19424;
	Sun, 12 Apr 2026 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776020430;
	bh=9fGCFaYmiOtu98w+dglbaRj6ZG+ZWxVZAKKzaNaEbNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g1Mdcr8m9w7rpzRvM0fQIY2TqEIxFWCbJvHebiQ1yaz3iHjfGIzQ6d7f9BVHqVUfh
	 88PYtztAGsZyme1f7JwZDPM2SNqpx+8kHfYLjB+ZFfGuncAH6CfOiVBKIOeXydPqHf
	 IsZp0OXlC1U9E+vZ19Co1+jH3WbFK4JnvE6aamisFIb4yYtuJd+D78abLTosE7BKnf
	 NSdHKqDAQsxzNAVb4+tvJj9cqVSRo0udtgc/IHttEB6zXwS2RAjuCL4xCYxHsXmxn+
	 pDjNju6dFJzV1pqZNO2lRo5vMiF51KiR7R+q5OtLmYKJMyqDeXfvLg0KfI8kCBig5V
	 5uWq75wKahseA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 12 Apr 2026 20:59:36 +0200
Subject: [PATCH RFC 05/13] fs/proc/task_mmu: remove mapcount comment in
 smaps_account()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-mapcount-v1-5-05e8dfab52e0@kernel.org>
References: <20260412-mapcount-v1-0-05e8dfab52e0@kernel.org>
In-Reply-To: <20260412-mapcount-v1-0-05e8dfab52e0@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15235-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D41183E59CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reading the mapcount is a usually a snapshot that can change immediately
afterwards, except when the folio is locked and the folio is unmapped.

For example, nothing stops other folio/page mappings that are not protected
through the same PTL from going away; the folio lock cannot prevent that
situation.

Let's just drop the comment.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/proc/task_mmu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 1e1572849fed..55b037768c60 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -968,11 +968,6 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 		exclusive = !folio_maybe_mapped_shared(folio);
 	}
 
-	/*
-	 * We obtain a snapshot of the mapcount. Without holding the folio lock
-	 * this snapshot can be slightly wrong as we cannot always read the
-	 * mapcount atomically.
-	 */
 	for (i = 0; i < nr; i++, page++) {
 		unsigned long pss = PAGE_SIZE << PSS_SHIFT;
 

-- 
2.43.0


