Return-Path: <cgroups+bounces-16545-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMrnOUpHHmomiQkAu9opvQ
	(envelope-from <cgroups+bounces-16545-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 05:00:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E5B6277E8
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 05:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F086E306FC34
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 02:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BCF360ECE;
	Tue,  2 Jun 2026 02:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jB1DHUet"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB22045AD
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368283; cv=none; b=eKWF1P83AVkpr2O0fM1QvosPhLqbhZUM1HtLYd5XZ5+Ip2C5xBP1LCMTHcdMe0Rd2zWg/qLwasAUjcm26cR0OtsG0alhfJttSvAtnC6TgLi5Qe39pPt4h4JkB90tm96ZsYp+vVIJb03aRZocilXlEvlF3VYyqsQEwELHQind/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368283; c=relaxed/simple;
	bh=mBV0Ncctp5bj+WmMhsEnyI3Q2WK5rPGq5Q/W3Pa3tsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1fQVxya2qUt87O1HzY6Ic9St1Yv2Am07S5znaz8WhGQM7KgLjgZrldTi1BPh7He/wpd0faDl+OPjr9mTAvibDvmGTlRr/Z6JOguliNDa4fXwLr98Fe5ESpN/L9MxWnCux/3SCjj40PJ7T17e1hld6zWyzZp4Oe9x01SeA3bC6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jB1DHUet; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780368281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rVWQXaLYc7CCruLkmPJVoyOQeGqAG11TqakiWkSBkTE=;
	b=jB1DHUet6BnkzHIXVAd34ERj2wcrrpJUGN5GiMNK6yp2Pth4b6QpWsMycpaNq5JxeiLhsn
	tbu4z5XXGJGuRfSfTYQASwWUooMCQIA9+PoHh972wKQEqp3qd7oEEWSEX7M7279+Q+gUiJ
	jmqREhgwFx6hMKXrEHi0zoxX8qD/rK8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-AoHsHVOBPtmzOdFH5t5nfA-1; Mon,
 01 Jun 2026 22:44:38 -0400
X-MC-Unique: AoHsHVOBPtmzOdFH5t5nfA-1
X-Mimecast-MFC-AGG-ID: AoHsHVOBPtmzOdFH5t5nfA_1780368277
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6E2F1800344;
	Tue,  2 Jun 2026 02:44:36 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.124])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4861519560A6;
	Tue,  2 Jun 2026 02:44:35 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup/cpuset: Remove Chen Ridong as a cpust reviewer for now
Date: Mon,  1 Jun 2026 22:44:22 -0400
Message-ID: <20260602024422.249458-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16545-lists,cgroups=lfdr.de];
	GREYLIST(0.00)[pass,body];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_SPAM(0.00)[0.373];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 56E5B6277E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Chen Ridong has contributed quite a lot of fixes and cleanups to the
cpuset code. Unfortunately, his email address is now no longer valid. So
remove him as a cpuset reviewer until he shows up again or someone else
volunteers to take his place.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 74c86cf9bc65..c7a7126ea406 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6526,7 +6526,6 @@ F:	include/linux/blk-cgroup.h
 
 CONTROL GROUP - CPUSET
 M:	Waiman Long <longman@redhat.com>
-R:	Chen Ridong <chenridong@huaweicloud.com>
 L:	cgroups@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
-- 
2.54.0


