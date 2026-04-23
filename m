Return-Path: <cgroups+bounces-15476-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJgtLjOE6mn80AIAu9opvQ
	(envelope-from <cgroups+bounces-15476-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:42:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6472457560
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37006307C2DA
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 20:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5643D347536;
	Thu, 23 Apr 2026 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmZktplk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B780B34677F
	for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776976500; cv=none; b=lw6Y9RKNanxoX1LZDgavOgnJmS0pc4OkGPIeSdADCQ/R36VlDGIRrRXJ6E52RvaUL6C01mzTanq780xNAGsiO9rqa2YFyCPPXR3l6mv+gG1Mbu+FbvbC6ykTrmJl1ymRgKKQ8WXMi7fcV9Wh1Uy5+/V2xIMAcZeDFEfaW2E5dBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776976500; c=relaxed/simple;
	bh=uWRjBtJOPcmcOipDjZW5A0jtm6KKpRLRzR3YtzGjk2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2SU2k2LbrabTiWeWyYxr5jYfPXK2+MyuTSiv0mLUv0dgr+kdJpNHGDK6qFjbBK++3hMPLD7BI4aC/B4hEVxz1oNUWaPIbg9h4IpvC6M8tbf9B6haBzrjcEjxzZWTixyrtSwS6hVWWiXG01ZGvjwlsuEGVqUtHOMbw4cOsNjm+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmZktplk; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dcdd1b492eso3027615a34.1
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 13:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776976498; x=1777581298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL+yOOTEXjRtHcz4KSAUpDgaXmbkTootS4bc3SQomf4=;
        b=dmZktplkF4al2B7NXOlJlvuV2x0CrQN3HPhb/11HqO3Chkh7a7fFTHEHNUzttZHYkz
         RTOm/DrVojQChNpLPJcyRtz3pR9wOKNoc13nZ5XigkRYdNko6gRdtAexe90JAGh2/YUC
         9qHDKNayvq1nrbL5jIimCb3paQtRe/KNjM+o/GdJUzh41NfS6mQx1Dx3A/xp2aJIJ/Hk
         zIBB2BkVnTaBzNtLXZuZnMp8LLF8v2b7A1DfLcumxShqQ7/NcXYIKms0uWAbJMZcE/7D
         72nc6rGZMcSrrz87CaME3UHxNlW92bjzNzCRaovKWBjALpNf3gyH4gw3j85D3gGWtocD
         G20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776976498; x=1777581298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gL+yOOTEXjRtHcz4KSAUpDgaXmbkTootS4bc3SQomf4=;
        b=Ji72O3mhnNsUr8V7ibKHcQnRWEmueT72aHjzgaAWT6RSLSmgoYPoItlhIQlVk5Lbjo
         MeZ12zTaKGRYZKsOAysKaIkhGjj8PDLKkYCvFYIMhbHuI2yYRnYrDDnR/MDZvMirssy6
         QiKqrxnRpMzoqiCahMr910RapLsmK7q8yYQsx7glYZStEeqTTbAijR9QdV21jteAajEz
         Elfyy8QS1EJiN8idoGui0e0sWJLddXRV7VNam5Uoh45H0lASu5Ys6NS3p2bpWOmyKaNH
         c85jUBRx7MDOmTXBoZvQfHoymNjXMS4R35dnzr3E2wAERAEaRZDwGzi9TfXEGa8oz4yP
         WxlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+HczzsCysBBb4SmUhMQXnsPuuyUpqVJZ0EGx39K5HfZn8AsUTkaCLnyXw1csi/c08f0cvSALp+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxet0Z8+dbuOH+jl4Zi4GGUr1pDLWPzfbyKY1xmq2WTXXbF7E2g
	SfaMNtINGiQF5KoHvZT67S6bzcns1Cti8PAbISJcKL+DlYQMkNQbUU87
X-Gm-Gg: AeBDieutDPAyGOZR+PMGGGmYIJ3nRt+PWaMnI7Ypti0eG3fD+jKggt9Krj+xCmISHdD
	coFpme4J4RdLnzmfcZRM5cxiMfuSnB1bVysjUb18VHTscgXOQBQhkIP5u4OqfxWNxNhaSmOFzkw
	Mc4lR5AXVbpWwWRZOv+n37XIabpbEl8nObivHWebrN+T0WWdG4AevKEHtwQCf2EWYIl/hIyAnxk
	IUemAo0ssu43494Kiw6RDkdTb2NYiyB0VIj39AFNBORiqEbVBMzk9jjUxhXG4aaiY/FhizzWFHN
	mu6emq0fQOXtHIXSOI8r5oQw5N/28CK3PXcEVvxMprTnIYl9TEWmK2fP9SdWzReACoiduqB18gm
	dyjJShv09SwcEOOGtuFXHHoAQAI5bhV6drtk3sTEq+6IuE6F486j/+8OVBc7iQ+V6/hafTEQb86
	LxalbHLIbAqjZ9CgfYg8e6qu+VbbxMbfM=
X-Received: by 2002:a05:6830:82e3:b0:7dc:d7e5:8d43 with SMTP id 46e09a7af769-7dcd7e5a2e6mr8038210a34.2.1776976497705;
        Thu, 23 Apr 2026 13:34:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc953e39asm10485258a34.15.2026.04.23.13.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:34:57 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 7/9 v2] mm/memcontrol: Make memory.low and memory.min tier-aware
Date: Thu, 23 Apr 2026 13:34:41 -0700
Message-ID: <20260423203445.2914963-8-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423203445.2914963-1-joshua.hahnjy@gmail.com>
References: <20260423203445.2914963-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15476-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6472457560
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On machines serving multiple workloads whose memory is isolated via
the memory cgroup controller, it is currently impossible to enforce a
fair distribution of toptier memory among the workloads, as the only
enforceable limits have to do with total memory footprint, but not where
that memory resides.

This makes ensuring a consistent and baseline performance difficult, as
each workload's performance is heavily impacted by workload-external
factors such as which other workloads are co-located in the same host,
and the order at which different workloads are started.

Extend the existing memory.{low, min} protection to be tier-aware in
order to enforce proportional best-effort and guaranteed memory
protection of toptier memory.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/memcontrol.h | 8 ++++++++
 mm/memcontrol.c            | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6bcb866440075..2222b390ebf10 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -624,6 +624,10 @@ static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
 	if (mem_cgroup_unprotected(target, memcg))
 		return false;
 
+	if (mem_cgroup_tiered_limits() && READ_ONCE(memcg->toptier.elow) >=
+					  page_counter_read(&memcg->toptier))
+		return true;
+
 	return READ_ONCE(memcg->memory.elow) >=
 		page_counter_read(&memcg->memory);
 }
@@ -634,6 +638,10 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 	if (mem_cgroup_unprotected(target, memcg))
 		return false;
 
+	if (mem_cgroup_tiered_limits() && READ_ONCE(memcg->toptier.emin) >=
+					  page_counter_read(&memcg->toptier))
+		return true;
+
 	return READ_ONCE(memcg->memory.emin) >=
 		page_counter_read(&memcg->memory);
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3fb1ee1d18603..b115ff40e268d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4933,6 +4933,9 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 		root = root_mem_cgroup;
 
 	page_counter_calculate_protection(&root->memory, &memcg->memory, recursive_protection);
+	if (mem_cgroup_tiered_limits())
+		page_counter_calculate_protection(&root->toptier,
+				&memcg->toptier, recursive_protection);
 }
 
 static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
-- 
2.52.0


