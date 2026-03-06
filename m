Return-Path: <cgroups+bounces-14686-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yISSFuMIq2k/ZgEAu9opvQ
	(envelope-from <cgroups+bounces-14686-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 18:03:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1298F2259DE
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 18:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D329303A605
	for <lists+cgroups@lfdr.de>; Fri,  6 Mar 2026 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BC22749DF;
	Fri,  6 Mar 2026 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXUmOcJQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A623F23A3;
	Fri,  6 Mar 2026 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772816602; cv=none; b=Jws1klZLubWoZLAN4JjDitRnhufOd0+L86Z3X5ki+UqSSTb2oXW8OoVzPUxT3Y9DngHCO6BoNJWTLwGDqlAeXgQwlYtDl00Wilj3dR2e8gDe2bxSmuAdBS4IVEav9h3nOzJuuUbjtG/qNMbqisvrEfPHVHqrYSf1O6uf/my/Q6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772816602; c=relaxed/simple;
	bh=ArEDItTJo6hCwcbnBFubpw6UP//5U2d0yXGHmNw662Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Y05gWoJJ8kyQ8R1glvPAqUnkfKbctBdA5HTDKoOliUIScAVqJrU/yVpantlFkzIhmHEQKGhL8upECH8T2oA5UGquUGaQQ8EDPkw8YZgkgc3+op5vefMCXGxkPbHIlP47IzbgmeLyOXyf4h7R5aFp/Y3yj1R4+hYDr2N/LmC2q2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXUmOcJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EFEC4CEF7;
	Fri,  6 Mar 2026 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772816602;
	bh=ArEDItTJo6hCwcbnBFubpw6UP//5U2d0yXGHmNw662Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EXUmOcJQwMvQoM5JLUZNqotWVkgNWBnWW9eaHGA9avwBdzSAxEUf57raE/uvwKdiF
	 6oxrCndxcZcmOm7VTmEj+nVdESJQWCopztk0kS7bUNNC9OpP98H316m7NBu/ozjdmT
	 JYpHt7SUDGPsFRR+d3FKtdifpfSU1ongVkBlhMY3hWNZUV5oV/rTmUFsaW+M1n+wqt
	 et9fHqxf5dT9QuNpW3eY2wlAdApEPP5fCMSMHRIS0BfuKhht2m6/zNSOJuOS4Zxlw/
	 ZWzIkyWVoXsoo8AOBeM3JhMyQToazizi++BXxof8z89BumlXX5O/oLZtbCop6S/hSx
	 xajtsIJ1cihgg==
Date: Fri, 06 Mar 2026 07:03:21 -1000
Message-ID: <6ad9aa06d0fbfd79b0541cd134013e1d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jon Hunter <jonathanh@nvidia.com>,
 Chen Ridong <chenridong@huaweicloud.com>
Subject: Re: [PATCH v2] cgroup/cpuset: Call rebuild_sched_domains()
 directly in hotplug
In-Reply-To: <20260305195329.282556-1-longman@redhat.com>
References: <20260305195329.282556-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 1298F2259DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14686-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Applied to cgroup/for-7.0-fixes.

One minor note: the patch also changes system_unbound_wq to
system_dfl_wq in cpuset_handle_hotplug() without mentioning it in
the commit message.

Thanks.

--
tejun

