Return-Path: <cgroups+bounces-14174-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH2EEyDXnGkJLAQAu9opvQ
	(envelope-from <cgroups+bounces-14174-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 23:39:28 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2EF17E758
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 23:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBB5830CA82F
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 22:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E58A37BE60;
	Mon, 23 Feb 2026 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLsqMBTk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E77E37B40C
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886323; cv=none; b=A52RnKM9CwS93dCz3sDOYsvugiIvllmkVGEDPrabJfxCUhi8MUckG+qgLAfmnGWXKuN4SldcQee4xxKgw4aMbxr+IMZggQAR1fO1v5FWsQuYfShXbwyq2mCgatifRkWvYmYnnTQ9WUSQtvZ9T95yEKWenz4tkoq/vDr1cxiEWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886323; c=relaxed/simple;
	bh=J+BT9JHVO5MqWgVBXYMCvRaAsNpI/lKiHSmM/7rTRko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUHevSitvnEFLa7V9+WH9UNFpISifQQRUyh3ECQS7bAy+bLDFivXkZASnx11ey8Y4Hs++MYao82WFERQ7ELiM76HhsP1BOb5PQFhTLfQatgDoDJ9B5DXrxYutIGXxlpKcVdATOSYKP1m63BrtmY7d/3H2+QSD+VETGpSKZ1H9EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLsqMBTk; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-463a94f8475so3076401b6e.0
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 14:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771886320; x=1772491120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgNKK4IJNslBJZZOngZoyEbar9yDv1r70Pc6CR+o2yQ=;
        b=ZLsqMBTkUrxPmUXniY20pVQ3VuNzlsDGv/KaLU50Bv2rJG8/0Jh/04kbFDxHYegmdR
         4u1hwYOP5Oc3Rvw1j2GjMGquFZP7BA3MPlaViY99SkbC7IYYPjus46+pzr3NSDFF3t7f
         TvFGRz451M5xbBgjviQnb+/5TYarK/4dP6qqEGPf/b9uTrye8+FPbkxf33U1JK+thch9
         F0yMafUZcYBA3uHoMfwzbEBqDmCMd0hLbbhkqp4VuU20/xtZGyeALnsXDOyxBz6BIbWY
         r1RvXO/WkWbnwcEDrfHWOOsvDwg/UDCz2lFijwafkK0xsr65RMIQh71cLi58yR45y3UL
         0hIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886320; x=1772491120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FgNKK4IJNslBJZZOngZoyEbar9yDv1r70Pc6CR+o2yQ=;
        b=GAlsAIoA3Oe1SEsVtiOXg9Qd4Y+hWf4oOGujMRcbBvPvH6/N7iJAXTB1HggCAqAtT1
         lsk/xR1NL7cxyYndfTZEZyBd11gJKuaFQS6JIb66G0UiO41UFsAWbUMiQJ1+i9JxdrtO
         PdUxKMsxPq7HHA4/pf3XNRhQ/tfwcWrfwxxUJZBQ1Mxjudr3sUobOvI3ISheJL/yWnbB
         Wyw5Gu42qL4kYkWEICFpvDMpFlsLQQ2Ct7tt5g7sA2QJ+n5kK2bSHiPglCUzTgA2NaHV
         +eUROfuC1yVpaqawOblvyJNg+xJRyQu1O3VsxaCYiZ3XG0Zf1e7DA06hWhf9/oc8ECs/
         8cFA==
X-Forwarded-Encrypted: i=1; AJvYcCUrpnfm/JFsMDlhHhosFQ8OrBOeiqmqYYqwQBx55LjvgQq46y0VG2Ung/JX7vTJrNy2AAtvom4a@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy5oPJRbAM2f3314v9bo1j/p9YIunCKbGMULJPvdpACzUHgaWb
	EP6DeANngHcw+8VsgUaqzpL4fBC3CG14kHDQ280MAJdYoUz2elhMh7yf
X-Gm-Gg: AZuq6aKBi/eFprKTkGIBbGvwCexXWEOl52Ddy1+so9nwg5nQaz3s/094FA9NKB7/uCB
	9QnPK6/MxbKBX0WlAia2tO7JLy7DmGlzyBzLRI1q2xm74lmy+LqGVtJAfQlogcXBnBI58IhNXlz
	L+L7IZyZDBRPo3EZhMDAbx/TES1sFBy/0RbXBOueajkIXVDlQGbtaKVAqt9jXXOkqsV3T8NsDTL
	MfpFswdB9rzsgd0HMCTgNKDR38+EbZLhSmRUPV51pXCjLaybD1iwknUgmodNKRjAo40IaMLVDW3
	QEUMPg/npZ5WtTjvWFK9EubwKF4WcDSmhvPSGL8sVbnxbWbfsXF5J+KmQI1m4MA/uz2+srSbZjM
	RgpqCuGOSLdDGglw5VD4DTO/VfLgtCO8GSMlNQzOPAEu4d4k19x4WlS9Z5etssImgvNO020kQNu
	xGP7qoUMlKihQIkH3y76z3bA+dn8dUz+c=
X-Received: by 2002:a05:6808:3442:b0:453:7cad:63be with SMTP id 5614622812f47-464276813fbmr8219044b6e.31.1771886320460;
        Mon, 23 Feb 2026 14:38:40 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:2::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4644a1afa44sm5819928b6e.16.2026.02.23.14.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:38:39 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 4/6] mm/memcontrol: Charge and uncharge from toptier
