Return-Path: <cgroups+bounces-17758-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pPI8OsvYVWoguQAAu9opvQ
	(envelope-from <cgroups+bounces-17758-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 08:35:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D649751880
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 08:35:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="amP95k/X";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17758-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17758-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 525CE302D4DF
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 06:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE34D3DB310;
	Tue, 14 Jul 2026 06:33:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000AE37A488
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 06:33:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010797; cv=none; b=hT2sZepN5p3OFD7KvjM+7kUeBXt/zfeTE4LRRTvvvMvQXqRWrbhKr9eR7EWmYl9NDNmw2PndETb/0OUZyBFz9bXQMRAgtBlsT3t1cuVkFR72JCyiz1R0+J86p6kCzaL4NyVT8CQJc1hoUxMh5KXfnJUeqYyNRCCa+9fh0OVnp2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010797; c=relaxed/simple;
	bh=MQ8pRU04Bz4GVmPze8vLLbemoEXmUOyh/n86eVxe6kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/7wMITCUL3Sigil7VUgvI6gE/84SDViwhFb06eEZiwJ18PMH4gxfs4Kr8BH/0YviQJ1+IW/3Jr7iEoeB1pfCdUSeFtqAZ3efdWj2sk2ey30WJwjlu/lb4jS91DULTXCjMSmsfqCknD1RGLqzajE+y1NTrJ6wj/RCIyUFDxLbEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=amP95k/X; arc=none smtp.client-ip=91.218.175.179
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784010794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l/KKjCP+P1nO+lHds4QdIg+RSxDUWU9CI5yqZPqSfLM=;
	b=amP95k/XumsDBBNpj4rDE3XOde0j6jX19YX3Y5ypgnznYybUTLckvSr5YYgdbYyUJfNbB+
	+wLB0IJE6JB1fLUiHc0M7NSOfyyMJWwyuECMJ3xOahO4p0iCzvqiGRT6dOHQxNtADwhG/X
	kHtGeE6uMCGeKZ+aShWo7TwK9mO1LAQ=
From: Tao Cui <cui.tao@linux.dev>
To: axboe@kernel.dk
Cc: tj@kernel.org,
	josef@toxicpanda.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] blk-cgroup: show io.stat numbers for discard-only cgroups
Date: Tue, 14 Jul 2026 14:33:02 +0800
Message-ID: <20260714063302.1153238-1-cui.tao@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17758-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D649751880

From: Tao Cui <cuitao@kylinos.cn>

blkcg_print_one_stat() gates the rbytes/wbytes/rios/wios/dbytes/dios
output on

    if (rbytes || wbytes || rios || wios)

which omits the discard counters.  A cgroup that has issued only discards
(zero read and write counters) therefore prints an empty stat line and its
dbytes/dios are never surfaced, even though they are accounted correctly.

The guard predates the addition of discard stats and was never updated;
include dbytes/dios so discard-only cgroups are reported.

Fixes: 636620b66d5d ("blkcg: Track DISCARD statistics and output them in cgroup io.stat")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a778aa9d2bb9..b324701cb05d 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1154,7 +1154,7 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 		dios = bis->cur.ios[BLKG_IOSTAT_DISCARD];
 	} while (u64_stats_fetch_retry(&bis->sync, seq));
 
-	if (rbytes || wbytes || rios || wios) {
+	if (rbytes || wbytes || rios || wios || dbytes || dios) {
 		seq_printf(s, "rbytes=%llu wbytes=%llu rios=%llu wios=%llu dbytes=%llu dios=%llu",
 			rbytes, wbytes, rios, wios,
 			dbytes, dios);
-- 
2.43.0


