Return-Path: <cgroups+bounces-9422-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F805B3699B
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 16:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFE156759F
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8091352FE3;
	Tue, 26 Aug 2025 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EIhBgXW2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90135209A
	for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217939; cv=none; b=a88GKym8DlC9TQSxbZl4sujhaHa5MZzGJUjEVpySKr19od1mobkCzUEQaogP5pXoZLQIs7k5/myty7RZDtn5h3xS9ivdTK3Dam5NKGxy7QBSBYIQN5MHgR3SJWH7FXTWFt2f1LiNTQfMKrWyII6hLPpWqofe3Z6JxmlL2gVzu9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217939; c=relaxed/simple;
	bh=kLb6ZG/MZKPX0wzw+VDHPpbkqCVRXUwVb9ltzEdxplQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wjp7J3h8t/r6XbV6bUcP4D3tjmRMiWQ96cOWq84Mj2mBsGIwbujXuUMc4totWrpTkREQGeztgQtpsAk7BjTXhUpFi9qS51nFvN7uqUd93t5JkvcXLzwVYUNucgPzDgisNjvipp2HH5fx2vzufo3/R4YEDQuI/HaIHeZnUOcBLEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EIhBgXW2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3c51f015a1cso2793135f8f.1
        for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756217936; x=1756822736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLb6ZG/MZKPX0wzw+VDHPpbkqCVRXUwVb9ltzEdxplQ=;
        b=EIhBgXW2tt+3VaPglIV/IuSG3UmIHZlsYXump7v3K0TeD/aIwpoaL5LxTMRYZaJHmi
         AmwwthsodlOO8ht756ULZQOxBknwSOh4QAlNh3h8obU6zP0DjjaESkPs5J1xDu2pe91N
         08DOVl9JUkeF4dRRomfJ9q/Z3Y1EDA582dx3B9PAiM2yaGkcGeIXP/c/f5LI47/F0ugG
         dCyPO3mJ/l1iNj2ZR5l+TeJyyqlY6cEYFw6XxeQD3BTOru48l5fYumZ4hbk1rvbu6vUm
         5Q5CKgeLqnXZKujwYs8rAf1De/n8RLh14usNhh9PQBtIcPLqWVTjexIt5wH5Dby6QO5X
         BiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756217936; x=1756822736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLb6ZG/MZKPX0wzw+VDHPpbkqCVRXUwVb9ltzEdxplQ=;
        b=dw5QmzNJtSMHtvIAwQaH5zdpS1/59BcU52RjAma5+L31eOnYUP4oCd8r6LIuiZfFRc
         hsUj55FbDdqsbi5L/xCP3Ykewhy9vRw4HQA2CD7YsLxig6vflbfSYgN1o0DE2Pg9EEof
         PkdHvgNYGC9KhbPqUxR8gE/c8vas+0gbGL67fkAZrWeDS60ezWUPmFacK3/tfROSpYfC
         le/cG3I6pTNmZSe0zO2XJIHq0Y17Tjh/SQx+SWzR12KJurDx6HEnrk048D1Qc5QIovez
         /RYmJrVDxwhiN2zvVShevIWF0OCy+YdGV9oZVBM5ALDIlb1WPiT7P02jo8HuXX1dao20
         pszw==
X-Forwarded-Encrypted: i=1; AJvYcCVKwAAlrWjF/1J1c++UHOMJtXYLkkWdKNUZidc5Avxb09gviuaZ0OV/VemcAfRVJ88b7KjwcvJQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzXJhmQ1BD10MFwJ+ZvpfmzABXPI3uiQraczA6vXCeVAA/Xhr7Z
	IoJmPxmNtzDyRD3P3JjWO3llN3+ln+yT6dMs8329PZe8FyUSL1d9gye2j2xV9Obap0U=
