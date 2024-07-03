Return-Path: <cgroups+bounces-3528-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED94C9268A6
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 20:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88F83B24EC8
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 18:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9581891DC;
	Wed,  3 Jul 2024 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTdlLkl7"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1909188CD3
	for <cgroups@vger.kernel.org>; Wed,  3 Jul 2024 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720032768; cv=none; b=AWyQFa7ONsW8ny+27vlupcJKI0IvILnQL/Sbw1+h/V0FJjno2y0yYziF/NH8tJRs1wUPyl+A71nvOL0wnKPIUooyKgy+W1G+GRDzAgHCPn6+0qUHnlWmm3FiIU13/Gep+70Bzt3ZtKxpTyVoMDBV0//bdr6+2iB43J92q4lyYwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720032768; c=relaxed/simple;
	bh=nC4pF2dDJtE0z7GMPFXks2mAm01oErvd3B+jorED32c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SV2ermA5nSwVEnUoxfos0AYzWSZbd/7D9tz/mHfkqb5tnsPKkyucnyPzdI/20iZHgs/7am0REjQPsbuJrzQbYmt/zHCgRl3fC+OYxb049HrEXJFzTVmIGuAJ6p8+lZmMQ6oSr8ApOcJaBxhR62WN0G1H1nUeuZpHmUfw43RKrpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTdlLkl7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720032765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1JfQRXvykBxI0RLs6DOfqQW6hwbzPvCYWb+yNAuMeO8=;
	b=XTdlLkl7sRmspUDu7CZsZzoufTQ3SCc1ONWwsNL/3Fs5SKGf5GGhcaPSBSJrFy6rD1PKQb
	FxpLey1tlS5CYi9eiosArVGyTnVBGjx73XeYDXEdtgpgWZh8+srP+dIOVfsthgx4VhoPtu
	QlF2x2+ihm1ldeb3IU92AC5475NWgmE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-umOyin8RNW66VrNeYeXLgw-1; Wed,
 03 Jul 2024 14:52:41 -0400
X-MC-Unique: umOyin8RNW66VrNeYeXLgw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 131A51955BCB;
	Wed,  3 Jul 2024 18:52:40 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.252])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 152F330000DD;
	Wed,  3 Jul 2024 18:52:37 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup: Protect css->cgroup write under css_set_lock
Date: Wed,  3 Jul 2024 14:52:29 -0400
Message-Id: <20240703185229.1849423-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The writing of css->cgroup associated with the cgroup root in
rebind_subsystems() is currently protected only by cgroup_mutex.
However, the reading of css->cgroup in both proc_cpuset_show() and
proc_cgroup_show() is protected just by css_set_lock. That makes the
readers susceptible to racing problems like data tearing or caching.
It is also a problem that can be reported by KCSAN.

This can be fixed by using READ_ONCE() and WRITE_ONCE() to access
css->cgroup. Alternatively, the writing of css->cgroup can be moved
under css_set_lock as well which is done by this patch.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ff3c14fa62e6..c8e4b62b436a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1842,9 +1842,9 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		RCU_INIT_POINTER(scgrp->subsys[ssid], NULL);
 		rcu_assign_pointer(dcgrp->subsys[ssid], css);
 		ss->root = dst_root;
-		css->cgroup = dcgrp;
 
 		spin_lock_irq(&css_set_lock);
+		css->cgroup = dcgrp;
 		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
 		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
 					 e_cset_node[ss->id]) {
-- 
2.39.3


