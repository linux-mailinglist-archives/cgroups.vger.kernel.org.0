Return-Path: <cgroups+bounces-11430-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5763AC1FA9D
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 11:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E611890FCF
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 10:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3693351FCA;
	Thu, 30 Oct 2025 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dXSjZRzF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F1350D42
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821779; cv=none; b=EOWPMbQvHAx1h7l4w1f+cAKybjjiaGi8tjTvIzd3udV6wKIIaW6Gb1QO47xu+tY5+CbpKGOF7+sJ77eh2BO+fRbbqwazisNiLRVPRHNNmG8OL5MySqXlQjqdQdswX3R88HPJl5Bkc8ox2LuC2JBQmZOCllSw/QpFOPqdLBwBzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821779; c=relaxed/simple;
	bh=SwuMGNljv5YCmGFt8PONT+5bpED3M42Ze9Lf7j7Ukyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbIh1L8+GRAB8Z8QmSWRf8BCaORp9dsDWxnWWGdsYbGepkHN9EhgL5qjrByEVpnt/I0Q2fdH5hv3VcMa1TIru6LmqOeQ4bLWyonN0AZ7JG8VM9geInGqLgbN0ygqkknQt/7vlcljIGr5O4J+Is0xLMYp3eRPc3uPW1xIdjDzudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dXSjZRzF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so534743f8f.3
        for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 03:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761821776; x=1762426576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HgtQ2g+dOWzWnvs0Qi9m2S1QHrl6yxD8lUWBkYgbzlk=;
        b=dXSjZRzFrpZmCtvrPJio384KIjqkBOfw88sM06qZVm5DsgJB9Rp+6wKa04P74hD1d7
         5cd8aO3GN7+M2llveTeHBYXvJNcIxI9JvJyK22ifmMxr014WrA4qNQR3AanlQJh1A5Rj
         Wdct/waP/JwkofJWetVKW0bXJgakJZPCpX8n8fETrwzaoNqRQTctyKCAljt7Cw9oRfwu
         ZntufYNcbEq0FNjRYNbOgWBLj8JadqWBOUxwJ2vr0xUqBHwlUjGMIXFzgAnezZEo6j4O
         K85U1Ug4uYT9LAiscAEvNnjjGAuf9kQEu7cPDbB+q2iW8+lmBELu+NBEsz+ys4iNQceH
         mflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821776; x=1762426576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgtQ2g+dOWzWnvs0Qi9m2S1QHrl6yxD8lUWBkYgbzlk=;
        b=fdw6y/B/qENBxn36N2MNTI2IakNaGYqsz6WjHhEcB/D/S1W92lKL9QRaa0dmNpbzAL
         tK9XFl9TjLttOMinltD0cmVkr4Rh2nItmW1vid1qtHSIKTHrLCkHxeBztmxNIUglPEhx
         bHk2c+6OBj3U9ZoMlhcPbFRonvaAaceNB07TDspJDPYfSrEfxecC9mHFCCbvFUhW4kRg
         Ytrx7dyCnm/8tp/ZmZ3BuiRB59AvErhNn9amLfjW0KuglzsSJ38jfYfT1vAr+oVyD62S
         PMEFS6xIBA+BhajqRdVWewwCsl3nfnQjYaTzLNUyo/ry2GiK+wWHpQXan/9W+g2Q+K+I
         rPpw==
X-Forwarded-Encrypted: i=1; AJvYcCWSj7gnnyDjxY3e4ZmA5vtaIUFnH9q4C17G+KbRrsjaZLNXPkT1L6+NOspHzPX78EemQaoRn+BV@vger.kernel.org
X-Gm-Message-State: AOJu0YwVY1rRrWjy3P+Ufwsx7sojwuNGDNZrmCtnOJ/zHxQpy3ArQoEb
	MxNMUAahBRGbqNzuZXDOB0b30b5XmHlmaXDHVvKI2XwfdJJkMflzyylYXwtf4+f1kMM=
X-Gm-Gg: ASbGnctfjDN9SFn8uFntXASjC3i/T8RFwN5h0hHW+yO8IpgsqyGdZjpvyKmb+qsHDvU
	WM6sQVtIoXoK+BitjqmQdnkMUeht/1BEeOWhA3TfQYflef2p8CAkElY35deRphaQEX/4gjPJPSg
	zWp3l6hoYrji3FXQKN8SY8V00LYGd6olOTjj/KW36pVwefPZnjwlzb4nSITwCY3Wtx7ieAIUBNi
	qZklKCF2yxXmqlZnurqYmlkkgOykzMo6ZIIJ348XRqXiw3JFvsBff0uMBC4A0fEyW/JKFOdi2EC
	nQfgqFyUNfwsESbE6aIFnAxS6D0Xyv1EzaKCBMYAOg8QMFLcOeJF9ENP7au2vBX0XVKgTNPvj+v
	w6Wqvw3uztk2ecoMZV9D2LYBsNmGP03lPuiphiqMSZZt8vl7kzz02xevDOWDDRvCafNalnRCJ5v
	BG+mY2PUm1ZvRcIFkb99es06MYmGVv62A=
X-Google-Smtp-Source: AGHT+IHp9g+3GLV8nhOvZFlsBnzq22456ksW+u7Llq4jQZH1laxHnfyEWYwfZxT0X86+Kf7MqNOXqw==
X-Received: by 2002:a05:6000:2c06:b0:3ff:d5c5:6b0d with SMTP id ffacd0b85a97d-429aef77a7cmr4631570f8f.4.1761821775776;
        Thu, 30 Oct 2025 03:56:15 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de971sm30865202f8f.39.2025.10.30.03.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 03:56:15 -0700 (PDT)
Date: Thu, 30 Oct 2025 11:56:13 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Chen Ridong <chenridong@huaweicloud.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RESEND PATCH v3] sched/core: Skip user_cpus_ptr masking if no
 online CPU left
Message-ID: <zvam3p6t6kdmegdbmziqzvwuynxkmeikmedyxmyflk6fxyrx3t@rmqed2h7geej>
References: <20250718164143.31338-1-longman@redhat.com>
 <20251029212724.1005063-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5s4bksgkambzrmqq"
Content-Disposition: inline
In-Reply-To: <20251029212724.1005063-1-longman@redhat.com>


--5s4bksgkambzrmqq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND PATCH v3] sched/core: Skip user_cpus_ptr masking if no
 online CPU left
MIME-Version: 1.0

Hi Waiman.

On Wed, Oct 29, 2025 at 05:27:24PM -0400, Waiman Long <longman@redhat.com> =
wrote:
=2E..
> Reported-by: Chen Ridong <chenridong@huaweicloud.com>
> Closes: https://lore.kernel.org/lkml/20250714032311.3570157-1-chenridong@=
huaweicloud.com/
> Fixes: da019032819a ("sched: Enforce user requested affinity")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/sched/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

(I had looked at v2 back then and reached the conclusion such a fix had
made sense.)

--5s4bksgkambzrmqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaQNESxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjW1gD/ZVVDsDeg8i30BmkfLzuy
LU04a994MlPC6JPJXnsPJfoBAL+o5dW3wD3U6QQG6Dr7vgU94GZrzADRRx2J3NfJ
J1AG
=8TQJ
-----END PGP SIGNATURE-----

--5s4bksgkambzrmqq--

