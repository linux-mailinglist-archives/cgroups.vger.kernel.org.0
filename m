Return-Path: <cgroups+bounces-15725-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM+yHpugAWpKgwEAu9opvQ
	(envelope-from <cgroups+bounces-15725-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:25:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 058CA50AD5D
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2FB63059938
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 08:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9613BED06;
	Mon, 11 May 2026 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0VJu/Y1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EBD3C3432;
	Mon, 11 May 2026 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489722; cv=none; b=EgC4RRhU3MEqePz8k0Tj98HRcjIBPURJEa2qbKozQJDFzscZ0mMD1HETjpele57KT/I4gDG8PEprQo/hsT1o/ZuM5Y/wH1HShKE8pFG5BSfH3NpuM7VGeZ8+NgVHz+uY2SN4tgcg6893Bc9G4TD6Yg/uw9EW0iq4lG1EAvtx6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489722; c=relaxed/simple;
	bh=KK1if0fF5TRN3IysUMjg7mABXiR8ndVrOdX+I6lRDkY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SnBI2Wtrs5YdWdaLzewShIKDp7Bq8a42vtLuJn1hVHOBSw3xOTsf23LvetprjDlmYy7C8LM3kaUmptEkU/+CBga6DcQUJfHFO1n8jy7L1hJToVWELOWalsbCDGj/Nlgh0wDNzNJTwy/n9eISGEuoSWZgjURiqAcEyanruxWK65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0VJu/Y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F31C2BCC9;
	Mon, 11 May 2026 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778489722;
	bh=KK1if0fF5TRN3IysUMjg7mABXiR8ndVrOdX+I6lRDkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j0VJu/Y1wLrNw7Mt61D0XmIoXhZwUO4XJ6W95VdRtsFujTaDJi7+CkodfXbV891sf
	 +PhdoIRRLTLCnCj0Q+cBMKc+Cu/g0v/y977NyZhX/Yt+HkjfxZeufs1wq74yEo5Wom
	 Xz1+ChXfk+50mSAgXPGT8zRzQXD6wEdWmB8P8w5zxDe4hKeHg51YDYPI9NGRmQX7zz
	 OHg9R/xxJE+8XNC2gCWtYNkI0Ci2Op6YRjYYmqc7y5snHEZVODTsok3W9QoIx49RCX
	 89zGr9PGXLq1iLQSKl+houhm4NVxCAGCAaoFj82Dd+Xbsh+GNFDB5ZzT1FOl7vaYkp
	 cCwQkdj1nlFXQ==
Date: Sun, 10 May 2026 22:55:21 -1000
Message-ID: <5e88624decdcf65e4368a783f8a534ee@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Chen Wandun <chenwandun@lixiang.com>, Wandun Chen <chenwandun1@gmail.com>
Cc: longman@redhat.com, chenridong@huaweicloud.com, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: skip hardwall ancestor scan in cpuset
 v2 in cpuset_current_node_allowed()
In-Reply-To: <20260511081838.862889-1-chenwandun@lixiang.com>
References: <20260511081838.862889-1-chenwandun@lixiang.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 058CA50AD5D
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
	TAGGED_FROM(0.00)[bounces-15725-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_TO(0.00)[lixiang.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

Applied to cgroup/for-7.2 after back-merging for-7.1-fixes to pick up
dde2f938d02f ("cgroup/cpuset: move PF_EXITING check before
__GFP_HARDWALL in cpuset_current_node_allowed()"), which was needed
as a dependency.

Thanks.

--
tejun

