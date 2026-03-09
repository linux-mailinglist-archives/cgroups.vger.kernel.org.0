Return-Path: <cgroups+bounces-14719-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMvhK9UNr2njNAIAu9opvQ
	(envelope-from <cgroups+bounces-14719-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Mar 2026 19:13:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC0123E634
	for <lists+cgroups@lfdr.de>; Mon, 09 Mar 2026 19:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC3E73158077
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2026 18:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C69339B41;
	Mon,  9 Mar 2026 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D3SxbZGT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBD933A039
	for <cgroups@vger.kernel.org>; Mon,  9 Mar 2026 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079629; cv=none; b=iACtfLV2pp8FoOVO68LTV7Z88TnwHKPDV7nLK3xHWMjRSSBhDQL55SCW0/XFP7Zi7uPgcS1sWcdNjsr5DFzCSBk3t0h2ChIDhvsR1XJWOl+sBV5OktLDIorvDNlXjtsv+ZlZFJZnbtR0anoguKsF2JbCYM/VPnzhrk/EuUOL/Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079629; c=relaxed/simple;
	bh=MmljSQnw2lcYLsSo3FghZOv/9z9lThlxmlthDeAKQp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6x/PcY0UoWXLFlijWqQss7k82YseuhvXcsurQfbyFOZmqJ6dESrHwjItJmuCLxHfTW08zMqdH1Ngvog0JH5bt/jR3/ot3yhFnLqWtzk9T1M2zWXK5cKazfZ7efQEl80xB0EJHNKtxq3Wn4SGKCCCed/pkH3QaaKl0WfetvGpkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D3SxbZGT; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439af7d77f0so7694410f8f.0
        for <cgroups@vger.kernel.org>; Mon, 09 Mar 2026 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773079626; x=1773684426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrfDzIDC5Rwkn3qiBzXUKn7XOVFFMBF2JI8saiP7iIE=;
        b=D3SxbZGT9Lz/X6NgZ1mHGvVazeFTqbOb+mX+TpTFjbUPJUZY0K/f/Cpxjfm/uOubGF
         Xrp5QMS93zFqoO8hkb8PLN3q5DdW6V6bVd3++6JIr4AOxVjZT1m9NyBj0ebk45rxlSZo
         e4cDAcDYIap7KFnDY8Cd1kqK9TsgzK/qdm5j0BJmqoNfCMJkUGBpFy62Xora3AnRWF4N
         PqsNb06kPaUoxdfoPl+pKNIuwXXUIxhJFXM4MQ5pX6ucOVrSS9Ta84tAbr91pEqYFRZ/
         r/GxtSS4K69EKQQ3MJ5FaMJSuEVN5vnsIb6b4p7c+/OPcawjwZXqIEIt7rn75plc7fXl
         IvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079626; x=1773684426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrfDzIDC5Rwkn3qiBzXUKn7XOVFFMBF2JI8saiP7iIE=;
        b=KpHs2dvydegVE0WXvfxAfWhFiqQzXk3X/lwe5WxAQaIsYjAvoA4rA37glWMub+2njY
         KQ230AGlyXYMo448LhDGkYi2+EVUGLvxld9dIZEZgvVTpG5Gze26PJYDbRDsIh8KR5Lt
         EbDDrXLOyq7sD33DTliXNxKlmdslYRUrU0eBeyC/UBnTs0wk3YP/ueYY75HKjwWV+U3t
         qpgWovVxU7qXQa3/lzV6ibdlTBqOaiYyyvJHhK5Z7c9NLZsc1FwYYsR4Mb9arzmgio6l
         iwAiiO1EZKebTyezrOVS5WmdJ9tcpNx0N/DiBM48HzCgJEYu5wQnT4OHkYoyXu+O5zSa
         De9w==
X-Forwarded-Encrypted: i=1; AJvYcCU76ePmCudKfNIRdmFgSLhHcHJz7p2KoTmg2v+2SiSr08Ub4DpbscUroqsJc4iiPxJNebFkghhN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56KvpeRQguD/zgne//TplIUtjy/CpslN1Po6liMc9vwXZYA9n
	tz5BOw78SV316DXaUNt96XNHV2Z1BeVlOo46L6MzurCXvwspjxfBKxCQLz5JVIQI1iY=
X-Gm-Gg: ATEYQzzpxzQ5hcSj0F6aFIwlzNAwpGAtw8DcPZqqYV+Dt3F3/foodtaV5FeYzKHx1kk
	i2sq55jYARf2nf3R+RmU2FH3Z1pqzYbuoUOCzPf79Ua2Np+FVv/ld0eAXFyxn16hrl1lmOQbq3X
	eDWSFr/Mh5X3QZAUyIfAVP0WZ5UqTPUHd94kt10WCYn7GVH2SHsuZLaYSsilgIjML+73pJUAacf
	9pMm1TWH0mvq4vCIjagiFz40yqKln+xZlEJjbFwIAFvmblg2F4vGAccqFY15AXkrfPLnrJRePXc
	/GnT1I0YRYA507a78ot/PLiZpqzG05ygWHMsXojOS9XtpOnsEDxHjWIz3cKAExe8394wIkBZ3UZ
	Qw+1Zoh1SH8Md4FpTJyoFtAPSXPftNGVmNYPqkkOWjvlPRsu1oam6ua+GcYyofamjpNnkGbp43q
	/XYuH7WWrY5/saBoAWHV80ETR5Wr5y/bNJ96BF/SIAyis=
X-Received: by 2002:a05:6000:220d:b0:439:c43a:acb1 with SMTP id ffacd0b85a97d-439da67c0bcmr22231635f8f.35.1773079626120;
        Mon, 09 Mar 2026 11:07:06 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2ba66sm24939422f8f.20.2026.03.09.11.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 11:07:05 -0700 (PDT)
Date: Mon, 9 Mar 2026 19:07:04 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftest: memcg: Skp memcg_sock test if address family
 not supported
Message-ID: <4ddd3jascnb6nt7quhyjfmsgsmtfmjofwmnrgjktz57cfbfymj@6ejbdgbg4lz2>
References: <20260309160205.651754-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yd53fwzzczbtgjoq"
Content-Disposition: inline
In-Reply-To: <20260309160205.651754-1-longman@redhat.com>
X-Rspamd-Queue-Id: 1AC0123E634
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14719-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim]
X-Rspamd-Action: no action


