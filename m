Return-Path: <cgroups+bounces-8583-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDEEADE63C
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 11:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CC73ABF0A
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 09:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691AD27F012;
	Wed, 18 Jun 2025 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L6WGCDFt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8D2405FD
	for <cgroups@vger.kernel.org>; Wed, 18 Jun 2025 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750237495; cv=none; b=oxmbTj9X1A9Om5b++TTr3HayLbEKFZQt41VF3MVC9lEDQhe6RZuD1j+d/MjBPXM39lUC01tohg8sonri5tpahkIC6fd8/ciL7+A8atAERxpPXzgZCWSIT+am2I5QgFq7ICxVbRJThfWadb/0i59+xhi/lIUF4AFVHQ7N4sWoHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750237495; c=relaxed/simple;
	bh=YrKaAy38iz5URyCQDyb4pP3EYX9uBc7/3gotimG+KYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHAXmCH4sDZxmA0MaI6iCQgccJQLfCT1UIV/kxIqwm0dUEHWCT7I27LyZnNiz2qc416UnNhdHWaLOEEuUioThrr38xqomasNDvG0RLv4eaKEXtAIHb1Q9FuDNB0KdG/l+N1VvaI43xJw7rQ4PaJKnxmTC/WFrsWFWDKZ6yRYPHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L6WGCDFt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a510432236so4938513f8f.0
        for <cgroups@vger.kernel.org>; Wed, 18 Jun 2025 02:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750237491; x=1750842291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gv14o3rhYSCR7Lylt3qG4iprEFfUfkaf9kxFp2mPYeA=;
        b=L6WGCDFtHNoFESliydPA0h8NSyj5aUNN2b0tY3s3gV1olJkYKTpB0H05rJOs7VF71Z
         k7w+n6JS0t7Zvtcb2A9e3Bx+mEHvJqictqLVNqP0fW7s835cEuli8mWPbDxfALF0RRXO
         gHZJ/7Xy/5QWjWf7+IuLE/9cJCwul6kr74hsbFB+3vggaTHysgGlpArm8dJzBNTn6pUr
         5PNBOQUSNxtSEIIUHfCFdc76WsxiW8i5MObSUJgsOwgIm/408auAWAFgy58Xc3QXbdsw
         7YSa8qoqrNS+ik6y9xzMqdSqZTUCeI72L5TS1bET5LcrhwukR7VYoiA5/Eiz2eeoznpP
         itnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750237491; x=1750842291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gv14o3rhYSCR7Lylt3qG4iprEFfUfkaf9kxFp2mPYeA=;
        b=O8J3pbbDi5XPiuDDbOwXoq0iENBQ1MeFQFY1Q+FHW2VYq2EDoPCeXp5lnmprQAygOH
         9KcwGMMEnP8EILqtYfq4JicIcSMhI6XqJnkfGHeEHENGmn3Iaih51mEXpKxH0CWHKQ48
         k10le+3nmqZzQ5am1t+Ytt3QeIZykos1hkymc8HuKvFl2rr63kP1ALFHkq8h1sRdCQjE
         I9VXkahUK3HQVoqWt9QqbHmsJA4UP6CvMgYTNH2hfDklUTXW3amnojTGn7Hr9S9AQnSe
         AXbHO4B0sg2qfMKPRJaiIaOFn39P6F5wEAOQEeGaP61UFn0LuDnkiPeuudn21xRQTWbR
         a2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVXfSS026iQO7uJJUbr6KnDlFKrnBLfpQGk/gRLgqZcHU9WIeCbR7Y5kMxH+AS2fn4UDhF2dEuB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+eaaUTcUv12Z/Hs8IXte1KCQ4ppBIwc3ne+dVmCq4CARcmAD
	Vbk64n1ntDgMnmDrpzDqUVrB4pYDlfkIzluxq2rBnt//FOtqB7u25BFe+DvAldHEexg=
