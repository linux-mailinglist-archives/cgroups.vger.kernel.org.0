Return-Path: <cgroups+bounces-14713-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPWaMeSvrmkSHwIAu9opvQ
	(envelope-from <cgroups+bounces-14713-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Mar 2026 12:32:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAF6237F71
	for <lists+cgroups@lfdr.de>; Mon, 09 Mar 2026 12:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B881308302A
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2026 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA3337757E;
	Mon,  9 Mar 2026 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="teo9Eycf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5439903B
	for <cgroups@vger.kernel.org>; Mon,  9 Mar 2026 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055818; cv=none; b=LquFXaCn6YRAX6/jJBtZuUJ+iQVkvO6GexinU5JNELgtGu+uWSb2tGRxJtCpWdQWT5WW+WaMXqeLcQ/H8LoAyXpT0RsRwr6HGPlZR52yhBsA+KrndqCtXAS2KO6ge9z1OTLTfNTT60ketsD9qWlKsUTundH654AoJuUsxOWIdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055818; c=relaxed/simple;
	bh=kVbrYMP5pt1BQk2q3WW9YiMA91YhgZOOKnk1hZLVEjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qucxrMxYpcXr5C02xF+a2Rfv/ZA94yjBlFmo4e94MIzyocUAr337ADDwBVPn295wXCKCqf4ZANVEKFUoQ1DeGnokzLiXLhuumRnLeKO1fJj3hNTyBPiPuGH2dG/kMBD40he8Xz7LKuu0Jt1nIYz4Xsxt5pN+eLIpy9rp0kw6zoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=teo9Eycf; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773055803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BCaKEuNZgtMKShDR3GzW8YFYwaQK2TRr8wn9CI/U184=;
	b=teo9EycfvI/jhpEj3RqyVtnm67r8unNsx/x/W6sU0U+5DxrYxlRVWVXcfdIK5UpqvEzqSR
	rsU+bf0CAqnjsmuJYC6HA23y9MmFckwX6Une3zy2xCKal49LYSTFKvhweFYx6T9us3UrM8
	mL6NmLE9it1YnGI94fPEW+KU/OcDIRI=
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
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH] fix: mm: memcontrol: convert objcg to be per-memcg per-node type
Date: Mon,  9 Mar 2026 19:29:39 +0800
Message-ID: <20260309112939.31937-1-qi.zheng@linux.dev>
In-Reply-To: <56c04b1c5d54f75ccdc12896df6c1ca35403ecc3.1772711148.git.zhengqi.arch@bytedance.com>
References: <56c04b1c5d54f75ccdc12896df6c1ca35403ecc3.1772711148.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 2DAF6237F71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14713-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.975];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

From: Qi Zheng <zhengqi.arch@bytedance.com>

Reset pn->orig_objcg to NULL to prevent obj_cgroup_put()
from being called agagin in __mem_cgroup_free().

Reported-by: Usama Arif <usama.arif@linux.dev>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memcontrol.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 992a3f5caa62b..ad32639ea5959 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4140,8 +4140,14 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	for_each_node(nid) {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
 
-		if (pn && pn->orig_objcg)
+		if (pn && pn->orig_objcg) {
 			obj_cgroup_put(pn->orig_objcg);
+			/*
+			 * Reset pn->orig_objcg to NULL to prevent obj_cgroup_put()
+			 * from being called agagin in __mem_cgroup_free().
+			 */
+			pn->orig_objcg = NULL;
+		}
 	}
 	free_shrinker_info(memcg);
 offline_kmem:
-- 
2.20.1


