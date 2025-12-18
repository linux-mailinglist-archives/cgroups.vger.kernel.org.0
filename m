Return-Path: <cgroups+bounces-12515-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F777CCCD27
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 17:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84B633114C32
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 16:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B949A2C11D5;
	Thu, 18 Dec 2025 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D782mtL/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7765126F44D
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766075561; cv=none; b=GJF9m0miiA2N8imq4+q7st+tSFlzDiXDGZlN1HUokc6j80hVdbmGdgfn+CFrmwkJi4r1st+PE+FfobucauQBBFszurC9n9rOQvR7YqnRCRtVTFW95jvZEYRDC+GldZOGifj+U03jlLXkaw4ziH78t2teYsPBmEVbxM3KAoV1h4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766075561; c=relaxed/simple;
	bh=SNnvyZ9vkTGATvlgI4Ih8b7/uG92hbaNc/B311zzepU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gR0pCM0u4A5useIFzS9o/kwKa8Ze8v2sN/KQrjGz7zCnDgqUx7Lttm2AebNBVj9R7C3xZUF8SmhKNElJ5GwqQctfyvyQzH6MfvpFXSq1WDrwVdoMvY2UgLVbyTuDqU0ZlL/Q/Do2Qkmza1qnp+KUu/u3+e0E5yvk+GRLUvubjH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D782mtL/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fb5810d39so414622f8f.2
        for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766075558; x=1766680358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNnvyZ9vkTGATvlgI4Ih8b7/uG92hbaNc/B311zzepU=;
        b=D782mtL/0ZUX8YYPZ1H1eLcMeww7bod9ij0QGI4iXtW+5WEPQSf+6rYFqSCD+Dy3We
         zn9SQ1X17Ho3YeOxa4eoLrhysiIkUvzunkQlvn8QxV7YoUaNtS0jZYH9R5SrSO5oUMPb
         x7+hiUSajTjs3vc6YM9MyAlNQY2UaEL5v8kV6XfCsZGUN8q1T1SQ8Tzn+8rZKylZbb7d
         ZMOieMRTNF4gdRDiJQN9uYOL9SViVY9Gt7eE/WpeA9f2ZQ43RXkeT3YlDvRLlwhOizdE
         EKXGpzoWEphNbfrWWJrY5mQFpLDfZi+ZvxZf1t0M42WwXzLIKElkx3ObQK8nsDY4FSnF
         8UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766075558; x=1766680358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNnvyZ9vkTGATvlgI4Ih8b7/uG92hbaNc/B311zzepU=;
        b=MBNqpoSDekJZvLwDPyEpIoKh/l07sCeaJnJSpQXXqX2CgeFA0pqy+03UYg3sMatKAF
         fcRZF+RHZDj8xVDmaUqKJUQMZOnWfrheXr7wkco4Ay6Ofd0HFrDudRrTVlGXUehUBkGd
         xFxwcQ+HmNxevrX2B4VvbtBMjE/QJTvUZMHzk3s5os/OdEssYjOui2dULpMm96ImCzP2
         X8cOXOL7rpMJL4u4j0qV+NkLMo9vy3Itd4k6qffa2XSPe+Nc83igG07mM27K/FWxWNyV
         ymWbKmQXqISSxavyg9c1HtA1nw45cWGSvvyavHKYa0pjgaDSoJ2HrspQQtce9js3pgAl
         8Gcg==
X-Forwarded-Encrypted: i=1; AJvYcCW6wxg1S6DmP1CRjKn8sa6AkKTzqtClgi2gzdxKXfTMREFiqxDa76lAK6rVWtyXlykgHSLS4WPD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Ghdmd3HHTr6yOzOghLYkSIpiWAZWr/tAc7tM0HMXz5j2PBA0
	rk5EHR3nGC5ePQc2UGona0w/lkKp9d0QwCQWJ8et5vHfKuOOlQLX1Xdd9FgAXshbHh0=
