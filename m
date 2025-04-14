Return-Path: <cgroups+bounces-7510-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E39A880B1
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 14:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016E91777BC
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30B12BEC27;
	Mon, 14 Apr 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RsAdBq9H"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FC42BEC29
	for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634584; cv=none; b=sUBuaI2LrVveL4y+7zSUvD/GfKUFyQmqgmb8H9JhYdG4NCDdPKIdfoIIc6WRr+Gv4w9vT1a1rDhx+3jM1BgeQllrJrbtK4rp8vD+SAHx04Sjyd/PRthjl4IQUWTaE+t0EUF+aBNguj2ZK+/5l7SdmvMr4YG+zRivltc856HoOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634584; c=relaxed/simple;
	bh=mkz2kA+VXnowiojV4uf1dKbm0WdGQAV1VMpX8sQUKbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQO1+n2lov17WsuVmYXUjy/0/TwVfUt+ugK7g1GY1ql57fi89ckOcBMauMO9MEhOCpPJtN+7gZo8V7bQ4gDiIFuC38vM6ric01gP5RTUy9SkJEowYilzIhFBwT+oG4DKdfRszclxPPMEbWWFDpbr3CbFlQu9JZO5sSelhR6+Ox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RsAdBq9H; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso27988685e9.3
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744634581; x=1745239381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9ixK134YSYVvgH5n+g61PRZpWOKvjguSgzISWbKA2I=;
        b=RsAdBq9HVJZPiOtXUhr4Yy/KlVOOZMiHRMjgSA6rTYzvprpodglhgCe5ufVYdoKibL
         1r07vATVUoCqq6TBJy6lAKDgNlWF+bJ/MvQuCTgQmOut9arLH8yx/qcBWqwYJpXeOhBB
         FY/v38ZLMLYhtF4tJPQABh5tWzqdR/N8Jorf4VnIpfIjK+uhCpgx80E5nlah9UD6b1uB
         pNyyc3FS3pj+HOAnhgVzadQ7ZOaKiMLytyubPxmgTsBvYxl8NJikCWdhw9TBfJOnlQYB
         kB48EmwtrizcPpkusu0Hfxj2cwq5wwHaWVBE6ikvBJOJBOQJ2biOkKYEoYeI+MS0pyCd
         rJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744634581; x=1745239381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9ixK134YSYVvgH5n+g61PRZpWOKvjguSgzISWbKA2I=;
        b=etVkJdC82VgcDsiZCiK7AH0BCNt3n/jUplOpugDp1JNNiFsow+nslh0QIjaADCXz18
         zp85nsjvFA59MnnLFm2utMDy16tsJkAFTPJJvwimxQrTgSYkfl3kdRNnFKjwtjygHKFu
         rHW55D7oqtHrCfrZpA9SEFNky+qWlfWHYiCHS4Ut+F9StaCpUsPru+JVl/rUGJSreS15
         zTaHKYVZvqSFoF8/h7V+9BsywbqYz1X38djWTSb2YNvny9KbeQNDDHBA6JgiXA0aYLrJ
         3Yg8taZW2uVCgFXp1V+tJvo5DRstyQTFOVJETaOM6kr6ZVwUFjIroFIgHN+TuyahcGBW
         WF8w==
X-Forwarded-Encrypted: i=1; AJvYcCXnFZTS/talN7SwV91crN/MbgQVKo1pkKu5K9MXvhLPk8vRsuxKQ1czjN4ZHf5gXxxeA7WXPl8b@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxmth3ZkfnJyKhDvObz1+hRTAzaJQEM/O4QcXYvJ6iQHyJqIEd
	5hlrrsDbY0dCOQMFX2/r2pbsEp3420xCFr0cBFe8EYPbKSzjeF1H4s9DbxYJNxY=
