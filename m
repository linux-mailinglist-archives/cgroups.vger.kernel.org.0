Return-Path: <cgroups+bounces-15032-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PHWMDzzwmnCnQQAu9opvQ
	(envelope-from <cgroups+bounces-15032-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 21:25:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBF931C4D6
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 21:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82FE2307C2CC
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 20:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA5034C141;
	Tue, 24 Mar 2026 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpqhgzDx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C022F851;
	Tue, 24 Mar 2026 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383893; cv=none; b=cq7NNPP9cNyAK/Wqd7yHEQDupPziwvqwp7nVHjpR524olCk9b8wBYqsrpWndcr7Xd8vDY8qmDEXdM6PJ2qZQf/Oqr7YRcX1yg4x4Ettyys3M3SR9yNFyJgvdUcUxj/9lf26qK6GpAnNugUTrtP3Eanjm0NCDCOvmhcN/TvZxrqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383893; c=relaxed/simple;
	bh=K8RVwS4rPQ3le2c1c6uADUie/cREhyMJeFBJwhdbBII=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=GEb8H75JHFFZPVo6ajo5p7NV3TOcM76xSjtJYGgQGABA6GBIjHA9C6K129OJCrAqqPtaRJrZZCETXt6tFqXjxKc33Sk7So0xnZcb18qzmwnyHrzV0r1tiz1GCVbwZlQRcON13u2R1o6OQ1sGCdQ84C5gRU+4Zoy089K9iuABXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpqhgzDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56793C19424;
	Tue, 24 Mar 2026 20:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774383892;
	bh=K8RVwS4rPQ3le2c1c6uADUie/cREhyMJeFBJwhdbBII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TpqhgzDxD68Fdb+TbqY7yNS8Z0UapgDKMzG6NJmgIRpHUpLp+8pMywiVSy/oSb/E/
	 021aBssyUbBtyHcQCDx9yz+ZLIBpZ285Eg8ZtWlLdOeCBn0sLbNY+p+VkN1sf6Gjgy
	 1dfBfbTv2xNgt7MxZazrNo6Ez+yReTqcGxLoTLJ0tTJmwGZo7rSV8vNM/phjiZONF0
	 7Cc5hZNUsPcpDiw3NHpMb20gGXDQhkeoYlPAwRuGOjyBICgvGedaTi98RL14YeOPyq
	 Ny2AR9SBXlZ5wyvsPV2pMqWU2vJXUkz2nG+TNi3NqNDN6oI9FxEmymT126Hd4nkRMc
	 mB5ewNY6yDIhA==
Date: Tue, 24 Mar 2026 10:24:51 -1000
Message-ID: <c32c2ca14057fc441f6437b08e08bccc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>,
 Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH cgroup/for-7.0-fixes] selftests/cgroup: Don't test
 populated synchrony against task exit
In-Reply-To: <49dca9aa15c6c46de60f1ba4ef2b25d0@kernel.org>
References: <49dca9aa15c6c46de60f1ba4ef2b25d0@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-15032-lists,cgroups=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7DBF931C4D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Applied to cgroup/for-7.0-fixes with the subject updated to:

  selftests/cgroup: Don't require synchronous populated update on task exit

Thanks.

-- 
tejun

