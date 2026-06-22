Return-Path: <cgroups+bounces-17138-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e9E9EJIXOWrSmgcAu9opvQ
	(envelope-from <cgroups+bounces-17138-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 13:08:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 395EF6AEF2C
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 13:08:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=xMzAngPa;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17138-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17138-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97052300B8FA
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 11:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F1D379EE8;
	Mon, 22 Jun 2026 11:07:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E6379EC1
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 11:07:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782126459; cv=none; b=fpzjFOyNHPaVVpbMySeT3JwAVOszph4k6soTA+mu1cAWZz4nLNPTqwF4/LIUV7DtkX/M8WgtZLlzl6uNJ3dPxH5DC4Vd1A5MD84k5kjqED65DBISlTYuCOj+Dpnp+neYYtiylCWBeHul3kTXAZDeEHqN5wIOetI5PgRqvxZ9iDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782126459; c=relaxed/simple;
	bh=6DrBo8HhCAFr4ixdaoPdbufVc3tmI+R4bk3nuxCXq40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dSkV9MIph53UFn5AaXXvSQqMC5dXk/mAmsusN1LiZ65Irp2LLUW35jVclUSvYcW1kPkHDmmGqKrYRqmJ9sbf9XblYRFPFrIR8+H4clPBziRTRE8AdcCcyaQ9k1E2JGD5VaEa46tiUzqZoFjU2OJ0r4qC6jbO42Hw1aUMk9gMGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xMzAngPa; arc=none smtp.client-ip=91.218.175.188
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782126446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J9tbcbEHAxEd0cLxohalzyjnZY/gZNSsc7sVRvTS3pQ=;
	b=xMzAngPaPeLLYnhq6fRhNG1YbzHxLoNIYijtry6bEuY0M4u+wKlLTV6cu4+H2/wym0E2gj
	60qrLoUwjXhxeXNKzCil2lbxvLoSlW2nU1Q6DaJks3kBaFF4g0tnEFhpJSBlz5E6e72JzB
	2W5ViYICij4Bz6Ye+o5u/HlnhKrS/0Y=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	"Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
Subject: [PATCH] cgroup: Fix a typo of the function name in comment
Date: Mon, 22 Jun 2026 19:07:08 +0800
Message-ID: <20260622110708.15593-1-zenghui.yu@linux.dev>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17138-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:zenghui.yu@linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zenghui.yu@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghui.yu@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 395EF6AEF2C

From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>

... which was wrongly written as cgroup_threadcgroup_change_begin().

Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
---
 include/linux/cgroup-defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index de2cd6238c2a..7a631a257613 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -896,7 +896,7 @@ static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
  * cgroup_threadgroup_change_end - threadgroup exclusion for cgroups
  * @tsk: target task
  *
- * Counterpart of cgroup_threadcgroup_change_begin().
+ * Counterpart of cgroup_threadgroup_change_begin().
  */
 static inline void cgroup_threadgroup_change_end(struct task_struct *tsk)
 {
-- 
2.53.0


