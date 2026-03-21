Return-Path: <cgroups+bounces-14979-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +hcjDBfxvmlxlAMAu9opvQ
	(envelope-from <cgroups+bounces-14979-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Mar 2026 20:27:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E5D2E6F91
	for <lists+cgroups@lfdr.de>; Sat, 21 Mar 2026 20:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84F7B300B751
	for <lists+cgroups@lfdr.de>; Sat, 21 Mar 2026 19:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E5B3009F6;
	Sat, 21 Mar 2026 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX1Yu60O"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458501B4F0A;
	Sat, 21 Mar 2026 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774121234; cv=none; b=YhFqxpUdZB0BGCKOo54FgxnKY0hcyUoGadJ31TBlWTzfrv7Sq9E1WXiMQgZfH7cUb2X9yAZFgY9nB2LnVx1p57p6YJgMNMwVIyIHgZ5o4k+FsBAg8R+9HFhDypILeAnC0FflLM41HE8MkfgwtCIM5WPkuoq1ws9zGgoUey4x318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774121234; c=relaxed/simple;
	bh=px/TL8DGdi8VbNkcoFn729fcLlKGeeNByfaaget981k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=OVx73qTuhSlDuV01rEmyaiFEi35xEbtTMyZ38GScKgZf01PTzIxEC9nKbhPjLosfDKJ3WYwVh8fNvssoMlU2S/hSSCqta+ssD3h4hjW3t+11Yo98rcq+m9R23QKVgoRKUV57+uqmJK02Xvu7IFZA4pD30TxfO1tqfq9N4LwVy0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX1Yu60O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E6CC19421;
	Sat, 21 Mar 2026 19:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774121233;
	bh=px/TL8DGdi8VbNkcoFn729fcLlKGeeNByfaaget981k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BX1Yu60Ol5ehk77hP+kFw96c2GjI8TOxEBdOFl5VXyNVJBTytBLi2nXgYekVxYEr7
	 brjaVeauUx3ZE3XSDQg8+HzLoe1zplCI88ytF0pGZ9ygt8Ns1TXgseGBA0j7w9sJXG
	 OwgrT6hs4Dq7sgn/JRlXhAMFgyA2nZ8Sb59ppFXvC+jIzXtPVIHFTtn6ygyqPmqJz9
	 bIi1NlqRpDMHT2rzmC+8yOob0YExGujcmXbr4uvfY3oq96AMY3JeiMKqP8B3ksQ1L3
	 oOAJcIxAWP/U+kffezmYLPIclivp/2LZSlfawz170eQe/06ejpYCsXx7gLfLOU0uys
	 CUTiA6Xcx4vyw==
Date: Sat, 21 Mar 2026 09:27:12 -1000
Message-ID: <b099d9248df084fed8d4252e3c6fc485@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Maarten Lankhorst <dev@lankhorst.se>,
 Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>,
 cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH v2 0/3] cgroup/dmem: allow atomic irrestrictive writes
 to dmem.max
In-Reply-To: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
References: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [3.34 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14979-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[igalia.com,lankhorst.se,kernel.org,gmx.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.004];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2E5D2E6F91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Generally looks okay to me. One comment on 3/3 — the naked xchg() in
set_resource_max() needs a comment explaining why it's used instead of
page_counter_set_max() and what the semantics are (unconditionally sets max
regardless of current usage to prevent further allocations, since there's no
eviction mechanism yet).

Applied 1/3. Maarten, Michal, what do you think?

Thanks.
--
tejun

