Return-Path: <cgroups+bounces-8249-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 450ECABA759
	for <lists+cgroups@lfdr.de>; Sat, 17 May 2025 02:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FE21BC091A
	for <lists+cgroups@lfdr.de>; Sat, 17 May 2025 00:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62654C92;
	Sat, 17 May 2025 00:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh2Cwady"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081A7BE67;
	Sat, 17 May 2025 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747441512; cv=none; b=S4avitRxVbrm4zFwRekXEMpmzk3GFYX3UQwYHLqwWKFKK15SrJGGUqLGTY1EZ1WlEYs54bJxqJgfyEhQKJ732nhAkG9Nq/svEbx6LNqVWgQisS4AR2DQwJtUEdyn3y5xvDacFup/1VZ4FEMfkrfNbgApi2JhRZK1LJDdxTgysng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747441512; c=relaxed/simple;
	bh=yHNas+zBX1TtFHbM1Y0ytAz1kHK3CF9a9C6155gaS7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuWNgsYRA7Xn3s99X6V/I4LxcXyVId1SifHcLGyh/ZadI/ifbGYLWEPh9vt32zk75PwfIU+QxDvCtVWwlTwLpWhWFw4WRwBNUB4kcFigbkwmIbWqYjyHJ7jUvpxmmBwTw8pG1YWzq684a7/x926oMOwMUpGa31tW5BWqFh44Xq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh2Cwady; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43edb40f357so19905225e9.0;
        Fri, 16 May 2025 17:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747441509; x=1748046309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oOZcroL9pDTCrImg+h0BCJtERSmMeYUbJFw/m22M8A=;
        b=eh2CwadyClH543KJlkYeRe1qfaVQaeVfpBJ+VwxThOuqp9qFM+2S4T1JbnKIQwkTEZ
         hJjtZKxULYC2Kp4A2euf9lWfvWj/DrfN+BpUK4R3DdsG/rNioCMvfjrd58ycQoc05liB
         JY82dUY3f4CcvYTpwB0s4WcvOZgtE7A0s6kjVhG8R0NNenxSvtKQn10h8S7u5WQsABVK
         GmO4DjdHzgd7x36q9ncM08d236SWkEgC6KOr9G1c5BkcDrAcHW9P/bqq39ju9OtY3q5D
         2ROQWfqfO5miCFNXnPnQuJIgRDadkBPfrx/QDpRY3BvjbKKZiYlEiKot4OT8XUfOvRTn
         gtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747441509; x=1748046309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oOZcroL9pDTCrImg+h0BCJtERSmMeYUbJFw/m22M8A=;
        b=Md3n/yde4I8nQlRFYVRYoEoDKF55oNWgllCSVK/4RU9ZP7nxg1vLLm+mur2Z50hCOt
         xgKRYgobZ+sn4Q5ysLemQU7QI2XU/8SZ3nWrJa5H0cazRMAb1JbFnUXlHn8aOrlbZ+W5
         F69WRzcPDUXhkKX09EdP9gjFnkwcyr7VpmpoWvVq905zxsniHtevbF2/+1llv0log/Fe
         kIU/EBOVCX+bgpzRwWuoVz2dPzwwPCn1au95JapjNtF9+FU5TF9NDX0TPTZ0HzXM4HfV
         oSqKITffR4j/Fr9/A8I6ARKgDtCWskszkdxYc+ID7NN5zHMvRAXCiscREmqN1tJ+LBec
         lAJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7aqG7WcgAupzCEL93DWyZ5VKbpsP/xnxwXAmfq7ZmzVKx4lbTYO0afpHTlrtL8Q3eHI1p/Xm011CAW49+@vger.kernel.org, AJvYcCWP58nGRW7/Y3axCi+1xx4K+Jp6TrwXL2v5KbtwQaGkEAktFywqZaTIoyOmPMD+OYm5cZhYxdURCg==@vger.kernel.org, AJvYcCXF4IWrLw9RZmAZfziC5IYFI98CoK6M38Prd46loGstSFuwJ1D7izbeF1ndTZ2ummoEzAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz9q07lUccozdkHnS5Z9JLkQUVOikgVF2Jk1ackxtxmd9P53Xu
	0Ui+bmi29ktXRt32rF3OxFKxoEJAW996bzOXONzzv+q8th+84TWEN8xXhlGEXZJ3Luqv1TAPGGP
	Z8FT8riB9/n1RD8iLi0pnxKVOMn1rcYw=
X-Gm-Gg: ASbGncv7ffclNZwysi0NSgIdF2N0MRcNAwXxKY5FapkwnOmRjwYLavIrK6V+WxGL91L
	yZkC3WwP+l6RtXxYtf8/ukuGAV7xZq9xELSgkxX7MnON9njgbsQ3d4BKEx4zl98jwx06et+Xoje
	P4VZlZRhioRxiY9V2SPYFE53nNTIp7kZgJQ+5Icyl7D04OZTOQho0RZT7UCNu1eQ==
X-Google-Smtp-Source: AGHT+IHDBDQOUrEVqoduv6ipIjFRPqEDCxoY3BbawJyJ71yHpe7/4KGFieaxXjUTK7EgTMViaD5tSlX97DWzKhg8ZUg=
X-Received: by 2002:a05:6000:22c1:b0:3a2:35c:4474 with SMTP id
 ffacd0b85a97d-3a35c84d725mr5415633f8f.46.1747441508907; Fri, 16 May 2025
 17:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514184158.3471331-1-shakeel.butt@linux.dev>
 <20250514184158.3471331-2-shakeel.butt@linux.dev> <22f69e6e-7908-4e92-96ca-5c70d535c439@lucifer.local>
In-Reply-To: <22f69e6e-7908-4e92-96ca-5c70d535c439@lucifer.local>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 16 May 2025 17:24:57 -0700
X-Gm-Features: AX0GCFt2-G58LKzfQ5yuhBPBvfaljiJP0swpn_ogR8ycZqKQVIHzNqom9pytzdk
Message-ID: <CAADnVQKkY+ner_ZjPK9ZO7vjyvBdDA56emmgh9+MqVzaisCWfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] memcg: memcg_rstat_updated re-entrant safe against irqs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Harry Yoo <harry.yoo@oracle.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 5:47=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> ----8<----
> From 28275e5d054506746d310cf5ebd1fafdb0881dba Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Thu, 15 May 2025 13:43:46 +0100
> Subject: [PATCH] fix
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/memcontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2464a58fbf17..40fcc2259e5f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3697,7 +3697,8 @@ static void mem_cgroup_free(struct mem_cgroup *memc=
g)
>
>  static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>  {
> -       struct memcg_vmstats_percpu *statc, __percpu *pstatc_pcpu;
> +       struct memcg_vmstats_percpu *statc;
> +       struct memcg_vmstats_percpu __percpu *pstatc_pcpu;
>         struct mem_cgroup *memcg;
>         int node, cpu;
>         int __maybe_unused i;
> --
> 2.49.0

Tested-by: Alexei Starovoitov <ast@kernel.org>

Andrew,

Please pick up Lorenzo's fix into mm-new.

