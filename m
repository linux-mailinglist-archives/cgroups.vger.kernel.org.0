Return-Path: <cgroups+bounces-8408-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E94ACB26E
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 16:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E69163D90
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C3B228CA9;
	Mon,  2 Jun 2025 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K4N6Fdfh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7092288F4
	for <cgroups@vger.kernel.org>; Mon,  2 Jun 2025 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873763; cv=none; b=NzF2wIV+UCx5rIr1yQasA3lC1isEBdpvo3qrRQ7E2w1Qsfde3hXRC1lTkp6KE1vMCyUZoE/DU0ncLKbi0ODzbuWGyXqFx1cIvlA4AeW0qn2tGJnYiB9ua0AvC6FQqPF3hNZ3TcVTi+WpZEAKGETAMhw5dtBy2wdS5jvYHZVe3SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873763; c=relaxed/simple;
	bh=dF5GAuwDgKDUST16OT0UxWR0Azq7MMy0XSykEj/fkT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jR5MVuvO58F6ikLOu8MkfICwiQ0AMLHQxKU1LgzOJBiKBLKhLxgQP/HcCSL05k/4nYV4G59pNFIJwJCft0Y2Ho0RJDtXNyLfxX7seBwVEoPbHsmbfWQsB19ZvXd0FheRFYz5rE/wNmFYk1LkowB1OqaHeZgg1tsmRGSmo1t+gjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K4N6Fdfh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a367ec7840so3039775f8f.2
        for <cgroups@vger.kernel.org>; Mon, 02 Jun 2025 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748873759; x=1749478559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pasRCSC32VgEjcQb416rK5+EN/XRXvQF7vBXVNk/1Wg=;
        b=K4N6Fdfh44MAAVtfDadHVtymwVSqSRQTUlsul/VCRKcKGCLB0vvsfs7GKxRzlBR4j1
         WFJc6/4I2CunWs+BKVvgNRTOW+goTFDQxJPaPdDtiksIOCnZrYuAsKdLT1Bx1laQ2aKC
         rpyFXyKWpynKJm4fQB/7GLIncOoxe6+5+3aHG51Ql1m/MHg5mQqXlCGBPUzGytiL7woV
         XpkKKAWFQTZ8zT7SPqGg/qzIB1WEb+tPQhvFz4wr/wAOsysFnTJ3asbh+bDJlJvS3IXX
         mYrqdH1y1CQS8254J0BmIq9DvF7xONiwI4h4MgVmutVCz01Vt1wKukGRAIpFhhpcdfxt
         co/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748873759; x=1749478559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pasRCSC32VgEjcQb416rK5+EN/XRXvQF7vBXVNk/1Wg=;
        b=Avfe9QG6b3h9djTQcymzJcnUwDL9j8oTafHkcE/mNkT8KkbY32IdHoX+jVDjDdex/q
         F105P81edfP7qfJiG7F9T7IXPgIW98t/uoLmAEfZHRsbVmgo1i7MyXAzcb5ImvrZqZ8v
         lga4Hs4e7q9JKKMB0Vk1s0vK+tdCozvqvY5mPjgDEz0LzndgRBEdShcCxApm+kSCc7N9
         4H0TfwszbiVycDP58IIdh+mwLcZ12kWQzUlkYvb6mrN+S6ikHW4oF5Az6T0T71pngC7K
         nx1cFwpEhfRO7i1UpoKFg2W4D5qNWskJocywujPeGcIYzuu4Jw/5Oy2VMHy1dRZ0EpHj
         ++Vg==
X-Forwarded-Encrypted: i=1; AJvYcCV2l4ZwwDvULt8SCgA9ZhYC75D7z/qz2nkbbjTObwT8GWPCLmj52onyZDc1XBugGdugpJ8+YE7+@vger.kernel.org
X-Gm-Message-State: AOJu0YztOtBE8OnjpFNB/DXipOBtgIzpnloai2lQQxovsG69gbz20POj
	SI+fEwC3Kly5bLP6flC4bF7unLYD8SoMrkujdyXGlwEidvNxMYy5r7N34A7nIyUU2LU=