X-Gm-Gg: ASbGnctQpISPNMmuXh7/rBmTxEtHyfLxHUBBjYhTRfNvjyx5vd7m2xqa9zvvuk4TBLk
	i/JiTnDBeVERN8PZEVOZPzt/wWDm9GNISh76sDl5jUXIZPr5A4DauTe3EOdHM4ams8aKeoggwGA
	Dg3VJV2SspiqXeo0EzqKkulZYMro9SfoonmiqAKQEcltH8cjGQQOL8ODwbaAkB0BZxzXL37vYoi
	2ybusA4wOM3fJqTFtavW7V63eh1xgl/At5sE1XmFdNt7coth4/zQFa46XJjsffAJZvlX3Gpas92
	wBc/9PMwUe3YJcR0UrEHhhFWDpMwzS3Y4CXsJ/jp1foz4TeiyGl7iz/gh0m3l2W0yTijTitD5zZ
	6w+tF4MBQ8UFpk8JdlTBQF8rmK4XXgtDJV0Fay1pZ2j+wNF6480oA9Q==
X-Google-Smtp-Source: AGHT+IFTnrF/rBPvpylZlqDHpY7RBPTOk3EMDyuxA7B2fRGvCnC6oI4Vr3hOs+41rkxMsyu+Iph/Dg==
X-Received: by 2002:a05:6000:18a8:b0:3c7:bef3:dd2d with SMTP id ffacd0b85a97d-3c7bef3e1femr9593000f8f.53.1756217935677;
        Tue, 26 Aug 2025 07:18:55 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f2b2d2bfsm3343673b3a.93.2025.08.26.07.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:18:54 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:18:38 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Djalal Harouni <tixxdz@gmail.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mykolal@fb.com, shuah@kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, tixxdz@opendz.org
Subject: Re: [RFC PATCH v2 bpf-next 0/3] bpf: cgroup: support writing and
 freezing cgroups from BPF
Message-ID: <356xekrj6vqsmtcvbd3rnh7vg6ey7l6sd6f4v3dv4jxidxfd6m@cepwozvwucda>
References: <20250818090424.90458-1-tixxdz@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yxqrpx4xig26ifgq"
Content-Disposition: inline
In-Reply-To: <20250818090424.90458-1-tixxdz@gmail.com>


--yxqrpx4xig26ifgq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 bpf-next 0/3] bpf: cgroup: support writing and
 freezing cgroups from BPF
MIME-Version: 1.0

Hi Djalal.

On Mon, Aug 18, 2025 at 10:04:21AM +0100, Djalal Harouni <tixxdz@gmail.com>=
 wrote:
> This patch series add support to write cgroup interfaces from BPF.
>=20
> It is useful to freeze a cgroup hierarchy on suspicious activity for
> a more thorough analysis before killing it. Planned users of this
> feature are: systemd and BPF tools where the cgroup hierarchy could
> be a system service, user session, k8s pod or a container.

Could you please give more specific example of the "suspicious
activity"? The last time (v1) it was referring to LSM hooks where such
asynchronous approach wasn't ideal.
Also why couldn't all these tools execute the cgroup actions themselves
through traditional userspace API?

One more point (for possible interference with lifecycles) -- what is
the relation between cgroup in which the BPF code "runs" and cgroup
that's target of the operation? (I hope this isn't supposed to run from
BPF without process context.)

=20
> Todo:
> * Limit size of data to be written.
> * Further tests.
> * Add cgroup kill support.

I'm missing the retrieval of freeze result in this plan :) cgroup kill
would be simpler for PoC (and maybe even sufficient for your use case?).

Regards,
Michal

--yxqrpx4xig26ifgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaK3COxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ah1zQEAn2OiR6udOpbasL3VJcIk
Dy1IyLSTg9q+CuHLVLl6K70A/R038kUPE6bDH1aUkhvgknFcca3oDCTeR68nTfoM
UzIG
=N7Aj
-----END PGP SIGNATURE-----

--yxqrpx4xig26ifgq--

