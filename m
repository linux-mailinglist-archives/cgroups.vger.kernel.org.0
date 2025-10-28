Return-Path: <cgroups+bounces-11301-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EA3C16876
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 19:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BC91C22071
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 18:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CB734FF60;
	Tue, 28 Oct 2025 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QEm//4JB"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C834FF4A
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676958; cv=none; b=P5sKH9EXK4pda/sxqNpkskYLKVgxYwCGUpXJMId1gA/VSXFKu3YBfO/sPIJ7Ql7Kj+SQ+URixdCZtUtVc+EwKXPyVo7lX2aSLI/vAdg5vl7LqjSL+aK2Lnk/oIyqJJ47oYE19MDLBjDIa1VDTXQr5BL3chIdtcPlnckYdr3/sE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676958; c=relaxed/simple;
	bh=goTC3AtaAi01urtiUtv3DK9rgjalng0u2KmjYfb12ks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=flR/FzIeE/jD3sbT6OSdV0nK58yAlpOB3vfZkao78bsa9/sVUlyNtJg9lao4qatT+CoLKTO02LaHtHfTiz+I9CxR0wVlJZDpHX8tpdbIYBMSvbof/yxdz8zJmtIz9STnrVoVNZv4itjp6Iek4D+jNkAJw2FFs5w/EuFlHBxcsPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QEm//4JB; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761676954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UViaiKs97AW130sd1Pv1jMx77Woc0mLfVhtIKZNEsXs=;
	b=QEm//4JBVdHkp2n7eP7X+898pDWsbWkilRRDP2Ko/YBBo6UKw+UvVX3Asjh0e0UdJCN+6S
	XOW0V2qu7Tgb+4tEk+vQISKdEdrf+L5RoaD4BtgsZDvTLR8ELwpryoEoajOe5DLGs14lF5
	fTvPlRyjeTam2lyXWMYKq7qIpjO4VBY=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  LKML
 <linux-kernel@vger.kernel.org>,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrii Nakryiko <andrii@kernel.org>,  JP
 Kobryn <inwardvessel@gmail.com>,  linux-mm <linux-mm@kvack.org>,  "open
 list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,  bpf
 <bpf@vger.kernel.org>,  Martin KaFai Lau <martin.lau@kernel.org>,  Song
 Liu <song@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,  Tejun
 Heo <tj@kernel.org>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
In-Reply-To: <CAADnVQKWskY1ijJtSX=N0QczW_-gtg-X_SpK_GuiYBYQodn5wQ@mail.gmail.com>
	(Alexei Starovoitov's message of "Tue, 28 Oct 2025 10:45:47 -0700")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-7-roman.gushchin@linux.dev>
	<CAADnVQKWskY1ijJtSX=N0QczW_-gtg-X_SpK_GuiYBYQodn5wQ@mail.gmail.com>
Date: Tue, 28 Oct 2025 11:42:27 -0700
Message-ID: <87qzumq358.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Oct 27, 2025 at 4:18=E2=80=AFPM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
>>
>> +bool bpf_handle_oom(struct oom_control *oc)
>> +{
>> +       struct bpf_oom_ops *bpf_oom_ops =3D NULL;
>> +       struct mem_cgroup __maybe_unused *memcg;
>> +       int idx, ret =3D 0;
>> +
>> +       /* All bpf_oom_ops structures are protected using bpf_oom_srcu */
>> +       idx =3D srcu_read_lock(&bpf_oom_srcu);
>> +
>> +#ifdef CONFIG_MEMCG
>> +       /* Find the nearest bpf_oom_ops traversing the cgroup tree upwar=
ds */
>> +       for (memcg =3D oc->memcg; memcg; memcg =3D parent_mem_cgroup(mem=
cg)) {
>> +               bpf_oom_ops =3D READ_ONCE(memcg->bpf_oom);
>> +               if (!bpf_oom_ops)
>> +                       continue;
>> +
>> +               /* Call BPF OOM handler */
>> +               ret =3D bpf_ops_handle_oom(bpf_oom_ops, memcg, oc);
>> +               if (ret && oc->bpf_memory_freed)
>> +                       goto exit;
>> +       }
>> +#endif /* CONFIG_MEMCG */
>> +
>> +       /*
>> +        * System-wide OOM or per-memcg BPF OOM handler wasn't successfu=
l?
>> +        * Try system_bpf_oom.
>> +        */
>> +       bpf_oom_ops =3D READ_ONCE(system_bpf_oom);
>> +       if (!bpf_oom_ops)
>> +               goto exit;
>> +
>> +       /* Call BPF OOM handler */
>> +       ret =3D bpf_ops_handle_oom(bpf_oom_ops, NULL, oc);
>> +exit:
>> +       srcu_read_unlock(&bpf_oom_srcu, idx);
>> +       return ret && oc->bpf_memory_freed;
>> +}
>
> ...
>
>> +static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
>> +{
>> +       struct bpf_struct_ops_link *ops_link =3D container_of(link, stru=
ct bpf_struct_ops_link, link);
>> +       struct bpf_oom_ops **bpf_oom_ops_ptr =3D NULL;
>> +       struct bpf_oom_ops *bpf_oom_ops =3D kdata;
>> +       struct mem_cgroup *memcg =3D NULL;
>> +       int err =3D 0;
>> +
>> +       if (IS_ENABLED(CONFIG_MEMCG) && ops_link->cgroup_id) {
>> +               /* Attach to a memory cgroup? */
>> +               memcg =3D mem_cgroup_get_from_ino(ops_link->cgroup_id);
>> +               if (IS_ERR_OR_NULL(memcg))
>> +                       return PTR_ERR(memcg);
>> +               bpf_oom_ops_ptr =3D bpf_oom_memcg_ops_ptr(memcg);
>> +       } else {
>> +               /* System-wide OOM handler */
>> +               bpf_oom_ops_ptr =3D &system_bpf_oom;
>> +       }
>
> I don't like the fallback and special case of cgroup_id =3D=3D 0.
> imo it would be cleaner to require CONFIG_MEMCG for this feature
> and only allow attach to a cgroup.
> There is always a root cgroup that can be attached to and that
> handler will be acting as "system wide" oom handler.

I thought about it, but then it can't be used on !CONFIG_MEMCG
configurations and also before cgroupfs is mounted, root cgroup
is created etc. This is why system-wide things are often handled in a
special way, e.g. in by PSI (grep system_group_pcpu).

I think supporting !CONFIG_MEMCG configurations might be useful for
some very stripped down VM's, for example.

