Return-Path: <cgroups+bounces-15746-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGfHEgrHAWqSjgEAu9opvQ
	(envelope-from <cgroups+bounces-15746-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:09:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB8750D5D7
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CFD6306B4CE
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D40381AFD;
	Mon, 11 May 2026 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SGq+qh56"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D7837AA70;
	Mon, 11 May 2026 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501242; cv=none; b=AIJ+5efFbIq9+ac87dC1B4WAjcRLFUO736o2AyBLPxuLtG16SrFbVtHnWS6ficiq2JgjU487fOkFFwt/zMkCCwotXS4oQIUjUrfk7SSRqEk37dJfii8tKL/KZ3r2k93uZr1lZdlPwKMhpQTl0YoVihBIoHWJx2sf14qDi9Ui1J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501242; c=relaxed/simple;
	bh=3F100iP4pB5ahm0qxWq2S4gYcxguC9KnpbuH61KE3D0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EtuAOjMU0MwZbD1d3alw0ED9nps5M4ta0T6HpjdjZk8k4G/gZIWKNTaur82m+rr63MDEWcrADtzR3m1xwHoH+4dr3Lhcc7ujsy1V0hWV04TPZaWnphW4AHFGG8YDlBmqH95S/6Gs3VrcdlOhgBOiS0U9t/g70sJmnj6hHiJ9kdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SGq+qh56; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Li2IzmyteveydDL/ki4+K6/ktKsKujM5ayLTcdkUL+E=; b=SGq+qh56Jd1CUfUh4TSQv1PUGi
	OkcI/W8uyxq1j9sD2kbPv1J0zKv0TZjZnxH68we/feuSu/161TTdmflEqUeBGuww7t3bUpr+0ejUX
	wkc3wtxrpNnGstHjKwZvAmunqcPlJVPpgABPBmDoGFUN3NYEiIhTmM8CSCA9YREn3vjF4NEVeXKbT
	1j9Iq9FLOhJ9/4SOch/uLGKXdGEL8Qt0keqVIdoeZgjMsPFaGUvXkQaCesX5CaUboNV5CbgJB9fr5
	WU/VZajEK84BC5Ujp4KSohLO83VOv3RB+vCek6v1X9zrN50Hn5KXA0esYWXBp3zbhP0a1WWl3My4D
	Vw5HcT+g==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPPZ-000000088m0-2Slj;
	Mon, 11 May 2026 12:07:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0C79530075A; Mon, 11 May 2026 14:07:00 +0200 (CEST)
Message-ID: <20260511120627.065013766@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 11 May 2026 13:31:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: longman@redhat.com,
 chenridong@huaweicloud.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 jstultz@google.com,
 kprateek.nayak@amd.com,
 qyousef@layalina.io
Subject: [PATCH v2 01/10] sched/debug: Use char * instead of char (*)[]
References: <20260511113104.563854162@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: BEB8750D5D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15746-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Action: no action

Some of the fancy AI robots are getting 'upset'.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -136,7 +136,7 @@ sched_feat_write(struct file *filp, cons
 	if (cnt > 63)
 		cnt = 63;
 
-	if (copy_from_user(&buf, ubuf, cnt))
+	if (copy_from_user(buf, ubuf, cnt))
 		return -EFAULT;
 
 	buf[cnt] = 0;
@@ -221,7 +221,7 @@ static ssize_t sched_dynamic_write(struc
 	if (cnt > 15)
 		cnt = 15;
 
-	if (copy_from_user(&buf, ubuf, cnt))
+	if (copy_from_user(buf, ubuf, cnt))
 		return -EFAULT;
 
 	buf[cnt] = 0;