X-Gm-Gg: AY/fxX7jBldHbhr4sb/O9E0XJ5mNXZIglghk1TPQWF5s0cmc6KSR58ttlM2ldUJOBB9
	3MNS0TUefT/Cl1AWuBTHIzHrqNvUt6U8kKcLAVHUcxU5jdHTnALloy1hSIzzmEuVqFHW5XL8ZO2
	PizNCG2uk9KcQL35rYS7Y6da553Mu4kdPXvfWk+4t1mEfXxOqFgrHH5QY8VDy15qdJSm6cu+j4H
	6iW1dalpFLdRTIoPRHsVpGX8SDPuhY78IEsvq44+UC8YFgYKUNWEKuHPdvJWAKh7zEbxKfyPrz1
	rddNLw8a9zhY1R7ZFr6FZtzfHFzQOMNKXMx//dtjoqN9wLeft06o8gHL+1EQYRbASlIvKQ1qx6l
	WnZkmiuIM3QOXv1jDEyTquryvihWZUwLlfRzbu+Y1t0tUwu5RDzuuph0OgI4G4mN+/cEL+8NHl2
	GmVOskFBhE92aIhihj0raF95Xmsgwc51Y=
X-Google-Smtp-Source: AGHT+IEDIDE4KTVKDsejMKejh4/aXt3graRane6v6z7goX6BJROYVpK3YamMTvz3oWiatc+Kg89G9w==
X-Received: by 2002:a05:6000:420c:b0:42f:9e75:8605 with SMTP id ffacd0b85a97d-4324e45d3efmr154078f8f.0.1766075557754;
        Thu, 18 Dec 2025 08:32:37 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449adacesm5659879f8f.38.2025.12.18.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:32:37 -0800 (PST)
Date: Thu, 18 Dec 2025 17:32:35 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>, 
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 3/4] cgroup: Use __counted_by for cgroup::ancestors
Message-ID: <ecrvq2zi3tyewmjis6wdwxsvzkosobzowrm4xoxzxq35hhobev@m6kroxwbnfa7>
References: <20251217162744.352391-1-mkoutny@suse.com>
 <20251217162744.352391-4-mkoutny@suse.com>
 <87cc0370-1924-4d33-bbf1-7fc2b03149e3@huaweicloud.com>
 <aUQnRqJsjh9p9Vhb@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wgk3s36crhaoc44i"
Content-Disposition: inline
In-Reply-To: <aUQnRqJsjh9p9Vhb@slm.duckdns.org>


--wgk3s36crhaoc44i
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/4] cgroup: Use __counted_by for cgroup::ancestors
MIME-Version: 1.0

On Thu, Dec 18, 2025 at 06:09:42AM -1000, Tejun Heo <tj@kernel.org> wrote:
> On Thu, Dec 18, 2025 at 03:09:32PM +0800, Chen Ridong wrote:
> > Note that this level may already be used in existing BPF programs (e.g.,
> > tools/testing/selftests/bpf/progs/task_ls_uptr.c). Do we need to consid=
er compatibility here?
>=20
> That's a good point.

I wouldn't be concerned about this particular aspect. The commit
e6ac2450d6dee ("bpf: Support bpf program calling kernel function")
excludes ABIs, the example program uses ksyms (not kfuncs), so there
could even apply Documentation/process/stable-api-nonsense.rst.
OTOH, the semantics of level is unchanged for BPF helpers (that are the
official API).


> Is __counted_by instrumentation tied to some compiler flag? If so,
> might as well make it an optional extra field specifically for the
> annotation rather than changing the meaning of an existing field.

Honestly, I can see benefit mainly in the first patch of the series
(posted the rest for discussion).

I'd like to ask Gustavo whether __counted_by here buys us anything or
whether it's more useful in other parts of kernel (e.g. flexible
allocations in networking code with outer sources of data).

Thanks,
Michal

--wgk3s36crhaoc44i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaUQsoRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AinigEAif7sDzj0YSa/E6aI3SHN
mYIMVmAgfmHtGztVSPBZk2sA/0ZdHU/Uf6jg2QruCsbrQ7Xq1DBM5nc6er4+hPGS
UhwN
=ZHnQ
-----END PGP SIGNATURE-----

--wgk3s36crhaoc44i--

