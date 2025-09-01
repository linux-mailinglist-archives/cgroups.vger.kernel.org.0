Return-Path: <cgroups+bounces-9565-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689E3B3E54F
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 15:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC65E440E5C
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 13:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739833437E;
	Mon,  1 Sep 2025 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a0ciY1zx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E87327794
	for <cgroups@vger.kernel.org>; Mon,  1 Sep 2025 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733879; cv=none; b=fJCjfJNGGB7/yIS7iUfeshEOOEMougab9bIHW8HUNps7QUbEE7wlxlbZZaJleCheUPH73yc647Pk3wugGUuqFd9AbCeMmyw8rU4Bjd6wOMFZFgFNLqWEHjb0OYFNiCabacrm3/0Zb1rDd45zG3MLTrc+MFiNwh1zLpGI6qvXzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733879; c=relaxed/simple;
	bh=hrOpoT0rQITjPUp/2qofb8QBO/j7OL9xreW+ARhc3Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ugw6LFHKrgb1L+veandoBZkYLpRRZk0iQgnTwg2+V0QgHNx02KSb8UILuIiA8mlPudSX9AzXGAyCRj4zS/NEh3ENaNZ+LEt2PyfhMGqOJJ81oxCSDeo/OjoaUi3LG9bd2Tu5V4MS7dhq2pFzxoLcSpFBkMVbMLsqVxGV7l3VLtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a0ciY1zx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b869d3560so17295285e9.1
        for <cgroups@vger.kernel.org>; Mon, 01 Sep 2025 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756733875; x=1757338675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJRnO5UD7YZuruV+flUIcQufYW0xYHWGkTcWe05GDI8=;
        b=a0ciY1zxZvtt/WTRQrkpZ2xf5oXOMfOlTiwfvACLXSAGR/ypY3zqx2OYdr+Nkwuwoo
         UYwd77JWurgCVqo7/h5Zcf8NPFVeEcYR5JSJdKp+VvDN8DpoyYcIvBWZlWsQLovDwv8a
         BF55yth5Z5k/xCgRsQepkF9ETQq0dxOPrOspOqWAzPXMPST4F6Gu35FsBDMEUv1nT6Ta
         /M6UN/k0I/ErkbtcOraMS9stzga5iFhvMDSP2vS0MC7tbqkkOoW5l4pzyJZUeLcIjxET
         OmSxAcifWkmBtTHjG0Bsa5H/4MosmdOwe4GuTGxORDoesghEbcFY9xXzOOLfrpdxB0bO
         EH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733875; x=1757338675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJRnO5UD7YZuruV+flUIcQufYW0xYHWGkTcWe05GDI8=;
        b=kejlDLAE/rIt2NepfMHSWWnWB6KdJR5wUV2WiLwAxeLJMkTjTw7B+WeSXhz7JQ3Koj
         OqrI5eJSPz/2UbcjgHxOGgj6QjfFxgvNdGpxi7vGRT3sD+MTN06c1TqwliCz78QIgwC/
         eHLD8InOCSa5TAEr7+SRU6w5fsZbWH8Mn/PATEwhQPZGQ/NC4lW7Xh3nKUnUWtPF0gAv
         dEwZBjP3eyRNRab0reFYQsPJ9ecVS/g4iCTyvi6U1d7KqHm89n5myRwO5FvLUAIwd0s0
         3og8/ubpnS8BRIOMHYZLykX+blMwnTTD4XJu2IMpNrhid8pKEqcFxUl+SV9fljYLpelc
         YmHA==
X-Forwarded-Encrypted: i=1; AJvYcCW1SlC18mn5eZljJRMg4BlkKpehcRtU1SpD7WTq3QHu7RByxkG/hq0cUcFe9FxRbkkVsU321wQI@vger.kernel.org
X-Gm-Message-State: AOJu0YxvcIk0wpwev4tD1bVYyJij+WT7tUib+OSY2dME4wYE+VD0vvXu
	A7Nvf0jQKi553HYosX3Ri6Nt4bR/pszWgy3CzAI2bOkMf3yZqzZAWQnN+z52bqEjPpYrFe5LBjO
	+01aq
