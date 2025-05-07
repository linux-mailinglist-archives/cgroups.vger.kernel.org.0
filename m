Return-Path: <cgroups+bounces-8076-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D971AAE92B
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 20:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769393A8AF2
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 18:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436E828DF4F;
	Wed,  7 May 2025 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UtDQLosk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE95628C016
	for <cgroups@vger.kernel.org>; Wed,  7 May 2025 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643276; cv=none; b=H2TVda9+pdcL4/cVSd63bZ85XyKFLJSmDf8JBC14y1qKXXU37q2bjFhDB3QKyuR2kKpWiJOMdpt/sY2Uvq7IOVPtmIPjDQiQrgGj09KL+WatuT8COvA3FYTE7eR+3ebuqcIoBUmhTb9tmr4lvVhk7JnEq2mu8fKS8LOCWvV/R4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643276; c=relaxed/simple;
	bh=HZe78NtNOEeWzc6bIg2m6Fj5rRasr/I4okqe59f+dLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/8EhfYkcxNGdM/SQ16eqk/tU0Hp5mjzOuZ+FM8xubKObusuLhYHzVFf+/t0sXvpNFQQr96Tvrjol3g2rOAOUT6fRr5w83w4BcOR9lX+3XmbB0C8oZFRB64kCdGcDLN/qaZ6DkI8ZL9R10KqEt/XtgeQpC3A/IfH1NbYRHjVMv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UtDQLosk; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f5bef591d6so275282a12.1
        for <cgroups@vger.kernel.org>; Wed, 07 May 2025 11:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746643273; x=1747248073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QQcufmYmGlYXbTUSfmkiThdQ5Pnfz5q4bUd1Pt0wtBw=;
        b=UtDQLosk4bfP8A6kbKZZK34Aah18zgBVYJPcoZeYH7j8upO6YjsHKoo38DQEqRN+zt
         yaad8BMX4ZJ2LdmSLcWfg83ZfNRN4aftlnxpPXPY7ghVvL7u3BNLImzw6vAbkl8dTA2/
         apjYPiaigq91LyQ9lpXQLGbU/Kw0rx6U1kmDSSX9dW+BpxRHHe6YMYVBTyqriIBve22c
         X4E4MyEAQ6AUBDiKIcABPN0n9TBcZuLeS/5Q7ssj84HC7KT14j9wVe8hEQfPOSr49dYs
         W8PrIT0u/MV8wrW3tgKG1lx7VSkxEJFEFdeKmKrQMvJHM0+yrCmvEzpZrmZ8rpGkW8ov
         0MSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746643273; x=1747248073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQcufmYmGlYXbTUSfmkiThdQ5Pnfz5q4bUd1Pt0wtBw=;
        b=DeN+dkUo3aED1dG/nqr5srYssBY9ac1BxJ2U7QgDDMVWs+BxSNaZKMBh+tHFx+uRXK
         XSCrva4pM3D1EAKIDYYlj0S9KHI0asDJAyA+jfpgB/fZGBm8hbIUTPaf1Lk5wsnNHiJs
         XpVHtoC5IrvqIPlNImQdeL9ae5pg5SnMVzD+w+0Z2RVRzN5JJ8SedkcIhS+4iUI12ne1
         BJh4716L6Ht63W+ndow2C2tM6NsoVKm7UksdogDVBpsrSMco1qhzf+sGDdDPHsUcEFXK
         QPpiUlvssAcYWlikY3Jfd79BEepHekc7JHXSmMHrwQiVfmreaHMdRgyooZ0D1rzVRHxV
         x1JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYTiMOsYdOv6EwBGRAt6IG9fCZHBQ4H+slAvtrd+t7Y9vhtAyhg4muKKVtoIpY3P6qfVdDOiSm@vger.kernel.org
X-Gm-Message-State: AOJu0YyvbfskFDA6wdKlBufuiVHVhFRIfiidn+HcxwPfqG6lN5IpnlE4
	267xerG/f1nipo1hbWw68jlcf4o60lqK3N2CmUSmOPTRTVaVYEHf8jfKXxa4LvpMFSVuJgaXrpc
	b
X-Gm-Gg: ASbGncsmycT4DaRCZBchesEVjarZh3YFVy3u7RxWzjEqawve3jWD21AUcZ/R09+PyrO
	5KtZLqsSY/qxo16XDnXvFLcC+Eam6vEhzlRC1M8NHsnqW9KDdnls3BRUeTC86ykO34t7xIw9hgC
	1jQiweUFGdzL1oK8I+1buAir36rMrnhQpCYdy9U85k4dysdfe9wYDm3Tjg28PucBPhQNn0Wp1u6
	adcbRZN0/405Ipmk4t+4cJaaaKsV0P07AmSflRaXhjOsBT3y+v6GHle7ACS1TFTwJRv9+bWcsop
	V45PHXkhxaUP9QSigzWXKc9P/D6tVKG0/2OuxgbLI/M=
X-Google-Smtp-Source: AGHT+IH/PR+Zz06sUuayKqpZNJEokZEr3n/LHOx8nH3XGM8ECywA5vvQjzQ7Bc4R025bd9OEt8DW4w==
X-Received: by 2002:a17:907:944e:b0:acb:ae3b:b424 with SMTP id a640c23a62f3a-ad1e8cd77a4mr480650666b.38.1746643272908;
        Wed, 07 May 2025 11:41:12 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a24a4sm950681466b.41.2025.05.07.11.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 11:41:12 -0700 (PDT)
Date: Wed, 7 May 2025 20:41:11 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Extend kthread_is_per_cpu() check to all
 PF_NO_SETAFFINITY tasks
Message-ID: <yghzleu6pvqzmie77muujhc4ac3dmtjmies3pcwjikrbwp7vvq@qpxo4qmxzhcs>
References: <20250507183011.550307-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4yycbdszh5z422i5"
Content-Disposition: inline
In-Reply-To: <20250507183011.550307-1-longman@redhat.com>


--4yycbdszh5z422i5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/cpuset: Extend kthread_is_per_cpu() check to all
 PF_NO_SETAFFINITY tasks
MIME-Version: 1.0

Hello.

On Wed, May 07, 2025 at 02:30:11PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> Commit ec5fbdfb99d1 ("cgroup/cpuset: Enable update_tasks_cpumask()
> on top_cpuset") enabled us to pull CPUs dedicated to child partitions
> from tasks in top_cpuset by ignoring per cpu kthreads. However, there
> can be other kthreads that are not per cpu but have PF_NO_SETAFFINITY
> flag set to indicate that we shouldn't mess with their CPU affinity.
>=20
> As all the per cpu kthreads have PF_NO_SETAFFINITY set, fix this
> issue by dropping the kthread_is_per_cpu() check and checking the
> PF_NO_SETAFFINITY flag instead.

I think there's a reason for existence of kthread_is_per_cpu(), so I'd
stick with more robust

-			if (kthread_is_per_cpu(task))
+			if (kthread_is_per_cpu(task) || task->flags & PF_NO_SETAFFINITY)

Perhaps with a comment that illuminates the kthread_is_per_cpu vs
PF_NO_SETAFFINITY difference.

0.02=E2=82=AC,
Michal

--4yycbdszh5z422i5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaBupRAAKCRAt3Wney77B
ScbLAQCNzzhTKInQ/O6giMRTLySRKJbbtyc+gFqTTOJTan310wD9HdMX42se2kCU
+Nc3gA8HKYQXvOjy/bEz1By6fqPUQQc=
=Ng6m
-----END PGP SIGNATURE-----

--4yycbdszh5z422i5--

