Return-Path: <cgroups+bounces-14530-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHYyBJDrpWlLHwAAu9opvQ
	(envelope-from <cgroups+bounces-14530-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:57:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A83931DF03C
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73D6A30F664C
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 19:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10D4337689;
	Mon,  2 Mar 2026 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="bjSmNgXH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D2E3112BD
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481204; cv=none; b=qU8kbTZ2KIov/jE6tyq0OX+I2QJcWPncfj8TW1qkdQDwxNvPQVetUpzqt20uXW4HpdcsPJLkJSIq7kLUaKqo1Zv5Mg6wj6r2nexFSSdlPUHYW2BnozLp5jLxYRLlmulRnwAV7r7L016bhcKKTE5X/awjE5lhJmOrfY4nX8lXI5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481204; c=relaxed/simple;
	bh=cC80qRo7JR4gIfZy7Oohm8yvU+7yInxXX1FTNUyJ+DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2rWLBHRxBMGy41PI2UitOK6LpaHBXBF/hLuYmyOKCCqALhQjH6iTdsNXkUn8f83NmeUC0uGI4afD+lNZFAN2wJZPTUPd7cQw9hl+VmQyjSVdYOzlp1KAlM5vEGUC7a/V7YXadsP9LuUahgE5IQfzLtGtfZaftWvemGE8T0canY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=bjSmNgXH; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899fa9610bbso21623646d6.0
        for <cgroups@vger.kernel.org>; Mon, 02 Mar 2026 11:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772481198; x=1773085998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IA4kjBdpYkYKS/nfolmQRGvXpsjWiFeExJHfqapx5Xg=;
        b=bjSmNgXHF9jdG7y1MwjfLEMVc2T2l2ANlNOIVyDFNqI4XEeZcNgHrbrI5y6E82otJR
         d93wfhQvLJMzNyHr+/tPeHyrAvlRo7QGg+pBZHSehdk6WMUUlm+kJfUpom3RDsYeJjrM
         eWwctbX+Xg6UsC1BruAEUHgPfQPzqC9BRSZzV08OeD/wa0LRucJ+52I40qHUc3FLtzSC
         bjslffLMATeayzms2TY4ZVTJzhANUNRakjBxL91puuH7KXSiP/n8lBu+gmUhraUrImG6
         u57WZN8ymqCN+RkEK1wYdsXvlNUtZPajURjm5iaMSmttd6Ebgkx8sTDOOG/+4KChQvGW
         iDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481198; x=1773085998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IA4kjBdpYkYKS/nfolmQRGvXpsjWiFeExJHfqapx5Xg=;
        b=LamWkYFiPEodUTCoYRj6oVD4Fi1hOhZbBtQdwPHQ+WYLYnIRkNCNji1HcIX14GvSoP
         L912binXhkpwa+Lld8syUqN8zJew0PgJGbdZfH6ZD39aqeTpwiKN+0XQIvb1g3cPBy1T
         M8H5AfzBPKH7KELWadrqmMItLwAoa0CwSmKLJNtYmbeOYUxn+7BRunRRG05tt9tHEMkL
         5V2g15z3RyOmbNlHVl628T4+JJlGuQxMMGDBf19oqU5kgFUGJKK0HLmZI68dCb8Q/+xQ
         AF2fIm2qO94n37iZVyA2sn/hK6EmmtIdIGMgBYmy0XrGEIjhgZ68JyNVUkPj81aAAlYC
         P23w==
X-Forwarded-Encrypted: i=1; AJvYcCUBHg8nSPO3v8YJuaD+5BS6dHoCVDGnLgKRpkQnBiYFb7hr84tB54eETSRDx6skAQtYhHmcpBq5@vger.kernel.org
X-Gm-Message-State: AOJu0YyD4T8bptnX0ARqAcSjtgmJ9UMweYyAguGnpyT1NE9YFIJ8zJEG
	Q93xVAStTOyH11ZnyHWLz6erEzVkgPZzWwTSovQYSm+WC2ob53b0xX3jsd025jDHYxI=
X-Gm-Gg: ATEYQzwObTg+1NGhRVIs/tEP7s+lSATBDHVexCwxyWI9dVniEazB4xiCNy04ONaudx1
	nAsVlP6Fo+ENeDXEhq/YFnpWfRwF2hb53MyJ5G4XvkES6gh7Qh+cofvKuF/CR5tXZiY4wuoILyl
	3RcVFAuJhb66FxsxqUxPwB26iun2JYp/9OuZs3+MAZUbgZaHKVVmKnd4//XQb1sGiu3aXKztkML
	6GLFV7LCwJ13K5nIZ34emOt94oADmcllti/eQdvk2bok/9swOPSHvu21EhyGDds7fcUiiqIx9bl
	dlMju0xJr1RJOgjhtEuT7MTYQ42cPa0KHRBY1CaQkcO8t8jz74G6oDyCXsLOztqrmRLI46zNhwo
	fkG9DiMAo4nLYTMKDN87dcHWKjYOQt60hFoqcHL0FwK3doTVhDlyfaE4is3rctuKhwcyr+JM9HO
	vEQiSg0K9Cd8gQGmu8bCSlsk9REY5fZP49
X-Received: by 2002:ad4:5ded:0:b0:89a:4f:1172 with SMTP id 6a1803df08f44-89a004f1317mr42550936d6.50.1772481198200;
        Mon, 02 Mar 2026 11:53:18 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899f4fb208dsm44178686d6.28.2026.03.02.11.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:53:17 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] mm: memcontrol: use __account_obj_stock() in the !locked path
Date: Mon,  2 Mar 2026 14:50:17 -0500
Message-ID: <20260302195305.620713-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302195305.620713-1-hannes@cmpxchg.org>
References: <20260302195305.620713-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A83931DF03C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-14530-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:dkim,cmpxchg.org:email,cmpxchg.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Make __account_obj_stock() usable for the case where the local trylock
failed. Then switch refill_obj_stock() over to it.

This consolidates the mod_objcg_mlstate() call into one place and will
make the next patch easier to follow.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 32c09b4d520f..4f12b75743d4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3227,6 +3227,9 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 {
 	int *bytes;
 
+	if (!stock)
+		goto direct;
+
 	/*
 	 * Save vmstat data in stock and skip vmstat array update unless
 	 * accumulating over a page of vmstat data or when pgdat changes.
@@ -3266,6 +3269,7 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 			nr = 0;
 		}
 	}
+direct:
 	if (nr)
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
 }
@@ -3382,7 +3386,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	stock = trylock_stock();
 	if (!stock) {
 		if (pgdat)
-			mod_objcg_mlstate(objcg, pgdat, idx, nr_acct);
+			__account_obj_stock(objcg, NULL, nr_acct, pgdat, idx);
 		nr_pages = nr_bytes >> PAGE_SHIFT;
 		nr_bytes = nr_bytes & (PAGE_SIZE - 1);
 		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
-- 
2.53.0


