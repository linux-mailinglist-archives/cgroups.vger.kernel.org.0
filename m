Return-Path: <cgroups+bounces-8453-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E04AAD0384
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 15:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00C2F7A265F
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 13:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98B2289830;
	Fri,  6 Jun 2025 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4by5+4S"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D1328981B;
	Fri,  6 Jun 2025 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749217912; cv=none; b=P1sfK6KgCE6Wj3w1FsgzhJqznbGc6qspEh3+VSaNX9/AprrL1ESv6onSlBXP+ffmH2Yh0HCokV9QxlbbdppA7M7vxPvH5yge14Y7/VGPEHgrfMXQuo+wpJfJaHU3I2bcr0MkJoMW0gsmzr6M4Hbfh2EQeO31DCtrms+8GRCEISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749217912; c=relaxed/simple;
	bh=IIrcHjOJF0WUmf3dP0J4tD5Xi1dZ+WzmtH3IV/CQrbY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=E07AL849BQejg9mejPPsxMT6OsgXaEiZvcGybRhuxo6H5xCVChWReNt/F9VrkfYrQ8OBSCYrgqgDsXYY4ZdsTsBPo//U1gxG8Td3ACopK5cUSl7RfJkmJNkhYcXjLyroI0uBtC9n/iE2ftJ5YMrLsZHFIzTfO87XynpU9S/j9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4by5+4S; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7482377b086so847443b3a.1;
        Fri, 06 Jun 2025 06:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749217910; x=1749822710; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIrcHjOJF0WUmf3dP0J4tD5Xi1dZ+WzmtH3IV/CQrbY=;
        b=Y4by5+4SqzjvREvK80VwpUn9C04PLcGI7p1SlVfvNn0DziG9WGqGhCSIbKFCSw4aNw
         aQ1FzropuAZFXREBRQ57XfqeI2HL0Jco14cFs8mTLQ67klHXQ/M9C0mhjpfVyu5y16PA
         ROrjMZa2MHNsvJ01uczrmyDZR0hnVnJWgqr2sEw7M0xhQFZfmPMKRsrmmx+r/4LF5sgf
         ykO8Iqn8X/Gt9mTwYJPKjlmA0A6RihqC9YIT3Rct3wMYb4axv7jLe1z6y0vNP2McQSaz
         hLp2qyIqPChJiaVy1EY+f5fuAeRYg7+JUshJoB+kz2GBYyLqR3z6XAW6Rq2V1cX6+9RZ
         18yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749217910; x=1749822710;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIrcHjOJF0WUmf3dP0J4tD5Xi1dZ+WzmtH3IV/CQrbY=;
        b=Uw457F15KbEUEf81Afufv0KfaphMCYAbplpHD2lsIWd3nbH+FL5oNa/+DFjy1wjNLC
         6RJltSUvy1X3wbHoo6cPXQO+Zak2NzwVsQ1tqUWHOQDep3HJXNVv1NPl2rumQVtD6Sow
         C1S/aMZoAUDPnwRYbGtnWOQBaVOs2p1W4i1sH6nJIMjuQTL73Z4QIL1ZEFcFyk3mnF4X
         fYrYvTzPzE24M6ZfN32w3gWAPT51q8ME4+AdxmX28mPwXVnHahV+nbYiAKZQWWpQ97WY
         R3QZPIX2S/P13zFG9r14s3syHU5hjHOzvA9Sc0yqERsxqnE3D+CI9GADVrzaSPp8mDyS
         sCCA==
X-Forwarded-Encrypted: i=1; AJvYcCUEKIaoX/wOFiqkNBLboHAdZNbtE8Iu+tMA5vNCqrmU+bXdfAV0M4yANTl7zPyNlapFc7M6yyQsOaRc68QB@vger.kernel.org, AJvYcCVtdLx+AzUPpxfYiWd4DZZ3ZrUPHwlWYzIE4ccCaFnNJg0XktfxtJIVFrLBlVY7Xm9n7kwDwJcs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5WXHDsXqepIFT6smOueg49hn94oU6ni97Uha6E0/w/8W3JmTQ
	yWqbzuS/EblXtVT+EUp9MGthT1cSKnHMUfkZ5QYTfc/ySmOU3V0ZKLtK
