Return-Path: <cgroups+bounces-1247-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 674FE83E3E3
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 22:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C48287670
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 21:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4381324A02;
	Fri, 26 Jan 2024 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXv0mHLg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C23249F9
	for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304516; cv=none; b=Kl7Q0aRUyZ/1BEdTXnMjs4htE5RvQWSshqcpUSrgIb3xQu3YJHOA28PSQlhALSsXWRssp/vqIBqTy7Dv56QLDOH4MKBfsc6vvVRRC9SKNabkiH38bQbdSPKVAHFepWZaY+ADyFEN4nvTPM/xi+L9m4SIDprlIFDhfiy/Ng1xe48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304516; c=relaxed/simple;
	bh=YPfJESNx63f8gXc8lRLZ4SNiww8xBncvURRDWEv5tbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpnHsytD0sWvtg8VhOv0WJZnlicxjkt2UPIuUKcU0CdF1XB9k1F0YkXLEKThiZjznbzhJrP1dc0Hva3IjD1DSplYBxz+02r7LCM/xAornhU5r5zNTGh72AIzkratHPMAfA8n43jyivt5aty+WibFW9kca+fbkX0JUCsdI6Zt6jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXv0mHLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975F8C43142
	for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706304515;
	bh=YPfJESNx63f8gXc8lRLZ4SNiww8xBncvURRDWEv5tbo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MXv0mHLgFzPXzyJ+cXnF0NEHqEVMZis5J3xCyKd/vUQ+sNHMTeOvo5/UiRtp2prgn
	 3W/Ekzx29ky6ERqEG0FCD5c6Ax2AAJbBymQJM+C2XVk0rB5/CW42DI8ekyEPrBRgTJ
	 Yqww8uOrdI/9wrwSyWcdaYFXqfOdoVOyWi5kA7B2gIpzbcjEiukdn/CrhmcXkxn0Bw
	 5xB52zJNgfDqQyfu23v4p6ZkQ9QhiLlxF5utjPu5p4kRaffbFWCjmyECdEyz0Iosfj
	 ECliNn6S60owiB5Y3Dt7zuQUzi8wKpJ+RVoa08wc4iNDVH2z0tQOTXHHNP4ZS4f+TQ
	 QNW4TQCmxSN7w==
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bfd0546d60so14107539f.3
        for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 13:28:35 -0800 (PST)
X-Gm-Message-State: AOJu0YzMEf7cejPby58NXCsOdxNHsKfFNaYCzverrJsJEsJTmTeRHKzV
	h0bYVIN5cRykXVs6oN4cLj8ZZORJUKulXhS8QraNWqZgN6l1apUtH5w/JdDjiY7bqMsRRhMaIQS
	8ItirDiqKbblwqku8lr5kq1bsRvQ2DEm7hBfe
X-Google-Smtp-Source: AGHT+IGNlb8VMURjwURcB5NRJcTClkW/oSCzBM4dOU+vxLvtNdJmhdWtiahxnT4JY+ITOetdOigrlYtfxWOip3LQdxU=
X-Received: by 2002:a92:d388:0:b0:361:98e2:90b1 with SMTP id
 o8-20020a92d388000000b0036198e290b1mr437960ilo.20.1706304514841; Fri, 26 Jan
 2024 13:28:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126211927.1171338-1-tjmercier@google.com>
In-Reply-To: <20240126211927.1171338-1-tjmercier@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 26 Jan 2024 13:28:23 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPLS_1m0=4vmV8fyrQ5N6yCt-2eufBkBSF=nECsb3pU2Q@mail.gmail.com>
Message-ID: <CAF8kJuPLS_1m0=4vmV8fyrQ5N6yCt-2eufBkBSF=nECsb3pU2Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg: Don't periodically flush stats when memcg
 is disabled
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com, 
	Minchan Kim <minchan@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi T.J.

Acked-by: Chris Li <chrisl@kernel.org>

Chris


On Fri, Jan 26, 2024 at 1:19=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> The root memcg is onlined even when memcg is disabled. When it's onlined
> a 2 second periodic stat flush is started, but no stat flushing is
> required when memcg is disabled because there can be no child memcgs.
> Most calls to flush memcg stats are avoided when memcg is disabled as a
> result of the mem_cgroup_disabled check added in 7d7ef0a4686a
> ("mm: memcg: restore subtree stats flushing"), but the periodic flushing
> started in mem_cgroup_css_online is not. Skip it.
>
> Fixes: aa48e47e3906 ("memcg: infrastructure to flush memcg stats")
> Reported-by: Minchan Kim <minchan@google.com>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e4c8735e7c85..bad8f9dfc9ab 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5586,7 +5586,7 @@ static int mem_cgroup_css_online(struct cgroup_subs=
ys_state *css)
>         if (alloc_shrinker_info(memcg))
>                 goto offline_kmem;
>
> -       if (unlikely(mem_cgroup_is_root(memcg)))
> +       if (unlikely(mem_cgroup_is_root(memcg)) && !mem_cgroup_disabled()=
)
>                 queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
>                                    FLUSH_TIME);
>         lru_gen_online_memcg(memcg);
> --
> 2.43.0.429.g432eaa2c6b-goog
>
>

