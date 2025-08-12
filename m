Return-Path: <cgroups+bounces-9094-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD12B22CC3
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 18:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269F2508285
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6082F28F2;
	Tue, 12 Aug 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PAP18Fbj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6027E2F28E0
	for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014125; cv=none; b=e7sWTnE9SwzM7HARavnqbzEw28MhLnRxipr7z7bLliRHJQYpMXpcsHAEOXL4blZcid1Zk4AuFlF3LMA6ALvetyrINrouk13wF6KX0AcI1gsbKrRpmehI7vv2aelHa1Fq+sN/91ZzlgKjkYV+LkaEchHhMcxtlfQrHb+tIVsZSHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014125; c=relaxed/simple;
	bh=r0/yEUMM7JPqnefmK7vmUlZWOLUisa+zKgHd/TvVIaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgxtL/58x+wNGrmJiFHTzN2mTSL5j9HctVlAWx6B98GsZVzU7/q/drGkbpLpNnRx4MkALejrBM298/b3jmChATHGnRY7AbahOJW5ezQKq4zzyF9gTxipQG7hvrEqb4Q2bnJlImccFfWKd2ExF5Hl0W69Agf84j1DN5OQMrAtd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PAP18Fbj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bd7676e60so4858958b3a.0
        for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755014123; x=1755618923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mcv2bxyNpRc50Ynpw4pPqHAkM7Jzrp/2IvvGq7EcEI=;
        b=PAP18Fbjhqn8BJLnWsJxG1VR5DW5l6rmrqytcAJgutiTpnQP7EbYwyHUDa+SqEOAqG
         jkYeriaxBRGFD9dm5stzRwZP+AjLYGaz6vdv3n0nnk7tUuDRy2/AUK+/QdrbAUJjZtnz
         L6HzQ9cN/GsY07MxjwYFXpj9r4L7h1LXm8UYKNAB+15ekc3jO/iqD/8J65RkAvKHQAaH
         vR7POb3gfDNlAZ62ZKy9FcDXh8RzZ3x7wOBoeFexQpSO9uNPdWSV9kWC3h2jME9mfbx3
         6EeDnf+Tebik0ahFFfZnJ/7GrghYPmzBQ1ki4FiAIKe0LBq9Tm/Vl6USFBZbsLSWlLuX
         Jkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755014123; x=1755618923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mcv2bxyNpRc50Ynpw4pPqHAkM7Jzrp/2IvvGq7EcEI=;
        b=IZimXf+NNNst6bwk6Oyq6Z251MjlCvYhy417/qbvxe/rfc0wMnH3HXd1zGr+D8R32C
         CjpfCNdLk6aU1ZRA9sEDMMf4ICDribRqpFc/bnr0me8v9bdWndL+skL6oG7Bi7tAVc/M
         4a4tWaM+s4tu1p2AmxuHSxDK8D3HkAubNt8VD8O1M731A6CI9WPG9KkEkdHZ/Un1jdpW
         czjxjaUNB4QdBVkpzKkitBHsgFEpIY7xxlgOgAKWDU71HEPlBwoUuF4tEC3luLdXN+ko
         YrmA7yylJNdDyF6XBQhRm7upS4t2PNUM7kGJ4JO6+6fyCRnZ81t+A9PG+7ER69SOJh0G
         7luA==
X-Forwarded-Encrypted: i=1; AJvYcCWVCMdffYurpx+WcP6e5k408sUaBeqmcWsQOIyzT7niYL4r655MMdssRXDisO+Y//w+54rMJE37@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkz+qxjLOMgCBw17suF+DBOndnXF8AV0OEAiyTlhVaFJBXgwp4
	Vy9kwHGBnuIbnk21fEpIBqr+FS7f75vh5/YGhjtPL9rxqggDfI2gRTXy85MuHWOpRHecfjXG2UA
	bTuvYuz6QUC9+B3G7/I9cKp2zte637Y9QiSuiJG66
X-Gm-Gg: ASbGncsz4T9sP0+ZDz53BXF/MSSZKi8DMz+vAhuB0x2FHKNv0jEgJXvTO5mH+K1wUha
	K6O3fU9hqxEcAlj6ele8bKCM+PzBYRG/i/mFC5P/bWGghB5G2WoMH7L7Y0FzvJRK4+mUwdAdhD+
	80py3i517g8dfQzxLACn49jhdo+V8ePHDiQd2a/5x82JEvRuLjAYqPn3EBVXXXQY/Aw2pJNu3rw
	GWyF2g=
X-Google-Smtp-Source: AGHT+IFChq5GEq9GGfaAl4dOo1Sl+YOfAmncpR386ybj+7kBczFF1Z2UKtKOTxU5KLS0Amm9EkxnQU0RhLAZT1wXcRA=
X-Received: by 2002:a17:903:1968:b0:240:11cd:8502 with SMTP id
 d9443c01a7336-2430c008265mr2760005ad.13.1755014122559; Tue, 12 Aug 2025
 08:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811173116.2829786-13-kuniyu@google.com> <202508122213.H31XXZsm-lkp@intel.com>
In-Reply-To: <202508122213.H31XXZsm-lkp@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 12 Aug 2025 08:55:11 -0700
X-Gm-Features: Ac12FXze_DG1t-NtmVQ64sQY1bC4hkt6geufHULb5hsjS94rK_uLgU0R6YoMjYE
Message-ID: <CAAVpQUDguV+qG9Aer=o2HS74OP2EdsWHbFx3J654hU3sBnHtRQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
To: kernel test robot <lkp@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	Linux Memory Management List <linux-mm@kvack.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:09=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Kuniyuki,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/=
mptcp-Fix-up-subflow-s-memcg-when-CONFIG_SOCK_CGROUP_DATA-n/20250812-013522
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20250811173116.2829786-13-kuniyu=
%40google.com
> patch subject: [PATCH v2 net-next 12/12] net-memcg: Decouple controlled m=
emcg from global protocol memory accounting.
> config: csky-randconfig-002-20250812 (https://download.01.org/0day-ci/arc=
hive/20250812/202508122213.H31XXZsm-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 10.5.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250812/202508122213.H31XXZsm-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508122213.H31XXZsm-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/cleanup.h:5,
>                     from include/linux/irqflags.h:17,
>                     from include/asm-generic/cmpxchg.h:15,
>                     from arch/csky/include/asm/cmpxchg.h:162,
>                     from include/asm-generic/atomic.h:12,
>                     from arch/csky/include/asm/atomic.h:199,
>                     from include/linux/atomic.h:7,
>                     from include/crypto/aead.h:11,
>                     from net/tls/tls_device.c:32:
>    net/tls/tls_device.c: In function 'tls_do_allocation':
> >> net/tls/tls_device.c:374:8: error: implicit declaration of function 's=
k_should_enter_memory_pressure'; did you mean 'tcp_enter_memory_pressure'? =
[-Werror=3Dimplicit-function-declaration]
>      374 |    if (sk_should_enter_memory_pressure(sk))
>          |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Oops, forgot to enable kTLS and allmodconfig.
Will add #include <net/proto_memory.h> there in v3.

