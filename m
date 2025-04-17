Return-Path: <cgroups+bounces-7609-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21019A91788
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 11:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5113C1908117
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D563229B13;
	Thu, 17 Apr 2025 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UIutXDKY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9FA226CF5
	for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744881541; cv=none; b=jyZmUGfp/qkeuKxXy7dGUgdgEBlR3zsBWTQQEdWTaI+YG63DG6DkTTIh0HFpaoq1yVTtpNX95lMuilBMkm1XIYZ1RmVAH3efSmI46FJHLHt5VWQIe5990RKQ1VZTmCAaY4KUN7WfOd/TqnNy8OE3uFhMrfP2yUREBpbB3Jss0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744881541; c=relaxed/simple;
	bh=rPWwFdaXqE/AILRQDnfw+JUbkcYsqI7EzlaUzZcjtEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/IUjSXIn3zze6+S3XzvmdPvU7KAHA0wc2bmL2hPD91xvISonYb7EdBolNJRbvh8mXUC7bG49fPlfFRdulpjhjjPC3H2oBPeoXIkRCognNr6kRTP9zARD7BTxrROzOU9Xq9hQYMvrJPr0m2wLio1xbzvoY7AjIqJnWqEil/tB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UIutXDKY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3913b539aabso310069f8f.2
        for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 02:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744881538; x=1745486338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sNxEv9tO9qIHcy69dAwzXZp+t1x6DTKUOs23pJiw3Qc=;
        b=UIutXDKYRA7yZ7e3hnfyMR3WXynkdmCxXT1EVjhIBROldGB9ViWfAdEkksugGoMb+v
         EwKWO7Bf6f4gIzNv7W614s32KwQm/5wn4Lm3HgUOq5o1i+LKCFJYbDQaB2UbocUvUddH
         N5tFf+7D/2XGLie3SdID5EE8aFKywAlFRpBTKB58IBVUTTzPeakxeqzgeFZ4F03XpNPm
         HrkMssqi4kgk9gLLysR+uJUD8KBJTFgGU4UEk4PZYTzJW9ajwuFjwVDBPb2ZSXx3Vwcj
         jZp2yhcTdjpM6Ixo7CFkXjoLHjcCAT7K0LdE/QUxEZuBNrZJ81egGXq1hV4oXaQsUWnL
         0DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744881538; x=1745486338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNxEv9tO9qIHcy69dAwzXZp+t1x6DTKUOs23pJiw3Qc=;
        b=jt3Tth3kDf87ECpaIzgeVU5jTWikxBA9/4G9ldfBuVSg7fOnmMjWQSJ6CyLz+bXDfE
         xlyMqjzX2X+u+IrRFEpHxOXcaQog9DO71Zw/x5L63PRWWheUZNGxelsS5E6yEMHph3WR
         1n+GEAKRO6/ApWjgPiaGT1woKMUDDoDp78px7o84qpr7zPxmSOekrmVO0FIk7aLiUkhf
         9Pfp6cAzqL/n6n51QDTQzKjStJ2FZPvPxZ4Zr2BwHH8DaN+UlCPnaMdMdbPGNYJRsjmy
         uCXV/YdooiFUVsZPm+DCGZKSBu19mrc8eEFMQlNLqXjRIk5nely5N+LI1qPR620k+4Vu
         dDSw==
X-Forwarded-Encrypted: i=1; AJvYcCWT5SORgE7QzZHRek/UYZmGBpnST69K/+y1nvJN3ow/SSQipWErNLgqtzsVlKfwfSm0I1tMLTON@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKhbgaCsPhPlNOxrtZl9pcCyN0PLGtlgxQAX0ebMilzYAFx0Y
	vMxQD+X1R73O1/y0kpW1+Cdfw7bWEFZZTFfOPL0KnBp/J+y0IHjdwvq794Z0fzw=
X-Gm-Gg: ASbGncsGwrpRKUYUfbYe8s5/Xj+ObPg5P2ew7JE1oKFNdlb4OLn+kkIhlV2zRFcj8FG
	CUwti1+LXmmnUVEn/eU+LOygPgKEjG3QEtjOKK0hyJfLNNgG6zvf7olxGET2xYVgutQejb9mdy3
	tcPgwXFNZrXeKA23Sjtv/EAQW5cLxbVOXv1YzYyKEAK/dH3jz7j4Bup7FL7vYQ9FcTFJ7Dmh4Cm
	BpE8CtO1ruAE4tQ0q6ZG5Px0rHO5DhxT0E5da10+vve0hfoKXbtVEtNNFllV/sRNYHzVvBGqQeS
	5wz0Ff60lD23ftnpMuEnTF4IK1mrCh1aTKlCy17W/n/13bGhtH+V+w==
X-Google-Smtp-Source: AGHT+IE+lNVzc+JtkTRzHTVV4KBhVKi5P/u9VhXrhgXWTgt3BfhLfXCGGp1bz75na5Lj7vjorRqecw==
X-Received: by 2002:a05:6000:4021:b0:39c:2692:4259 with SMTP id ffacd0b85a97d-39ee5b18269mr4570589f8f.21.1744881537968;
        Thu, 17 Apr 2025 02:18:57 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c074sm19077349f8f.28.2025.04.17.02.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 02:18:57 -0700 (PDT)
Date: Thu, 17 Apr 2025 11:18:55 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: gaoxu <gaoxu2@honor.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"surenb@google.com" <surenb@google.com>, yipengxiang <yipengxiang@honor.com>
Subject: Re: [PATCH] cgroup: Fix compilation issue due to cgroup_mutex not
 being exported
Message-ID: <egk3tm2hpesqb6wwi7totjeueoyg3tewdnwt75dcksxvdgpzac@hstrl5e6ltyh>
References: <24763f5c8a13421fa6dc3672a57a7836@honor.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kwivobgki5g3kkoj"
Content-Disposition: inline
In-Reply-To: <24763f5c8a13421fa6dc3672a57a7836@honor.com>


--kwivobgki5g3kkoj
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup: Fix compilation issue due to cgroup_mutex not
 being exported
MIME-Version: 1.0

Thanks, Gao.

On Thu, Apr 17, 2025 at 07:30:00AM +0000, gaoxu <gaoxu2@honor.com> wrote:
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -90,7 +90,7 @@
>  DEFINE_MUTEX(cgroup_mutex);
>  DEFINE_SPINLOCK(css_set_lock);
> =20
> -#ifdef CONFIG_PROVE_RCU
> +#if (defined CONFIG_PROVE_RCU || defined CONFIG_LOCKDEP)
  #if defined(CONFIG_PROVE_RCU) || defined(CONFIG_LOCKDEP)

seems more conventional wrt existing code.
But in principle

Acked-by: Michal Koutn=FD <mkoutny@suse.com>


--kwivobgki5g3kkoj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaADHdAAKCRAt3Wney77B
STChAPwKqyP5TOaZps75D5ssU7jAWBvpo0KB2fzw1MVC3eyprwEAlHeCns1yqSzn
TRPdiKEYRKzjBiziU31l1xy6p2w6+AY=
=WZ83
-----END PGP SIGNATURE-----

--kwivobgki5g3kkoj--

