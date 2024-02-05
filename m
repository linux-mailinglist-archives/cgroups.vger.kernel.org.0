Return-Path: <cgroups+bounces-1342-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12307849739
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 11:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F373E1C231DE
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 10:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B4812E6F;
	Mon,  5 Feb 2024 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hJsuQZCW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hJsuQZCW"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A74F14A9D;
	Mon,  5 Feb 2024 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127286; cv=none; b=OQWjU8KrYVter1UmTpH4UeMMQkkiKRtB4vjG4VNOlQrmntBWiaGsmwvPUuPG7Rggf2+cnVZwOq8EGa5a/hbJs0xY7N8wG4ItX2FClCRmfeDgn6GaV1MybPKcc6i+DwBRR8vcSbrmLqiPzB4qQ56AjW53zZ3xTMouFnF/a3Y9DZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127286; c=relaxed/simple;
	bh=+dO4EQD2SN1JdOP7Fx31tqo8rZeaPObie5hw9pjkLqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnG9EbseyhpjXdocFaYpnzn24C4vPcaLQbe6rTm/LEjvCKu11cyiQ2VtkMevFKXdTXob/gVVLevpgZW57SjShMpi+LYgm+GkQqklWeJ4li9DMs5LUh3WZLbZu1qGHFexQS9WVZ5wWZ5r/0pZEtfp2e99Yt7jZ6WRySgc1Um/86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hJsuQZCW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hJsuQZCW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from blackpad (unknown [10.100.12.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E95321E19;
	Mon,  5 Feb 2024 10:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707127282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3vjQXPNFinwCndTaWwm27IR9C5ek9C7awlooEYWzEAI=;
	b=hJsuQZCWGfg3SVvriUzh+Gkvam0W/gX9KovWxHTnAF0Q6X4ossNx1W+oHBVLiXz/vS9n5e
	V6HYCc10bVZ86CJXpajoPz2d9ViAImH0lgnisZG0LAS9DUSgBC4OkxzdnaE8NUqWUgTfb5
	FWWZQ0Wu7J4C378V4jO4eC9O9ENiVlM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707127282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3vjQXPNFinwCndTaWwm27IR9C5ek9C7awlooEYWzEAI=;
	b=hJsuQZCWGfg3SVvriUzh+Gkvam0W/gX9KovWxHTnAF0Q6X4ossNx1W+oHBVLiXz/vS9n5e
	V6HYCc10bVZ86CJXpajoPz2d9ViAImH0lgnisZG0LAS9DUSgBC4OkxzdnaE8NUqWUgTfb5
	FWWZQ0Wu7J4C378V4jO4eC9O9ENiVlM=
Date: Mon, 5 Feb 2024 11:01:21 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com, yuzhao@google.com, 
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: memcg: Use larger batches for proactive reclaim
Message-ID: <o6rwaeeriqerrvuaqd56tcmuincjuwrpftkv7qbdj73b3pfm6k@ipcysrxvoslh>
References: <20240202233855.1236422-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bdxp7foh36trvtol"
Content-Disposition: inline
In-Reply-To: <20240202233855.1236422-1-tjmercier@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.35 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 SIGNED_PGP(-2.00)[];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 BAYES_HAM(-0.65)[82.65%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.35


--bdxp7foh36trvtol
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 11:38:54PM +0000, "T.J. Mercier" <tjmercier@google.=
com> wrote:
>  mm/memcontrol.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

Thanks!

--bdxp7foh36trvtol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZcCx7QAKCRAGvrMr/1gc
jmhRAQDeN4bfnQOdKsp1nAqD9oe+Isq/qEV2Qe/TtQwJJ49uywD/cRBFnhvoCpMx
5Re+QJEUHMftXzJNz93qwKf0Ah/vrg0=
=6Jpj
-----END PGP SIGNATURE-----

--bdxp7foh36trvtol--