X-Gm-Gg: ASbGnctIqylbLYIsIdb1lKC1Jdv72+TITtCiPR3KZMN/KZrk1bc43Vj+ZYAjcBm+Qxm
	VesF9T7KxuF3zLBKM980EPNFVgALkUJV7gDCtFhqHAkUxO2dIvqNVtn3wEtq7AKfkh6/YntKuHi
	U/n/oGg3sv1g6wZSPaLXvOkw8K8AdDvrCWn0S4OMQ0pFPx8yhPq5bQL2tq8mSLLFR0l14iGpwg4
	I0Ly75p2uIvuzl0shx1lNaZHtTjXX51DqNMHQozNS+a+vj5I+39jZnWsq+4/44vmNOOIaZt/o9T
	FO10MqQ9ShzwmpOe1DtuLDGDEtSS29gnQwJwp/ZB7UxNVYZgXMDdth13TpyUHUyraLERAuhx
X-Google-Smtp-Source: AGHT+IGhKffUcoovZoLmF4robbIk7xZYJEyrjgrjfdxA9yu1fAwpBy+RuF1KnZIN80fq3t/tsXzygw==
X-Received: by 2002:a05:6a21:e8c:b0:218:5954:128c with SMTP id adf61e73a8af0-21ee2532c61mr4608410637.21.1749217910233;
        Fri, 06 Jun 2025 06:51:50 -0700 (PDT)
Received: from smtpclient.apple ([202.8.105.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b084f60sm1315192b3a.101.2025.06.06.06.51.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jun 2025 06:51:49 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v0] cgroup: Add lock guard support
From: Jemmy Wong <jemmywong512@gmail.com>
In-Reply-To: <fo5le4uonsrv24z5gikojq7hxwaqaidgco25pypnppk5h2czap@egdwx6yte4lf>
Date: Fri, 6 Jun 2025 21:51:34 +0800
Cc: Jemmy <jemmywong512@gmail.com>,
 Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <64D97068-D44C-4B29-9847-82F87A006D14@gmail.com>
References: <20250605211053.19200-1-jemmywong512@gmail.com>
 <fo5le4uonsrv24z5gikojq7hxwaqaidgco25pypnppk5h2czap@egdwx6yte4lf>
To: =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi Michal,

> On Jun 6, 2025, at 5:34=E2=80=AFPM, Michal Koutn=C3=BD =
<mkoutny@suse.com> wrote:
>=20
> Hello.
>=20
> On Fri, Jun 06, 2025 at 05:10:53AM +0800, Jemmy Wong =
<jemmywong512@gmail.com> wrote:
>> This change replaces manual lock acquisition and release with lock =
guards
>> to improve code robustness and reduce the risk of lock mismanagement.
>> No functional changes to the cgroup logic are introduced.
>=20
> I like this.
> Could you possible split it to individual commits to ease the review
> for: cgroup_mutex, css_set_lock, RCU and the rest?
>=20

Thanks for your support. I=E2=80=99ll split the patch into several =
parts.

> ...
>> --- a/include/linux/cgroup.h
>> +++ b/include/linux/cgroup.h
>> @@ -382,6 +382,10 @@ static inline void cgroup_put(struct cgroup =
*cgrp)
>>=20
>> extern struct mutex cgroup_mutex;
>>=20
>> +DEFINE_LOCK_GUARD_0(cgroup_mutex,
>> + mutex_lock(&cgroup_mutex),
>> + mutex_unlock(&cgroup_mutex))
>> +
>> static inline void cgroup_lock(void)
>> {
>> mutex_lock(&cgroup_mutex);
>> @@ -656,6 +660,9 @@ struct cgroup *cgroup_get_from_id(u64 id);
>> struct cgroup_subsys_state;
>> struct cgroup;
>>=20
>> +extern struct mutex cgroup_mutex;
>=20
> I assume this was because of the BPF code, which wouldn't be needed in
> the end.
>=20

Yeah, other modules also need cgroup_mutex, cgroup_lock/unlock must be =
retained.

> ...
>=20
> Thanks,
> Michal

Best,=20
Jemmy


