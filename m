Return-Path: <cgroups+bounces-16172-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAgxB94lD2paGgYAu9opvQ
	(envelope-from <cgroups+bounces-16172-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 17:33:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEC55A86AB
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 17:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17B4333CBE95
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06E037DAB1;
	Thu, 21 May 2026 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="TVfi7btK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B1379C3F
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375838; cv=none; b=lq0ac3Ga9Kki8WG3pty8U+DLvJ4FONwvI3/j7fqXAc2WbAmio7077Q2tfPSW+5BJW3NzDB2iJtW9HUIUsVcZRhG/VzJwYenWBpsj9ctOA2Lmk5BPqEHmQkXy3Rphb3uldy5rTYY6REaiXDs3mVMlRxKxuGpD3/J+iXZL6FA5qZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375838; c=relaxed/simple;
	bh=71dbN/lwsz2RYbZhDRLT9fuF1mdojGIG9wIFF+AZShE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWloYk8yt152d0rfZcZZuCyTys4wwRq11TNSFTZ4Cl33LHk6EW2GykfIDgvX4HH38iBZavLcvzJXuxl8qaObpXEgszmUQov0Y1bSkr7d5XX+XbLEFlha59z7kKWF/x4QvCJs5D5VfpMYUCn+/znD/pBGvyXtowCXfPNBiascgRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=TVfi7btK; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-911dfc86901so657796285a.0
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779375836; x=1779980636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJJEuZOvug6rcak+Osyt/tu7+OHIrKr4x7Xajjb2SaI=;
        b=TVfi7btKfs52Ud8FsysSxZtMH1F5OjgJIxCHty5Taq8U6zqvCxwhhJGjfd4rZp99iJ
         YvHwhwX45E03r1y92lMLy1Ea79jxYvIhvbGdMqxkqAowfW6fY8Dnk++zefxBAF2jtHcb
         OZlLnOn4nxAK6UQ7VnWWrZGuV02Lx5xNcpwsWEGY4YBezdtJH8aGhj2EXo/uM+nKgrVu
         WTCNLFRr0AdeOrLOCpIG8oMjFyOJvSWnwhDBDKrSc6K3e+fsdfrcA9ExSrXtnI9zL3Eh
         nmU3C+QxETIMewceTKi3fOZRC2kGLteTY8xJvhmOO1hP09saDG6XHlkkBBLMZXs94eRF
         HlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779375836; x=1779980636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VJJEuZOvug6rcak+Osyt/tu7+OHIrKr4x7Xajjb2SaI=;
        b=O7Y88omdUthujM/LKOE/Q33oHTfPOWvVHYpzA/2DItuoIL0I9HpJl24wqcXLP7H35l
         ygrWHL034CCBOx6QsH6rzNDfXjiDbs6kIfLBfwFjyTnZsFdjGMD3ZCiPyjxCQEA2XTn1
         tTWs9Z06MDuQLX5lBJby3U0ZBVGEabBDWTXe9PIWEWWOLDZjpcGUiUyrZVw0BcZctj0b
         s05kDp8opBjAXicV4hkX9GQAN7+pa5YH4jaxp1szgDsflTv3sSFwRnrblFrmYEKkWvDk
         mqqYCOIpSzu0GDtyLqkPep63C2ID/jD0mQ6AWTrmmAAjqZz2I7uO10GAAlqb7Fp5bhdf
         b+wA==
X-Forwarded-Encrypted: i=1; AFNElJ/zH8kFF4JsOWo0fmwtz5uY+n3HP9fA5XS+OvbAoBx+lb309xVFXnvSfHNoRLRrv34DYXJb+HSv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1IyNN712pSMYam9k35zvjdIE9jkjjlJoqL/GVr/KNdgTtoBt
	E1IGjOb6YxbVBF37vvMm9hUPkVVZFlGZ8on4d7jU/GKW9sY5eFRma5vl9DbrmvHyfZI=
X-Gm-Gg: Acq92OFBeM3qvhUuIR40I7W5CrINxqcRKJDUbVARu3kTJtxCPSci/UoKfIs4ZiDgX+m
	0NxI6Yi5E69d4KKgiVufnE/J/aLEIj5kAO4xdxGxyH+jGP2lz5ZDj6NVKszI0iF/uMULgJV5BoQ
	w10URYwqn0uYrTSXvFufYsPDFvHJhxAylwnsx830nWc+YqvjKZaQcZTuTWQ5Gi7GqKAKv2w27SI
	Eq8je4uMmA+Eb3z/InKJCLJzcOwNI9exqtpLRRZv5n1qMkk4Qq4HPUw9RLMDXNBo+5VP9i8kcrL
	zMx2UrsXLCNT+bkWh/4igOPqKTQYyTAKXeFxdQMEJ2jY3zdvvGOWbMpFv0ga2QCDpmhCSnWFads
	nzBy1tSeS3jrQNLGA4cl7m6mvRhTI/LKEtCZHQBJh2LgDxXF98mzeLYWU4pV/wHAvRF2+eUG55Q
	n1Kc2uI2xSi+bqnP+S1JIQ1A==
X-Received: by 2002:a05:622a:608f:b0:50d:860a:8fb0 with SMTP id d75a77b69052e-516c54c70e8mr41818231cf.21.1779375835903;
        Thu, 21 May 2026 08:03:55 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516ccba5ffdsm9169611cf.5.2026.05.21.08.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:03:54 -0700 (PDT)
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
Subject: [PATCH v4 7/8] mm/memory: flatten folio allocation retry loops
Date: Thu, 21 May 2026 11:02:13 -0400
Message-ID: <20260521150330.1955924-8-hannes@cmpxchg.org>
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
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16172-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6EEC55A86AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

alloc_swap_folio() and alloc_anon_folio() use a top-level if (folio)
that buries the success path four levels deep. This makes for awkward
long lines and wrapping. The next patch will add more code here, so
flatten this now to keep things clean and simple.

alloc_anon_folio() already has a next label, use it for !folio. Add
the equivalent to alloc_swap_folio().

No functional change intended.

Suggested-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memory.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0c9d9c2cbf0e..552fe26a042a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4752,13 +4752,15 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	while (orders) {
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
 		folio = vma_alloc_folio(gfp, order, vma, addr);
-		if (folio) {
-			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
-							    gfp, entry))
-				return folio;
+		if (!folio)
+			goto next;
+		if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm, gfp, entry)) {
 			count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
 			folio_put(folio);
+			goto next;
 		}
+		return folio;
+next:
 		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
 		order = next_order(&orders, order);
 	}
@@ -5270,24 +5272,24 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
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


