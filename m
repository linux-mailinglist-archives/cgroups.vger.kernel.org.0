Return-Path: <cgroups+bounces-16526-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N+bMS3FHWq9dgkAu9opvQ
	(envelope-from <cgroups+bounces-16526-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 19:45:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FB56236AE
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 19:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2286F3018795
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 17:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D6E3E0239;
	Mon,  1 Jun 2026 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRGaizGG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE53E0C71
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335914; cv=pass; b=EDQLu3kV5tvC1gBkyBubemPkfLnhWcKIHiSVxcB8nLluAy+VuheOu8Yrr7Gi5VZvg+f77QvgANUun6nL0jlMqS5LLkbA3e6ntojD7k20eWZFvFq/x5VtCYIkBFnH71jSs62ootdIRDAdwnoyXF3NuxvhXT/wrTLCyug6k2LifSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335914; c=relaxed/simple;
	bh=b1X1Wus+CRdmVfPWGZGamYBMPYzTklUo5EaQiNtkQw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgOLLbVgAo4LU+7ACSvXcnl/NIAv7fh2YT6EHEVddc2s1LO8mU4wkgQoivK9oWagfT6tV/eQNUstkovwS7HfLN5ynqL3vk63SIOxV0242Rnzrg91yBxl5O69qGcibxNc5YmYwoVBtJb03hEoQduMJH1b+2rrxIu24ZlKzg9HcaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRGaizGG; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68b2229b48eso7569640a12.2
        for <cgroups@vger.kernel.org>; Mon, 01 Jun 2026 10:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780335911; cv=none;
        d=google.com; s=arc-20240605;
        b=PHWFBwVrz8o3oFW5I02uIf8+DNYEc8aPgLFf3iqRtlZ8GePySLO4oF3UV7mcVHy9Fm
         qgh3bXx7HQXJ/bMVxpjjOoAYsbVGkOU9DJzwBQASF+gU1YbE6ptKt1GvKWq8EDl1BYEd
         NvczZOO/8e1JLqsG85WF/O6mzf+HZl0w6pON+veL76U8rEAaOQPmT5low3hamx5Pikbq
         pV/wiccnBqANZ51Nbrd9m1ChRAfd84Tkv5PIMqa681mufWLK3BOQFkfrxr68O9bjiZ4/
         21gOOAaQsaAO3VERazK3EtXkos+e7kJfw+JAG/jjhFjYTQG+Lc0n+D0YF4bKZg/OhTW3
         W2LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zdBZDiQ9N2o+gUmeLxVAthNWp/fmNi0DwM5ZWNlvs8Q=;
        fh=YCFMqJwsOasejLlKI0dTyHJnt/K6BYxWyOFs12qTKfY=;
        b=HMJIwOZ9cGSe7CizgwLUSEI2Ao0JuJIh0DIFefxEiApjoy+Vtbbd/kidYah7di2hQR
         K2y6NTCTse3d7CFNuPqbpIxKmAS+qr43BHAr5jSokLw8wqnY5Mnj6wxegSpkZbJ2SfSc
         ZpyhHF0QSZEJlsABVY0xc8latE59RpguWBVqhDPRa6o3TbOa7NFloLNP+6tL+eolvtsn
         uTiTW582GWWm1U+lR5CdN9ryNIovL2rhvo484dEjI2+8Zc2Tl1TjP2QWBQo5kyFK4Rh1
         DQS5JB2riWguJESG+x2Tb6r/LfZn92wFNaGzf6+qp+Z2G5nnhhcv2ChlDug+GLZTjWzP
         TP0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780335911; x=1780940711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdBZDiQ9N2o+gUmeLxVAthNWp/fmNi0DwM5ZWNlvs8Q=;
        b=aRGaizGGW9utm+OAF7/91XcRpLUQ9G6XbQCgREzwRnR63v/8HGTgZQgfGWIKZteXes
         2cYap3JTmzWbdjWJR84reTZZE+BOL5RKTdCnDE3qRj6gVaB145rWLK2Uc7Qv3Hm9AQso
         XqiuGT4uCMv0Mkd+zMP46saDywyscGZgS2Bsxz4rP+euAewvEopBHU55HoevmC7gXtor
         FewybKWASpPZo5Q6dVoLnSuSE+GVnwtiCfHMDDZNta7YZMAldheQUAPW7cqwZimbtV3V
         uMxqa0svctAZogHBRUaUDkXFi+fqEurM/eZUSMM15BW6hUSXgbnguoJJqzSRude7PMlK
         rdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780335911; x=1780940711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zdBZDiQ9N2o+gUmeLxVAthNWp/fmNi0DwM5ZWNlvs8Q=;
        b=G+0usBbFOX6XYfi9A0QQIWgzrzP8u6/I7sWthroOnfrU9g/z0KEdfYUPsY+nn4X0Pr
         oINJjVn+yfKB+jdP80PjZL4xXN18ntmHJj9b4DLSZq/dyvmMIIpK3KJhjUrooftwwwIp
         b5jAu/ni6NpLVflejcjH5IJRWGhyfPLpM4V0aPPBukmj7qzBNxecY0hXvej75oZtTeRS
         xSUqpX0Ps/FFE3R+d3TEyPQMGZtOcvA6sSEXXSBRTJMIl98cEClTJDy9rg0UgLXStwSL
         xOML2rK6GA9yxZGroRpNtSLDJhXBIcTFbis04lRdhRc0MkennwBTCs3rVxCVy6/BIHO4
         ysrA==
X-Forwarded-Encrypted: i=1; AFNElJ9S3kolo7i+CGpenOLWxBqkr3Q/1mqz2KT4obuqpliahOe+jydt3FxeD2qpJ/8+vYkPDtJTslKM@vger.kernel.org
X-Gm-Message-State: AOJu0YzE9rwHo1XPP+duVl88cpZDprn6lyDm0SuPeios2AwB5E51edEw
	cydNUqDwMOk+3iKcfjXTPAV3FxlJpUUY7EizcXAs3P0D/FuiqyGICOXygdMKEBqwvJdjAX0L7yy
	A89UXHGfXy30F5MyBbS3gwrYiBSJQ/0Y=
X-Gm-Gg: Acq92OGeGrRNYMVli0c6ksU2w/tQPZ9nyQibHkId+4+z7GjblLNeZnKGfp8UDw2Aw54
	1rNcLocaaM4kQMGV4CFiAd77ksdynH10+JOSVOd0JcA7cdm8621JvfsdDf2JyMjyLglIeVEkt/2
	DNDWN74SGZco+udc0W0hHUjgr/CCdQHJCBjq5lF22kzs+51jnYA0wKol/6L4tY6gfyavWCbIXOp
	2+/wHWbfjrIYrvGSt7BSrJ/Y3VQlZCDFm7GVXbxL+9mKPya4hAgroSfug/yjzIojxGNgvi8Nqq7
	wm4xyP1Rn2kbPlPzZo3LRfRAu7bnuNj1nCUhoOF7CQRgMBxCsd4=
X-Received: by 2002:a17:907:d24:b0:bed:83ee:922a with SMTP id
 a640c23a62f3a-bed83ee9b81mr309677466b.16.1780335910507; Mon, 01 Jun 2026
 10:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ahz_iYG4lqWL4g-J@KASONG-MC4>
 <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com>
In-Reply-To: <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 2 Jun 2026 01:44:31 +0800
X-Gm-Features: AVHnY4IUw3nIoySauxI6MLfil3rr6hgOs7Yvxi0fLc_FDWPMh1u4pdIwbMn_l88
Message-ID: <CAMgjq7BhOn48xEyC=2j837R7qddfjeBVHMiRqdx8no4ZEBpBLg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
To: Nhat Pham <nphamcs@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, 
	lenb@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev, 
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com, haowenchao22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16526-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: B1FB56236AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 11:57=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Mon, Jun 1, 2026 at 12:34=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > For the format part, PHYS don't need that much bits I think,
> > so by slightly adjust the format vswap device could be share
> > mostly the same format with ordinary device.
> >
> > For example typical modern system don't have a address space larger
> > than 52 bit. (Even with full 64 bits used for addressing, shift it
> > by 12 we get 52). Plus 5 for type, you get 57, so you can have a
> > marker that should work as long as it shorter than 1000000 for PHYS,
> > and shared for all table format since it's not in conflict with
> > anything. You have also use a few extra bits so a single swap space
> > can be 8 times larger than RAM space, and since we can help
> > multiple swap type I think that should be far than enough?
> >
> > Then you have Shadow back at 001, and zero bit in shadow. The only
> > special one is Zswap, which will be 100 now, and that's exactly the
> > reserved pointer format in current swap table format, on seeing
> > si->flags & VSWAP && is_pointer(swp_tb) you know that's zswap :)
>
> Are you suggesting we merge the virtual table with main swap table?
>
> Man, I'd love to do this. There is a problem though - we have a case
> where we occupy both backing physical swap AND swap cache. Do you
> think we can fit both the physical swap slot handle and the swap cache
> PFN into the same slot in virtual table? Maybe with some expanding...?

I don't really get why we would need to do that? If you put the PFN
info in the virtual / upper layer, then the count info, locking, and
all swap IO synchronization (via folio lock), dup (current protected
by ci lock / folio lock), and allocation (folio_alloc_swap), are all
handled in this layer.

The physical / lower layer will just hold a reverse entry on
folio_realloc_swap, or no entry at all (no physical layer used, zswap,
or after swap allocation but before IO) right?

Looking up the actual folio from the physical layer will be a bit
slower since it needs to resolve the reverse entry, but the only place
we need to do that is things like migrate, compaction (none of them
exist yet) which seems totally fine?

> > This could be imporved by per-si percpu cluster. Both YoungJun's
> > tiering and Baoquan's previous swap ops mentioned this is needed,
> > and now vswap also need that. If the vswap is also a si, then it will
> > make use of this too.
>
> Yeah I made the same recommendation when I review swap tier last week:
>
> https://lore.kernel.org/all/CAKEwX=3DN2XcMHN1jatppOk6wnmz-Shab5XMtTtzgYOz=
RvU_6YFw@mail.gmail.com/
>
> I like it, but yeah it will be complicated. That said, I think not
> fixing the fast path for tiering/vswap will seriously restrict their
> usefulness. We don't want to go back to the old swap allocator days :)

Thanks. Not too complicated, actually our internal kernel
implementation still using si->percpu cluster, and use a counter for
the rotation and each order have a counter :P, it's a bit ugly but
works fine. It still serves pretty well just like the global percpu
cluster, YoungJun's previous per ci percpu cluster also still provides
the fast path, many ways to do that.

>
> >
> > YoungJun posted this a few month before:
> > https://lore.kernel.org/linux-mm/20260131125454.3187546-5-youngjun.park=
@lge.com/
> >
> > The concern is that some locking contention could be heavier, or maybe
> > that's just a hypothetical problem though.
>
> I don't think it's hypothetical. At least with vswap, it's very easy
> to get into a state where the shared per-cpu cache gets invalidated
> constantly if phys swap and vswap allocation alternates (which is
> actually very possible under heavy memory pressure), hammering the
> slow paths...

I mean if the per-cpu cache is moved to si level, then whoever enters
the allocation path of a si will almost always get a stable percpu
cache to use, even if the last used si changes.

We might better have a more explicit per si fast path for that. The
plist rotation should better be done in a different (will be even
better if lockless) way.

>
> >
> > >
> > > - Runtime enable/disable of the vswap device. To be honest, I don't
> > >   know if there is a value in this. My preference is vswap can be
> > >   optimized to the point that any overhead is negligible. Failing tha=
t,
> > >   maybe we can come up with some simple heuristics that automatically
> > >   decides for users?
> > >
> > >   In this RFC, CONFIG_VSWAP=3Dy means the vswap device is always crea=
ted at
> > >   boot, and CONFIG_VSWAP=3Dn means the vswap device is never created.=
 This
> > >   *might* be enough just on its own.
> > >
> > >   Is a runtime knob (sysfs or sysctl) worth the complexity beyond
> > >   these heuristics? I'm not sure yet. Maintaining both cases
> >
> > I checked the code and I think it's not hard to do, patch 1 already
> > handling the meta data dynamically, everything will still just work
> > even if you remove vswap at runtime. The rest of patches need adaption
> > but might not end up being complex, it other comments here
> > are considered.
>
> Yeah, it's not terribily hard to do. I'm more wondering if it's worth
> the effort, both for the implementer and the user :)
>
> As I said here, if we want vswap, just enable it at boot time and get
> a vast (but dynamic) device. We can make it optional per-cgroup
> through Youngjun's interface, and that would be good enough?
>
> >
> > For patch 2, a few routines like vswap_can_swapin_thp seems not
> > needed or should be moved to __swap_cache_alloc? VSWAP_FOLIO is
> > same as swap cache folio check, which is already covered. Same for
> > zero checking, and VSWAP_NONE which is same as swap count check
> > I think. That way we not only save a lot of code, we also no
> > longer need to treat vswap specially.
>
> Unfortunately, I think a lot of this complexity is still needed. Vswap
> adds a new layer, which means new complications :)
>
> For instance, I think you still need vswap_can_swapin_thp. It
> basically enforces that the backend must be something
> swap_read_folio() can handle. That means:
>
> 1. No zswap.
>
> 2. No mixed backend.

