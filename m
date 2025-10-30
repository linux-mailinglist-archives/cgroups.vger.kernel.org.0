Return-Path: <cgroups+bounces-11417-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4717CC1DE10
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 01:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D9114E3E83
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 00:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D59E19B5B1;
	Thu, 30 Oct 2025 00:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hxu+HoxM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF25518A6CF
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783384; cv=none; b=TpyzqTTNevCalPA4VDTCrqdj2DSaCcNccJbbF9ez82/SAElR2CF4B8ga+9eHnPIRzMZR7+kVS9k0THY9hh4C0A71F4HkQllCn+mkQor/c3jQ+FU8sVvNo9V5hr3XZh7vt1GfXp7+umra7B9YuyDserd2R62csz3tbUISwZh2m/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783384; c=relaxed/simple;
	bh=x+I/KzwoC12VkmtwKHyh/Qebgf4gkZrqoOo7LWzoDTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rR+AyESz+InqtOOS5ROQJWPT8YlDY0Axn18wEfltvVxWPoWxGnO7nly3IMBuwEshr/CykGYKQqU01d9kleYpVx9ugS67Ujf/9eWAE/gNRcGWkXh+uC0SEH7GWUjGFokFvkWvF504WKuvbw3CrqfsLNwEx1tDWGOcpBmnIBghds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hxu+HoxM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so2378655e9.3
        for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 17:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761783381; x=1762388181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+I/KzwoC12VkmtwKHyh/Qebgf4gkZrqoOo7LWzoDTQ=;
        b=Hxu+HoxMkRS31UVo2FKKI9iauD8T4ksstCd9RhFSkOOc8lzizxmnfsMbhb5sNp+sgo
         8KoTvm+AjAM432e++w6cmPIBFMDjS+ZXH36BWww1pIoAhz8N7CYu9ngmW1qtZJgDt6tR
         pdbye4LUhFknFmcvEceIq/9D0BRh6Wi9n1sQlzDc2vL5T71nL3d83YDVFo+V/5dPDi5X
         DS+CqHx8tx4ATgZVv+okvTQ79dEEtYVkagLjwPa9M+vlQ75PW9MGAp0kpPcsuu5zYiDL
         a0ztm8lTOVdKAkYpxOorqLUvCkEOmKgGuvzyS5Pc0VNY2SLoSTFvYsSCA27XyOHJZ4UU
         KZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783381; x=1762388181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+I/KzwoC12VkmtwKHyh/Qebgf4gkZrqoOo7LWzoDTQ=;
        b=fOD+vngGADClD/F1XUfngD8KaXTsxZdM0KnUl80TUzajjmkbsxPYOT/xuu+LGVR5q1
         19MRUN84wVkLKE6vpbfDvB+msfq6RwH3FPDkZZShuVYUsangSr6hi9Jb78nWp+UX40xZ
         OSLq4PK/S3Aco3jwW6JCXBBqxiGX+afc4VhL3UCj8rdO9Edss9m4VEJrTsJTui1Juhjo
         Y88OIoAglsp3Ka9/H8NL9iLzgSQyYmGkyed5xQzfGNiVu9Xdncva6jwPa9VEgD2hiJ+x
         0QtwL1INrQWHx+vaXzt/96Se/lJ25jLV1GKYfd7c7RNgx6iLe2vvEk06nYQlELId8u8D
         YK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsIcxtnwTM3yAhvPMI8eNjozmAksOlsJQZsOrh9zV5CG8M+XB5ymjLXekGajytzMJdipDJfbin@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ3jGew4Yvg/o4oXqoKV2R+L2o4l8MUY/0ORFVQaHLPOCstbEQ
	CYDx+zuNNBBfR2kEVoxLFY/wpf+BPiqoEIyX+dm3y5e5y2o2NBkJtFqUyHoX4CStsdWG/s8FA66
	jwerMb7zjHm4JKFFTGWLWPf9+j0uOmXZGBht3
X-Gm-Gg: ASbGncsq08bROwN3TB7v8LjubAOAmRsdtTV0+rfpGezjIrTutGpQrLkLAmsPTjT7XrY
	exV5y+JkTHOA+sS2rRAtyQxjuZTijGFQtLlEczLrQjj+m/Eo+ooJsxc+PeqFQzvBfatWmObm6WD
	J7CsxySLVer/anBwwLui2mKEbQvaxr+eUKm/SRRYVBusA978rrX/G0/1IxUcHVT745fAdV3u4t8
	0BvFyAz36KRGoLFcXh+pPKk16bSdRSmXJsAfNhhD/AZeae0VK2eDYVAvp+2IZb6yCHb/Q3loZYG
	eA11y8yHgtIs5lSjtg==
X-Google-Smtp-Source: AGHT+IF09btOdHcwxJqodVRN+ViMyO/SoklcID7X1FwZ3ORBb9xOqUsCObSUvrzvXw3Kfh27llznbS5xErV22oTfDgo=
X-Received: by 2002:a05:600c:64c7:b0:471:672:3486 with SMTP id
 5b1f17b1804b1-4771e18157dmr48056215e9.15.1761783381050; Wed, 29 Oct 2025
 17:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev> <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
 <871pmle5ng.fsf@linux.dev> <CAADnVQJ+4a97bp26BOpD5A9LOzfJ+XxyNt4bdG8n7jaO6+nV3Q@mail.gmail.com>
 <aQKa5L345s-vBJR1@slm.duckdns.org> <CAADnVQJp9FkPDA7oo-+yZ0SKFbE6w7FzARosLgzLmH74Vv+dow@mail.gmail.com>
 <aQKrZ2bQan8PnAQA@slm.duckdns.org>
In-Reply-To: <aQKrZ2bQan8PnAQA@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 17:16:09 -0700
X-Gm-Features: AWmQ_bnVnjW4yRQWoj8DDZKSY0nxin242cIZkPvDGi7K7MOsZBTy6KJHgZg6C7Y
Message-ID: <CAADnVQJPcqq+w0qDjMV+fx-gYfp6kjuc7m8VD-7saCZ7-bvaBw@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Song Liu <song@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 5:03=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Oh, if there are other mechanisms to enforce boundaries, it's not a probl=
em,
> but I can almost guarantee as the framework grows, there will be needs fo=
r
> kfuncs to identify and verify the callers and handlers communicating with
> each other along the hierarchy requiring recursive calls.

tbh I think it's a combination of sched_ext_ops and bpf infra problem.
All of the scx ops are missing "this" pointer which would have
been there if it was a C++ class.
And "this" should be pointing to an instance of class.
If sched-ext progs are attached to different cgroups, then
every attachment would have been a different instance and
different "this".
Then all kfuncs would effectively be declared as helper
methods within a class. In this case within "struct sched_ext_ops"
as functions that ops callback can call but they will
also have implicit "this" that points back to a particular instance.

Special aux__prog and prog_assoc are not exactly pretty
workarounds for lack of "this".

