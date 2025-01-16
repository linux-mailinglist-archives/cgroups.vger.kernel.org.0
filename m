Return-Path: <cgroups+bounces-6197-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 490F6A13D86
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 16:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C7147A54B6
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C4F22A805;
	Thu, 16 Jan 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gihnkstO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18A81DD9AC
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737040752; cv=none; b=R9zznpLJVwzMms8tEfm8hdi7FPN0ubkeyepujU6+hsDvKUCLxiu+RaLDH51IpvC+XKTC3hwlJ/MRjYEbdoCD4eV+Vo8aNrY6NKxKfa5t0myT+I5kC7pfT8y0LJVPjblpsNDipdB0MZgIknXCaKW5GpZNamEya3PWFc5HaUb1lts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737040752; c=relaxed/simple;
	bh=9F5cJeDBDXvb52hdEocuB3PsWieKHpqkEs/7UrgHKAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+M0a1aJ1lGlZVLVgezOVG4XiIMZ1Is8qN1+OPtPcBYWOTVWzol+RVss8Lv3xTR9+vZMWqVWxLjuwIb04Uo1SLKbgJ9dIku8WYn/yfslKQhmnqg9VLmOLDEjyaz5OGK+qopgMGT2SmEBRA4ivmA+HHt4qfc8WeFb6H4+9gIRwYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gihnkstO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso10197125e9.0
        for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 07:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737040749; x=1737645549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3M1DKP2VZ97EYmAW4sCRoH3vFNxeWQORDKqGMpvw6ew=;
        b=gihnkstO235fwWwTVVrz36XwUQlQvA6/HE1+7FIGxuZBPxCnrYjLVGBUHRVjqq9Y+X
         YafEg8j23B+JnXWJSPTu+Zb9mf6LqT+ynvtxvvs5xkdOudYsjQAb8Bvini3VRZc/sFit
         yseQK8PhJmuD3K0WOFnLyxHEg64/ZlS5ZaUUn0fQLEINny6NDgyw7OpGLTa4kQmMXQTX
         h/FwqLl3BDJ/gQxvKZLqB7IZFKTS+psDSJiMCwrEvqEi/eGC55PuYHSNupPRKaxK0bJh
         ECRSL6jeU1RflBF55mNQgM/edL4ki92m4MmKWSFY4ydT+10ZJkcWNbOcwDPzlvCLB1b4
         Xn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737040749; x=1737645549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M1DKP2VZ97EYmAW4sCRoH3vFNxeWQORDKqGMpvw6ew=;
        b=uD9CaGFDYYBnRq/TBAk44W4+Qz36TXSVlXCaHHhqRqzJ+F6FXHhQ1H39VBKPLL7xYU
         AyFVkA81PKL1+pItnUkrWDGyhWbGJLPBkBJ+eCQYUim8roeb1UP2SK1acNsNIWiqiS8j
         grte6+Vn10Tov/rV+hqG7az/ZAwwfdxDgBweBw6gbylHx/RJXFe4V6hYPLqVGcpSGJqN
         NVGF1DrBd4Zibql0xmgfTLSbndn/th9bRQmjSpzj4hTjxZyGyqZZeYe+55nOi5l1wGdG
         Ljbu9BE0Df3O8JUllGyV6P76zcEL9kkt7nUQK4y6VOsQPufYEJjl37QCd9DNmPCeIyDI
         uruA==
X-Forwarded-Encrypted: i=1; AJvYcCWbW/oxT8mF9OKxLansOZxU449ENwNLwxMS8mUqJMbocalFtCQUBMNioiY5iW94GoWbmpn40SQH@vger.kernel.org
X-Gm-Message-State: AOJu0YzumRzUlNZSEIkz8n4cgjAUfYDJ/u7dXjrBKoAUJWnGM/DdjOre
	0JDqFYcg+8RqRFj3byeMuY3qX1AKt0mn+jfFQ6AoMvqrbiiYBCiO6sBMvMFxdwY=
