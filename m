Return-Path: <cgroups+bounces-10636-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EB5BCC48B
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB52C3C4D8F
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461FF2773C1;
	Fri, 10 Oct 2025 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUvd7UFT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC760277004;
	Fri, 10 Oct 2025 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087712; cv=none; b=dN4W/IJomBBGEuLsCd59/PtR+qM8N3Kf1HWF9Z25nLRgH62JYCOB92d+sWmKl7+1w75KGdL1xiOlauWJoH669mPmPUh5dbpo3ymOr+/fmj+ObWqQ631PKNiRgw0rILRG+R4hV44FoBk0JHTMZAyF64HB/rXG/QNmEJhGxxTFI0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087712; c=relaxed/simple;
	bh=f5ObnNSNB2Rh3zWoq5PQH5VemgkhXP2DHUAXCReJSxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFJjena8UyCa1/uJMaOKOv/haYF31UmFX9aLNCLM7XqJlPISMZF8e5LSSJMu9NHD7yIOtMiiBZY8+eEImq9sMjrjuhlDJHdsRbnL97ftdMsm6hMJFvnSSn9gLlmJMNeLd56JQVMUg3BOvLBBMIqJ7RRXdBRwmGMu9aoVtiBt8fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUvd7UFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF31C113D0;
	Fri, 10 Oct 2025 09:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087711;
	bh=f5ObnNSNB2Rh3zWoq5PQH5VemgkhXP2DHUAXCReJSxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUvd7UFTfOp5CondiGEU+M94qZHLL4ehN141dp+doFfjf6af+VpWLY+1fLXRlL5i7
	 lLMhhSCkwvdVocBIxaajBvQP8A1sNw6mWR6H7ZXX4vb38srYbB8U2wd26k1pNdcjyS
	 gaTUT9nh8uSCEHYx9/0YdbsyjtzwFxpisdeiDpzEph015JI91UVggkLAtOzvFwz1nc
	 NJLN3yQzmfNLSMrEitSM2vx6bI+gObStReGSUFMOnEIxZ6whHV8j3hoPkDwuozpw8c
	 wH9UJ9oiT5u3QYB+HiyqcvdF+VtICLHfGdRxlLeIEgsPewlnm9jH5zqcCICOja0Jf3
	 py4OBUThlyGYw==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	tj@kernel.org,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v2 07/19] mm/page_io: don't nest queue_lock under rcu in bio_associate_blkg_from_page()
Date: Fri, 10 Oct 2025 17:14:32 +0800
Message-ID: <20251010091446.3048529-8-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010091446.3048529-1-yukuai@kernel.org>
References: <20251010091446.3048529-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

Prepare to convert protecting blkcg with blkcg_mutex instead of
queue_lock.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 mm/page_io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index a2056a5ecb13..4f4cc9370573 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -313,8 +313,13 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct folio *folio)
 
 	rcu_read_lock();
 	css = cgroup_e_css(memcg->css.cgroup, &io_cgrp_subsys);
-	bio_associate_blkg_from_css(bio, css);
+	if (!css || !css_tryget_online(css))
+		css = NULL;
 	rcu_read_unlock();
+
+	bio_associate_blkg_from_css(bio, css);
+	if (css)
+		css_put(css);
 }
 #else
 #define bio_associate_blkg_from_page(bio, folio)		do { } while (0)
-- 
2.51.0


