Return-Path: <cgroups+bounces-15218-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPdjNhZo2Wn5pQgAu9opvQ
	(envelope-from <cgroups+bounces-15218-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:13:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9113DCC69
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BC63309DC05
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 21:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF7F37CD56;
	Fri, 10 Apr 2026 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTZbeYOG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A775B3A874F
	for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855286; cv=none; b=CWAhQNMYjTSpxR1gBDxfDbrbysVdFZM0EnakizMPlrole5bnB4SLgV6fS1a32mr2p/aiDIuhQcVtULN3VewuYeqB9TOhGsut6uAx4QzFLpqmnyOkyan+a+zmRNGVTVqiyX0kT9r7unb1AAy4O0Nb3FnPRP8++AH47TxTQy/8Pds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855286; c=relaxed/simple;
	bh=vs3QDWwNH10RCc4zFoNuAaKqRY15PIf14IbBQYxdpfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLdi77L2GdMnQR2ef6p08paHLcy+2HUVNSShUjb/sRioq9Zh4BzI1QUVnHGRE3EGlntufVf+c8zzNCSKxKy7CmzdERCkO86gtM8KX9IVqF7GKuffPBY+lCl6jssr7XllRG/YTu4klxeKObPon0631wuXxME0gU3r2SW/mJndzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTZbeYOG; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-66ee7b9af94so913533eaf.0
        for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 14:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775855275; x=1776460075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Txux4TW6NI8BBnT/9aUbbKCnnuVuxmAnvDFuD00fzoQ=;
        b=mTZbeYOGCChtZIIs1yEcCtGqFy+EY7EWywHT8BaoQExmqin9TMWN6v2N2aeY8Di96k
         9QG+H5OUsp5vFuL6/ez4SKFEpsFcKGXKqfBIX60JbgMG9QwcR6OF4KyqYgATcBSYX1fE
         HrTkm1npcTkGZ3eO6oWMGmKw5qXaiGZoTf1p6KBgrg2wBz809xp6aofbFBd5n5u+tzhY
         /ws/XqmbpXUZ8UAugnVfeHpWsM9BQR6BYyFnT3r6CoVsONEEw+QlfIN9KPJq7uld2kHS
         N0UzV6SWiC+weI9+um0TA24UEbRoA91aNyWQSWBNeoUrOCNBd+m3IEWdgznXF/W8gxle
         zmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855275; x=1776460075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Txux4TW6NI8BBnT/9aUbbKCnnuVuxmAnvDFuD00fzoQ=;
        b=SVd+lThLMqnVQs0P/Gv7JWRpxq5ZVZvqP9rXmEyrh/YZE4uzcQGBrzYX6oxPQTV3T2
         FmaG2cahgyo/wMK31IORcFjn9sET+sq4LRmRRg3Dszl98ASeFOggnJRKQtU49eEdH9jk
         1CmYujXnq9y1zoMUL9UN1/A0TofwoQ5XM76IiD+3tOtdwqgjMtC/nW7f/JZi26SNGY9G
         4GYP3tb7hvKgfTHj94pnUeMnA3FvTNJHFhLMXW41TGTr5M/5E2iUkswKxo9XBQKGd9IM
         jHtQcdTp2HYtwdsfPHtkSjawaCcmbePNPB+FS+Rq069xoSpGkxjjIaevip3yglKkXxRb
         pVRA==
X-Forwarded-Encrypted: i=1; AJvYcCW0RUmiXWT0k11zoiFVnHZ7ovrbKIMH+XoGY09kwSbJ++ZO4nUNU803k5OrzngcdBB3ldvYbRH8@vger.kernel.org
X-Gm-Message-State: AOJu0YyJQLNgkgjT4OXOzCoEugvHke1JkysV0RRz9Zlxb/hC7F6IZASq
	+kHmUBd1Yt08mnJn97Vx7sU44dh3BY9bbzK6C18CB4SJZMH9/H+HpTCh
X-Gm-Gg: AeBDieu+xZr0NM80OaF8OO5rUsEuGUixRvi44s1tQXw9jIazngJpkEu8YdRk4EzF7RA
	KdMmzpyIsZNvcEtaUIDEAvUavA0CKPolhoJMSsPwzFFUcbcni/9w8bgnT5SXAaxAzU2HToucNP1
	mbGsNLdOPkpgaiyPG0Vy1D5clr6dGiDLdznoEHXWR8NYxo6d/1VfjrX9eaVPEfg4aiSWzZ4wiOQ
	7R9Zg9BHeHkuLbLeBI+Flecq5Uja990PiDue6h9u8GhW2+D/CfIvot7qA1jZu9vyGaj5wEERfAe
	NbJTfznp/sn9bhHglS/9PD6Syz22zIDQjcA6V4iLoPuPQfIroJ60/IT+FBoCS0Qk8eoPnf9zAHy
	vjlJ3OEM7lS0hZRt1Xj6wIYKgwvL3/4urYlxzYs4skE0rlMs+JnmSf5XeS/eXu8gFvQtE++mBpG
	DzfYcLEXTfn970/JR4Cdi/2g==
X-Received: by 2002:a05:6820:6307:b0:685:c39e:583a with SMTP id 006d021491bc7-68be7ee7a15mr1487108eaf.30.1775855275568;
        Fri, 10 Apr 2026 14:07:55 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bc88c80a7sm1944727eaf.8.2026.04.10.14.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:07:55 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 7/8 RFC] mm/memcontrol: optimize stock usage for cgroup v2
Date: Fri, 10 Apr 2026 14:07:01 -0700
Message-ID: <20260410210742.550489-8-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
References: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15218-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cmpxchg.org:email]
X-Rspamd-Queue-Id: 3D9113DCC69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In cgroup v2, tasks can only belong to leaf cgroups, meaning non-leaf
cgroups never receive direct charges. Having stock remain in these
cgroups therefore, is wasted percpu memory that will never be consumed
unless all of its children are removed.

To avoid leaving unused but accounted charges from remaining in non-leaf
cgroups, drain the stock when leaf cgroups become parents.

There is one caveat, which is concurrent charging and child creation.
When a leaf cgroup becomes a parent at the same time it is still
charging a task, there can be a race condition where the parent's
stock is drained, then refilled by the charge.

Instead of adding expensive synchronization mechanisms, accept the
pages kept captive by parent page_counters which will not be able to use
the stock until all its children are offlined first. It is a rare
race condition, and is also bounded by MEMCG_CHARGE_BATCH = 64 pages.

This optimization is not for cgroup v1, where tasks can be attached to
any cgroup in the hierarchy, meaning stock can be consumed & refilled
for non-leaf cgroups as well.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6d50f5d667434..4be1638dde180 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4130,6 +4130,17 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	 */
 	xa_store(&mem_cgroup_private_ids, memcg->id.id, memcg, GFP_KERNEL);
 
+	/*
+	 * On v2, non-leaf memcgs cannot directly be charged. This child's
+	 * parent is no longer a leaf, so drain the parent's stock.
+	 */
+	if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
+		struct mem_cgroup *parent = parent_mem_cgroup(memcg);
+
+		if (parent)
+			page_counter_drain_stock(&parent->memory);
+	}
+
 	return 0;
 free_objcg:
 	for_each_node(nid) {
-- 
2.52.0


