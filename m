Return-Path: <cgroups+bounces-7192-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBF8A6A0F2
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 09:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A91462AA0
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AAF209695;
	Thu, 20 Mar 2025 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpLMDD28"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF5C1E7C23;
	Thu, 20 Mar 2025 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458183; cv=none; b=lZJa7BcojtFCoT+M4McJaWYYiLeEr9Wj4yvoFpen5YaCYO5o3I0DSSEAHcnYiUKmKKm6r70yjjnvqz2ZYF9b22yPiMlvPraow2YEJAsha5PmbUCNb3ArQ3CGOgOGPKq6f5dkIw0MvmxgeUp5BxK5J9e9JEi+YXewcJWSWK+Ph9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458183; c=relaxed/simple;
	bh=JMhkC/qzy7CJY247FAczSaMR9th3O24RtFPlon4S9k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6XphAz3tgydVUQYTs9zWqczXwhjVE6sVeyY2RjheXQX9Jz4ZHACpJxVy8SsO6qUdoAlfjiiVOWP5PnTrLAf797yRdug/kZS77Mnyi/P2Dl9ceBwG2gd3EjGcHOiWL6sFFe87z8aTVz3uP4VnbOJdqSuDCWQex32Ij38uK6wSZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpLMDD28; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff80290e44so1060159a91.0;
        Thu, 20 Mar 2025 01:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742458180; x=1743062980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JMhkC/qzy7CJY247FAczSaMR9th3O24RtFPlon4S9k4=;
        b=BpLMDD28q6FfdptARc3ZyhkUN3WE/jwtx5No8PkEQPesXtvGHxPFlpotoSqRcOstm9
         xecUrdvSJQwKmTESFaKLYGOfrxBZQ6MbDZGeoX4ySMNxOMAVdvt+3vxsZp2VzQ4qJwVk
         JBy3nU6rjn6vZYeb8jAl4NC7WHF5UtWA454Nrv5j9kO3PsygBPHyELh73Id+eZyDb3f3
         ia+KGjfKE5b6yCcr09q9QeYULYIh+H7z3L5RGtJeVCSnkbcOhpZ6fIVsBbIGU0h2dQH6
         6SijttiAgUSaIeGI1XoxjUAJCMjHUFKOaAGCQSm0oy7c5H5rkz/5Zqnxom//fbPm24X6
         K2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458180; x=1743062980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMhkC/qzy7CJY247FAczSaMR9th3O24RtFPlon4S9k4=;
        b=K5Nv5Nj732TIZfbWFh+JwYyoFbHR1Xokjwo2zhby0vIy1lAoTpjkD23cTQuPGjs5NP
         uDLmM1tVznBEwKCc75YKQU4HFgsGc8DzVtwuegg4rX8JQbqoy/Puzgz9i1uVwx8FFkb7
         8z1oqvM57+vxZATiSm7giGotgPOUsTg+gWPygz7RPZcdHjNs1BfRTRGIOP2p1puIitcg
         33wU/NqXeaGzkd/+I2fRB7OgmXs3MM4eUEOisM2UIjShVxSpbknEs7GwJXALePYWJ0Zq
         Ye5pwuU03ySSjBMJYhgdtJEglYQw5NeMqQUZI1wzCp+zaEsuHn7rpYZIeQb2ZXWGx9KS
         Ob0w==
X-Forwarded-Encrypted: i=1; AJvYcCUVtOBfFhBp0x+DhMjYV0VxK1NBj9WxD1Id5THpRJxe4c3Q60fP6XaR+76G66QygwXpOa+xR0I7OrZfpBR3@vger.kernel.org, AJvYcCVkKTI2B0/5KYHoKBMB3exyP2J0Q/c1TvyzPpZHs0zhvzbofxsj38yDT9MI9VmtzxSEXrHLn8O5@vger.kernel.org
X-Gm-Message-State: AOJu0YyP6N26dlirrTQp7K+J5Ds/3CijHQAwPqycb/XlJ7GBYSqYYuzQ
	CmujUZ3nk8qaJndQZu2x8z9lrOqpZvdWhGj4tfVQ3U03P5l77c2bUv9erlVT8rY3Nh8R+0/QCTB
	RKNcJFLZSV4sL5j9YPQgPPPUkl6x8/Tg+uuk=
