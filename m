Return-Path: <cgroups+bounces-13165-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 411F6D1C8A3
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 06:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AE5930D9762
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 04:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F157C3033D6;
	Wed, 14 Jan 2026 04:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHU3m4zX"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131B82EDD6C
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768366513; cv=none; b=M8vrEE9bsp3GKsQikrHFXeYQpNNJNvbTzD4CuSRSXIbucHzjTIlvejh0bBMg4/1VLfCsBv1/TZuUxptbAGS5hKDORJR2/xigjd8KJE99aToQdR2ErLBmiIRWiGJJ2lg/M9vC+46XemZbyGrIAVbSTGLZ01QeghdDd2ox/0xJ2qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768366513; c=relaxed/simple;
	bh=1sQCSjB2XGPVHIuJFAe2p/xRmT6QiXINc2LLjMl3wDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXmwFsrRkK3OqwBGx8Fi0e4xoli8MtVLtg8urpqZuMWzKt0bSq5gwUUtVls2YwN0XGn1QubdsbWPjSjgdhdS7xqM4wkB7ighVvfscT5hIf17SjCwksGr4sOM0cR2h878PaXuXqA4OU6sr102WGS6sNS40d2xZ0VWPdAVuF3I7PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHU3m4zX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768366497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vZhNYDAcP03LpjC3uL+OmkGZM2idhgQrCOgoJvnLqUM=;
	b=XHU3m4zXCQ1VnTrpp9tjdJnSeO2vtZZ5KqFnLrMoX8nonJdgGNVikLsbTV1tAFjWBRcw6M
	4ciWbcCqGFFHe1RLHqe43DGPGhwCGHW6dOQgAPnN4GZ2+OcZ1U8ZjcyXROIZTuvamxSTfq
	4A1DIEXI+m+KT6bv6fG7jHGvIikveYg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-xSoRr3T1PNq0C7kw1YvF2w-1; Tue,
 13 Jan 2026 23:54:54 -0500
X-MC-Unique: xSoRr3T1PNq0C7kw1YvF2w-1
X-Mimecast-MFC-AGG-ID: xSoRr3T1PNq0C7kw1YvF2w_1768366493
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF58B1956095;
	Wed, 14 Jan 2026 04:54:52 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.224])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8EA3E1800665;
	Wed, 14 Jan 2026 04:54:51 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Chen Ridong <chenridong@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] MAINTAINERS: Add Chen Ridong as cpuset reviewer
Date: Tue, 13 Jan 2026 23:54:35 -0500
Message-ID: <20260114045435.655951-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add Chen Ridong as a reviewer for the cpuset cgroup subsystem.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d701a4d5b00e..9c79da17b438 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6402,6 +6402,7 @@ F:	include/linux/blk-cgroup.h
 
 CONTROL GROUP - CPUSET
 M:	Waiman Long <longman@redhat.com>
+R:	Chen Ridong <chenridong@huaweicloud.com>
 L:	cgroups@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
-- 
2.52.0


