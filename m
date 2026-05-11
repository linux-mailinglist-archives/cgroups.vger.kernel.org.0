Return-Path: <cgroups+bounces-15783-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDZNDTs2AmocpAEAu9opvQ
	(envelope-from <cgroups+bounces-15783-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:04:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A93F51569D
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAD9D305C4DA
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513C43290C9;
	Mon, 11 May 2026 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJKGcV9E"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115FB2E8DEC
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529828; cv=pass; b=raa8mriCT/f+T5qBaQ6jvp30I/RpJFyHzqGrZ9YTmsL+NuNMdUcuEXntFZUSbV9NIo4UU84BWPT80O9WkwO0n7vPKTKTuDdrV1rdhsxYEv99KLhWL718MEDuvrD7Mt5GSDdgeNhmnA44MgLIEGjM4Sy1KrKPZgXJ++zL6zOFk/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529828; c=relaxed/simple;
	bh=IQoo2L8EhaJ1Fc2RW4QQ6a7gHDjPWRMIXP79pVn/Lw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoehX8Zs6I4m6NmlDadKZ7zYUpHxk8ixPcKZPByPGJdTbEB8VX8aEQAHcZWT7RFirdEz3NEeSvHtdn9/zNLuxJUg0ZYW2S7ZgIzV9URW2gGfy9S8C6W+xQkS8E1w3DGsL6o05xQUkw9vSjjBNeZQuNA4qrW9dh8dXnejXfsKW/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJKGcV9E; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-678a16429c6so7259931a12.1
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 13:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778529824; cv=none;
        d=google.com; s=arc-20240605;
        b=Rxys2fdOHLwPPEGHSLZ+qD0/VKXuMiRx2fZODBYVfOB/Gq1R+fENndt7dAHNxCF9A/
         a6NoX1hqjrDIvW/GFjxludAKfaWptkFCbQH3TZ7ePPsm3/Mxsjzj0XkRgB8ZnuIKDNVl
         nZ2wZVhdIua4FobURTfT83pUa9IAAg2XTmcytNN+AcC0TLIJVUtDhsUJNFC3CPf/O7yQ
         j4e3Xpzt2DIFmAj6LOKYvLgvXRWcOOkzR5x4ZQ7yBB6zupk2baacsc2DMt6wW9FC8sNA
         Jcf7ZF5TDexH/J1D1XQUPVMqQUVnNMkRxipiUnDOe8AjtJ857+fBFoOMFpW6g4yRGrMU
         KAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IQoo2L8EhaJ1Fc2RW4QQ6a7gHDjPWRMIXP79pVn/Lw8=;
        fh=qBE8TWSVaddSjJSwGchTmfSHXsSeuVWHsb5Vjb1EVIE=;
        b=Ie0qh5fVD4eswGmmvQ3nSOhpKFdwtM2yP+0s8t7tKrMv1laWO5wC+Og4JMIKnpwK5J
         /Em/n1KVLgclMWvMEOM/rQv1Znp1dCtAIo7QZQ/AJvo8xY7uD4ZMmj9E+/ioY1zu7L06
         H/YXfPvuYjaABk4+Sk65rcEp7iyP9RDyAV3AWs+nWv2JcXlmJnCt5o/ztiFQ62kL15Fd
         Jx14CRqKtQf4D9nLNRMpVp1j+SV9klxjJEw+dfJrBJNrokM43eGezICUfWW3wgkuhduC
         C0523ccY1fX81rZnQmm4q2T0dKj6tDd/5OYTDIHkC2VV80lq6qxd4WYdOg7Jgi4OfdqD
         RDHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778529824; x=1779134624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQoo2L8EhaJ1Fc2RW4QQ6a7gHDjPWRMIXP79pVn/Lw8=;
        b=aJKGcV9EsZUZ4OIMmYrjdtJAOGuwEYSveODmQvkq+BLT/TSj3hHuOAhsqGEI8j96qn
         0IILsxK+MEfTteMYBIJx7U8PuPWEIZEMDkHGknha8jPp+9L03cjxUkDPmBrq27zjW3Ml
         eo2DeJQ1EkALUvMOORqYv3wytjGgUeZUnQq6ObTsB6ToAPzaIEKj8Rp7HJj5hYk5000n
         BJ+wlR3jBDwaMUBwUy2rasDtAb2V42ueUoiC2FxLKjSEFT83oz6U55XC+x0ZXhcVIrgj
         cFkixbRz7zwGMnOr3wbZP2+B5rhmHERQ4oLidrO0VM11Kjr+Ch0Qy5pKaB53F5YrpUr/
         8NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529824; x=1779134624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQoo2L8EhaJ1Fc2RW4QQ6a7gHDjPWRMIXP79pVn/Lw8=;
        b=stODq8606BmDjW3kdVIdSP7+UGh+dD/R76FYKZ79koiXVgyeTwBOQOhCw3OcwwSPIO
         /butVSXSelKZma4pEB8pOWo9OV4P+JHzhoj428ze3oX9O3olwDwwIZZz3yF0uVY2RMOT
         LNcBP8YHqzoJSqZRcW7ujPlbGu6PwQ46mkz7WXyTDqnqcLDqfd+Cafgz3VmzUhiqUn7r
         cK14etqK/knI4fZlrZ2qUvO1QU4CP3pGUs4ZDPh5f4cFUbPitxCHdEtq0EKvEnL3i2qc
         Kl0FJalTqvwHw2qM5yrIFWWn+W3Kwrr1334FhdX1DtRC7JmqrNl8HqcD21SW+sXgbXlF
         Htdw==
X-Forwarded-Encrypted: i=1; AFNElJ+fSs58x+RMsrm2mkZY9GQcZCOe3FPXKDoyzoFnyHAO24hyiNl2UCBgTPIl2If/eaptv31S8E7I@vger.kernel.org
X-Gm-Message-State: AOJu0YwVnVtx7iwxmI/mVBx5ESDUnTwd1jzkSYrcZCd7uSPFohq+RhMN
	YgnQBJL3n9m+rAoY3+clpMdTbSl8ZFAIQM0L5o+867PjrUkKPipGS1cEL3DVgr1zlp6jxDNhFdg
	YLUc32LM5gOXt+VmCd+BcZBfkQ4BBocw=
X-Gm-Gg: Acq92OHSqpOw3FmVZbQZz/YMdaGauqIX29gqIieIJuzrJIEoVU7KOa1Hb4q5U1Vw5uK
	lKpu5YvFvc9xC9QBxRy69Y7QEXWK8u7ny6bDSfK78YIhRTxl6In3SbiIUUeBDI1XReYZBVYGJoj
	+HZZURTsoobqz88pLoLFVVHncmq7zdgrvkqsbSIzjyZY2uYuTkFfJOp9tvCOLAbyY7hR6PFrwCb
	B5H2GTtSf6aM+taLYj+zedejh6h74ohknbt6SvPNgrDdGvL2sCec1wMd8s40u5Pwnuh+JeiPPF/
	a3if/R6QBXkIAmB9Dgk/HPmxqZOawfl7QjxSK9uw
X-Received: by 2002:a05:6402:324d:b0:67b:7e67:7f5f with SMTP id
 4fb4d7f45d1cf-680b360118fmr374089a12.9.1778529823702; Mon, 11 May 2026
 13:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423203445.2914963-1-joshua.hahnjy@gmail.com> <3ff8b23a-479d-46e8-b820-a23697587f01@kernel.org>
In-Reply-To: <3ff8b23a-479d-46e8-b820-a23697587f01@kernel.org>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Mon, 11 May 2026 22:03:32 +0200
X-Gm-Features: AVHnY4K1a6nMigh3_903jx2K6M9LAk--_V64cSO-XxSGUFqXFVJ32lwBtBHSK00
Message-ID: <CAN+CAwPK4cW6k6LazZsbuvewswOwzM8VJgPvcg0jef7FwfF1qg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9 v2] mm/memcontrol: Make memory cgroup limits tier-aware
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Koutny <mkoutny@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Muchun Song <muchun.song@linux.dev>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Kaiyang Zhao <kaiyang2@cs.cmu.edu>, 
	David Rientjes <rientjes@google.com>, Yiannis Nikolakopoulos <yiannis@zptcorp.com>, 
	"Rao, Bharata Bhasker" <bharata@amd.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9A93F51569D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15783-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,cmpxchg.org,suse.com,linux.dev,linux-foundation.org,tencent.com,oracle.com,google.com,huaweicloud.com,gmail.com,redhat.com,lge.com,cs.cmu.edu,zptcorp.com,amd.com,vger.kernel.org,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 5:56=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 4/23/26 22:34, Joshua Hahn wrote:
