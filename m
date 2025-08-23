Return-Path: <cgroups+bounces-9349-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321E8B3270B
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 08:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B5E1CC009F
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 06:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699921C2334;
	Sat, 23 Aug 2025 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PGNSn4Do"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6730113D521
	for <cgroups@vger.kernel.org>; Sat, 23 Aug 2025 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755929907; cv=none; b=agHIMgN9ljZvw4DHLkc5f579VkZy8YOT7lXVuyqosY5YU+QnQeUAMNT7ku59IgeH4FwCY0DLuYCtyEC9ZRrYnPqEDjeUWUEbMvb/tP3BV3rwMD/lDB6NMQyvO+exp5ordIhH+f/Cz9k8pxE9KjeeUFtbyy54XhsDzrZ9DBJ6b+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755929907; c=relaxed/simple;
	bh=bZn48aC+rqGXuq7Wic6Vfcgf2lcjG4wRkDvwUbEzKNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPVNaLaMxj+LtlA9j4AEPkn2i4r8b6p6wMzyFC0f5Xl14peyQuGpiQzofpeHSYigZBJLGabNshLku13z3a1rXNuQX6s/+r0P0TpbFwtsIPOBpYsDaRnSGH3LZQNxZ/cJIr27naA3Yg962t+lPBENwAyzE0gDodT8RBs0OE5cVBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PGNSn4Do; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e94eec0de32so2707887276.0
        for <cgroups@vger.kernel.org>; Fri, 22 Aug 2025 23:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755929904; x=1756534704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fe9B4QogL1CNYXei3YboAYYKAny2QBbn+ipsHUDuLLk=;
        b=PGNSn4Doc4DrpCbZBg+W9kVm2HD84GKTeHinvyiuGVCG6FGWbaN5stY9NHdMHifVky
         dGbeuBEFVVYfpoVCBY4iuC14qaywjY48x8JSnJApAeM6IeJaoONe/j6kMEbAyAWCGVOz
         IPQFEQFNewrnzMdse9olSGa5Ckt19PtGgLNPBoU8O28ZLh2GcTKgjnu1KYeF8ulUh3br
         8NS+g3i7g4nteWo6c5OueH3BjFWSieej9SOM/JlGfVKZtBhAcNIKjoYDE9zOnX1AECX6
         vebTVvEJaMOQK8uLcEDz9JD0+k8H/5hF+O1q7ScmwD9RfHQ9BMUHwb0WUezU0Y6Kmlp5
         VD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755929904; x=1756534704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fe9B4QogL1CNYXei3YboAYYKAny2QBbn+ipsHUDuLLk=;
        b=CHr2w0qwJsqRx89mNJpNz0Vn/zdFNunECul7tkjTCPF2eX6SyFQb+a83MQHyD1sNh+
         O6lgUAPtG2DU6TR+oYqb9CmskWesowDYzlT2iViYE4kW07AH/zFMG5qFA2UntYWUjGwV
         lYl6582DBf/7O0Nkte84aczNyCerDgIWYX1OScxRhpMRbk6JfH+IYX4+yVNZQLIDBnka
         i/4BN8TkDbHAa4X2VBnDirwaCEeUJnIFDn7F2zZ4ezjSea4RYmZ9QvVbIw/qvtBbyRiD
         uMgRAjNH2Cdh3PliBGs+helr7F26bRiU4gk8wIpUtXLDnBPIOkF0pWA6HK7uj8CjSJSC
         eTpA==
X-Forwarded-Encrypted: i=1; AJvYcCUGEqwi+T0htmzmxVPcBMLeuFTj4bxO9TGhbP308eVGiFGcYIz1hSvkfOADYc9HOKghqLHAyZjM@vger.kernel.org
X-Gm-Message-State: AOJu0YzAJyDdk/gRai1GQAHTlQ0AigcGYhpSbrLwep/aJ84kDAx6WbX+
	KdGvNir23gEe56tTzk+6h0nDA/FzmQFXbwEFIf1zFgtILBlyGHpN23qAaJ/X9GWOrr9QVkgVQ8U
	fFViqptxc9ft7C9s0Ql8DJpT9XuHtJTNDdlC0Xt9QgQ==
