Return-Path: <cgroups+bounces-8827-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BBEB0D4D0
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 10:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A9B3B37B0
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 08:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07283228C86;
	Tue, 22 Jul 2025 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LrhmVXb/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C632D1F69
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173686; cv=none; b=NY0aqoSLajBv2F7ISdgabeKro7hI2tFCpfC4X+cw9V3U53RG23FE/nqShsYrctfUsRCDmCsURpulpVOSU4dhI2cvcwkmY7S/Vf+bu8BavqkH9rRniB1iy4ZmAMlR+nT8AoDZxMIGrYXELldusa2iS5zfIGP5R/b8jmCyclrjEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173686; c=relaxed/simple;
	bh=01w/qmnV+Ivw6/6VF3WZabXloociS3gJDlp39Lg8Lzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEOZbd4BHIZWHJdmevPAxpl6ISUiYO5SMUtvGpvv8dqRblLDWMODHLJzzI14Cc8+iW8HR1FnNFkjvnetij+LSWEEw4JlHeAFlPP6SmDaNZLbf3Bxhj2UbqiKRrPKC20bu4Y9mzuWBAdxbTAgKUhp1ifCImxpxSynAk6PxuBlqVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LrhmVXb/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0dad3a179so838056966b.1
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753173683; x=1753778483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bRjs2dB89iP5QPdZHpfO+IIDPv1Lm2vrEdP8oJ8jq4I=;
        b=LrhmVXb/XPH7tXqWinP0MQ6s4b/7cZSRjfIHZlYXHQ2iOsEkhZ5Dnhy9XNBGnFVE41
         ICe5VhhQ8g+Yt1REDXYrqZcPyvdgjxy93EHe4szHxQu3eF26FtO0MKNJpmMaZi/pMCEp
         NfLK7zD2aTZWGF2ldpQ6bZQaELQAeOH7KgS+FEWjOSo1MfCOCOMznvSWwvifmiZfNNTI
         VbfnPXGzqQ1JJXNbvfy5iZ6XBYIpUSTn9DYtQVOSU0rKJlPAPLCg9AyjSisoKoCo8/IS
         lhz+k2Sfb0tNIdo0NcEOFPYebhjunoZ/jf8lcEhmZI+vcAmi/k2c6vapOwA3LmiiEV58
         SOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753173683; x=1753778483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRjs2dB89iP5QPdZHpfO+IIDPv1Lm2vrEdP8oJ8jq4I=;
        b=qIsj3D4v59VMHYkYie+4+wtYOF2kgQmSaI2EVSj+BwDeRu0cxTYsSldzpLiktdUNGn
         GsOA0/rk8hw+mLWCCdh3Fbhr22OaH9BqzWcdHGojZW/rGLsnUhM2U/Sy7c+VTAA8IFwI
         Djzz/owC1G1IANHTVPpMDdb/7QY9PCKyeznkQNFq9+wGcNoMFNc1o+n/7FRDQ7hxM+2w
         08HDogq/vkpGAoZdBa3CHz8ZgxtD93t0oW8e3dBlZnIPDxJWkehr9iJcz/B7AYtNsw7Z
         HrsCuOXOPgGUYud9QoFJXa49ubND0pRbxjcwekqUTbjRfHMRBQbQM7zhivnL1u7Hkpcr
         el2w==
X-Forwarded-Encrypted: i=1; AJvYcCXVyffN9GYrd9nIR5sHxfM7xSEsL8sE8B06KCNiEayARDMyaXhxemPI3063/FGIKc5llndrkx34@vger.kernel.org
X-Gm-Message-State: AOJu0YzJTocmJ+v0RTGOmC6WOC5KC6XjbeKBeui680Ceizi3aPELcVrf
	lq4faugd2qOpc7HPlFitY9MzTIpUBP33PV8KKdTxtJFVQpE05hq/FWhbODswG+SxSL0=
