Return-Path: <cgroups+bounces-7321-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFBCA79D55
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 09:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E54173A11
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 07:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72551A23B9;
	Thu,  3 Apr 2025 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X6F9ZdLS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575F1411EB
	for <cgroups@vger.kernel.org>; Thu,  3 Apr 2025 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743666467; cv=none; b=QWdkTN7FsONSeFAkmTSdjUqAmX6DnzgVjg3Qk2laOoUZFZndDxnlelDc26tp53EEhvC+dB2ZjsH6TkajB48FpiYY77ZGlQv10sqCN4VZCYGoGtLIc4uMG8s365m74xqlT8iltLsClzE2uLaK3FKWZtXDqs0kP8f7GoHj7XgB0Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743666467; c=relaxed/simple;
	bh=fWe0XgwWCGoaCQE0Ze/b6miLO2cEZ4XihFTdgIZK7nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/ChCioKUmgp/5YLsU6wJxur903Iny0c2WmIMWUYo7TUDVBhxGAa8mcgYjjHyCcf1yKP5DZjqQr5Tmr/+Kf1R+rK0hpPDL3X4Hc1XC8BxDRda7qvPlsJxrQ59gTcA6g/aYzOCC/yCj0fSZeu02jWt3Y83mlPdeH0MZyzvg/5Mgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=X6F9ZdLS; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so16867241fa.1
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 00:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1743666463; x=1744271263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWe0XgwWCGoaCQE0Ze/b6miLO2cEZ4XihFTdgIZK7nc=;
        b=X6F9ZdLSz++G56fCsJWFb9ESdiRS5MxEFAjiR8Jmz3SAVlglfow+AChpKLBAp12La0
         8FS1HlsxOc/6iAaecjheSd76oSSGWA2qmpGPbyTCF/8K01uR4VOj3hLemjtsnL71Ckpx
         rzDBvyYHqhz4oOp1tPnYuKf+Dev8BsHwtXB9P4nF/NuMle7QTNIIMBUzbvPiXAJf/z8x
         JLAtRjc2nvyqHQXJaIsJ5CkDVWYyWTh+dmUUMVVD7zRIC8x62wat+uP+RymY7KvSACX4
         Ry+qUvOg569HAwoAqrCGIpzfIXBKTep33RCvCcvKszkdc4TlaBhlvvQ+eBRwEv+LJbvw
         anOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743666463; x=1744271263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWe0XgwWCGoaCQE0Ze/b6miLO2cEZ4XihFTdgIZK7nc=;
        b=QZe/iUJCO3gw4UluvfLhap8+BawEpapkHmB7sfD3DBg/DvWcV1207r8v5s2pC6tPWM
         ZEWZJAI2SLpr/whZrbI5OQYC+0KVNT9i19KwDUq2On0Pmq5YyaWGkOGy1UnykDrdSBtB
         elR9k0QYtVDCZ8uBbHNXZm5+jij5bfqBR20QBNF5cgw6ldjaArSPmOVUoSzLiHg9gaHl
         lMiNGN5BbcV2ZWt5s5jFLWUzxVXmZwPGvxctFKx9CgHB5lTepWrM8JIe+aBYk7ipF7TL
         712EC5HrTZ0RGgL2sSyw7hYC+/a8jcfbt6iQM+Ysn55BkhpxV4W6c11vC9Ev72QHZ9qS
         Fpdg==
X-Forwarded-Encrypted: i=1; AJvYcCUWmYI43be74e5XFxlj4yD6VzX42kJLjSAForRaj7KfJlUNUvqKA9/CJEJTx4FQYixjLKV0d/Bc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4jhChHXNp3mCDTGrzIp4/1+Hi66orbyXbsw66g6m1JW7PKpxf
	qS4fBhBN2ygX3wyXVNhqWC8KPedunLAuzZ5pavFwwaUch6sQ9Qe1tFydXRR1jZD5NiknJMvB31i
	NzaysqYppbium780GNw14t1VF6ZZXyHiOYv6oXg==
X-Gm-Gg: ASbGncvKNedDqgzkg6f5RyS7jzmMFvLY6AuKjA6f8vOoAymcTjKBOmPeVQiCDCToV3i
	w72teiVfq+A4tIlIB+eX9bKKBsY/BcR7hpq3ax8UgQ99RJ+IlcCktoaLciKnXem+BbQYrYEywIG
	P+0C2puXHbPvbZ7EsZWeBfAofHCuue6awE7GpKE5w0l5L3Tzhj0P0=
X-Google-Smtp-Source: AGHT+IHF3RTQt7C8PWWKcW03kqyq+vB9t274NDs3XZDdekEAKo7i3dVAqYWB0kkOx5kesGqT8ATQ5REdHm0zDyHlpMA=
X-Received: by 2002:a2e:bc92:0:b0:30d:c4c3:eafa with SMTP id
 38308e7fff4ca-30f0064c308mr9536351fa.7.1743666463599; Thu, 03 Apr 2025
 00:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319064148.774406-3-jingxiangzeng.cas@gmail.com> <m35wwnetfubjrgcikiia7aurhd4hkcguwqywjamxm4xnaximt7@cnscqcgwh4da>
 <7ia4tt7ovekj.fsf@castle.c.googlers.com> <20250320142846.GG1876369@cmpxchg.org>
 <ipskzxjtm656f5srrp42uxemh5e4jdwzsyj2isqlldfaokiyoo@ly4gfvldjc2p> <4lygax4lgpkkmtmpxif6psl7broial2h74lel37faelc3dlsx3@s56hfvqiazgc>
In-Reply-To: <4lygax4lgpkkmtmpxif6psl7broial2h74lel37faelc3dlsx3@s56hfvqiazgc>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 3 Apr 2025 15:47:08 +0800
X-Gm-Features: ATxdqUEqWWLBNL7_e1hPcDJGh82p0lp3vOrTz9-0gyPLg0SnpQkWNGC5Tw6uG5U
Message-ID: <CACSyD1NisD-ZggRz0BaxUdJ9so4j-sKPZi361HJAum3+bHO+tQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC 2/5] memcontrol: add boot option to enable
 memsw account on dfl
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Jingxiang Zeng <linuszeng@tencent.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mhocko@kernel.org, muchun.song@linux.dev, 
	kasong@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 9:42=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> On Thu, Mar 20, 2025 at 08:33:09AM -0700, Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > However I want us to discuss and decide the semantics of
> > memsw from scratch rather than adopting v1 semantics.
>
> +1
>
> > Also we should discuss how memsw and swap limits would interact and
> > what would be the appropriate default.
>
> Besides more complicated implementation, merged memsw won't represent an
> actual resource.
>
> So I'd be interested in use cases (other than "used to it from v1") that
> cannot be controlled with separate memory. and swap. limits.
>

Hi Michal

We encountered an issue, which is also a real use case. With memory offload=
ing,
we can move some cold pages to swap. Suppose an application=E2=80=99s peak =
memory
usage at certain times is 10GB, while at other times, it exists in a
combination of
memory and swap. If we set limits on memory or swap separately, it would la=
ck
flexibility=E2=80=94sometimes it needs 1GB memory + 9GB swap, sometimes 5GB
memory + 5GB swap, or even 10GB memory + 0GB swap. Therefore, we strongly
hope to use the mem+swap charging method in cgroupv2

>
> 0.02=E2=82=AC,
> Michal

