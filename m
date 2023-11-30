Return-Path: <cgroups+bounces-743-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8209D7FFCF5
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 21:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9641F21103
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 20:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79F355C28;
	Thu, 30 Nov 2023 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXxqmv8l"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ECF1724
	for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701377031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlJxse7VR/q1n51PSliVgyIuHZ/VI5Kr3VkztHHMLrk=;
	b=bXxqmv8l70K3nU4nDqgw9bwL1kRjSKWPbPQBaIe+wLwXpnP7GZ3agVbSC2wP61w/joKV30
	p724bZaMBvsDUXxcE2+UbjUVBFTc2J3xX//eN84QypDU47EpEpu8MwS4Sxqwc7kv0KrO8m
	TeSbK1g/+Bf0ceSL9HH2g3N9vC1wUoE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-iFhoK-N_OQq3aTIK0XPlnA-1; Thu, 30 Nov 2023 15:43:45 -0500
X-MC-Unique: iFhoK-N_OQq3aTIK0XPlnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8020185A785;
	Thu, 30 Nov 2023 20:43:44 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.192])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3269E40C6EB9;
	Thu, 30 Nov 2023 20:43:44 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Mario <jmario@redhat.com>,
	Sebastian Jug <sejug@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v5 2/2] cgroup: Avoid false cacheline sharing of read mostly rstat_cpu
Date: Thu, 30 Nov 2023 15:43:27 -0500
Message-Id: <20231130204327.494249-3-longman@redhat.com>
In-Reply-To: <20231130204327.494249-1-longman@redhat.com>
References: <20231130204327.494249-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

The rstat_cpu and also rstat_css_list of the cgroup structure are read
mostly variables. However, they may share the same cacheline as the
subsequent rstat_flush_next and *bstat variables which can be updated
frequently.  That will slow down the cgroup_rstat_cpu() call which is
called pretty frequently in the rstat code. Add a CACHELINE_PADDING()
line in between them to avoid false cacheline sharing.

A parallel kernel build on a 2-socket x86-64 server is used as the
benchmarking tool for measuring the lock hold time. Below were the lock
hold time frequency distribution before and after the patch:

      Run time        Before patch       After patch
      --------        ------------       -----------
       0-01 us         9,928,562          9,820,428
      01-05 us           110,151             50,935
      05-10 us               270                 93
      10-15 us               273                146
      15-20 us               135                 76
      20-25 us                 0                  2
      25-30 us                 1                  0

It can be seen that the patch further pushes the lock hold time towards
the lower end.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cgroup-defs.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 37518436cfe7..5a97ea95b564 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -496,6 +496,13 @@ struct cgroup {
 	struct cgroup_rstat_cpu __percpu *rstat_cpu;
 	struct list_head rstat_css_list;
 
+	/*
+	 * Add padding to separate the read mostly rstat_cpu and
+	 * rstat_css_list into a different cacheline from the following
+	 * rstat_flush_next and *bstat fields which can have frequent updates.
+	 */
+	CACHELINE_PADDING(_pad_);
+
 	/*
 	 * A singly-linked list of cgroup structures to be rstat flushed.
 	 * This is a scratch field to be used exclusively by
-- 
2.39.3


