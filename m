Return-Path: <cgroups+bounces-1693-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBF985A5E0
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 15:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC771C2121F
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0607C374EB;
	Mon, 19 Feb 2024 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CyOmQFXf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CyOmQFXf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F1A25614;
	Mon, 19 Feb 2024 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352957; cv=none; b=uCf2N4UTG7ciIC12wYNGRkTBiTtdNon9cSSJOTOO6hU847NmagoGFT9d3yLsCid1KvF01RjymD2RdA/U1sJRj3Xjy631Fds4RVgbIwSeE746BFKjbba5XC+NT61SozXhIFftoJrIpb9P8jJPeIQ5zD+Klsp40Prb5ykcSlWvfkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352957; c=relaxed/simple;
	bh=+92MW98XOXYBpDGx8mWcDGFrMsPAqOXoGejzwebjWB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHRUOrp2aLWjReDFR/NnL7m/Ygk5wpESE+Ojm+IF4JMzIMPxgO1mBYiQkWl0AfH+kF6PNa6CtB5xPrr0W81TrYCAMymm8h8p703ki3mNawriYwQvCCFvEqU3KLgqvsmFOD1wyn8cPND/5Z6Bef8idsITmHLX1dwt6TRswMRtQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CyOmQFXf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CyOmQFXf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2521B220FD;
	Mon, 19 Feb 2024 14:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708352953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ONaivgVj/kykIG/cXvY1zXXQU8tX6udCSGGm21f/RE=;
	b=CyOmQFXfzsrEpil59zjj1xDhLSls+8rhnUd/fyM34aCxr5PpAsA/lhdmTMzKx8PxdQA/q7
	ayNWDtsEGEmotEstGlETf4VqR4ofnEUf/rDEBI9rulMxzF4Y3fUs2Gc9IQLdPOyu7nf4iS
	BgP9ma7+xRaMwGXQbh0NsY2UwQa8aW4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708352953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ONaivgVj/kykIG/cXvY1zXXQU8tX6udCSGGm21f/RE=;
	b=CyOmQFXfzsrEpil59zjj1xDhLSls+8rhnUd/fyM34aCxr5PpAsA/lhdmTMzKx8PxdQA/q7
	ayNWDtsEGEmotEstGlETf4VqR4ofnEUf/rDEBI9rulMxzF4Y3fUs2Gc9IQLdPOyu7nf4iS
	BgP9ma7+xRaMwGXQbh0NsY2UwQa8aW4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E15D139C6;
	Mon, 19 Feb 2024 14:29:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mIwkA7ll02XNEwAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Mon, 19 Feb 2024 14:29:13 +0000
Date: Mon, 19 Feb 2024 15:29:11 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonas =?utf-8?Q?Sch=C3=A4fer?= <jonas@wielicki.name>, 
	Narcis Garcia <debianlists@actiu.net>, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] mm: memcontrol: clarify swapaccount=0 deprecation warning
Message-ID: <ch7mbvyfcvc5yswykpgj5i73okgt4dnovelqhpuv22puw7gpba@6vj6d2z2yhau>
References: <20240213081634.3652326-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ifpowlilw3jtc7ow"
Content-Disposition: inline
In-Reply-To: <20240213081634.3652326-1-hannes@cmpxchg.org>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CyOmQFXf
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.38 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-0.994];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.27)[96.58%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: -5.38
X-Rspamd-Queue-Id: 2521B220FD
X-Spam-Flag: NO


--ifpowlilw3jtc7ow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2024 at 03:16:34AM -0500, Johannes Weiner <hannes@cmpxchg.org> wrote:
> The swapaccount deprecation warning is throwing false positives. Since
> we deprecated the knob and defaulted to enabling, the only reports
> we've been getting are from folks that set swapaccount=1. While this
> is a nice affirmation that always-enabling was the right choice, we
> certainly don't want to warn when users request the supported mode.

But shouldn't such users be still warned about effectively unused option?
I think `return 0;` from the param handler should ensure that.


> +	if (!kstrtobool(s, &res) && !res)
> +		pr_warn_once("The swapaccount=0 commdandline option is deprecated "
                                                commandline

Regards,
Michal

--ifpowlilw3jtc7ow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZdNltQAKCRAGvrMr/1gc
juU8AQCiaPhuMzNBRds24LnLkLrdU13FWaz9U416QQSNSADfBwD/SBYoMGN5ze1k
0GP/LNuyKMEMrQa7zSRq6963II7goAY=
=Jopi
-----END PGP SIGNATURE-----

--ifpowlilw3jtc7ow--

