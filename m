Return-Path: <cgroups+bounces-15593-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EiPEV7r+Gmi3AIAu9opvQ
	(envelope-from <cgroups+bounces-15593-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 20:54:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB324C2CC1
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 20:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 863EF301E97D
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2026 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1CF3E715F;
	Mon,  4 May 2026 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGyOvreE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23AC3E6383;
	Mon,  4 May 2026 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920850; cv=none; b=hp/cgmRRohuvMhpwICeyxfGnPIyC/Vb8H+FrMyE+8P1BH4T+c0peiSU/4IINkIF+qCM7f4u98JgDwpZ4K07wTO06mTJ6HjwE9jIGcfBYBAhTzC0FHacKJFbdG/xk0JifRxk+BazU+1oEivBeSuC8MnCAZ/+SMjKIknIESkYE6nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920850; c=relaxed/simple;
	bh=h+uhi/NqA0FdGMn82gWEgw/8zcywPLWzEWQvhat6/88=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=JfHE0Xh9QCTclWdcCWTxi28b/8ovh4bV27v6XRFkSpW1LsCuX7qg62ZIEOdOOZKzZ5zT4Oz3yt4n4ZivKoe1MaGS9HbQutfwK/l8cAjs6OvUPSFLMOoCF+t/JGIA0549PcU/hDQgEJznRNeHc+t16ZpY5hZ2m1pcqyyMxt7hkVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGyOvreE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E928C2BCB8;
	Mon,  4 May 2026 18:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777920849;
	bh=h+uhi/NqA0FdGMn82gWEgw/8zcywPLWzEWQvhat6/88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FGyOvreEiMEaXdRBOOmb+UQ2J0P8dT1vMZM2ECeQ8cWbZ2pPj+ydl4qOo+xkF3VmR
	 pYPQly6gcwTXC3PQBpNHwZIZB4i4JmllJ5++KeYIr0sE9yObcv5snbFy1kHlFkiQ3L
	 T7Ecr9Vnhu8QgiQ83n6U0S58A9C9Mt4j+VH19cFiPyfPLN4md2drA4aD7o53xczR1n
	 iHo7QOGQ0PSz9Jvm2pbdRWN5buHlgKMpXTfDdZGkDZweqVCc9XjukvVGTHWfS6AprY
	 vsh6SJrmb56SjJCaPdYYeiCRme7c51Ys4cqsEpiWEHsMrIBTzSSmzTvdUPYIlXba0K
	 /43mPcLCWW91g==
Date: Mon, 04 May 2026 08:54:08 -1000
Message-ID: <fb9ce3e0dbd50b89a1c9b687fc445be8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Martin Pitt <martin@piware.de>
Cc: regressions@lists.linux.dev,
 cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 cgroup/for-7.1-fixes sched_ext/for-7.1-fixes] cgroup: Defer css percpu_ref kill on rmdir until cgroup is depopulated
In-Reply-To: <ad3b4597f3df81914b871618535370db@kernel.org>
References: <ad3b4597f3df81914b871618535370db@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: DDB324C2CC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15593-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello,

Applied to cgroup/for-7.1-fixes.

Thanks.

--
tejun

