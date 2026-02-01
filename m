Return-Path: <cgroups+bounces-13580-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id K3vdLDCBf2lysQIAu9opvQ
	(envelope-from <cgroups+bounces-13580-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 01 Feb 2026 17:37:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30857C6843
	for <lists+cgroups@lfdr.de>; Sun, 01 Feb 2026 17:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5751300565C
	for <lists+cgroups@lfdr.de>; Sun,  1 Feb 2026 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EAB26A1A7;
	Sun,  1 Feb 2026 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg1h/jyj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0224B45;
	Sun,  1 Feb 2026 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769963819; cv=none; b=RmQWkv+NHZChKW/NKafxzwgtIZzS9lkIsRo/StqTCNK523dclLAT4GAR5b9z3Mf1k81abrLynNVDuxY8KUo7ZHps7s5n8SDjKAmighzve6Ne0Uunfm9gQt5AHDibhUsPC9SVjAYjbtf1Yp/StyE7aXoIPrZtHyo+ZPO70zUgGqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769963819; c=relaxed/simple;
	bh=ZK8UH6lZb0WzcRQp7vKfUyuwca2Tzk21UZa2ha/5n44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk6hoBfAI+Wv9Hx8LZgJTCIPCEgA+nQxm3cxGlXEmiOLaP41mm1MnNkG0uYpnXycLkT0z+SsiK00JguPCCvGSKFqeNK1G4iRfo9+xhsLsdDXg3i1GbZYnfUoCa/GRsYQaz9zSl6NY4TxvYdino7H13iLBmxUejuJgQfDZxaU+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qg1h/jyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A1FC4CEF7;
	Sun,  1 Feb 2026 16:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769963818;
	bh=ZK8UH6lZb0WzcRQp7vKfUyuwca2Tzk21UZa2ha/5n44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qg1h/jyjia2HFovgvsawWT2Uj72nQiYNBKxjj7a6dvwpWBFxHC5ww0x+UoZR0Pzlz
	 gomt0vWyWLC2lEZb8gH8Sie02005eGfxc0Al9c9PVM5Ll5KIfggtoKgs6H6wtqPWrF
	 JzuR6iuY3owfuLrh/Tm5oZLYHp84J5pBDEupB2iFjju7Wl+Pi0AW9QJ1/awVLWDrEr
	 MOHjAOo016UXjmPXKiFzSiObnkN+ZiK/AZrLK/qcKu03NABmjai4QWNpPqLjrb9yq3
	 aoEhfdHM+hEJGGYfe5ksGXU23tCVySMb6uvDwDK6oDilE6XlnxsvAq9WBh3TMsDThR
	 FDMCrLOtoJBAw==
Date: Sun, 1 Feb 2026 06:36:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: dev@lankhorst.se, mripard@kernel.org, natalie.vock@gmx.de,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com
Subject: Re: [PATCH -next 0/3] cgroup/dmem: bugfixes
Message-ID: <aX-BKaEXXtgPaerw@slm.duckdns.org>
References: <20260131091202.344788-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131091202.344788-1-chenridong@huaweicloud.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13580-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com,vger.kernel.org,lists.freedesktop.org,huawei.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: 30857C6843
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 09:11:59AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> This series fix three bugs.
> 
> Chen Ridong (3):
>   cgroup/dmem: fix NULL pointer dereference when setting max
>   cgroup/dmem: avoid rcu warning when unregister region
>   cgroup/dmem: avoid pool UAF

Other than the exit path problem flagged by the kernel test bot in the first
patch, the series look correct to me. Maarten, any inputs?

Thanks.

-- 
tejun

