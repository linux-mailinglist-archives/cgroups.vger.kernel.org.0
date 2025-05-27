Return-Path: <cgroups+bounces-8352-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCB2AC4BD9
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 11:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADF03B67F8
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 09:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADE6253F2D;
	Tue, 27 May 2025 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eEzg4l66"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F2253947
	for <cgroups@vger.kernel.org>; Tue, 27 May 2025 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748339937; cv=none; b=Rzvfqc64JANgDr29hA19lCyaU96k2GPF6vVQZr8S5p1o+Tb//SCUVGm0679Yjxz4iUXwiEtzSlNqfZc5FfeKkObj5SKbaqt9ZhKMp8YWfAR2M9huHXT5YfMcW9DFhjbFjy4WvjzC9RVOi/Tbnh5mRyK5+5Sy+hb7DIUReuSms4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748339937; c=relaxed/simple;
	bh=gPXYMkam9e7YUM5qKqIBAC+BmfBK97NM0JOhRxCvlVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDAWbQJlPseUCV/JngfDj9LHxrIo2ztfJ/xH+rUZC/RSCr+FgObjWfPDJqwv4jnjf7uB02oO+WBseYBJMEx+6NL+9iYcCG499jkkqRE+5lz431wFBtpG04G+qMpSMI5sFrt/Yah1h/hpou2QMqv7q+agYF2Q6DFphhQIAbgMsQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eEzg4l66; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso42998085e9.2
        for <cgroups@vger.kernel.org>; Tue, 27 May 2025 02:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748339933; x=1748944733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovDeM7CFy59ro2G29zEI76iQj5LO8OiJCTjhuKqfgog=;
        b=eEzg4l66tQDN5pumWbXC13F9MqjmL8stt3aOAPNKrWn5mUs36jhHAb6D07pkKcFNQk
         jeqyA+vHBb08Pl7NFs/1PYhsnnMQH8Jam6wqKJA0/9vqcdD4grCjwx/XCdNTgEgsI6NO
         9zuVy0+rTIuV3unOb+1dVLFCBpl/qOENpDfvg9sBH1WFuzO9bS3FYFkB2GsH1H7WAcfM
         qqbhLL8BPgDfWaf0aUpsbZf1PnAEmWsp3G0zdg1SFNnnv2touQeIlNcrCjC1WpFjUm23
         P81ctXq7fhO9M1SIcC9MVEFV/7Rj3oN1p8315QYhBvlVPCPACw9yGUXBMdTMF2Ai1brF
         h7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748339933; x=1748944733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovDeM7CFy59ro2G29zEI76iQj5LO8OiJCTjhuKqfgog=;
        b=hvz3CCStzhwD/Rc8EkFY9Q1izWXFUXG8c/Ew8yqBx1QKEpbFqL8j/Leq0TWVtgUHzm
         j7r7q2zkQBsXGDTol9rd0MQBfmGz80jjdWwyW7AJyUxIewtja8ilxpv4HEbbyAz+tPs7
         GqcNxTmzGRgurrtSMfqvSghXvejZM1YoMHNIrLSyjSmsOhFokNa4UJLtjwLPPQ1JYB0o
         6c/TShD4VKUe5wOu1VYuO6KupdyWc3wGGJd22MlkmcgBkI64j1/dldQqN5ulZ/30UFTm
         4z4z/vvVHN/wFscmDMSeGLDC7mk7Il3sUezZN4iqCPotMGH1c9NG36iVSU9cRHLNHQik
         Y25g==
X-Forwarded-Encrypted: i=1; AJvYcCXUBvgj8nHWhtUhz5nUN0iD4klhFK+X1lCKcQwuSU2Fd3CsnBTeB9DmfFP4fSPyizASlNvSDz5W@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6TG3Jqyu6LaszqqB4rjmOgbYlEg+KPWzrZMrcIouyZgFVmis
	tXXJVC3Ux5Fj4rdHwy5hNsbR5kHGoC1GTVpbHhyq1CqCdIUyfSddWxcA1bctHNbXhOk=
X-Gm-Gg: ASbGncsMX8KpV035hJmKdK00BiMbtfC+1NG0Vec0ei7JZosJ9VFkcbp1+nFE8oKFHvc
	j9iEzCIlIH0Tl00bZaaezJ1ReX1nz+ByEQ+Of+kYceCuGGrvOonBX8QZ0ATQlvOCsbpCzZuWN8m
	rI6uHtdOA0tT82Ow9jGXO7EmOJ/Y0x60CBS7f4g4zAIiM1/8VzTXfRwFtwD4FlVW74OCfB0qhiE
	xerfOHlXaJ5ZU/2O3FWWztJ+9ZcQDOpChi3Bb4bRq7ZtWSzpNnSr95ttMlTJIH3sXnLCMLPl1x0
	9HnrRXiBg/grbTYL/IwzF1kIdaz//6LRD63KPBlCVjdCl9Qg7gJ13Uc1xfsmG+j0
X-Google-Smtp-Source: AGHT+IFtwTUjZn2K0uyc0dB9w9W6AVN79yBgYpvErxn26uh2Ttzg6hAA9ZousEeaV8G5tSv1mKe7kA==
X-Received: by 2002:a05:600c:4e16:b0:43d:98e7:38dc with SMTP id 5b1f17b1804b1-44c917f674amr93208125e9.5.1748339932904;
        Tue, 27 May 2025 02:58:52 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44fcbe5c4edsm14789285e9.2.2025.05.27.02.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 02:58:52 -0700 (PDT)
Date: Tue, 27 May 2025 11:58:50 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: cgroup: clarify controller enabling
 semantics
Message-ID: <vzdrzqphpjnvrfynx7ajdrgfraavebig4edipde3kulxp2euqh@7p32zx7ql6k6>
References: <20250527085335.256045-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rntxf4t2quqmp4ym"
Content-Disposition: inline
In-Reply-To: <20250527085335.256045-2-vishalc@linux.ibm.com>


--rntxf4t2quqmp4ym
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Documentation: cgroup: clarify controller enabling
 semantics
MIME-Version: 1.0

Hello.

On Tue, May 27, 2025 at 02:23:36PM +0530, Vishal Chourasia <vishalc@linux.i=
bm.com> wrote:
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -438,8 +438,8 @@ Controlling Controllers
>  Enabling and Disabling
>  ~~~~~~~~~~~~~~~~~~~~~~
> =20
> -Each cgroup has a "cgroup.controllers" file which lists all
> -controllers available for the cgroup to enable::
> +Each cgroup has a cgroup.controllers file, which lists all the controlle=
rs
> +available for that cgroup and which can be enabled for its children.
> =20
>    # cat cgroup.controllers
>    cpu io memory

Honestly, I see little difference between the two resulting formulations.
Could you perhaps add an example where the documentation confused you or
behavior was not what you expected based on the docs?

Thanks,
Michal

--rntxf4t2quqmp4ym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaDWM2AAKCRAt3Wney77B
SehkAP4m2JBDAcWV7UZtGTJZhDwiZgZ5EpMBCX5UXgau7TpWXwEAyQspYhrq2elF
Wq/V7UC4bJzdkIoiXD3ldrzKriS6VgQ=
=vJ3L
-----END PGP SIGNATURE-----

--rntxf4t2quqmp4ym--

