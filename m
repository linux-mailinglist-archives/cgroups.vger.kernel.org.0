Return-Path: <cgroups+bounces-1010-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E2981D7B4
	for <lists+cgroups@lfdr.de>; Sun, 24 Dec 2023 04:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D133C1C20B35
	for <lists+cgroups@lfdr.de>; Sun, 24 Dec 2023 03:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAC7815;
	Sun, 24 Dec 2023 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWohQv3v"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08881807;
	Sun, 24 Dec 2023 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67f9f6ca479so14230326d6.3;
        Sat, 23 Dec 2023 19:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703387165; x=1703991965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc/EeFNStAM4HFXgIrM213r5l5ThELoA39vc46XZGRI=;
        b=gWohQv3v2aMOh4PjYxIbFoOKLkOK/9IFIdF1qzik8yAHjiUPG4sMdxVr0TahfUW/Gv
         8xzJ4UGs9F5h8tADEpZLZOw/oqaQpOHafvAKbJYqGlar8nfzswgj2e2IAcND5RjijRym
         ksp0GOS1T02CmsGUYhoxcr3Doy9YZZM5fMRBDvQpl2FtADfeZ9NHie5aH00oGNtHJWDM
         bhUOErXjxaqhRLfljCPrVbnlYKkjR0mh8LZZaMA6ehyEiqafTv5KC2ioJrKLlnrCjiHv
         lwf8w7ASQixF369rxFsX0wymDOFltDPVuA6ib/a8Y5TQ4TDwYHLfhMl3A0TyT5kmehi6
         iSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703387165; x=1703991965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mc/EeFNStAM4HFXgIrM213r5l5ThELoA39vc46XZGRI=;
        b=wlUBOOuQTRKnk7Eg/LdjLpGXrqJ5lnw/ENKKlaw37sd8t1I7iDQq3XHY397LTuAxOa
         yT5zqGUSXTW3ERgsUUC3PchdvdugMp904C7/tk1cKwz6jbzll9OqpqSxT70dWpFALPcE
         bAk9Pz0ZKdTF2A4TWdgPkTY8Hz8Int4sUNSL5NSiT4O+qhZ6ppT/UTB70KYuCYJ1BtzH
         pQI3XnbR9QQbTcPHpdotukAzTWyHrRJHX0TzpqpmlOywRT8LWGfSF7EKw3zMmhIs3MGK
         1gHQkiMB5vE+mEDrCN1Hc6MyrJy3zmGWg73qjRwQBJskIGC+xLrYmkFc2cGsUh/sODWx
         dTzg==
X-Gm-Message-State: AOJu0YxfXkgH3rKAKE9JqJumMcT+MlX1aAWsjLBoCo9LjhzwHVluhz6m
	Z/64c/bsAS3FMAWo0AmedYRWt/MDNrogqC7Iyuc=
X-Google-Smtp-Source: AGHT+IEEyWCdWAuBK7cbHsicQYN8oRq1dhivALElKXV5f4qHElk0L1NQ6MSjuSQpbc+EP/xy+qBnrcT8V8H3O7JA3IM=
X-Received: by 2002:a05:6214:d4f:b0:67f:47a8:84cd with SMTP id
 15-20020a0562140d4f00b0067f47a884cdmr6996207qvr.36.1703387164739; Sat, 23 Dec
 2023 19:06:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222113102.4148-1-laoar.shao@gmail.com> <20231222113102.4148-4-laoar.shao@gmail.com>
 <ZYXMns6PV1byBWtg@mac.lan>
In-Reply-To: <ZYXMns6PV1byBWtg@mac.lan>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 24 Dec 2023 11:05:28 +0800
Message-ID: <CALOAHbDGTgGfxtnWGP32M7Brt86ezh9g7gywNyU_R3ttv6r=fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Add new kfunc bpf_cpumask_set_from_pid
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, bpf@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 1:51=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Dec 22, 2023 at 11:31:01AM +0000, Yafang Shao wrote:
> > Introducing a new kfunc: bpf_cpumask_set_from_pid. This function serves=
 the
> > purpose of retrieving the cpumask associated with a specific PID. Its
> > utility is particularly evident within container environments. For
> > instance, it allows for extracting the cpuset of a container using the
> > init task within it.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ...
> > +__bpf_kfunc bool bpf_cpumask_set_from_pid(struct cpumask *cpumask, u32=
 pid)
> > +{
> > +     struct task_struct *task;
> > +
> > +     if (!cpumask)
> > +             return false;
> > +
> > +     task =3D get_pid_task(find_vpid(pid), PIDTYPE_PID);
> > +     if (!task)
> > +             return false;
> > +
> > +     cpumask_copy(cpumask, task->cpus_ptr);
> > +     put_task_struct(task);
> > +     return true;
> > +}
>
> This seems awfully specific. Why is this necessary? Shouldn't the BPF pro=
g
> get the task and bpf_cpumask_copy() its ->cpus_ptr instead?

Good point. I missed the bpf_cpumask_copy().  Will use it instead.

--=20
Regards
Yafang

