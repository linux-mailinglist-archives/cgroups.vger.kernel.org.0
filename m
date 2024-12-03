Return-Path: <cgroups+bounces-5740-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D300A9E1A9A
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 12:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E16B3986C
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 10:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3E31E0B93;
	Tue,  3 Dec 2024 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W+NKn6nr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77531E049B
	for <cgroups@vger.kernel.org>; Tue,  3 Dec 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220104; cv=none; b=esTT5wySd+x54lJbcX9CxUI20kJ1erE7UcPj3WR+AAF5llcxDYzzQd8nngC4l+rMotvEg/53Il+S4w2ARb+Sm5of7rSiHeOUHfj834+y8I7h3lWnyOzXQ3t39eJ4mWre5ndU2OdMZvUqcXcWdFpQypoiH1EGaAmMQxgGj/ITFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220104; c=relaxed/simple;
	bh=jmyk4L0m1uD/d3yvbMqa3Zr0W6i+w63Tb+z5ZXdzQKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hteziahxq/Wi5e/SNSzVIa4wslJ6Fk64u954rD3GWu5dZzG/klCHUg5fH4MoHM3/g9akuhpjnXW/NW99jfWsXKMany8SQYMDsTZcMzqN8Hcx8nyVWL+eM2DYYMQDUPRXq0Mh1WQiKmFEhjBX26O0l66S1oDBhoiYUwDb86IoHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W+NKn6nr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434aafd68e9so45475585e9.0
        for <cgroups@vger.kernel.org>; Tue, 03 Dec 2024 02:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733220101; x=1733824901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoH0g6mcc/lLOBtNOVK7uWKZqQJ0zcF2m3HC5PqElU4=;
        b=W+NKn6nr4ErxTU63vJZ0WcNB206dyWDK7UhChjvDt3QsMzq0fbFhKzkkrB4zhGbgMg
         PHJiE02C+6xRCG9vtNGYRkIhhECgPLtyY8H4fZzvN7/GWrcMR1qDuiLBW+Pm0pIT/03w
         caCe7gFFFjC42SjRQcBrB+fRJXPDK0WDXkuqCHb2IQjHPcQWQzJQZXxhcbgPJgdarN3E
         IkIXgiK0cfQ7QTrruD+Aq8k6wLRKQ1ck/Se0Eoq/zqAil7+Q8MHbPnghMeY4mpaPEmbR
         cyWYm7dr+Dn0xflFOjdgwleB/3pMsVK0OuEyCEFP8WdiJpGx0tkcyplj/pMLwNgx1fHN
         c8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220101; x=1733824901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoH0g6mcc/lLOBtNOVK7uWKZqQJ0zcF2m3HC5PqElU4=;
        b=LoREwtsEXnlIYfxrTW8UaJCbV69ngXOTKoix04OA0WmXOx6zbQ+9P85qX7TvkVWjW0
         wKEY4Us9+BQ48C8mykyrKgCvxtw5JOHYJ91Nc2fkYEjnSuLv5qxrG1pk4fMLsRyulgQZ
         luWpRSrY5VqeA0BUhA5FeWR86wUsTPOihpVOJGp/h8Ffcx47zl6o+twBcHa+nxA5sLG1
         eVaGaKYJWNRwR/72X3yXNJtbMjxp/wjafJVNjdXXMTOQtfUZ6VpCIpTvkoxIhJqy3xPj
         qx1r45vwR5yY5Rd0J1XGD35I/H9vF7Ho1EYbW/LiFlmyiMd34LRIlMYsnDlP5O7lmNCT
         UzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEtimKN14Ik/S23Do9EHDhwLgTmlwU3rIyPpWEA4+nKa40rDkNcXlenW7r4thlDgLLtdMRAeUw@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/3y75dHrDOZhNOcnevDSUxUpGHHfxxyfKDvpY4KI+zS5MxvS
	RQ/piEEkjPvoUgXgiczcoZu6wAQHl4wMqserx6Pzd/yC9t9ZIOcs3DDOsTzHFmk=
X-Gm-Gg: ASbGncvHoM7MYgl/yDFJQWf47HDtE7xENQB7nZm9C1yJy9pgEXDZKMGk5HXK7EnLB/I
	hhm47HpFplbqyDudI9yhqZsFeS9d5AHu3r4+0EwdK2jsBiG7B2Y2gm0b5Uh5lyICRgp7kBsgCWm
	ZNctx+wt/8yVh7yDXp8+KCoURjEcJBrlFhqvdyUcT4Ps3R2Hfim2dPa2lTuJlYUJYZVYA3iM4Hq
	k6uF3YZ9EKOZDW4yx8E+6npsnNxLfBWQlQBPoTpjEsnOJTPvYsw
X-Google-Smtp-Source: AGHT+IFKtsKOx5nwraYeu49MJVp7ip+d12LFtsoXKro4umRgrI++BPEuQZ0k/TOeYwHKW5dnR/TmDw==
X-Received: by 2002:a5d:47a7:0:b0:385:e2d6:8942 with SMTP id ffacd0b85a97d-385fd429c62mr1515845f8f.54.1733220101043;
        Tue, 03 Dec 2024 02:01:41 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e391656csm9736738f8f.47.2024.12.03.02.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:01:40 -0800 (PST)
Date: Tue, 3 Dec 2024 11:01:39 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, 
	surenb@google.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] sched, psi: Don't account irq time if
 sched_clock_irqtime is disabled
Message-ID: <7pad3qmmmy2hgr5yqwwytj3wyjm3d5ebbqy4ix6boxkd34fc7c@ebdjg75tfgiq>
References: <20241108132904.6932-1-laoar.shao@gmail.com>
 <20241108132904.6932-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="juoy3qq5zk2bma6x"
Content-Disposition: inline
In-Reply-To: <20241108132904.6932-4-laoar.shao@gmail.com>


--juoy3qq5zk2bma6x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 09:29:03PM GMT, Yafang Shao <laoar.shao@gmail.com> =
wrote:
> sched_clock_irqtime may be disabled due to the clock source. When disable=
d,
> irq_time_read() won't change over time, so there is nothing to account. We
> can save iterating the whole hierarchy on every tick and context switch.
>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--juoy3qq5zk2bma6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ07XAQAKCRAt3Wney77B
Sf0eAP9apEDJBM5MtREkfBDzMCJWEux2oGXMiraWvAokGB47zAEAgHwiwvw5k5rg
UMlIohbr5pdL+q0G4NEdOeSIYAYQ1QQ=
=ISUS
-----END PGP SIGNATURE-----

--juoy3qq5zk2bma6x--

