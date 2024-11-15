Return-Path: <cgroups+bounces-5573-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FE49CDEAE
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 13:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CB41F24250
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 12:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313621BCA05;
	Fri, 15 Nov 2024 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Eut80KLk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC201BC9FF
	for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675149; cv=none; b=P2O63YRI4vzCC31C7UacZXp7su4x9AR55hBzjZ0vy+v+dLHY8FhzDC0gpHik6gJ4jqnyjUHHx/B5141CKH/VIqqnT9fvBzSFiZob45yNfYn3lhrC89u4MqDEadrk8J94H9XKPhjvPC+Ggh5HWeErgrD+HsBn9GvraHxWCcbtXUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675149; c=relaxed/simple;
	bh=O9b1S7Wa8pDEKhTXu1e0njgl4QX3+67067qzucvDaj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFfdH2HYSaJsR5eBesoiVrinCJsO75NbUwGV+jZE7be5im6iTxshXYx7WbjWSQkdMwotytTd+hfydFDTONWvRiA5/dr+MpkTqewGETZiT68GAJ/OlZDVqurz50GIN592GpdifnSkXxAv7zt3EUyd+HQRQByDgHxR/PqKKYZI7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Eut80KLk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so5570395e9.0
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 04:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731675145; x=1732279945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O9b1S7Wa8pDEKhTXu1e0njgl4QX3+67067qzucvDaj8=;
        b=Eut80KLkbvBwnT4Sg8Y2/bOY+eigOuxCXl5a1nW6OR0hERaT6qML9EecG27SemW0cW
         pRaRDhPPkCaSntwkNgKqJN4/VjxICPaIKPbRbKuSPNCsdiNoujAQg6cZ8hmuBg1PhAVt
         KH4f9nLwzOjxW4AwduwjhRpxvXwj/TpcPbiPYrJdWuNLdMkLuNlsvDkA/I7l2pSsxO7N
         Bew9e7rHI+Qobjgyt9UObPFngi7liXInBbiT3hv/SMBWg5bjtHqi2SmfkG0hbKIUa6de
         c4he47IVDjR+6nFHaog6QB8xNMoIE0TEuTqtdxVq2+usieLZm8YKcGZudmiW23fCOb+A
         gY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731675145; x=1732279945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9b1S7Wa8pDEKhTXu1e0njgl4QX3+67067qzucvDaj8=;
        b=H8XPql83iuj8PlWFbNbhqWPy9Fbw5lj6kLAwK7oQFU8Z8QXBlgOjbWaeqxhEOHEb+6
         Kl+x94uCGDTR7sE9jQAgm+fJ+uvRKhRoIyAJtBxU09G2AGWP+LdpaGfTL7f7VA3SYSdx
         Of0r7yDhIDtmda5ZfD2dfZ4Lv+qh1Qq+P7im3TCfO6Q7RiVcbBijgI7Ohjdx4kBIFeeK
         FngyN9d2oj8sd2DMDZ42wmKU7mJxGmOL4MLTLLEj6BVxlfvOKnOmDV+lEthSYBlY0A/g
         mmr8cexiprAUQ+R8OlGFYfc1Qyrc2ICWskqVwg46lM/661ZiHEubfCUigj8NS9F5Veo5
         Fotw==
X-Gm-Message-State: AOJu0YyldquHxHaNH4Kw2uKqazzQrTwQXMTIbvS4C72gX7Nhf7ZYNvWo
	mznSQlbpmZdDCwFqb5B08FGtSj/bO0kkdL4TKr04VgOEPTHU3LvC/5MgYVDi1VA=
X-Google-Smtp-Source: AGHT+IEoYzFkjMiNiG/421KbmVNBg/OqYzJv6S+4VQbzAsFIYzCPHCz3awHF6FuVlSvOgAHZZTIUow==
X-Received: by 2002:a5d:47a1:0:b0:381:df72:52cd with SMTP id ffacd0b85a97d-38225a0c616mr1820482f8f.23.1731675144752;
        Fri, 15 Nov 2024 04:52:24 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae161cdsm4370391f8f.79.2024.11.15.04.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 04:52:24 -0800 (PST)
Date: Fri, 15 Nov 2024 13:52:22 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: cgroups@vger.kernel.org
Subject: Re: process running under Cgroup2 control is OOM'ed if its stdout
 goes to a file at at tmpfs filesystem
Message-ID: <tuvclkyjpsulysyz6hjxgpyrlku5zuov6gyyhjzvadrqt4qpse@bwmb7ddutwzj>
References: <e0dccc65-3446-4563-8a0d-1ebda4bd7b81@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zgip7uiyufq6jnj7"
Content-Disposition: inline
In-Reply-To: <e0dccc65-3446-4563-8a0d-1ebda4bd7b81@gmx.de>


--zgip7uiyufq6jnj7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Sat, Nov 09, 2024 at 08:38:54PM GMT, Toralf F=F6rster <toralf.foerster@g=
mx.de> wrote:
> The reproducer in [1] shows that a process running under Cgroup2 control
> is OOM'ed if its stdout goes to a file at at tmpfs filesystem.

The (writer) process allocates new backing pages for the tmpfs and it's
charged to that process' cgroup.

> For a regular file system that behaviour is not reproduced here.

Your reproducer disables swap, so there's no option to write out the
anonymous memory. OTOH, regular page cache can be written out to the
backing persistent filesystem and free up RAM.

> I do wonder if this is a feature?

It's how tmpfs memory is charged.

HTH,
Michal

--zgip7uiyufq6jnj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZzdEBAAKCRAt3Wney77B
SYsGAQDCEaH9ZYOYDXrbzRDiSECTGjSarKonoDSRbPCLgGlYywEA5AUGgYdn6qcP
bsyBXqEwJlW9Ql9HIE8y5OF1dJDylAg=
=Yzcq
-----END PGP SIGNATURE-----

--zgip7uiyufq6jnj7--

