Return-Path: <cgroups+bounces-214-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA88C7E47CE
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 19:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B74EB20CBF
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 18:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA553588F;
	Tue,  7 Nov 2023 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h/HPTYxf"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D3817F0
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 18:05:41 +0000 (UTC)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC1AB0
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 10:05:40 -0800 (PST)
Date: Tue, 7 Nov 2023 10:05:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699380338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gg2dDs2iW2RW+Tsbluyj1ewN4uduradP7BMNhxCG0vc=;
	b=h/HPTYxfRVbNaQUBJ8Oqd2I588Wuu83I1NrTDOLrqcIXxtKP5QP4vUUOH3yf6mu5zJeTxF
	nGFavNOx5+A47qwrHgrAYJSBoP4hPWB5mTH142AJvLBkNV2yjiAAfniIf5OzSDMVJE4yWR
	9rnoSuFUpGkrUMTRaCYeexKjfwgeZ1I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Christoph Lameter <cl@linux.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: cgroups: warning for metadata allocation with GFP_NOFAIL (was
 Re: folio_alloc_buffers() doing allocations > order 1 with GFP_NOFAIL)
Message-ID: <ZUp8ZFGxwmCx4ZFr@P9FQF9L96D.corp.robot.car>
References: <6b42243e-f197-600a-5d22-56bd728a5ad8@gentwo.org>
 <ZUIHk+PzpOLIKJZN@casper.infradead.org>
 <8f6d3d89-3632-01a8-80b8-6a788a4ba7a8@linux.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f6d3d89-3632-01a8-80b8-6a788a4ba7a8@linux.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 06, 2023 at 06:57:05PM -0800, Christoph Lameter wrote:
> Right.. Well lets add the cgoup folks to this.

Hello!

I think it's the best thing we can do now. Thoughts?

From 5ed3e88f4f052b6ce8dbec0545dfc80eb7534a1a Mon Sep 17 00:00:00 2001
From: Roman Gushchin <roman.gushchin@linux.dev>
Date: Tue, 7 Nov 2023 09:18:02 -0800
Subject: [PATCH] mm: kmem: drop __GFP_NOFAIL when allocating objcg vectors

Objcg vectors attached to slab pages to store slab object ownership
information are allocated using gfp flags for the original slab
allocation. Depending on slab page order and the size of slab objects,
objcg vector can take several pages.

If the original allocation was done with the __GFP_NOFAIL flag, it
triggered a warning in the page allocation code. Indeed, order > 1
pages should not been allocated with the __GFP_NOFAIL flag.

Fix this by simple dropping the __GFP_NOFAIL flag when allocating
the objcg vector. It effectively allows to skip the accounting of a
single slab object under a heavy memory pressure.

An alternative would be to implement the mechanism to fallback to
order-0 allocations for accounting metadata, which is also not perfect
because it will increase performance penalty and memory footprint
of the kernel memory accounting under memory pressure.

Reported-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 774bd6e21e27..1c1061df9cd1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2936,7 +2936,8 @@ void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
  * Moreover, it should not come from DMA buffer and is not readily
  * reclaimable. So those GFP bits should be masked off.
  */
-#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
+#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | \
+				 __GFP_ACCOUNT | __GFP_NOFAIL)
 
 /*
  * mod_objcg_mlstate() may be called with irq enabled, so
-- 
2.42.0


