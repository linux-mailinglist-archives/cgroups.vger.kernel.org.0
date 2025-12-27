Return-Path: <cgroups+bounces-12778-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA252CE007A
	for <lists+cgroups@lfdr.de>; Sat, 27 Dec 2025 18:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A43230213F8
	for <lists+cgroups@lfdr.de>; Sat, 27 Dec 2025 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F3B22578A;
	Sat, 27 Dec 2025 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+hZOtrM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74120335BA
	for <cgroups@vger.kernel.org>; Sat, 27 Dec 2025 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766857832; cv=none; b=Y3bEff1swNbCQF8RAFssHBe+/5QLYhKkyuo4ZxrJVzdASLgfR8OwOEHNrHgbo3KYrG4xC5C0ZVXFG2OZ3tZWMh+ZmrL8UQsOn11dAVwXUhEDXfXP/+kQHJ1f+8seiY1rtIhLkOXdUJGcjyDdrhlSTDp61bUeIrW/FPUirhA4Zho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766857832; c=relaxed/simple;
	bh=mOrKFdy9550WIYMUm0xDARXdKVKOJHA4toCYLC89Bbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jln/Kefd/jwd7ZyU88dFgXM5f+zTpnGNe3YIwfRgLqXbpwogUsjtRYNoLfipBJJOnmBprZoewsYJZGGpwTNucZ140SyPKUny8v5ZEq5dARVW47ueIT7oVh97Zjen/uUjK3aD8g1sEYCOvS1gUlfWZAsd1M3oT+AUltEZgfLAkf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+hZOtrM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b79af62d36bso1372879566b.3
        for <cgroups@vger.kernel.org>; Sat, 27 Dec 2025 09:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766857829; x=1767462629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WL14hCGzkiqmAvKmCU+thkeYezwIsMSVDEfVrt3GJis=;
        b=F+hZOtrMVY0jzdQh8nsTVOIpKPDKhrZmMqAd/7nC24boBxb750C14aupy3uRbEoqLV
         0+KpnY3PtWxOgPByMmoacSg1HMay4G06vWW0zNaSlvpnv9eSj/bcyHYtRSeCAcfN1Azb
         A/3PPcrfz9KCkOWl9ztVSDVdUReucR/mCsMiD4jo3zQbzNZr+TEVd4u9CsWEUA8jPj9s
         Vp/CPqG8AHN1bcRdRiLhSDBsCN7i/1+YyQkwwghqlBKe5mf4+LSKy7am+AfwCek32x2q
         58POyPmtnlDf9HP9kHrHNnl8saUTtzUe4wByc10doL9AFOPYOeTgW/r3Vlq1mBnM+j3f
         Oc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766857829; x=1767462629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WL14hCGzkiqmAvKmCU+thkeYezwIsMSVDEfVrt3GJis=;
        b=cdQAKnNk+J2AQr3RTSpgTM85Lvi5mLOGIF3BnPJy0QJj2y/qG39Utd+zzL8vRchSHS
         cQHea09b3jTecYs9UsV9ltxJCgiHIlz93lAtoEGVv6cKtb3F/nKGEpckbCPpf2HUmCkT
         Iglk/zjUK5UQLCgS9542/FveUZQ/AIibEjZj65jStcRGvm6e1oTbxX7RgnFFckzLnzwJ
         lrfIduyzwKYQ/2wKF4JyzdgqafKMrLSA7tzFZ+szAKXOZsrQqRZxrBhvV5Zl8Kam4bbN
         6tkbWJKLgs8X1ArTqw5y8wfbSYpFTVh/hSS4j6ZNAK+yPHKrK8SGd/EWfSvkEGLBhBFr
         CrBA==
X-Forwarded-Encrypted: i=1; AJvYcCUH1JgqLcsHwTaIM8Aigr6P2n69EdaMEm7wCEM7bnTj7aEzy+zL/LUXX9jsWJHua2V8zD8DtPO2@vger.kernel.org
X-Gm-Message-State: AOJu0YyNKhNKf0xCRrDQLQ7Jze3wWQrpra+s/ekzXGlKjhfKr8UOHQq5
	NhI2glNeC9OCqODggdXLnH7u9mZIKQ5dN0Flx2BRwOYKeKxc8M4IoQagXGCjAKmHaUKsMUIrsJW
	RZ6o3PLQoDpGY6h2yg3SEg7MHf5DgQwI=
