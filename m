Return-Path: <cgroups+bounces-11305-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF61C1722D
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 23:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D55E24EED2B
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 22:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8982435581F;
	Tue, 28 Oct 2025 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF+kY4sp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA52EAB83
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 22:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689288; cv=none; b=cs561d4GWz1OrCIAfvbxKloxqrXhIHwQHSkVzzr9wJ+0S+jXXUNFZ8LmyH/3gxu8v8k/Bl7VO+9mL9xTvNyEpTJweStE+6bj7niGe66a/IvRE3GyRFXx8ndZDXemviLPFK+tTrL2eJ4ZJVt87FURW8FQa7+y5MvzdvJTcdnfYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689288; c=relaxed/simple;
	bh=xxLjTcs49KVHsuBWJBp8+5TQJEuXYXCZzLvCqnDtD3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtbXu/qGMMbiyfjiwudVviydyAjjpIRJZ6JbLF6ImvAAMcIRD8nnrFNFmYpURXfff5Kprc8fMoevNTYHdTe9RyPZoeTrjWNyfIwXFXW10+sUfxIHibiO0WIKwUu+nIk/M999sbihH8TzpVX8RsKoA9pMSwyFLikJ7BywSY0UVNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lF+kY4sp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4270491e9easo5366888f8f.2
        for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 15:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761689281; x=1762294081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7V+762A1daN4J9oNjmmT69+inXV9phu8pPtP3M7FAMM=;
        b=lF+kY4spAEP0CrGbZfaCAYVN7tjQyJ5/IL8S82YAu/KyjKTunYI52v+6qy/xg2iw//
         2Pi2f7HzzYPuj1lhyuMfD8Rx2xK+JiCvtEJyPmXulM0ugiz773sMLNM4Z2uzDz0LtMQz
         R1D9Hs53WOC11wBg9ld1ltuUSCRYYkHvQMcQYu0F44xXeWnmoldnNqbTPjdDPxjuoZFc
         jeber4tOBrgqsoJ/Pcvxy6biJejoZFO5BGnMLtHxMuxh5OxB7JnnuDWextrF1tC/8s2M
         4653WgUejRDf3dfmvisPN3TAONI0sLwUwAjRtC8ZUqKPjWS8ZxYKQziRHPSMuCOOvEYA
         +xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761689281; x=1762294081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7V+762A1daN4J9oNjmmT69+inXV9phu8pPtP3M7FAMM=;
        b=pue8QSwm5yCH5GfANgSLSR+WrMnDKN0hQEBs4RMX6jtO4o9xYqzc0r1ggUciAwPaJ1
         biwWsOoX9+4YvndqWqyyon1i6yaHQ92JCsWIA4fL47hjsgzYtaScz6OVK6u5OVeyVKGT
         yWDdK+tBJj4ZWRxoysVd67Hl1TEdgC0ba9bZmtm3rxQepzeH9Oe/m2o8xXf38mvnv3Bd
         Os1rJQgJR8M8etr7hVcQMucaBJxQ8fnbIhKMC2jdvX4gnNpAEPrX1TPM1KY1yj0uLzsD
         TkdP6f6z/AMuM6TLahuDlg28qjBxJ2IWja2qYALPdMgUl15HGgGCZ9nXM7MaGAPYTkOy
         iaWA==
X-Forwarded-Encrypted: i=1; AJvYcCVdk8EvN0fYsG7NoxaAOsYK1HVpWISH99ozjZywxfltdTRVeEBbtqC9Mhkuht9NjRurTOV+KWc1@vger.kernel.org
X-Gm-Message-State: AOJu0YwP43+A82uqtZysd9fZTWNpBEjROpqqX+vszMnIHf+qXkRvu7Cm
	mS6FVC3N1rq7tIWnuZP7fLnuCYm7eW3gk4LzTAvHxMdlMP9jx7d0QZchK89P9CZBRUgEwNex5t0
	GeGnFDzo/W7GAUBpFpgAb/uSewYqUvYQ=
X-Gm-Gg: ASbGncuWMKmWmNbginhCAi5GsFY1iF158pWKeGXcmaUrHYQMagvDAUUuSpRCqiBpinJ
	NPd3nimLDIGCmFYwqCR9e7kTRkutYbq4jH2A0rtQKm9CcEhAX+w1ZYp8DR1SifKkOkhmkTalWP0
	8DEaPlZVOFuDY09UOxi30bV+Y/nQoFIOgXAGHoZbOtgE5PIPsLebyRmM+SnP4dP6On9QkOU2oM+
	XWIFOupuBYga53SEQ9dQO60qSSY20sFM1BfZqRg7ed9aC1SecXL23dV7oEwpjAxK/ms06tMBnit
	LRnBOH6SlcTumEQWAA==
X-Google-Smtp-Source: AGHT+IGICaO3BvlkXeLb+EbVNUOXQ0U63xZwGPTFrBoahOPE5MZiS6EG5jxPBtr1ZSjP3nUamu+JhVo3r42lsbR/Cqg=
X-Received: by 2002:a5d:5849:0:b0:426:ff7c:86d3 with SMTP id
 ffacd0b85a97d-429aef78c90mr552970f8f.13.1761689280869; Tue, 28 Oct 2025
 15:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-7-roman.gushchin@linux.dev> <CAADnVQKWskY1ijJtSX=N0QczW_-gtg-X_SpK_GuiYBYQodn5wQ@mail.gmail.com>
 <87qzumq358.fsf@linux.dev>
