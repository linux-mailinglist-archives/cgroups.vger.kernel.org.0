Return-Path: <cgroups+bounces-17176-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9uj+K+QnOmqm2wcAu9opvQ
	(envelope-from <cgroups+bounces-17176-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 08:29:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1A76B47A4
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 08:29:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=XnAJbpIJ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17176-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17176-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B84333035AA7
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 06:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF953C1419;
	Tue, 23 Jun 2026 06:28:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE333B992F
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 06:28:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196133; cv=none; b=dM+AS2ntTTBAiH+C3ixuvHwfbD0F9s3gwHjiU1ghdsiJwdfDCgdsYU/Np0cYc2DKAYNHlFrTgEDLlUdr8eMl6BGhMtUsHqq/bZ888EdBRp6xRBmGOawK7HF+WiqFKwfZDe5JX6tYXDomNOeqZ1US4lKqUBZ/vuIaAdgxNK8Iv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196133; c=relaxed/simple;
	bh=XPPPV4Ug35Um8J2lPRVVhS5HfHFpfErJBAhjv864suY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+cekraF35103lckAM2G/vZKuaZ/iJt+XxRAnu1d8lkDAM0U/LujUSaiYK1dSgGmWoMt+NALhJj1Ak3+YWqM/jRERAhmPg/HbIhzQDilAu6uDIGNqzpU4LGFKpD19I61ZLXsxWxyGbpqNfuB+Tr8IPSMG/S6qMikjj5McfqlMIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XnAJbpIJ; arc=none smtp.client-ip=95.215.58.171
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782196130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fulPYBKv0+qQhpOwEZvPxrLqZb68dG2SMZzTJMFOD6c=;
	b=XnAJbpIJbAuC34LqLXy68b1Vw4byyaTksocBJcQm1Bbv4HRQfGPY2mEU1QQYDMt7ZD8fi3
	Pq5Pw+E3Ve87u+B4MFfetnx5/3vbwBe1MM06eUaKiGDk5nC6U6/U7nzpv9I0r2ko2DPhpn
	qfMdrvqc0OSKUCeeWpdmA9G0s9zFI0s=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: yingfu.zhou@shopee.com,
	jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] memcg: bail out memory.high when memcg is dying
Date: Tue, 23 Jun 2026 14:27:54 +0800
Message-ID: <20260623062800.298514-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260623062800.298514-1-jiayuan.chen@linux.dev>
References: <20260623062800.298514-1-jiayuan.chen@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-17176-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:yingfu.zhou@shopee.com,m:jiayuan.chen@linux.dev,m:jiayuan.chen@shopee.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:david@kernel.org,m:ljs@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,shopee.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC1A76B47A4

From: Jiayuan Chen <jiayuan.chen@shopee.com>

memory.high reclaims synchronously in the writer's context, and the
latency can be very high - especially when reclaim performs swap I/O, or
under thrashing where the loop may not converge for a long time.

While this runs the kernfs active reference on the file is held, so a
concurrent removal of the same cgroup blocks in kernfs_drain() under
cgroup_mutex until it finishes. Reclaiming a dying cgroup is pointless,
as its pages are reparented to the parent anyway.

Mitigate this by bailing out of the reclaim loop once memcg_is_dying().

Reported-by: Zhou Yingfu <yingfu.zhou@shopee.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 56cd4af08232..2d5cd056a25e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4793,6 +4793,9 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		if (signal_pending(current))
 			break;
 
+		if (memcg_is_dying(memcg))
+			break;
+
 		if (!drained) {
 			drain_all_stock(memcg);
 			drained = true;
-- 
2.43.0