Date: Mon, 23 Feb 2026 14:38:27 -0800
Message-ID: <20260223223830.586018-5-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223223830.586018-1-joshua.hahnjy@gmail.com>
References: <20260223223830.586018-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14174-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C2EF17E758
X-Rspamd-Action: no action

Modify memcg charging and uncharging sites to also update toptier
statistics.

Unfortunately, try_charge_memcg is unaware of the physical folio being
charged; it only deals with nr_pages. Instead of modifying
try_charge_memcg, instead adjust the toptier fields once
try_charge_memcg succeeds, inside charge_memcg.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f3e4a6ce7181..07464f02c529 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1948,6 +1948,24 @@ static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages)
 		page_counter_uncharge(&memcg->memsw, nr_pages);
 }
 
+static void memcg_charge_toptier(struct mem_cgroup *memcg,
+				 unsigned long nr_pages)
+{
+	struct page_counter *c;
+
+	for (c = &memcg->memory; c; c = c->parent)
+		atomic_long_add(nr_pages, &c->toptier_usage);
+}
+
+static void memcg_uncharge_toptier(struct mem_cgroup *memcg,
+				   unsigned long nr_pages)
+{
+	struct page_counter *c;
+
+	for (c = &memcg->memory; c; c = c->parent)
+		atomic_long_sub(nr_pages, &c->toptier_usage);
+}
+
 /*
  * Returns stocks cached in percpu and reset cached information.
  */
@@ -4830,6 +4848,9 @@ static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 	if (ret)
 		goto out;
 
+	if (node_is_toptier(folio_nid(folio)))
+		memcg_charge_toptier(memcg, folio_nr_pages(folio));
+
 	css_get(&memcg->css);
 	commit_charge(folio, memcg);
 	memcg1_commit_charge(folio, memcg);
@@ -4921,6 +4942,7 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 struct uncharge_gather {
 	struct mem_cgroup *memcg;
 	unsigned long nr_memory;
+	unsigned long nr_toptier;
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
 	int nid;
@@ -4941,6 +4963,8 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 		}
 		memcg1_oom_recover(ug->memcg);
 	}
+	if (ug->nr_toptier)
+		memcg_uncharge_toptier(ug->memcg, ug->nr_toptier);
 
 	memcg1_uncharge_batch(ug->memcg, ug->pgpgout, ug->nr_memory, ug->nid);
 
@@ -4989,6 +5013,9 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 
 	nr_pages = folio_nr_pages(folio);
 
+	if (node_is_toptier(folio_nid(folio)))
+		ug->nr_toptier += nr_pages;
+
 	if (folio_memcg_kmem(folio)) {
 		ug->nr_memory += nr_pages;
 		ug->nr_kmem += nr_pages;
@@ -5072,6 +5099,10 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 			page_counter_charge(&memcg->memsw, nr_pages);
 	}
 
+	/* The old folio's toptier_usage will be decremented when it is freed */
+	if (node_is_toptier(folio_nid(new)))
+		memcg_charge_toptier(memcg, nr_pages);
+
 	css_get(&memcg->css);
 	commit_charge(new, memcg);
 	memcg1_commit_charge(new, memcg);
@@ -5091,6 +5122,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 void mem_cgroup_migrate(struct folio *old, struct folio *new)
 {
 	struct mem_cgroup *memcg;
+	int old_toptier, new_toptier;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
 	VM_BUG_ON_FOLIO(!folio_test_locked(new), new);
@@ -5111,6 +5143,13 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	if (!memcg)
 		return;
 
+	old_toptier = node_is_toptier(folio_nid(old));
+	new_toptier = node_is_toptier(folio_nid(new));
+	if (old_toptier && !new_toptier)
+		memcg_uncharge_toptier(memcg, folio_nr_pages(old));
+	else if (!old_toptier && new_toptier)
+		memcg_charge_toptier(memcg, folio_nr_pages(old));
+
 	/* Transfer the charge and the css ref */
 	commit_charge(new, memcg);
 
-- 
2.47.3


