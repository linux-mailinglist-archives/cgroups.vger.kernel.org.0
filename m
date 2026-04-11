Return-Path: <cgroups+bounces-15225-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIiTMBCy2mnl5QgAu9opvQ
	(envelope-from <cgroups+bounces-15225-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 22:41:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFA73E1A74
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 22:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C845D301CFE7
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 20:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B0A2EBB84;
	Sat, 11 Apr 2026 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM0evz2H"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B800175A9C;
	Sat, 11 Apr 2026 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775940015; cv=none; b=B37DRH0wav9K5fPKEYGyZRvjIEpqvq8XTPVwKnHjTdPByaRToSvVP8Ckc4wsGGnnMeqcsymcYRVTsibtCtb85KGiO6EK7j/Y3y/dFuHWYkSSYXcBKLeAQ2Nrw4W+2emuoq4WnoHSB+PkzaOQYweXEBDgxHEoj4iO3aWqZ3vxv14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775940015; c=relaxed/simple;
	bh=gDxz6ztrkLHIlDZTuuR2I8phhWDCINBsHfpF42h2Ki8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCrZ265RuDpmzioahqbrZ7HuiywUWJU8g9/CZoxF22hjMGZapHGkG5wVjBZ1Tz8oRXceEerVFIYAXdUkftS/wHlcgDtBxJjX0eGkiGcrYjBnAM7TxSA1S0s5gwpgpEzMedB7cB+RhhOuaGwwjfuZxAW8CNZWlbJ9aTBaq+uam3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM0evz2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E086BC116C6;
	Sat, 11 Apr 2026 20:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775940015;
	bh=gDxz6ztrkLHIlDZTuuR2I8phhWDCINBsHfpF42h2Ki8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oM0evz2HyYNZZVkHSOvER+5hKLjTvX6zowrHgOOUFnLEyKE7j5QOLOBeCr8GCaqe9
	 XoVONYFfjNTjgzzEUiacEc+VBtZxetRKCDJ4GIZE6NCPU520acwHa2tj5qZ0alalo+
	 DtkIZhSRCTgyPaEClTeyrIVEUS6jC27r9Fj1uHlPhyn4m0xXcwSD+Quxv6LSicjjdH
	 flB43DSMrDlp/ieOjDmLRnGg4QsIof3t6U3bfqAe23Mrww6MP/ROMXY1kBUnzuN8sI
	 XVoQeK7T6wkYRZg+810BVoCvZqeT96pmc8myqPXEGiRnoYjeIwsLQxxSzF03klThut
	 m9JxrEw1fxm/Q==
Date: Sat, 11 Apr 2026 10:40:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: cgroups@vger.kernel.org, chenridong@huaweicloud.com, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, mkoutny@suse.com,
	syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] sched/psi: fix race between file release and pressure
 write
Message-ID: <adqxrX8Huq1J4BLG@slm.duckdns.org>
References: <adn6xRNYwep9dQyQ@slm.duckdns.org>
 <tencent_157925F8BA70BB65336B9E831B714BA11B08@qq.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_157925F8BA70BB65336B9E831B714BA11B08@qq.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15225-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups,33e571025d88efd1312c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid]
X-Rspamd-Queue-Id: 2CFA73E1A74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Sat, Apr 11, 2026 at 04:29:22PM +0800, Edward Adam Davis wrote:
> On Fri, 10 Apr 2026 21:39:49 -1000, Tejun Heo wrote:
> > > > > +	ctx = of->priv;
> > > > > +	if (!ctx) {
> > > >
> > > > This test likely isn't necessary but that's pre-existing.
> > > Where?
> > > Are you referring to the check for of->released within:
> > 
> > No, I'm talking about of->priv. I don't think it can be NULL while a live
> > cgroup kn is locked, can it?
>
> If the lock is acquired before the execution of cgroup_file_release()
> completes, it will not be NULL; however, if acquired afterwards, it
> will invariably be NULL.

Hmmm? While the write is in flight the file can't be released and the cgroup
couldn't have been dead if lock_live succeeded. This part is tangential
anyway. Let's ignore for now.

Thanks.

-- 
tejun