> > INTRODUCTION
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Memory cgroups provide an interface that allow multiple works on a host=
 to
> > co-exist via weak and strong memory isolation guarantees. This works, b=
ecause
> > for the most part, all memory has equal utility. Isolating a cgroup=E2=
=80=99s memory
> > footprint restricts how much it can hurt other workloads competing for =
memory,
> > or protects it from other cgroups looking for more memory.
> >
> > However, on systems with tiered memory (e.g. CXL), memory utility is no=
 longer
> > homogeneous; toptier and lowtier memory provide different performance
> > characteristics and have different scarcity, meaning memory footprint n=
o longer
> > serves as an accurate representation of a cgroup=E2=80=99s consumption =
of the system=E2=80=99s
> > limited resources. As an extreme example, a cgroup with 10G of toptier
> > (e.g. DRAM) memory and a cgroup with 10G of lowtier (e.g. CXL) memory b=
oth
> > appear to be consuming the same amount of system resources from memcg=
=E2=80=99s
> > perspective, despite the performance asymmetry between the two workload=
s.
> >
> > Therefore on tiered systems, memory isolation cannot currently happen, =
as
> > workloads that are well-behaved within their memcg limits may still hur=
t the
> > performance of other well-behaving workloads by hogging more than its
> > =E2=80=9Cfair share=E2=80=9D of toptier memory.
> >
> > Introduce tier-aware memcg limits, which establish independent toptier =
limits
> > that scale with the memory limits and the ratio of toptier:total memory
> > available on the system.
> >
> > INTERFACE
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > This series introduces only one adjustable knob to userspace; a new cgr=
oup mount
> > option =E2=80=9Cmemory_tiered_limits=E2=80=9D which toggles whether the=
 cgroup mount will scale
