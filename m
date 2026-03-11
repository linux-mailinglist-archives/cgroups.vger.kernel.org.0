Return-Path: <cgroups+bounces-14759-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL2hIZNEsWlCtAIAu9opvQ
	(envelope-from <cgroups+bounces-14759-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 11:31:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 476A12623A6
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 11:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8C8F30E683E
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 10:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFDC3CBE88;
	Wed, 11 Mar 2026 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HpieEL+2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A063C1400
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224880; cv=none; b=TXJQwAOw+KJsonocEkzXEwjtulnevQUzrhnsDvFjFeKS8tsAHJibZzAKF45MmwRUHkcwkwX4M2GfKw2IXXvgCBEvELYIGjjtMbgZuX089JUHcfzQZGeuVlVljj7+Jj+kQDu/yqPchGqzgeeCg9147tts3zlQsNNCZt9Ub+BxF1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224880; c=relaxed/simple;
	bh=OhZeESvtdZ4jcH9ll++uGOg/vtAvdZiKWXfdTC4/v0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evYtKl/NyshPfxZTtOcmv3uYZhQc0ydhUtsbLVwbbxbo3v+pO5kk8RjDHwXHjolZYs//p9cyyZ5nhxT0vczTym8gJjzSJYhOccr81nDDv2x44X2OFt/e61fde/Komn6nodBzIlNXq/X+EEqEeZS048+NCRfSeaZ98OSFYQ2wdTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HpieEL+2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-485345e1013so6347305e9.1
        for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 03:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773224878; x=1773829678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5j4jaAYOM8eCoDOEvFzIXtQzN3FUkdB0X3c7yVW0+s=;
        b=HpieEL+2kDYR+JFtfFNSc7yS7FlOBfG+FZT5dMBSUe9KHKzXaMHJa6EMbuc1kgow9K
         oXAf8BpIEXTWOoBTNODxBBnlMoRKVkPCbbziWap/TizI3B3R9Ma7RiafuKCdfYRLMqw3
         78r41Hx8Z0znueyUgSpoQBI7lvHCgjtz/9Xjlu5VfPSneCgcUbtkh6BdgSJ21m9DDmQV
         z6yYKdfgB1mytmFuhfvd+BrF80tI06whXcUPISFPeIxTRE60armaEAbkceg1M0vREegB
         Ea5EuQYqsF/s+3GwZuUABPvsNLApN1y/TDmR0esxzzElqZ2WCs7px+fJ57Lpfh23UG0p
         VrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773224878; x=1773829678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5j4jaAYOM8eCoDOEvFzIXtQzN3FUkdB0X3c7yVW0+s=;
        b=TH3OUhjvr/48WYv2+cU5UFsRjJYiRl+w1xPfoKzA1Jl3AAecPf0N55+ArN5Qb/G6R/
         PbTmEiEvegslM7Nx3l4i6rPMnxq2x5C9IcsLykZdIpkpNmG8teNfui8jisMs0fNbv8gX
         4O4JrQyWv+5Ggtcay41JT9hZpZLlSTT78ymyJiOTOehbF+NgdpBweiRNAuvk3iHCtRNR
         ZIXutmVAoIpm/ln+C6L9Ta+pflbgEFC4vMQ0255BOyWaMhxPt5EzmsVRFpYazA5LU4S4
         F8rLpDVaZuZDDwNPYO7s2xXPSRN4DMvDEyJ7aTWdmR62cL6hRKrzSJmmqn1XNqly2Tqs
         pcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg3hk1E2GFAIuIHPpeoK3LbRky4Oyfis4ECDhSIt81lQ1oUH7eYLLvinqLESszjssVcAUXqcdM@vger.kernel.org
X-Gm-Message-State: AOJu0YxOs0iu04NPQtmaBfVZwyXV9wpW9Aie+/1Nsb8ObvwfVz1sUIGv
	7cpsFlG60OzkgWSbraYO9pbivxo8k3kvMSSN+FWKsy4I92+J+LMbprUb6Xu2aWVdMwA=
X-Gm-Gg: ATEYQzw7/uOxEhAoQiemVked5LdJexQ9l4XUUJJaZz2zVgeoqw3zLbBBRcVevJ+GaRt
	+SSsRVARgwAF9f1fms639+e4PwUCC2l4XAEwLyWgmn4/uH5xAsEGtAdSQd0LbF24sbracp5K8al
	DbjdIDzMYXzH/d9Qi8PhBjZKR0i+bmgM0SsF7gYD3AjvmvWUEy4XCzJstxFykzOJ1cVeBaBqSWr
	BpdZ0hKLZR+LGpOu6UPGsk1rcTfrL2zW2G4vULxm3vvOSLDfwGWtvr2WpQB6O4cPsu7iM6v0V+D
	5z+MUvY6kRt8VOqWEceT8WWlITnyxRJbZ4viq1OOpGsmoA4T8jDPTp+nzut3ylXlhlXg9NNEjpQ
	o6BVNI4HmAOzIuAV1AUiWPjSIwq2NYW+fhQBKYtijn3T4O2T56+1tpuAevlxN3lE7icpuFvebhT
	zbUjp/os8wQ8l4yEUHYmsee/KaFGkjsjzYDF6PTct3O8I=
X-Received: by 2002:a05:600c:8b05:b0:485:38f1:5cec with SMTP id 5b1f17b1804b1-4854b255a79mr29402935e9.7.1773224876909;
        Wed, 11 Mar 2026 03:27:56 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b6756e4sm49552295e9.15.2026.03.11.03.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:27:56 -0700 (PDT)
Date: Wed, 11 Mar 2026 11:27:54 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftest: memcg: Skp memcg_sock test if address
 family not supported
Message-ID: <rbw6bit7rgcpcw5zc6vdezp2x3sufogled4yxn2i3xmjkg2gb6@i2rpowwixa5m>
References: <20260310143936.720592-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pa4tyuvad3rxlz5h"
Content-Disposition: inline
In-Reply-To: <20260310143936.720592-1-longman@redhat.com>
X-Rspamd-Queue-Id: 476A12623A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14759-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim,suse.com:email]
X-Rspamd-Action: no action


