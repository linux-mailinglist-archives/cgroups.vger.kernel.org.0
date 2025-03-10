Return-Path: <cgroups+bounces-6932-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876D6A596E6
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 15:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478733AA295
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 14:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE4F22A4EA;
	Mon, 10 Mar 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRt17fAI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6061BC3F;
	Mon, 10 Mar 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615238; cv=none; b=lj8N8BiZ1PawN6fuEKzLZHOJNfAFbacFw10jCdLAEvveSeN1VDSJW5hmrwJQO9SZjtpVVhsQJfSOr/jsHa8hDv47mRsz1fq9Fkrk5Hkz/vrkFRo6CcVJFncSZcIuzCfRUU5gHbZ44CLbiJ1mdBXWD1dndd3guXR33Sp4VjLep1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615238; c=relaxed/simple;
	bh=Ba5NDi5fZRJd4/CrXOUiPUATJgsupoyMZmnZU/+S/Vw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hkWtCw4cx0y9y56phdj+J26yN2/oohvbiCHvF3GrvsRCzkKLnfqmH+r6uDkYpuzW+BLG7LKAJfNz8vTs+w6ck4eE8zEmcHfw5TDSQD6SL2a5+ILQqIeBori5/cCOG7EQmgGutzdwBEIe7AeZK5ySXM+K5pMgb9y5MQTMjQ6WjBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRt17fAI; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47548733e7eso35010261cf.2;
        Mon, 10 Mar 2025 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741615235; x=1742220035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUfVmD+fo/7wc5Xvn1/+10J6Mu9jVuL5I3o4O5MqQ48=;
        b=bRt17fAIDw41jsDBUY2Kh03GsgfW2YZKSrXa2PLxr1yB3prPI5b2fU/ixAed2slTCk
         ignybOPK8m4CGVeVZ3e/7FA0rgIZcx6EUvcxsyj0zB2mGV3C1XQFQ0aRDqvLaOyd7tSa
         2L26gb8AFr/2f3YaXCkxZ6piN/Y9FaGmHZckLkaVivjr5aHPNZEgPNpdvyylxhOnetwL
         XhGos8aM37yTLTt34esJUlz+0IlLUooJ/owGCpfOMvFPje8GwcqKnO3lHwLmF6l+K42t
         xkJoQuMoONAiPrmwhtNN+KfSS0OkXBZgE59BwqbTWDOcMdxK0XyNFLddJZxS4LOTac0t
         IVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741615235; x=1742220035;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KUfVmD+fo/7wc5Xvn1/+10J6Mu9jVuL5I3o4O5MqQ48=;
        b=HzNxL/bl+szZK8LGC44k/NOPQcZWzE0E7p4ysfl/kxeO2PzIp3lECXwYFZjHEMLLlC
         OEyUlblKsz8Umn11qWM6iTpVpxGjgZtH6oER/Ptrtisf1EkEpr/VPOr2BQleOHWgbHPx
         gTs4haPQFyo9GaV9BgkoCdnJy3yLWpcKeAWILMXAuEE8O1x0aya77WMTUjb5Oi/nblat
         sWRR64lcopAEgWe9JoYfoPXg80W8eUA4Z6Qu2nNGcDERSIzhvpqf+5XklL0VHPeY5ezS
         7HwUjYrcPzYnNykJIVPhI3QVVkw3jo8Nva4lCDOvS1MZ4H25IJM6BIfmA9lKbhUpsCC3
         BpcQ==
X-Forwarded-Encrypted: i=1; AJvYcCURhDZ1cVSjiDgKa8ZvAH94T67IUVb59bZAHOCSHn8BS9Ow7cV6C6TGESae/piFqWAWw2rCjMiH@vger.kernel.org, AJvYcCWFCNmg5iB7P2Ifd0UhEvWbzeOK1EH5eQnT/FuMLvtwaktL87jxESXSU37qw5HHUBu/0NiY/7JxKFtlgPAA@vger.kernel.org, AJvYcCWuvcMbst579WafSlrivrUSCUGNdSuYC9CQSzmAofPwUKHOuNwZcWwR3fJbIjmIsqnVMMjAO04c@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt5fI4l9MtmKhM2UvdJ6wa69RrK6W5vPEBGzP4+LA8iXBra+Ar
	s9G1klD01rrXtR7jz4XOVFx86uBBS+OhCFZeY034GXmsoBpFpwTT
X-Gm-Gg: ASbGncvRj+2dMC0GZwW0V+Wm/Kj8SVDjEpwgkVWi2hUTRIoMXG9d65QBlvTLw1ZBQDc
	TYdYGAl5UHXoqZuxjZPWwkQBwYDoe7cxfUcCqsS8YUpAkAJRBwDwQ+UH3rtQgsYrm49nabiP5v2
	uzuESOP2kPduyYobeFvpT1CG6V1BXpgh1E5xa6A8JKd+rJcglz8RMQNCz6ipkmAzTNTY9gegfj9
	V9hMPYrf+UFNNVBJZXo/IgG0+DcIrFFkOWq69VuBDA7CA13mG7nmEXXHNNN8wIUtkb5TaD0Nwv8
	JLq3mv1VcSSnYh26eIDvMXk9THgx1FtFTSqiX2g6O+NnmhzWv4jRlYLSGw5vBSN2nKaie7EsGyB
	YkhSbMs1OnzFY01Kz2ERWig==