If mixed backend means phys vs zero vs zswap, then we already have
part of that covered with the current swap cache except for the phys
part (zswap part seems very doable with fujunjie's work).
swap_cache_alloc_folio will ensure there is no mixed zerobit, it can
be easily extended to ensure there is no mixed zswap as well
(according to what I've learned from fujunjie's code). Similar logic
for phys detection I think.

> > For memcg table allocation, on demand seems a good idea, and actually
> > we are not far from there, I tried to generalize the
> > alloc-then-retry-sleep-alloc in swap_alloc_table but still not generic
> > enough I guess.. Good new is the allocation of the table is already
> > kind of ondemand, just need to split the detection of these two kind
> > of table.
>
> I have a prototype of this, but I have not tested, so I do not want to
> send it out. :)
>
> TLDR is - I still want to record the memcg for vswap (just not charge
> it towards the counter). So we still need memcg_table at both level,
> generally - just not allocating until needed (basically if a physical
> swap slot in the cluster is directly mapped into PTE). You can kinda
> tell, since you pass the folio into the allocation path - with some
> care you can distinguish between:
>
> 1. Virtual swap, or directly maped physical swap -> need memcg_table
>
> 2. Physical swap, backing vswap -> does not memcg_table.
>
> Another alternative is you can defer this allocation until the point
> where you have to do the charging action. But then you have to be
> careful with failure handling, and need to backoff ya di da di da.
> Funsies.
>
> I think I did a mixed of these 2 strategies. Anyway, I'll include the
> patch in v2 (if folks like this approach).
>
> >
> > Mean while I also remember we once discussed about splitting the
> > accounting for vswap / physical swap? If we went that approach we
> > don't need to treat memcg_table specially.
>
> For the charging behavior, I already have a patch for it actually in
> this series (just not the dynamic allocation of the memcg_table field
> yet).
>
> Basically:
>
> 1. For vswap entry, not backed by phys swap: record swap memcg, hold
> reference to pin the memcg, but not charging towards swap.current.

