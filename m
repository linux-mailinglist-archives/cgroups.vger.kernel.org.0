Return-Path: <cgroups+bounces-145-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558F97DE46E
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 17:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36BC281327
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E4113FF8;
	Wed,  1 Nov 2023 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UFpQPg/+"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A266ABB
	for <cgroups@vger.kernel.org>; Wed,  1 Nov 2023 16:16:25 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C994EF7
	for <cgroups@vger.kernel.org>; Wed,  1 Nov 2023 09:16:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8552221845;
	Wed,  1 Nov 2023 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1698855379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pQH+TPyLxgkTJq7ImZfFmxTqdkd4TqoKAvM6ipQOUUo=;
	b=UFpQPg/+YgTqTPck4IAwJD/a5ddICXUdHcnvPqAJS3iWL/QPW0OXZgc2QJ1WKFFRZYEghX
	W5LgqtvSS69Xvtu9m6Sp4e4LFs8fT/3ss6IfF9yMdAid5g7oCu7QOI7a9sALWqLVlkcEAe
	PSlSnjPY3FAqIEEXlPLScpSR1f5iAuc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C62813460;
	Wed,  1 Nov 2023 16:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id q1aUFdN5QmUqPAAAMHmgww
	(envelope-from <mkoutny@suse.com>); Wed, 01 Nov 2023 16:16:19 +0000
Date: Wed, 1 Nov 2023 17:16:18 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Ruifeng Su <suruifeng1@huawei.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, hannes@cmpxchg.org, 
	linmiaohe@huawei.com
Subject: Re: [PATCH] mm, memcg: avoid recycling when there is no more
 recyclable memory
Message-ID: <4ljrvuomfzrh3bypphkp5wbdzbkguts2icwoonykwttg2axwtv@oqnwohi52nmc>
References: <20231027093004.681270-1-suruifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rh2j2t53ntltg333"
Content-Disposition: inline
In-Reply-To: <20231027093004.681270-1-suruifeng1@huawei.com>


--rh2j2t53ntltg333
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Fri, Oct 27, 2023 at 05:30:04PM +0800, Ruifeng Su <suruifeng1@huawei.com=
> wrote:
> The test result shows that the program frequently sync iCache & dcache.
> As a result,=20
> the number of anon pages requested by the program cannot increase.

memory.high can be a tar-pit (instead of OOM).

> This patch changes the behavior of retry recycling.

What is behavior of your program after the change?
And what behavior do you expect?

> @@ -2616,7 +2615,7 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
>  	 * memory.high, we want to encourage that rather than doing allocator
>  	 * throttling.
>  	 */
> -	if (nr_reclaimed || nr_retries--) {
> +	if (nr_reclaimed >=3D (in_retry ? SWAP_CLUSTER_MAX : nr_pages)) {

So this reads better as
	if (nr_reclaimed >=3D to_reclaim)

>  		in_retry =3D true;
>  		goto retry_reclaim;
>  	}

So it would unnecessarily overreclaim in some cases.


Regards,
Michal

--rh2j2t53ntltg333
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZUJ50AAKCRAGvrMr/1gc
jgyGAQCRDYc9FCwcEqEIuYJxggE6SB9RVoQJEJTkIxpo0dB0bAD7BFaOvnsp11sR
1KRFe7l9x++XPZP3HOq1dyUu3hrUXAA=
=0+N8
-----END PGP SIGNATURE-----

--rh2j2t53ntltg333--

