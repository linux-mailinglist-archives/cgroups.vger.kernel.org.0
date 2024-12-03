Return-Path: <cgroups+bounces-5744-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4459E1CC4
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 13:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C7CB2687A
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B307D1E3DCA;
	Tue,  3 Dec 2024 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nbzs8tuH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848941E1C33
	for <cgroups@vger.kernel.org>; Tue,  3 Dec 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229106; cv=none; b=Pq+T/KRE1RKm2H7r8umTCHr2CYkubQPzn962oq85jY/dU0cCuvQCNW04N+wNSTnN0yYpBQuaDyo6q/+hEJTQyoAOF8QBfgtt/5moExjgxhW9epnLBR2x2B8ptROw3/iuuJMXwKPq5lVkZVW+b+QV8WVKcP/bhK/cwsJ4EyOIxa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229106; c=relaxed/simple;
	bh=71RVm4jnhzuql2pIE4eBzII2aWtBSSvxUgiJT7K0d4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNcy+Zet61mJE/jnp+gcTUPmmLYFzPnMh3GRsbhdgeBDOHO5H01Y+GTcsq86T/IDdNs+0Vcyipo63AyaJ7PvkOjbs0nB98jqanx4zbQ4LFr7KSAs5AT5KniiZUoJt6sSBdDmOuq4JCbu8OyeQhRvi9dgbLH9WPtLxLLqIQopUnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nbzs8tuH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43494a20379so44797895e9.0
        for <cgroups@vger.kernel.org>; Tue, 03 Dec 2024 04:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733229103; x=1733833903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=71RVm4jnhzuql2pIE4eBzII2aWtBSSvxUgiJT7K0d4Q=;
        b=Nbzs8tuHcUpJyVR372BeKfO+33GwJoCkxnzWYJTdtvF03Ohps1HPF3eCECgiqdEav+
         wjL70BO8+P2UB9svQS0nyQEIxIVnWl8p2538o6Eu40W6XsaIuQZncw7Q44Z8iVhR0mR+
         MrZLn0ja3XEUqxduxPmRP3Za0SfUdPxIK+AHgD+wTiQEGdVMIc1m67fLUt2fCesjl1HJ
         6ha+eR7Kyt3E18FteIh3uevkVuSIFribh0ckgh7bFiN8uMzPfDDtNzbUfrZLqUw9AjL0
         USYDuBbeq9vZuUOC61ovcWLmDi6e2fovESHhL135wwP0731Z6wPF4ShhtsIgIX/BjF53
         1ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733229103; x=1733833903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71RVm4jnhzuql2pIE4eBzII2aWtBSSvxUgiJT7K0d4Q=;
        b=mAuX5iNaJ+l/Wov1TuZOneeYdSG3ZPNGAHc42rfwfnATU/t3ep2axxV9FaDsB/yOFM
         lKbpHfis6mAA2OmT2ZShevdKstoTyDkAc+wtLgLiXgZgBfWfdKgE+6cm8biz+Tx8dUqv
         0U+Rw5FgNRIWVSwiAiTe7hg7jp3+X19qwn7WhHIfmJ5BiqWH0hOkO+R6as2GrIi3m+ia
         vTrNXUsP5aFhVW/qGb2QbvrltBPy/7H/Ei2JgLZ+hptzqIXOQoV8r34Dv7whYdVs9UhP
         +h0tCxGqEza26gsuwz8v8qJ+b1Pzgg2qlznv9psuVZAXsUbG3ZeUTu7gplpWGtwLHpZb
         3u7g==
X-Forwarded-Encrypted: i=1; AJvYcCV5ngD4ipXwg3fkxdyG2pwB7jLaWx4YaSB4kgbOWmQAV3477YOoMQv7DhbWiXPRsSrh8LJP20uQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQJvbm3e+px42PdvPHJ3QKK7uQGhmAgb+Cx1B57BrY7J0bIcL
	3i5NE/FdPKR9rfNEPdVCbCT/1t3uP8YPm2iVCNXIEDir5sCK84O8uGxu3NraS2+vEZM6MuZUZvk
	3
X-Gm-Gg: ASbGnctH75S1fHNzP/U2hMwK9s8UliQidfE9lCQLJ0WVnmlHE31Nsum+dr5XZtccDDX
	JqcYIZ3KomZ2OwMyuA5POAXE9gPuEDqGkWunHIlTU9lQc3LxYVzVh9v98n2YwWguN9eYfDvwv/J
	+RcuPqRc9qxQ2XQLaszzMUjeATEU4pwho7ENclTyTr3S+4eBR6myMCvy/gvFsggbfDSTAbNuTX0
	iW95MBHPH0XioR4lK/BIHX0UkWHJEwADloHTa2vrjJlQWJY6xOw
X-Google-Smtp-Source: AGHT+IHUGEnXul1z6h01353jiiorSwSKWZVta/CMetAn5st8zarQxCzltNJHvFkgNKq/TTMW29B7ww==
X-Received: by 2002:a05:600c:3502:b0:434:a902:415b with SMTP id 5b1f17b1804b1-434d09b647cmr23796755e9.10.1733229102878;
        Tue, 03 Dec 2024 04:31:42 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm185474395e9.15.2024.12.03.04.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:31:42 -0800 (PST)
Date: Tue, 3 Dec 2024 13:31:41 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Remove stale text
Message-ID: <6scvm7d7pcwtgo3gqu6jxf6ht6qcr2rnmmdwnhpopkd44gayej@ussah6oaxssn>
References: <20241203095414.164750-2-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hlz2riwuijrgz4t6"
Content-Disposition: inline
In-Reply-To: <20241203095414.164750-2-costa.shul@redhat.com>


--hlz2riwuijrgz4t6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Tue, Dec 03, 2024 at 11:54:13AM GMT, Costa Shulyupin <costa.shul@redhat.com> wrote:
> Remove stale text:
> 'See "The task_lock() exception", at the end of this comment.'
> and reformat.

It seems you've read through the comments recently.
Do you have more up your sleeve? (It could be lumped together.)
Unless it was an accidental catch.

Thanks,
Michal

--hlz2riwuijrgz4t6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ076JwAKCRAt3Wney77B
SQ3nAQC/D8tHiSjgJUFAf/I5kkvmZ98SUWI+t+N9ynF6TFJzTwD7BzbtDxUKY3QQ
ydLSSdHdUZ4H9BGBvnIennqoYyjCwgc=
=OV8p
-----END PGP SIGNATURE-----

--hlz2riwuijrgz4t6--

