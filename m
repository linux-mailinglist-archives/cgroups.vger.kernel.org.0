Return-Path: <cgroups+bounces-15709-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEcDOPY3AWpHSAEAu9opvQ
	(envelope-from <cgroups+bounces-15709-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 03:59:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70724507156
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 03:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B128300B61A
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 01:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A7F2417DE;
	Mon, 11 May 2026 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWOuzoUn"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB59617555;
	Mon, 11 May 2026 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778464751; cv=none; b=hnp3aqzeQDy3OMpLnRCaGse4gAxnpSR8k8ZHOoOBl7ukKi65khqx3EGrwBzMrRcIHMOPcYgMQeobzhz1ziWCuIBC5D8TO5q+mTROs8oel7TWaxyX/5ndtYVO37lTx3Ta8XDO69a1JM0wZSCeWE9Ex4CVWbrK0HcSeAuP3GJCQ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778464751; c=relaxed/simple;
	bh=h+uhi/NqA0FdGMn82gWEgw/8zcywPLWzEWQvhat6/88=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=M4JM768JZeHxBNSGDEGNEZX+x5o12X5Xy5fyqFxSOomHg9S/TLLM4mQVAMXtK/eQlEGbVZB2hp3+e5mBrfFRrFmlQ7u0UmbTvFhlhOHALsNrJNHeKccAlsjkI10LYxJjjDYFWqfUIcAm5giQNhreFZqEXcddKKM3/Rhbbfg/Gdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWOuzoUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD6EC2BCB8;
	Mon, 11 May 2026 01:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778464751;
	bh=h+uhi/NqA0FdGMn82gWEgw/8zcywPLWzEWQvhat6/88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NWOuzoUn82hVqXnprSFfjlPUtCeyVd3ZsBboGucmVmzQ3MRrHhRgZSNzznWgD0AiJ
	 uA7LJPRU3UmJs34ooy9X9DWuXmDf5LwBSN7764Jf11zGoEbXAZmSIw9dsuS+d44GQL
	 u2IlZYRmXAvhPE+yKTn0eREok5p3SlYfXaTVKq18WczPIdv0MnUnqkxVdtxXZhtjYY
	 1MymlfRM/23JnNwW+gjZFB3r9RvFCWX5OezVgasy3XVi7WuksPxI0Ywr8XTs4GbadE
	 9kWLa86jk8Vva3+XSrMvcSEbtHBMMhPg/N5hZsfyT7aPvw/KEAKIxIchFHRsVw/G+Y
	 niYOoriDHTzqw==
Date: Sun, 10 May 2026 15:59:10 -1000
Message-ID: <e6b0da8a53e22257d122096c429a7310@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Hongfu Li <lihongfu@kylinos.cn>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 Shuah Khan <shuah@kernel.org>,
 Sean Christopherson <seanjc@google.com>,
 James Houghton <jthoughton@google.com>,
 zhangguopeng@kylinos.cn,
 cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/cgroup: Fix cg_read_strcmp() empty string
 comparison
In-Reply-To: <20260509080328.632007-1-lihongfu@kylinos.cn>
References: <20260509080328.632007-1-lihongfu@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 70724507156
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
	TAGGED_FROM(0.00)[bounces-15709-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Applied to cgroup/for-7.1-fixes.

Thanks.

--
tejun

