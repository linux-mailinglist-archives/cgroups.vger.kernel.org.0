Return-Path: <cgroups+bounces-15594-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBSiBEcK+Wnt4gIAu9opvQ
	(envelope-from <cgroups+bounces-15594-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 23:06:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B604C3DCB
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 23:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05D103031ADB
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2026 21:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C08A33F599;
	Mon,  4 May 2026 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCElDrI/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F020033DEFE;
	Mon,  4 May 2026 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928745; cv=none; b=fJsUuR4n0RfleZxdVjOGZDguiDB5LSFQy7Giajr5iZ71u0vG5RXX0A3qZPhuqvzdSCjF9A1BGqfNbWkz4lonvW7zpvuIYcl/bZw8hPcc5iSOkR8kaL5nqX4yg9FitvZjZ65dUP5aUHJlxtDlofK6tLqEsIMcPkjRvYCCgI318G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928745; c=relaxed/simple;
	bh=h+uhi/NqA0FdGMn82gWEgw/8zcywPLWzEWQvhat6/88=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=X/pnK/KAd2JHeZuBBhCPYxNomXHqbFEN2LdpGLn/RmaVce+Myax5xPtiQ9OBkm7ZYAPH55BWltrSI0zqcfSp18I1PJk9IdvCgwx+w70SJfQQeNG9o22pYFvaEMeyxPyFyHwbCOErrS9oRZWo2/ihYUysFM2CumbHolG/Ss0mGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCElDrI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84D7C2BCB8;
	Mon,  4 May 2026 21:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777928744;
	bh=h+uhi/NqA0FdGMn82gWEgw/8zcywPLWzEWQvhat6/88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tCElDrI/MdAu045nEHvrc+UDML/ckzykUrdkNaoejc9Qa4bjaRcZwRO15nC3ojXBr
	 K5lJVwHFKSJ6BuU5tj0mDodCFp1DCauBMPOx34sZLdnwuE91AEahMYwYgSxOmxrAhk
	 hUE/LdoeglmrAs9wMzst6g8FuIXiJIx7POmi+NAc/X146pu4uU6j3Frlw6cArR70Vb
	 ErWkzeIg/BaxI+B1gCUrlpdHoJWvjJF0MBFyP5D8vxx8qNofPFn3Fj0/FVCRKTRHJJ
	 sgQHkHFdLkHFCsC8ohTn1mC0TnHMQlPe7tBoMoLEwEroGIK66L/pEYxu/uNqDruodL
	 V4pjGDmJPVWaA==
Date: Mon, 04 May 2026 11:05:44 -1000
Message-ID: <27f00387eb2bcb4eb95d2c34f01aa1d3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 cgroups@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: cgroup-v1: Update charge-commit section
In-Reply-To: <20260430201142.240387-1-tjmercier@google.com>
References: <20260430201142.240387-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: B0B604C3DCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15594-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello,

Applied to cgroup/for-7.1-fixes.

Thanks.

--
tejun