X-Gm-Gg: ASbGnctslc/AUnpthhNeoUxcaVLl46kLOrdW6+XHkK2HE5wKKVS85dWUuLAKJbNTYRy
	qgyyalfPzHVgvBwaBeMoU+W2jOgz3iMHMAE6myOZ+asXuzFBZIPYDn2opjqgz9hQsgC0bmXWxUj
	6aAmq6gSK/b9o/gS0Uv856zZcic+fBW+0EmfWoDkTMESiaMxZgRGggtLQ5YuhJglf1vrcbMbToL
	jve5r/zgItYqQ40YXBvzle011nzWAFzqZ/xMNE+5747jYMCqZjQ15neZbYkvjejlvMbFvf4oNHp
	PN9QURwwNkqMQri50ux1M7uUJRXHOyWMT2NABmB4U8W3YGSbu79H8RMKvv8tw5pB
X-Google-Smtp-Source: AGHT+IFeOWw0lXG4a6XXTyZ+Ni+NsjFyKjDpbATi7KwCxJv6p4hP1tFsL1bqbEFVfcFZVlIKEjCkGA==
X-Received: by 2002:a05:6000:2f88:b0:3a4:f8e9:cef2 with SMTP id ffacd0b85a97d-3a572e6be35mr13559664f8f.36.1750237491310;
        Wed, 18 Jun 2025 02:04:51 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b3c0d3sm16358933f8f.79.2025.06.18.02.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:04:50 -0700 (PDT)
Date: Wed, 18 Jun 2025 11:04:49 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking
 cpuset.mems setting option
Message-ID: <pkzbpeu7w6jc6tzijldiqutv4maft2nyfjsbmobpjfr5kkn27j@e6bflvg7mewi>
References: <8029d719-9dc2-4c7d-af71-4f6ae99fe256@redhat.com>
 <CACSyD1Mmt54dVRiBibcGsum_rRV=_SwP=dxioAxq=EDmPRnY2Q@mail.gmail.com>
 <aC4J9HDo2LKXYG6l@slm.duckdns.org>
 <CACSyD1MvwPT7i5_PnEp32seeb7X_svdCeFtN6neJ0=QPY1hDsw@mail.gmail.com>
 <aC90-jGtD_tJiP5K@slm.duckdns.org>
 <CACSyD1P+wuSP2jhMsLHBAXDxGoBkWzK54S5BRzh63yby4g0OHw@mail.gmail.com>
 <aDCnnd46qjAvoxZq@slm.duckdns.org>
 <CACSyD1OWe-PkUjmcTtbYCbLi3TrxNQd==-zjo4S9X5Ry3Gwbzg@mail.gmail.com>
 <x7wdhodqgp2qcwnwutuuedhe6iuzj2dqzhazallamsyzdxsf7k@n2tcicd4ai3u>
 <CACSyD1My_UJxhDHNjvRmTyNKHcxjhQr0_SH=wXrOFd+dYa0h4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5fd5vh6qqcct247c"
Content-Disposition: inline
In-Reply-To: <CACSyD1My_UJxhDHNjvRmTyNKHcxjhQr0_SH=wXrOFd+dYa0h4A@mail.gmail.com>


--5fd5vh6qqcct247c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking
 cpuset.mems setting option
MIME-Version: 1.0

On Wed, Jun 18, 2025 at 10:46:02AM +0800, Zhongkun He <hezhongkun.hzk@bytedance.com> wrote:
> It is unnecessary to adjust memory affinity periodically from userspace,
> as it is a costly operation.

It'd be always costly when there's lots of data to migrate.

> Instead, we need to shrink cpuset.mems to explicitly specify the NUMA
> node from which newly allocated pages should come, and migrate the
> pages once in userspace slowly  or adjusted by numa balance.

IIUC, the issue is that there's no set_mempolicy(2) for 3rd party
threads (it only operates on current) OR that the migration path should
be optimized to avoid those latencies -- do you know what is the
contention point?

Thanks,
Michal

--5fd5vh6qqcct247c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaFKBLwAKCRB+PQLnlNv4
CASjAP0VYu6p8wvLUhiihCm8ro3s7bzR1Nz4+lPHLRjwqONiTAD/XWemhhLumVN5
UQxjOamLKhzgHdochJGTz24+r+JMGgY=
=Y3Vh
-----END PGP SIGNATURE-----

--5fd5vh6qqcct247c--

