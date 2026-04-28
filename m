Return-Path: <cgroups+bounces-15539-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDhcGCjW8GkSZQEAu9opvQ
	(envelope-from <cgroups+bounces-15539-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 17:45:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C530F488261
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 17:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E61C30A4122
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 15:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADE53A759E;
	Tue, 28 Apr 2026 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVyp8n3r"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78E138A715;
	Tue, 28 Apr 2026 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391041; cv=none; b=Uu0DUqe8R6sXbMNOksM+KGaHKBSCNtZL01YvzG9G94iMhrWtf5kGbaEjhCO4E4ILjRg8HoQGi57JoVfRvhvjB13OOdx95vEODcq9V5ofg1q1LI4gHW0n5WXXKj0Djs2pcKBgdothl3IvG/2WuFlcWxLi//omKQA+xoml3pB8Tuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391041; c=relaxed/simple;
	bh=IsONiDrD2xR5auxYL6/onJP6puh+tp2frOU7zl6ODsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=romKyaWl5cMuQ0DK8HRv2/z9Ui6GeEMefPcL+CWsMvlO5zHhg8/pGc/I5i8AhBmyKrpg2XOj5o1L5ZIoCooAnoPJLLeqQUNCX8mxY3CqOJsgwgHqfFy6syZGybflwO/Gs9dF37Qnnwwp8vvANSHLUuipbr/n6++nquCXP42GeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVyp8n3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB57C2BCAF;
	Tue, 28 Apr 2026 15:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777391041;
	bh=IsONiDrD2xR5auxYL6/onJP6puh+tp2frOU7zl6ODsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVyp8n3r1UFhEVDycBbVOpEikxTTOKqjKvWMqXrjiJ3fPQLzAjwMKnYEA0/dUdWxN
	 T5CMgSnwPA1qaMwiFey8CJJLC7zmlW/A43R+5UKSsQLKHglWhZ7W4SeotwHWYhmR+p
	 xZc4QzyirHqNanQ/IlC+LMG9rYOq3l1+UVKi8DVi1nbeWbSg/f7X4VdfTClSi51ac5
	 lNGD69YN9L3qIqxIjB2+VRrZtRc2B5m5ohX712QczulcvDfYGTcSQDG5yoImcbYH/u
	 3K4pIXZMZ4Qese4NSK1vTrrGC1Y9IlWp+iY37pSn1moh6xpC6lI4JK/7wtxM6Ow/M6
	 VFOfRsH4UOwvg==
Date: Tue, 28 Apr 2026 05:44:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Chen Ridong <chenridong@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Xie Maoyi <maoyi.xie@ntu.edu.sg>
Subject: Re: [PATCH] cgroup/cpuset: Creating or adding CPUs to partition not
 allowed without privilege
Message-ID: <afDVwO-j2UOdSpQj@slm.duckdns.org>
References: <20260428033439.783246-1-longman@redhat.com>
 <7so4b76wg2apwwk3yh76q42jgwnpvlv7sursmsmzeyefhp4pbt@thybpp4litm6>
 <9df75f61-0cbb-42b4-b64d-8e6fd49d50ca@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df75f61-0cbb-42b4-b64d-8e6fd49d50ca@redhat.com>
X-Rspamd-Queue-Id: C530F488261
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15539-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello,

On Tue, Apr 28, 2026 at 11:19:16AM -0400, Waiman Long wrote:
...
> Thank for the comment. Yes, that can be a valid configuration.
> 
> One possible workaround may be to see if the current user has write access
> to its parent partition root. If so, we can allow it to create a
> sub-partition, if not, we will forbid it.

I think this whole thing is a confusion. First of all, resource knobs in any
given cgroup is owned by the parent. Delegations where the perm to a
resource knob is given to delegatee is not supported and expected to affect
resource distribution w.r.t. its siblings. Partition isn't special in this
regard. memory.low or min can create similar effects. Maybe I'm missing
something but I don't see anything happening that's not supposed to happen.

Thanks.

-- 
tejun

