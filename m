Return-Path: <cgroups+bounces-9159-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807B7B25A80
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 06:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0E72A1548
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 04:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB11202990;
	Thu, 14 Aug 2025 04:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZulMerqp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77DC1DE2A5
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 04:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755146055; cv=none; b=GClYYXR5VHgkWbErx0fHVrnj55ypIq6D1yEZ9eCSKrv7y6iuTlDXCfdG2G/vSIfgL+N6fWXe5oCOJ1fHHmeeYcaHNfahkSnoen19aE51NPWo6QwzRFTXdsM7dzXgD/0aNOmnuame3NT/jHKPYz4q663xde5BmQ7olw8M3qJqWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755146055; c=relaxed/simple;
	bh=1jpYMe9Rs3tolynO9B73W/0DpudggFG/LEClC4JR1AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAp5A0s+tkwdnIc5a6/RI6afANkjKgIE3biTONANf8QHYU4MD3XRQPJ2w6qQLJUufNWeudmt4eAFSdcLZUd+jkY2t10mx201GhShWoJSr9/EuiA8fjr6m9vA4dBALMliHr5smTIMwGc387m/IfI1EmYcEHYrRj3rHC6bTrJfiWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZulMerqp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2445806c2ddso4285275ad.1
        for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 21:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755146053; x=1755750853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jpYMe9Rs3tolynO9B73W/0DpudggFG/LEClC4JR1AM=;
        b=ZulMerqpseRGKB3VfhN2cwrwFpK8vPuZeXrlnh4lMn7zJgD8M2JqFPoiVd2ORP/jy3
         fTgJtf87Dmlx53M7GrdlfDBkapwrkhcXOuVbvz/NVvOYl2wjdtOQ/QZBgteymcahoS1a
         iaWK9i7+FAqkWhj3HIwbP2WiNn2EFSlQjkyODiTMBMOoTUCpMOg2N37TdhU1d1uylm4+
         AiblJE8T+zA7keEoXzZCskJ98aDKWVsL8Ikf5AgjkpqlYcSdiB0zXGJCocF9XFkGxpUz
         GwBwGdBS8QOzAN3ifhfGtGU07cQHoqfTp+4P/XLnecRvofCriSxWbcwTICJILxzctV7u
         TD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755146053; x=1755750853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jpYMe9Rs3tolynO9B73W/0DpudggFG/LEClC4JR1AM=;
        b=J0Wck2f4rSnf8tbJbMZl4WI0BAkCKn+P3rELwsxvR/F99t8NRi8OI59BVKFxiDQ8+O
         tBRe0nKZ/3oVyIpsfdslWMS2FCL4DowWkpjfRgSSOhsu2Lm8adWfwBLSRkhl2cJK0b6f
         49yr2MKP2aH4GtWGpQj1p8AkkJDCIadCEFwlx/SFzI4Q+Jx0YkQCN0QvbnKqgyuwt677
         HCsW2ESjgLJcMMIpVnEvlyr/2SkbRzm8xnJ7h8gMY5fSSFKjjqv5u78yHVAi/RIEi9NA
         vOeIDXax5CH9c7NtAbWYh7b4MDFoVlK0YZgXmK5/GcwcaMLKyITypM3yX6RKvjeGgIs3
         WcMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKqOTnjpD/xhGD/Sqd0m3RKC9STxZfdnzimrnuXehUWgYmTG5p7cOG8NDQ2Lr7MVL7Rd7h97nx@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/RfxksgsfgbNF6aJnCyji5LUJfqkdCtI0We6zL1FXlBGUb2w
	19soSxfgVg+lFem7nZdZIaLCr5V+Xm85w85RY2awglr9rlWCWohNZk/klwO/xt6QWEzDiDNF380
	G9ubUQ/jDrSb+m1eTTsfFB87ql57EYketn+8jbnT4
X-Gm-Gg: ASbGncsmFzkiMsSHLdQ4SLa8dXrnUBYqNHYKupiaIebGULNl/fwPyyEfA/nhFe5aO17
	SXPIFvyHa317TXhdFEG7M/Ghj/V1T1Xjh12Cii1cy2cZ5h+ouwNc5khTkDiOV4ecZOG1jUxqc0H
	oJ6EotSTRgE9YyGoBRA25q228seN6PzQvzPxc0XP2gLwTUYQNcETdhUs6ic6tSa++Gy1kra66zL
	0TjRUTkwk2TJmPZHPUrtuFDWik4NeOdH+S9+ADXzJczPEKShjZJqKOXDw==
X-Google-Smtp-Source: AGHT+IGwKj8+FeXsQR4WunSW0QBU4S01IHDhpLwKH7+wQspVHInHE5tXI45S3ELL33wWwQ08lPI1qcfPuEc+19ZHTWs=
X-Received: by 2002:a17:903:19cd:b0:240:5c38:7555 with SMTP id
 d9443c01a7336-244584ede2fmr22257795ad.5.1755146052777; Wed, 13 Aug 2025
 21:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com> <20250812175848.512446-13-kuniyu@google.com>
 <w6klr435a4rygmnifuujg6x4k77ch7cwoq6dspmyknqt24cpjz@bbz4wzmxjsfk>
 <CAAVpQUCU=VJxA6NKx+O1_zwzzZOxUEsG9mY+SNK+bzb=dj9s5w@mail.gmail.com>
 <oafk5om7v5vtxjmo5rtwy6ullprfaf6mk2lh4km7alj3dtainn@jql2rih5es4n> <e6c8fa06-c76c-49e7-a027-0a7b610f1e9c@linux.dev>
In-Reply-To: <e6c8fa06-c76c-49e7-a027-0a7b610f1e9c@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 13 Aug 2025 21:34:01 -0700
X-Gm-Features: Ac12FXwCislSz3BViv-OIQ8p6QupR93n7L2582VKpwYhsHhniE6ipCNyQvXHe4w
Message-ID: <CAAVpQUD6hCY2FDWKVnoiQ59RmovLizTPCC+ZNqB=oyP5B4-2Aw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:55=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/13/25 1:53 PM, Shakeel Butt wrote:
> > What I think is the right approach is to have BPF struct ops based
> > approach with possible callback 'is this socket under pressure' or mayb=
e
> > 'is this socket isolated' and then you can do whatever you want in thos=
e
> > callbacks. In this way your can follow the same approach of caching the
> > result in kernel (lower bits of sk->sk_memcg).
> >
> > I am CCing bpf list to get some suggestions or concerns on this
> > approach.
>
> I have quickly looked at the set. In patch 11, it sets a bit in sk->sk_me=
mcg.
>
> On the bpf side, there are already cgroup bpf progs that can do bpf_setso=
ckopt
> on a sk, so the same can be done here. The bpf_setsockopt does not have t=
o set
> option/knob that is only available in the uapi in case we don't want to e=
xpose
> this to the user space.
>
> The cgroup bpf prog (BPF_CGROUP_INET_SOCK_CREATE) can already be run when=
 a
> "inet" sock is created. This hook (i.e. attach_type) does not have access=
 to
> bpf_setsockopt but should be easy to add.

Okay, I will try the bpf_setsockopt() approach.
Should I post patch 1-10 to net-next separately ?
They are pure net material to gather memcg code under CONFIG_MEMCG.


>
> For more comprehensive mem charge policy that needs new bpf hook, that pr=
obably
> will need struct_ops instead of another cgroup attach_type but that will =
be
> implementation details.

