Return-Path: <cgroups+bounces-1319-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5C6847C1D
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 23:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22281C25512
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 22:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129A683A1E;
	Fri,  2 Feb 2024 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vWeElyYh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2639783A07
	for <cgroups@vger.kernel.org>; Fri,  2 Feb 2024 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912041; cv=none; b=N6zb8LQwefTo04Yb5Z9sqcpdcyYMsW8xzsVuNMThB+4H12yiei/P31i+bhpt2Hj8EwtviqR1Vw4R5njEjeAVe4Gjo3EM4zNNc+OFzX62sFxu3UfoED9Vz2602CGkD3WGqUG0SQ2Hc3mhLe5i3N2ArA1vZLaaoXtV8a7ZTs9vnHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912041; c=relaxed/simple;
	bh=uakkg+P5WZApE2CGW5Rx/phDYX1aiInRTjo8IrPh7ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5g6h2BSM3pEduV+af9obIlxHSsHQcwlOFw7SQYrPs24KfvpatPcvUREK01viCQOeE24JkWMki0pf3T5pR0UJXZ4+U2V6YLZPzKHxEq2H5+SBdnXjixual59yiOyyR4Q+cOa0iUQrijrG5KS2lzLmwxmcemKIDzZv/cNjQsrtQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vWeElyYh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a35b32bd055so331555866b.2
        for <cgroups@vger.kernel.org>; Fri, 02 Feb 2024 14:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706912038; x=1707516838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+G3qsUqxSh8vhcK2EdRaK7Ujc+gblwEexIg3qjIpso=;
        b=vWeElyYhS/+Zg5Ib6J+eUAOaJ7yvcSz9K1EFRCL7xDGuut6Tvh9intVnmNvfFUgx3V
         RzOwh6Uu/EXp8d1CzAczv9blIdB1A/q0ppHxDpix1WZahJ74NvLqdG1/Y4q2sFQWFSna
         pdapnnZgq6SUHa6FyQk3nKbLSHT+JS+NgguCnrGaZjn5rQebNwBgWxVlyXNZsKlSiG1c
         KjdHTPHME7OgsKu7v7BWhYoPm2ajXO7vXECyeTUJGVrBXFd4KemW7YpSG14EBlBdDEfD
         BjeRAlJtX77I72UezZDD0LDueiiLMVWBqz/J8LOGHTDUaaR6Sz4YIbRuUv5EEF5t9PzR
         ZDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706912038; x=1707516838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+G3qsUqxSh8vhcK2EdRaK7Ujc+gblwEexIg3qjIpso=;
        b=FZsMYYwm7HKhuFKlV4ieCRHkLG2t3TNY04zFBKlckMfpGtCOchPsrtW6r1Y4RXR4Pq
         NV7vnBoePf4jK8n2X8mmOetOZxJFtzmXIqLmXsk7+Q1B1bklHjI9CizPMUHFA+4N6eRo
         3E29hZGo+5CBDye1jb+cRWEwvV3MX4wwHmgE316QQdXo/oY0cT07pST2IyB0uXsHc9Jj
         FZmcXNQ6aEhJjRvcG+d0jpgVaAyZKoPK4/xcrKNQOFPmcCNX0IJcoPiEWuLVudIOB+8Q
         A+AwLdgCSesvXHQoMKVCknzs0UFWiaHh6piJenqTlEnv0lq8Ubj8fs86iPBm1h4QijPh
         Tt/A==
X-Gm-Message-State: AOJu0Yzus1wg/0Yjr7BVMlyU69SsfvMyQVb2nvDyTTbKoCAc5mAQMVAU
	hfiWlc7f/osbsqZSp7HA5uPNQ+C0zceMylFbYFGqzF4AZc9W8LctvgT+ShtVohMgBQulIWhSd/h
	e8AhU4z4MsOp8/p6fedimSM17VMQvNcFnZPLa
X-Google-Smtp-Source: AGHT+IH/CCUD/bO36uEGfiYOOZKFEyPfMKKxpr5e5aBWqRtcRoMy1RZ3L/I56cfr2K31177GI0e5bYE7tCZeazh6U8c=
X-Received: by 2002:a17:907:2da6:b0:a35:6a61:e3dc with SMTP id
 gt38-20020a1709072da600b00a356a61e3dcmr2939958ejc.16.1706912038142; Fri, 02
 Feb 2024 14:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202221026.1055122-1-tjmercier@google.com>
In-Reply-To: <20240202221026.1055122-1-tjmercier@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 2 Feb 2024 14:13:20 -0800
Message-ID: <CAJD7tkZh=M58Avfwx_D+UEXy6mm18Zx_hVKn8Gb8-+8-JQQfWw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg: Use larger batches for proactive reclaim
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com, yuzhao@google.com, 
	mkoutny@suse.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 2:10=E2=80=AFPM T.J. Mercier <tjmercier@google.com> =
wrote:
>
> Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive
> reclaim") we passed the number of pages for the reclaim request directly
> to try_to_free_mem_cgroup_pages, which could lead to significant
> overreclaim. After 0388536ac291 the number of pages was limited to a
> maximum 32 (SWAP_CLUSTER_MAX) to reduce the amount of overreclaim.
> However such a small batch size caused a regression in reclaim
> performance due to many more reclaim start/stop cycles inside
> memory_reclaim.
>
> Reclaim tries to balance nr_to_reclaim fidelity with fairness across
> nodes and cgroups over which the pages are spread. As such, the bigger
> the request, the bigger the absolute overreclaim error. Historic
> in-kernel users of reclaim have used fixed, small sized requests to
> approach an appropriate reclaim rate over time. When we reclaim a user
> request of arbitrary size, use decaying batch sizes to manage error while
> maintaining reasonable throughput.
>
> root - full reclaim       pages/sec   time (sec)
> pre-0388536ac291      :    68047        10.46
> post-0388536ac291     :    13742        inf
> (reclaim-reclaimed)/4 :    67352        10.51
>
> /uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
> pre-0388536ac291      :    258822       1.12            107.8
> post-0388536ac291     :    105174       2.49            3.5
> (reclaim-reclaimed)/4 :    233396       1.12            -7.4
>
> /uid_0 - full reclaim     pages/sec   time (sec)
> pre-0388536ac291      :    72334        7.09
> post-0388536ac291     :    38105        14.45
> (reclaim-reclaimed)/4 :    72914        6.96
>
> Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive =
reclaim")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

LGTM with a nit below:
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

>
> ---
> v2: Simplify the request size calculation per Johannes Weiner and Michal =
Koutn=C3=BD
>
>  mm/memcontrol.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 46d8d02114cf..e6f921555e07 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6965,6 +6965,9 @@ static ssize_t memory_reclaim(struct kernfs_open_fi=
le *of, char *buf,
>         while (nr_reclaimed < nr_to_reclaim) {
>                 unsigned long reclaimed;
>
> +               /* Will converge on zero, but reclaim enforces a minimum =
*/
> +               unsigned long batch_size =3D (nr_to_reclaim - nr_reclaime=
d) / 4;
> +
>                 if (signal_pending(current))
>                         return -EINTR;
>
> @@ -6977,7 +6980,7 @@ static ssize_t memory_reclaim(struct kernfs_open_fi=
le *of, char *buf,
>                         lru_add_drain_all();
>
>                 reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
> -                                       min(nr_to_reclaim - nr_reclaimed,=
 SWAP_CLUSTER_MAX),
> +                                       batch_size,
>                                         GFP_KERNEL, reclaim_options);

I think the above two lines should now fit into one.

