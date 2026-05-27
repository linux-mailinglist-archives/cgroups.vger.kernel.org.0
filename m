Return-Path: <cgroups+bounces-16375-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGN6CqFZF2oPBQgAu9opvQ
	(envelope-from <cgroups+bounces-16375-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:52:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C33A5EA391
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 340983148EFF
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 20:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C3613D53C;
	Wed, 27 May 2026 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="cbV/DC5v"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94E2F8EA8
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914906; cv=none; b=VIxurWn+DEn9+5PGIlWHEndtv8wg7hFHZOc8SW1rn0n3lFN1bMvZbTW18J0cOQRNOoao5uev+Ya8bpF976EinyxOAniY/6baIbeKQ5PEEod0XkzZlNbdUSgRcoZLoyqFZj4q6hWjzi9sDLvPOffE1CH+oFadn6EuZFE7H/GngG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914906; c=relaxed/simple;
	bh=l5utMigt3ZQHnFSdncqv9s5JEG4L2+Jjugd/3yPMeAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVV8MOma+KcFAA1iafknf7PLA8rq7pdbd7ln7ql7ICx3OFUEiOZxN2Ol/berHPvKW8SGQcLA7XoEPiWR6y3uWrBDBAIWr3XDyrQo5Y2BigLpftaexDIzIZe2bXSS+HVdIIyJ5bO0CFany2msGydITKsKUkYetDHmttiBSX3DLcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=cbV/DC5v; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-914c1ced558so278989485a.3
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 13:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779914901; x=1780519701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4EOQagJ0AFWLKeiqsu95H2CZJTRs9F1Y/QS2dFLRqc=;
        b=cbV/DC5v+IpAs92+MCZxGBOmglWChdoH+QI93I2+2BRDcmeAewQN31l4VkD1mswSGY
         p3zS7NsiJU+N+i0azB/mlU/hhjh2owlnrqjoPDlP+v/BxhXjCJiYOaKzpjxtX7OKL0JH
         V9w3z4CzpzdTmrDbll5zByIUQ4BdtTASGz0+TUG5SqBYU2S57Uh0sKTWVAY5uIi5CP98
         TtHyApApfykaplIucc/g8BKTFcwWMfhgfgYQtvcHwvpE6wnqdjzQnVSlIrm2+JhIFFA5
         KeokoPBQkBma8n+PJyGxIl506d+x1gTTww4/Ifp59ntM0KYoLrI2mxS0bSglF/aR8tYw
         CJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779914901; x=1780519701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B4EOQagJ0AFWLKeiqsu95H2CZJTRs9F1Y/QS2dFLRqc=;
        b=ZOwCW6urI4myla3oJjvnyhhtdeifVtVxcU1IhUneUyioWGHiQQ2b4N1BNRzY9Pxdzh
         2OQoLZl8saWD6d0+Q/iJd7LWcocT9ekHN9g4oNBBcuTmv6TZmKXt03yV3FuzZREk7vvR
         aB+uMLin2BcN2RG3bmPRLnBxFoCxxC1DTqako02jdXzC19F6JbhFDMgatzJK/7le3N1o
         zZJ7e40IIYkmnOe3oTzLsYY9wWR+ofwlXQU5+IEfJsk4FDOABVzdnei6nRXWQqYY6+z2
         A2pqGnWBWiHnceDghCeTaMXSbZ4xg+yCYlAFSL4WPJDGg4ldJUii39UO++hRVNp3lQMI
         6pag==
X-Forwarded-Encrypted: i=1; AFNElJ+TzjShkPMLHWPqe0UaSYlpk0x07bm5VE6Qj6iiPTydNoySa+r1SczO/kO4vk4IqI55TtwIWmW/@vger.kernel.org
X-Gm-Message-State: AOJu0YygeltsUc2YEw+eq64/DhRAmk8Yk2snL/UmvHGFl6TosNBQ/yHI
	SsF1/Knhk9KfnSDQjEPsL+4ebV4muYr0GWj4t4Niqk3YMBPXsVD9JsLv1vgQWp+b1GE=
X-Gm-Gg: Acq92OF+eh4MRxb1+erwwDNQ+c71ilR9d0YIk3TeVxy/G3iGFz5pfxjOtSENTGWJ05a
	nGrmmBLHh23ROnQi0fFC3cDDpqE09aFYZYCvg6cWoaeEvBsHLGwsexCxTojS06fjbvhNeAATs+5
	r0iR4fO6j7ydavmzakWYQFK+4sGmmKSv3+mJkyuoG843H62GS7nT1f2BYi+1cEEpDwfkK4gdyYo
	OcCyzNNUiUQm9o1ezBH0m5OQiDePyJuHG3kpEhrGb+7SIeegRxQXvCEHFNg7yW9vffVcf2uhkPR
	/3rJ8f15PuiYYoEwCYeBQHJ570EnLfRpt+TR3SXm02b7d2dOhweBUTBg2J46aFcl37SI5Ktmc2T
	8liBdLbquLOL0gMniYuZzbbwbgdEGGRJvIp0ru897GSc3NOWjFIOnQ5/jpgb/ERI+K4EL6Vw7LS
	asAf4e/jE3ZxMBUNUm4qS7kNqo0EJV3AM7
X-Received: by 2002:a05:620a:4408:b0:902:eacc:bf88 with SMTP id af79cd13be357-914b4a19480mr3620622585a.62.1779914900580;
        Wed, 27 May 2026 13:48:20 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8810a50sm601500585a.41.2026.05.27.13.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:48:19 -0700 (PDT)
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
Subject: [PATCH v5 8/9] mm: memory: flatten alloc_anon_folio() retry loop
Date: Wed, 27 May 2026 16:45:15 -0400
Message-ID: <20260527204757.2544958-9-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527204757.2544958-1-hannes@cmpxchg.org>
References: <20260527204757.2544958-1-hannes@cmpxchg.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16375-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7C33A5EA391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

alloc_anon_folio() uses a top-level if (folio) that buries the success
path four levels deep. This makes for awkward long lines and wrapping.
The next patch will add more code here, so flatten this now to keep
things clean and simple.

The next label is already there, use it for !folio.

No functional change intended.

Suggested-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Usama Arif <usama.arif@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memory.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7c020995eafc..135f5c0f57bd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5215,24 +5215,24 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	while (orders) {
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
 		folio = vma_alloc_folio(gfp, order, vma, addr);
-		if (folio) {
-			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
-				count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
-				folio_put(folio);
-				goto next;
-			}
-			folio_throttle_swaprate(folio, gfp);
-			/*
-			 * When a folio is not zeroed during allocation
-			 * (__GFP_ZERO not used) or user folios require special
-			 * handling, folio_zero_user() is used to make sure
-			 * that the page corresponding to the faulting address
-			 * will be hot in the cache after zeroing.
-			 */
-			if (user_alloc_needs_zeroing())
-				folio_zero_user(folio, vmf->address);
-			return folio;
+		if (!folio)
+			goto next;
+		if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
+			count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
+			folio_put(folio);
+			goto next;
 		}
+		folio_throttle_swaprate(folio, gfp);
+		/*
+		 * When a folio is not zeroed during allocation
+		 * (__GFP_ZERO not used) or user folios require special
+		 * handling, folio_zero_user() is used to make sure
+		 * that the page corresponding to the faulting address
+		 * will be hot in the cache after zeroing.
+		 */
+		if (user_alloc_needs_zeroing())
+			folio_zero_user(folio, vmf->address);
+		return folio;
 next:
 		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
 		order = next_order(&orders, order);
-- 
2.54.0


