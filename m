Return-Path: <cgroups+bounces-7241-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B9A72CAA
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 10:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E36F176FB0
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 09:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD8A20CCF0;
	Thu, 27 Mar 2025 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AohM6zpU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430722615
	for <cgroups@vger.kernel.org>; Thu, 27 Mar 2025 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068605; cv=none; b=o8SS/CXQvUr/OvAZEnFghwIvNjP0rsgW1SYoFLALAekutKVHuKpTRx8iFc7v4IElmZCndGlbjKYYy4mnfSOEVxdfGTcJvjK6Gje7oK0/gxwH4Q4hcSwjgJLiC7u/mGQgb2rk/7NEgk1SZrAAufpm1QT3YZDWfINqh1VT0sKJfr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068605; c=relaxed/simple;
	bh=RQI/b+5b2edO2Zw7Frn6Ca5fIDxB6ZihWM6BQJgkAiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hz7eK/MGMDfG+HFkLPc7pe+KytORHF3ZE7oKWAYkR0ebz64PVr5uBFDgwHeAWDoQwgK45dZV/MDV9+ojrwedxpjoVseocp9ocU2fu2n0XUMTIC4mzxB6g0A4KCVJpRyfwY3vaXAEhyB1U9PuObG46K3DNul56Eb+oNPwfHewXIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AohM6zpU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso621822f8f.2
        for <cgroups@vger.kernel.org>; Thu, 27 Mar 2025 02:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743068602; x=1743673402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MH3oLkZ3QoHPrfnbUPiT0wxSJtA1cLOkJbbbBEVhhYs=;
        b=AohM6zpU1vVZv+6TDKEGGgKFhtXqvoFpYBiE+bM3QOGQF8+YP8pydG5UMdnvE1Odnn
         rQ1Ykh+PA0bM4uFTgpdR+0dwVcsbz5yEpB7BxC470vTsgMjMrwMcvU+5kAS8Gn/qzTtD
         HscYRmgzMqSXZKW2ZIM/CBRI4bIVIK/1hCGkwsURXMkwedHiWXCGJMTX44Bl0nAcwz9w
         oE1N7nhVUqRYoAGm0pv9bRsJ8Faopme4pHLwEvn7HUf6BLOpCJ2ebwf1vpeOR3NButi+
         YyQjlmaL8mu+6I92atd5/SCFpaOlS2A1h/JtBlIH5jFQTeVxE2Us0njKcV1kL89Q/86D
         SSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743068602; x=1743673402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MH3oLkZ3QoHPrfnbUPiT0wxSJtA1cLOkJbbbBEVhhYs=;
        b=o/Mi3OpTjntZmrZ8pd0hKLaf3zyXM03EPSuOIhtLF6OUrsI9Gnddw2+1HfycftbwRn
         HKheVFm1/pKbSxrqs9qHY2QVhK1ZGwAXFLQduwHHiOGamS9+qKj+KCrKn9b6ZUhkJG04
         dTCYa8dbpTbBWENzYx3L2rV4mjTsBz5s5rvJ0UCCdOKhoL2dxsjsxyKTVUewoUjak8gj
         QKSgNHxYJCo1lbjJWznkPbZaU3hg2ILoCq4yrLLkpOjnsO7DknWh3ljpXVcWnOOm6vbb
         aj8E03rDoGTKn24X/pYKlPvpbDSRbPbtKrErIObVzud0DvtBLCSRicN6VJSN6N494is/
         YtBw==
X-Forwarded-Encrypted: i=1; AJvYcCXMbNuSnSrslaotVfTpzNv8ClVuSkrGNwYTsu4r2hE7pbLlfjX26eY01CYRz9YhmdkaEMqUegIm@vger.kernel.org
X-Gm-Message-State: AOJu0YxkyYdkLfkNli5aSwxwlt1415aRBMbNnShuwAMqFJztjb4rZdGR
	mC4umtyoWGlpoUXHdYMbvbIRp64Nosk8sovUpRLHNLsiRGeedAoBythoj+3QCNs=
X-Gm-Gg: ASbGncuBsw+qGVQN0eYzP1sBuWMjrJjbm2Zmt5FQaibzIhiBUr38Eeu1eoi+RX5BfJ0
	vOn09ZuejQACSa/kqNcxcE3B2qt5pYWPOQfoteMmj2e0QAyKU1YemKLq5IJ/q4QSSaB0wxmkTGB
	b7bSBVcm6iVCdgCsaraqOdeAEke/oCV6ICv0b0w/+XyK/syzUoR/Tc1izadlswNqhU1UmeaBJCL
	S6F3NbbvyGxbD422hIw5ZsNOLRGNXEMrRkofJAwncW9otff/t/yXGgy0BTUY7cBFxH883HUz4b4
	TvszPbM0QbMYQAsZRTbgR/Nsz3Tmi7Cf0pVSI3/RbbssG88=
X-Google-Smtp-Source: AGHT+IH1WiFsXOivY3uNtWR03fqybSpj7EH4HsxNZKa+E51aIf//dEXmU1/S3e5uU474CO7buz/DFw==
X-Received: by 2002:a05:6000:2cb:b0:39a:c8a8:4fdc with SMTP id ffacd0b85a97d-39ad175c052mr2145200f8f.16.1743068601849;
        Thu, 27 Mar 2025 02:43:21 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e6ab48sm32678605e9.10.2025.03.27.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 02:43:21 -0700 (PDT)
Date: Thu, 27 Mar 2025 10:43:19 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: James Houghton <jthoughton@google.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yu Zhao <yuzhao@google.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH 3/5] cgroup: selftests: Move cgroup_util into its own
 library
Message-ID: <fg5owc6cvx7mkdq64ljc4byc5xmepddgthanynyvfsqhww7wx2@q5op3ltl2nip>
References: <20250327012350.1135621-1-jthoughton@google.com>
 <20250327012350.1135621-4-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="emghnkmnkyymych3"
Content-Disposition: inline
In-Reply-To: <20250327012350.1135621-4-jthoughton@google.com>


--emghnkmnkyymych3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/5] cgroup: selftests: Move cgroup_util into its own
 library
MIME-Version: 1.0

Hello James.

On Thu, Mar 27, 2025 at 01:23:48AM +0000, James Houghton <jthoughton@google=
=2Ecom> wrote:
> KVM selftests will soon need to use some of the cgroup creation and
> deletion functionality from cgroup_util.

Thanks, I think cross-selftest sharing is better than duplicating
similar code.=20

+Cc: Yafang as it may worth porting/unifying with
tools/testing/selftests/bpf/cgroup_helpers.h too

> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
> @@ -16,8 +16,7 @@
>  #include <sys/wait.h>
>  #include <unistd.h>
> =20
> -#include "cgroup_util.h"
> -#include "../clone3/clone3_selftests.h"
> +#include <cgroup_util.h>

The clone3_selftests.h header is not needed anymore?


Michal

--emghnkmnkyymych3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+UdtQAKCRAt3Wney77B
SdMdAQCSfMUeyxs7jRY1DgHYPciU4P2a7+sr132y+/5NX5fJ/wD8Dp4tx7S5u978
BgGpkmbqxF6HcGVx9Y4bacdDAkqBbwc=
=kBp5
-----END PGP SIGNATURE-----

--emghnkmnkyymych3--

