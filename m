Return-Path: <cgroups+bounces-5742-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B32519E18FA
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 11:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791612814CA
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 10:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010BC1E0E17;
	Tue,  3 Dec 2024 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YiyPPPMi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25171DE4D7
	for <cgroups@vger.kernel.org>; Tue,  3 Dec 2024 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220930; cv=none; b=R9MlOlyn3PIdF+C0hW3isozz34k8hzMxVjrxC00B9iGN+vTbmzFJLPPkIgB60vSUtH3O8GSsAAS5fCPYTCTL2BhGe64K7B4EMrk9RbJOEpFeI7rEUHGijh9SeGdxLopa1KDUbD1ZshGX2D0rQgaDLvW3vbSVzPUAO7fzVMNmqUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220930; c=relaxed/simple;
	bh=G0sj8PY6ADW3aET+hb+E7GMb/SqAJl8FiJH7t0gVTnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8ghP8IZ857RcCPMgrC4MjKOTt6hEGHKYjvV9OIzIQO0J2vmmg5MXNfCB5/K01qM+qUj/8AvMU54XbIYymRPMGviFwomSpn9XXHYv93oUmDwdPYUMPx04vB+92hX/L07aMRIR+lPPxXF0rCr6qKii7f/1VZixOTxJoB3bqlk76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YiyPPPMi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385dfb168cbso2541450f8f.1
        for <cgroups@vger.kernel.org>; Tue, 03 Dec 2024 02:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733220927; x=1733825727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1oL/Eu1oFnM7Lq/a9MADW9dd1D0ZuUMkh3bz7/dA41Y=;
        b=YiyPPPMiYl2teojVGTnN3euHxVo3Ei0VTzhwP3CJBRoS/pvHiMPwEbS9NzToxJ5cjG
         286vxWQmQUffhxvIpOQrpNbgAQ1QUFVh409diZRUfyRfVdYPrTSS6Ok6ML+TyxDgwjn9
         456fT9A+d6UYdGXo8Wy6zV1SYxoQxnbtntZShuiNrcVtOAFBlF2iut0IXT7mGvHztPCU
         ZIhdgKmlP8jHb+UoSMvzP+bhRYXoNlIz+SzGoJzgYLjZLnyVwXcHFyRT2iRMWsGkt45x
         JslA1LiRvzNWaK7l4iWDn9tcjnEruJS0W1beRmAfuH214LvcSTFj08wM+RpvjFUXQpyz
         ulDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220927; x=1733825727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oL/Eu1oFnM7Lq/a9MADW9dd1D0ZuUMkh3bz7/dA41Y=;
        b=C/bVr63Jyi3dWe39ColYrZXj9NRlilhXj2ALlgSAAi8/GUYTuLDQigG0zRCfS4fTT6
         mi65esoILKelWCawTU2T/P9yzf7t+L2Umzzu1dpczfEKvEX1HZAmzXnrhZ1w8rZd++dh
         avN3Nn4FFJH5pJazIBrUsVKlbsR3VysXJiisPgm++S1EQdafOw9czDbBP3FKtq/1FNLl
         cR2hpuTTQ3Yb4AyMT84mlcxn4JTzMELHGQKB+WH7AjYmzKo3L18LRN9KetBeOQRkgC+k
         QUKG6kuaPZu2ubw8z0laMtExh5cWDWNbik78boKQqbvWoankEU9fhuI6OReFXkl1NIE0
         x1Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWiHFhYttYcs/3mybUHGMcidPbXCyt4wihZIWYXYXKIriHD76XeKl2lUHupJBlRKNYmzNMn+Qee@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZVeE8Tpgy+3BpgMSa7TJSsF/VIjpKLUH2J36F7A4OLuIk6Hj
	vGJbaP07vV/TPJ5XeikiWRVfH6uPLhXZvBMkrh86P8figNfXbXXTMcTBzBGzZgw=
X-Gm-Gg: ASbGncuYMEv73FTTu0pBejX7Gkeh4d7QFH4cm3GAtp/lNhDglQwkXPcjUowiXR4M1a5
	qqWSk0hDq5wy2vSLhNWSyyOJ0HcWCKAQX5Z2HGyfgPTTOegeRBVEGsm+t0VEWk5VmZrdzB/j2Ga
	+WOPjkIUgF3qmx/imWlPMycPSyYFfdfA+gYdHMisvqsgTZ8fHVBOd9yxyaNAQkhNWq/MSM4Dxar
	RusudUiv6jlFPUnWiOsHfVZP1+Ox0AoPr3qAlyedgpWKx98PQCP
X-Google-Smtp-Source: AGHT+IGP+wf/uT+o8vDXMwC1hvUzbUJpXqnj3ziNpYlS/jQFsv7zchrVLXRh0KKHa1usVlCFg2O3Cw==
X-Received: by 2002:a05:6000:78d:b0:385:fd26:f6e0 with SMTP id ffacd0b85a97d-385fd3cd5c6mr1704607f8f.18.1733220927155;
        Tue, 03 Dec 2024 02:15:27 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d25c5sm214564325e9.28.2024.12.03.02.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:15:26 -0800 (PST)
Date: Tue, 3 Dec 2024 11:15:24 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, 
	surenb@google.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] sched, psi: Don't account irq time if
 sched_clock_irqtime is disabled
Message-ID: <ghu7irmizgbyso5hjemwsgscfoigdtzufpfckxkvdqibeo63uo@kvzncpy2rlit>
References: <20241108132904.6932-1-laoar.shao@gmail.com>
 <20241108132904.6932-4-laoar.shao@gmail.com>
 <7pad3qmmmy2hgr5yqwwytj3wyjm3d5ebbqy4ix6boxkd34fc7c@ebdjg75tfgiq>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="efb3qc5jht7fzdid"
Content-Disposition: inline
In-Reply-To: <7pad3qmmmy2hgr5yqwwytj3wyjm3d5ebbqy4ix6boxkd34fc7c@ebdjg75tfgiq>


--efb3qc5jht7fzdid
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 11:01:41AM GMT, Michal Koutn=FD <mkoutny@suse.com> =
wrote:
> On Fri, Nov 08, 2024 at 09:29:03PM GMT, Yafang Shao <laoar.shao@gmail.com=
> wrote:
> > sched_clock_irqtime may be disabled due to the clock source. When disab=
led,
> > irq_time_read() won't change over time, so there is nothing to account.=
 We
> > can save iterating the whole hierarchy on every tick and context switch.
> >=20
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  kernel/sched/psi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

On second thought, similar guard may be useful in psi_show() too. Since
there's a difference between zero pressure and unmeasured pressure (it'd
fail with EOPNOTSUPP).

(How common is it actually that tsc_init fails?)

Michal

--efb3qc5jht7fzdid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ07aOgAKCRAt3Wney77B
SQp6AQDCofeL+RYVr6OoZ5Ku/ryrsGjAU/xUYeRLREz6RNOLswD+Mqy1fxDBv3bL
jyX2QbOi3rrBurYl8eDsySO0VMuwIwk=
=B8Jh
-----END PGP SIGNATURE-----

--efb3qc5jht7fzdid--