X-Gm-Gg: ASbGncurhqorx9vUed4XUQfWWJ2kyiikZrHpY+Q8lwU6I0oqK370X9/Osc2jzWheK4Y
	ttBvOm3wFqArLQE17lANG7QynDOt2X7kgLN9FCkhkbxad7ggd0OMc29CObpDpwZKYOo/X7yli/B
	HIW8tMDYDvn0pbRAE101Z/HtbzVlEIZd4LzPFsvmnzIo9NmsjWfzxMkZzF4Csitp/wI4vfvMKnU
	XOaT1QTgHPjWGrw1KliEG/YfJFlrCHMHI8schO7QePbpKssjbxra4C3fTRaV1oO2/9Py3A1671Z
	aWVFwfJGErsv/s2QJLBqwTqxrVGdMV37xb7L0yF50n1YUWAvglOH2JB+jCdWLUhS5TOV85vIX/2
	E8hWLPT3tr0k0km8hsvlw0pUUN5H6RG5+mYpEpIyX6gHHTOE5Fn4I
X-Google-Smtp-Source: AGHT+IGVTq5jQfcMBSU2EE35kS23f3MVVY0rKBzXyZk98SKg1l8+dLktQWM4sm1V77E9tsRIzM2T8Q==
X-Received: by 2002:a17:907:d89:b0:ad2:4b0c:ee8c with SMTP id a640c23a62f3a-aec4fbea8d9mr1823014466b.35.1753173683000;
        Tue, 22 Jul 2025 01:41:23 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6caf733fsm829032866b.159.2025.07.22.01.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:41:22 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:41:20 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, 
	baohua@kernel.org, chrisl@kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, gunho.lee@lge.com, iamjoonsoo.kim@lge.com, taejoon.song@lge.com
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
Message-ID: <jrkh2jy2pkoxgsxgsstpmijyhbzzyige6ubltvmvwl6fwkp3s7@kzc24pj2tcko>
References: <20250716202006.3640584-1-youngjun.park@lge.com>
 <20250716202006.3640584-2-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qlnvw6uygziqhfah"
Content-Disposition: inline
In-Reply-To: <20250716202006.3640584-2-youngjun.park@lge.com>


--qlnvw6uygziqhfah
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
MIME-Version: 1.0

On Thu, Jul 17, 2025 at 05:20:03AM +0900, Youngjun Park <youngjun.park@lge.=
com> wrote:
> +  memory.swap.priority
> +    A read-write flat-keyed file which exists on non-root cgroups.
> +    This interface allows you to set per-swap-device priorities for the =
current
> +    cgroup and to define how they differ from the global swap system.
> +
> +    To assign priorities or define specific behaviors for swap devices
> +    in the current cgroup, write one or more lines in the following
> +    formats:
> +
> +     - <swap_device_id> <priority>
> +     - <swap_device_id> disabled
> +     - <swap_device_id> none
> +     - default none
> +     - default disabled
> +
> +    Each <swap_device_id> refers to a unique swap device registered
> +    in the system. You can check the ID, device path, and current
> +    priority of active swap devices through the `/proc/swaps` file.

Do you mean row number as the ID? Or does this depend on some other
patches or API?


> +    This provides a clear mapping between swap devices and the IDs
> +    used in this interface.
> +
> +    The 'default' keyword sets the fallback priority behavior rule for
> +    this cgroup. If no specific entry matches a swap device, this default
> +    applies.
> +
> +    * 'default none': This is the default if no configuration
> +      is explicitly written. Swap devices follow the system-wide
> +      swap priorities.
> +
> +    * 'default disabled': All swap devices are excluded from this cgroup=
=E2=80=99s
> +      swap priority list and will not be used by this cgroup.

This duplicates memory.swap.max=3D0. I'm not sure it's thus necessary.
At the same time you don't accept 'default <priority>' (that's sane).


> +
> +    The priority semantics are consistent with the global swap system:
> +
> +      - Higher numerical values indicate higher preference.
> +      - See Documentation/admin-guide/mm/swap_numa.rst for details on
> +        swap NUMA autobinding and negative priority rules.
> +
> +    The handling of negative priorities in this cgroup interface
> +    has specific behaviors for assignment and restoration:
> +
> +    * Negative Priority Assignment

Even in Documentation/admin-guide/mm/swap_numa.rst it's part of "Implementa=
tion details".
I admit I'm daunted by this paragraphs. Is it important for this interface?


Thanks,
Michal

--qlnvw6uygziqhfah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaH9OrgAKCRB+PQLnlNv4
CMRBAQDzCszk0ZJDxPwRBr0crrEo5Fn9310kn3KBAiLE3KInXgEA/or1joqEpYNt
8C29XY1pGwaogm1oWi9Qfn+sSCEoDQI=
=vEC+
-----END PGP SIGNATURE-----

--qlnvw6uygziqhfah--