X-Gm-Gg: ASbGnctzIluu/4lAO2MxPQe1STuFBUKCmFLhwZc72iBPvoefiikPxIk7S5hTxmQ9Xax
	jBtcAKFVXox1apF/Lkj1b5qHPgAdFm0ggfDuIqWYsCyPHlrnm+cRO+kcUmksBfmLJqtHaXl7ALL
	D7W1tANIa+3a5oFVY9Wdj6u3vnfozA5K1ckH1dCKY5mxuETaHg9focjcvzwePmy3j+Au44Czq6p
	Y4NwDK5s+BzXgeZTsscbc1niI5nTJ5kvkCclCZ42ssCsrOXq6O7CoP4ItLXlim5UJj3i8QNAYuH
	wvhvh7VG+Zrmduwonc8/IlQ6uCdGE6S1P6KMZ82OcdVDoNx7qH1IdA==
X-Google-Smtp-Source: AGHT+IGeRpd8VDsT9tzxbCNKifu8MjL161GTIQbbUw44DS6V6JSyR7z1tMRcG6paU3cdSynR/larLQ==
X-Received: by 2002:a05:6000:2c0d:b0:3a4:e5ea:1ac0 with SMTP id ffacd0b85a97d-3a4f89a7f0bmr10299120f8f.5.1748873759286;
        Mon, 02 Jun 2025 07:15:59 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8f194sm125483535e9.4.2025.06.02.07.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 07:15:58 -0700 (PDT)
Date: Mon, 2 Jun 2025 16:15:56 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: syzbot <syzbot+31eb4d4e7d9bc1fc1312@syzkaller.appspotmail.com>, 
	inwardvessel@gmail.com
Cc: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	axboe@kernel.dk, bpf@vger.kernel.org, cgroups@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, hannes@cmpxchg.org, haoluo@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org, josef@toxicpanda.com, 
	kpsingh@kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, martin.lau@linux.dev, mhocko@kernel.org, 
	muchun.song@linux.dev, mykolal@fb.com, netdev@vger.kernel.org, roman.gushchin@linux.dev, 
	sdf@fomichev.me, shakeel.butt@linux.dev, shuah@kernel.org, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, yonghong.song@linux.dev
Subject: Re: [syzbot] [cgroups?] general protection fault in
 __cgroup_rstat_lock
Message-ID: <p32ytuin2hmxacacroykhtfxf6l5l7sji33dt4xknnojqm4xh2@hrldb5d6fgfj>
References: <6751e769.050a0220.b4160.01df.GAE@google.com>
 <683c7dee.a00a0220.d8eae.0032.GAE@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kzcsf5ktx4jfm6ch"
Content-Disposition: inline
In-Reply-To: <683c7dee.a00a0220.d8eae.0032.GAE@google.com>


--kzcsf5ktx4jfm6ch
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [syzbot] [cgroups?] general protection fault in
 __cgroup_rstat_lock
MIME-Version: 1.0

On Sun, Jun 01, 2025 at 09:21:02AM -0700, syzbot <syzbot+31eb4d4e7d9bc1fc13=
12@syzkaller.appspotmail.com> wrote:
> syzbot suspects this issue was fixed by commit:
>=20
> commit a97915559f5c5ff1972d678b94fd460c72a3b5f2
> Author: JP Kobryn <inwardvessel@gmail.com>
> Date:   Fri Apr 4 01:10:48 2025 +0000
>=20
>     cgroup: change rstat function signatures from cgroup-based to css-bas=
ed

It says: "This non-functional change serves..."

However, it moves the *_rstat_init in cgroup_create() after kernfs dir
creation and given the reproducer has a fault injected:
	mkdir(&(0x7f0000000000)=3D'./cgroup/file0\x00', 0xd0939199c36b4d28) (fail_=
nth: 8)

I'd say this might be relevant (although I don't see the possibly
incorrect error handlnig path) but it doesn't mean this commit fixes it,
it'd rather require the reproducer to adjust the N on this path.

0.02=E2=82=AC,
Michal

--kzcsf5ktx4jfm6ch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaD2yGgAKCRAt3Wney77B
SVQoAQDHq+sRBr9VIovCUMvE0lKEciOvnR/BAoR4DPgcg+NOwAD9Fm1hrpnED7c+
obYDZ0tb/tA0+9khXt2TrVelWDcc/Ao=
=n7f7
-----END PGP SIGNATURE-----

--kzcsf5ktx4jfm6ch--

