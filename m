Return-Path: <cgroups+bounces-6762-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D28FA4C4F3
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 16:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE7E7A9E60
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D3E2144CC;
	Mon,  3 Mar 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FvMwRItq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D22144A2
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015368; cv=none; b=kLbulV7nukClzZ0eG71earwmER0Abugm4stdeR6NRaDkqKOOS+bBk5iNlwJJ3Jt4ZS7mOARWiZQNLFe9Z067rwjBZExkic9pLV4O7a4M0XoY+oII3iWiGEGxQBxnHbveQ7RQoBaUTeRpPNptdUq+HFqmhDFGlY5XR36xcFGzXfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015368; c=relaxed/simple;
	bh=ydLLMKrxEKo1ts78m0TL716MnIMoxc/AmA16e2nV9xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhg+282NbiP9xFFOOzo/X2Iyu2e05LQpfQPo9h9srGc12acwJvYqREv4ftZ6bdWtHxL4xW25xhl+ushNz6WvkfzHJ9S74EHIk6ipnF9gi5RzXGCPoru17/sRp8AD5VmVbOi6hRkm3t6weVwvqsu+AdTL/GvUtOVbKsU+HQdyC1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FvMwRItq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so13593485e9.1
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 07:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741015364; x=1741620164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wGs7jK9Bj7vq9uXprxwNi5fvQ9EvpRq1hi2k41CtAc=;
        b=FvMwRItqlKxyANGsPcEEPX0THxlChhlG8loR8Z5DRmqp9EddzNYPCfheT8n++7Mg2g
         b4u+JBKz9Sf75JhpgCLWYuMf7e0ccjdDMybbnzVsc2jHMExSZPk6j0YcTS9BT+oBy+OJ
         kpufVfGUBQ5Dw3KRGYQh5E2aXTjguXeQmEP7z0Z7CHYhRv4mFIfq3/oo2EkI8ZN6P/Xe
         nD549HrgNFVMVagfs7lymxyZHGTkqe4ZwzBV2SujWT1f/Yy0/bJihfqB7whaevBIAt5P
         LRXqbHHfbxzyoJoo7+/Zv8yamIf52q46Rd1MEs0WT2/6j6tCn1YrCoMN3ZdpNyf+Dn1o
         TfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015364; x=1741620164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wGs7jK9Bj7vq9uXprxwNi5fvQ9EvpRq1hi2k41CtAc=;
        b=gx9jw8G3KFHAG2kHSTw1KzKdLziYl6yds9L8z+EcNV5rEBfzCUrgRmiQA73cNNy37d
         gfoGbpBSqTzGF0Mw1u8C+nKUnOjzgvIhwniN1J9jbakQHjaU5T3+TevJkPfVrw5uuR1t
         wIh+0VaSqfZKWCCplyf0HrQbarjQv1X8PjX8DmNNTr3y/jjfsFNKo0KsS8HSPae4EoQD
         d5HTgAv22nBfUvhpAr34iB5BS4blXs7noCakIA1bCPB9kowfl2CKGI9AkQhS/TY2+4rO
         ZHciCPbD24BrMEgoxae7Wwp6oXR0o3/vzXVElYDkrcdd22IRVAVefd8+qALO5tqQmtHN
         MlXg==
X-Forwarded-Encrypted: i=1; AJvYcCWTjp+NgZB1jl2qeCb2YE64rARz+bvv1YFWqZWuE7lHw29EpYB5Xglr7KLeN7kosuZq6dBmU8cj@vger.kernel.org
X-Gm-Message-State: AOJu0YwUk6pVCj/0wFnya0UiQjJScIJ0cIsjcxVNTc1igBqC5DnFUE3U
	PswwSYDTVk+sM03c+wdf9eRvf10+bpWFazfICUYc7ba5CJU5F43ePzPsUGWmfds=
X-Gm-Gg: ASbGncv9p1HPQfBKzlOfOrIe3f/W8PtOz321a98rp0LJklEwJ2pzx4QnnzlvKfBkAap
	0psC8Ekyv6GDfOMNJMlbhxEqnHH7PsB/J4uso2Q3RmvZ4wrviW8b3ZfxIai7uGFnZ4tOtm16fTC
	eMxufPKnzYVmwhLUxDJt/zHtQtRnjQpGwd3zJ/5S260rTe5Fhz0AjjkuBTH/TSvFV2lv6IShNeC
	yVn/02t07q2A8yuoDsEtPCuz8jPerfXMa8EHmUUHsAUQ78sw2AXqgVYA6SAH2WoLfo8m3bYgBG0
	pgJNSuqsPrIwoyMC1hy+iKlXY7rChvx6ZxeA83S2QVM5MFI=
X-Google-Smtp-Source: AGHT+IHZlYjKKBZMfn/9ucHLf76EfZ46eRVHZD3BqNqZmIeGhL1H+Iyhtl5P0Uvx6XKM3wU0JcP1yA==
X-Received: by 2002:a05:600c:3b0d:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-43ba66f980dmr107971195e9.3.1741015364344;
        Mon, 03 Mar 2025 07:22:44 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc447a0b3sm30778325e9.3.2025.03.03.07.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:22:44 -0800 (PST)
Date: Mon, 3 Mar 2025 16:22:42 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: inwardvessel <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	mhocko@kernel.org, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
Message-ID: <n4pe2mks7idmyd5rg6o3d6ay75f3pf4bkwv4hcwkpa2jsryk6v@5d5r3wdiddil>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-4-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pru4evwusljqesxi"
Content-Disposition: inline
In-Reply-To: <20250227215543.49928-4-inwardvessel@gmail.com>


--pru4evwusljqesxi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
MIME-Version: 1.0

On Thu, Feb 27, 2025 at 01:55:42PM -0800, inwardvessel <inwardvessel@gmail.=
com> wrote:
> From: JP Kobryn <inwardvessel@gmail.com>
=2E..
> +static inline bool is_base_css(struct cgroup_subsys_state *css)
> +{
> +	return css->ss =3D=3D NULL;
> +}

Similar predicate is also used in cgroup.c (various cgroup vs subsys
lifecycle functions, e.g. css_free_rwork_fn()). I think it'd better
unified, i.e. open code the predicate here or use the helper in both
cases (css_is_cgroup() or similar).

>  void __init cgroup_rstat_boot(void)
>  {
> -	int cpu;
> +	struct cgroup_subsys *ss;
> +	int cpu, ssid;
> =20
> -	for_each_possible_cpu(cpu)
> -		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
> +	for_each_subsys(ss, ssid) {
> +		spin_lock_init(&cgroup_rstat_subsys_lock[ssid]);
> +	}

Hm, with this loop I realize it may be worth putting this lock into
struct cgroup_subsys_state and initializing them in
cgroup_init_subsys() to keep all per-subsys data in one pack.

> +
> +	for_each_possible_cpu(cpu) {
> +		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu));
> +
> +		for_each_subsys(ss, ssid) {
> +			raw_spin_lock_init(
> +					per_cpu_ptr(cgroup_rstat_subsys_cpu_lock, cpu) + ssid);
> +		}

Similar here, and keep cgroup_rstat_boot() for the base locks only.


--pru4evwusljqesxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8XJQAAKCRAt3Wney77B
SS6HAP43BFlFZii8ME858IQ21EkBriG+eWmMI8IPJfDAtopYwwEAii8NEIgzMWUe
i9P27K+r2zvIj9J8wyAkITZTO5g5/w8=
=nKWP
-----END PGP SIGNATURE-----

--pru4evwusljqesxi--

