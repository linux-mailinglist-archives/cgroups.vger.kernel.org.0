Return-Path: <cgroups+bounces-17439-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tYvPE3dXRmqqRAsAu9opvQ
	(envelope-from <cgroups+bounces-17439-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 02 Jul 2026 14:20:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 501236F77A4
	for <lists+cgroups@lfdr.de>; Thu, 02 Jul 2026 14:20:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=KkGVTP0g;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17439-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17439-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 587183075B78
	for <lists+cgroups@lfdr.de>; Thu,  2 Jul 2026 12:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26D4480978;
	Thu,  2 Jul 2026 12:05:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D6480350
	for <cgroups@vger.kernel.org>; Thu,  2 Jul 2026 12:05:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993939; cv=none; b=KTlyUCQ0JdcF7EssI9Y3/5WqKN5E45irO3PQzvm6PNUE2t6XqlvpjOmJDPtXZMdd0/Ru6acbLlmm2gEhpxoYQSDNKu1x871c2Y9F5fZJIi8PYKHUxJiJZgeAG2s17vAMQvUP8i10HxXlPF5L0Q/oRLb5ygLf5Swf19T7FYFXNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993939; c=relaxed/simple;
	bh=osAkqdldu0cEtl7b+69rPbUopVqWousL2SHeNgC/ypo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFWB/Hn+tZkG4OFHj1Kr0U/L3bnR9O5vIKsEmayY7h5nzd9YpfVHNd+hB/9KW38mn2fWkndbUPFSA8xf1aIxuKT0ps2Yjlg5rq63SpYaCSC2XS5kzVgOnvW8j/KUWJajg9srp+wEc6Q/Uo9II5ivbocErl0UaVd8cyouvsJ4Rgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KkGVTP0g; arc=none smtp.client-ip=91.218.175.185
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782993934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qV/6Q/zfvU+sGrRgh8IWLF6r3UQhaR3MZc7VaNSCn6c=;
	b=KkGVTP0gI8cfFdAg1a9okozjmFpJrnwgFn0GqlbJKS2fHkzPFT+tSei6g6K1BEmpaB2NBF
	IiX941PxBS9SvWwPRCRKTcaf/BLPiw2TYCg9/kHaxHYGLQHnEQnzIvVyxSlr2/AyVXUdhe
	CT3GxhecyyzOx4dCrqZ9vxxPAnMruq4=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: jiayuan.chen@shopee.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Zhou Yingfu <yingfu.zhou@shopee.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] memcg: bail out proactive reclaim when memcg is dying
Date: Thu,  2 Jul 2026 20:02:29 +0800
Message-ID: <20260702120235.376752-4-jiayuan.chen@linux.dev>
In-Reply-To: <20260702120235.376752-1-jiayuan.chen@linux.dev>
References: <20260702120235.376752-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17439-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:jiayuan.chen@shopee.com,m:jiayuan.chen@linux.dev,m:yingfu.zhou@shopee.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:qi.zheng@linux.dev,m:ljs@kernel.org,m:kasong@tencent.com,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cmpxchg.org:email,vger.kernel.org:from_smtp,shopee.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 501236F77A4

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Proactive reclaim via memory.reclaim can run for a long time - swap I/O
or thrashing again dominating the latency - and delays cgroup removal in
the same way.

Mitigate this by stopping the reclaim once memcg_is_dying().

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Reported-by: Zhou Yingfu <yingfu.zhou@shopee.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 mm/vmscan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 754c5f5d716a..6ae61be2fab8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7912,6 +7912,10 @@ int user_proactive_reclaim(char *buf,
 		if (signal_pending(current))
 			return -EINTR;
 
+		/* cgroup_rmdir() waits for us with cgroup_mutex held. */
+		if (memcg && memcg_is_dying(memcg))
+			return -EAGAIN;
+
 		/*
 		 * This is the final attempt, drain percpu lru caches in the
 		 * hope of introducing more evictable pages.
-- 
2.43.0


