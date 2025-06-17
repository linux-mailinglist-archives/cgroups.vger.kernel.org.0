Return-Path: <cgroups+bounces-8558-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1524ADCBBC
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 14:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE74C3BE637
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E956E2DF3D6;
	Tue, 17 Jun 2025 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bFozL5dC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63622DA766
	for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750164007; cv=none; b=JSJKQNNtv+i7ln2sZ9Ve0LPmu4nS6BUTSLnKSoU9X7B+SJ0FkYysXxW0LE73PRf+SThgBR1M6pL8qjsanAD6vlmSVvQbuyRnCIWUzqXlQg6brgj+uuboR8GU/Bkb/0mBdJFElGJeYhSlHfdOV3X70oJBmx3tIIDrTNgS6iQrpl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750164007; c=relaxed/simple;
	bh=ytPjJHvma4FQtvEgnKuyXH/c3dhAU49XIc8L9AzjIyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLAhUb2hMNSKyuoXojbA04vHx2HzrkTpOw0MR7NHReIIRnoB5/S0j93Jdq3mYNi1hBUyeXY8hKVtVELVAhbZkYMYYKhXxnWwKNp/mkokOtA6QJHlEiLGXIzxQE5mOMdOfLa3BlE6tHTzyzBDY2zhcrbo0kei5mSVsAgX0rc29UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bFozL5dC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so3520676f8f.3
        for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 05:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750164004; x=1750768804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ytPjJHvma4FQtvEgnKuyXH/c3dhAU49XIc8L9AzjIyk=;
        b=bFozL5dC6bkGRAZtMpl13OdU51XmReaRHy7wo4ekbY1PEN+hLFCik62Viq30Ji56lF
         oQAbAzX7GN0iutRAauGlaNjp/2obQcgp+j+f3YPf9QErJMkI3xsGNeTgkOPg7OFuuvZh
         a5TFP71eitU80arUiqoPMWemyrV7k9rKMd4hJyFO/MG9Ya77K29utKTzSg8j88Iz4OwG
         sNz/DfclkLqwvGIgfWSiQbHhLV7MNbEet2V897AJj9Xz/sL/5qUP9+QOYbXsGqhC2TMF
         /R4RHy7IbETh6BrMjqjykLyMKHHr/1t/Mnf6iVWEYYdEUXWf9Zf+knkKtcCv13hcE84w
         pqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750164004; x=1750768804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytPjJHvma4FQtvEgnKuyXH/c3dhAU49XIc8L9AzjIyk=;
        b=setR9nzrB1F1hGqQJwJIpgE8SiAdV+jojy8AMOF4+RDhcLIeREYK45MJ+jVCSPvrU3
         nGmJ5dvqVcnzDXKa/KG9NoOJaij/nr4+w1y0ZEn0bXTUievpgYtAotmfLjtx2S9zLFAQ
         7lBwZxZdtqElnfOIzyXJkzRXDogBAIVl5+BtsRHYott6ORNPUYLNyX6TSnBOTvIS2bQX
         L0HXIuan6w2kDwNtt6EAv7c+wZdR5Ncfi0173qhkVqyBNcyL9Vwxp8XsckjfQ4ekvPiU
         zjNFLLWiowZqZ2hGqvzhAAJtVpvgGpM/iHaTwN5ytCMqvt7ZJiy07nsdSPZZaPJFHIXe
         MT/w==
X-Forwarded-Encrypted: i=1; AJvYcCXzWjiA/eelfQcJ+zswenj0AF4E9rJeJ6GqohHxnhJrQlu/FafytRpRfnx4KM38THXMTYyyOq6g@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIa9aEe8vsjoRVAmnYyU/3t72XxdrXXquN7ov6rPpnK5Zml58
	0BGlUM+oczxL/K2+2PLqYm6PK+CcBRl7TX/OCBgwIbqhWQAa4qkRR298ReSCUiEbtTk=
