Return-Path: <cgroups+bounces-1184-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8109C836B8C
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 17:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79CD61C2504E
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 16:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF5C3FE54;
	Mon, 22 Jan 2024 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BfN0cFW6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BfN0cFW6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CF03FE4B;
	Mon, 22 Jan 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936837; cv=none; b=nRdQROowWwqZ8pXdomf3njPtxBApafIyHUKM0bNQ6Pfx376P4xhhRW6WuIkyYOcfUxbe8bJNaO5frwNrU1OZow2XAR+kZWyrlf9sMJNnZf/glbW+dZBDpmCTvIRoaYbHRcYDgA6Oj8MhVItxbLuy0jY6TXGQ4NnFS2hXFN9sax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936837; c=relaxed/simple;
	bh=fVQWgn6dMqT65ij7t8YeQ++AxrnBH2Z/fCv+edloKhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vA2i6PxLHfZ650OaRs+YnVy0xmqnAtoD8BljTAux+GD9EDWNoijlgiJfIZzzVVSmS0o0Dct3VPZySmVNWfdvDurw6SLesenjbRNZnUJi+eHsZC+xcv2kI+rwoJTQAV9mN6+Y/9OBja2vsStFqOYkxEkholigkqQ5Bt4jmcYKcYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BfN0cFW6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BfN0cFW6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A497321FD4;
	Mon, 22 Jan 2024 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705936832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uI8H29046lEwAQaOE9IkKlCQkju2vmSs/MhQpFiaPtI=;
	b=BfN0cFW6Ucd4aMQdhtVQZBZPSYYOf8yTXNjWs9Yt1e3RVCU9MYF/u0BQLFDEqbZCCAsSM3
	cp+GEseEUKQn/4pro5nCyDA8Z9Vll5zOtxQkatPnUGk6G7CtDPIPRQROyuC342ETucdNsS
	wRJP1ACqRz+G2k0V5aAuku0KL2oDx1Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705936832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uI8H29046lEwAQaOE9IkKlCQkju2vmSs/MhQpFiaPtI=;
	b=BfN0cFW6Ucd4aMQdhtVQZBZPSYYOf8yTXNjWs9Yt1e3RVCU9MYF/u0BQLFDEqbZCCAsSM3
	cp+GEseEUKQn/4pro5nCyDA8Z9Vll5zOtxQkatPnUGk6G7CtDPIPRQROyuC342ETucdNsS
	wRJP1ACqRz+G2k0V5aAuku0KL2oDx1Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8808D136A4;
	Mon, 22 Jan 2024 15:20:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mP41IMCHrmU1ZwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Mon, 22 Jan 2024 15:20:32 +0000
Date: Mon, 22 Jan 2024 16:20:31 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, 
	Jan Kara <jack@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: writeback: ratelimit stat flush from
 mem_cgroup_wb_stats
Message-ID: <jazycqhefxn6oigmt6mitn2cfoonscbdwqxy5g7gs2j74w3ia5@qwcu3v7kmk4h>
References: <20240118184235.618164-1-shakeelb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nypkyt5neisq55gd"
Content-Disposition: inline
In-Reply-To: <20240118184235.618164-1-shakeelb@google.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=BfN0cFW6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.12 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[47.96%]
X-Spam-Score: -3.12
X-Rspamd-Queue-Id: A497321FD4
X-Spam-Flag: NO


--nypkyt5neisq55gd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Thu, Jan 18, 2024 at 06:42:35PM +0000, Shakeel Butt <shakeelb@google.com=
> wrote:
> One of our workloads (Postgres 14) has regressed when migrated from 5.10
> to 6.1 upstream kernel. The regression can be reproduced by sysbench's
> oltp_write_only benchmark.
> It seems like the always on rstat flush in
> mem_cgroup_wb_stats() is causing the regression.

Is the affected benchmark running in a non-root cgroup?

I'm asking whether this would warrant a=20
  Fixes: fd25a9e0e23b ("memcg: unify memcg stat flushing")=20
that introduced the global flush (in v6.1) but it was removed later in=20
  7d7ef0a4686a ("mm: memcg: restore subtree stats flushing")=20
(so v6.8 could be possibly unaffected).

Thanks,
Michal

--nypkyt5neisq55gd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZa6HuQAKCRAGvrMr/1gc
jv0KAP49hs1sQx/Itdzma7JXdOKCH4l9eewELaaWxrVCyuoC0AEA3fgaAGcdTEMr
hwYxaHAKsxG38pb+QxHQjbOhmP/afgI=
=9ZXF
-----END PGP SIGNATURE-----

--nypkyt5neisq55gd--

