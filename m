Return-Path: <cgroups+bounces-4068-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3629454B0
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2024 00:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F269B22AD9
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 22:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D513214D299;
	Thu,  1 Aug 2024 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X/xYmjcz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X/xYmjcz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFAC14A4DE;
	Thu,  1 Aug 2024 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722553088; cv=none; b=Ujv+MCrQZBnqLLZVfOklcVo4YME4tLtaDWZgHVkQ8toWfh/v0bE9NUXQZ6uxIgfGPGlAllFnynFTkMTp2mI+MZGQMLSGRI3SE3oG/raiboOaNCJD8eq/qa/sH+l/etxrodpd/LGJwGD7bDfmVpxc6XvCkzEi7LpAjXpa2UHcRHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722553088; c=relaxed/simple;
	bh=Qn8maADFXO+bT5IiTIRKCfikENUxTp3PLAQL+m7ZeA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aa1M4ShSTR6kF1jmQIXe8Qy6JFZkUwbae9gTMTsNNhQ6RRh/WzOvZ33PFSdYZXemFv8OdacHONeUHpc6ZpiEqat58ABRhsllxqlDzUBa+q0/R8tBQGDRg5ZmiRtI4AzRpIBuWCBrh14YwQwxyqUDHUj2JPZJBwL6TuNnNOyLzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X/xYmjcz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X/xYmjcz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2C1B219BB;
	Thu,  1 Aug 2024 22:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722553084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LrfpBRx2OlghlnQUP396vQ52rxWepmoXbexqsA06Cq8=;
	b=X/xYmjcz12jbl5/3YVMkSKTgLyyEi3dLakZekRU8pFzCqX1AOhXVox/8GvaguOEXbiMwRj
	h2f0lbQ0vn3co70X6VS421xoReKL7V1xM/g6zmOAUHINYcMX4M3iD9Htr8Yt71Maer3tB/
	bFxqQMIy9bbVuDBYQOWGWAhSsO2DTKA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722553084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LrfpBRx2OlghlnQUP396vQ52rxWepmoXbexqsA06Cq8=;
	b=X/xYmjcz12jbl5/3YVMkSKTgLyyEi3dLakZekRU8pFzCqX1AOhXVox/8GvaguOEXbiMwRj
	h2f0lbQ0vn3co70X6VS421xoReKL7V1xM/g6zmOAUHINYcMX4M3iD9Htr8Yt71Maer3tB/
	bFxqQMIy9bbVuDBYQOWGWAhSsO2DTKA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F17F13946;
	Thu,  1 Aug 2024 22:58:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IyJLIvwSrGYICwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Thu, 01 Aug 2024 22:58:04 +0000
Date: Fri, 2 Aug 2024 00:58:03 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	akpm@linux-foundation.org, 21cnbao@gmail.com, ryan.roberts@arm.com, david@redhat.com, 
	shy828301@gmail.com, ziy@nvidia.com, libang.li@antgroup.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Cgroups <cgroups@vger.kernel.org>
Subject: Re: [BUG] mm/cgroupv2: memory.min may lead to an OOM error
Message-ID: <iedonwzoqj75yeaykgovdufi53cu3ddsrqfhdfui5kgwlal6pq@mdeue6pc6byz>
References: <20240801045430.48694-1-ioworker0@gmail.com>
 <2527d5a4-de1f-4c93-b7ee-fdd6fbe2a6f0@kernel.org>
 <CAK1f24knBez71sEvcfFoFuyvap+=3LzsRrmW-+fLsqV3WkyMBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z3wr2ynnu36cbovk"
Content-Disposition: inline
In-Reply-To: <CAK1f24knBez71sEvcfFoFuyvap+=3LzsRrmW-+fLsqV3WkyMBA@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.70 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,arm.com,redhat.com,nvidia.com,antgroup.com,linux.alibaba.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -5.70


--z3wr2ynnu36cbovk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Thu, Aug 01, 2024 at 07:40:10PM GMT, Lance Yang <ioworker0@gmail.com> wrote:
> However, if the child cgroup doesn't exist and we add a process to the 'test'
> cgroup, then attempt to create a large file(2GB) using dd, we won't encounter
> an OOM error; everything works as expected.

That's due to the way how effective protections are calculated, see [1].
If reclaim target is cgroup T, then it won't enjoy protection configured
on itself, whereas the child of T is subject of ancestral reclaim hence
the protection applies.

That would mean that in your 1st demo, it is test/memory.max that
triggers reclaim and then failure to reclaim from test/test-child causes
OOM in test.
That's interesting since the (same) limit of test-child/memory.max
should be evaluated first. I guess it is in your example there are
actually two parallel processes (1321 and 1324) so some charges may
randomly propagate to the upper test/memory.max limit.

As explained above, the 2nd demo has same reclaim target but due to no
nesting, protection is moot.
I believe you could reproduce with merely

	test/memory.max
	test-child/memory.min

> Hmm... I'm a bit confused about that.

I agree, the calculation of effective protection wrt reclaim target can
be confusing.

The effects you see are documented for memory.min:

> Putting more memory than generally available under this
> protection is discouraged and may lead to constant OOMs.

HTH,
Michal

[1] https://lore.kernel.org/all/20200729140537.13345-2-mkoutny@suse.com/

--z3wr2ynnu36cbovk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqwS+AAKCRAt3Wney77B
SdQ9AP9aLMnZx3/4HGSUidBokh2k5NVbAqtBX6zPkBFpe48eSgEA8zZyvtnuUPW8
Y0FKs+Gg7CewHbz21JQzAJSjT6d77Qw=
=ij7V
-----END PGP SIGNATURE-----

--z3wr2ynnu36cbovk--

