Return-Path: <cgroups+bounces-4950-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE8E9873D2
	for <lists+cgroups@lfdr.de>; Thu, 26 Sep 2024 14:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7331C2286D
	for <lists+cgroups@lfdr.de>; Thu, 26 Sep 2024 12:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6FFAD4B;
	Thu, 26 Sep 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y2rUqbGJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97FB18035
	for <cgroups@vger.kernel.org>; Thu, 26 Sep 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727354986; cv=none; b=QIvVgOH7UE+ZqOd5+0fae6Y46d43fLREWT+zft4B/QAnMzWO+DWVdL6UbJDg+DhCtUOrYIuLhFfB75jJEc694p7BOasXMyd24JRofGaCXB4EIMm+X724iAhZj+WobeloUrEKUJR8B1PvC0Ssf9PcjjU4RZEDgBnL8n5pxpCohHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727354986; c=relaxed/simple;
	bh=PcAQFQWF3yzOYCy67M0riQ3CDorxWvR8/K5Mqap2swo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtslcOofP3rSOzs9oVRx6IS3vO7TleLMU5LuGs69tZfs3KtaDbXjixGqveEspA8MXzkIEIr7fUElAvZw3qv9D4QZIx5eP5v0Yq73NHKSHRzIVjGXayUPwPj8gUpCmmg18Wo+KFAF1bL5bTBo4WaS0BNPEbwCx304WBxoel2fJhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y2rUqbGJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c718af3354so1094129a12.0
        for <cgroups@vger.kernel.org>; Thu, 26 Sep 2024 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727354983; x=1727959783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MjJsOvgildp9H/xsUULy2gDxt7xA3HkFuJwBFtYzD/o=;
        b=Y2rUqbGJ9qUCknmaN6j9ClDZN+q4Edfm819Rzm5JVvata0NDa8rBR4hHV6mry6+ND2
         93JLjme4Y65aL84cV7kvoBQIhp+eD0RqpH9k7rMFOa3xWXqFXmOIJ+llDjAMs/aC2+YS
         7Z6FU7Z8e2PU2VMUUeVeE/0psEQkRj4s2M19Lg4MP5ELwWbVBCellgUUX0h4tQxwXAQu
         g2V5u/Yf9sBY665WuJ8L6EuDEkoW5DxWL7rhPH0TPT/0pEvfofTVORvDpmxXVdJVcX13
         NeITXlHwkKLNtWQZm/jTK59RC3QDz/Kw+ghklxj3TiydkYcSdrm6PN1QGg/hNlIyVRvg
         Ymvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727354983; x=1727959783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjJsOvgildp9H/xsUULy2gDxt7xA3HkFuJwBFtYzD/o=;
        b=vBFPHtkhJgtjRx8hSEbNKuPtm3GJ11HJgCZ0wsSsw24Ly8DmKZ/24PaEn6hhOMNpoA
         Lk6tjRdco0a+kSVuIRcRtrnJnXBJvqXRf4ydG6LCEgMpktg7LQSLI/59+ALDA/KtP/zM
         4VzSpT1vQIm8Oh1jV4eTfJ2TbYfTlmLR9Z0lqBGJGK4s4/IAd5smQ0MonYVnYQtV7JP1
         7alJ5IPbEaF87DzeW8SJBPyVQiHXuTO2Nrp9qCV0VNu6Za8mrVKwywUMvv4meLW0Xqis
         ClkLxTpENVjloITwcU4GecWwMrEkQcsteXtcf5tXlujiCMjnCHQVL0yftWg3j++HWJU+
         Lk3w==
X-Forwarded-Encrypted: i=1; AJvYcCVs52t82dxtjjnnSnCrokGIQIUZUJlBxRscNohWNMvuXLb1fWpykQRTtXV/LxxT+c+HJf6Fl89E@vger.kernel.org
X-Gm-Message-State: AOJu0YzMNjKg7T8L0ds2R6+SZFtP7SvDxzF1AihC0vgtIusgZiN/+t2h
	qOEncp5aHDe/Nb3Hm9ab5QKkIkEr7XHZ1vPGR4BDF4iBfwbWsVrOwbHpI7u9QMU=
X-Google-Smtp-Source: AGHT+IG5oXINx2+BHWwqkm9/6dgecwNYSEzGznLHq9dYTb8oZDl/WOd28v49JduwM7ansKFgf/vIqw==
X-Received: by 2002:a17:907:31c8:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-a93a063338bmr572804466b.43.1727354982994;
        Thu, 26 Sep 2024 05:49:42 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93a1a8c71csm232348666b.87.2024.09.26.05.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 05:49:42 -0700 (PDT)
Date: Thu, 26 Sep 2024 14:49:41 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, chenridong@huawei.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] workqueue: doc: Add a note saturating the
 system_wq is not permitted
Message-ID: <ipabgusdd5zhnp5724ycc5t4vbraeblhh3ascyzmbkrxvwpqec@pdy3wk5hokru>
References: <20240923114352.4001560-1-chenridong@huaweicloud.com>
 <20240923114352.4001560-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3iq4bhwwm5dfsvhf"
Content-Disposition: inline
In-Reply-To: <20240923114352.4001560-3-chenridong@huaweicloud.com>


--3iq4bhwwm5dfsvhf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 23, 2024 at 11:43:51AM GMT, Chen Ridong <chenridong@huaweicloud.com> wrote:
> +  Note: If something is expected to generate a large number of concurrent
> +  works, it should utilize its own dedicated workqueue rather than
> +  system wq. Because this may saturate system_wq and potentially lead
> +  to deadlock.

How does "large number of concurrent" translate practically?

The example with released cgroup_bpf from
  cgroup_destroy_locked
    cgroup_bpf_offline
which is serialized under cgroup_mutex as argued previously. So this
generates a single entry at a time and it wouldn't hint towards the
creation of cgroup_bpf_destroy_wq.

I reckon the argument could be something like the processing rate vs
production rate of entry items should be such that number of active
items is bound. But I'm not sure it's practical since users may not know
the comparison result and they would end up always creating a dedicated
workqueue.


Michal

--3iq4bhwwm5dfsvhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvVYYwAKCRAt3Wney77B
ST+MAP0fDxXvbUEc5ey/TpWnTsLmyHSf/YiXugOiki+455jukQEAmF+vWJTMxP4R
1GYHr3HW1PTyXSE4IM+96+DNdw9C3w0=
=qxwb
-----END PGP SIGNATURE-----

--3iq4bhwwm5dfsvhf--