X-Gm-Gg: ASbGncu6g6p/JCM9dem6LBsKirH+xhrpUJ2KBYzgmej1p/Uv2PNqxqojLUKTkqT8DnP
	7pXRM/sOKyCyNPOsVfGlegPKE3+i4nooQC09Eqno+bTjkDB7ZtMDm5t4YM5TKEmD7c3au2oOzXw
	q6zHzjjseFAa7YDRtbbHE0DErvlw==
X-Google-Smtp-Source: AGHT+IEQiTKOt2LMSqy3PQHK3F1M7BdfLFWEHQ4J+Jl93iXKf+ApncxDTs9g4rgwDvOjOKsh5oKBLX2x98Ctz5xOddg=
X-Received: by 2002:a17:90b:5285:b0:2fc:c262:ef4b with SMTP id
 98e67ed59e1d1-301bdf93e0cmr10361659a91.18.1742458180445; Thu, 20 Mar 2025
 01:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com> <20250319193838.GE1876369@cmpxchg.org>
In-Reply-To: <20250319193838.GE1876369@cmpxchg.org>
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Thu, 20 Mar 2025 16:09:29 +0800
X-Gm-Features: AQ5f1JrZZEoKedaMtWNsJLn9ST0hUA5wF5GIy5JQ7u50GlSaaHdntRsri3F9-y8
Message-ID: <CAJqJ8ig7BrPp0H3Lzbd0u9R6RhS5V0-i3b4eMWf+4EhujRU-jw@mail.gmail.com>
Subject: Re: [RFC 0/5] add option to restore swap account to cgroupv1 mode
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, kasong@tencent.com, 
	Zeng Jingxiang <linuszeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 03:38, Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Mar 19, 2025 at 02:41:43PM +0800, Jingxiang Zeng wrote:
> > From: Zeng Jingxiang <linuszeng@tencent.com>
> >
> > memsw account is a very useful knob for container memory
> > overcommitting: It's a great abstraction of the "expected total
> > memory usage" of a container, so containers can't allocate too
> > much memory using SWAP, but still be able to SWAP out.
> >
> > For a simple example, with memsw.limit == memory.limit, containers
> > can't exceed their original memory limit, even with SWAP enabled, they
> > get OOM killed as how they used to, but the host is now able to
> > offload cold pages.
> >
> > Similar ability seems absent with V2: With memory.swap.max == 0, the
> > host can't use SWAP to reclaim container memory at all. But with a
> > value larger than that, containers are able to overuse memory, causing
> > delayed OOM kill, thrashing, CPU/Memory usage ratio could be heavily
> > out of balance, especially with compress SWAP backends.
> >
> > This patch set adds two interfaces to control the behavior of the
> > memory.swap.max/current in cgroupv2:
> >
> > CONFIG_MEMSW_ACCOUNT_ON_DFL
> > cgroup.memsw_account_on_dfl={0, 1}
> >
> > When one of the interfaces is enabled: memory.swap.current and
> > memory.swap.max represents the usage/limit of swap.
> > When neither is enabled (default behavior),memory.swap.current and
> > memory.swap.max represents the usage/limit of memory+swap.
>
> This should be new knobs, e.g. memory.memsw.current, memory.memsw.max.
>
> Overloading the existing swap knobs is confusing.
>
> And there doesn't seem to be a good reason to make the behavior
> either-or anyway. If memory.swap.max=max (default), it won't interfere
> with the memsw operation. And it's at least conceivable somebody might
> want to set both, memsw.max > swap.max, to get some flexibility while
> excluding the craziest edge cases.

Hi Johannes,

If both memsw.max and swap.max are provided in cgroupv2, there will be some
issues as follows:
(1. As Shakeel Butt mentioned, currently memsw and swap share the page_counter,
and we need to provide a separate page_counter for memsw.
(2. Currently, the statistics for memsw and swap are mutually
exclusive. For example,
during uncharging, both memsw and swap call the __mem_cgroup_uncharge_swap
function together, and this function currently only selects a single
counter for statistics
based on the static do_memsw_account.

As mentioned above, this patch set considers the approach suggested by Roman
Gushchin[1], which involves switching to cgroupv1 behavior through a
configuration
option, making it easier to implement.

Link: https://lore.kernel.org/all/Zk-fQtFrj-2YDJOo@P9FQF9L96D.corp.robot.car/
[1]

