Return-Path: <cgroups+bounces-15319-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDi7Cn3r32m/aQAAu9opvQ
	(envelope-from <cgroups+bounces-15319-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 21:48:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 835944076D4
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 21:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2886C30233D7
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 19:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018A43859DA;
	Wed, 15 Apr 2026 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FTIOxfHa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0227C30EF64
	for <cgroups@vger.kernel.org>; Wed, 15 Apr 2026 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776282485; cv=pass; b=t7Iynz6wVSB2mDyXWyVRlLGtiR4fQEv8pUazI7GD0UQXUN4ApOahMjJeAXqiF9im5aY3uH4wNW7KqbZ7k5SZwsea0tWFGRsd78Hq+haDlTLhPf4HyFIsJH79StJ1gWVPCJs3XR0oFxtwYXZuf8qBzo0WutbvIj5l+8CTlyX7N80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776282485; c=relaxed/simple;
	bh=bTKITcODyC33aRzhtGD6NO5LshHbAyzyPqYrtdm77LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6IFJnnsQ/AUs4TUpbP92IhnusCVxLTEu2GhM9q+ZHcfGzavAdFuyKHwq9TLqijAYN7ugz4GzrXAaCiMKbj0NuWxkqeTT9WXkcZ8Rq/Oui2xMiFiAzK9lEP5lZGyB/DtUHdonMDOAa72bWV1Ksj4pseTQzQSFzm6KgoWGwAtkMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FTIOxfHa; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488879dcbc3so50455e9.0
        for <cgroups@vger.kernel.org>; Wed, 15 Apr 2026 12:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776282482; cv=none;
        d=google.com; s=arc-20240605;
        b=CNyESJElaGCfcInyr68F4W+778wiLZbg/9NhbW8fIySlMz9fiLYvKUsTI8etiWZBiC
         NrMMdATUSJsnoOUzcjnnCRU5pwpiKdR8l0GyUfiWh+wr8KtmAODAi8O0QHcAs8umyVT6
         cMtrOEfsqJRLSftpFRePBY0W18lzLIZQiclJEmUEBvMghCMEtxxbcswpCAQjNso+Li76
         g2FIAYvnkZqWF9/hQVnt2l/T8Pb4/9toT/yD6+5oaljIN8mfiMkXrifHaAxIjtd1KF0W
         U+t+imB27R9xeJ+7O4EYqQLrCdygH56K9QKuEDv9MtbSu2bAvBG+q0Hhtqh3w6dBal1r
         6SWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+7EyRQT4jMuTzXDYdte1riRfSEGUZuTfSDGM7Pop5YI=;
        fh=lZFHdxJl+IdQxNzdj4kPiZTGhvj+SUtozg9VFz19ygc=;
        b=IR0uKa31tmz7ZVvc0hBGActwCsHMLbS5Xd+VjDEzvQpZGIGT0/BWs9jRJlwrJ8Kb1O
         AWdBktpCQ3m57xBDYTk/OZM7mE+U6IAHS1JRsJQ2A3oo0Dap/mOw5JyKEBc+BM0GR4s3
         2zT2soOc2fsqCLXjPiUwK+Tv1xFmYibhH1yoTqDuUI1QcxSbkTkpBg+VGz5Eay3FKNCJ
         i9QUy9y5yqCXf6zIPNqjsTW8lV1Vu+7hqDf9h9cKh8Smlzq+oYQg7flaUuCb6KRdY5T8
         7eQGPf9YJjLWGcSX3Q8F/2Yo4R0gWuCBM8HsrBPHCrD3DFragQB7uX8kjv7s208ouoIQ
         xRqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776282482; x=1776887282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7EyRQT4jMuTzXDYdte1riRfSEGUZuTfSDGM7Pop5YI=;
        b=FTIOxfHaSG8bu3WpKE+MiMFLgGuIG03o4ruPvjXKf+JziNg7G88zsypJp/MDjFf6rr
         /UKkCUXoppsk3KxH7VAO9WQoOjU4POlNLh8389mbSQumaX3+UHSMPDCR1SHuvoHTVPFq
         AnO2rbFPpv8MYR2AO6KyYgK99210iSuqTlBiFPIYjVZDNaenZoaXIz/e9UJ3NXIQwdg5
         sG+3KAeklIv/LaesKDgUWgln3YgQBIMPp27hd/4gx3TSJsueHwYq30CREnBiZ4RHfr7X
         3MEDdNbKYmxd0Vvti4Glz+xI8/qOiD9Hlsfm3NOJbqh484JXQe4PvpZk3gYxZAC2IaHF
         UrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776282482; x=1776887282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+7EyRQT4jMuTzXDYdte1riRfSEGUZuTfSDGM7Pop5YI=;
        b=E1SziXlQ/vioHu4JnsXkeUWBgV4QVkNaZxqA6P5ChiUoQs753SNG6o/iuYoWLw6vWh
         tKj/6ZIeI0fmi/rKPV1AbzJO9I5cj0PiIcDLgMNhpLoWYETZh8Dn3fhKOlCxNb7JqZwN
         gBPRUf3aEA4XcfjX6Mp7ZPN5QZ1iCDrc7Q76Dt5mA849+buOmQAm4TFU3l8OGiKsbWY2
         gwX2fWSiAubu+9vM4psO6Lpj5zj1XqwmR/TmcUcJTrz+kjGgk6LzdHDtULVL+sCP4coo
         /uEerTyV0IuDki9Uf2384/jl9EFkIfslewi1xSRecb0wsFCP2zwlRdi5cTxoqvYTsAZG
         tXHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PfEsU/ChiwG2eobiq+Scn9cWiExbabOU7vCkvfjHS2/apiVbaEbpthG1Ww1GSswwrzNrYV5IT@vger.kernel.org
X-Gm-Message-State: AOJu0YykGQibAZwfa+WitcDSvn+wH5qMtKMGWKzIAszTvNrNz7AZ40ZA
	A48FnuebpXQJBzKL22snF0cdXiK7sUI9voEtna2Rw60QNw6f1hpZeoH3JTG1l3OMev+f+BlYNU7
	I1gxAcAk+simutrZhbVONOU+pWdM9Havn1qOOmzXE
X-Gm-Gg: AeBDievv4hfN26yEoUhW/sFdepzpxYZ3/o/sdJQixzmj9uTknyit+rACM6KaUiF+zHE
	NRI0o5tHl9F2OMzmY2WWm7LyBxziwDBggZh0Ud2f2m+BY3EScqtit67tbDTZNvCYzFv2N3o8ycU
	mEpEi/Of1KdzcNVRknS6dUUsPTq34d5BVgokQ32YfRWvq3QUdDhPPvl6G8WmqeCIBNAnjX+oSeO
	Gi+EtqZkw/i7n3JhjpYsin1NOt0ICkimLDMSVq6ntmQTu4ZsWAAy4zNX8Y0jK53lqYgBeOWdW0/
	8XzQtV7BFwzQIxIL4RFh0RZZCIDB
X-Received: by 2002:a05:600c:529a:b0:485:1a54:9407 with SMTP id
 5b1f17b1804b1-488f49f7b15mr240485e9.0.1776282481776; Wed, 15 Apr 2026
 12:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222084842.1824063-1-gourry@gourry.net> <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F> <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F> <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
 <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
In-Reply-To: <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
From: Frank van der Linden <fvdl@google.com>
Date: Wed, 15 Apr 2026 12:47:50 -0700
X-Gm-Features: AQROBzCIVwgyF1A8foGoMoeg1wgH05cQMGevG1TSqfVdQKYctSN8Xrxoo27rHlc
Message-ID: <CAPTztWajm_JLpp9BjRcX=h72r25ELrXeGkOXVachybBxLJGS=g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev, 
	kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, dan.j.williams@intel.com, longman@redhat.com, 
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com, 
	sj@kernel.org, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com, 
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com, 
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com, cl@gentwo.org, 
	roman.gushchin@linux.dev, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	zhengqi.arch@bytedance.com, terry.bowman@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	TAGGED_FROM(0.00)[bounces-15319-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fvdl@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nongnu.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gourry.net:email]
X-Rspamd-Queue-Id: 835944076D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 8:18=E2=80=AFAM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Wed, Apr 15, 2026 at 11:49:59AM +0200, David Hildenbrand (Arm) wrote:
> > On 4/13/26 19:05, Gregory Price wrote:
>
> As a preface - the current RFC was informed by ZONE_DEVICE patterns.
>
> I think that was useful as a way to find existing friction points - but
> ultimately wrong for this new interface.
>
> I don't thinks an ops struct here is the right design, and I think there
> are only a few patterns that actually make sense for device memory using
> nodes this way.
>
> So there's going to be a *major* contraction in the complexity of this
> patch series (hopefully I'll have something next week), and much of what
> you point out below is already in-flight.
>
> > > On Mon, Apr 13, 2026 at 03:11:12PM +0200, David Hildenbrand (Arm) wro=
te:
> > >
> > > This is because the virtio-net device / network stack does GFP_KERNEL
> > > allocations and then pins them on the host to allow zero-copy - so al=
l
> > > of ZONE_NORMAL is a valid target.
> > >
> > > (At least that's my best understanding of the entire setup).
> >
> ... snip ...
> >
> > A related series proposed some  MEM_READ/WRITE backend requests [1]
> >
> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-09/msg02693.h=
tml
> >
>
> Oh interesting, thank you for the reference here.
>
> >
> > Something else people were discussing in the past was to physically
> > limit the area where virtio queues could be placed.
> >
>
> That is functionally what I did - the idea was pretty simple, just have
> a separate memfd/node dedicated for the queues:
>
> guest_memory =3D memfd(MAP_PRIVATE)
> net_memory =3D memfd(MAP_SHARED)
>
> And boom, you get what you want.
>
> So yeah "It works" - but there's likely other ways to do this too, and
> as you note re: compatibility, i'm not sure virtio actually wants this,
> but it's a nice proof-of-concept for a network device on the host that
> carries its own memory.
>
> I'll try post my hack as an example with the next RFC version, as I
> think it's informative.
>
> > >
> > > This partially answers your question about slub fallback allocations,
> > > there are slab allocations like this that depend on fallbacks (more
> > > below on this explicitly).
> >
> > But that's a different "fallback" problem, no?
> >
> > You want allocations that target the "special node" to fallback to
> > *other* nodes, but not other allocations to fallback to *this special* =
node.
> >
> ... snip - slight reordering to put thoughts together ...
> > >
> > > __GFP_PRIVATE vs GFP_PRIVATE then is just a matter of use case.
> > >
> > > For mbind() it probably makes sense we'd use GFP_PRIVATE - either it
> > > succeeds or it OOMs.
> >
> > Needs a second thought regarding fallback logic I raised above.
> >
> > What I think would have to be audited is the usage of __GFP_THISNODE by
> > kernel allocations, where we would not actually want to allocate from
> > this private node.
> >
>
> This is fair, and I a re-visit is absolutely warranted.
>
> Re-examining the quick audit from my last response suggests - I should
> never have seen leakage in those cases, but the fallbacks are needed.
>
> So yes, this all requires a second look (and a third, and a ninth).
>
> I'm not married to __GFP_PRIVATE, but it has been reliable for me.
>
> > Maybe we could just outright refuse *any* non-user (movable) allocation=
s
> > that target the node, even with __GFP_THISNODE.
> >
> > Because, why would we want kernel allocations to even end up on a
> > private node that is supposed to only be consumed by user space? Or
> > which use cases are there where we would want to place kernel
> > allocations on there?
> >
>
> As a start, maybe? But as a permanent invariant?  I would wonder whether
> the decision here would lock us into a design.
>
> But then - this is all kernel internal, so i think it would be feasible
> to change this out from under users without backward compatibility pain.
>
> So far I have done my best to avoid changing any userland interfaces in
> a way that would fundamentally change the contracts.  If anything
> private-node other than just the node's `has_memory_private` attribute
> leaks into userland, someone messed up.
>
> So... I think that's reasonable.
>
> >
> > I assume you will be as LSF/MM? Would be good to discuss some of that i=
n
> > person.
> >
>
> Yes, looking forward to it :]
>
>
> > > One note here though - OOM conditions and allocation failures are not
> > > intuitive, especially when THP/non-order-0 allocations are involved.
> > >
> > > But that might just mean this minimal setup should only allow order-0
> > > allocations - which is fiiiiiiiiiiiiiine :P.
> >
> >
> > Again, I am not sure about compaction and khugepaged. All we want to
> > guarantee is that our memory does not leave the private node.
> >
> > That doesn't require any __GFP_PRIVATE magic, just en-lighting these
> > subsystems that private nodes must use __GFP_THISNODE and must not leak
> > to other nodes.
>
> This is where specific use-cases matter.
>
> In the compressed memory example - the device doesn't care about memory
> leaving - but it cares about memory arriving and *and being modified*.
> (more on this in your next question)
>
> So i'm not convinced *all possible devices* would always want to support
> move_pages(), mbind(), and set_mempolicy().
>
> But, I do want to give this serious thought, and I agree the absolute
> minimal patch set could just be the fallback control mechanism and
> mm/ component filters/audit on __GFP_*.
>
>
> > > If you want the mbind contract to stay intact:
> > >
> > >    NP_OPS_MIGRATION (mbind can generate migrations)
> > >    NP_OPS_MEMPOLICY (this just tells mempolicy.c to allow the node)
> >
> > I'm missing why these are even opt-in. What's the problem with allowing
> > mbind and mempolicy to use these nodes in some of your drivers?
> >
>
> First:
>
> In my latest working branch these two flags have been folded into just
> _OPS_MEMPOLICY and any other migration interaction is just handled by
> filtering with the GFP flag.
>
>
> on always allowing mbind and mempolicy vs opt-in
> ---
>
> A proper compressed memory solution should not allow mbind/mempolicy.
>
> Compressed memory is different from normal memory - as the kernel can
> percieves free memory (many unused struct page in the buddy) when the
> device knows there's none left (the physical capacity is actually full).
>
> Any form of write to a compressed memory device is essentially a
> dangerous condition (OOMs =3D poison, not oom_kill()).
>
> So you need two controls:  Allocation and (userland) Write protection
> I implemented via:
>     - Demotion-only (allocations only happen in reclaim path)
>     - Write-protecting the entire node
>
> (I fully accept that a write-protection extension here might be a bridge
>  to far, but please stick with me for the sake of exploration).
>
>
> There's a serious argument to limit these devices to using an mbind
> pattern, but I wanted to make a full-on attempt to integrate this device
> into the demotion path as a transparent tier (kinda like zswap).
>
> I could not square write-protection with mempolicy, so i had to make
> them both optional and mutually exclusive.
>
> If you limit the device to mbind interactions, you do limit what can
> crash - but this forces userland software to be less portable by design:
>
>   - am i running on a system where this device is present?
>   - is that device exposing its memory on a node?
>   - which node?
>   - what memory can i put on that node? (can you prevent a process from
>     putting libc on that node?)
>   - how much compression ratio is left on the device?
>   - can i safety write to this virtual address?
>   - should i write-protect compressed VMAs? Can i handle those faults?
>   - many more
>
> That sounds a lot like re-implementing a bunch of mm/ in userland, and
> that's exactly where we were at with DAX.  We know this pattern failed.
>
> I'm trying to very much avoid repeating these mistakes, and so I'm very
> much trying to find a good path forward here that results in transparent
> usage of this memory.
>
>
> > I also have some questions about longterm pinnings, but that's better
> > discussed in person :)
> >
>
> The longterm pin extention came from auditing existing zone_device
> filters.
>
> tl;dr: informative mechanism - but it probably should be dropped,
> it makes no sense (it's device memory, pinnings mean nothing?).
>
>
> > >
> > > The task dies and frees the pages back to the buddy - the question is
> > > whether the 4-5 free_folio paths (put_folio, put_unref_folios, etc) c=
an
> > > all eat an ops.free_folio() callback to inform the driver the memory =
has
> > > been freed.
> >
> > Right, that's rather invasive.
> >
>
> Yeah i'm trying to avoid it, and the answer may actually just exist in
> the task-death and VMA cleanup path rather than the folio-free path.
>
> From what i've seen of accelerator drivers that implement this, when you
> inform the driver of a memory region with a task, the driver should have
> a mechanism to take references on that VMA (or something like this) - so
> that when the task dies the driver has a way to be notified of the VMA
> being cleaned up.
>
> This probably exists - I just haven't gotten there yet.
>
> ~Gregory

This has been a really great discussion. I just wanted to add a few
points that I think I have mentioned in other forums, but not here.

In essence, this is a discussion about memory properties and the level
at which they should be dealt with. Right now there are basically 3
levels: pageblocks, zones and nodes. While these levels exist for good
reasons, they also sometimes lead to issues. There's duplication of
functionality. MIGRATE_CMA and ZONE_MOVABLE both implement the same
basic property, but at different levels (attempts have been made to
merge them, but it didn't work out). There's also memory with clashing
properties inhabiting the same data structure: LRUs. Having strictly
movable memory on the same LRU as unmovable memory is a mismatch. It
leads to the well known problem of reclaim done in the name of an
unmovable allocation attempt can be entirely pointless in the face of
large amounts of ZONE_MOVABLE or MIGRATE_CMA memory: the anon LRU will
be chock full of movable-only pages. Reclaiming them is useless for
your allocation, and skipping them leads to locking up the system
because you're holding on to the LRU lock a long time.

So, looking at having some properties set at the node level makes
sense to me even in the non-device case. But perhaps that is out of
scope for the initial discussion.

One use case that seems like a good match for private nodes is guest
memory. Guest memory is special enough to want to allocate / maintain
it separately, which is acknowledged by the introduction of
guest_memfd.

I'm interested in enabling guest_memfd allocation from private nodes.
I've been playing around with setting aside memory at boot, and
assigning it to private nodes (one private node per physical NUMA
node), and making it available to guest_memfd only. There are issues
to be solved there, but the private node abstraction seems to fit
well, and provides for useful hooks to manage guest memory.

Some properties that I'm interested in for this use case:

1) is the memory in the direct map or not? Should that be configurable
for a private node? I know there are patches right now to remove
memory from the direct map for guest_memfd, but what if there was a
private node whose memory is not in the direct map by default?
2) Default page size. devdax, a ZONE_DEVICE user, allows for memory
setup on hotplug that initializes things with HVO-ed large pages.
Could the page size be a property of the node? That would make it easy
to hand out larger pages to guests.  Of course, if you use anything
but 4k, the argument of 'we can use the general buddy allocator' goes
out the window, unless it's made to deal with a per-node base page
size.

- Frank