X-Gm-Gg: ASbGnctwy0ECQqLvGYNCHQt5hAYcPftXp9ZoiKiE4RQmYF6x0BPHNeGTB8ei3ebq99q
	hPSbxudOKkH6picbc0HRfT4jwXjhofiIpmOuPjFL8AhExzOHcRe+ey74peYjdXcfr/Qo26gd1pU
	9u2ajjr4r8fojSjYP4BORYlXFlJBYYTwWoTuhj5eWTvZXEWGLEgGD4Cq7IqMbZfwtzxlQ/jNmC5
	2Vld8l9fBG+y6HqG0JPDjpgxMnfrXuNEx031jqVRLLeV64NwJpuuBgTP3k=
X-Google-Smtp-Source: AGHT+IG6FI+0yboxU6K4HwBhGMIcNCd6nFsTJz/hOtKorzaZu6B5u9WiUiOchSPpaiA6weWNX/GwVw==
X-Received: by 2002:a05:6000:2aa:b0:385:fa26:f0d9 with SMTP id ffacd0b85a97d-38a87086c15mr32092084f8f.0.1737040749057;
        Thu, 16 Jan 2025 07:19:09 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3279388sm107522f8f.75.2025.01.16.07.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 07:19:08 -0800 (PST)
Date: Thu, 16 Jan 2025 16:19:07 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/9 RFC] cgroup: separate rstat trees
Message-ID: <gn5itb2kpffyuqzqwlu6e2qtkhsvbo2bif7d6pcryrplq25t3r@ytndeykgtkf3>
References: <20241224011402.134009-1-inwardvessel@gmail.com>
 <cenwdwpggezxk6hko6z6je7cuxg3irk4wehlzpj5otxbxrmztp@xcit4h7cjxon>
 <3wew3ngaqq7cjqphpqltbq77de5rmqviolyqphneer4pfzu5h5@4ucytmd6rpfa>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tyxvgw4r6watmyar"
Content-Disposition: inline
In-Reply-To: <3wew3ngaqq7cjqphpqltbq77de5rmqviolyqphneer4pfzu5h5@4ucytmd6rpfa>


--tyxvgw4r6watmyar
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/9 RFC] cgroup: separate rstat trees
MIME-Version: 1.0

Hello.

On Mon, Jan 13, 2025 at 10:25:34AM -0800, Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> > and flushing efffectiveness depends on how individual readers are
> > correlated,=20
>=20
> Sorry I am confused by the above statement, can you please expand on
> what you meant by it?
>=20
> > OTOH writer correlation affects
> > updaters when extending the update tree.
>=20
> Here I am confused about the difference between writer and updater.

reader -- a call site that'd need to call cgroup_rstat_flush() to
	calculate aggregated stats
writer (or updater) -- a call site that calls cgroup_rstat_updated()
	when it modifies whatever datum

By correlated readers I meant that stats for multiple controllers are
read close to each other (time-wise). First such a reader does the heavy
lifting, consequent readers enjoy quick access.
(With per-controller flushing, each reader would need to do the flush
and I'm suspecting the total time non-linear wrt parts.)

Similarly for writers, if multiple controller's data change in short
window, only the first one has to construct the rstat tree from top down
to self, the other are updating the same tree.

> In-kernel memcg stats readers will be unaffected most of the time with
> this change. The only difference will be when they flush, they will only
> flush memcg stats.

That "most of the time" is what depends on how other controller's
readers are active.

> Here I am assuming you meant measurements in terms of cpu cost or do you
> have something else in mind?

I have in mind something like Tejun's point 2:
| 2. It has noticeable benefits in the targeted use cases.

The cover letter mentions some old problems (which may not be problems
nowadays with memcg flushing reworks) and it's not clear how the
separation into per-controller trees impacts (today's) problems.

(I can imagine if the problem is stated like: io.stat readers are
unnecessarily waiting for memory.stat flushing, the benefit can be shown
(unless io.stat readers could benefit from flushing triggered by e.g.
memory).  But I didn't get if _that_ is the problem.)

Thanks,
Michal

--tyxvgw4r6watmyar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ4kjaAAKCRAt3Wney77B
SXpBAQDi8Zo/4YSATiE9l3oV1JeCJjzTixddSW3iLnfRRh2A8QEA9hf3+VQTof+P
v6kWsbf/WLqI9WQ+t2SSMxrdeQkwcg4=
=/nGe
-----END PGP SIGNATURE-----

--tyxvgw4r6watmyar--

