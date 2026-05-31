Return-Path: <cgroups+bounces-16496-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOcoFAxjHGoVNgkAu9opvQ
	(envelope-from <cgroups+bounces-16496-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 18:34:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BA661721F
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 18:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74784301D053
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 16:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B90A28469B;
	Sun, 31 May 2026 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+Qf//Uv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD3762809;
	Sun, 31 May 2026 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780245190; cv=none; b=VkcgkcLkE+wlFDyt9EJXPJgBI6uQq+gO/RNSuagEn411gz+/c9bnky6tm8Pchgdc4qvPHlKwhWN8o36iHjUR8XZyyCzPPmmqaXPrfF6NrZqetV9zg+PeiJ6tiHHdAVtSH6RbTZ3p6QwR0+yHd9JSkSLT7JCqGjOQWuOCr2R4zOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780245190; c=relaxed/simple;
	bh=/EBK9Za3dzKeST6xzL+uhXsqga85E68iUDnkuLoGL9Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=knclOKZiKnklEzm8k4Bl7So0O9camVRde1inAEeTWNt9PkGvbWS2tcimYAMq+ao0rgD/hxyl1IOut9oPDpU0amK+YL86KIwojU7clS3c5ub08YQPfSDeyebbUMqdDNLjWzcJf0H/n8hxQzKdblbqNMOwlqJM5mv4JQjlzufLGh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+Qf//Uv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85EF1F00893;
	Sun, 31 May 2026 16:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780245188;
	bh=/EBK9Za3dzKeST6xzL+uhXsqga85E68iUDnkuLoGL9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c+Qf//UvGJPiWky0Bx3n0cD3T9m0V/qawaD5MvlXXn9H7tLwcd5ZYpM6awhfkuZLY
	 voXD6dhrU9LmQYUtm+oLrrdo/9W7XW6MCbDWBQUZl7DmHAZuZmBSZeRfL5PkN/Isns
	 OtA3L7c2ykICGQUwsk/SrTFALiLXiS13B+Q9tDQpwhTgX2wyn3h8qVaoHCyQGaW+p+
	 vJScB3ZtyBD1+H+8nL4R0ZH06XUxnHHP9t/KKpnmskTk/lao2deVAw4cEXZbpEABh9
	 fdeCbcNzAYJv5Rmp0dfr9Ove8KQso86IifQVwcjaDv/0dMtLPy2+QSvCrmYpPK28IS
	 426ZN40Y0KbwA==
Date: Sun, 31 May 2026 06:33:07 -1000
Message-ID: <f0be4bbcfc27f132334ceabe2a0b8348@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: cgroup: Fix stale source file paths
In-Reply-To: <20260531140045.4114289-1-costa.shul@redhat.com>
References: <20260531140045.4114289-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16496-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D6BA661721F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Applied to cgroup/for-7.2.

Thanks.

--
tejun

