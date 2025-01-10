Return-Path: <cgroups+bounces-6084-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAB4A08D52
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 11:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EFD91888A36
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 10:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7527720ADF6;
	Fri, 10 Jan 2025 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SHAWo0DZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2DD20A5CC
	for <cgroups@vger.kernel.org>; Fri, 10 Jan 2025 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503498; cv=none; b=tUQ2tCRz8id59exuoM3K3Pbr7bBkynfxO+FuX68rFiXK1QkboBzFwcWfyqN8kzT1gmf6OEORR9Da2bmqkA/hFkJX+M79U1NqdikE0swoVIslPKM1uqrvV9MMQWCTbNJsQ5rJISQbzO14+FiwtaqLQ1sqlTQYBKlwhP2584PqxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503498; c=relaxed/simple;
	bh=kH4fvLIBELsr2V98K0vQwkDPMob6FoTquMtwNrDrhNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qI8yiPX9hnFxYLuQPY87+WhVmG3KC+ZeBPX9b/BjJKPnTEeRMz5rYdlVCToLyubpOg/gIO/A5oykc/BumRiWH/fdpMFhH6j1qxxr+c2FKk5AE54+ZLBZWGhd700NSlzqipW9rqTa7An09/ngc5vOg3xyfkZ+FaTBp95MUc48Lms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SHAWo0DZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38a8b35e168so1172982f8f.1
        for <cgroups@vger.kernel.org>; Fri, 10 Jan 2025 02:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736503494; x=1737108294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kH4fvLIBELsr2V98K0vQwkDPMob6FoTquMtwNrDrhNA=;
        b=SHAWo0DZACy/CpadgP+W8AOipgtt6HiQszaae2d4QoTLtSASOOvb+fw7o27Dp4F2eH
         MFPAvFfz3/zQS8jXrxkXXhghZ/7GZ5Scolc4qVC7gyKAfwK2Wh0uaYisnpwrilgHhmjd
         uUEwUrZoqWH0DCjpHorEhlP0LANhWotzkU8td845cHeBtjiBxJFHcfUkclYaf7KL0nes
         VU7m3Kvqui+I+TLmIghzBJRqVDmjcOcGsqeaND3F8+Dza6SE4G1rLgRhb186rBp4zQyx
         r5hKqO7BwZ15QxMtWDfHdb7puA2ROvsr1E6UiPVcfZwNy25aSZ3uu95WYoQXPVk5g870
         sF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736503494; x=1737108294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH4fvLIBELsr2V98K0vQwkDPMob6FoTquMtwNrDrhNA=;
        b=O7NbyolTiyXNggK5CajwKf1fmtEpwPqzDvfRpGoDqHjfvxr/nJVp7e4tGf66caRpCP
         6Q4I83wi9t57+MpszzNYHpqB8mCzCEcbErhcqxPMlR9gHrZsxF6XCqHz8K3xzwci2VhL
         KwQue+r+T5KIj5pK1xmngrxcBZfu/ISOuXyJ0rF9V6KMbUI7RICk3p8WiTWePCb6/Rxi
         UCFbp3QqLZ+NE4QP0Zje8HujQl1l3MQ9ehZZclmQaTI0chZiL7DVIE5ockWpYrk2xB+g
         x48LGwJ6YnDUva+hfvKQ0T4iMUqOvKWK+ccscGle7P6DHBbJH1JI4erAinQAYlsEUOzx
         CWVw==
X-Gm-Message-State: AOJu0YzS/fW8p3WVWjVZMSapTj+nXeeqs+f+kuFfHIjWQg0zYsDA/jGj
	DNsEFm+mlhqHE0qcIcrTWoiGif/r68zxnJvCfZiTlEsQzAQlS+Pmz0bDAWfC7u8=
X-Gm-Gg: ASbGncukd82pMrarG7aQEhySZQIwT86vAx9zZyC2CxZWV1VZQHSJXjwMIrcrL1//e9B
	1Vm/w+K0LqCnvdVOWwaYkDHAWbxW0jihaWn9M8vQA9FVxIFfHRhH6uE+S1lVqhXjwFnWATJKuKa
	G5aMbDEUq5JKGZGXwLUTsCo1uiU4cyzt9WfAsQ4W9qVh9dll6GiVkz1doCcmH0CgnvxEBdxmrmp
	hVsTmAsRnr4Jo8yyfBaH4aIPYMOSwvyXfMrhbVwHMh4ui+rTw==
X-Google-Smtp-Source: AGHT+IE2XhPisMQORYsqPfvuJ3ueePRvavMBjBimZX1+AjeKIUbdoXJDX8DAZeDqRoSqfVURKjcDmg==
X-Received: by 2002:a5d:47a3:0:b0:38a:49c1:8345 with SMTP id ffacd0b85a97d-38a8b0f3005mr5165679f8f.18.1736503494404;
        Fri, 10 Jan 2025 02:04:54 -0800 (PST)
Received: from blackbook2 ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c006sm4077782f8f.46.2025.01.10.02.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:04:54 -0800 (PST)
Date: Fri, 10 Jan 2025 11:04:52 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Frederic Weisbecker <fweisbecker@suse.com>
Subject: Re: [RFC PATCH 0/9] Add kernel cmdline option for rt_group_sched
Message-ID: <4eqnoqtpk2gbrr3cgukm672eljyrl7us5ozuy5q5ib2ln7itzf@bg3kt473ly2l>
References: <20241216201305.19761-1-mkoutny@suse.com>
 <20250107194106.GB28303@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p7mwmudtgjbftxdn"
Content-Disposition: inline
In-Reply-To: <20250107194106.GB28303@noisy.programming.kicks-ass.net>


--p7mwmudtgjbftxdn
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/9] Add kernel cmdline option for rt_group_sched
MIME-Version: 1.0

On Tue, Jan 07, 2025 at 08:41:06PM +0100, Peter Zijlstra <peterz@infradead.=
org> wrote:
> We all hate this thing and want it to go away. So not being able to use
> it is a pro from where I'm at.

I understand and to some extent am not a fan of it neither (we had
disabled it in SUSE quite some time ago). I'd consider the remaining
existing users legacy.

> Sadly the replacement isn't there yet either, which makes it all really
> difficult.

Exactly. Thus the runtime switch is meant as a bridge for general
purpose distros where a kernel is shipped pre-configured (i.e.=A0one
config where the default is non-grouped not to hinder the majority use
cases).

Considering the legacy usecases on distribution kernels do you oppose
the chosen approach? I can work on changes if you have comments on the
implementation itself.

Thanks,
Michal


--p7mwmudtgjbftxdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ4DwtwAKCRAt3Wney77B
SQF6AQDMtMVh3cjNY+qVeii/URABnN4ut4H3zC8Tl5f0m9u+aQEAxB377eHecG/d
rwFCrc8Lmh6xLfYMCkhad2rhae4mAAc=
=ImQf
-----END PGP SIGNATURE-----

--p7mwmudtgjbftxdn--

