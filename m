Return-Path: <cgroups+bounces-7989-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDE2AA754E
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 16:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59149817D3
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9391B24DFF3;
	Fri,  2 May 2025 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VSwMCIy5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75C35950
	for <cgroups@vger.kernel.org>; Fri,  2 May 2025 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746197298; cv=none; b=b43Odwb0sa8CjGm0D3SsfeILCzVacjqRHhTgvYsJuDrIkUYiwL4VQbqsJ+w86kgD7mTEO6w6OIIJ8wa4JU4Lu+l3rmy27s5Q7L5d+1D2nbq5v/jsAMkdF4pWFaVGJqCVSGswPRipP3ZMpmKwIaTQWkXs999guUQshPeKKtf1jTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746197298; c=relaxed/simple;
	bh=13Pg5ikX2JJEvpW5syZwxR8oHWGY0WQZqtGLTmAUjKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkvOeNuH22uwZTtSL7oIm+5ZPI7b27ARbornuT2Z0GcqCvJ6QQcKPoUzD1G+LZRu5G0dOgfheZGj0iQ6Vnt7Wof777+HCoALypF0OJh8Vvejhux5IK84kZ/0OiBSQtgiT/6tWRNthLQWFDFLEhKeatD5RJwYanro4xahoXQPUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VSwMCIy5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acb5ec407b1so334490966b.1
        for <cgroups@vger.kernel.org>; Fri, 02 May 2025 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746197294; x=1746802094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pnD2QgwV5GhvcqcEpVEKPNi1cezGAg3bSSiDo9kEBMQ=;
        b=VSwMCIy58BbIgRG+MRhXF96IPa4Tnr8G5DK77K1NRK8ikWmgZJ/imlAcHEjSIUfCMP
         5u36dk3mzPezwx9YzxMEBodeXDgq2c7oAa6r3uO5VW63yvT4Jp5Ldoqc/XUG5J1lkcnM
         RzOvsOzH4vsm3EW/lEx6RHz+Pw/u/VmmOxHGEnIb2UzpmD5OODp2EjDbsOSA+/wQ1icr
         m+FaBQGhIXY3NTenJDNzkMD5c0mZPl4fgPL6JKQL4DHLI8XKIOpEGlg3ACuUpT2OQdpE
         +LDNAx8sswNP7pbjqqwNRDSY8ciGHJSzXrROkPSJjyGYCGgyPuP05sEVqNZW4molgTDK
         6+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746197294; x=1746802094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnD2QgwV5GhvcqcEpVEKPNi1cezGAg3bSSiDo9kEBMQ=;
        b=gyBxadB9Nj17YI8oQVglnTOGrc9VNFDnmEH7/2gN2CFxMwb6YT2nCgTZaMhzYGJi+Y
         xsiPYi5Oq48PrpBaOedXiHMmb7k4atoDJax4MBcgQE2UD1+b18XEPMSmW7GfSGYbC7nw
         1R7+RPfgLvDzJ1eh0I0cUoV/nAsLLwXg4Mgh4W1D3zcfazT8HYDfY0u+qIYlyCEUp02n
         +oKsVYqjbRKurWUsa6LDhdb0DyqzUU254Rd8Xy1foklrejHqivWuDMEg1/dUaBwdIEiv
         8XwflhEJFlMdikQnfdD6vqbrwjdP1TI3GmP03jFpu4bOgSK2ntEHVZSaQGpkeI6ah9HE
         q6eA==
X-Forwarded-Encrypted: i=1; AJvYcCUgV0sa4bJW1URCv1jHO2OHvoivZPpcsIKlfhVOomPt8ujud/bVb/4Xr8ftnvMyOzNlBhy0rqJw@vger.kernel.org
X-Gm-Message-State: AOJu0YwwBJWjFJMkdQlsCFMA3/z3HdGrC6bhPbN6jDVrzzikyRfWjsy8
	T7i4klQYCjdfddIzm0uvA3CADMIryAl5mFGbjVTAjZWkJV3tLBNLvrneNbvQETI=
