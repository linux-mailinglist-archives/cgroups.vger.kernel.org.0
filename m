Return-Path: <cgroups+bounces-13603-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNMwGDzQgGlaBwMAu9opvQ
	(envelope-from <cgroups+bounces-13603-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 17:26:36 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC894CEF20
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 17:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23704303DD52
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2C027A465;
	Mon,  2 Feb 2026 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAjMJOlj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD70275AFB;
	Mon,  2 Feb 2026 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049061; cv=none; b=m0p1KTl0utIEJMdBBGjfCfs/HOHvq8U2OqsauYnDYx638+etbkGcoHgGegOoZlN0EuDZrq9j/5utMTz23LjfmepU4+Sq239qN8cLVFlf/Fn4+ICOYPEXw9uka9HwSg6llsh2fntryfR8YQmx/mK4yKrPzihAopZONIgemshNar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049061; c=relaxed/simple;
	bh=4DUaVHOZIT+oa1d4uf2KYUHKJZwxY6Iopd49aAtgbZY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Bs4aQPnP/ldoE6a4y4ExMhAkHe8LrmBuqP9Zswspd3gaPQFSvUh9x0vRX5sDhlMejOpgyZBeuPpqPZKOvaTKu7Vq0H4a825pM6awVVeiEIMw2lWUD+4WZne0N47AijKdqFfNriggYfvuKVL/dDNMgXomsNoeb6aP7aDBEPcteOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAjMJOlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156D9C116C6;
	Mon,  2 Feb 2026 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770049061;
	bh=4DUaVHOZIT+oa1d4uf2KYUHKJZwxY6Iopd49aAtgbZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CAjMJOljPkx7H8FbX58xHXHo/IEsPG9+nmSOEniqmmqq6GjqMwUFxMIT5uWYqx/yI
	 6q507EUDuv7NtIOsqrPdhxhaNnTDishBQVtKeQccyArioR8goj2jPnJdgZRPtX7AOO
	 8WovY20Cuomh1EbCFzHx12HvdInuEUUQtcCzhGLIOZwo3wIc/39EIkshOKIElv62nJ
	 7hMF1AIcTZHnCCTixbJIPdg09gOHgd8QeROot4CannnCUmf0z2UZ6WuV2T+LY6E6bx
	 0GRVTu8/TdauRsZeC3Goh61jIS76eBs6ilfQdwEsGPYalv8p14vMYTRMYExM/zoip4
	 44UCrVqH+jvQw==
Date: Mon, 02 Feb 2026 06:17:40 -1000
Message-ID: <a3f6882172c7a1d1e335259675cc8ff5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: dev@lankhorst.se, mripard@kernel.org, natalie.vock@gmx.de,
 hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
Subject: Re: [PATCH -next v2 0/4] cgroup/dmem: bugfixes
In-Reply-To: <20260202122719.414466-1-chenridong@huaweicloud.com>
References: <20260202122719.414466-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
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
	FREEMAIL_CC(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com,vger.kernel.org,lists.freedesktop.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-13603-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC894CEF20
X-Rspamd-Action: no action

> Chen Ridong (4):
>   cgroup/dmem: fix NULL pointer dereference when setting max
>   cgroup/dmem: avoid rcu warning when unregister region
>   cgroup/dmem: avoid pool UAF
>   cgroup/dmem: add argument checks in helpers

Applied 1-3 to cgroup/for-6.19-fixes w/ stable tags added.

I dropped 4/4 as we don't want this kind of blanket input validation
unless there are specific reasons to do so.

Thanks.

--
tejun