In-Reply-To: <87qzumq358.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 Oct 2025 15:07:49 -0700
X-Gm-Features: AWmQ_bn1qYp03A-J3vHinawzwNNuHcAYrjS8vVp0NbrkX9UuC4qoOTSYxLLTXTE
Message-ID: <CAADnVQ+iEcMaJ68LNt2XxOeJtdZkCzJwDk9ueovQbASrX7WMdg@mail.gmail.com>
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

On Tue, Oct 28, 2025 at 11:42=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Mon, Oct 27, 2025 at 4:18=E2=80=AFPM Roman Gushchin <roman.gushchin@=
linux.dev> wrote:
> >>
> >> +bool bpf_handle_oom(struct oom_control *oc)
> >> +{
> >> +       struct bpf_oom_ops *bpf_oom_ops =3D NULL;
> >> +       struct mem_cgroup __maybe_unused *memcg;
> >> +       int idx, ret =3D 0;
> >> +
> >> +       /* All bpf_oom_ops structures are protected using bpf_oom_srcu=
 */
> >> +       idx =3D srcu_read_lock(&bpf_oom_srcu);
> >> +
> >> +#ifdef CONFIG_MEMCG
> >> +       /* Find the nearest bpf_oom_ops traversing the cgroup tree upw=
ards */
> >> +       for (memcg =3D oc->memcg; memcg; memcg =3D parent_mem_cgroup(m=
emcg)) {
> >> +               bpf_oom_ops =3D READ_ONCE(memcg->bpf_oom);
> >> +               if (!bpf_oom_ops)
> >> +                       continue;
> >> +
> >> +               /* Call BPF OOM handler */
> >> +               ret =3D bpf_ops_handle_oom(bpf_oom_ops, memcg, oc);
> >> +               if (ret && oc->bpf_memory_freed)
> >> +                       goto exit;
> >> +       }
> >> +#endif /* CONFIG_MEMCG */
> >> +
> >> +       /*
> >> +        * System-wide OOM or per-memcg BPF OOM handler wasn't success=
ful?
> >> +        * Try system_bpf_oom.
> >> +        */
> >> +       bpf_oom_ops =3D READ_ONCE(system_bpf_oom);
> >> +       if (!bpf_oom_ops)
> >> +               goto exit;
> >> +
> >> +       /* Call BPF OOM handler */
> >> +       ret =3D bpf_ops_handle_oom(bpf_oom_ops, NULL, oc);
> >> +exit:
> >> +       srcu_read_unlock(&bpf_oom_srcu, idx);
> >> +       return ret && oc->bpf_memory_freed;
> >> +}
> >
> > ...
> >
> >> +static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
> >> +{
> >> +       struct bpf_struct_ops_link *ops_link =3D container_of(link, st=
ruct bpf_struct_ops_link, link);
> >> +       struct bpf_oom_ops **bpf_oom_ops_ptr =3D NULL;
> >> +       struct bpf_oom_ops *bpf_oom_ops =3D kdata;
> >> +       struct mem_cgroup *memcg =3D NULL;
> >> +       int err =3D 0;
> >> +
> >> +       if (IS_ENABLED(CONFIG_MEMCG) && ops_link->cgroup_id) {
> >> +               /* Attach to a memory cgroup? */
> >> +               memcg =3D mem_cgroup_get_from_ino(ops_link->cgroup_id)=
;
> >> +               if (IS_ERR_OR_NULL(memcg))
> >> +                       return PTR_ERR(memcg);
> >> +               bpf_oom_ops_ptr =3D bpf_oom_memcg_ops_ptr(memcg);
> >> +       } else {
> >> +               /* System-wide OOM handler */
> >> +               bpf_oom_ops_ptr =3D &system_bpf_oom;
> >> +       }
> >
> > I don't like the fallback and special case of cgroup_id =3D=3D 0.
> > imo it would be cleaner to require CONFIG_MEMCG for this feature
> > and only allow attach to a cgroup.
> > There is always a root cgroup that can be attached to and that
> > handler will be acting as "system wide" oom handler.
>
> I thought about it, but then it can't be used on !CONFIG_MEMCG
> configurations and also before cgroupfs is mounted, root cgroup
> is created etc.

before that bpf isn't viable either, and oom is certainly not an issue.

> This is why system-wide things are often handled in a
> special way, e.g. in by PSI (grep system_group_pcpu).
>
> I think supporting !CONFIG_MEMCG configurations might be useful for
> some very stripped down VM's, for example.

I thought I wouldn't need to convince the guy who converted bpf maps
to memcg and it made it pretty much mandatory for the bpf subsystem :)
I think the following is long overdue:
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index eb3de35734f0..af60be6d3d41 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -34,6 +34,7 @@ config BPF_SYSCALL
        select NET_SOCK_MSG if NET
        select NET_XGRESS if NET
        select PAGE_POOL if NET
+       depends on MEMCG
        default n

With this we can cleanup a ton of code.
Let's not add more hacks just because some weird thing
still wants !MEMCG. If they do, they will survive without bpf.

