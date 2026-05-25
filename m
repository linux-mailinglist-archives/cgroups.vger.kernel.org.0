Return-Path: <cgroups+bounces-16258-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMadM7ydFGqpOwcAu9opvQ
	(envelope-from <cgroups+bounces-16258-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:06:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D48165CDECE
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E746300A66F
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 19:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEC33955E5;
	Mon, 25 May 2026 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqH8Yg5F"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD95380FFB
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735912; cv=none; b=eROccBbuy1Kdv5gdtr9OVR5PorKtHFTNKcemWT16UOkqEf2dvmbmCCcr7PMvU/RpPuADDMI15MdMQ0V1tfY4y80xOhhGXNlpgrZp7PjyUW0yt3Fkb/QhqCz1aXZ23xh6kNsAzwQhr00byZ4zTDPeEtbsCASzosUyb1LYQm7XjfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735912; c=relaxed/simple;
	bh=zi3Ude+mgYpIWVX0/fNZoP84JwZ0OmrzuaVBZnHQ+MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=II9G1OnvboWNQ7YWlAkyL11O5WKgr6SlLCuE8M3m0GJ/rxTs9BH+gdFHY4xajgmej4hAEutAc8/qg16QFa8EtuLxSpkJ/Q5k2GPkJytcl31X/oQmgPg9YilWG+RUMLpSWw44Cb05JdmgTBEhQ4h+cPyYcORlpQ14Wd1mFEJ9dH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqH8Yg5F; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-43bf95c3f6fso263785fac.0
        for <cgroups@vger.kernel.org>; Mon, 25 May 2026 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779735910; x=1780340710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ36US7aEGO2e9MShcKJGWBIzONamDGB3D8ceYmvI+8=;
        b=iqH8Yg5F4gCLFUnOmnesvxqsvmmzTOGfKJxYrUvTbxQU6dIUMjYtkNGfyTZaVqxsjp
         tdBu4f5JkpcPRenPUG/FsGyTZRtv+ntzB23vrdyLPwOfM9Wp+f5I5OqZmcjoA3iWPoU3
         hdwW/M+w8ih78RvAZto032ymThYOWAC0L63ngShpvI1dfN+QKEv1yrJsl0bI+DfMgrVa
         IunOZPpfX32ELBJ7CwTK1Vo+8Uoe+HWDA4s3xbG3dcDqROkLHBvoo5oAlpVhjQG5jG2L
         RBNv54LBPO7getggsVJw6mbVnCMc1WiIp9cot4LI+ty6ml1nlyVImQTwLSZUl55NYts7
         3/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779735910; x=1780340710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQ36US7aEGO2e9MShcKJGWBIzONamDGB3D8ceYmvI+8=;
        b=sPF+ouBXX6P6N7KXLyNQcSXM5t0obU+RY3CW5X+0qAf8MpzMQ2+kbxUNnRREphhrea
         TaaXY3eOBHwApkl2vfekNmtV4J14rXQlZRjIvHbY8kgQ0AVFdEhN+MsPlYnGXrNQW1/7
         mqqM0Dv9Wn+QfQu+d7RUSxThZ+fyR05S+ohbuFgyj6rwXEggwf4GIG0aQi+zQfdTkRPM
         1jxuYBYMUv7rpesE6uiE5wuNvhJCIV12bS2jxcWe2ERWeZUdr1sQwYPeW/PCLmRjEy53
         tTLhqmSzXwwbi7cj9eapwe87WDcS6tx3GdP6DXbG/IXdEwz0VF/0XSCstZujMIMHVJ/+
         CAow==
X-Forwarded-Encrypted: i=1; AFNElJ+pEnCA4eBUX9JMkQll/8Ye4agMxq4oxyHVagIN0Wg+YnVstU+8Ge8CRuBIwq5XvJNYhzaR427K@vger.kernel.org
X-Gm-Message-State: AOJu0YxRiUOt/G8itttzdnCAsz2NybShMzpf3sMMZJr3ZpgbZPBMh4cz
	ObWedl8CPQqWCNeIbmQvuKQfaUjEvzBc+m2g5yZ3ewl5qt4jgvH9h4B5
X-Gm-Gg: Acq92OGesTi4JO69eNcnjghs1gFVanU4l2o9Xf+aZEaqHiCpF8w4lpCRQHFGneCTOHD
	/6hfVPSxT0LvP8G8KUbi1X/+Kh5cb/L8LRVBlAM9850Fm798KhV1H8PmAkpDOMus7kTD8J4hXdt
	P/Ec+Ccit5I0g3E4Tx1Fub3RaiAkOh8jRUvzGQX7j6TXG/uWwl2+dx5baLIOUVCUP0HLPIvD9XU
	Iz6Pjb/rG1uf3x+PE1sYfv6h1x5LgHaMnKs9T/YfhCzU0QCDGsVJ19w8yNRiHKnMAGJpFixUOyD
	jlxeADv8w4lcspqKDuZGrVR4siM6/ofqitY2ZYLEO13E/hHgpzLhe4BCndSCp+HHGv1AtxW1E8q
	GK31l4P+hE+PvNGzV7e4d/sOvu8LYfH8s3paK9me0oXN0vR/CFsP9chMBNXUj1v4TfRcVbrxchY
	vnuozfUEs/xd6LYOf6bw1Q/0wrAAf0tEy0CYV1NEq+FLETxHFdLMt4Fw==
X-Received: by 2002:a05:6871:3291:b0:43a:60e5:21c6 with SMTP id 586e51a60fabf-43b2fcaa33bmr9336295fac.24.1779735909636;
        Mon, 25 May 2026 12:05:09 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b635d26b5sm10931436fac.6.2026.05.25.12.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:05:09 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 6/7 v3] mm/memcontrol: optimize stock usage for cgroup v2
Date: Mon, 25 May 2026 12:04:53 -0700
Message-ID: <20260525190455.2843786-7-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260525190455.2843786-1-joshua.hahnjy@gmail.com>
References: <20260525190455.2843786-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16258-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D48165CDECE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In cgroup v2, it is unlikely for memcg charges to happen directly on
non-leaf cgroups. There are a few exceptions, such as processes that
have yet to be migrated to children, and tasks that are reparented on
memcg destruction, that charge to the parent.

Because it is rare for parent cgroups to receive direct charges, stock
that remains in them are wasted memory.

Drain parent stocks when the first child is created to return those
pages for other memcgs to use.

This optimization is not for cgroup v1, where tasks can be attached to
any cgroup in the hierarchy, meaning stock can be consumed & refilled
for non-leaf cgroups as well.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f20c9b829224a..64b82f1782720 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4280,6 +4280,21 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	 */
 	xa_store(&mem_cgroup_private_ids, memcg->id.id, memcg, GFP_KERNEL);
 
+	/*
+	 * It is unlikely for non-leaf memcgs to get direct charges on v2.
+	 * Drain the parent's stock if we are the first child.
+	 */
+	if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
+		struct mem_cgroup *parent = parent_mem_cgroup(memcg);
+		int cpu;
+
+		if (parent && !mem_cgroup_is_root(parent) &&
+			      !css_has_online_children(&parent->css)) {
+			for_each_online_cpu(cpu)
+				work_on_cpu(cpu, drain_stock_on_cpu, parent);
+		}
+	}
+
 	return 0;
 free_objcg:
 	for_each_node(nid) {
-- 
2.53.0-Meta


