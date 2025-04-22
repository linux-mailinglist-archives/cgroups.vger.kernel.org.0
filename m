Return-Path: <cgroups+bounces-7714-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5566A968F2
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 14:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B8A3BAFF7
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 12:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D67927CCE7;
	Tue, 22 Apr 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f6RPD7rZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5584F1F0E4E
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324343; cv=none; b=AAJS99lxdqgPQ+uMytDJztjFmrDmgu4G0FmSLO9uCQHtjvSlmhY1FdyfAKuW4RA/G4c2ZfprTtyWJrlEmDExcHiF5uaReDUlx6FSy7ylQQXOFIpsLDAdamqf680F48McKXd16Wn8XUc6h4FjqwLSdttzpeLSa/1ZdJYVAH78d5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324343; c=relaxed/simple;
	bh=FEb1vp9zsmFr2JcPIb0VWNcIkxax01MRvDIaLi1NWfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wjr/AKIcbhg0x7J6cn5MzITCLILpkavkF5BIzk9IlaVp1AhaCyCECgYYaJ1UK7xwfsR9XBS8PYz2EVTm9tF22irSZRggZhZthd5lxKMojsYWJyUI2vY9+3JYs5d6DGlrIFr5DzbyBaFHLnCkAcioLhXYT3b3YPzzFbbygexHo5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f6RPD7rZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac41514a734so729377666b.2
        for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 05:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745324339; x=1745929139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FEb1vp9zsmFr2JcPIb0VWNcIkxax01MRvDIaLi1NWfs=;
        b=f6RPD7rZsrqWa0d3m5zGKyFjrT/Qv3Hx2VvG/aeUP/JRGP19hY2e53GaEjRSHPfJm5
         e4E9F4Nj7ZMGqtF0dbA/iR2TVu5SNOL73HBv4yu/2WGc6ein9jUV/R26oKNMfMfKx+5a
         OtuWdBQo2zysnD6BsfzVxvV2+rhDCdYDnAfolWhVorDt9Nq9BgQspro1Kw0zCTpotzbn
         5lj05rxGkFcKZ9TO7rzDBgVlwOE0lg4cVyn+TIkF7jYQQMoMAu44iNsj7E9kVR44MvzH
         LYh3QYCGG+7+A6AXX1/aTXHxVnrlVC5mfQxYQxQWH8vId0BZxkUZ58sbs31xcUA8c9A9
         ssHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745324339; x=1745929139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEb1vp9zsmFr2JcPIb0VWNcIkxax01MRvDIaLi1NWfs=;
        b=ix0w2ZU/qN8PawPJzNtjhlhEsIqk8tWT35T4sXq8CKDBDFXs2dUa6deb3B0a4VsGNx
         7yC+Ia+0ribDhU+IpCZBQK+VYP2Irr0VmusczEQYl+omnklYAaiXJvFngAynaUdvH0x4
         2WKjqlDT2/SOvBp5PU1rYZIFEn3VKGW1VHZDRlkoy81wo5Q/jK7YN+2EsmJSn0KzdTRl
         Lkc5p1Pvk8tORuuIjWKPFmvPoh+80dTEa9wsWRXeQljZMf6fQuFEuFLmm0t2OlYAsCAk
         WEjm+w3c/lMZdT8oNoFSjDwOjn7QQrCKBBUxW3hgTpgRbuXC/LWjBHbu3HvqkhIceff+
         AzNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXWH0LN3D7koW4Ru91Ep7SlEYtQs2DiD5Aw0e2zA+0AxjglKH92WhIohZPVfCvLlZnHR0ulJsb@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdbghlb/0WPgLf2x0/T+vEBwwzCFwSqdZzUjr9JE1LGxyM1iJ9
	BILMSaHgVYtw4hl9iCj28iuY4EDAJdako+hij8ofipVQ6RSatjj3an122+C0Osm9TlWz3mdcoZs
	F
X-Gm-Gg: ASbGncu+4GRXaEYioz6cX2/J5BTelnzHynSg4XY/LjN6GGRBwzhO9XOqOsSu0vWtpPf
	PsRbeutSu4O1VCXv/FTL6a08jNAbgb2algF8p1Vz4TtOrlOskc5RHWqT5n2F9dSiN+XGX6ZVmkD
	VEeSvDj47mry/OyRdmjrTs2Y2pM5CVaFKUFtt/L5MX9WrsSWtpqWW1n6ZIOI7mvP3wUZp8aD7Jr
	6TXLh+VR2zGa42EzUVe8lh4chbk+u+0li8CP68tQ7hhFWzZ/eUZV2L9YOmFh7BeZA6lVROZm48t
	rzpXIg18+z5mqZVNtng3y6YkRu9pp2T8VIpqI3cOHdw=
X-Google-Smtp-Source: AGHT+IEvO4I0PXr3VK52/nbiHGb/HzcVEaKVg4zzxE5USQ7ElhY0GjljRx4O+2j+s6yFoHcQWu17EA==
X-Received: by 2002:a17:907:9496:b0:ac3:446d:142 with SMTP id a640c23a62f3a-acb74ad9369mr1114924566b.2.1745324339474;
        Tue, 22 Apr 2025 05:18:59 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefc6f3sm655834266b.106.2025.04.22.05.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 05:18:58 -0700 (PDT)
Date: Tue, 22 Apr 2025 14:18:40 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Penglei Jiang <superman.xpt@gmail.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, xnxc22xnxc22@qq.com
Subject: Re: KASAN: slab-use-after-free Read in cgroup_rstat_flush
Message-ID: <2eatfmps723vwbvqgqppswny73axxgbmmkaseqjkg2hxojpwvr@3fn36fsfed6x>
References: <Z_1JBt3RMATxnDgL@slm.duckdns.org>
 <20250419153843.5035-1-superman.xpt@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hiej3wsm4kzjo3ca"
Content-Disposition: inline
In-Reply-To: <20250419153843.5035-1-superman.xpt@gmail.com>


--hiej3wsm4kzjo3ca
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: KASAN: slab-use-after-free Read in cgroup_rstat_flush
MIME-Version: 1.0

On Sat, Apr 19, 2025 at 08:38:43AM -0700, Penglei Jiang <superman.xpt@gmail=
=2Ecom> wrote:
> On Mon, 14 Apr 2025 07:42:30 -1000, tj <tj@kernel.org> wrote:
>=20
> > Maybe another casualty of the bug fixed by a22b3d54de94 ("cgroup/cpuset=
: Fix
> > race between newly created partition and dying one")?
>=20
> This issue was maybe caused by commit 093c8812de2d3, and was later fixed
> by commit 7d6c63c319142.

Ah, I overlooked that the original report is not for v6.14 but
f6e0150b2003 actually (correct?), so this is sensible in that context.

Does it mean you cannot attain the KASAN report post 7d6c63c319142?

Thanks,
Michal

--hiej3wsm4kzjo3ca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaAeJHgAKCRAt3Wney77B
SVALAQCxpvY+YXDCaGceP86Ps37TAi1fztt+MjmyKf9IWzf4VQD+LGcIjiluUvvf
3CDAaVURoOL8D/lTu6M3RIITuf41bQU=
=V4iz
-----END PGP SIGNATURE-----

--hiej3wsm4kzjo3ca--

