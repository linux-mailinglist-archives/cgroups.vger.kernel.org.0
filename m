Return-Path: <cgroups+bounces-8752-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455C9B08E3C
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 15:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CB25A0BA2
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239402E542F;
	Thu, 17 Jul 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SYcyU7B7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7071A2541
	for <cgroups@vger.kernel.org>; Thu, 17 Jul 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758914; cv=none; b=U7BUR8OycOh8Sd+iDp59J8UpDQ9y3xgdIAQ9tmAx16Gu9Gx/vdM3vuS92aiCWQ9Co/NFxYiD1fptbZkAYSgsUaEkwsvtZrGtk44fID/uDkSKB9EjTBQ77SiLN/jSh0imAysIaLZquiWZybXN3x/MONda3bRhIpvKsBVljZv261c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758914; c=relaxed/simple;
	bh=uhLICpyonaXsszXJDK/zPlGgsrZp0V9gZHcTjqC4y5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOsLn0O/0yxLZHRIN+5LAKpodcp277VctQDnJczKxOSFdPUxrIGIIHFgg84jUHjPqwmwD3A/zajSiVscm5EXCKZEt2nKaRyLWl61zA8EougYNHFR6DM7+IccGRp2v0nnqXfR5lhM2r0s/4ZtMl4S3cQlmtPgX0uxuQc4/PDXaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SYcyU7B7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso184785766b.2
        for <cgroups@vger.kernel.org>; Thu, 17 Jul 2025 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752758910; x=1753363710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhLICpyonaXsszXJDK/zPlGgsrZp0V9gZHcTjqC4y5g=;
        b=SYcyU7B7R96EUeLIq46nPnI1v7HDYsFFND9TTaj1oQGQoSfquln/NnSEZaBbSVm5p0
         Dql2DITPQw4RR/62PbfgcY8EQoOMDkteyzsY+fqIUe106azRlkeljlVpmmgWtGjpQcDp
         vSQFwDojKXXk20K9ziV7yxTeGbZpwLcgiDOCA8oPnsGiqfiWjrAPRSAtqN8YfJWsaU2e
         dmUOyNABiZuPH1wKM3fnY79Bu3prDsXJMqlcPi2cvBPSR2391iyC6sEZT34oPdeCt0tH
         +PX4fi4sFMnT3MH5DPC7p6cBvCTZV1wdAZmx/AyeA4XPnVekFwbjhbmpoy4fsRbQOSJt
         O5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752758910; x=1753363710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhLICpyonaXsszXJDK/zPlGgsrZp0V9gZHcTjqC4y5g=;
        b=HtzDtH2ePN8oZZ1MmxPBsiDnGkydwqyj7Boy+CKvflnt617KOM37b8RhKmfrxqpSuc
         Yg+T0vHf1Hio0NbaMAy285LjQjSrKo/a2Js6j+xFQNEH8hFH27UkIXddAYecPkAXtWdF
         b1gHJIyhJgptWwUI+M/wgEWoU9igI3mFJDiXVTF/PI8BuXKTnEmwvF/nWWgHlyPMjmUR
         lox4T5bk3Ik4Nf0PU429MYs58BFw7GuZeQWkplfVDchIZmh41pLHCyYDDyOLcumacuKk
         n96eo2GX+wzSTgfnsXussNPNYVd2s7QYQ/h4VK1gCQBLntW4DyKkbAYfYLCe+o+rg9J9
         csDg==
X-Forwarded-Encrypted: i=1; AJvYcCWPfOTfUf2ocwxsSAQCC0Y0oBdEjCCWahWDlVoH3E2pquX6TXHAnSO2io8KB6vInBCQu0004Zq2@vger.kernel.org
X-Gm-Message-State: AOJu0YyaHk4bLyPPoqea6UI6ZHfA0ErJbcXGLQCdMtC/CAJ0iW2n1QOm
	DHdkbq1gtRWsAwqr891K3/begI3i8X4krr16FpPWT1HTPqYmqndDJbxZdWeUI5QDGuU=
X-Gm-Gg: ASbGncuEAisQ2kgEViiHp4HNs3zBwdCIUWoIF3dYBL2/pBWYz5TERt854yAXZRtIuBz
	t88ELIUOD6iyfDjjjWEmzdoTpqKYzOnp/BTwPyzxgh6JpdgkMhBdUtG5OJTa24AqgvxhZv1JNCj
	xrBuBCEqDq8AjGuFoqVhFC2843yOi5dStZXrQ+LPylCxOThgy79/X+wmtge/0XAVCD2eC4Oxp0I
	JK/ut7c7PHJ7V0H/vBM0TuLfPInhAByfPwcX53sh1jJqoUjtSAz9jAr5n08L13BFt5z7nXvuz1j
	EIH75zMxci4gV9bVjspJp3ycdSo4Nqu6KxXxoVDCiurRpKQ9zml2g/3tWB7jxJSFT4qwkPEI/6B
	eykQKAvzLGuONEiCtAVzdIREXiHFcjuml3oQk57nI1V0r3IPvYebC
X-Google-Smtp-Source: AGHT+IGbH2JFwBLPGaLraTVu5QEVZak5Rl1cRsioev8MLGku57cqKjJrgA7FyxKjd1yCd7BcoUWJxg==
X-Received: by 2002:a17:907:894b:b0:ae3:90cc:37b3 with SMTP id a640c23a62f3a-ae9cddddbd9mr695822266b.17.1752758909512;
        Thu, 17 Jul 2025 06:28:29 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611d06bafb0sm9850766a12.21.2025.07.17.06.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:28:28 -0700 (PDT)
Date: Thu, 17 Jul 2025 15:28:27 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
Message-ID: <ammabsnegvc5m5qdj3xmydq3vhzw5igiy4fofpzyyzcwz5y7ib@rgbbbvxfxrf3>
References: <6874b1d8.a70a0220.3b380f.0051.GAE@google.com>
 <2b10ba94-7113-4b27-80bb-fd4ef7508fda@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zd2szp6eksrzw5d6"
Content-Disposition: inline
In-Reply-To: <2b10ba94-7113-4b27-80bb-fd4ef7508fda@gmail.com>


--zd2szp6eksrzw5d6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
MIME-Version: 1.0

Thanks for looking into this JP.
You seem to tracked down the cause with uncleaned rstat, beware that the
approach in the patch would leave reference imbalance after
init_and_link_css() though.

Michal

--zd2szp6eksrzw5d6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaHj6eQAKCRB+PQLnlNv4
CKckAP4t2sTel5NAIcoMDkPLhVj1Xa02VVfnsF7RBxyxnK9dsQEAnyOuSjGR3Zgq
rB+TQqoGgTO4G5NzZzpXEZxBkKWGdA8=
=HKJL
-----END PGP SIGNATURE-----

--zd2szp6eksrzw5d6--