X-Gm-Gg: ASbGncurlbvDavc9NAdshVLBOcRrZARAOASgbRFi3Rn2CYiCox7r2MnTcOFn5IxVkow
	GLuCqDvQif0e7JE+UsDawiy9tj87EThcVwQD8OePYn4ASaLnHc5BMkI5vhTCMkOFfEc8IKxID9n
	xUkOeK5pbj3RZahXWlePb67WA6D8pv1nSTQl0z4o9+p696/9NeAmMKzRmlXeQ1P7C3uTHgCOe/M
	4rZ6UDe9T+2Fu971CzGHKy1MgazZj8aS0M4jmzwsxuZ9lyGX3GUlOtV4yn/lD3hsTJop+TS0vGy
	q2RgHPul/UKnLP3usfBYjsLD191jihS1OY1qdZN0WI8=
X-Google-Smtp-Source: AGHT+IH7iIHRZ3vV/WkqxRDldhrP0zYk3mfrclbeNsJTpYta2piT0N21vJ20EAFWMAd7XZkrfuQvEQ==
X-Received: by 2002:a05:600c:8519:b0:43d:300f:fa51 with SMTP id 5b1f17b1804b1-43f3a93ebb3mr104821235e9.9.1744634580452;
        Mon, 14 Apr 2025 05:43:00 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c817dsm173048895e9.23.2025.04.14.05.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 05:43:00 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:42:58 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
Message-ID: <kwvo4y6xjojvjf47pzv3uk545c2xewkl36ddpgwznctunoqvkx@lpqzxszmmkmj>
References: <20250414021249.3232315-1-longman@redhat.com>
 <20250414021249.3232315-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="npwwpgxnj2lpvqxn"
Content-Disposition: inline
In-Reply-To: <20250414021249.3232315-2-longman@redhat.com>


--npwwpgxnj2lpvqxn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
MIME-Version: 1.0

On Sun, Apr 13, 2025 at 10:12:48PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> 2) memory.low is set to a non-zero value but the cgroup has no task in
>    it so that it has an effective low value of 0. Again it may have a
>    non-zero low event count if memory reclaim happens. This is probably
>    not a result expected by the users and it is really doubtful that
>    users will check an empty cgroup with no task in it and expecting
>    some non-zero event counts.

I think you want to distinguish "no tasks" vs "no usage" in this
paragraph.


> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5963,6 +5963,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, s=
truct scan_control *sc)
> =20
>  		mem_cgroup_calculate_protection(target_memcg, memcg);
> =20
> +		/* Skip memcg with no usage */
> +		if (!mem_cgroup_usage(memcg, false))
> +			continue;
> +
>  		if (mem_cgroup_below_min(target_memcg, memcg)) {

As I think more about this -- the idea expressed by the diff makes
sense. But is it really a change?
For non-root memcgs, they'll be skipped because 0 >=3D 0 (in
mem_cgroup_below_min()) and root memcg would hardly be skipped.


> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -380,10 +380,10 @@ static bool reclaim_until(const char *memcg, long g=
oal);
>   *
>   * Then it checks actual memory usages and expects that:
>   * A/B    memory.current ~=3D 50M
> - * A/B/C  memory.current ~=3D 29M
> - * A/B/D  memory.current ~=3D 21M
> - * A/B/E  memory.current ~=3D 0
> - * A/B/F  memory.current  =3D 0
> + * A/B/C  memory.current ~=3D 29M [memory.events:low > 0]
> + * A/B/D  memory.current ~=3D 21M [memory.events:low > 0]
> + * A/B/E  memory.current ~=3D 0   [memory.events:low =3D=3D 0 if !memory=
_recursiveprot, > 0 otherwise]

Please note the subtlety in my suggestion -- I want the test with
memory_recursiveprot _not_ to check events count at all. Because:
	a) it forces single interpretation of low events wrt effective
	   low limit=20
	b) effective low limit should still be 0 in E in this testcase
	   (there should be no unclaimed protection of C and D).

> + * A/B/F  memory.current  =3D 0   [memory.events:low =3D=3D 0]


Thanks,
Michal

--npwwpgxnj2lpvqxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/0C0AAKCRAt3Wney77B
Sd/BAP9TY2qAV5thRUJlYr+lBEw43c7tulDcGAlAmMTw3fVIxgD/TAOGmPlsQ9YN
ZZJQOw3S4qTSiiwaCq9RFx8VCKUEjwE=
=J0fF
-----END PGP SIGNATURE-----

--npwwpgxnj2lpvqxn--

