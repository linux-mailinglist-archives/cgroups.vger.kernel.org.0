Return-Path: <cgroups+bounces-14654-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMJWE8hwqWmy7gAAu9opvQ
	(envelope-from <cgroups+bounces-14654-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 13:02:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 860322111CE
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 13:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85E393061042
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 11:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A4F39B497;
	Thu,  5 Mar 2026 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s3v1iK8W"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011339A7FD
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711840; cv=none; b=PWNdl7tE5kb+00sLQZrT3Gi/0sWKRLx/H/OXc/2/jCJpTFLxumGTULJKoTGQ7oh6FSlcd+WwqalbPRrXWfxmcY+UKFT0DynYZE+AkVSTFRlG06IJTpZPWVZf23NiKhiUKpUW3KP9/fIMY4bXTQyrFMsR0DdMAQxM20EOOAjVpCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711840; c=relaxed/simple;
	bh=foPF5gf9399mlEYKh0nP2hLyaTs4UeimkKcCKOYDhM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrXJdyQKUdp1ydx7eLoC2xoQRvU/BzhkLE5aOn6CxvLDN14QVz0j9GiMd892L6vGcj+kk3UnrBd0p3bMyn+whxJLBg1B7wX6lNAbW0mztGldknNIR51w7J8To6Lwdj8bMGPWK0230swQl+wb16ku57WqnaJh8mjvWwSJesezgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s3v1iK8W; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772711836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuGdh3NsMuiZscvyzRC4/MBSUBTvm1soytMKG+347XA=;
	b=s3v1iK8W+2/lyiTlyMS3zxFj3WgIlRYhe5H+s0QFT0llX2t+stJ7v/BZUrvc7S0Nhlw+EV
	9IpuZYgKVcG3RvQ0aect08xUayoWd8gLAKDQoOHod9upjfloUsBuJAYVVXJw8cV/URSRVE
	pdfe0Qfpo6AHi0UluFFEJceymQL/VzM=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com,
	akpm@linux-foundation.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	lance.yang@linux.dev,
	bhe@redhat.com,
	usamaarif642@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v6 18/33] mm: zswap: prevent memory cgroup release in zswap_compress()
Date: Thu,  5 Mar 2026 19:52:36 +0800
Message-ID: <340f315050fb8a67caaf01b4836d4f38a41cf1a8.1772711148.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1772711148.git.zhengqi.arch@bytedance.com>
References: <cover.1772711148.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 860322111CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-14654-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,bytedance.com:mid,bytedance.com:email,oracle.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email]
X-Rspamd-Action: no action

From: Qi Zheng <zhengqi.arch@bytedance.com>

In the near future, a folio will no longer pin its corresponding memory
cgroup. To ensure safety, it will only be appropriate to hold the rcu read
lock or acquire a reference to the memory cgroup returned by
folio_memcg(), thereby preventing it from being released.

In the current patch, the rcu read lock is employed to safeguard against
the release of the memory cgroup in zswap_compress().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/zswap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index a399f7a108304..fb525874a1b6b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -893,11 +893,14 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	 * to the active LRU list in the case.
 	 */
 	if (comp_ret || !dlen || dlen >= PAGE_SIZE) {
+		rcu_read_lock();
 		if (!mem_cgroup_zswap_writeback_enabled(
 					folio_memcg(page_folio(page)))) {
+			rcu_read_unlock();
 			comp_ret = comp_ret ? comp_ret : -EINVAL;
 			goto unlock;
 		}
+		rcu_read_unlock();
 		comp_ret = 0;
 		dlen = PAGE_SIZE;
 		dst = kmap_local_page(page);
-- 
2.20.1


