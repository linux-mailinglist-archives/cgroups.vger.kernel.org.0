Return-Path: <cgroups+bounces-16132-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAA8A98PDmrB5wUAu9opvQ
	(envelope-from <cgroups+bounces-16132-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 21:47:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A961E598BDB
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 21:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A46A301F340
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 19:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C1035AC11;
	Wed, 20 May 2026 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Myi6jhCZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65966318EC7;
	Wed, 20 May 2026 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306446; cv=none; b=U+WKocM5EH+9kxZGKYEhdr2GQUzKJxwM55VOds0BI/hlKfSwIR0O3WDzzs4RKPLL55qabaO9w+tunWeco2FVNhvf4WBs6+Zrw14vd2R7X0pBJGE4DfN2tLvLG05ghiThz+pxsz6BH6oEphILUfwvrt5LyEqdZQgN4ngCnOEMmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306446; c=relaxed/simple;
	bh=zP8Max0nzTqhTrtkuj/xidfpXL3lutBrRwI1xtpA1g8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=s7K1IGC7IsdOzb1nplX0vWP9AoeamVV4s9CT+WjEIeec8kupIFMQy+Y7q30EsZbeeepIdXnXDkW2oVH/MqoeYZ7oteyTuc1eTetvy28J9/eZ7E8RpSFBKQiyZzN+kBH0XWoQs+zxb/miXrFrRZv7WU8on3KW6rpSojOtbP20/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Myi6jhCZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03091F00893;
	Wed, 20 May 2026 19:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779306445;
	bh=zP8Max0nzTqhTrtkuj/xidfpXL3lutBrRwI1xtpA1g8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Myi6jhCZ3Vn5LtU31Uy6OXbcRSm4oIxEMq3Tg+Mr3MrA6uyy7BjVk9E0H40ciG4Oe
	 2LCpu/koeliXDvbhZWJrlkz1nNM/lHQS6QYpz+8k/oAHOUuYfGUGHs44vnEqQrIJDd
	 Nfsnm1jFlRA8jZRXEYZtbsK73rSr7TYIst8Uzdu6v52zVeEm+E+pgG2yeCs+RnRp+C
	 U5HqrfRmlzNktLpgSdrK1f1R6ZyShgrANJAhHiI97KjQBue0rMz1KSqDsflC+rGrnA
	 HUzHj848PjX47PuNUkIdVBRz2dEufZz+6PKNwVVYpHfYI1y0SpHxsZBgg5O4dTcsjO
	 HvaLpieFj5/qw==
Date: Wed, 20 May 2026 09:47:24 -1000
Message-ID: <c7c614c7140794b8a7e06ba86cf7d057@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cunlong Li <shenxiaogll@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: rstat: relax NMI guard after switch to try_cmpxchg
In-Reply-To: <20260520-nmi-v1-1-f2c8f08e4a2b@gmail.com>
References: <20260520-nmi-v1-1-f2c8f08e4a2b@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16132-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A961E598BDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Wed, May 20, 2026 at 11:30:54AM +0800, Cunlong Li wrote:
> [PATCH] cgroup: rstat: relax NMI guard after switch to try_cmpxchg

Applied to cgroup/for-7.1-fixes.

Thanks.

--
tejun

