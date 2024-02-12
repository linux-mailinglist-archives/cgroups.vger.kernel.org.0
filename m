Return-Path: <cgroups+bounces-1421-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A78851772
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 16:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E0D28327D
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60AE3BB35;
	Mon, 12 Feb 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MvvqIR95";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MvvqIR95"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346F39FD5;
	Mon, 12 Feb 2024 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750040; cv=none; b=qwEsrw+UjD02wM4oEc2TvkSBTtClabuk9y1nCgfNtoirZ/FW5HUrxBfsgY1RT1lyWqLu+JfURvtlfV5p96dBhBd6YDpBRnVIKy/MKpumIGf7Pf1kv2ZRx3vysyDbMrU40aE/qQhGf+dlTMJGO7/WPybke40r9wJD3Z9+A3ar3Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750040; c=relaxed/simple;
	bh=zCA6YMIgfL2kSQYWwcG3dnu2KR4ZdNffoBP3LtJDiiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSJ3eMR5aG6pdae+54Yz6ikEw6UkH5ZCDhVsVG2D2WAwK3I0p5zUEzCnDPnBCdRPrRcvFjC2qp7pXAEFFzQtiy0dqDTJEBedvcrjg46ojqJe1RL+jk95MRqVh25RAXVdvTOM1XoxuPVIGe72elT5UOUth5IiI7fGDk5oOSfYqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MvvqIR95; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MvvqIR95; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from blackpad (unknown [10.100.12.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2643721BDD;
	Mon, 12 Feb 2024 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707750037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zCA6YMIgfL2kSQYWwcG3dnu2KR4ZdNffoBP3LtJDiiQ=;
	b=MvvqIR95yBP75tWFFy1E1AQN+7JSPPgRSEt6Mv39rfeUc6lnAA1+ajIgsxDBV2O3pfCrMf
	hunvnm68UfdHJTa/XZ5WtpnzS3ACHsonwVULiwzLCTQxVvSOJL1ERy4mupMUaSdc+QnZHG
	nKfmBE0Wg2ucd43Je97aRJ2o/WOC9pA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707750037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zCA6YMIgfL2kSQYWwcG3dnu2KR4ZdNffoBP3LtJDiiQ=;
	b=MvvqIR95yBP75tWFFy1E1AQN+7JSPPgRSEt6Mv39rfeUc6lnAA1+ajIgsxDBV2O3pfCrMf
	hunvnm68UfdHJTa/XZ5WtpnzS3ACHsonwVULiwzLCTQxVvSOJL1ERy4mupMUaSdc+QnZHG
	nKfmBE0Wg2ucd43Je97aRJ2o/WOC9pA=
Date: Mon, 12 Feb 2024 16:00:36 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Jan Kratochvil (Azul)" <jkratochvil@azul.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, containers@lists.osdl.org, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] Port hierarchical_{memory,swap}_limit cgroup1->cgroup2
Message-ID: <ked455hccs23ghrqug3ieqck6qmmlip5htgszjvz7n3cvhvaeo@7kkg6faezy2a>
References: <ZcmaPqZ9HzoN0GFM@host1.jankratochvil.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="udftjw4lcp7jj2yb"
Content-Disposition: inline
In-Reply-To: <ZcmaPqZ9HzoN0GFM@host1.jankratochvil.net>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.95
X-Spamd-Result: default: False [-2.95 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.975];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 BAYES_HAM(-0.05)[60.57%]
X-Spam-Flag: NO


--udftjw4lcp7jj2yb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

Something like this would come quite handy.

On Mon, Feb 12, 2024 at 12:10:38PM +0800, "Jan Kratochvil (Azul)" <jkratoch=
vil@azul.com> wrote:
> which are useful for userland to easily and performance-wise find out the
> effective cgroup limits being applied.

And the only way to figure out inside cgroupns.

> But for cgroup2 it has been missing so far, this is just a copy-paste of =
the
> cgroup1 code while changing s/memsw/swap/ as that is what cgroup1 vs. cgr=
oup2
> tracks. I have added it to the end of "memory.stat" to prevent possible
> compatibility problems with existing code parsing that file.

I was thinking of memory.max.effective (and others).

- no need to (possibly flush) stats when reading memory.stat
- can be generalized also for pids controller (and other "limiting" control=
lers)=20
- analogous to precedent of cpuset.cpus.effective

Whereas, using v1 approach in v2:
- memory.stat mixes true stats and limits,
- memmory.stat is hierarchical by default, no need for the prefix.

What do you think of the separate .effective file(s)?

Thanks
Michal

--udftjw4lcp7jj2yb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZcoykQAKCRAGvrMr/1gc
jrcRAQCmHQ3zahZOyBX4mYSsgAGeyZnpqwR6DtFU4iC+td8H0gD8CMLymLYdXAGC
I89BNel0pL7qDQzxSuSAVFvoyZhlRws=
=v9Sh
-----END PGP SIGNATURE-----

--udftjw4lcp7jj2yb--

