Return-Path: <cgroups+bounces-15223-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JoKZHcz62WlTxggAu9opvQ
	(envelope-from <cgroups+bounces-15223-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 09:39:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C123DEB61
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 09:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E2CF302D959
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 07:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9550332634;
	Sat, 11 Apr 2026 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqpCemMQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A325393B;
	Sat, 11 Apr 2026 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775893191; cv=none; b=fhyAocwYuWz6A4S1iI89Tb83+aLNlKBioo2PH7/yK3GabNf0IVN2prgm+MsgP1r199TQGB9SbhjUGzGHCVLU4hl6Wf+JWKr29ZxZZmB+GAd6VS+iml3h0JgbRrOyZE3Sh95Au+A9szwet12gHDKJqQX0OHyTS13z7A/nTiG9E1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775893191; c=relaxed/simple;
	bh=yvEmeIb3VoEuclqDPGg9CUH5w0Of9eqWWWBPUSlGwL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6F3158oeeUJvDIjYm+g0fHP1Pv4qW2Y1gm1OysbOjPYMi1v824O4afPpA7/OnC5Lbf1H5PhTYC5j9iwlDiE0CjcHi8Ge293lBzoeYmb6LTUNTydyX2B0CzSepvP+0wO5siyYwkhrLe0us52P58hHG0MaXM0TWXTsjWqRnbYW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqpCemMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB9AC4CEF7;
	Sat, 11 Apr 2026 07:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775893191;
	bh=yvEmeIb3VoEuclqDPGg9CUH5w0Of9eqWWWBPUSlGwL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mqpCemMQtI7CeEB5nP1ZJNdQDOB9/woQSwFq+6rNbHCwv07e2zkWaS+N+HNFXS03m
	 OUFubnTx44Maf7+tKeQH628TYIDx+ACaHbUFWtzkRnGsqyGy5MG4rWvUPe7BmRL/Rk
	 zBsDUsHS4FznaboaDz56etUJttxQ7faqKUXZkXu6LvzFz2XXq0MhFQuEabdEX4nxvo
	 0V6jFBpvWQ5jttgUyCwxJU7tbEzK7/wfCDpX9QyL0CS5Dokogx0OFKiSoxUBFtBaGP
	 BWLiK7gDNewZgUum8Fhved5EbbdlS/lxyYFdpSFqfoag588CbjU9lQl6WiN1CvkmoQ
	 hwg6L0TWIjv0g==
Date: Fri, 10 Apr 2026 21:39:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: cgroups@vger.kernel.org, chenridong@huaweicloud.com, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, mkoutny@suse.com,
	syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] sched/psi: fix race between file release and pressure
 write
Message-ID: <adn6xRNYwep9dQyQ@slm.duckdns.org>
References: <adlL_QXVAgCBH9L8@slm.duckdns.org>
 <tencent_851B66256EBA58BB8933329E6D1BD54BBE08@qq.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_851B66256EBA58BB8933329E6D1BD54BBE08@qq.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15223-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: E8C123DEB61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello, Edward.

On Sat, Apr 11, 2026 at 12:25:47PM +0800, Edward Adam Davis wrote:
> > > +	ctx = of->priv;
> > > +	if (!ctx) {
> > 
> > This test likely isn't necessary but that's pre-existing.
> Where?
> Are you referring to the check for of->released within:

No, I'm talking about of->priv. I don't think it can be NULL while a live
cgroup kn is locked, can it?

Thanks.

-- 
tejun

