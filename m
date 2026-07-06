Return-Path: <cgroups+bounces-17543-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GhQqJfkFTGrMewEAu9opvQ
	(envelope-from <cgroups+bounces-17543-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 21:46:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD27151F1
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 21:46:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XOfQfD6B;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17543-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17543-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B58A302418C
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 19:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AEA3C5857;
	Mon,  6 Jul 2026 19:45:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D083C3789;
	Mon,  6 Jul 2026 19:45:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367157; cv=none; b=D7VJthrDdrr1L90d5DYw9E5sEhIjxQl3cSxlnRiv33D4OPrbpdhCuH5fp4zXFG62+41h7QVqK3oZejI/Ykw0K/F7gZBF7JNQbYAh7XpiIsTxp3XhXS7qfkzL1YR8omNxCUhwHQ7pkNul9FUihctQR1tHLS8DvJsf0uoTcl1bMD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367157; c=relaxed/simple;
	bh=AovqIHQqwVYs0zTuniHpmPmij/s519jnqC8QcN6eRkg=;
	h=Date:Message-ID:To:Cc:From:Subject:In-Reply-To:References; b=jV1Z0X7JAci8LX4EBcaiEF8gsIE9dKh1MkgS8/WMsCTAYamgJYubfiCnQT3J+USopViAuhijBvHuc6YeshPRUrLz6Kpr6d33imN2u0EVqee3pw/YWLJQwE6P18SnfPQtNyMrDZK9NRaRAFkidCFXlMqeMB47ZPzgBBclvYZITbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOfQfD6B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9411F000E9;
	Mon,  6 Jul 2026 19:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783367156;
	bh=AovqIHQqwVYs0zTuniHpmPmij/s519jnqC8QcN6eRkg=;
	h=Date:To:Cc:From:Subject:In-Reply-To:References;
	b=XOfQfD6BV5xPh/dM2/TdgTOCFYbwCcwQ9mf6FopUDp6IG1cB3+quIfh+HUzbr19i1
	 lZ+vyu3KCohQ2wEqRjvaoMyzAJKGjm7H6X1QH7c0IL2OdQL7CC6EEXVKzUBwR+m/Sa
	 QhyyMQkNYYaFJIoy21I9oLbG6A9JrZXti4DJRV+w4SuRKdfmNZLjucKEhWKsBMukE9
	 iyWM+wUvzn+JM6/jvHwRViM+a7GZP+Sp/XaP4tUyk6SCT+lWAEXS8vIw/LNXRyUc22
	 8Fc2Dq7H7kKA2CuoxJz2VT028L4G1PpEdo/7bJADZbijFJUcryIcjVCYO53lbZAK9p
	 7qJkWa+B8Iaww==
Date: Mon, 06 Jul 2026 09:45:55 -1000
Message-ID: <6414bf279afba506259bda347299fee9@kernel.org>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] docs: cgroup: Fix bracket
In-Reply-To: <20260703063805.219517-2-manuelebner@mailbox.org>
References: <20260703063805.219517-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17543-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:manuelebner@mailbox.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20BD27151F1

Applied to cgroup/for-7.3.

Thanks.

--
tejun