X-Gm-Gg: ASbGncv0z8pFpP8wY5/w68sp332ZAmWPcVf/WgmitCn/7fFFNcxZyGzFVa2NJlhrvjo
	EoAUTegVL3P+BaQu/Pjux67PUTAmRwMcjrfZtevIkuEoPNnIgdwLfOuC1px9Ti1LKvV1bHaf4tP
	+ZdHuQWUi1/A4gRt9da72SBzfWvmwel+ZiWzZsDLiRlS3avUSZROtVko1oEvmNxgrTRWuamcP5C
	QX3QX95g9+KhkGoDrgvgOI+EDHIq9AiIb4D40drxc4zLF/g2iaBQBNM/l3ksZwiIFwnGE2oObJ4
	dOgkStubunUu+o8udcwm0XrmbkIIrsH/O98HL22M1cSHMPbOestezYEokFFojA57JQMtsob0RBd
	rENAlPRD0exXY92HQnIt8afILBFS/s90nBy7H4s31J7Xtr1ga7VKrwQ==
X-Google-Smtp-Source: AGHT+IFv2pHF60bsj9gEg82i475aoJnNBxx1riwOpUVOZgBEMlNs+m1YOElvTU1CshvLDpIwNvyw7w==
X-Received: by 2002:a05:600c:c1c8:10b0:456:1156:e5f5 with SMTP id 5b1f17b1804b1-45b85e42eebmr47046545e9.31.1756733875227;
        Mon, 01 Sep 2025 06:37:55 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33add504sm15216852f8f.30.2025.09.01.06.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:37:54 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:37:53 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-hardening@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Chen Ridong <chenridong@huaweicloud.com>
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
Message-ID: <wkkrw7rot7cunlojzyga5fgik7374xgj7aptr6afiljqesd6a7@rrmmuq3o4muy>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ovh33ndv7ladsqzs"
Content-Disposition: inline
In-Reply-To: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>


--ovh33ndv7ladsqzs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
MIME-Version: 1.0

On Sat, Aug 30, 2025 at 03:30:11PM +0200, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> Based on the comments above, it seems that the original code was expecting
> cgrp->ancestors[0] and cgrp_ancestor_storage to share the same addres in
> memory.

Fortunately, it doesn't matter what the address of cgrp_ancestor_storage
is. The important effect is that cgroup_root::cgrp is followed by
sufficient space to store a pointer (accessed via cgroup::ancestors[0]).

> However when I take a look at the pahole output, I see that these two members
> are actually misaligned by 56 bytes. See below:

So the root cgroup's ancestry may be saved inside the padding instead of
the dedicated storage. I don't think it causes immediate issues but it'd
be better not to write to these bytes. (Note that the layout depends on
kernel config.) Thanks for the report Gustavo!


> So, one solution for this is to use the TRAILING_OVERLAP() helper and
> move these members at the end of `struct cgroup_root`. With this the
> misalignment disappears (together with the 14722 warnings :) ), and now
> both cgrp->ancestors[0] and cgrp_ancestor_storage share the same address
> in memory. See below:

I didn't know TRAILING_OVERLAP() but it sounds like the tool for such
situations.
Why do you move struct cgroup at the end of struct cgroup_root?

(Actually, as I look at the macro's implementation, it should be
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -110,7 +110,7 @@ enum {
                struct {                                                        \
                        unsigned char __offset_to_##FAM[offsetof(TYPE, FAM)];   \
                        MEMBERS                                                 \
-               };                                                              \
+               } __packed;                                                     \
        }

 #endif
in order to avoid similar issues, no?)

Thanks,
Michal

--ovh33ndv7ladsqzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLWhqxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Aiw5AD/WjNnIRij7kR4aDTHZCH7
vzJ6lYELo8G6AfXsjqYtUbcA/2ayENeSaMr743JSAr9CRnOqwlPR9lH/vzAo6qt1
c+UC
=BQTW
-----END PGP SIGNATURE-----

--ovh33ndv7ladsqzs--

