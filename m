Return-Path: <cgroups+bounces-3916-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CAE93D3A4
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 15:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB13D1C23465
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 13:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8381917BB02;
	Fri, 26 Jul 2024 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XGRZdgJr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6808B17A93B
	for <cgroups@vger.kernel.org>; Fri, 26 Jul 2024 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999077; cv=none; b=ogWYOhI0o7w45nBOkyDecfC/gKgw5MNuCy60pvaiHVTVuEPkqAn+EbfrJIUmKjhKP5Mc1FbV1tPcQBZAjUXKG8iByPBe/rzajMDvr3tCMJeYdCzqE2aHGUGWUrgmOL3SbV69wRN53irOTWkuoBeRoEoWov52fMegO3hLecndHOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999077; c=relaxed/simple;
	bh=KKESGORhcoQA9Aqe3oavXhCZhKC98kmZdXj0F7j0ZAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGyq6x67TNVuyTvfFw2iTEaA1ej4VsGeT4QFY6F/fZGkedptnHaXqeuEgqI+YfDkMgf3L0GF/PPAIEggaOHgK0pJwYMicHJsEBd738NGirSkK0BT549Vng+0NINDe97dh+kxrs63DVIi8W//OP4vukIQT2V6B59UN1kucwtYaqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XGRZdgJr; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso13427341fa.1
        for <cgroups@vger.kernel.org>; Fri, 26 Jul 2024 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721999073; x=1722603873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Om+9chWRNNEpAfdZtTQ/mtLwGJ1z59DIgJZDHwgmqW0=;
        b=XGRZdgJrpHSRNSiX/oyKBgkp6gHVLpZ3YX0MlN8RkKNgG6z/J+AUQOPLV8bvMQAhGt
         mdAsP6vR0F5hfzbp513aI+zS3mrHuCFDrsCNcqj9cGjYWgrsP+xs/OzR5NhMlQ8V57/S
         BVc71OID8RmGtKiKT2kdhanAIMTm4wEQP4NKpCJBp73t0EKnQM9ARYmhXN8kQ6jRQ6tG
         pGtMob0ymLy44AZkHTgpXO7PT1eBl8sodY9oGJWU+v7jxUDUOs2Z+j+GVAHaqpzhMHqA
         pjyUbx5We+I5mKP+RMD60WZrFRBAd3+q7tlZJ7Uerx45ERlcRKllu/VzASlQrG/YjfK+
         X6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999073; x=1722603873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Om+9chWRNNEpAfdZtTQ/mtLwGJ1z59DIgJZDHwgmqW0=;
        b=q+/RvZez4D7RgKIERIaXTPq46nPdE96PhvO5XLD7bq8vV0/zY3uzUydOW7J96oGMqK
         aEyr6vn86WZ2qenfC2xyVcmBfp9GS3g9tyk+xT1vny7mbIbNcu6xo10tfPqLbdEKV0QV
         0jx/3WnjPDADTXCiDIjS4/SwO3nFl3vDHtbDJbm8rXu2Nf9FNajE0EBbmMU9syxxlAxW
         odQfRCsWWw6DGBSBNLLaJJgGr6gF0EkQc5aWkv8g52T1+30fjAuqjCZC7J96XsuzE80I
         xl0Znccc5UU2XpmWG3kgDWNX2wgmwv7RIbFd6//d33zn7FDJkPjKJgiYBXNPKQX+Qwxi
         u2zw==
X-Forwarded-Encrypted: i=1; AJvYcCVgWQYhUgK0DfgdDRM7ttrETy+R5x/DQRFYvKqwd1sFZDo6PsBPrQ6F9PNkLSBpwVKAuGWL0I3JVshGOR0IdxuOalP7WxIbLg==
X-Gm-Message-State: AOJu0YzSOqs03uWlH78GbKpb/jyCxfWUHch0/p3iAq+xrJy1vLTG6nZI
	iMTzNx8JKO63CUse7jSFeqb4H/lnHToGnRTpmhFwmWHRDLPEjXS5C2fGIl3u1uc=
X-Google-Smtp-Source: AGHT+IEVfulzR9d0qzgqQVFEoqrvluyhlK+ugJ916FpIw4lFOSjmSOUX0/K6QrXV3XvrlVp9jAX27A==
X-Received: by 2002:a2e:9d09:0:b0:2ec:6639:120a with SMTP id 38308e7fff4ca-2f03db70dc6mr33413951fa.10.1721999073011;
        Fri, 26 Jul 2024 06:04:33 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8128d0sm2640375b3a.118.2024.07.26.06.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 06:04:32 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:04:24 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: chenridong <chenridong@huawei.com>
Cc: Hillf Danton <hdanton@sina.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, tj@kernel.org, bpf@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -v2] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
Message-ID: <ohqau62jzer57mypyoiic4zwhz2zxwk5rsni4softabxyybgke@nnsqdj2dbvkl>
References: <20240724110834.2010-1-hdanton@sina.com>
 <53ed023b-c86c-498a-b1fc-2b442059f6af@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wvccf7izdphyux7k"
Content-Disposition: inline
In-Reply-To: <53ed023b-c86c-498a-b1fc-2b442059f6af@huawei.com>


--wvccf7izdphyux7k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Thu, Jul 25, 2024 at 09:48:36AM GMT, chenridong <chenridong@huawei.com> =
wrote:
> > > This issue can be reproduced by the following methods:
> > > 1. A large number of cpuset cgroups are deleted.
> > > 2. Set cpu on and off repeatly.
> > > 3. Set watchdog_thresh repeatly.

BTW I assume this is some stress testing, not a regular use scenario of
yours, right?

> > >=20
> > > The reason for this issue is cgroup_mutex and cpu_hotplug_lock are
> > > acquired in different tasks, which may lead to deadlock.
> > > It can lead to a deadlock through the following steps:
> > > 1. A large number of cgroups are deleted, which will put a large
> > >     number of cgroup_bpf_release works into system_wq. The max_active
> > >     of system_wq is WQ_DFL_ACTIVE(256). When cgroup_bpf_release can n=
ot
> > >     get cgroup_metux, it may cram system_wq, and it will block work
> > >     enqueued later.

Who'd be the holder of cgroup_mutex preventing cgroup_bpf_release from
progress? (That's not clear to me from your diagram.)

=2E..
> > Given idle worker created independent of WQ_DFL_ACTIVE before handling
> > work item, no deadlock could rise in your scenario above.
>=20
> Hello Hillf, did you mean to say this issue couldn't happen?

Ridong, can you reproduce this with CONFIG_PROVE_LOCKING (or do you have
lockdep message from it aready)? It'd be helpful to get insight into
the suspected dependencies.

Thanks,
Michal

--wvccf7izdphyux7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqOe1gAKCRAt3Wney77B
SQ3bAP4zZwhoMlp7s0lfIHJRH2FNHqYst96qUlJGjpM8tZLEuQEAjMbWp2LRL4Wq
RebdIf7Erlmd/BknyFNRjYv1GWv0Swg=
=at7/
-----END PGP SIGNATURE-----

--wvccf7izdphyux7k--

