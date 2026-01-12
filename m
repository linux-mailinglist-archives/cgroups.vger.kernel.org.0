Return-Path: <cgroups+bounces-13072-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E0FD137E0
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 16:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 225823005185
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD532DECAA;
	Mon, 12 Jan 2026 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DP6dRaIZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B82BDC0E
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230515; cv=none; b=aVBMGhsXWUkgctTLEZqOfVGfM5waOSShoSvVxC0VrZenienyQ2KbVLCgQuEI8zDBOtxonLeJUXUWNCkmiDlpz0QJi9/Hrt/TLD8VsgMxu2stX7sePyKPE9HsmTmuz41N2z2uhzcYm0gMmElN6FkuMXO55VJqQGo0ljVTj8zX7Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230515; c=relaxed/simple;
	bh=2LlAdcFOMuNXqy8VLk9nvlKy5s1t5Qbb33Ri0Pt3etU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beHzX0CZRQf82GKzXY+JG7GM1uWWEf4wMWFEpw8O3c32rVb1z3Jx14HQhz25vkPgtx6J9T+U0ry0KdPEccxQNhp8uEVGJ/mXNGNeeVGxg/M42paMxQ5qHK33qdi2T4wxhYN4UCcaLuEGQIeCnld6Do8eLoQbggi4c6yQffHBlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DP6dRaIZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so5437638f8f.2
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 07:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768230512; x=1768835312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LlAdcFOMuNXqy8VLk9nvlKy5s1t5Qbb33Ri0Pt3etU=;
        b=DP6dRaIZSrMKN4qVhz6g/WgTf35PDGl+VFZw/EDha+a+cA+3myVw7WOKXDS2So94Py
         DA2TSiGdlx7nLSwpNWFFEcPXM0d7rfzwJP2IyDsx/sH4NBl75K3RnJD2wt5JjtTLn6We
         bqm965mwxDAZwKLgGKNK6h03qUwhbedVdPgBW+EGOpWDW73Iiy8NXxB9WFcNGeMEC4on
         /qGWZMeZzRuPnsd/VGPHYkacC+hziO3XR+tY3flqQ2Hbmqm7RPaAya5r57Ag3Nm26T41
         Hhbf1O1W8scP3LJR8TtakvX2HMOvGOU78+A4KwNEzQ3VdDcqb/D0ivWaaWyNTcASpOL3
         8ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768230512; x=1768835312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LlAdcFOMuNXqy8VLk9nvlKy5s1t5Qbb33Ri0Pt3etU=;
        b=h98LI0yDHYWN9ovKsfp2sja1NZ+K40MH62a5Ul5UsOl8yZTHvdYR5KQFfPsGuJ1mS4
         kGmXKZ3HDAR7AlDzw2aqbuxSUtmAZsW/3p4F6HEFrGaOieNalMPLhJcS4OfUKcVBdym1
         C4uZtPA2nGfaZtsGYsSG22J8uJGF0ug5up9gOB+2VxwudLb/RiFhnTKlGiVx/ffSRwRP
         Y8bBoI8V1Ke9trCY+3HoNLTbDi1H4o5meLaT8l1wfsD8aCwIU38+jo8c9nEYBdd4dl1w
         j2c3dYL5W+qmeUNllbldOrSdxvW73f8mlpBtcGUQcM2r4cX+ypFB1OK8WCzzc1SWC5rl
         Z0Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVDQge2zQ4EwIDpV+5apQCCM22sHJgXuKZJOwhKdkl6thxgHOCDGR7oY7mru78je9vx9zFw7Zil@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Vu4/jwzWOQG55m65RG2ylDf/Dr/VwIDibfDY4LVtcJ8Xln0A
	xcOhA8Otb+2KoYVYV1brqEG01ErwVJhYYF9v9psMwgXDxMOrW8VC5BFSMze2oIwy8Gw=
