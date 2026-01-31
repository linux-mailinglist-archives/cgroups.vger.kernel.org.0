Return-Path: <cgroups+bounces-13575-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPQPNedwfmkrZAIAu9opvQ
	(envelope-from <cgroups+bounces-13575-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 22:15:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 228D3C3F78
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 22:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9C3130166F2
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 21:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8653793C9;
	Sat, 31 Jan 2026 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="knqR6QtH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B781337BAC;
	Sat, 31 Jan 2026 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769894113; cv=none; b=OkuilgIhaHcU+0cs4Pz3YYj0806nyUcNd/8xiA5kD3Dg5u9KgEeh4KOF8gOpskCwxvZHKDM/+bmeg9Jf3XSIKgiGtVArnNESRLq+R9Jzi+xsh5m1zyy0PFSvE5NmYJTV+ft8+A9LG40vbYW7p/8hIdK8TbnRd/YCXey72JoLG7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769894113; c=relaxed/simple;
	bh=xcm867JgMbkkY0fTpvZFMhpWopYN8xdNIr1JmHZJZbg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M9Hv48t8K28XedFVDn48oq7BKD8UmDu//a17m+CMeqa9hvF8g2AOXG4bESte5DcUx9ysPni1zlxGbYvsXkevuOeP3MJRCBAHUT2f2rL3RcoDWWJ1p+J33mJWvufxHcbODWrL9CoIgF7Z4C3sKfmTUdWNTQV9s2Bs7BzGu6rF5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=knqR6QtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3110EC4CEF1;
	Sat, 31 Jan 2026 21:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769894112;
	bh=xcm867JgMbkkY0fTpvZFMhpWopYN8xdNIr1JmHZJZbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=knqR6QtHT4eLud0Wuw0mdH9iqbgHVNi81q8RTfLHCFf5u9RGDDeETZ5qghnkZLZuz
	 vW7J9enus/UdbnXbq5HQ/lyoUIxdo+tCHpXOQLySwDlepNYI/jJ3CTx5UzvoOz+MrR
	 uxcrMPQehcRjvpOH9/4s2LKcL1cHL+A+1es+HcEI=
Date: Sat, 31 Jan 2026 13:15:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>,
 Song Liu <songliubraving@fb.com>, Kiryl Shutsemau <kas@kernel.org>, Usama
 Arif <usamaarif642@gmail.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Matthew Wilcox
 <willy@infradead.org>, Meta kernel team <kernel-team@meta.com>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: khugepaged: fix NR_FILE_PAGES and NR_SHMEM in
 collapse_file()
Message-Id: <20260131131511.e5f1ec520fec066b22ca04c1@linux-foundation.org>
In-Reply-To: <20260130042925.2797946-1-shakeel.butt@linux.dev>
References: <20260130042925.2797946-1-shakeel.butt@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13575-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cmpxchg.org,surriel.com,fb.com,kernel.org,gmail.com,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,infradead.org,meta.com,kvack.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 228D3C3F78
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 20:29:25 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> In META's fleet, we observed high-level cgroups showing zero file memcg
> stats while their descendants had non-zero values. Investigation using
> drgn revealed that these parent cgroups actually had negative file stats,
> aggregated from their children.
> 
> This issue became more frequent after deploying thp-always more widely,
> pointing to a correlation with THP file collapsing. The root cause is
> that collapse_file() assumes old folios and the new THP belong to the
> same node and memcg. When this assumption breaks, stats become skewed.
> The bug affects not just memcg stats but also per-numa stats, and not
> just NR_FILE_PAGES but also NR_SHMEM.
> 
> The assumption breaks in scenarios such as:
> 
> 1. Small folios allocated on one node while the THP gets allocated on a
>    different node.
> 
> 2. A package downloader running in one cgroup populates the page cache,
>    while a job in a different cgroup executes the downloaded binary.
> 
> 3. A file shared between processes in different cgroups, where one
>    process faults in the pages and khugepaged (or madvise(COLLAPSE))
>    collapses them on behalf of the other.
> 
> Fix the accounting by explicitly incrementing stats for the new THP and
> decrementing stats for the old folios being replaced.
> 
> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")

As the bug is 10 years old I think I'll queue this for 6.20(?)-rc1 with
cc:stable.  Just to get it a bit more time-under-test before -stable
kernels pick it up.  Sound OK?