X-Gm-Gg: AY/fxX4Be9wbmvag1pSOPIbdokX/KgBC7L9EH8uMCbqDj0fPkxAOXHV8BPj8e9KEvnq
	kSPNV/9hThSSmiVetQkp/Y/ytkNyp81AUwRK8VOVjn1YD1MYVe5GlAH2kJR3IEDdvhy+/UNipos
	xsWOTzzm8h6HvhrmIZ85RNKFuHEfxRAPf3ng0Nvf3W2JeD3xknZbnnCOgf0kyIWKJ6SCWqERhI+
	kEeQc1YuJXyIn6DHkZAZM9da/Qv2Yhyc+0azyaidXPm4YbKQYRTU+PcWvfnmi7+7zFdNCE/r1kT
	q9+IwR2B3vhdkJVannVCypx9uhkQnWMz
X-Google-Smtp-Source: AGHT+IEZgbvqTOYwo3FJJfnfUezy6+2cWZ9EeFPcolMCxdO4EgAtFxeH9qjjcUEpdcjraPKWzcZMdilgj0ntgRU/07g=
X-Received: by 2002:a17:907:829a:b0:b83:246c:d125 with SMTP id
 a640c23a62f3a-b83246cd206mr560818966b.41.1766857828401; Sat, 27 Dec 2025
 09:50:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224073032.161911-1-chenridong@huaweicloud.com>
In-Reply-To: <20251224073032.161911-1-chenridong@huaweicloud.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 28 Dec 2025 01:49:50 +0800
X-Gm-Features: AQt7F2rOR-WeID-Ov1CqYlda8yYcBaRSvHcd5dFl0LZVdgzXP8wohTfuzaZzioI
Message-ID: <CAMgjq7DQmdoQKZeFjpnYQ4wgMx3j-Lu7na+Ghs_Dh=Rq36MDOw@mail.gmail.com>
Subject: Re: [PATCH -next v2 0/7] mm/mglru: remove memcg lru
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, zhengqi.arch@bytedance.com, 
	mkoutny@suse.com, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 3:56=E2=80=AFPM Chen Ridong <chenridong@huaweicloud=
.com> wrote:
>
> From: Chen Ridong <chenridong@huawei.com>
>
> The memcg LRU was introduced to improve scalability in global reclaim,
> but its implementation has grown complex and can cause performance
> regressions when creating many memory cgroups [1].
>
> This series implements mem_cgroup_iter with a reclaim cookie in
> shrink_many() for global reclaim, following the pattern already used in
> shrink_node_memcgs(), an approach suggested by Johannes [1]. The new
> design maintains good fairness across cgroups by preserving iteration
> state between reclaim passes.
>
> Testing was performed using the original stress test from Yu Zhao [2] on =
a
> 1 TB, 4-node NUMA system. The results show:
>
>     pgsteal:
>                                         memcg LRU    memcg iter
>     stddev(pgsteal) / mean(pgsteal)     106.03%       93.20%
>     sum(pgsteal) / sum(requested)        98.10%       99.28%
>
>     workingset_refault_anon:
>                                         memcg LRU    memcg iter
>     stddev(refault) / mean(refault)     193.97%      134.67%
>     sum(refault)                       1,963,229    2,027,567

Hi Ridong,

Thanks for helping simplify the code, I would also like to see it get simpl=
er.

But refault isn't what the memcg LRU is trying to prevent, memcg LRU
is intended to reduce the overhead of reclaim. If there are multiple
memcg running, the memcg LRU helps to scale up and reclaim the least
reclaimed one and hence reduce the total system time spent on
eviction.

That test you used was only posted to show that memcg LRU is
effective. The scalability test is posted elsewhere, both from Yu:
https://lore.kernel.org/all/20221220214923.1229538-1-yuzhao@google.com/
https://lore.kernel.org/all/20221221000748.1374772-1-yuzhao@google.com/

I'm not entirely sure the performance impact of this series on that,
but I think this test postes here doesn't really prove that. Just my
two cents.