X-Gm-Gg: ASbGncuWnpFKzKXCGDigxndq82y++cQMuMk3hAlLQ0divbdmSeFmpfMjV9LDj4JQ+pA
	kojv+Ld8vEhtGsM8T/naOugGequSGV28QyVt7BqQfgu2+EV8bPjTgKQ3o+kGfVt83PcyF75+7cV
	81QwGufJxDaprkeUScZllpi+30bqiAyJ9DkE6+DlN58DSYKgip0hxw/dugi3EuseXiFhiFE3/TE
	PLl0pyNKLqDFjQeTkvCyhveIqmOCwC8KZ33LpPh1UbxhsYiVolKUPii/qAIyfpjF7Vfk+zEyqO7
	pRL2lefxTz/guid+jIU6TNqga8Xyjee3GT8Tw16dR5rZ1aRQWTHXOfWzJ6MMJndz
X-Google-Smtp-Source: AGHT+IEOdWy2Mwxtgb9/U6R2bT0t5VY/D1i4vnDT8/fObQPqO0r0UDJm0jcaEjvkdQ0vbqb6Bpv8xA==
X-Received: by 2002:a05:6000:25f9:b0:3a4:f024:6717 with SMTP id ffacd0b85a97d-3a572e9a4a5mr10268668f8f.53.1750164003871;
        Tue, 17 Jun 2025 05:40:03 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a63a42sm13869802f8f.28.2025.06.17.05.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:40:03 -0700 (PDT)
Date: Tue, 17 Jun 2025 14:40:02 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking
 cpuset.mems setting option
Message-ID: <x7wdhodqgp2qcwnwutuuedhe6iuzj2dqzhazallamsyzdxsf7k@n2tcicd4ai3u>
References: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>
 <8029d719-9dc2-4c7d-af71-4f6ae99fe256@redhat.com>
 <CACSyD1Mmt54dVRiBibcGsum_rRV=_SwP=dxioAxq=EDmPRnY2Q@mail.gmail.com>
 <aC4J9HDo2LKXYG6l@slm.duckdns.org>
 <CACSyD1MvwPT7i5_PnEp32seeb7X_svdCeFtN6neJ0=QPY1hDsw@mail.gmail.com>
 <aC90-jGtD_tJiP5K@slm.duckdns.org>
 <CACSyD1P+wuSP2jhMsLHBAXDxGoBkWzK54S5BRzh63yby4g0OHw@mail.gmail.com>
 <aDCnnd46qjAvoxZq@slm.duckdns.org>
 <CACSyD1OWe-PkUjmcTtbYCbLi3TrxNQd==-zjo4S9X5Ry3Gwbzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="56vaxekarlsmjcqn"
Content-Disposition: inline
In-Reply-To: <CACSyD1OWe-PkUjmcTtbYCbLi3TrxNQd==-zjo4S9X5Ry3Gwbzg@mail.gmail.com>


--56vaxekarlsmjcqn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking
 cpuset.mems setting option
MIME-Version: 1.0

Hello.

On Sat, May 24, 2025 at 09:10:21AM +0800, Zhongkun He <hezhongkun.hzk@byted=
ance.com> wrote:
> This is a story about optimizing CPU and memory bandwidth utilization.
> In our production environment, the application exhibits distinct peak
> and off-peak cycles and the cpuset.mems interface is modified
> several times within a day.
>=20
> During off-peak periods, tasks are evenly distributed across all NUMA nod=
es.
> When peak periods arrive, we collectively migrate tasks to a designated n=
ode,
> freeing up another node to accommodate new resource-intensive tasks.
>=20
> We move the task by modifying the cpuset.cpus and cpuset.mems and
> the memory migration is an option with cpuset.memory_migrate
> interface in V1. After we relocate the threads, the memory will be
> migrated by syscall move_pages in userspace slowly, within a few
> minutes.

Why do you need cpuset.mems at all?
IIUC, you could configure cpuset.mems to a union of possible nodes for
the pod and then you leave up the adjustments of affinity upon the
userspace.

Thanks,
Michal

--56vaxekarlsmjcqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaFFiHwAKCRB+PQLnlNv4
CFnDAQCLg3MASOPWqGFIovOVrrY4FnbPra0YxgV95dieDAtqLQD9FBUJNYwz1AvB
9lpcr7rNBEV7ussJO3hHD4jym91gjAo=
=be/q
-----END PGP SIGNATURE-----

--56vaxekarlsmjcqn--