X-Gm-Gg: ASbGncvwC7TemkrzT7YkRMIOHyzUDSBmR/8caacvpZgKS3DtOLmgSB6c6rgf6wLA0v7
	DU/Du9knNBPD7Zc0Ntw66BQK6UBDL+06kh2lRURWtufJKwOcafiH8+EK7f2B6UAoNjyk6Klkrhn
	0dCezOzIO9XrmMeExl33ZtvMmwxIxH5TSrLCOwcrp5HGmY7YEGlZHz1Vwi6zBrx8/uPT5AICNhk
	TGzuz53cHqysqwW61Lul3kNgHMsHO8dHvNvK8Lc5bw/uTLMY2T14VwgbLpdyCoPb65PTV4Wq4jw
	a2lQWVVrGvNKUnFKSZzTcdzBAdjtpP4NXPyUj2PrtPE=
X-Google-Smtp-Source: AGHT+IEwVRCPWUe4R8INqTEd9yswuQOQv2KIQnaLFYPMCSbtQeuwiEoJkiUYJi7tG1t1kW8uBiSgdA==
X-Received: by 2002:a17:907:1c0d:b0:ace:da0a:2882 with SMTP id a640c23a62f3a-ad17aff7e39mr323110166b.54.1746197294371;
        Fri, 02 May 2025 07:48:14 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1894c01f2sm57995466b.119.2025.05.02.07.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 07:48:13 -0700 (PDT)
Date: Fri, 2 May 2025 16:48:12 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Frederic Weisbecker <fweisbecker@suse.com>
Subject: Re: [PATCH v2 10/10] sched: Add deprecation warning for users of
 RT_GROUP_SCHED
Message-ID: <pgbl3anqsqo7a3of7lyml4ynzf5jbpmgm23uokiw77x6qf3jc5@bhh5lvbnndkp>
References: <20250310170442.504716-1-mkoutny@suse.com>
 <20250310170442.504716-11-mkoutny@suse.com>
 <3sfn3j2l7wmsstzmtkxa7cyz4w3hmkdqya7nhdwrqlvfosoixv@q5wu2xluuwxf>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="selnpx3dp6vmsctb"
Content-Disposition: inline
In-Reply-To: <3sfn3j2l7wmsstzmtkxa7cyz4w3hmkdqya7nhdwrqlvfosoixv@q5wu2xluuwxf>


--selnpx3dp6vmsctb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 10/10] sched: Add deprecation warning for users of
 RT_GROUP_SCHED
MIME-Version: 1.0

Hello Peter.

On Thu, Apr 17, 2025 at 02:13:25PM +0200, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
> On Mon, Mar 10, 2025 at 06:04:42PM +0100, Michal Koutn=FD <mkoutny@suse.c=
om> wrote:
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> ...
> >  static int cpu_rt_runtime_write(struct cgroup_subsys_state *css,
> >                                 struct cftype *cft, s64 val)
> > {
> > +	pr_warn_once("RT_GROUP throttling is deprecated, use global sched_rt_=
runtime_us and deadline tasks.\n");
>=20
> I just noticed that this patch isn't picked together with the rest of
> the series in tip/sched/core.
> Did it slip through the cracks (as the last one) or is that intentional
> for some reason?

I'm still wondering about this so that the users get right (or no)
message.

--selnpx3dp6vmsctb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaBTbKQAKCRAt3Wney77B
SfFcAP9Ha+Ou8wzGxxXme3GgPN3QQ59RnSaOEtZZDkkYaCmBcQEAyAVifVY4lhW8
EH6E+WC4HT4DeiymGFiKCbfV4ZJ7TAY=
=zMPU
-----END PGP SIGNATURE-----

--selnpx3dp6vmsctb--

