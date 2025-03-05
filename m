Return-Path: <cgroups+bounces-6845-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A24DA50457
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 17:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7295616C4F2
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C92BA2E;
	Wed,  5 Mar 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="elU4xBBE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C5D2D05E
	for <cgroups@vger.kernel.org>; Wed,  5 Mar 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191360; cv=none; b=MVF6Ll5QwLfSTLWyHj0Hmgxxnn8XylPqahzk5OG1WsjnkIUPg+eJaeYJc42dIttsydr1GMr9f7oqNZ/qDIrI27PwUw2LivNNytcA1082pE76i+V/JvBUW/kMKGPnOL4SuTJ/YC4uuBH/+5RtKS5cRUW/P0iHquSovYRMmqtl/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191360; c=relaxed/simple;
	bh=fv4YhRvlWbb2xsBRPo+vB8HbRXMqdTqTfwRar1qvmx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO485fZc6bK+uvaXRlIUacnoelZWDb2BEKAKgUfAyPCGW8zx/wv6f8lCFU9j+MJFbtdZmXA7IQCGpXBcGNTlBXsAFPZ2Rax7/hNo+TNnEMREMZ3Dq+g1/qgBEkf2SG7sPDYsEm5eBqbclyHm4Aru4JXHxR5w2bNtLp+y2lfc0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=elU4xBBE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3910f525165so2722650f8f.1
        for <cgroups@vger.kernel.org>; Wed, 05 Mar 2025 08:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741191356; x=1741796156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNAB44QyhnX4KFdgTgmL60qRg10qylEcS57fI8BPRcw=;
        b=elU4xBBEmJhkTMqQ484vLEvFMK7m+hheKUitkLhNtXdoiIP5glSwKQPE2kOQvSDCQr
         jD7KUAHnWsxjV4UyQU/5ITcXa7/Jpans53w4omNE4c1Bs1UaOFY/9sE/bcezQUQs+FhY
         nuR8iQLKnKicUmIbLQ+ZiBxfrSFnlrwX292pSoIeKnutTy0eFNzwaDc/tpXz7Eb080fF
         RKni5sr6M//lpq+HXifkHZUvEzL7gNMii7VCX7F02s1QlqpYr3ULkTArOpGtcHMqObF0
         PKqhuQkH6XyXlYKBbw+11iBaxETGI4bvki887+ebJR+FeMnPLx96hdROq+lOV27y2Uhz
         WSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741191356; x=1741796156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNAB44QyhnX4KFdgTgmL60qRg10qylEcS57fI8BPRcw=;
        b=ELozh6G5d5ZDTWz5GePi8XbvpuFbgYxRFXE4GD4qLshK2ixMNjX+bSxijotEbxZhY7
         TVqf3F/2vz6YPZ7Vwo/h8ai0OVrxwXaDO2K4jA62mlmPoh3cNGuHA0Q8qdldYx7DqUfC
         e7BJnmxs+PdRh4I95iID/Ket01kTYoIINzarClYkAxmF2abhakrCgxszZwObt+O6SKtf
         Z2botTRvsrki7RQe7atZzRcnsDbls5ZvzMJk2xu/Q/6+9kAV5CjlxCY7u+KlGhmaOwWS
         zyAcloE/M6MKjXsfm99ki+nCBaF3F8uVE9DqTWNnKe1EWTmEPMeBzVNavAbMz9pdDLQ6
         YqnA==
X-Forwarded-Encrypted: i=1; AJvYcCW/W36RW7Oc5oD5WUpnX02xAKDfb/FT0V42Gj6EvfN5x4Y3V6ib2mGnuJzpJWtSe/pd9LEm9kSU@vger.kernel.org
X-Gm-Message-State: AOJu0YxOLSo6/YdMM8BwCwxPG3yDzcyD/XfaH3VxOnaA/Sn8vNnxfGKv
	QYhoiAHiU36Qk8/su23WZr9myznz0LpL3iTbCCV38ybaJLIZs3MPPe7B0m85nOg=
X-Gm-Gg: ASbGncuAVhqw6G1RNiY6peSFZdyac+mARsowf3b2onf+dJzsVlfz7kLDL5WU8YxCdvW
	WiIG/UWKemZ6DD8CzwCIAcyCKQBGvDrGkjUGp2W6wCj8dl1ZpuPgNCAQ5atrdjGs/HbQR7VAtXB
	Yof49nWQ6qymR5HBO2tuuYtiGdD8xghCti6QxW5mELR1PtKMQK1UOSTuYABiACvtqw/Zp1sD3vL
	sVfxVI0KKDSmnDeItEsCqptjDwwuTfOityEboqg4Rs7mgZtKpNn56tho017yZZPaTwoSsmiDkaT
	LCUJzTT72q/S5cpmVQ8G+8nqxgOCFn6Y1suBkp4OBLICcnA=
X-Google-Smtp-Source: AGHT+IFSFHy1G7JXs9LS6Zp9vf6qrgDOnTuLsUnVpuP6RU8IBq/z8lBT5ioxtv8qoOlGoLHFx2uA7A==
X-Received: by 2002:a05:6000:4185:b0:391:5f:fa4e with SMTP id ffacd0b85a97d-3911f7476b5mr2262201f8f.29.1741191356432;
        Wed, 05 Mar 2025 08:15:56 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7ddesm21704636f8f.57.2025.03.05.08.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:15:56 -0800 (PST)
Date: Wed, 5 Mar 2025 17:15:54 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: shashank.mahadasyam@sony.com
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH 1/2] cgroup, docs: Be explicit about independence of
 RT_GROUP_SCHED and non-cpu controllers
Message-ID: <h7xbvvv3727yobsl7vx3vvcpqhdulagmogbuulp3dny4jgggym@gb3yaeuiuwa2>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
 <20250305-rt-and-cpu-controller-doc-v1-1-7b6a6f5ff43d@sony.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mohu66pwpewgjwac"
Content-Disposition: inline
In-Reply-To: <20250305-rt-and-cpu-controller-doc-v1-1-7b6a6f5ff43d@sony.com>


--mohu66pwpewgjwac
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] cgroup, docs: Be explicit about independence of
 RT_GROUP_SCHED and non-cpu controllers
MIME-Version: 1.0

On Wed, Mar 05, 2025 at 01:12:43PM +0900, Shashank Balaji via B4 Relay <dev=
null+shashank.mahadasyam.sony.com@kernel.org> wrote:
> From: Shashank Balaji <shashank.mahadasyam@sony.com>
>=20
> The cgroup v2 cpu controller has a limitation that if
> CONFIG_RT_GROUP_SCHED is enabled, the cpu controller can be enabled only
> if all the realtime processes are in the root cgroup. The other
> controllers have no such restriction. They can be used for the resource
> control of realtime processes irrespective of whether
> CONFIG_RT_GROUP_SCHED is enabled or not.
>=20
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>=20

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--mohu66pwpewgjwac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8h4twAKCRAt3Wney77B
Sa/MAQCsVpx3ngjUqnES7cUlQY3BJhxMyIKDkx8/OleeglUqqAEAxOHtAu3BJJAS
Ccs3+43hdTpTkLZ4OmOk8HTZf1FlMgA=
=478H
-----END PGP SIGNATURE-----

--mohu66pwpewgjwac--