X-Gm-Gg: ASbGnct1o59Rria0jqrxSC6qN3dYcWmmjcGNzAgzSw7r6lQmUTUhxu9tjhshIY9TRre
	jiYaYPBu+IDEDAKZgYP17mJ8+Q8DU0ZsUEV8kvbC6t1AIiBZh/AE4dwFk9HgkYa/8HZklV6yAfY
	4mDSMbiWb2nI9ERNV4DRj8x2f65n18KMGuc981l4h5cD5OO7b86ufevJXcDdkrl6qifTdAr6PPC
	OsrgTjD+8Ih
X-Google-Smtp-Source: AGHT+IF+4VwJabSmHqm1OuJrLC1EunTidnKe7Nj1y/1G8DjRIDBILmH+4G2nb1e4//UM1cfwf01YJ8iFcUXks3HwKOc=
X-Received: by 2002:a05:6902:18c6:b0:e95:2702:6816 with SMTP id
 3f1490d57ef6-e95270268d0mr3510223276.30.1755929904301; Fri, 22 Aug 2025
 23:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com> <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
 <aKdQgIvZcVCJWMXl@slm.duckdns.org> <CAHSKhtdhj-AuApc8yw+wDNNHMRH-XNMVD=8G7Mk_=1o2FQASQg@mail.gmail.com>
 <aKds9ZMUTC8VztEt@slm.duckdns.org> <f1ff9656-6633-4a32-ab32-9ee60400b9b0@bytedance.com>
 <aKivUT2fSetErPMJ@slm.duckdns.org>
In-Reply-To: <aKivUT2fSetErPMJ@slm.duckdns.org>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Sat, 23 Aug 2025 14:18:11 +0800
X-Gm-Features: Ac12FXyOfNLp8q4yZni7XXqfZzc-Xc0uBvm0JA-Rlo4tH5dpdniIQM2_tzLTwkk
Message-ID: <CAHSKhtebXWE5m0RcesWe_w2z1Gpqt1n5X0wuE9oD1tX6VxztUg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
To: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 23, 2025 at 1:56=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Aug 22, 2025 at 04:22:09PM +0800, Julian Sun wrote:
> > +struct wb_wait_queue_head {
> > +     wait_queue_head_t waitq;
> > +     wb_wait_wakeup_func_t wb_wakeup_func;
> > +};
>
> wait_queue_head_t itself already allows overriding the wakeup function.
> Please look for init_wait_func() usages in the tree. Hopefully, that shou=
ld
> contain the changes within memcg.

Well... Yes, I checked this function before, but it can't do the same
thing as in the previous email. There are some differences=E2=80=94please
check the code in the last email.

First, let's clarify: the key point here is that if we want to remove
wb_wait_for_completion() and avoid self-freeing, we must not access
"done" in finish_writeback_work(), otherwise it will cause a UAF.
However, init_wait_func() can't achieve this. Of course, I also admit
that the method in the previous email seems a bit odd.

To summarize again, the root causes of the problem here are:
1. When memcg is released, it calls wb_wait_for_completion() to
prevent UAF, which is completely unnecessary=E2=80=94cgwb_frn only needs to
issue wb work and no need to wait writeback finished.
2. The current finish_writeback_work() will definitely dereference
"done", which may lead to UAF.

Essentially, cgwb_frn introduces a new scenario where no wake-up is
needed. Therefore, we just need to make finish_writeback_work() not
dereference "done" and not wake up the waiting thread. However, this
cannot keep the modifications within memcg...

Please correct me if my understanding is incorrect.
>
> Thanks.
>
> --
> tejun


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

