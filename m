Return-Path: <cgroups+bounces-17178-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RkGdNAgoOmrH2wcAu9opvQ
	(envelope-from <cgroups+bounces-17178-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 08:30:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CE46B4802
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 08:30:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Tpo4KkFr;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17178-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17178-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CDF1303C4C7
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 06:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC00A3C1419;
	Tue, 23 Jun 2026 06:29:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E993B9935
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 06:29:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196142; cv=none; b=UZJxxr4hSMAvdk/kV6PwzPb/EhK9ep86EErzWDERBcKP6K4Gp7nwF5VHtwTbW/umAKNEqTvARfnP0KS/bwBShjA/Bom+sXWj8osIQXOsAPilYK+Zh4QSnQo2XbY01WngYI0jV6bOGktPnkaujDN+5cTQq/DfhqQM9wLZm3eeQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196142; c=relaxed/simple;
	bh=wJD1ljWu38ueJIg00md8NCvRyYO93WZjGqVQpRgjFnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhpnwB2NQgtgBs8Btk/qRQsBXxKd0Tly1ypeEVo2wuHjAcbfj+iBCKN9JECZfLsIczdUTit/jh9Pk/ntwIxdlNZ7S9MpKQa/MLei8QQfHZ9d6DChXMYUjo0uXXPin022eYUyZ59jlLJTcX/ED6SPpQtbWdhbodZ6+fyy1C0FYx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tpo4KkFr; arc=none smtp.client-ip=95.215.58.179
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782196139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGm6TUFBAg84hbkJ477thX3itg6T9dCyxPw+enISTeU=;
	b=Tpo4KkFrsFNFm6Ly/8tUzfzu0MJJ6VdUwcPMg6lKY4K3FCcVCQReTaeBUYOMlGuTAKMDDz
	M1+L5k0Xqy6KfAUnecwQHyAUe/pON7OXT1bFKhs2DpLnwhwvez/II0XySwSVinnvIkp90N
	zyQcQYpZQDPwTZ8l/fGTpE3rEOj5lA0=
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
Subject: [PATCH 2/3] memcg: bail out memory.max when memcg is dying
Date: Tue, 23 Jun 2026 14:27:55 +0800
Message-ID: <20260623062800.298514-3-jiayuan.chen@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-17178-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,shopee.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44CE46B4802

From: Jiayuan Chen <jiayuan.chen@shopee.com>

memory.max has the same high-latency reclaim loop as memory.high, and
may additionally invoke the OOM killer on a cgroup that is already going
away, further delaying its removal.

Mitigate this by bailing out of the loop once memcg_is_dying().

Reported-by: Zhou Yingfu <yingfu.zhou@shopee.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d5cd056a25e..06bde6c5318f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4847,6 +4847,9 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
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