--yd53fwzzczbtgjoq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] selftest: memcg: Skp memcg_sock test if address family
 not supported
MIME-Version: 1.0

On Mon, Mar 09, 2026 at 12:02:05PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> On systems where IPv6 isn't enabled or not configured to support
> SOCK_STREAM, the test_memcg_sock test always fails.

I think IPv6 is not substantial for the check...

> The purpose of the test_memcg_sock test is to verify that
> memory.stat.sock and memory.current values are close.

=2E.. so this should work with IPv4 too.

> If the socket() call fails, there is no way we can test that. I
> believe it is better to just skip the test in this case instead of
> reporting a test failure hinting that there may be something wrong
> with the memcg code.

Yes, the skip on (any) socket creation is also (independently) good.

> @@ -1460,6 +1466,9 @@ static int test_memcg_sock(const char *root)
>  	free(memcg);
> =20
>  	return ret;
> +skip:
> +	ret =3D KSFT_SKIP;
> +	goto cleanup;

Maybe make this analogous with other cases where there is no specific skip-=
label but

	if (err =3D=3D EAFNOSUPPORT) {
		ret =3D KSFT_SKIP;
		goto cleanup;
	}

Thanks,
Michal

--yd53fwzzczbtgjoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaa8MRBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjPoQD+PmjLLORgemm6L6Wd7y1R
hoB0caqu50AlVSz1SKP3ThsBAP+AO9l6EzSrSBWNiUV7LSV/NsXeLyrdxjriU91M
fVEL
=GNSq
-----END PGP SIGNATURE-----

--yd53fwzzczbtgjoq--

