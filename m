Return-Path: <cgroups+bounces-14574-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LB7DTIip2mMegAAu9opvQ
	(envelope-from <cgroups+bounces-14574-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 19:02:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 468E51F4E6F
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 19:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6A4C30AE258
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 17:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FDD3BED77;
	Tue,  3 Mar 2026 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HejWsx0k"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B7366577;
	Tue,  3 Mar 2026 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560742; cv=none; b=kA8Vrptj+3ZDf8AHy/XSZxNK0DrUHdpJKDzKfrdXd+BeO412SXRb3la+vbYmb//I+lGSEAHuDTsyj66J1g6+s3P31M+MKoSfEBTBnJgdM7PRtOSQMqnco/BJTDtTxsGteqHd0kW85bndny6tnCj88iJAMyRNNSW8mNdefxuQCmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560742; c=relaxed/simple;
	bh=bPr1d4FsEvE8qaKE4jC8j8uofFzZp53mFL2kXJfOrvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am85IhWYsomXmDTxzNlgeU27TXwDKn8SDVRgT6d9iG+ZkU8WrPLSs2hiWUxoYbMy3p/1+CM+drxmm2XN+PdNoXzdD3lTJUmvH2oGOpkksauYZhxY5UHfON7n6FU6gXUbxXJM1jVZP48/SlsGLCthIoygEzBYf3ONeWxqitemdXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HejWsx0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28383C116C6;
	Tue,  3 Mar 2026 17:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772560742;
	bh=bPr1d4FsEvE8qaKE4jC8j8uofFzZp53mFL2kXJfOrvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HejWsx0keLtia0uk0VFk+qjpnZJoxLP+LGfAiDcxrThwkOqPbNVBcsi9AJO5UEvuN
	 s9gM2Zs+Cww1tTH8LVutuZwC7FEOXZiLqhhLegk8By73U/jCivGYKCz+/F7ZXZYqef
	 q5a96EBXVurR2ZS7CzM5af4DglGYUf2eAdPR9wKzs/71J1G4YlUOcA37l/x1BGsg1N
	 5Y59lNjUrBy3mzsnwACo9ISPqEvnl6q4btKvor1+C0cYiKJGR5iMrcsBwl7w4djkNI
	 P/Ye1FLsS2jtwZXTiJKWkzYV957G6+cADKhdecwZoHwDcgrMQ+r9Q5usbuqMAugCra
	 21MtddHddkOjQ==
Date: Tue, 3 Mar 2026 07:59:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, cgroups@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH] cgroup: Don't expose dead tasks in cgroup
Message-ID: <aachZbIFl6HCFSxD@slm.duckdns.org>
References: <20260302120738.6KkDipsR@linutronix.de>
 <aaYHmCV2CW-tOT-Z@slm.duckdns.org>
 <20260303131301.ieSSCM4n@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303131301.ieSSCM4n@linutronix.de>
X-Rspamd-Queue-Id: 468E51F4E6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14574-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,cmpxchg.org,suse.com,kernel.org,goodmis.org,web.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

On Tue, Mar 03, 2026 at 02:13:01PM +0100, Sebastian Andrzej Siewior wrote:
...
> I get the same timeout behaviour on !PREEMPT_RT. So it seems like I did
> reduce the race window.

I see.

> So what about doing the removal before sending the signal about the
> upcoming death? Something like:

d245698d727a ("cgroup: Defer task cgroup unlink until after the task is done
switching out") is what created the big wide window causing the regression
and we need that because otherwise the cgroup controllers get confused. I
think we need to figure out where we need to start hiding tasks from listing
to remove the race window and do that explicitly.

Thanks.

-- 
tejun

