Return-Path: <cgroups+bounces-16430-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBejA1SFGWouxQgAu9opvQ
	(envelope-from <cgroups+bounces-16430-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:23:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A153602360
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EED43113F34
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 12:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172553E0C71;
	Fri, 29 May 2026 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bSaVaO1p"
X-Original-To: cgroups@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070813CEBA7;
	Fri, 29 May 2026 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057196; cv=none; b=okKcxVl8v9GS3xNzlTDzkbyqTe62JzSTU/UrQMxt5dqJM4e6qq10GhK1poCnrVVBDD/g+DmCTUpacMAJfIv/V3SY+eHDKrGvcKQINOFA/Bi9cGzxa0HmMzovEe+d+FEm4fvImkE33FpF7q2E5ZmoKwATPdyeSOKwcNRz4+WsKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057196; c=relaxed/simple;
	bh=N0bkbZk9e+3vO2o+P1+AL6OGGPDRe1aokkNHMcWFoa0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hc0kaIVVXBUjxRN/04DgWof6+xwA5aPKgAFc0MhrCO1WAOxmRsxYMa40qmmSqbcSEPx/lgJOXehLxJWU5tmgFKm5EZGveN9aKZ2ApuxtQIsgWcxvHvDkq2UO6wqm4Yu7G2YN0kxSwbWZsUKPR1n5hpDWKex5AcO/gFesp9+luBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bSaVaO1p; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780057187; bh=0F7tBsnwtr9hum4Sk2+uPTGTQ76BR9xyPCoNaMnjzxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bSaVaO1pHWsE2as9v5aqSMI3gC6pea5BdBgdNC7Zp/OSLATc3MR/tPAEO2FgIruVC
	 YB9mZhzuJch1Lyv9TcBU1iRgTAX1iW1VQk/UqItvsjW7pq3FuwOdkBfXuvHXobr1Zz
	 JyGIUF9yPPyeUphvvzOes8X1ZlDuBPPGyfWROCuI=
Received: from node68.. ([166.111.236.25])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 4DC10017; Fri, 29 May 2026 20:19:28 +0800
X-QQ-mid: xmsmtpt1780057184ts6fo2ynp
Message-ID: <tencent_0F6F682C60B99E9E0F1553E6BF3D86468409@qq.com>
X-QQ-XMAILINFO: Mzcurg9uYAemtBwe+INFz74//KNnE+Z/ry9r/kfo1MYznumf3xBU+p9iy79Xaw
	 5SFqWyk9ocoWQh4qtxi57Wl8PIpPfEbG5//RFyUtp7BvID1cq8ZOL2RNORIdwQAzWbREte+FISGS
	 rQLBGEYc6eUsDDl76FFUFO5/22ui9p3L6U1JZw0N66akvDKNhv/1ynm4BWilnqfjBg2mCXJnkx67
	 pwCuegeawCfvgAVS+7KNfwxM5DDiHZnFNXH6ZG4+UCSsbK7o40q0YwxET8LyS0tiHcYiLb5VtZFL
	 AhOMNGUUEYOXEXb+8Skf3IL+tU0BsQDlyt/+KP2F+tZGfDgScU1V/cFt104Yj/eM6uMAX/97T5NW
	 74mzCT2cveD5PAqm4nQwFkHJFe5i9cJReF55joujorHiYDxaX8gXPlCIF8ejkOK+BlPhSqw7MEsR
	 GWIOs7Xh0FTyVz+6i/R+CfGiEPU1aMpB+fMq67UMOM0cs+kt69P07GXv8K3gO1g5Nr2DA/5BLnjZ
	 mAToYyjg9Ydu/7jk0GSMBpTyEG0GJEgZ14RiImwQOaFQxrcor9tUVNIuTs/1jVyeZjt/rfUMJH9D
	 H0vc0MXd/ln8DTRmhr0dDIfzVJtXGNKUGZLszineBd2wsEbTzl1DVmsjblQCkRC8dDR3iCGOoC9P
	 KhoOLRf/Y01X/QHibkPXac0vuPGeZFo9sYT5Xajl2kQgof722s+DxCQB4b6domZD1/i4gkgfsLSC
	 AwqOLfuWfOn3JASXbC8cLYiyXjduwjbvL2Y9NYDWSMmWTjAYBO9atEQ0d8770p2vzQ8PyP+KfWqg
	 tx6Y2DHMgRODRVKFoBsMSERP7Ar8uNDk2TvEdEStURJEMO6K50+et+x2VpxYvFUpk2QSPcwSvK0L
	 TXjiwyPvWmy8RVmLFleFoPIBszmIlosHJPcYsGUoKTbY/wH3sFaXX2C3JgUOYva0ncVfCDuOWYMa
	 FPuQLGY7kjudHqGukOTmTK7VYzX/GUfQwLlbrJwUrdcxSdrFqwAbD9eESEvPovIzqoUER1VAm/H6
	 uELPk+BgwYmrm1cLTFhdappr6OAVFkmrqx+qYiY9YcRRoUL9mzGIOdpgDNqH0=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: fujunjie <fujunjie1@qq.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@meta.com>,
	Kairui Song <kasong@tencent.com>,
	Usama Arif <usamaarif642@gmail.com>
Cc: Chris Li <chrisl@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v2 9/9] docs: mm: update THP swapin counter descriptions
Date: Fri, 29 May 2026 12:19:28 +0000
X-OQ-MSGID: <20260529121928.4115683-9-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com>
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16430-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[linux-foundation.org,kvack.org,meta.com,tencent.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,gmail.com,google.com,linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fujunjie1@qq.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qq.com:email,qq.com:mid,qq.com:dkim]
X-Rspamd-Queue-Id: 7A153602360
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The THP swapin counter descriptions still describe large swapin as
coming only from non-zswap swap devices. Update them now that
zswap-backed large folio swapin can also increment swpin.

Also describe policy and backend rejection as swpin_fallback cases,
since speculative zswap large swapin can intentionally fall back before
doing large IO.

Signed-off-by: fujunjie <fujunjie1@qq.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 23f8d13c2629..59b7a0d09243 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -667,13 +667,14 @@ zswpout
 	piece without splitting.
 
 swpin
-	is incremented every time a huge page is swapped in from a non-zswap
-	swap device in one piece.
+	is incremented every time a huge page is swapped in from swap or
+	zswap in one piece.
 
 swpin_fallback
-	is incremented if swapin fails to allocate or charge a huge page
-	and instead falls back to using huge pages with lower orders or
-	small pages.
+	is incremented if swapin cannot use a huge page and instead falls
+	back to using huge pages with lower orders or small pages. This can
+	happen because allocation or charging fails, or because policy or
+	backend state rejects a speculative large swapin.
 
 swpin_fallback_charge
 	is incremented if swapin fails to charge a huge page and instead
-- 
2.34.1


