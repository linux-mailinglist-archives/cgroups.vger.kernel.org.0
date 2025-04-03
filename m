Return-Path: <cgroups+bounces-7327-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F59A7A2AD
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 14:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148621893922
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 12:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F422924A050;
	Thu,  3 Apr 2025 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O99Qjc+g"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D261B1519A7
	for <cgroups@vger.kernel.org>; Thu,  3 Apr 2025 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743682864; cv=none; b=chMyrf3SU9dBZSc5fPCOSdQXDaBYyTN4MDkCG6PUk6Blo4E+DwXX6vsBTr7or39PJxt9Lh8c1uPRZwD703289ozhOJ4uHiBSaIN3GDmEKvVevFktjQgMv+IrtB5bHFXwwUvdbpK1Rbs+C2rEWyBaGUWStKR+BAMgGdRhF2+mNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743682864; c=relaxed/simple;
	bh=nJPKgA+fqkGF6OwUdH6F0ePVjgCHov0wDAmt/5tT4D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxmdJlqxcxm/uvzEuIVr9aVQ83al9C0eMe70ELIBcjbu3zJUdeKhu3R30rgldh+LaXOS63UEYhxxdDOpTdUTf7Ej2aGsCkl1qNWWh8zGcY8G49px/jl/D7Ijn2Il82U3uMvVvIqBnYsmTrCHh91hf0TuK5xu9o0vuOILLjRcJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O99Qjc+g; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso5540525e9.1
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 05:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743682861; x=1744287661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxGGnpHSon1brCmtfpj995Ux6sFy5/VZq0EMOjpmwcQ=;
        b=O99Qjc+g0exMANvQPDcLs/vSY3g4B3/c13JsGK/rBBf2d9LBRYjeyLTwIZBxd9O5ak
         fqdrnWAB1rI+OKhzJL5V9RxaR4irauEc/ThEM5ik8e7HihyyWJPb89UZZzLViW8QOcV7
         w4k0o/krAgIwv29a8YZzQpR9izWJB4941gBbKgh+ETRvZBwImyo/NK/t+3oFz5yt/8pY
         8R81yig+su4hmE6lc4DmUCrrPfDpe5Z1fG327Rc99tFaI7Nv/vmCQk9yeLbdO9MIU4OM
         xcVAvIPKZKZC/58aZu7gGAO7MGS8B7VBgUFI/mG06zUuG8Yo0RzkXEKGxjy2ZFwhwIeL
         2ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743682861; x=1744287661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxGGnpHSon1brCmtfpj995Ux6sFy5/VZq0EMOjpmwcQ=;
        b=ACoAX4CE44fZslRYkYIaQ+dE/TLmfY4HN37ptbp8LyxL/6T2NvUR3fBRILJAjReqUz
         fHbf2GzPlMBCSigTTJaz7mqAngjvCnSqvNiw9i0BLRoq+7EEzDzIjTOXvF8y6APE8l4R
         ixG6v8kwXgFXpZd+EX5O1LBBXkQDYEAZOraZi3lnSLKJCOgML3pUym+4hcs739yMwJLk
         ZH2rO6+bkuGLGdvojsn1UPSzHST0MzchCGgUk8c3HevRgX7h2EZVnIGRWkNSOF28moef
         J6XMSWr7MDGaFrsd06kSjQGaL8cjc60e9cVI2vFHN09QtBO5DE+/VzNrAiU7hCdVIOB9
         3VjQ==
X-Gm-Message-State: AOJu0YxLal0LM7HQxbS1mQGt1T0bMLMCl9PHnkKU6Y6HaaZJUtzZAfvD
	YXwsJIGvX//B5AFn/6SvnlCtLj2kCu1cP7kia/UeFgGLugWIH4nuAk/ImnkHRfo=
X-Gm-Gg: ASbGncsbLsmM8y0yQ3B5pn5FKrr81R5xIfFfee1lweXjUmKTElkqjTOihjguDOAfm5Q
	YHhal24oQVdoW48xb1Q8+cRqJ+sEVwzNRpOI0Sh8DJ4AdVPQFlGak8bFUI0TDwVi6PdZKGbQB4U
	QAB1O8X6FOpOzNYoQ5fxqoyuSvEWTa18JZ4OM34+Xc4EHcUCIgvrs9xt3m25Haaqj99100cxnr/
	+xTqEKFU1SsfNH4/WIU12xKqZkTB49szfCqISiWHT8pWA1JR7fZaisXdkjVnPVjFa9of3tgZPBv
	IQYh7663RzbrJ7SVy2dh6ci57spnuEPiNr0HG52v9X4eQjisDLNVP0jINw==
X-Google-Smtp-Source: AGHT+IF8Rk8S8kxFyorNaE4NcvfztKCcHIw0MGY3NBfMq6CEJ12nq53xnrOSozVX3u941hPlqCIo8w==
X-Received: by 2002:a7b:c845:0:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-43ec3c7ad9fmr18360355e9.0.1743682861156;
        Thu, 03 Apr 2025 05:21:01 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b0a38sm20154215e9.34.2025.04.03.05.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 05:21:00 -0700 (PDT)
Date: Thu, 3 Apr 2025 14:20:59 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Frederic Weisbecker <fweisbecker@suse.com>
Subject: Re: [PATCH v2 06/10] sched: Bypass bandwitdh checks with runtime
 disabled RT_GROUP_SCHED
Message-ID: <nt6pfc3lwud2k3eakjr7qutseuhtislao4jr43a5355tjqnbnb@6deb5jxmwadr>
References: <20250310170442.504716-1-mkoutny@suse.com>
 <20250310170442.504716-7-mkoutny@suse.com>
 <20250402120221.GI25239@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="imnhiqp4gmwjyoyh"
Content-Disposition: inline
In-Reply-To: <20250402120221.GI25239@noisy.programming.kicks-ass.net>


--imnhiqp4gmwjyoyh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 06/10] sched: Bypass bandwitdh checks with runtime
 disabled RT_GROUP_SCHED
MIME-Version: 1.0

On Wed, Apr 02, 2025 at 02:02:21PM +0200, Peter Zijlstra <peterz@infradead.org> wrote:
> Can we make it so that cgroup-v2 is explicitly disallowed for now? As I
> said earlier, we're looking at a new implemention with a incompatible
> interface.

I meant here that
- rt_group_sched=0 -> cgroup v2 works but there's no RT group scheduling
- rt_group_sched=1 -> cgroup v2 doesn't work (prohibit RT tasks in
                      non-root groups)

I.e. there is no new function for cgroup v2 besides that it is possible
to switch to RT group scheduling (with v1) without recompiling the
kernel.

Michal

--imnhiqp4gmwjyoyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+59KQAKCRAt3Wney77B
SQsGAQDn/qfkAqSvqnRnNexhtvf0Zdy8JbTGe5y8kt1fm+dCaAD/VO2Dhm3VAbtE
1dJ89MnaNMVsVNoX+XdeXxV8tLgAng0=
=K6M4
-----END PGP SIGNATURE-----

--imnhiqp4gmwjyoyh--

