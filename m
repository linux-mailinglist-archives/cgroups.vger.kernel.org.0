Return-Path: <cgroups+bounces-14647-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ/KG4ZvqWnH7AAAu9opvQ
	(envelope-from <cgroups+bounces-14647-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 12:56:54 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7151C210FAC
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 12:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43B483045A2D
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86FA38E13C;
	Thu,  5 Mar 2026 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sp5oK5oF"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655D317146
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711765; cv=none; b=mV/4KmMN4vzneXf5s+OoXc0fb8xYLJD34fkwkEMIbYC9TzyfcN9qijrh7lOUM9m+P7G51DFPug4vonSZRhMTJMdJi3S/Q0WuU3s6ik3PbpQUgoiVHIFkNdqt6imTvdwIwdapb6Y71pkphxhHP7BCr9Xx0Tu9t281Ypy6G2i5gvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711765; c=relaxed/simple;
	bh=5bUKBc4771QU23iCzBAa0sVt8S5IWikOPFOBJLwNYpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTmtt5QPuMfqkbCVZayxgbpGteD2+Ck2mZNgVN8OXGnykRuHpjgHVSmFRViYwwwjbEcl7YmYxsZaMnodPMAcOpYLT1wBD1iHB7VtzJS/riryNWCqzrfmuXZSphQDAUAcsMJeBBAFi2T8gh7uKCGMlFVFkgCr4lAOrXJl9GyUJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sp5oK5oF; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772711762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFugfqe6/ZOVEb7BRYdC4hEvLiQEcyW+5o69Lqfswgk=;
	b=Sp5oK5oFjJ4WgSWliPpVc97gKNr6NqbPwLiwIZw2Z5SdXlWR5qqaGTuz0QH15VeaTPFeTL
	DhNfLnKGRBoCG/NKALOxn+6rpvwZ+0MFsAYZK5mRe2jhWsni/vOgmp0glTUg1xHKOXNwk2
	OXk+yVV6975l6Mvz8Y7qKdWdSI/kOaA=
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
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v6 11/33] mm: memcontrol: prevent memory cgroup release in count_memcg_folio_events()
Date: Thu,  5 Mar 2026 19:52:29 +0800
Message-ID: <dea6aa0389367f7fd6b715c8837a2cf7506bd889.1772711148.git.zhengqi.arch@bytedance.com>
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
X-Rspamd-Queue-Id: 7151C210FAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-14647-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bytedance.com:mid,bytedance.com:email,cmpxchg.org:email,linux.dev:dkim,linux.dev:email]
X-Rspamd-Action: no action

From: Muchun Song <songmuchun@bytedance.com>

In the near future, a folio will no longer pin its corresponding
memory cgroup. To ensure safety, it will only be appropriate to
hold the rcu read lock or acquire a reference to the memory cgroup
returned by folio_memcg(), thereby preventing it from being released.

In the current patch, the rcu read lock is employed to safeguard
against the release of the memory cgroup in count_memcg_folio_events().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 20d38262b984b..0fdfb8044458e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -976,10 +976,15 @@ void count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 static inline void count_memcg_folio_events(struct folio *folio,
 		enum vm_event_item idx, unsigned long nr)
 {
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct mem_cgroup *memcg;
 
-	if (memcg)
-		count_memcg_events(memcg, idx, nr);
+	if (!folio_memcg_charged(folio))
+		return;
+
+	rcu_read_lock();
+	memcg = folio_memcg(folio);
+	count_memcg_events(memcg, idx, nr);
+	rcu_read_unlock();
 }
 
 static inline void count_memcg_events_mm(struct mm_struct *mm,
-- 
2.20.1


