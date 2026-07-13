Return-Path: <cgroups+bounces-17690-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hTjHG+KpVGo2pAMAu9opvQ
	(envelope-from <cgroups+bounces-17690-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 11:03:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 048C4749124
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 11:03:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=e76Rkjzw;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17690-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17690-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5AA9306D565
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A533D6474;
	Mon, 13 Jul 2026 08:58:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B894C3D411A
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 08:58:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933100; cv=none; b=WAOCRAfQWzpDE+/qlCVNApAfr2F3LLEX6A5OWle02ady+C53a0pY8veB/3t1YxLtWlFNbtLy/zrQDw7PQ8gEr3A58UNZ3n3wNlECvpoe3uEOd4Dcl1eu+Uj3bGyGENMbEjFr5iCyvL85NQEenJdYaG5lGKxs3z2JZhQ+cFAFfjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933100; c=relaxed/simple;
	bh=3gUhkjdw9EGmBJFal2pssXqgAo7dUgB30LSEvo7q6aA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHGim9VNqlv1vMcnY4HSVyHL9yddw21/kpE3t52ZnXguwpGSOiO4PO4Oyb7AZR1MGRYxOZjvze2UC1J+AyKa9XFO9QWLay8mrQ5ve1EZDYtf6wALeUGcA2LqpDeRocsozNYjJGPyOtuwAsxK6s26kaAhF6x26Z8Ok885cvDtrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e76Rkjzw; arc=none smtp.client-ip=95.215.58.172
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783933096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o50UWWlVarKMLpI6cAe4MGWsEGszstCJcs3+C8rnhwI=;
	b=e76RkjzwzoMlPIRamqY/vAQmc6OLqBcbFDUzu1geFIulY9WEStbRpJ+q1NFgLlAaW07y+H
	dD/UF31sL341kXXwKzAkD0v5E6zv5jcBKFIdsWXl0lqfmGqbiWhoV44BJj6dF+hp2biUHj
	zxV7fmxNAjCNdPepr6ZkmtNFI1jAMyA=
From: Guopeng Zhang <guopeng.zhang@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH] mm: memcg-v1: fix wrong linux-mm list address in deprecation warnings
Date: Mon, 13 Jul 2026 16:57:56 +0800
Message-ID: <20260713085756.2973549-1-guopeng.zhang@linux.dev>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17690-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 048C4749124

From: Guopeng Zhang <zhangguopeng@kylinos.cn>

The deprecation warnings for memory.oom_control and
memory.pressure_level use linux-mm-@kvack.org instead of the linux-mm
mailing list address. Remove the extra hyphen.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 mm/memcontrol-v1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index e8b6e1560278..178e1466d898 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1182,13 +1182,13 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 		event->unregister_event = mem_cgroup_usage_unregister_event;
 	} else if (!strcmp(name, "memory.oom_control")) {
 		pr_warn_once("oom_control is deprecated and will be removed. "
-			     "Please report your usecase to linux-mm-@kvack.org"
+			     "Please report your usecase to linux-mm@kvack.org"
 			     " if you depend on this functionality.\n");
 		event->register_event = mem_cgroup_oom_register_event;
 		event->unregister_event = mem_cgroup_oom_unregister_event;
 	} else if (!strcmp(name, "memory.pressure_level")) {
 		pr_warn_once("pressure_level is deprecated and will be removed. "
-			     "Please report your usecase to linux-mm-@kvack.org "
+			     "Please report your usecase to linux-mm@kvack.org "
 			     "if you depend on this functionality.\n");
 		event->register_event = vmpressure_register_event;
 		event->unregister_event = vmpressure_unregister_event;
@@ -2340,7 +2340,7 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
 	pr_warn_once("oom_control is deprecated and will be removed. "
-		     "Please report your usecase to linux-mm-@kvack.org if you "
+		     "Please report your usecase to linux-mm@kvack.org if you "
 		     "depend on this functionality.\n");
 
 	/* cannot set to root cgroup and only 0 and 1 are allowed */
-- 
2.43.0


