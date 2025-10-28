Return-Path: <cgroups+bounces-11293-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B84C164EA
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 18:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156B3402CFA
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 17:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0E934D91E;
	Tue, 28 Oct 2025 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdEK6NOy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4432A34CFB9
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673563; cv=none; b=K0DsYtX3V3e1l2C5KNlRQSGxqG/u2HKqGm8R33YYn7nblKw6hS50oKOtvs96zXwBjSEgPcz/cySHHoZ4zKTIAnvQsy0pajsgqWFU3L/WiVqGr2nBdl+KEdxh4CEmrDrbyZscA1mLlQ5jnPzIZspzAezaddBvD5HnP5/9ue69mC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673563; c=relaxed/simple;
	bh=gB7hEkZPdK08HudRz2YuF8fv82Vq7UsDwA/HC8IHSaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8So0GpWOFjF4aCqAhM+wsQVkjtbCaadWrFt5jfb3G0N8ogAroxN8sQ8mFBirFWLEEToA7uQ6CI9I5mXBgxFfa2LGxLW2pZ95J+hSa7F5u6FEGeNruihjz0BLQieLE3f5pJYV9wyE7pLfM8vTZkZKK5MHFrBCF0FT3oqyZGJ6gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdEK6NOy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4270491e9easo5188636f8f.2
        for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761673561; x=1762278361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8o8F76IUU0UbQ0/2SRvS77TkF8M8+mUDrHHUTizJsU=;
        b=EdEK6NOyQhyKdAf7e6PzuB+lCbL2yoTMei36RwI6UkbbU9Bn14Wn2giQDD4Qkv70CJ
         lnoKa4+nqmt9+U1xSlDWwfHOJpC2utZQ5jR0iWnWv1cZtbjeDGBiELXB5s59ZTGfpUXC
         3fuureugnjV3ePzbWnHc+lRs/msS0W6pIDDPsJ7DHuVwb/wywYVV+bLtPbi26mx2gept
         xx3yJXC8ls1Egw5KEF0uDUatfRepLzuKGMZUmHmQ5QYrhckIN0PDxgdVnTM/vzo5yXFQ
         u26Oj/YT/gtuTTUMJNsClH7XtQdenszfsOrOqFpYgz6PXe3LnZqCXEYzjdmSxqlWmH9+
         gnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673561; x=1762278361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8o8F76IUU0UbQ0/2SRvS77TkF8M8+mUDrHHUTizJsU=;
        b=vSiY4LOj5+FNIP6u88oV1dv1gFD89kxiQgrvOY/OAKuPBsFpLD1FI7ZqBjTjBkAnH+
         AvUzF/Yh3rYn7TjieprAkhUC7/FK4vRkRT5tJj1pVKjUWtbPyk/a1/yjbKWHDBx56POQ
         CMUv595eOTKJkl6/s5iNH4n7fEPNmVrDDo//4i/ipfdiMhPpj+mqsyqyVcbGySxJCmri
         vbErQdyuLJJKtCqIVUfwCJ3BEUMJk3OrFH6YWlK6mtc7WL5c2uje55DAUhsay3eS5g+7
         02lHsYqEk3O8vHad9IKYVw6DE4sCRi1v++BY3EMGjOO8TRbJeJZkCjVc6TO5jR7k5Rma
         VQoA==
X-Forwarded-Encrypted: i=1; AJvYcCV6I4JrfDDhUrDh2PMPHZy0ZWs1k2Lw1ulhlPrY1b9VG6iQn3ngYmCFcD4GSuwWtTjQO3CwNK6p@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3xkQWGJZcrf1l6CefvAU1YSIwt0wPXlswqWp4c5viDd+zkyAf
	tGguTeFL41MWBgYi4zD2FqM5JOWuYs2oQ2/sCqux4x/p4bUjrWW3plEajUJC3isHKtk3ehxFKgZ
	Eez9IZFoZw9FJahQdJzkrolN0nvtkkMk=
X-Gm-Gg: ASbGncvO7IilBjo63SAfWciIet8lL008MqzdWH0xHdLNeandJt25pd9C0TF55CA9C1y
	NV5tdl7rJcwnjbBbu7KFpULp+U8zu0R5XG7PqhT1CZfqo53PbOIsRU2Ql2ya1TIl2vUXnnbIND1
	oawQDOduIdXIJJXsfLqSq7TMu+QI7+rLv55/W7/jQrDG7RSJ4u8xcz8qw7Czbv+KJeU+o2lLffc
	69siozWnVyu40YCpkHWtA3Fx6uGTy24nddxSnLjS4zK5ltdbM9l0s3LLOBXC/di0A1ZaOqsxvPF
