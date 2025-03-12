Return-Path: <cgroups+bounces-6999-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D87FA5D388
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 01:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1F43B95F4
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 00:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1EC35948;
	Wed, 12 Mar 2025 00:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVQGlp5X"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D07E288D2
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738082; cv=none; b=Hj/MkK+bk1vlZoPxcXA7z5ZCxqIZ4NRqKM3QG5Jy+2b5/5CdJqzeVp+Q8RUPDv5y8NHru+3U682S4BQb8GzIh9RERW8EFUOwhuZSVb/QOIxXxVn7VATz8QWEEaqgBP4BEIInkgF9f3bILE8J/No59RehLuOcf/JrcKvVkRtHqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738082; c=relaxed/simple;
	bh=AzqFum6Agw13RjN3Fu1tKvuI6gP3XBpPLw2tmwLYzUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tD15pDxOZ19YlU81+4oF9/LkKdHjtgDqJsbCRAriz5yV9Pf8/TrsoPS1k197ky/UKLUAnsw+kp9l6hio/0hdKWnVSz63A9gXjgB2HG+pFNa/we7ucrfbgzBB5DdtbDKSvRLjuYyKO4M29hyUOWvVXjdIqsdjKV0mgd0wz7xppoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVQGlp5X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741738080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPsYu1/Zt9JxInUUfAbvJhaRjTUPwV0c8VAQrmxs/V8=;
	b=eVQGlp5XGM0iusurSHlz5VyY7zoPlxr+F8TfNsMxndeChKGgGVi2TT442dZozPBfqQ1A+z
	MgLvFYV6Csol4sTVNLEQtk3ucS5P+XpNuWzAfxxF8fOYs7zwYSFYLl++zk8yxVsaEQE/QE
	3Cgycjs7+TgbNJ37zZauv+NuAceWIFo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-DsGHc5fiN22ggfCluAAvjA-1; Tue,
 11 Mar 2025 20:07:56 -0400
X-MC-Unique: DsGHc5fiN22ggfCluAAvjA-1
X-Mimecast-MFC-AGG-ID: DsGHc5fiN22ggfCluAAvjA_1741738073
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58D9B1955BC1;
	Wed, 12 Mar 2025 00:07:53 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.56])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91DF71955DDD;
	Wed, 12 Mar 2025 00:07:46 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	mst@redhat.com,
	david@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com,
	alexander.atanasov@virtuozzo.com
Subject: [RFC 3/5] hv_balloon: update the NR_BALLOON_PAGES state
Date: Tue, 11 Mar 2025 18:06:58 -0600
Message-ID: <20250312000700.184573-4-npache@redhat.com>
In-Reply-To: <20250312000700.184573-1-npache@redhat.com>
References: <20250312000700.184573-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Update the NR_BALLOON_PAGES counter when pages are added to or
removed from the Hyper-V balloon.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 drivers/hv/hv_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index fec2f18679e3..2b4080e51f97 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1192,6 +1192,7 @@ static void free_balloon_pages(struct hv_dynmem_device *dm,
 		__ClearPageOffline(pg);
 		__free_page(pg);
 		dm->num_pages_ballooned--;
+		mod_node_page_state(page_pgdat(pg), NR_BALLOON_PAGES, -1);
 		adjust_managed_page_count(pg, 1);
 	}
 }
@@ -1221,6 +1222,7 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
 			return i * alloc_unit;
 
 		dm->num_pages_ballooned += alloc_unit;
+		mod_node_page_state(page_pgdat(pg), NR_BALLOON_PAGES, alloc_unit);
 
 		/*
 		 * If we allocatted 2M pages; split them so we
-- 
2.48.1


