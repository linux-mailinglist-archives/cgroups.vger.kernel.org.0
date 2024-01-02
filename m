Return-Path: <cgroups+bounces-1053-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8657982249A
	for <lists+cgroups@lfdr.de>; Tue,  2 Jan 2024 23:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2131F23790
	for <lists+cgroups@lfdr.de>; Tue,  2 Jan 2024 22:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A468B168DE;
	Tue,  2 Jan 2024 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuwWQcu7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D6F17743;
	Tue,  2 Jan 2024 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so5934696f8f.1;
        Tue, 02 Jan 2024 14:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704233630; x=1704838430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mO6XebmqdF5n6gT+avY0yL7UnfUFBRrIUEgVS3y8Y1g=;
        b=MuwWQcu7TV354UHK/dW++VfRGH7pfOXgjdUmRE/y9Llpco84nzwf9xNtMeWg7wVNPY
         TqQJXunGy9kDtLwBzBc3Mmfyu2ykbyQ8ZtX0dgx2OYZjIbA7HeokMibf0zyEWKly741F
         9hWpd2ATev3QKV/k6hptArO7gjBX4nnLE87IRMS9EDrt50anxJKFNCi5Cvu0QeVlqcOt
         Js9mhb/TEBwVfXfjxS0/BYGYavhmgxcxEGFGkThYgfV0urA47h8hLIzqtTva3jQPPUjq
         ZaXrwA+XOJYY8sVfs7RmqHOLp0Xub4Onjwt0hCxlmu6VqqeFXIF43t0dNt68xEkSyr4B
         1x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704233630; x=1704838430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mO6XebmqdF5n6gT+avY0yL7UnfUFBRrIUEgVS3y8Y1g=;
        b=B0F3xjYGV5IBYh6NC7kZWet77a9G0Mj5yK0zPFcpChWJe2BYkw50Aln4KDbzKuf5ud
         YOqDdERGd2Y///1BDGROoHZeIZSC5hd/wJxn4HWQpsfZAf24dzY9+SauLFMLVEyVZJWg
         fDZ4p5V/DcZmjh/IzcjdpuYPzqMPjX2o2qANo8JCsBarX+6m4ft5W6Aam30W86ig4A0h
         tf1F3k4rZSYYt91E5Yb+uAmdz9Me/d6jgpLQAJtrVxcNJ93qH9ORJF0IjBlCzegcUgh6
         9zjwU1vx/3Q9VsAZJMTD2Ak1imtJRQ1cN7nEuglLPaDhxdtDoF9HHSqEjkTB5ykApTZ6
         TpUg==
X-Gm-Message-State: AOJu0YxH3/fc6ZPc+V8BWju1Tef7xb4RC6pRdtyJl33sbpHQmKkI1+2o
	Dgy6z1TiDoP5nV3TgDDLcFGXsVwxq+yV9Py9wCE=
X-Google-Smtp-Source: AGHT+IHmWxIwetL6s0CPOugm22RrLj9syYOjOHnsC1ph5XPduxZALQyWtL65srekpH2svnp5WA3oS9qGBvPLWyivxfU=
X-Received: by 2002:a05:600c:a56:b0:40c:6eda:93a6 with SMTP id
 c22-20020a05600c0a5600b0040c6eda93a6mr4702278wmq.43.1704233629693; Tue, 02
 Jan 2024 14:13:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222113102.4148-1-laoar.shao@gmail.com> <20231222113102.4148-3-laoar.shao@gmail.com>
In-Reply-To: <20231222113102.4148-3-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jan 2024 14:13:37 -0800
Message-ID: <CAEf4BzbvPFYx3JpUaKnpG=HaNheQkJbUfaTd=DW0GbYi4A-A7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Add bpf_iter_cpumask kfuncs
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, bpf@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 3:31=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Add three new kfuncs for bpf_iter_cpumask.
> - bpf_iter_cpumask_new
> - bpf_iter_cpumask_next
> - bpf_iter_cpumask_destroy
>
> These new kfuncs facilitate the iteration of percpu data, such as
> runqueues, psi_cgroup_cpu, and more.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/cpumask.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++=
++
>  1 file changed, 48 insertions(+)
>
> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index 2e73533..4ae07a4 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -422,6 +422,51 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpum=
ask *cpumask)
>         return cpumask_weight(cpumask);
>  }
>
> +struct bpf_iter_cpumask {
> +       __u64 __opaque[2];
> +} __aligned(8);
> +
> +struct bpf_iter_cpumask_kern {
> +       struct cpumask *mask;
> +       int *cpu;
> +} __aligned(8);
> +
> +__bpf_kfunc u32 bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, struct=
 cpumask *mask)
> +{
> +       struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> +
> +       kit->cpu =3D bpf_mem_alloc(&bpf_global_ma, sizeof(*kit->cpu));

why dynamic memory allocation of 4 bytes?... just have `int cpu;`
field in bpf_iter_cpumask_kern?

> +       if (!kit->cpu)
> +               return -ENOMEM;
> +
> +       kit->mask =3D mask;
> +       *kit->cpu =3D -1;
> +       return 0;
> +}
> +
> +__bpf_kfunc int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it)
> +{
> +       struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> +       struct cpumask *mask =3D kit->mask;
> +       int cpu;
> +
> +       cpu =3D cpumask_next(*kit->cpu, mask);
> +       if (cpu >=3D nr_cpu_ids)
> +               return NULL;
> +
> +       *kit->cpu =3D cpu;
> +       return kit->cpu;
> +}
> +
> +__bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it)
> +{
> +       struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> +
> +       if (!kit->cpu)
> +               return;
> +       bpf_mem_free(&bpf_global_ma, kit->cpu);
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_SET8_START(cpumask_kfunc_btf_ids)
> @@ -450,6 +495,9 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpuma=
sk *cpumask)
>  BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
> +BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)
> +BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL | K=
F_RCU)
> +BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
>  BTF_SET8_END(cpumask_kfunc_btf_ids)
>
>  static const struct btf_kfunc_id_set cpumask_kfunc_set =3D {
> --
> 1.8.3.1
>

