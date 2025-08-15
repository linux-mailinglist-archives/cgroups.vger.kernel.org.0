Return-Path: <cgroups+bounces-9215-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C11B28249
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 16:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4261CC57AF
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C80B253F11;
	Fri, 15 Aug 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yl07bti9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA163257AD1
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268942; cv=none; b=MAoVSmFzb+Kodr8hW3hd0VOIEiqXY63+m5w5tRbE2eG6eqhoCT8+c7yMMHhZrmTtLa9jXUt0VzbPDzu3SLnghOqA5+tr6eCwdpDFt0yZZuGfkCYSJgvwYHlrjEN2A1wFz0Xfvy3Ci77tRs2u/FTC0wGYNLkb/+wl8tnsfvqjBIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268942; c=relaxed/simple;
	bh=E08Z/Gjpe/x4ncuy1dWHOIFHunMG31GwZdhkHJ+i07k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWGng36EQjzr01swpcmeoAfBx84WVjwCpDTwTPZKrjuFdmFVpYD81b5MYTZlvmcreZ6ePTw04ZLZrU+VnqgcceG5bzkRo6SvPWFTjFrrnJhyjk7Nmo4bWUk56eqCsn0PDpu63y5zsGf0cw3oDPqNBX3Zvln84AoV05yFJNHU7lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yl07bti9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0bd237so15382785e9.2
        for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755268939; x=1755873739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UrhhDUhBgNZopwv3/8XFWlqe8JuQPPvnbL7V1VwKS8A=;
        b=Yl07bti9GmLGELAJ98oVI/87ptjER5vdh9ZFtLCrQMRtggMKYkLGEFJEpDZPY2XDLx
         ZfThpATH9vsN4F27NDF8uRcPuEYGoYrRiQSlr1MtVea6LpxmfFSBPV42qDy5zZoC93N/
         jsUb3m2MVcuBMwL68sHW6HZ9g2OEElu/Otmsdru1lh8KOZCduOSQmGKfnhCTm4U679tg
         TV1r1bq8BB/6VlYzHrHY0Z6GVNuYSfKKc0jDlsZs9/4/CQ8RePqGK+9/hGRsfkMMG4B9
         nwumMY1hDcNdqo3qW/urct5BhrW0YLVhSP7ddbgTq2Xzhcqu2WrkO3J0nTNPD0d4iE2l
         RCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268939; x=1755873739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrhhDUhBgNZopwv3/8XFWlqe8JuQPPvnbL7V1VwKS8A=;
        b=IWrUcvtXDkkuYXsRU6jazs4g1slY57KUFFXy5U49HvM2uo+udiMH4etwYDdd7p1fqG
         83KmvmFXhHV3ZUgl5lT7SmXEzW/M6Eq9C5Sh2lnPhzzR4jhZKj+udutQIVS0pB7hw3+l
         ttNefgrlu28whfiD/+pQskrYa5vKlMigrGC1XUoCJQSMo7oYP5ex0Uj322poLNXYkUtZ
         qCG2hduS7mNr7pHAlO2GcLngRHlPtvbaFu3lHd5skD8gzv3yWMNHE9Ro5in1qaVPZAYK
         Il5iqJUPVkIo9+I4naPyr4OfQw+yc6EL3WlSlmCNG90++q66139Awu+5h2Eq7WmRmpw8
         oDWg==
X-Forwarded-Encrypted: i=1; AJvYcCVL3vXw+SKNUQp5asQgMGeiuOtrOAtJph/LHHaey2wP0PjFKmJmGaqMOfTC7lv8s9j8QIre/S38@vger.kernel.org
X-Gm-Message-State: AOJu0YzExJnOdEZIjDb46b8O49xwGzhVB4MPzfAMKj3i888Ve8hlPyw9
	3ZAsdx0znShM6awGXX6xJCogVc5aujn+teIY6g4LeVJBsUaY8b9W4m8ZscbAxY3cqaA=