X-Gm-Gg: AY/fxX5CT1H3CH8QblFFh5sFdaO90IUgqsPpxSPCiTpHyyDh0ixZLdD5C2rqnRg0P9u
	5Ye2JbeeGTABTaeAGedZOhcMeOUuOfpbkIjTAyT1u1evLLtvSQwsRPWjnbwXxWTf+HqJbXs4Z2H
	meK5mZdZ3b0c8YtM2GtTHEG63fdV4Zl1zs3TnB19eKj2mTTyijW3n9hTlKaPDK/GBhKOGstfK1W
	hFErfO3SDCO222H8zb84NYJKslhCL/sGaKjLY7tNc2ua/VPcgmFHb7uZN4v6fXTwqrA3H2CuI9U
	GRpvPfFkFOE1A2c2cIZb06uFKKxuIw7WsstC3glMqU2MoC3OqBcYLy9Mr7dnRNdaIY8SAH3YpLB
	ki7+i1pF+vjg3gNI7w4OAcySgr8O2BWB56zdhLv/I7rP5Wo2Pnpoay8aqQ8/wsNHvKq2yowI9GV
	qt7iZDexWdoYhKBB+bXIPWQN6itEj0Lot3n+T80QhzeA==
X-Google-Smtp-Source: AGHT+IHKV1LEX2Kg3/u/Laf0CuUnSDbfVay62iMr9BZEu/EkpT7Nz24/p9OPfOdHBurpeZ+kYCwV8Q==
X-Received: by 2002:a05:6000:2311:b0:42f:b707:56dd with SMTP id ffacd0b85a97d-432c37c878bmr22055424f8f.33.1768230512058;
        Mon, 12 Jan 2026 07:08:32 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm40089995f8f.11.2026.01.12.07.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:08:31 -0800 (PST)
Date: Mon, 12 Jan 2026 16:08:30 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Sun Shaojie <sunshaojie@kylinos.cn>, Chen Ridong <chenridong@huaweicloud.com>, 
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH cgroup/for-6.20 v4 4/5] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
Message-ID: <uogjuuvcu7vsazm53xztqg2tiqeeestcfxwjyopeapoi3nji3d@7dsxwvynzcah>
References: <20260112040856.460904-1-longman@redhat.com>
 <20260112040856.460904-5-longman@redhat.com>
 <2naek52bbrod4wf5dbyq2s3odqswy2urrwzsqxv3ozrtugioaw@sjw5m6gizl33>
 <f33eb2b3-c2f4-48ae-b2cd-67c0fc0b4877@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="57d4b62ug42tsq4v"
Content-Disposition: inline
In-Reply-To: <f33eb2b3-c2f4-48ae-b2cd-67c0fc0b4877@redhat.com>


--57d4b62ug42tsq4v
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH cgroup/for-6.20 v4 4/5] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
MIME-Version: 1.0

On Mon, Jan 12, 2026 at 09:51:28AM -0500, Waiman Long <llong@redhat.com> wrote:
> Sorry, I might have missed this comment of yours. The
> "cpuset.cpus.exclusive" file lists all the CPUs that can be granted to its
> children as exclusive CPUs. The cgroup root is an implicit partition root
> where all its CPUs can be granted to its children whether they are online or
> offline. "cpuset.cpus.effective" OTOH ignores the offline CPUs as well as
> exclusive CPUs that have been passed down to existing descendant partition
> roots so it may differ from the implicit "cpuset.cpus.exclusive".

Howewer, there's no "cpuset.cpus" configurable nor visible on the root
cgroup. So possibly drop this hunk altogether for simplicity?


Michal

--57d4b62ug42tsq4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWUObBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgfBQD+LRMv2fmPFzKZKYK7xH07
xkhePTg1NW33sf1/vTxdhDQBAOhjME1GIwRPEdrHWZa/OJA8akS3jrgvjUc32oNZ
W/AE
=x6DT
-----END PGP SIGNATURE-----

--57d4b62ug42tsq4v--