> > toptier limits. It also introduces 4 new read-only sysfs entries per-cg=
roup:
> > memory.toptier_{min, low, high, max}.
> >
> > The new toptier memory limits are scaled according to the amount of top=
tier
> > memory and total memory available on the system as such:
> >
> > memory.toptier_high =3D (toptier_mem / total_mem) * memory.high
> >
> > For instance, on a host with 100GB memory, with 75G toptier and 25G CXL=
, the
> > =E2=80=9Ctoptier ratio=E2=80=9D would be 75 / 100 =3D 0.75. A cgroup wi=
th the following memcg
> > limits {min: 8G, low: 12G, high: 20G, max: 24G} might see toptier limit=
s scaled
> > at {min: 6G, low: 9G, high: 15G, max: 18G}.

Hi David!!

It was great seeing you at LSFMMBPF. I didn't get a chance to have a
conversation with you at Zagreb but hopefully I will be less shy and say
hello next conference : -)

> Assume you have a bigger hierarchy (HBP, DRAM, CXL), or assume you have m=
ultiple
> NUMA nodes with a hierarchy each.
>
> Your proposal doesn't really seem to be very versatile, or am I wrong?

Let me address these comments separately!

First, for the multi-numa-per-tier case, I think this is already pretty wel=
l
handled by my series. Once we realize that a memcg is consuming too much me=
mory
from a tier, we trigger reclaim from that memcg via
try_to_free_mem_cgroup_pages,
which as far as I can tell already handles the multi-numa per memcg case.
Other than restricting the scan_control's nodemask to target the nodes
from that tier, I don't think there's anything else to be done.

Next for the 3+ tier case, I think this is a lot more scalable than it seem=
s
at first. This series depends on another RFC that I sent out [1],
which pushes the concept of "stock" from memcg to page_counter, which means
that it is more scalable to just add more page counters to each memcg.
This means that each tier would just need another page_counter to track its
memory usage, and we trigger selective reclaim on the tier that is being
targeted via the scan control nodemask we introduce in this series.

At my talk in LSFMMBPF, Usama noted that the user-visible API should probab=
ly
remain the same, no matter what. The way I have currently established the
memcg files aren't really scalable, so Usama suggested turning the
"memory.toptier_XXX" sysfs files to "memory.tiered_XXX", which would includ=
e
a newline-separated / space-separated list of per-tier limits. Something li=
ke:

$ cat memory.tiered_max
tier_0 20971520
tier_1 31457280
...

So we have a way to make both the user-facing side stable, and the internal=
s
also more scalable.

With that said, I've opted to leave the internals to 2 tiers for now -- I t=
hink
it is not too late to add the generalization series when we start seeing
3+ tier systems out there in the wild. My goal was to introduce tieredness,
and we can work towards generalization in a future work.

On that note, it seems like in general mm is aware of 3+ tiers, but most of=
 the
existing work revolves around distinguishing between toptier/everything els=
e.
I got this impression from reading mm/memory-tiers.c -- but please feel fre=
e
to correct me if you feel like I have the wrong idea here : -)

So perhaps the generalization work would benefit from first introducing mor=
e
general tier awareness (not just toptier vs. rest) in memory-tiers.c.

What do you think? Does this approach of introducing toptier restriction fo=
r
now, and then generalizing in future work make sense to you?

Thanks again for your interest. Have a great day!
Joshua

[1] https://lore.kernel.org/all/20260410210742.550489-1-joshua.hahnjy@gmail=
.com/