--pa4tyuvad3rxlz5h
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] selftest: memcg: Skp memcg_sock test if address
 family not supported
MIME-Version: 1.0

On Tue, Mar 10, 2026 at 10:39:35AM -0400, Waiman Long <longman@redhat.com> =
wrote:
> The test_memcg_sock test in memcontrol.c sets up an IPv6 socket and
> send data over it to consume memory and verify that memory.stat.sock
> and memory.current values are close.
>=20
> On systems where IPv6 isn't enabled or not configured to support
> SOCK_STREAM, the test_memcg_sock test always fails.  When the socket()
> call fails, there is no way we can test the memory consumption and
> verify the above claim. I believe it is better to just skip the test
> in this case instead of reporting a test failure hinting that there
> may be something wrong with the memcg code.
>=20
> Fixes: 5f8f019380b8 ("selftests: cgroup/memcontrol: add basic test for so=
cket accounting")
> Signed-off-by: Waiman Long <longman@redhat.com>
>=20
> [v2] Update and commit log & adjust the skip code as suggested by Michael.
>=20
> ---
>  tools/testing/selftests/cgroup/test_memcontrol.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Thanks,
Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--pa4tyuvad3rxlz5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCabFDkBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AirqwEA5ez8dlyt/ZfidHe6iSqC
8cAuhuEPnD7bwDGi8sH7DSsA/39ZAFz8X5c/wfwzVixVP458FkA+Xqr/aPpG33QE
WDgD
=jKdH
-----END PGP SIGNATURE-----

--pa4tyuvad3rxlz5h--

