Return-Path: <cgroups+bounces-4301-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AE79528C6
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 07:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960951C21183
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 05:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7CD14533E;
	Thu, 15 Aug 2024 05:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="olL28lu+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF813D276
	for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698344; cv=none; b=QQ6yq9JBWCvjlACtSuW5JkfUNbFcLNNNSa7A/C2CWcBuwuGVgQwznNZgSfakgFdXZWRLChf0cn6wa8wnivA2wIfuRcMXkFngur97eny1eiDdL/11bqdk7kFaRO0zZqW0u/u+x6Hf8+jS928jb3fxmzI1Sa3ZuQxbrVQLWehEIQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698344; c=relaxed/simple;
	bh=i3M5S+rUsE+Do4aEAW0zVPstTu46zezdV6XYFzAKFd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Izsg1w1toybR0iYQgnJmpMesoeN2qBc2nnYLQAtkV3qzbGe+yiP4yifiPyl7dalLBmLaSVkqvVH6OvOU2KfdqcEogaicisWQAudNY1F18z6x99nMRgeCzsgED510NozxpKhkd14qiPx20UbB10q/mTyPd6qUTKOaFEbXRWpb/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=olL28lu+; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723698339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4eAu+FADTIrdS5fQdJHfQzYaBndTq6CMzABmov4I1A8=;
	b=olL28lu+B/zDWmkEuIbo69rLnNvVgmsmXU8CRoAVPnl5y2BaGzfXFuxPoLOVcbY0rq6D7C
	8ngmcAcKiy7BJ07ngoQh7T+Um+zErT+SdESm4nRgRT4kPTIwD8f8Cr0ONEhBBEfoMRXMou
	nC2ywtg16+j82Juz7oq0kph1B4s92u0=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 7/7] memcg: make PGPGIN and PGPGOUT v1 only
Date: Wed, 14 Aug 2024 22:04:53 -0700
Message-ID: <20240815050453.1298138-8-shakeel.butt@linux.dev>
In-Reply-To: <20240815050453.1298138-1-shakeel.butt@linux.dev>
References: <20240815050453.1298138-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently PGPGIN and PGPGOUT are used and exposed in the memcg v1 only
code. So, let's put them under CONFIG_MEMCG_V1.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c4b06f26ccfd..9932074c617a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -411,8 +411,10 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 
 /* Subset of vm_event_item to report for memcg event stats */
 static const unsigned int memcg_vm_event_stat[] = {
+#ifdef CONFIG_MEMCG_V1
 	PGPGIN,
 	PGPGOUT,
+#endif
 	PGSCAN_KSWAPD,
 	PGSCAN_DIRECT,
 	PGSCAN_KHUGEPAGED,
@@ -1461,10 +1463,11 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		       memcg_events(memcg, PGSTEAL_KHUGEPAGED));
 
 	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++) {
+#ifdef CONFIG_MEMCG_V1
 		if (memcg_vm_event_stat[i] == PGPGIN ||
 		    memcg_vm_event_stat[i] == PGPGOUT)
 			continue;
-
+#endif
 		seq_buf_printf(s, "%s %lu\n",
 			       vm_event_name(memcg_vm_event_stat[i]),
 			       memcg_events(memcg, memcg_vm_event_stat[i]));
-- 
2.43.5