X-Google-Smtp-Source: AGHT+IFI0hAfwuH0U/UW+ytLrbkunn8AQjq75B+5EEJJwLCpaxuyCyVWOshYCKkKwynkC9DTfKnqug==
X-Received: by 2002:a05:622a:1a83:b0:476:91d8:230e with SMTP id d75a77b69052e-47691d82646mr26421501cf.52.1741615233667;
        Mon, 10 Mar 2025 07:00:33 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4767d0dea2csm23105101cf.74.2025.03.10.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:00:33 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:00:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
 kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 cgroups@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Luca Boccassi <bluca@debian.org>, 
 Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 =?UTF-8?B?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>
Message-ID: <67cef08098659_24626529485@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250309132821.103046-3-aleksandr.mikhalitsyn@canonical.com>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
 <20250309132821.103046-3-aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH net-next 2/4] net: core: add getsockopt SO_PEERCGROUPID
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Mikhalitsyn wrote:
> Add SO_PEERCGROUPID which allows to get cgroup_id
> for a socket.
> =

> We already have analogical interfaces to retrieve this
> information:
> - inet_diag: INET_DIAG_CGROUP_ID
> - eBPF: bpf_sk_cgroup_id
> =

> Having getsockopt() interface makes sense for many
> applications, because using eBPF is not always an option,
> while inet_diag has obvious complexety and performance drawbacks
> if we only want to get this specific info for one specific socket.
> =

> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> ---
>  arch/alpha/include/uapi/asm/socket.h    |  2 +
>  arch/mips/include/uapi/asm/socket.h     |  2 +
>  arch/parisc/include/uapi/asm/socket.h   |  2 +
>  arch/sparc/include/uapi/asm/socket.h    |  2 +
>  include/uapi/asm-generic/socket.h       |  2 +
>  net/core/sock.c                         | 17 +++++++
>  net/unix/af_unix.c                      | 63 +++++++++++++++++++++++++=

>  tools/include/uapi/asm-generic/socket.h |  2 +
>  8 files changed, 92 insertions(+)
> =

> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/=
uapi/asm/socket.h
> index 3df5f2dd4c0f..58ce457b2c09 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -150,6 +150,8 @@
>  =

>  #define SO_RCVPRIORITY		82
>  =

> +#define SO_PEERCGROUPID		83
> +
>  #if !defined(__KERNEL__)
>  =

>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/ua=
pi/asm/socket.h
> index 22fa8f19924a..823fa67f7d79 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -161,6 +161,8 @@
>  =

>  #define SO_RCVPRIORITY		82
>  =

> +#define SO_PEERCGROUPID		83
> +
>  #if !defined(__KERNEL__)
>  =

>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/includ=
e/uapi/asm/socket.h
> index aa9cd4b951fe..1ee2e858d177 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -142,6 +142,8 @@
>  =

>  #define SO_RCVPRIORITY		0x404D
>  =

> +#define SO_PEERCGROUPID		0x404E
> +
>  #if !defined(__KERNEL__)
>  =

>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/=
uapi/asm/socket.h
> index 5b464a568664..2fe7d0c48a63 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -143,6 +143,8 @@
>  =

>  #define SO_RCVPRIORITY           0x005b
>  =

> +#define SO_PEERCGROUPID          0x005c
> +
>  #if !defined(__KERNEL__)
>  =

>  =

> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-gener=
ic/socket.h
> index aa5016ff3d91..903904bb537c 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -145,6 +145,8 @@
>  =

>  #define SO_RCVPRIORITY		82
>  =

> +#define SO_PEERCGROUPID		83
> +
>  #if !defined(__KERNEL__)
>  =

>  #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP=
32__))
> diff --git a/net/core/sock.c b/net/core/sock.c
> index a0598518ce89..6dc0b1a8367b 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1946,6 +1946,23 @@ int sk_getsockopt(struct sock *sk, int level, in=
t optname,
>  		goto lenout;
>  	}
>  =

> +#ifdef CONFIG_SOCK_CGROUP_DATA
> +	case SO_PEERCGROUPID:
> +	{
> +		const struct proto_ops *ops;
> +
> +		if (sk->sk_family !=3D AF_UNIX)
> +			return -EOPNOTSUPP;
> +
> +		ops =3D READ_ONCE(sock->ops);
> +		if (!ops->getsockopt)
> +			return -EOPNOTSUPP;
> +
> +		return ops->getsockopt(sock, SOL_SOCKET, optname, optval.user,
> +				       optlen.user);
> +	}
> +#endif
> +
>  	/* Dubious BSD thing... Probably nobody even uses it, but
>  	 * the UNIX standard wants it for whatever reason... -DaveM
>  	 */
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 2b2c0036efc9..3455f38f033d 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -901,6 +901,66 @@ static void unix_show_fdinfo(struct seq_file *m, s=
truct socket *sock)
>  #define unix_show_fdinfo NULL
>  #endif
>  =

> +static int unix_getsockopt(struct socket *sock, int level, int optname=
,
> +			   char __user *optval, int __user *optlen)
> +{
> +	struct sock *sk =3D sock->sk;
> +
> +	union {
> +		int val;
> +		u64 val64;
> +	} v;
> +
> +	int lv =3D sizeof(int);
> +	int len;

why the union if the only valid use is a u64? Is this forward looking?=

