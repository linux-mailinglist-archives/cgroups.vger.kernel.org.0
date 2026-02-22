Return-Path: <cgroups+bounces-14107-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HAFGZ3DmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14107-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:51:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D186F16EAA7
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AA34305466C
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5055C223DEA;
	Sun, 22 Feb 2026 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CGUxMNnW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4229223DE9
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750160; cv=none; b=Q67/5NOHzvNEU3i6YDe/ZhyuZ9QDSSJZrjcV+P6fRlPg9HjRx8cPZEJuoPlyHijRfAkLmFAp5sv5odM82/NrsT16cfLSyuH0CNHkmirPgeiLjwlVKntuZdLeGSJnugDEIqJ5SlkZRtFK0CQ0/K089zKkbW4n+p23D7BjrQhQTC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750160; c=relaxed/simple;
	bh=H6CTxJojW3RaznwU7e2tIws+8uIQCpQLDZJs/4YMrlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APv79cdgg0uv5LRFd3glG45nPQVgTyS7SNw/ojxT0XEOSbRFcaK/VnSWHf3QiVgXmtMzy7jTcHv/0f1dvPB7Djum6XkRW7IkigYOAqW7NyR3mDkwvlu20h/y/5fDvEtWEHK5ms3PUhvN6BhvSsTkmap5ygugwm6xgMTeZfYRBZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CGUxMNnW; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506a3400f30so26507451cf.1
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750158; x=1772354958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN2sy4KwpOgCvYV+YZxAOK9yTs+OHW6J8ZgmY0xzRNk=;
        b=CGUxMNnWu02bmbzLcOlR+km3HPzPoJ9As9jFtY2WxYxvmgGbXZnW2cjXnNozVsjQCg
         t7pJkcAkvleH5Yb3EDUbbvUstv4VLIfoN74M9FfqpSgcx9GAQS8rOh2SM30ptHku+Xau
         0onGqjdY0agBTyizJgnBFlXfy0wZrXXGp7vBdUsvo3sz5UO61gYvoSishH6Qbu1Ss4Ga
         L/3xgM8iF1uTF1azirbKhglN4MFhDGoGyHyVbj/PDwB4YOXlPZqIt2L0NxfG5qx7LFIQ
         70woyJ8+DrFl3Xw+OnDabldE1/bCvwi6OMflG4FdQHJO1kcqsKoFif/Y2tJvocwdx9+t
         dZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750158; x=1772354958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PN2sy4KwpOgCvYV+YZxAOK9yTs+OHW6J8ZgmY0xzRNk=;
        b=p6wUyz4hpPAlH3VZfjB6+sLhRwgz0ircYkKIT998zgKMdkHsrKYIBogFmDQaTL/TzL
         sy1x226Lif9mJPMbngUWjgtF3dCiZKrY5Sdlq345vw4Tc48CtveBS8QJNHaqOjgxS0QU
         8JkvU/yMDcK0FsfMe8nr7bVSXVXX+ChlId0GeoKvoi1j2Y/dg6FUaWj0aNkijeV2Qy8n
         vs8SPpTar5cuSG63AwhQhLmBEKqQYvlUx2wucyhaq20oUobJSUk9VAMIlSLhWiWTsPOL
         YUUtUQiNlW5LpVSpcpNkH3mT65X3Zxk0zy61F/LlHqedl8WBalOfpP3sFEiw+sBa/3gQ
         P5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgKrk37ryqXhIOYpKNk7qLbwTfzTxPvF19qFxgT1+CYQMqdmrO3jcOl5Y2sPT7wjiZRNCXtqXZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2GTWR6+75pM/qWB1sVVZ4Runql5mQGZX/a9aPaEVJqto5bFuN
	LDQwmhc4Ew5930sFg2le3ELtNy5G9W1UdmAnBd6llubHdEgMIz3ryRr2iZWS16mrvs4=
X-Gm-Gg: AZuq6aIjoEiGbmtdZ3kzg3oE/PgxvOhaelTeq+Cijrem84gAw9xDiNz3tAC8NUdXZSg
	xpmShMqpXuB95z1M/oYhVR6T9s9Q9auqxiCUbfbzJsYA7yn5d/kvIzZf4O8QZlAN8kAbWGb5Cum
	Nb+SCITeck/DXq0rIndq78XPy13X7ZJmGtHFqeuXpicRSbM9NRnF32yP8xrMK4wLndEHFeXxcDu
	qeC1FtrMAWtjW0+5iJEY5hck7N+9pYUMwH2xtNEbPMS7S+jM5f0rnkFG0HSvj5EqUWtJ3HVTpT9
	beR3oiwQJOz/T9Eja4pXAlJ2PgopvfJvGeQjrCGvDmRWxp8whFk3Y8MhPB+RNKEhq3RArKAr5XT
	pT/cKbR2CrG5ivKoJlF2JUs7dmsYW+HBM3hnUK9t/tpYjYZmKZvOhTvRtoW7uCD6CLscMA1c0Fq
	fFN/ZfqZdAPUPLcbuxpz99kr1hT8TLwYmxqHkPqwENAYQMLZO4kydHEwUvukNDGjst9FCqY2nd1
	j2tkf5swu4asig=
X-Received: by 2002:a05:622a:201:b0:4ee:232e:4950 with SMTP id d75a77b69052e-5070bf3bb60mr62117601cf.8.1771750157802;
        Sun, 22 Feb 2026 00:49:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:16 -0800 (PST)
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
Subject: [RFC PATCH v4 06/27] mm/mlock: skip mlock for managed-memory folios
Date: Sun, 22 Feb 2026 03:48:21 -0500
Message-ID: <20260222084842.1824063-7-gourry@gourry.net>
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
	TAGGED_FROM(0.00)[bounces-14107-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gourry.net:mid,gourry.net:dkim,gourry.net:email]
X-Rspamd-Queue-Id: D186F16EAA7
X-Rspamd-Action: no action

Private node folios are managed by device drivers and should not be
mlocked.  The existing folio_is_zone_device check is already correctly
placed to handle this - simply extend it for private nodes.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/mlock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 2f699c3497a5..c56159253e45 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -25,6 +25,7 @@
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
 #include <linux/secretmem.h>
+#include <linux/node_private.h>
 
 #include "internal.h"
 
@@ -366,7 +367,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (is_huge_zero_pmd(*pmd))
 			goto out;
 		folio = pmd_folio(*pmd);
-		if (folio_is_zone_device(folio))
+		if (unlikely(folio_is_private_managed(folio)))
 			goto out;
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_folio(folio);
@@ -386,7 +387,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!pte_present(ptent))
 			continue;
 		folio = vm_normal_folio(vma, addr, ptent);
-		if (!folio || folio_is_zone_device(folio))
+		if (!folio || unlikely(folio_is_private_managed(folio)))
 			continue;
 
 		step = folio_mlock_step(folio, pte, addr, end);
-- 
2.53.0


