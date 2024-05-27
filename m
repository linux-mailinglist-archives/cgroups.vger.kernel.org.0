Return-Path: <cgroups+bounces-3012-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 407BE8CFF63
	for <lists+cgroups@lfdr.de>; Mon, 27 May 2024 13:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFDA28255E
	for <lists+cgroups@lfdr.de>; Mon, 27 May 2024 11:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B25715DBAB;
	Mon, 27 May 2024 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tcQoCWGi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tcQoCWGi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11E13AA31;
	Mon, 27 May 2024 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810875; cv=none; b=ee9KnL9vwAwU2pxMnwu3Enqlko2FNZpsk9nEZMjgGX8s3+cZIwhF77/Fdqh6LXTwD9+YXt6ttjvRPhhtVpD9hIEE4cyANdIjun4IfLOS1JnidShpjPLBin6lH+/LfoxRrpgSDtha5kl9fWTUIzAZekJy1iYYBa5aOO7pq1bGODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810875; c=relaxed/simple;
	bh=MDDwVaq/e+nPokPn9D9X4IiCzdTxBX+6Ef8nUisB89c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdhOrPp6HgksPkZR6PCwSBk7XV1iLGZFfS0QbyC8o95dvnA79yLboXCNY8E+XD2LW4+gISulF/HKYdaGp9Os/JP6FN1pQVV5io2vCPb+t1p2IekFCwCSoQuXkXm9zHvN/zdxhcfTaBj7y+kqq4N1Ogy5MM0iDyPkO8cQj2k9gLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tcQoCWGi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tcQoCWGi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A510D21E65;
	Mon, 27 May 2024 11:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716810870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MDDwVaq/e+nPokPn9D9X4IiCzdTxBX+6Ef8nUisB89c=;
	b=tcQoCWGiJMkdjzenPniPoa+2BxfFCBsze4QDFAlezPqq1UsGrDznOqDLOBOE1vdBtkkGxe
	hSXRvJXtXPkFSGvVmbkkhKcHDBb9KkjRqd3cZJZWRnU5xiED9dYs/3gjf1erAGQsqTw0qZ
	unPSV8FVgAo/OS22d4xBCu74Wt7P0Eo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tcQoCWGi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716810870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MDDwVaq/e+nPokPn9D9X4IiCzdTxBX+6Ef8nUisB89c=;
	b=tcQoCWGiJMkdjzenPniPoa+2BxfFCBsze4QDFAlezPqq1UsGrDznOqDLOBOE1vdBtkkGxe
	hSXRvJXtXPkFSGvVmbkkhKcHDBb9KkjRqd3cZJZWRnU5xiED9dYs/3gjf1erAGQsqTw0qZ
	unPSV8FVgAo/OS22d4xBCu74Wt7P0Eo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99DD213A56;
	Mon, 27 May 2024 11:54:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PL1hJXZ0VGaCJgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Mon, 27 May 2024 11:54:30 +0000
Date: Mon, 27 May 2024 13:54:29 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] cgroup: Fix /proc/cgroups count for v2
Message-ID: <rwb5lqorevlmywo6da623oc4vacy3wjfxaokfx3it52fkvhrvx@qyef5cmd5sgr>
References: <20240519174650.559538-1-tjmercier@google.com>
 <h5xdtfh7dc4rjh74b4cwkpjszro73hfbxzdobwtivyx4hl4hyn@p5lp5h5gzjuj>
 <CABdmKX149mbOkjo6fwZdx1LKX+xXH1TicUx+92Ud99RS9hSy7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ypbevvviesi2cei"
Content-Disposition: inline
In-Reply-To: <CABdmKX149mbOkjo6fwZdx1LKX+xXH1TicUx+92Ud99RS9hSy7A@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-8.11 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A510D21E65
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -8.11


--7ypbevvviesi2cei
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 10:36:45AM GMT, "T.J. Mercier" <tjmercier@google.co=
m> wrote:
> On Fri, May 24, 2024 at 7:23=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.=
com> wrote:
> Sometimes? Take freezer as an example. If you don't mount it on v1
> then /proc/cgroups currently advertises the total number of v2
> cgroups. I thought that was reasonable since there exists a
> cgroup.freeze in every cgroup, but does freezer really count as a
> controller in this case?

v1 freezer controller and freezing implementation in v2 are different
things.
Before v1 mounting, the freezer* entry points to the v2 hierarchy (which
causes listing it as realized for each (v2) cgroup but that's not true).

> There's no freezer css for each cgroup=20

Exactly.

> so I guess the better answer is just to report 1 like you suggest.

It matches better the reality of alloc'd css objects.

Michal

*) Same for any v1-only controller.

--7ypbevvviesi2cei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZlR0agAKCRAGvrMr/1gc
jrqRAP9TQP6j5DmHoxLheRwnbqIY6gmYi7uqeFtypt2h0JJDPgEA+TjFacW3QA0k
c8Uy1NUReoZDyx4nhMhOQXRT2wFcygQ=
=Vtbf
-----END PGP SIGNATURE-----

--7ypbevvviesi2cei--

