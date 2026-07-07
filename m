Return-Path: <cgroups+bounces-17558-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LcezI+nVTGpZqgEAu9opvQ
	(envelope-from <cgroups+bounces-17558-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 12:33:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4871D71A6DD
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 12:33:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=VSb1WFL6;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17558-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17558-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73D3430509A7
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 10:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE163E5A09;
	Tue,  7 Jul 2026 10:22:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AE83E0C6F
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 10:22:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419753; cv=none; b=tCsz5eh5pzOTcNzoevwq7P5CaCc7cFG85e1ahPQiSg1X69LAO/5hcAtqC20KyuJiyacb+2Px7/2PAzuGXjec2l+jTNOdJctunu9Wri3Mx1y9rEI7R4LFu4fSPUogZ1BogRskRVyEr92EtglXLJQW4tXmTM0zDAOgpkTzoyJqe6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419753; c=relaxed/simple;
	bh=UJF90wddtURlNpPrITFUw9JAfusR4oacQc6J31ypKQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuoagUK/0QroYkkhM0fUvgbrehmsLEOXIuBdeUhdZTGO2tZL+pQTdq1cj/zztz3gnzGz97aNRJGYTdKnPVGbUwmet0SwK6KuBBr91Q43ZcuYqV7G5T2cBsy/MIYgk7COvmGmosB2LueZteXW2dWPjoGH/moeYBfm9hB4YxfjX+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VSb1WFL6; arc=none smtp.client-ip=95.215.58.189
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783419750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7B5Q6YmLzumcR7aPGfA8TNRl7ZAeq3JFkw4iMkiANt0=;
	b=VSb1WFL6QsqGOfl4+Laf4i58FTffkj+APB4D8fSa7e11411eb8RR0+SFv16xYI9vmUiDPz
	zk8zlyl8v43lvafY2pK7lzT8isUTieDsPahuRZm/zg8o3NADuA4u10+IqjMYcFi6TRUs+z
	dkobEnqbDCalhEdHW1Al3YitgqaK1h0=
From: Guopeng Zhang <guopeng.zhang@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Guopeng Zhang <zhangguopeng@kylinos.cn>,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 2/3] Docs/admin-guide/cgroup-v1: document rdma.peak, rdma.events and rdma.events.local
Date: Tue,  7 Jul 2026 18:21:47 +0800
Message-ID: <20260707102148.692250-3-guopeng.zhang@linux.dev>
In-Reply-To: <20260707102148.692250-1-guopeng.zhang@linux.dev>
References: <20260707102148.692250-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17558-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:guopeng.zhang@linux.dev,m:zhangguopeng@kylinos.cn,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email,rdma.events:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4871D71A6DD

From: Guopeng Zhang <zhangguopeng@kylinos.cn>

The v1 RDMA controller documentation only describes rdma.max and
rdma.current, but the controller exposes three more files -- rdma.peak,
rdma.events and rdma.events.local -- which are already documented for
v2. Mirror the v2 wording so the v1 documentation matches the files
actually visible on a v1 mount.

Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 Documentation/admin-guide/cgroup-v1/rdma.rst | 66 ++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v1/rdma.rst b/Documentation/admin-guide/cgroup-v1/rdma.rst
index e69369b7252e..abddf34d2667 100644
--- a/Documentation/admin-guide/cgroup-v1/rdma.rst
+++ b/Documentation/admin-guide/cgroup-v1/rdma.rst
@@ -9,6 +9,7 @@ RDMA Controller
      1-2. Why RDMA controller needed?
      1-3. How is RDMA controller implemented?
    2. Usage Examples
+   3. RDMA Interface Files
 
 1. Overview
 ===========
@@ -115,3 +116,68 @@ Following resources can be accounted by rdma controller.
 (d) Delete resource limit::
 
 	echo mlx4_0 hca_handle=max hca_object=max > /sys/fs/cgroup/rdma/1/rdma.max
+
+3. RDMA Interface Files
+========================
+
+The following interface files are available in each non-root RDMA cgroup.
+
+  rdma.max
+	A read-write file which describes the configured resource limit
+	for an RDMA/IB device.  See the Usage Examples above.
+
+  rdma.current
+	A read-only file which describes the current resource usage.
+
+  rdma.peak
+	A read-only nested-keyed file which shows the historical high
+	watermark of resource usage per device since the cgroup was created.
+
+	An example for mlx4 and ocrdma device follows::
+
+	  mlx4_0 hca_handle=1 hca_object=20
+	  ocrdma1 hca_handle=0 hca_object=23
+
+  rdma.events
+	A read-only nested-keyed file which exists on non-root cgroups
+	and contains the following keys:
+
+	  max
+		The number of times a process in this cgroup or its
+		descendants attempted an RDMA resource allocation that
+		was rejected because a rdma.max limit in the subtree
+		was reached.  This is a hierarchical counter propagated
+		upward to all ancestor cgroups.  A value change in this
+		file generates a file modified event.
+
+	  alloc_fail
+		The number of RDMA resource allocation attempts that
+		originated in this cgroup or its descendants and failed
+		due to a rdma.max limit being reached.  This is a
+		hierarchical counter propagated upward.
+
+	An example for mlx4 device follows::
+
+	  mlx4_0 hca_handle.max=5 hca_handle.alloc_fail=3 hca_object.max=0 hca_object.alloc_fail=0
+
+  rdma.events.local
+	Similar to rdma.events but the fields are local to the cgroup,
+	i.e. not hierarchical.  The file modified event generated on this
+	file reflects only the local events.
+
+	The following nested keys are defined.
+
+	  max
+		The number of times a process in this cgroup or its
+		descendants attempted an RDMA resource allocation that
+		was rejected because this cgroup's own rdma.max limit
+		was reached.
+
+	  alloc_fail
+		The number of RDMA resource allocation attempts
+		originating from this cgroup that failed due to this
+		cgroup's or an ancestor's rdma.max limit.
+
+	An example for mlx4 device follows::
+
+	  mlx4_0 hca_handle.max=5 hca_handle.alloc_fail=0 hca_object.max=0 hca_object.alloc_fail=0
-- 
2.43.0


