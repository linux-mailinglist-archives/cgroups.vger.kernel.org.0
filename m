Return-Path: <cgroups+bounces-15722-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DydHWeYAWomfgEAu9opvQ
	(envelope-from <cgroups+bounces-15722-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 10:50:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA6950A58A
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 10:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 732E53097D46
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 08:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5B83C6606;
	Mon, 11 May 2026 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY61d69C"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E183C4540;
	Mon, 11 May 2026 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488559; cv=none; b=PHIzu0pa+sCW9psUlj4qcyhjP3JVImh9QYKebsLPERw0yw2Xd6gAyAX9brKVQWzJO8ZvQKoBOhs9Ku8PpO99mNT0JvgofUyUJOC+NiuZ3TPYeAH+sVLAhzCK9MQNbM+GTNR4J+JEVCfBe29wlAaDDroiFCTDLC5cSzsChMvJ0zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488559; c=relaxed/simple;
	bh=/EBK9Za3dzKeST6xzL+uhXsqga85E68iUDnkuLoGL9Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=NnU5yQtdcGSx9ZOmtHXg1bedoXOz0yegggtoaDeulOcn0etFKnIaxOM1IM1fMmQEgsPmFFYRXx/tfzWcyM6x5EGLN5kwlqkH1JEZF7VsEfwHQbwujxkr93Iv/G5pAJhak9MGC+sEb1tV/t5UB1TnH5Ca0hJUQ/6648/PStfgt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY61d69C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAC7C2BCB0;
	Mon, 11 May 2026 08:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778488557;
	bh=/EBK9Za3dzKeST6xzL+uhXsqga85E68iUDnkuLoGL9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DY61d69CJfp19KazmqNOGXOlE0zodqOtGBXFfZqUT1fw5rJyP1eqzeA+fUqo0FX44
	 v/qlsgBJWvKRB7guPiVmcyg6aaYrRWyylje0MrvCj/Efy0hprOxKr+2VdmceYbKAbR
	 SlkIyQ1/Q/skQIzhyVAwxtmBnmDQTDnPSbulmSuqZa7m9fdpAkR1UE6FAvm6+BYirD
	 xl2aHdMkjHZ9bRUg8AzoCSf0boyJ/PkrMiKWPRzv5yZE63Pxxzqfd0FucZ+A5YyBYd
	 QT9GT+Hgqhco+O58i4MrG2PC3p2KfIDsLkvoGYnWpLA/h013/f8YhhiDFrO39vzOhD
	 xXQ2IzAsLxqRA==
Date: Sun, 10 May 2026 22:35:56 -1000
Message-ID: <60bda7187dc09b87588e47276174c71d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Hongfu Li <lihongfu@kylinos.cn>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
	jthoughton@google.com, seanjc@google.com,
	zhangguopeng@kylinos.cn, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/cgroup: Add NULL check after malloc
 in cgroup_util.c
In-Reply-To: <20260511060853.1873161-1-lihongfu@kylinos.cn>
References: <20260511060853.1873161-1-lihongfu@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 3EA6950A58A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15722-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

Applied to cgroup/for-7.2.

Thanks.

--
tejun

