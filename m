Return-Path: <cgroups+bounces-15313-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLJ6ANuS32n5WAAAu9opvQ
	(envelope-from <cgroups+bounces-15313-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 15:30:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF98404C74
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 15:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A27E300DA68
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940ED39478D;
	Wed, 15 Apr 2026 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="afx80R+a"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9A3A7828
	for <cgroups@vger.kernel.org>; Wed, 15 Apr 2026 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259800; cv=none; b=E+paw4f4PfWjfsZh5J+OpUGxD8nuM2Ty+m64TF4kQs7/W3NnQ/6SCbYsYzZTvvOAIYS6vvwrv7Y0HPdm7PV09fCsAaAER26c20Ink/2K9oxL792qZckdrmlHYoEDajoidBJ6VpIdm1ByWtTpcvwEC2jsF6LHtS4zBXqDacOru1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259800; c=relaxed/simple;
	bh=p2Me4kjVF7V4eTZB8rfwnq3oTxMV1jmLhF+6gaAVArU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOr8BYaiVweWVY4m6tO/LArEEGwNy30NM/ATMX5LCzX1kaX9k2JEOiuGLWrpr74nUmgwp5OcqVLJWOsdfcG/uo1yLsCzXoYSjxzrhcLe40P+tbqQs79eZZQ44TjHG6KTeHGVndouz4tZ9cW9ZKiaU8GhhMQ0wtAElTEfzm8yI20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=afx80R+a; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso80230875e9.3
        for <cgroups@vger.kernel.org>; Wed, 15 Apr 2026 06:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776259797; x=1776864597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KN+OlszcVRr0Gp6ojF90RC9ICGAzmt5OYyHWl7ygZm8=;
        b=afx80R+aijNl5kFWVBDo7OZL6sh4kf8WJM53RnQJYTItOpw83eYmTNZ5k/9M22+dWw
         KR+xYMvH+h9EFzvD2x4ymX4zll2H3Z5qbLx+pUtw5C9gdyUmrcnuAy7NqaUE2E26e0z3
         3Ip/c9V0M5fXaX6XfeWYfEKmtb0KoAn9c1l6IP6idhfJshc+EV1mZZFE/WKRHL0yrZk3
         jOJJ+DWUDhaQ7/6rcjbVJvUBf02JGEJ3jkiXmsUoCCnq4zhC3IGT0dGQFy54p9WxIWPb
         24g/Takfav5WS/GA1RhWGXGdYnfoQuf/0Sj8nnnPWRzsbe0qy/rCo0pU7xHkT37lwBwV
         tQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259797; x=1776864597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KN+OlszcVRr0Gp6ojF90RC9ICGAzmt5OYyHWl7ygZm8=;
        b=TywdtgFLU5vGr3t+6I4eyzJa5GrIR+Z0OP6Zy6ii18+ck/QJ6u3dETQfQp1Q4DJSVC
         CHg9UIu3TTIurzwQoe8D0JsevESRIgecya8yGZ0z+xXjXb7JYINE3w9tzw1JS5rXVL+0
         FeF164eewnNZsJ4WmZo/2a9n4oRqOny2OwXxJYT4D/4sVMC17a+HB8jaJiEp5loRjer3
         hnmE6HkN08jUKzwc0oVqRGdeMyeEfRKsksH5WjD7W5SIFeV4+8mFROfV2CKintWSG6x/
         5SkZ0cy16eJuBy5uPP/A5r9Uj6PkWuwbNvFxAmGSpGyyIcFd0r09Ay057b15+i5SdT1C
         maRg==
X-Forwarded-Encrypted: i=1; AFNElJ/oUUlU5VHho2WijAM0nkemLeb7bunZtGZdgi9XKbTAKiZie3FOsil6xKOAs2iI6biSF5GV5/0M@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfj9+jJX2uhndLA0okYvRqUOXfTA2B1UCnuJ96ywnzBXNSKTjx
	BwiuJICNPEfq6G0TRq3G5q9uZvcDG5nYGAdyXhlgtUanzo4rlJ5pgnw3DdKQrgd2uxU=
X-Gm-Gg: AeBDievoVs1sLGSvF9JW7JM+VcpPHbCIwMD3gw/MT1Gx5XxXlXUXjuGu+fhh1XNNYnw
	z7oXcUrFnmUj9idjpLNYX0xXthxUvh2zAbYRGqYwLZ/FvTssxAMDtwbL58LUyOOS2lvFhRsP8s7
	MIi60uO5m5YK6hqKe2fWoyhiKEcdzxC5pfWsT0KVf2va9Pb0ODHtBVehNh8oJNWyEVxRKZ2GN6Z
	PRx7miq4wuo84GNPvfp+Zo1wJRfPMp1pijEmCRUSMasm4EARpF21RgUuhiZ+DCJ+EztPMECR1DO
	zlAZWsDnQlAPFywsrCW5dp6LTroT9lctorA1y2aA6Y1EhT/NHgN71jciEGuUCp2ocUXDQxM12OQ
	IDq+W3SZYS9vtZh/cflS54P6Bial8RkmF/VblX+H8sSTQCJ6h+a2u6bFxEUg8HPc/lTXt8MiaKj
	59X8B4tyS8Nw6mnNTHxM3OB0roi7O8p441emFrkd+M/B5pZ9VMnTesww==
X-Received: by 2002:a05:600c:4e45:b0:488:8c89:cfaa with SMTP id 5b1f17b1804b1-488d67bf6e0mr320812265e9.3.1776259797017;
        Wed, 15 Apr 2026 06:29:57 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f096d110sm26867445e9.11.2026.04.15.06.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:29:56 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:29:54 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: cuitao <cuitao@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup/rdma: fix integer overflow in rdmacg_try_charge()
Message-ID: <uvbdtbqefxyx63l5gxrbgtjgpscwxswloatpzfzkirhqvwsunc@ihezth63q4tr>
References: <20260414015327.306721-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oi5gi4wcf7swwowz"
Content-Disposition: inline
In-Reply-To: <20260414015327.306721-1-cuitao@kylinos.cn>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15313-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 6EF98404C74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--oi5gi4wcf7swwowz
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/rdma: fix integer overflow in rdmacg_try_charge()
MIME-Version: 1.0

On Tue, Apr 14, 2026 at 09:53:27AM +0800, cuitao <cuitao@kylinos.cn> wrote:
> The expression `rpool->resources[index].usage + 1` is computed in int
> arithmetic before being assigned to s64 variable `new`. When usage equals
> INT_MAX (the default "max" value), the addition overflows to INT_MIN.
> This negative value then passes the `new > max` check incorrectly,
> allowing a charge that should be rejected and corrupting usage to
> negative.
>=20
> Fix by casting usage to s64 before the addition so the arithmetic is
> done in 64-bit.

Thanks.

Fixes: 39d3e7584a686 ("rdmacg: Added rdma cgroup controller")

>=20
> Signed-off-by: cuitao <cuitao@kylinos.cn>
> ---
>  kernel/cgroup/rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--oi5gi4wcf7swwowz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCad+SzhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AiR5gEAsgN1k+g964JpikiLjfVN
X0yCfTYu/QhcJNbSA81M8VgA/1mRaI4iWb1L41eelRP0hO50kIQrEAX/pHpQ9Ywe
oAoO
=V7Yb
-----END PGP SIGNATURE-----

--oi5gi4wcf7swwowz--