Maybe you don't need to record memcg here since folio->memcg already
have that info?

I previously had a patch:
https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-7-104795d19815@t=
encent.com/

The defers the recording of memcg, the behavior is almost identical to
before, but charging & recording should be cleaner and you don't need
to record memcg at allocation time hence maybe reduce the possibility
of pinning a memcg. I didn't include that in P4 just to reduce LOC,
maybe can be resent or included.

> 2. For phys swap backing vswap: charging towards swap.current, but
> does not record the memcg in its memcg_table, nor does it hold
> reference to memcg (its vswap entry holds the reference already)
>
> 2. For phys swap directly mapped to PTE: charges, records, and holds refe=
rence.
>
> The motivation here is I do not want vswap entry to shares the same
> limit as phys swap counter. If we think of it as "infinite" or
> "dynamic", it should not be capped at all, but even if it is charged,
> it should be something separate.

Good to know, it's not too messy to make everything dynamic, but if
our ultimate goal is to account for them separately, maybe we can save
some effort here.

>
> >
> > > - Widen swap_info_struct->max to unsigned long. The vswap device's
> > >   max is currently clamped to ALIGN_DOWN(UINT_MAX, SWAPFILE_CLUSTER)
> > >   (~16 TiB) to fit in unsigned int. 16 TiB is small for vswap,
> > >   especially when we're getting increasingly big machines memory-wise=
.
> >
> > This should be very easy to do, just replace unsigned int with
> > unsigned long, a lot of place to touch though :)
>
> Agree. I'm just lazy, and this sounds like a simple patch as a
> follow-up. This RFC is already 2000 LoCs - I do not want to burden
> reviewers with extra useless details :)

No problem, good to see progress here :)

