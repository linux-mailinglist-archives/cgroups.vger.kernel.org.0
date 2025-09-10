Return-Path: <cgroups+bounces-9872-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0224B51848
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 15:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547461721A7
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5490D217F29;
	Wed, 10 Sep 2025 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgJmIu3s"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDEB35977;
	Wed, 10 Sep 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512248; cv=none; b=l2/VdwPH0zaxwppHxfn9hBxodSfciqg6uGKISG6aFD6HiIwkeFtNPVTSF+EydLlkhzmALxsoY67egZaiFoPjfiXrcvHV/ObuCmMZBfvEFRPtKn2awH+mTsTtjumIyIxdzVZblSd5tjGGvk6uvg3zkxNrP+ZrTbm7h2DNM+xTzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512248; c=relaxed/simple;
	bh=qb6kI15oTJfRUux34RoBAq7bEV2NkwWFZHgrsdB3I08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLqYzNRhCEV6L8UIqevcZKuwsO7IqLwaMbOehdSs5RepLI37G2k4mCIbNwylW6LtjIIUPimmPbEV5B8MYPlNjxocUzWofdMJs13Og/R4MPYHgI7hCtOR0atC1j8CqNN5sjQT0v946uih1fkIHHpAe6ug+U+OI9fyK48WUniCFqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgJmIu3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F10C4CEEB;
	Wed, 10 Sep 2025 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757512247;
	bh=qb6kI15oTJfRUux34RoBAq7bEV2NkwWFZHgrsdB3I08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SgJmIu3sAC7m+L2SJFj1Gmwoa7WKUe/5ZUUfTpMIOc7wVuPaIFG/PAkWxbt64Moqk
	 lFPimdDtfHyufgQFv+3+LLw+N1Tqq9zBnzLrNeVjI8MRjzi1WWmoZpwq6c9okVODPV
	 /igG/kKaaPcUA9hfPFTiQigR8sIgldmVW8DxxSrQc4Q/dO+DlIaIThAl/AXFgFZW/I
	 OfymFr/YIi9ZDpBNM0ZcgRgPmoeA6vde7IVdqhx0OTrKm0dvgy8XyFis72MZWWYdcx
	 IZ/BkD5kCCi3mMFPKwaB/TPAPiheg7CXzVHhOkM22dwjcqdcZiLPFfeVCTZPYPBTZc
	 edC51lLaH4EKA==
Date: Wed, 10 Sep 2025 15:50:41 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux cgroups <cgroups@vger.kernel.org>, Tejun
 Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Andrea Righi
 <arighi@nvidia.com>, Johannes Bechberger <me@mostlynerdless.de>, Changwoo
 Min <changwoo@igalia.com>, Shashank Balaji <shashank.mahadasyam@sony.com>,
 Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>, Cengiz Can
 <cengiz@kernel.wtf>
Subject: Re: [PATCH 2/2] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
Message-ID: <20250910155021.418ac199@foz.lan>
In-Reply-To: <875xdqtp7m.fsf@trenco.lwn.net>
References: <20250910072334.30688-1-bagasdotme@gmail.com>
	<20250910072334.30688-3-bagasdotme@gmail.com>
	<6geggl3iu2hffdop43rtd6yp2ivd26ytfn4xdclurwce6mapal@4ve46y652dbj>
	<875xdqtp7m.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Wed, 10 Sep 2025 07:24:45 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Michal Koutn=C3=BD <mkoutny@suse.com> writes:
>=20
> > On Wed, Sep 10, 2025 at 02:23:34PM +0700, Bagas Sanjaya <bagasdotme@gma=
il.com> wrote: =20
> >> manually-arranged table of contents (as reST comments) gets out-of-sync
> >> with actual toctree as not all of these are added to it. =20
> >
> > Is this true? I generated HTML with this patch and the resulting ToC
> > matches what's in the comment.
> > =20
> >> Replace it with automatically-generated table of contents via contents=
::
> >> directive. =20
> >
> > Mauro, what's the best practice wrt consistent ToC and having it in
> > plaintext form? =20
>=20
> I fairly routinely get patches fixing manual TOCs that are not updated
> to match changes elsewhere.  We have a nice system that can manage the
> TOC automatically for us, it seems best to me to use it.

Agreed. If you use:


	.. toctree::
	   :maxdepth: 1
	   :glob:

	   *=20

There won't be the need of manually updating the TOC tree.

That's said, I guess very few documents currently use grub:
	$ git grep :glob: Documentation/|wc -l
	7

Also, it has some drawbacks, as you can't control anymore the order=20
where the docs will be placed. So, if this is important, you may need
to do something different, or maybe use things like (untested):

	.. toctree::
	   :maxdepth: 1
	   :glob:

	   pre*
	   main*
	   post*

> That said, if having the TOC in the plain-text version of the document
> is deemed to be important, then it needs to be kept and manually
> maintained.

Agreed.


Thanks,
Mauro