X-Gm-Gg: ASbGncv0pxOVqxUEFwSr8JPDASPG+xyTEkmTQWX9nxm1MNEAMYtoPCtTFD9QIxSmq4I
	LkCr5b6P7gQh6s+APKrGyUdljUrw/KqGYBVMCsLhRnsc/c96rBJ6+6ovSDYqx5VfYb2ZLc1Of6U
	5IyL/olxbkpg1+ZS5XOX2wRg88uJFLnvtwQiWUHun0A5mpJlLhw1JANqIuJAXVMkQT9bn0A34rb
	eLH1gRfGe23omrShHBiBt8sOjtpIp9QKekzYvs6VWOfhITFTiXGmso/8qULfwJsULHUfmSpT9Qb
	9Z/AKvh4mTarGKNUIjO68xWrC6kmGt422aWSvYdvPiqbGGuFDTge7m9l2wAlbsSUa4+4dgWBeas
	0VaM4bG7ve0DvyGEDMAwiG6tV0ef0GoiVMDzZJcvNqA==
X-Google-Smtp-Source: AGHT+IEboWaeHkNlU+m2U6Jyj7/6NzkEInnD8P8sG3Rh85pdmSXQEYsAqvzgLOG7UNxq/mqhuQwxUA==
X-Received: by 2002:a05:6000:2508:b0:3bb:2fb3:9dc3 with SMTP id ffacd0b85a97d-3bb6646e1c7mr2044697f8f.5.1755268939165;
        Fri, 15 Aug 2025 07:42:19 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45566fafsm1288877b3a.73.2025.08.15.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:42:18 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:42:06 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org, 
	hannes@cmpxchg.org, peterz@infradead.org, zhouchengming@bytedance.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, lujialin4@huawei.com, 
	chenridong@huawei.com
Subject: Re: [PATCH] kernfs: Fix UAF in PSI polling when open file is released
Message-ID: <ql5573r2nbex53fyygwczyjipmtalc22n3hxxzmqwi2sgadodt@a5pesn5gunf2>
References: <20250815013429.1255241-1-chenridong@huaweicloud.com>
 <2025081526-skeptic-cough-7fda@gregkh>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7waogckkrlgxbmqz"
Content-Disposition: inline
In-Reply-To: <2025081526-skeptic-cough-7fda@gregkh>


--7waogckkrlgxbmqz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] kernfs: Fix UAF in PSI polling when open file is released
MIME-Version: 1.0

On Fri, Aug 15, 2025 at 08:11:39AM +0200, Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> > diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> > index a6c692cac616..d5d01f0b9392 100644
> > --- a/fs/kernfs/file.c
> > +++ b/fs/kernfs/file.c
> > @@ -852,7 +852,7 @@ static __poll_t kernfs_fop_poll(struct file *filp, =
poll_table *wait)
> >  	struct kernfs_node *kn =3D kernfs_dentry_node(filp->f_path.dentry);
> >  	__poll_t ret;
> > =20
> > -	if (!kernfs_get_active(kn))
> > +	if (of->released || !kernfs_get_active(kn))
>=20
> I can see why the cgroup change is needed,

I don't see it that much. of->priv isn't checked in cgroup code anywhere
so it isn't helpful zeroing. As Ridong writes it may trade UaF for NULL
pointer deref :-/ (Additionally, same zeroing would be needed in error
path in cgroup_file_open().)

I _think_ the place to cleanup would be in
@@ -3978,6 +3978,8 @@ static ssize_t cgroup_pressure_write(struct kernfs_op=
en_file *of,
                psi->enabled =3D enable;
                if (enable)
                        psi_cgroup_restart(psi);
+               else
+                       psi_trigger_destroy(???);
        }

        cgroup_kn_unlock(of->kn);

The issue is that cgroup_pressure_write doesn't know all possible
triggers to be cancelled. (The fix with of->released would only
sanitize effect but not the cause IMO.)

HTH,
Michal

--7waogckkrlgxbmqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJ9HPAAKCRB+PQLnlNv4
CBaBAP43oVsG9hvpd+fisul1x1+rwolSV58J9LSb7n7VoAz80QEAm+hxMRFwmmMB
7V7Z15dEzI3wqk/GDvXimj5mD3Im8QY=
=9lzv
-----END PGP SIGNATURE-----

--7waogckkrlgxbmqz--

