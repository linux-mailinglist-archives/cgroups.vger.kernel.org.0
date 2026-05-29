Return-Path: <cgroups+bounces-16419-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJisG65XGWqCvggAu9opvQ
	(envelope-from <cgroups+bounces-16419-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 11:09:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAFF5FFB36
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 11:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BE28307FE10
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 09:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8637D3BBA04;
	Fri, 29 May 2026 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oS3P7Zvb"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0683BB13F
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045681; cv=none; b=Z1j+gYN1L5YGbGSliUXn/EAWqO3BVBV0EAwye4n+IRYLIhM+EUhF6P6cKEc9sBnNqlPIxbwfT9Y6DCe0pTfVNch1IZAmHVzgYPV5ShTG/8IYKryARJY45p0vko0wOfnH6bGyRc5TOVKswA8KuPxF6srpqonm80Wc0yNtMW16IUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045681; c=relaxed/simple;
	bh=c/81EIBYKuNviJ2mRN5ZbUg3jgv+/+UIOpbxXJBbgIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEOxCfBdrDBo02ca3LbK6kxqnhPCj2SQDOKNW5M7MIjEGqqFyIuEbT0drd+hr+uJfF7ux6IC7RwN3Q1jfnNWxcx2dhrqAUNpus3901XIpyijlDIOR3TkyIas2x+AuHL1X5QlPl6EMaMpPX8ZPIfjQoAgyeZEApNo+G0WKy+7cEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oS3P7Zvb; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780045678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmJAP4aZOaxiUto1Kunt2nTEBh0r3j2YyJk3QPS9rI0=;
	b=oS3P7Zvb9AhTICkGjO+yQ/jQqCbP5ACLfglzjLNW7twk0pwEU7+q7l/BPWVJMNm/95Dhk4
	Sl6DQg1wbvzls6+JKt3ishyE1j03f7HPjHsOD3mY3IIZrXDnU+LQlHvrD44iB6fATUAjJG
	SdJsf3KEi7rrBz4KwVCR1nRJSjxNiN0=
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	cgroups@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH rdma-next v2 3/3] cgroup/rdma: update cgroup resource list for MR_MEM
Date: Fri, 29 May 2026 17:07:33 +0800
Message-ID: <20260529090733.2242822-4-cui.tao@linux.dev>
In-Reply-To: <20260529090733.2242822-1-cui.tao@linux.dev>
References: <20260529090733.2242822-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16419-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,rdma.events:url]
X-Rspamd-Queue-Id: DEAFF5FFB36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tao Cui <cuitao@kylinos.cn>

The RDMA cgroup now supports MR memory size tracking via the new
mr_mem resource.  Update the cgroup-v2 documentation to describe
the new resource and revise the usage examples accordingly.

The mr_mem resource tracks the cumulative size of memory registered
through Memory Regions per device per cgroup, providing a DMA
registration budget that is orthogonal to the existing hca_object
counter.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 Documentation/admin-guide/cgroup-v2.rst | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 993446ab66d0..08d80e6f79ec 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2766,15 +2766,16 @@ RDMA Interface Files
 
 	The following nested keys are defined.
 
-	  ==========	=============================
+	  ==========	================================================
 	  hca_handle	Maximum number of HCA Handles
 	  hca_object 	Maximum number of HCA Objects
-	  ==========	=============================
+	  mr_mem	Maximum cumulative MR memory size in bytes
+	  ==========	================================================
 
 	An example for mlx4 and ocrdma device follows::
 
-	  mlx4_0 hca_handle=2 hca_object=2000
-	  ocrdma1 hca_handle=3 hca_object=max
+	  mlx4_0 hca_handle=2 hca_object=2000 mr_mem=1073741824
+	  ocrdma1 hca_handle=3 hca_object=max mr_mem=max
 
   rdma.current
 	A read-only file that describes current resource usage.
@@ -2782,8 +2783,8 @@ RDMA Interface Files
 
 	An example for mlx4 and ocrdma device follows::
 
-	  mlx4_0 hca_handle=1 hca_object=20
-	  ocrdma1 hca_handle=1 hca_object=23
+	  mlx4_0 hca_handle=1 hca_object=20 mr_mem=1048576
+	  ocrdma1 hca_handle=1 hca_object=23 mr_mem=0
 
   rdma.peak
 	A read-only nested-keyed file that exists for all the cgroups
@@ -2792,8 +2793,8 @@ RDMA Interface Files
 
 	An example for mlx4 and ocrdma device follows::
 
-	  mlx4_0 hca_handle=1 hca_object=20
-	  ocrdma1 hca_handle=0 hca_object=23
+	  mlx4_0 hca_handle=1 hca_object=20 mr_mem=1048576
+	  ocrdma1 hca_handle=0 hca_object=23 mr_mem=0
 
   rdma.events
 	A read-only nested-keyed file which exists on non-root
@@ -2815,7 +2816,7 @@ RDMA Interface Files
 
 	An example for mlx4 device follows::
 
-	  mlx4_0 hca_handle.max=5 hca_handle.alloc_fail=3 hca_object.max=0 hca_object.alloc_fail=0
+	  mlx4_0 hca_handle.max=5 hca_handle.alloc_fail=3 hca_object.max=0 hca_object.alloc_fail=0 mr_mem.max=0 mr_mem.alloc_fail=0
 
   rdma.events.local
 	Similar to rdma.events but the fields in the file are local
@@ -2836,7 +2837,7 @@ RDMA Interface Files
 
 	An example for mlx4 device follows::
 
-	  mlx4_0 hca_handle.max=5 hca_handle.alloc_fail=0 hca_object.max=0 hca_object.alloc_fail=0
+	  mlx4_0 hca_handle.max=5 hca_handle.alloc_fail=0 hca_object.max=0 hca_object.alloc_fail=0 mr_mem.max=0 mr_mem.alloc_fail=0
 
 DMEM
 ----
-- 
2.43.0


