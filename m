Return-Path: <cgroups+bounces-16166-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI3nDnotD2r+HQYAu9opvQ
	(envelope-from <cgroups+bounces-16166-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 18:06:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 859AC5A8E02
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 18:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFCDD33AD56D
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C987C364E81;
	Thu, 21 May 2026 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="MPLRq5Vc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DF9332EBC
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375826; cv=none; b=KeTT5kRoQ2Pzmf6T/DwqMvTqlNeaNHFhkGQOmvxsv1LjYjqylI/x+iPUB9ShtpxE+MPEuNI6ms3BQNkT4p/r/+A8O9WGPBzsDcvkzGj7j0n+6BJtw7FHzmJN6rHaUu794PEfuzOdFS39MdZBX28QhlivQTmNn9YTzqAJ35syMVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375826; c=relaxed/simple;
	bh=U8Z3an3hNgZrCxyekQRPWZceUjB6u0warXZQZI9zDco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKCnS+GfcJxFgecIEs26spyPzr3t8opb5dVlaBpyt1ifjfJyD1sJhYqm4PGQtSmfK8YR0wvZcGP10vUcvG9E5gnWcAwrjWyG7FmKng/RiXLVgoeAx4eDLgKMZzB0nbV+2yJn0OwMdK2BURQq7dxdz8UKYjGHVcyrsZofexe0Amo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=MPLRq5Vc; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-484d3c0855aso2439978b6e.3
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779375824; x=1779980624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cbAO2KW+lIj5NuloFoDpyrLcHnbVUzz5CiT+zyYy0s=;
        b=MPLRq5Vcn/sK/aXPgD0CaHvegRRF9M1+l6r0nhCwNEvOD9feeAEykYn1oixuTqPTH5
         BLplBfvM0g/y/PrmXWRgraUG/7uslPVrpAoauviD0iQjAO20owdE44O/3Peczfyk7yRG
         E17LbfVG+8AwU7wLlDpTRzKHddUYIlXSI36UBxyCyNxTeL1DBqHAgbTVlw+h1YmgUx3+
         YpvsIR5bgt3OHUyVXRhck7Sf/RuTURNQ/uAEHML9mK4VLN0b0uJo8iy1gD27ybn2HwXU
         izgu3Erd4l5jS3zsNOPp/EzMw3YpnVEG+45F0ximUypIFk4hH/M9zZhennlZFeD6qsP+
         2iBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779375824; x=1779980624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1cbAO2KW+lIj5NuloFoDpyrLcHnbVUzz5CiT+zyYy0s=;
        b=jyAM1GkpEchCxSqKxh2ZKQ5T6NQAsV3cXxsl8GJdN0ULsCTR39TpDuyl5Zb7+hTRBB
         723kEsG8q7nZwAcjOXa72pquNCtsEj2a/xWabeNCmh+yeURdKrDcSlHN9Y8EW08vorsu
         NVdOBPeAmh9J+9vKx92R57v4DVkU7XIHvP6qFxlX4lvJPuZ7EFPSWvmvHCpNpe2OKmGH
         ZSkEtMZBbR6kL6jWT4iv7g+WRbDlYAcpIVYEDjQtXrNFbGrKfbz0aXVpNfH2ykaoUcrh
         b/QC9FUcUjvarnyRfK7UGHRGUimCbY1zeH+Ws3w/4wLabUtUb3+Smh8v5j6Rfcpc/6/G
         Olpg==
X-Forwarded-Encrypted: i=1; AFNElJ+ZyUxX4vIK2S8sprXaUmMIcdCcpeKhtbUDFXMHQzmNPAPoadrKVgJhQ9h0Zj4MMsZgHrc7jQCh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9HZ4bPw52kj+Pn1b3tiJjbuVyNTKkFkrsHAijnz0nXAxCz3cE
	Mxb3BkZZuhfIFfcBhBCc9bYopQQtv7HjB2eZeC/QLLCKIe8p8x92bBq7HZmYe0hN1FY=
X-Gm-Gg: Acq92OHDAinRcwd8MZfiSyMiygy1Il14zwNzHBZb8XRlsg2BJJwmUXabeTUT+dJfn/E
	Eg0r9UZi+EbAbIrYl/7E60bdXeg+AhmTq1JF3hA7lmLW75GQuaaoqESc7CxHmx/5a9yTt7m5YEJ
	/s9hEqD5lEZXm8nyclqfXoZX9A2RqY0wiSe6nIRrMwkILfipuKudicCDbuIvVp6TzXZFkrDzzhO
	0ti56y1REQD++/j68dM8dFmQZMJjX7iK1nWa50o6THEZcH/Kxcnv83itOZ1NHX8huqh10odegX8
	wa2fLTR8RK1vqsdZy09FD3cPfDLKdlxSl3ZpagzEdnUpQiuXE/qj48mRKOsH4nRTnq+PSNB0FNx
	ybmE7vHVUt5ohZTmeu8YbKogjDNk4YaE3wcyLu1RoE36ZMeAG1XT5xTAVs8kKoZX204Q355S9lM
	NkhjCNUATpSoIoGFXiKaF3Qw==
X-Received: by 2002:a05:6808:2221:b0:467:1941:1f0d with SMTP id 5614622812f47-4852eb590aemr1685571b6e.11.1779375823781;
        Thu, 21 May 2026 08:03:43 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516cce102f7sm8647231cf.22.2026.05.21.08.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:03:42 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] mm: list_lru: lock_list_lru_of_memcg() cannot return NULL if !skip_empty
Date: Thu, 21 May 2026 11:02:07 -0400
Message-ID: <20260521150330.1955924-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521150330.1955924-1-hannes@cmpxchg.org>
References: <20260521150330.1955924-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16166-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 859AC5A8E02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

skip_empty is only for the shrinker to abort and skip a list that's
empty or whose cgroup is being deleted.

For list additions and deletions, the cgroup hierarchy is walked
upwards until a valid list_lru head is found, or it will fall back to
the node list. Acquiring the lock won't fail. Remove the NULL checks
in those callers.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/list_lru.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index dd29bcf8eb5f..d3619961a7ac 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -165,8 +165,6 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
 	struct list_lru_one *l;
 
 	l = lock_list_lru_of_memcg(lru, nid, memcg, false, false);
-	if (!l)
-		return false;
 	if (list_empty(item)) {
 		list_add_tail(item, &l->list);
 		/* Set shrinker bit if the first element was added */
@@ -204,9 +202,8 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
 {
 	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l;
+
 	l = lock_list_lru_of_memcg(lru, nid, memcg, false, false);
-	if (!l)
-		return false;
 	if (!list_empty(item)) {
 		list_del_init(item);
 		l->nr_items--;
-- 
2.54.0


