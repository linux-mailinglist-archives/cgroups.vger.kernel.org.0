Return-Path: <cgroups+bounces-17559-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uVa6K0HUTGrUqQEAu9opvQ
	(envelope-from <cgroups+bounces-17559-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 12:26:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 474B571A573
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 12:26:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=sYuUGfNw;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17559-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17559-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC6F9303A204
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 10:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FD93E172C;
	Tue,  7 Jul 2026 10:22:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD523E0C5C;
	Tue,  7 Jul 2026 10:22:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419760; cv=none; b=grCEqGtOivNqeX+8f7ArupcysIuhq/NY+tOsJj9MucOCYZyfiJSujr8mGfRuI+GqtJtnuCZRfd7cnkw/x5wJOoIrBD5j6/IZIC3R/C3TBsD7mq61vafTPbWHAKiPUzvDux+rQfUfVN4imJws+NWEo4rn5thS+hBBt1q4rBxiBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419760; c=relaxed/simple;
	bh=DaLe8/QXrTWscizG+dYcIkmo6WTPEu4GyF4vvjyKeyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpFcT+TpXyL4OdQgtIspY6FhHgVfBtmf5KKW0Szf+P+hvWs5awIB0tOLlmPbCAaSPKCNPEe605O4eRGr85NUDJz5iMM6RD1LghoDo3SVyXzwGRBioVME4NHfpQAUL/21W5rLPzNSjCl1THBfJugx7ip3su6PgAz1hv2rOJDhA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sYuUGfNw; arc=none smtp.client-ip=95.215.58.173
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783419757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9pYchVVq66JQF9/AQXK87a2K/GG6sLwSAaz3vkY6xc=;
	b=sYuUGfNw0ciX5Btk/+HD/kCsVAsGe0ylxo8MZopdMGjHjljF2KDR6PYR2lgZ7BqpMp7dEy
	AMX3jnhHEwDJfC/G13Krb8s/TCmhRPSUIdTC/LkiZd5IxdacIC4/hTt+SUAM2vlFOCq9cG
	MBVj9dGf4R/05IjyyZqEQu9+uLuTaOg=
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
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH 3/3] Docs/admin-guide/cgroup-v2: note blkcg_debug_stats gates io.latency stats
Date: Tue,  7 Jul 2026 18:21:48 +0800
Message-ID: <20260707102148.692250-4-guopeng.zhang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17559-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:guopeng.zhang@linux.dev,m:zhangguopeng@kylinos.cn,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,kylinos.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 474B571A573

From: Guopeng Zhang <zhangguopeng@kylinos.cn>

The io.stat section says that enabling the io.latency controller exposes
the depth, avg_lat and win stats in addition to the normal ones. However,
these io.latency-specific stats are debug stats and are only emitted when
the blkcg_debug_stats module parameter is enabled, which is disabled by
default.

Make this explicit so users do not expect these fields to appear in
io.stat by default, and qualify the usage text that suggests using
avg_lat to pick an io.latency target.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 Documentation/admin-guide/cgroup-v2.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index df3fe7a7c6b3..0df15a672cf3 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2278,10 +2278,11 @@ groups D and F will influence each other.  Group G will influence nobody::
 So the ideal way to configure this is to set io.latency in groups A, B, and C.
 Generally you do not want to set a value lower than the latency your device
 supports.  Experiment to find the value that works best for your workload.
-Start at higher than the expected latency for your device and watch the
-avg_lat value in io.stat for your workload group to get an idea of the
-latency you see during normal operation.  Use the avg_lat value as a basis for
-your real setting, setting at 10-15% higher than the value in io.stat.
+Start at higher than the expected latency for your device and, with
+blkcg_debug_stats enabled, watch the avg_lat value in io.stat for your
+workload group to get an idea of the latency you see during normal operation.
+Use the avg_lat value as a basis for your real setting, setting at 10-15%
+higher than the value in io.stat.
 
 How IO Latency Throttling Works
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -2319,7 +2320,9 @@ IO Latency Interface Files
 
   io.stat
 	If the controller is enabled you will see extra stats in io.stat in
-	addition to the normal ones.
+	addition to the normal ones.  These debug stats are only emitted when
+	the blkcg_debug_stats module parameter is enabled (it is disabled by
+	default).
 
 	  depth
 		This is the current queue depth for the group.
-- 
2.43.0


