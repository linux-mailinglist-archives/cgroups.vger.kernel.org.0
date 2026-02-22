Return-Path: <cgroups+bounces-14109-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKw/Cs/DmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14109-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:52:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 962E216EAE6
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36F2B3065863
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C867922D4C3;
	Sun, 22 Feb 2026 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jSqP4sHV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF9F2253EC
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750167; cv=none; b=eThBmvmkOdjiPlOty6OFipsLqumQ+ROB7Wt85uajx7xYCE6A2HR2QAA4Mgdrdt9AB4RnAtw1Xzkwp3T7HoWaehsCA5NxJ/AaujpRKeWn3WlYEZxo8PE14zY6ZVHxxdRKjGH3lA7OZl7fY01sKVVHRCVaIy32s+pTsisAm3w1a2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750167; c=relaxed/simple;
	bh=RBdmtloBdxUpHWxlqKJWGoVvcuaOTpX5GdBn/hyqYaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXHKeC6rOrZlZvKNwdsvNl7pyaTJuZLpXvH6k72/gAFJwcmP9zYCnW0Ztyx2u5iAwC8UcKMfiNBRxIwp4L+jAPWnYRWyBqRCEwZprX/In1O5IfG1ol9JrPbBPJ1l9/Pp8fqrWMud2DptZSVOs+sLtrW738tTwp6NeiChCVP01MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jSqP4sHV; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506e287dd53so27493911cf.1
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750165; x=1772354965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qbh2YPrN1iAkzOE6jhFX+vkJxP+0+A7nSYJL8bBT1Dg=;
        b=jSqP4sHVyxKHeQwa0cDMYZhNTDSnXVNKEtuQxARnmGuWQx5B7R2yj1gEdcs0KbQjHc
         pYkLTHIIXrOicCCwUZxKjZlh6pktNI+IWOGiM5T8iJcEnUodJYu7tMOoKKMEQ8ZawBEK
         s+g4ZpqatyOf1yMvnZjz23i2lJaY+yalR3W9cXm5P+6Lyt8pZzOYmROuU7alpODJM3Zf
         iCF7JICQMS2x+Mi3opCCO/pfeAXf9ng6+8hRFf+0gdG7H7CiYUdNTaNKGdC1dxkp3qDU
         vyu1Et7B4+TUWB+7YN3RuZ/C2f+xTtDSGuYojtvPAfUokN6fvwNIcfMSC0UyEXU4we2m
         mN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750165; x=1772354965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qbh2YPrN1iAkzOE6jhFX+vkJxP+0+A7nSYJL8bBT1Dg=;
        b=PZJz/rUnYSfkQjVeJUYdPT0Qmi3qXlO6J/ZB55PDOtOvyIf2BBdCYTrMF0FUhc/znf
         tkHgjNun6huWo4UCrjaCRBU/7oTG/XSyv46vmJ1i5n7NbL3gFaeSct3vVtjMWkeTVZzy
         u5qZfI6FPBoK6RbDXtLlojH0mhuStWQ1B+qe3tiUx9qFsQDsCN7D23EzwmFO1KW1J0VI
         IcKWb8qIlTOH/njAnb6ux96umxfgZabPRYi7iju4UkT+NH7JuHscDa7V0UFMUg89cEER
         5TS03AjvEOr9x6JlCTHmzALIqqUSIHNNPAmdJDjl90Y0EMCxQrASpkpWQBDY8tiDEYxi
         pjbw==
X-Forwarded-Encrypted: i=1; AJvYcCVD8N5JlIjGTCuVwqR72or8lv7iuxG2XErhs/xGLLS5E6WNjOPvfo0RHDg/0YG+NrSNrCHoKO41@vger.kernel.org
X-Gm-Message-State: AOJu0YyqSijkDAjXZ9O7Sm1VULZrQu0DmIAE4zuq4Sdzzg10KsVLkSgQ
	oueQ1HX4rPwmQTm9ueIujNwO2+nqoHik3ZZEZ5pO3junCLAFU/14J0PBxum70spJP38=
X-Gm-Gg: AZuq6aIE8T4YYiLBf5OT6p/xw8qf9vZTYpqjEqKqsJ+S4dG8Z5KJtywrUG93VAOS+fH
	wjAFQIU2V5/f2briwKy5ifR0vKK/+nEToJX10BfPlcypmboJ4Yk4Oi0qi29+i48KPqFJLTlLGxK
	S0F84fiAdoVl3fT3v43vA00eL62jJieMXgIodEysvibIlQ6BLs3p9SEYMKC32vWWdq8346TYAmh
	PjY3S8wUtEVYdhwRuIMGxUo8X0czioL54yuVYZPGlmzNMZ+3zaIJM9/P3cbOfd70JbcshhMERlU
	vkw988khvuqAPA9yjYwqOPN7SiVzSG0whgnIH14qCwVfg6Vaot4xXqOcaa5v8PVp8/RpyRrukxs
	NWLYvBElG0ye1v83M2LlJOH5tBfFqTWh/IcpSPauyYF/xYOrx9XM4lvMhi205lzQRqMdV1CIJMH
	CpNshObz+M65IYekoA2IRW7xmf57RiMVMcXv4qSkZJdEES6TRfcZHVyLmA3YrSWeJuGIsOH3IuQ
	KGbH9dSAeog8ms=
X-Received: by 2002:ac8:5816:0:b0:506:9b96:6280 with SMTP id d75a77b69052e-5070bbe5967mr70651841cf.21.1771750165415;
        Sun, 22 Feb 2026 00:49:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:25 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 08/27] mm/ksm: skip KSM for managed-memory folios
Date: Sun, 22 Feb 2026 03:48:23 -0500
Message-ID: <20260222084842.1824063-9-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-14109-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:mid,gourry.net:dkim,gourry.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 962E216EAE6
X-Rspamd-Action: no action

Private node folios should not participate in KSM merging by default.
The driver manages the memory lifecycle and KSM's page sharing can
interfere with driver operations.

Extend the existing zone_device checks in get_mergeable_page and
ksm_next_page_pmd_entry to cover private node folios as well.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/ksm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2d89a7c8b4eb..c48e95a6fff9 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -40,6 +40,7 @@
 #include <linux/oom.h>
 #include <linux/numa.h>
 #include <linux/pagewalk.h>
+#include <linux/node_private.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -808,7 +809,7 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 
 	folio = folio_walk_start(&fw, vma, addr, 0);
 	if (folio) {
-		if (!folio_is_zone_device(folio) &&
+		if (!folio_is_private_managed(folio) &&
 		    folio_test_anon(folio)) {
 			folio_get(folio);
 			page = fw.page;
@@ -2521,7 +2522,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 				goto not_found_unlock;
 			folio = page_folio(page);
 
-			if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+			if (unlikely(folio_is_private_managed(folio)) ||
+			    !folio_test_anon(folio))
 				goto not_found_unlock;
 
 			page += ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
@@ -2545,7 +2547,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 			continue;
 		folio = page_folio(page);
 
-		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+		if (unlikely(folio_is_private_managed(folio)) ||
+		    !folio_test_anon(folio))
 			continue;
 		goto found_unlock;
 	}
-- 
2.53.0


