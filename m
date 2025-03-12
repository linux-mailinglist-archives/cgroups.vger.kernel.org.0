Return-Path: <cgroups+bounces-7000-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA953A5D38C
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 01:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B066189CC3C
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 00:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173625474C;
	Wed, 12 Mar 2025 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXShS7GV"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594B79476
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738091; cv=none; b=NDzeLqgHpMsz2Ss16mct/yXCLO5h8V2CGD5gYwqfO7rNpz1teE7dkkXn4EoOpaLs5rV23dgLW8f4zS6eBY5OPFKekzhhmt+DwU2rD1xzKrypj/DdgRVhKc8mGZKtjix21HdylsN7DePBrArVIv5QczZQOpn6brWwyC4Mj2oCUYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738091; c=relaxed/simple;
	bh=d/9U3Hs56MfO9ZDfHXmWmno1K8O1u1XuJHmhdH2F0w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtNI2FMNlRqyYm3Q/IOQcSuOqONKbQqal9vEHm4yzMUTaYM+a6DbWVQ8n58SSuMJ/pMUCFkyzv/oZSvHu7z0MJVNSwPsvFq8Dd617oOwftk9XW5kTEKJ0toZf4W7vZxayIq7dZGyO/o2SoXn/0F3DMKeNle1cJIs/WLv+lNHCu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXShS7GV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741738089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2Hs8hV+/gJc3OfaS9x8cWsCD/xR9fjklu355DFl/Jo=;
	b=iXShS7GVYv6TRmTkB6HBlHNZG7lr8eB2c0n4tiRfHZrszsyHExRLfVgwJRUNxa7du6gkxL
	wQnBK6p676ETUPn2mII/WYN1NtCSLJotHsApIydJ2xQwZpAbAk199nPzLbVwOlynvNRi3C
	K3Gr97zgTJU+S3AC56m6+FBrU8XS63Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-hcKnUj3kOH-9CB9AP-czdw-1; Tue,
 11 Mar 2025 20:08:04 -0400
X-MC-Unique: hcKnUj3kOH-9CB9AP-czdw-1
X-Mimecast-MFC-AGG-ID: hcKnUj3kOH-9CB9AP-czdw_1741738080
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 629D51800259;
	Wed, 12 Mar 2025 00:08:00 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.56])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 989161956094;
	Wed, 12 Mar 2025 00:07:53 +0000 (UTC)
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
Subject: [RFC 4/5] vmx_balloon: update the NR_BALLOON_PAGES state
Date: Tue, 11 Mar 2025 18:06:59 -0600
Message-ID: <20250312000700.184573-5-npache@redhat.com>
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
removed from the VMware balloon.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 drivers/misc/vmw_balloon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index c817d8c21641..2c70b08c6fb3 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -673,6 +673,8 @@ static int vmballoon_alloc_page_list(struct vmballoon *b,
 
 			vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
 						 ctl->page_size);
+			mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
+				vmballoon_page_in_frames(ctl->page_size));
 		}
 
 		if (page) {
@@ -915,6 +917,8 @@ static void vmballoon_release_page_list(struct list_head *page_list,
 	list_for_each_entry_safe(page, tmp, page_list, lru) {
 		list_del(&page->lru);
 		__free_pages(page, vmballoon_page_order(page_size));
+		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
+			-vmballoon_page_in_frames(page_size));
 	}
 
 	if (n_pages)
@@ -1129,7 +1133,6 @@ static void vmballoon_inflate(struct vmballoon *b)
 
 		/* Update the balloon size */
 		atomic64_add(ctl.n_pages * page_in_frames, &b->size);
-
 		vmballoon_enqueue_page_list(b, &ctl.pages, &ctl.n_pages,
 					    ctl.page_size);
 
-- 
2.48.1


