Return-Path: <cgroups+bounces-9440-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C31FB37E16
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 10:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D15516ABE9
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 08:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497A5304BA2;
	Wed, 27 Aug 2025 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EvHjPhgu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE1521C9F4
	for <cgroups@vger.kernel.org>; Wed, 27 Aug 2025 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284419; cv=none; b=WYb2kYTbYR2e1L08IZG1cDqUgdCHy31iLlnGkf+dZN4cDefw0aEXcNaQGV+oXTpbOur73GtAJPVE5QN7bpbRuAhjn3T5J9bBiGa9Gn+rNwN1uHO1Q9KZkWIPwpOGS95hKgSu0ocEny0nD+1NJowWwIbO2H3kjuVm4w0BzQ5kW6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284419; c=relaxed/simple;
	bh=SuhyOnXQXcyL8UMuSG06qdRFA+YF/PQe9SePBTnntkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbrWdjMnmD95rlxOXDlgdq03/hLW3iotR3l7SJn+C8vGHVxRoUDuhjwGUrfg05wzYxcyL75ymS2jU7ECEt4lUHnDzye+VwumbsmuGhH1wc8rEgwkAEmRqomlRu8+rwNBnt5/2IRX3l7GWOgk/maExCHueck2RzF7/6XGENBknFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EvHjPhgu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso5267070f8f.3
        for <cgroups@vger.kernel.org>; Wed, 27 Aug 2025 01:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756284415; x=1756889215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SuhyOnXQXcyL8UMuSG06qdRFA+YF/PQe9SePBTnntkM=;
        b=EvHjPhguCY/2VLWmvm0YiMknrilOvSufERrv1iwYlk9jKgotrQ1iuHKhvZUA+LfUpV
         rwvCbT7ByicuqjhH64DvBdZtzbgHnZN9H0LmQwyDFxfcM/sNtvhPkb7uBJaCWyHzQtCb
         5+SiqVSsXi6eIJHuoOufYtYBe+UVeSYHwbPWiTT/nD49dJ7fff1MUHpqOnq+bZrESx16
         FSgMvnI/BSYCQkC61bZqkkH5TPYUMnG19AmNd3OjEMPbNkhYXkaukb91NdqJGqLI5+QL
         cu4I1NVPU7wcBbJHFcN4D2PxiyzvE+yxtxV1DwwbdfqC0lY9C1+GkTnrVMFFOwErV5ct
         k9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756284415; x=1756889215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuhyOnXQXcyL8UMuSG06qdRFA+YF/PQe9SePBTnntkM=;
        b=LeaQGF0cw2zV9eQycH2Ma9z4/ctbdEX1B22zRBbMmdWqzPM9mqYFJWcUZcz9b+M0Tj
         QCODuDxcb2ZcDi92fjyiC0nisXv8y3+Q0wJwVFhzxMU7NoIGi/4x4TFpMFggHU8IkBKZ
         ENbACg5XMGrJ5HFOV06rAthUigojjtC6eKVBf5F02K7qy1y6TC7dm6FQTfoWMuyZ118l
         BSZDIIMcEy/0Y/JPEQZYbhINgN30deJTd1z6TZZzWnBFZp8QWZY4SESNIU/2djLS+nQL
         CUsBTMvPdWUbXPs0Q0+rVfsh3oIvTAPK2lnA2dl+S1vsvbAMX9nwVs8xFG5uYctC1CWZ
         C90g==
X-Forwarded-Encrypted: i=1; AJvYcCX0Dj45QEUndUQGYjbhXho2aVAyvNpmMNs1evGsCapVg2sY3M4HMEDSL+uoAQiOg++UvMiZxiXs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4/mPXz88yxrzqav3dGRsqZRgLPGd08YF3SZFeEwVz8ff9l9V
	Itun0ov9h1ygOrj/nnK8+um0WMXIBwUwNQqND6jsNEHQduw2SQQqzg66FpQdgitKFYs=
X-Gm-Gg: ASbGncvSNn+3C0A9VHDXraM9XhBE3RcqSc+VbVI59ztEKNlqk25kxbUDQPcakDFULCQ
	zDhvsCGNOo+iC9aXcrCaIcB9uX9Iw+mkVp0azIEZK7PHFFgTbd2t6Gsacv1QHzjM7s5qqEl23MW
	EVYRZiJLF31D9O3zGmluZXjc9WK/dEraVOo8bwtvg3VJJ6wE4GfprOTfxnFOBzK9p/TX+VOts4t
	dy+GYkpcqRQzpJ/nx1GkaKM95QMzpaBQZPvwYFgvAgrS7yM/yUEQ62J5JWvoP7f4m3u0aRJi4s+
	kWBCm98pul+Kug/AgUWy+9OC4XruDeriiFTB3mmfbsd7X8bV4Rk+uitJ68GnGN0k78AkdGuVJwR
	Kd7+0ugqzK1Y02PEyj+QtDvEXXOxJmFro5SePLnwDGWc=
X-Google-Smtp-Source: AGHT+IGWJOxOH3ZMIayAV4TyQG/sUUI7Zg8meNLV3mNl1YmrdY37vT4tdwxDKqJDDJN36lilsBHIPw==
X-Received: by 2002:a05:6000:2888:b0:3b8:d4c5:686f with SMTP id ffacd0b85a97d-3c5dc540a3fmr14446073f8f.39.1756284414821;
        Wed, 27 Aug 2025 01:46:54 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7720e184090sm330370b3a.82.2025.08.27.01.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 01:46:54 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:46:43 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com, 
	chenridong@huawei.com
Subject: Re: [PATCH -next v5 3/3] cpuset: add helpers for cpus read and
 cpuset_mutex locks
Message-ID: <vel3zxgvbrqfvw6drqrtbski7xwe2thn3bfeo6ahifuncvjxvu@kegptpfird5l>
References: <20250825032352.1703602-1-chenridong@huaweicloud.com>
 <20250825032352.1703602-4-chenridong@huaweicloud.com>
 <luegqrbloxpshm6niwre2ys3onurhttd5i3dudxbh4xzszo6bo@vqqxdtgrxxsm>
 <312f3e07-0eb9-4bdf-b5bd-24c84ef5fcc1@redhat.com>
 <2b574bb7-0192-4a91-8925-bd4c6cc8a407@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="blzwcny5j2erdyph"
Content-Disposition: inline
In-Reply-To: <2b574bb7-0192-4a91-8925-bd4c6cc8a407@huaweicloud.com>


--blzwcny5j2erdyph
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH -next v5 3/3] cpuset: add helpers for cpus read and
 cpuset_mutex locks
MIME-Version: 1.0

On Wed, Aug 27, 2025 at 02:23:17PM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:

> It was suggested to use a do-while construct for proper scoping. but it could not work if we define as:

Perhaps like this:
DEFINE_LOCK_GUARD_0(cpuset_full, cpuset_full_lock(), cpuset_full_unlock())

> So I sent this patch version.

No probs, it's a minor issue.

Michal

--blzwcny5j2erdyph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaK7F8RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhxAQD/TPj5lcZRSj2QqDEtK3Vs
ISmUxmn/7ofiqLpD0ZC90lMA/RWl+pfZ5TV51vTO9dx4bKAaMgu2WfXPCW4le927
vroJ
=12gP
-----END PGP SIGNATURE-----

--blzwcny5j2erdyph--

