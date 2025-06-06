Return-Path: <cgroups+bounces-8449-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 944FCACFC51
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 07:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC983AFB85
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 05:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB242356C3;
	Fri,  6 Jun 2025 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnrP1Gfq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9ECF9EC;
	Fri,  6 Jun 2025 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749189553; cv=none; b=FrZAUtaUj7orZkOZvtmOhEOwaI4/KJqdIh/vHbk06eZlVBeckeeGIhVZp+KcIC1CVuCe/z+S/OyQJkpU8anxCWKGVhRIp2aK1esjObvth/c47A8nYrTLVj1MxmEquusPwRE62boDF6qFV2ESDua0rb+slRcO5/5yBJNcMC5DbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749189553; c=relaxed/simple;
	bh=YmJcU9va6zlIKBqEb/6FSueJJ7ATQVbP2IX5DudqPPk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=g0gsEX6xE9GLdKcl8ZJf6KovXEThWNNfOrdrf8HSZg7hpGT6uNCMy0ycJWFJDBsObKwRN2J98VxKJGH3FihXQF9ape0E4zz3qFnd7rxks7XZpBbtaiFoIEugJYcRBg2h9fivpHwhg7DHXZPeXRsEDWDv0onndgEgJwOkNSZFIb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnrP1Gfq; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d21cecc11fso281471385a.3;
        Thu, 05 Jun 2025 22:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749189551; x=1749794351; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqcpyQR1uW9jks47tVuDGazbOtrYAt2+YqMREe9YBoI=;
        b=NnrP1GfqMhp7Oe3Omp0ul5hhDtnt5FFuWg58BQ4ZHtcHNDgRspQvI4DHMUI6oPrxec
         ufh0/BlpfFVNR8T/zuIk69pavAmOTQbuFl5+mM9oGtfEdkjJksFD9cUi/E7fn4xcZpwK
         aK3w83teGQhmBJnYu/j+npFe3+SSAUSb7Y5eBIrrjoVe5HXKhM3sXT6WmqmXrjepUgnD
         4wKJRjluhIx09OR/TSbWpwY9vLYtoYoaxxivY9K4sxYuPz9bdnvR0jaR4hnEvavYBL7p
         Qealz2HU67zhgxLHlsTK2V+ADpecVBJ3LAYDEhXlHkS5bNQYc8liOEDYDXbJ3Eca1pGc
         xELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749189551; x=1749794351;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqcpyQR1uW9jks47tVuDGazbOtrYAt2+YqMREe9YBoI=;
        b=GqFSpOLZo1CKwmSQSxbOoOSZZa1NSZn9wwUToSSCP+YGVmEIK7JogDsOLJV2xNENsI
         mRX4VARwci/7rapCM2TmwtpRMexf3sxD/z5NgO/nd8tBQdfvGCgkmrLH48jGMtsZiQCa
         2AaVjfgLg/asxMftx+hoiM/D0VoiwbiJWv2zw+M4sUqzNiugeMs7av+rlAdz3hZI++EY
         t8WHaoAsbPw7BYVEGmRs3JS9G5alKk2RyGXTYJ5zFOGyzBmgw4H3WKQBaFnbU3p0aKOF
         l1vUWQyerd3UJEhBiHQd0H38Vlew+HrIc9a680Vg1RnW+3ZeKI+8gPWvX2NdF3dnv90X
         9apA==
X-Forwarded-Encrypted: i=1; AJvYcCU0cS4YSlHrmgs/28Z6zldUYRev4M6Az/+BcbC6NBaWRePVyUhQ3BST3i8Mh0Ru3zqT/KXDBU5n@vger.kernel.org, AJvYcCWNCaAnPUvKjoJ8Jq98lwLIeWuGMJxbiwkqGe9IXyztE5hqcF4wov9eOc/JCUnFjfv97tc+GQ0WUEht7vnC@vger.kernel.org
X-Gm-Message-State: AOJu0YxgFX8xnSBr/6FOGY6dSIScQ+TjdNUaOoTeNwW02rMlN5yT9j1N
	U+VtI2IC09dEuMVs78wCGf7IU9/jP0GY/yCaSpqymPgEKKVeIoo0bRxK
X-Gm-Gg: ASbGncu68uXU7R+Eo/QZ7d75jGWS977mQV8PBhgY/EqRFAY/W6+fZPu+Hka+1i6mXdu
	j60EaveLbEJvDbCkUslEz42cMh4bwe2Y8C62TbFq6hrUxTtxhS58U7oA5L8UODmaLXFLCENbla6
	dkUPzKakQQ/Eu7DrpSrtLacszttMDBAUgoOkNvbXnm60EzDciJLvy7T/ocPObFLpGmYGxZoXdPz
	Tus1FvE8Obbb0tnGKqzWc+4/jtAf6HatCOGMKjicwWe5L6aTagUPcCiB2aGUCBY8t52tK6YdApj
	P7FcppiC65bJzSrscSwu0GKD+kSzI13VZ9hQn8PU/kYZdStRJmkJ+iOP0yFNlQ==
X-Google-Smtp-Source: AGHT+IESyHlAlFO7+uuIypvrTAQS8nZexY0QRLY3mCrq4aPdb4VOAGaiKiKs0qnPlCpcb/iD4VN37g==
X-Received: by 2002:a05:620a:6412:b0:7ca:eb5b:6de9 with SMTP id af79cd13be357-7d2298db5d6mr318174785a.42.1749189551044;
        Thu, 05 Jun 2025 22:59:11 -0700 (PDT)
Received: from smtpclient.apple ([202.8.105.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d0dsm85326185a.67.2025.06.05.22.59.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jun 2025 22:59:10 -0700 (PDT)
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
In-Reply-To: <CAADnVQJyATTb9GFyBhOy5V_keAO5NZ6+zucLRyN27Cmg2FGPVA@mail.gmail.com>
Date: Fri, 6 Jun 2025 13:58:50 +0800
Cc: Jemmy <jemmywong512@gmail.com>,
 Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
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
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E6D65212-6332-4180-8A78-81700357AAE5@gmail.com>
References: <20250605211053.19200-1-jemmywong512@gmail.com>
 <CAADnVQJyATTb9GFyBhOy5V_keAO5NZ6+zucLRyN27Cmg2FGPVA@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi Alexei,

Thank you for your review. I=E2=80=99ll revert the changes to BPF.

Best Regards,
Jemmy

> On Jun 6, 2025, at 8:54=E2=80=AFAM, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
>=20
> On Thu, Jun 5, 2025 at 2:11=E2=80=AFPM Jemmy Wong =
<jemmywong512@gmail.com> wrote:
>>=20
>> This change replaces manual lock acquisition and release with lock =
guards
>> to improve code robustness and reduce the risk of lock mismanagement.
>> No functional changes to the cgroup logic are introduced.
>>=20
>> Signed-off-by: Jemmy Wong <jemmywong512@gmail.com>
>>=20
>> ---
>> include/linux/cgroup.h     |   7 +
>> kernel/bpf/cgroup.c        |  96 +++---
>> kernel/bpf/local_storage.c |  12 +-
>=20
> Nack for bpf bits.
> It only uglifies the code.


