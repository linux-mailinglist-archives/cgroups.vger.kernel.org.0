Return-Path: <cgroups+bounces-17461-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nwk2EyRZR2pVWgAAu9opvQ
	(envelope-from <cgroups+bounces-17461-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 08:39:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B03886FF21B
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 08:39:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=BIkuZWYJ;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=oh0MX1Fb;
	dmarc=pass (policy=reject) header.from=mailbox.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17461-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17461-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46F3A30451E5
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2026 06:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F95381B1C;
	Fri,  3 Jul 2026 06:38:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0D3806C4;
	Fri,  3 Jul 2026 06:38:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060732; cv=none; b=iVpcU8sFjyjKDFeQs8oHxsRVw4FOlAN5naFDpXjhfkBSzsclTraYWIavULIYr4i7LrMEnGdwLkP5hQOOHpPvsa2GQW0qSwrWYBO2uQzCuJzGJ5c858/E5PzxSYN+ZlfsqAwqga3dre+eilEH6kVHFrp/pSLDjESno5aXiH3u9wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060732; c=relaxed/simple;
	bh=MCFRL8G3IiFC1y+iJSbAx/VqT1lrgXRbyOmslUOD4QI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lrMBPezqFOwUYMmQTYBPgcl2ajYtzkbWTGaUNUKa4exOI4zZNn2M9HMzaCQF48dLwVSCIbUsL7mZrtZGrWReUczArrKHZhWVlLd65mVhMGTS/MwpkncaB/gzQ8wL749NnR3mSgJG0E6YCyQfytqcvMg0u4fTcOA9qP9QfW4HtUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BIkuZWYJ; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oh0MX1Fb; arc=none smtp.client-ip=80.241.56.171
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gs3xG633kz9tvC;
	Fri,  3 Jul 2026 08:38:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783060722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fOrgozTJMjn4rnfORWTzUhBrhJUbQ04jzVOms79twA8=;
	b=BIkuZWYJYWBx7iUYhfpzSFXjQD+U/od29GDxLdr7oky2VZSDQ/ZMuLEEsgAzj7SbK11MH/
	EXGZ3PE7Woh4EXlHOz6UoitcLunH81JmsZPUJAyDNyWbzpc00LGs1JRfGRNdzwyOPvJYCG
	WFq4Tfn2tzMRFVHYKG84n0zktwaKb247rOFZXqtJIiXQJjvZ+UgS2Lk9bHlCF6rR+grJ+x
	6C9F6zwZ/tmuqe2LyFAUbiJIS1D2TPRDsvOBk2NMMW1xSpaV8oqplAIneyc8dgrQCe71D9
	MdPzxTSovkLArAlFLN3wMvtJXJ69aZukLletVVNuzLvAlNXyJvtXttDMnC1SAA==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783060721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fOrgozTJMjn4rnfORWTzUhBrhJUbQ04jzVOms79twA8=;
	b=oh0MX1Fbpd6Ik9QucBv8+3vbQyn15Ib1nryU5b1BJpofP58HQ63X5Qp/JX1DSuyFEJKQKo
	pVyGO1Uj9Xh1g8s8uTHZYN0DjkLbjiREKsIfxrp8MpLBnQXWbCgGGJCKn83AJYk7S4cBHo
	CQct+o/wk1etoS4S8X51rG6B9jWt2f+wyVYj7tBgjTvOejIc+huCX95l26GNardMjpkmJY
	fJgFMKg3JIqJOal7m/DOEYir7UEd1JfkG2Ab7FK5uSiADweiMb12Bzi0SJhQshnxdlPk/W
	IetlBapndJoyTme+aZTtwfk969NPASZKGDhOlj7e+txGmuQgV09wz6Aa4r26pQ==
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	Manuel Ebner <manuelebner@mailbox.org>
Subject: [PATCH] docs: cgroup: Fix bracket
Date: Fri,  3 Jul 2026 08:38:05 +0200
Message-ID: <20260703063805.219517-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: z3jpxezsq364x6an79ecobauiz7dpphq
X-MBO-RS-ID: 52e40322ae47065f32b
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17461-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailbox.org:from_mime,mailbox.org:email,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B03886FF21B

Remove single ')'.

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---
 Documentation/admin-guide/cgroup-v1/memcg_test.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memcg_test.rst b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
index ebedbc3c3f9c..d9951c319ef5 100644
--- a/Documentation/admin-guide/cgroup-v1/memcg_test.rst
+++ b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
@@ -10,7 +10,7 @@ Because VM is getting complex (one of reasons is memcg...), memcg's behavior
 is complex. This is a document for memcg's internal behavior.
 Please note that implementation details can be changed.
 
-(*) Topics on API should be in Documentation/admin-guide/cgroup-v1/memory.rst)
+(*) Topics on API should be in Documentation/admin-guide/cgroup-v1/memory.rst
 
 0. How to record usage ?
 ========================
-- 
2.54.0


