Return-Path: <cgroups+bounces-8609-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7207AE1939
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 12:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740903A9B50
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE30127703C;
	Fri, 20 Jun 2025 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX3eB2cP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A23219E8D;
	Fri, 20 Jun 2025 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750416370; cv=none; b=UL/dcL8MX9/amaS4Omh1urwunjbQkTEVSoZ6TBvt3FKzbaWjhEm7COx0WYVT7HpM0ndjFztLAH1zvfxDv9MGubwIyUpRUVr8YD36MFz4QRpHxeksrF2Ow97/VtNU4ThaRIF8hEIJ2vl049Ju7tvgOpVm6M0RnlRpCnkcU2p02b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750416370; c=relaxed/simple;
	bh=Q+j9oZw/v/MeLULzqR7Js8GlISBHCoAvMB5UyRvP22c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OVItJtzfSSz8c48Oo6PSpLOPbKshjry4JxUU56WpuSdtZ/Xu9NzRRMoRxML3QDg98jftiyMV734ypJg0sDC4JkhEF9fIxEs1Pco1cFbUwb831Rvo0hqjgnG1ORUFMJicwfGmKWb5JonR/ZYm5U79Jls1jL3B3EVVXdaH5XOPXZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX3eB2cP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23694cec0feso15251195ad.2;
        Fri, 20 Jun 2025 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750416368; x=1751021168; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuzPxfWTRlSyQwCFyPkqYH7z4kShkKHo8PIEM41jRko=;
        b=XX3eB2cPIMLhnJEmEb8QFgmvymt+vNMlYrI/rvmsY4cnCkn5qiE7Phg7mREvf/zV1P
         ul2cZ/fzjv+G+wi3pA+aGnrmmirhdyrXTJvTIpPoGFKoGkpMdOPWpEx7V2jigN2w9eNZ
         1HG663+pGtp2tEgIN8fyV2TmIbUQTRnC9tmlkEsmlrAsDO+jYtkOAn1t0hm7nXsWsLzm
         l29p2VDvhKwtAD7FL8dDgZAMB4cPhsb0XQSn4PMRxx6JlLTVBlxJjJUfWVLdyfb0JY9I
         cJHui/+v3ioLIdox3fyhxkezb8HgEObro+L+8JI4gmI3T83DQIfyEDE46cNrgSbB2nKe
         BrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750416368; x=1751021168;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuzPxfWTRlSyQwCFyPkqYH7z4kShkKHo8PIEM41jRko=;
        b=dbNRtYmDixdz7DNuh4qpPUpA+yW4Y8y1T/DH8VAQiGPosEmXg/FhvcZl/nMc9lUb0O
         N8V7jONRArL4T2vLaO7yBLbKY5nghJbiH1ySHnRi5BsVxlydUvC918SppEEtRh7/lLjM
         uYXLVdQrn4dl8ambpruTwb7ZiWbbtbf7hLRcwYivfTPg1QJSc2HXMHBbdUQrcOgZ1wEb
         AHTc+2OJMoxgVuQZXFcWRBp4w1ylhUsv+sxNrpmlnJPnG1dQ3siwZ9H0jam42iIvN68D
         EiVa4NwaQeD7/IKzGVNvC5mw+ml8T/hkyHRcv5sz4+EGrhUKVLZnEKk3Bk0bpPNHCjiF
         GKfg==
X-Forwarded-Encrypted: i=1; AJvYcCVAdNmgV4uUqSBd2rt9uTqC6mE4t0Nuq5xt+WD7sPs80l8J1deSn0KZdNR3Cf6ygTt/bX0kajKxrbE5E8nb@vger.kernel.org, AJvYcCXFIrJKY6QvU+KIq1cKd60O6RNnXm1iBiKoXPBW2Xhxr0GbZ+NHtpT396ZzH7ef61cdpx8NkKt/@vger.kernel.org
X-Gm-Message-State: AOJu0YxfgbL0Ms5wimuI01GIXh6pfBWz8I8n0Nu2rz7bXetJSvzxy3uA
	OROj/7Dn8VnK1CkwDofbNpGAF7I6q2DjrSpPZoFrbsEUXgabMgGMQO/hEia4Meo6J64GuQ==
X-Gm-Gg: ASbGncsEQBg7NsChhmzJHAy6exhlNbq7ZDdtOIBtu+Z54doqOmVmfDGk/nNwY0Rzg+p
	0AQQNY9oSIQYyPge7tqa7YCHmLg7lBunC/weNToJKy29qdBs7zTGObfqD+R+qFZtXofzAZqNnHc
	DLl+2v5f2TOLCcw8+CHt88/9fkk1AP3loXXtzcS9hcWv/WNQwFALZe/Gu+U8OOe+M3iFC42FLCe
	GLpJRvp1j+H/LcupBz7WitBkXcJKqPaJUUO951KKrg9HXX8xRHxCiCgMfmtEhD1QrssfPsUBtt+
	tFlbyFflcGwwoFeZ3wuFBbPQXkl4NRGjgxKvGNj7/sdD1FUxsfxAdOCj1LzZJT4w4qcJMoBq
