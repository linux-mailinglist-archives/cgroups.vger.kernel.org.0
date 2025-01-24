Return-Path: <cgroups+bounces-6266-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75706A1B28A
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 10:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5D316D987
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 09:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AADD218EB4;
	Fri, 24 Jan 2025 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fUap0/6R"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF61DB144
	for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737710579; cv=none; b=PYUCipc7mTipCKll86Fd993i5gKTvBmU+2pJu6IXWLKZnHYtJivluHzzBWZGwqyDcbZ0YWLLreubvvZNn14JScReNyGAgmuCqs5/fDYHYkvhBTfwOdI4Pbefksw+zJSbTtfDlasXME1UENvtXTbFvHkEoPa+QITuCRF7W+LpVqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737710579; c=relaxed/simple;
	bh=BbsRykMYCjEOKx7rDpeahHQv23T4QNwSld/rN7RPwss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPnZBVdqT2jChJKw00GhbFb1IIXZBl9n/46H8F+6yXzsVUBxQaWUayaWPN1H1OQwPgVymuFf6nnGJRQ94EwaF3ksJS5gSUHp2Tlhykqv9Esmtdc4Ku1T9qc/v5D+QW7d0nEzoTIh7pw2vw+wIQoY6FrlswcOafvJWAg5ONtYjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fUap0/6R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso19148115e9.0
        for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 01:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737710576; x=1738315376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9bWsbPziLBG/7e5Qa+ePdC6ESiy5rTCswnH/uw5eaY=;
        b=fUap0/6RxaPcO2PzRPDx08CKOnWltHs9eY581focOMF3FpQOSnRmLQGtGjteb9E3tV
         5QzWfTHqi2Tj8U1kwrI9VdvEi7tiJiRMxRyUxqcgboJtHsRo9PKJG+ZqM5QI6U3MwIuk
         YrHSj5vV9zT/VXt1B2j/VeuSNOLJtJIJwnuSCDechGGIKMYr7cQx7wGuaHR36+gXQmly
         PqQfD543jThB7in9Fbr9rIR9DycA3WteauwTbYwSpu2JMgKg9n/5A5rf/8yxh3xtTv/J
         vWSWz9HrLt+G7OzRahQ5iAAVyTqQOzu+FmM59fSdizXIYci6tkW6+mL7O2HzQQnWMtXG
         ljJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737710576; x=1738315376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9bWsbPziLBG/7e5Qa+ePdC6ESiy5rTCswnH/uw5eaY=;
        b=A5y42O0HtRKNlq1CyXghUM9N4nClOzgcbypM/UG7WzxH19GISMCLik4zcL0jtv9N8Z
         xJl/PSWRPV7jEz4kIPG+RCClbsFpTxEGXOp18kjv7ROwxkX2YkNaQ6BL1SsIvhgpD9EF
         hEx6H6i5Uopn6WEO4jcY9hG7LDleBD/MPCO6FiLX8fN8HCdXC49ijzOXQSEKvuLt/Xqi
         PgG6MDM5CK34Zg6zSvslpRJ1C3qUw7Q/SgWMAcPK8mHd33FRtel0mJlUNuqQ4uTmRh6N
         U5bXhvINToxQr3EWUnh2ey6Tvk0c9d8UZhultTQmc1JPR1UkVA7VXH8rNo2VY26zEnVZ
         KU4w==
X-Forwarded-Encrypted: i=1; AJvYcCV7D5ihizjSKbJD7hQipClC+AjNbXiNVd+PWyCU8vsOATVUSKIIrQ1ByPvfzYOFrOk/fS35CEIa@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGdyAdG0NVjJKqtSR4mAdAchOHPHx0eK5XbVXj7Hku1OFk3bH
	4z86E9hqt/tZKJhgWEqfhpjLd4MXATM4BrTC6a5S5amp/lQ2FATFOnCt0XVkRtg=
X-Gm-Gg: ASbGnctM6Cq7ANL8WNy231LHciwOfWGxAc03QxH6f0Cim3hEu8juZwq0q5pM/ZiHsH0
	I+pKvMZb/pZ31Bn1uC8hqbdybNwXQU23LmNLu0h70OmOFFFZVa1VnO2D7TYKwPWj51D5qHzgK1S
	3+gfAx+9RLe/OiHzom7Ub/TUI43OYq6ozOJocxAfE7P9DHxj+Pit91omhoK964I7gSHVzyZ3MNy
	Dm0RXywjUyMbmPtD9ZuKcCN9eMbi8aIUEsGP1NHpSZVhADuY7PHq7xbDRVBZk9htwux1KN3EEwv
	8JThW3I=
X-Google-Smtp-Source: AGHT+IFCv0eyiKtehn4II4+oph9TbabT8LdFIdP3h5yuguOk+MeNiApyBbpxlhqnpnT9+v/L616a2A==
X-Received: by 2002:a5d:5f48:0:b0:385:faec:d945 with SMTP id ffacd0b85a97d-38c2226c070mr6932255f8f.9.1737710575601;
        Fri, 24 Jan 2025 01:22:55 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb0d4sm2162149f8f.69.2025.01.24.01.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:22:55 -0800 (PST)
Date: Fri, 24 Jan 2025 10:22:53 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bitao Hu <yaoma@linux.alibaba.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Yury Norov <yury.norov@gmail.com>, Chen Ridong <chenridong@huawei.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] cgroup/rstat: Cleanup cpu.stat once for all
Message-ID: <2fenjyawa46abfrpcebluaoi6dd4z5v2y7pp7jyuu2oblmfmhk@reaaehe6pkzn>
References: <20250123174713.25570-1-wuyun.abel@bytedance.com>
 <20250123174713.25570-3-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="syvfmw22bmuvyaet"
Content-Disposition: inline
In-Reply-To: <20250123174713.25570-3-wuyun.abel@bytedance.com>


--syvfmw22bmuvyaet
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/3] cgroup/rstat: Cleanup cpu.stat once for all
MIME-Version: 1.0

On Fri, Jan 24, 2025 at 01:47:02AM +0800, Abel Wu <wuyun.abel@bytedance.com> wrote:
> -static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat *bstat)
> +static void __append_bstat(struct seq_file *seq, struct cgroup_base_stat *bstat,
> +			   struct bstat_entry *entry)

Not sure if starting with double underscore is needed when the helper is
`static`. Also something like s/append/show/ -> cgroup_bstat_entry_show.

Thanks,
Michal

--syvfmw22bmuvyaet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ5Nb6gAKCRAt3Wney77B
Sb8LAQCFszj1nUqoEGjfi5O5vLldmjO6b16rc7J3nw3bB2xTjAEArlXDdjEju8ON
7oESO8RLLV6Pu+swMBg+me4JS8deTA0=
=ibQ+
-----END PGP SIGNATURE-----

--syvfmw22bmuvyaet--