X-Google-Smtp-Source: AGHT+IHdC935jXGEIZNQ8BYD/ANRC6JF/uyaxHO8iGt25M0BknomRTBrWpakBaxhp4hLDP8/bFuayzs/ibY+/MUNENI=
X-Received: by 2002:a05:6000:3108:b0:427:6cb:74a4 with SMTP id
 ffacd0b85a97d-429a7e7a1b0mr3757740f8f.39.1761673560565; Tue, 28 Oct 2025
 10:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev> <20251027231727.472628-7-roman.gushchin@linux.dev>
In-Reply-To: <20251027231727.472628-7-roman.gushchin@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 Oct 2025 10:45:47 -0700
X-Gm-Features: AWmQ_bncnJypaBtdt8pXLZmr8dzBy7-unV831zo2gE3qs0GF1C9pXA_M9bOiMqw
Message-ID: <CAADnVQKWskY1ijJtSX=N0QczW_-gtg-X_SpK_GuiYBYQodn5wQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:18=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> +bool bpf_handle_oom(struct oom_control *oc)
> +{
> +       struct bpf_oom_ops *bpf_oom_ops =3D NULL;
> +       struct mem_cgroup __maybe_unused *memcg;
> +       int idx, ret =3D 0;
> +
> +       /* All bpf_oom_ops structures are protected using bpf_oom_srcu */
> +       idx =3D srcu_read_lock(&bpf_oom_srcu);
> +
> +#ifdef CONFIG_MEMCG
> +       /* Find the nearest bpf_oom_ops traversing the cgroup tree upward=
s */
> +       for (memcg =3D oc->memcg; memcg; memcg =3D parent_mem_cgroup(memc=
g)) {
> +               bpf_oom_ops =3D READ_ONCE(memcg->bpf_oom);
> +               if (!bpf_oom_ops)
> +                       continue;
> +
> +               /* Call BPF OOM handler */
> +               ret =3D bpf_ops_handle_oom(bpf_oom_ops, memcg, oc);
> +               if (ret && oc->bpf_memory_freed)
> +                       goto exit;
> +       }
> +#endif /* CONFIG_MEMCG */
> +
> +       /*
> +        * System-wide OOM or per-memcg BPF OOM handler wasn't successful=
?
> +        * Try system_bpf_oom.
> +        */
> +       bpf_oom_ops =3D READ_ONCE(system_bpf_oom);
> +       if (!bpf_oom_ops)
> +               goto exit;
> +
> +       /* Call BPF OOM handler */
> +       ret =3D bpf_ops_handle_oom(bpf_oom_ops, NULL, oc);
> +exit:
> +       srcu_read_unlock(&bpf_oom_srcu, idx);
> +       return ret && oc->bpf_memory_freed;
> +}

...

> +static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +       struct bpf_struct_ops_link *ops_link =3D container_of(link, struc=
t bpf_struct_ops_link, link);
> +       struct bpf_oom_ops **bpf_oom_ops_ptr =3D NULL;
> +       struct bpf_oom_ops *bpf_oom_ops =3D kdata;
> +       struct mem_cgroup *memcg =3D NULL;
> +       int err =3D 0;
> +
> +       if (IS_ENABLED(CONFIG_MEMCG) && ops_link->cgroup_id) {
> +               /* Attach to a memory cgroup? */
> +               memcg =3D mem_cgroup_get_from_ino(ops_link->cgroup_id);
> +               if (IS_ERR_OR_NULL(memcg))
> +                       return PTR_ERR(memcg);
> +               bpf_oom_ops_ptr =3D bpf_oom_memcg_ops_ptr(memcg);
> +       } else {
> +               /* System-wide OOM handler */
> +               bpf_oom_ops_ptr =3D &system_bpf_oom;
> +       }

I don't like the fallback and special case of cgroup_id =3D=3D 0.
imo it would be cleaner to require CONFIG_MEMCG for this feature
and only allow attach to a cgroup.
There is always a root cgroup that can be attached to and that
handler will be acting as "system wide" oom handler.

