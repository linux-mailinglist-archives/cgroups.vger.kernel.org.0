Return-Path: <cgroups+bounces-7762-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5380CA99AED
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 23:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68FB81B82F3B
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500C91F8743;
	Wed, 23 Apr 2025 21:44:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B746447
	for <cgroups@vger.kernel.org>; Wed, 23 Apr 2025 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745444688; cv=none; b=GXlnJxhznTXddk8OxLfdGXJdDrVATXLfu+SwQazRLsK1W6rdkP31MFbykMZdaRRjyDd5GFQ7up6rpH7kCbVd1r1JmVaHKdIttBQ2TUXjB8sR9lBDf2G3s96RAJJhtV+grz7aipgVi+9w7LIp4WxVpLtEKpUrGEa0LG1NoxIbL7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745444688; c=relaxed/simple;
	bh=jxLscFll5ou80mA0BMFJvzDQZALjQF4EPl/6IaallLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=d+AyjXMd9dl0UaEjDJqdsua1SVDSXvZXJs0RCslD5mP6t3IZXq5GBLmc6XcYMdWSvoAW7krarkBxFITWdfZnlRklWCgZu3T0O47QlzjuuwsGMTaFLtwwffFEHzw8Zxg7LkgeNjwDnfW0T/Wj6ZzJjQCCjiffXi11P0SUhrACZME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-NCx2YT8_M9m2dr-sRLWJhA-1; Wed,
 23 Apr 2025 17:43:35 -0400
X-MC-Unique: NCx2YT8_M9m2dr-sRLWJhA-1
X-Mimecast-MFC-AGG-ID: NCx2YT8_M9m2dr-sRLWJhA_1745444614
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 249F41800368;
	Wed, 23 Apr 2025 21:43:34 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.64.136.98])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF83B19560A3;
	Wed, 23 Apr 2025 21:43:31 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org,
	tj@kernel.org,
	christian.koenig@amd.com
Cc: cgroups@vger.kernel.org
Subject: [PATCH 2/5] memcg: export stat change function
Date: Thu, 24 Apr 2025 07:37:04 +1000
Message-ID: <20250423214321.100440-3-airlied@gmail.com>
In-Reply-To: <20250423214321.100440-1-airlied@gmail.com>
References: <20250423214321.100440-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2r27G9b78CaxDwpuatQDv-sGnWiWffzSpb8BMNNrHB0_1745444614
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

From: Dave Airlie <airlied@redhat.com>

In order for modular GPU memory mgmt TTM to adjust the GPU
statistic we need to export the stat change functionality.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 25471a0fd0be..68b23a03d2a6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -709,6 +709,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum m=
emcg_stat_item idx,
 =09memcg_rstat_updated(memcg, val);
 =09trace_mod_memcg_state(memcg, idx, val);
 }
+EXPORT_SYMBOL_GPL(__mod_memcg_state);
=20
 #ifdef CONFIG_MEMCG_V1
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
--=20
2.49.0