X-Google-Smtp-Source: AGHT+IHoD15oqSTAkNo1bhHhXLPWwnOmc9K3Fbtyp1EyYtc49G58RUu1kxJACku3Hk6L8rKeoYohOQ==
X-Received: by 2002:a17:903:1b66:b0:234:d2fb:2d0e with SMTP id d9443c01a7336-237d96dfe41mr41656695ad.10.1750416368106;
        Fri, 20 Jun 2025 03:46:08 -0700 (PDT)
Received: from smtpclient.apple ([202.8.105.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86db251sm15081465ad.213.2025.06.20.03.46.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jun 2025 03:46:07 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v1 0/3] cgroup: Add lock guard support
From: Jemmy Wong <jemmywong512@gmail.com>
In-Reply-To: <2dd7rwkxuirjqpxzdvplt26vgfydomu56j3dkmr37765zk67pd@aou7jw4d6wtq>
Date: Fri, 20 Jun 2025 18:45:54 +0800
Cc: Jemmy <jemmywong512@gmail.com>,
 Waiman Long <longman@redhat.com>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9BDD726A-2EAE-46C3-9D00-004E051B8F5B@gmail.com>
References: <20250606161841.44354-1-jemmywong512@gmail.com>
 <2dd7rwkxuirjqpxzdvplt26vgfydomu56j3dkmr37765zk67pd@aou7jw4d6wtq>
To: =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 tj@kernel.org,
 hannes@cmpxchg.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)


Hi Michal, Tejun, Johannes,

Thank you, Michal, for supporting this modernization effort to adopt =
guard constructs.

With 3,326 instances already in use across the kernel upstream,
guards offer improved safety and readability.

I look forward to working with the community to integrate them into =
cgroup=20
and welcome feedback to ensure a smooth transition.

Best,
Jemmy

> On Jun 17, 2025, at 5:08=E2=80=AFPM, Michal Koutn=C3=BD =
<mkoutny@suse.com> wrote:
>=20
> Hello.
>=20
> I understand why this might have been controversial but I'm surprised =
it
> remains so when the lock guards are already used in the kernel code.
> Documentation/process/coding-style.rst isn't partisan in either way.
>=20
> Johannes:
>> heebeejeebees - it's asymmetric and critical sections don't stand out
>> visually at all.
> - I'd say that's the point of it for functions that are made to
>  manipulate data structures under the lock. Not to spoil the code.
> - Yes, it's a different coding style that one has to get used to.
>=20
>> extra indentation
> - deeper indentation =3D=3D deeper locking, wary of that
> - although I admit, in some cases of the reworked code, it's overly =
deep
>=20
> Further reasoning is laid out in include/linux/cleanup.h. I noticed
> there exists no_free_ptr() macro and that suggests an idea for =
analogous
> no_exit_class() (or unguard()) macro (essential an unlock + signal for
> compiler to not call cleanup function after this BB).
>=20
> Tejun:
>> There are no practical benefits to converting the code base at this =
point.
>=20
> I'd expect future backports (into such code) to be more robust wrt
> pairing errors.
> At the same time this is also my biggest concern about this change, =
the
> wide-spread diff would make current backporting more difficult.  (But
> I'd counter argue that one should think forward here.)
>=20
>=20
> Further benefits I see:
> - it is fewer lines (code is to the point),
> - reliable cleanup paths,
> - it is modern and evolution step forward (given such constructs
>  eventually emerge in various languages).
>=20
>=20
> On Sat, Jun 07, 2025 at 12:18:38AM +0800, Jemmy Wong =
<jemmywong512@gmail.com> wrote:
>> v1 changes:
>> - remove guard support for BPF
>> - split patch into parts
>>=20
>> v0 link:
>> =
https://lore.kernel.org/all/20250605211053.19200-1-jemmywong512@gmail.com/=

>>=20
>> Jemmy Wong (3):
>>  cgroup: add lock guard support for cgroup_muetx
>>  cgroup: add lock guard support for css_set_lock and rcu
>>  cgroup: add lock guard support for others
>=20
> As for the series in general
> - I'm still in favor of pursuing it (with remarks to individual
>  patches),
> - it's a good opportunity to also to append sparse =
__acquires/__releases
>  cleanup to it (see also [1]).
>=20
> Regards,
> Michal
>=20
> [1] https://lore.kernel.org/r/Z_6z2-qqLI7dbl8h@slm.duckdns.org
>=20


