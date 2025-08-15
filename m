Return-Path: <cgroups+bounces-9216-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F123CB282B3
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 17:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3DB1CE3585
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA59428D836;
	Fri, 15 Aug 2025 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jb1+7qE/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9800F28C85A
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270622; cv=none; b=hQ37jhT4dyyBe30/MmfAVvVrgMhrDBXOg943ObQAlkNxTQPWynJ5M49e50nRsYJnCt/XXv/raj6hcHUvfaM15cDrBIW+xtfNFSKcwwnQrU/i1mT2CIYDh8k3V0n8rq+e8d0xCNvSahhtoj0qK48hXY3h/wr1ZyIMSvETa1H9AEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270622; c=relaxed/simple;
	bh=fGDwaVSvPH8pm2BAhxS+J5h/sgd3Il31C8JSmXIzOUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cX5tOCqTm5t/2Byhw4+gQDzm98KlGnb3n9Gyy6ECXePyllOAfIxYDWnzu2POx06Kqmv5bV0uQMQVI18uK1K2QL573UqrLQTJHOf8zA3xm/6mwKa3IxYzojVqYpcLm0lvhw+5XgLBAm8lX1NAsecmrCsWvsigVqGvEm9mCtutgl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jb1+7qE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151DDC4CEFC
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755270622;
	bh=fGDwaVSvPH8pm2BAhxS+J5h/sgd3Il31C8JSmXIzOUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jb1+7qE/0SDxocjVwFIAG//tpTUp7qfkzmcfnMmN1J3Y7z28WTrHVi5cIo8HOs52p
	 JNHixNYCD2XKD1YcPj8mknASrA6uGNmdwvf/sWMtENi2HACUcwN/T00le9SgGqiTzz
	 97NzeZQtgEo9J804d2vWLQyoKwlZRfEV3BZWvr98+aaSeTlvWmZzzEP3IKsafAipZo
	 Lr/fIivW8kNEZS17H9kYPTG45CSxUF+q2T8gbKvbHZdOvQpDGq7H0Slqaatmo7+f7K
	 JAbTxc8381skqOUo2++P52+RX5Y0I5VfL74D2+bc9/6fouyG8gpYdT3XZE0dFsBNxQ
	 jNFg113g+ERiw==
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459fc779bc3so61675e9.1
        for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 08:10:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXylWC1SCQSIMeMcMOdu5QkbEf7gYxk+JQTLhPUqtd9u0IlAA2f6FNO+qAj3Sshy7Gl829LKEzZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyqaO4PqJ7aIiIACiAAdB1YzUixi1LR2YavQ4q71gwfDLWSl0R+
	e9g8otXf7Iz45VksW2dRtMcshaQsRudLyog9VCsmIoyzLMy6FCRBfq86D1MfiORR6hl2XDqPGtD
	4rXjqekG/vR3XbTPStW0ux35nYJuvn/Cn0PcuwFdq
X-Google-Smtp-Source: AGHT+IG/Z8MebvAbTWGT9RmBQgvG1DLMFgUD0Xtc1EusOb89eQmpS0MfrZue4XkJq0FF4+vgGgs58TCUtMWhT5S+eqQ=
X-Received: by 2002:a05:600c:18a3:b0:439:8f59:2c56 with SMTP id
 5b1f17b1804b1-45a20980c41mr1461135e9.2.1755270620316; Fri, 15 Aug 2025
 08:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716202006.3640584-1-youngjun.park@lge.com>
 <20250716202006.3640584-2-youngjun.park@lge.com> <jrkh2jy2pkoxgsxgsstpmijyhbzzyige6ubltvmvwl6fwkp3s7@kzc24pj2tcko>
 <aH+apAbBCmkMGPlO@yjaykim-PowerEdge-T330> <aH/baxIgrBI3Z1Hl@yjaykim-PowerEdge-T330>
 <uyxkdmnmvjipxuf7gagu2okw7afvzlclomfmc6wb6tygc3mhv6@736m7xs6gn5q>
In-Reply-To: <uyxkdmnmvjipxuf7gagu2okw7afvzlclomfmc6wb6tygc3mhv6@736m7xs6gn5q>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 Aug 2025 08:10:09 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMo3yNKOZL9n5UkHx_O5cTZts287HOnQOu=KqQcnbrMdg@mail.gmail.com>
X-Gm-Features: Ac12FXxaQMgJCxryg4vXQEsqpIxPtgndj7TaEMxwJoTPbnI-r8lKXY393MbSlPo
Message-ID: <CAF8kJuMo3yNKOZL9n5UkHx_O5cTZts287HOnQOu=KqQcnbrMdg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: YoungJun Park <youngjun.park@lge.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, shikemeng@huaweicloud.com, kasong@tencent.com, 
	nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com, 
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com, 
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal and YoungJun,

I am sorry for the late reply. I have briefly read through the patches
series the overall impression:
1)  Priority is not the best way to select which swap file to use per cgrou=
p.
The priority is assigned to one device, it is a per swap file local
change. The effect you want to see is actually a global one, how this
swap device compares to other devices. You actually want  a list at
the end result. Adjusting per swap file priority is backwards. A lot
of unnecessary usage complexity and code complexity come from that.
2)  This series is too complicated for what it does.

I have a similar idea, "swap.tiers," first mentioned earlier here:
https://lore.kernel.org/linux-mm/CAF8kJuNFtejEtjQHg5UBGduvFNn3AaGn4ffyoOrEn=
XfHpx6Ubg@mail.gmail.com/

I will outline the line in more detail in the last part of my reply.

BTW, YoungJun and Michal, do you have the per cgroup swap file control
proposal for this year's LPC? If you want to, I am happy to work with
you on the swap tiers topic as a secondary. I probably don't have the
time to do it as a primary.

On Thu, Aug 14, 2025 at 7:03=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Wed, Jul 23, 2025 at 03:41:47AM +0900, YoungJun Park <youngjun.park@lg=
e.com> wrote:
> >
> > After thinking through these tradeoffs, I'm inclined to think that
> > preserving the NUMA autobind option might be the better path forward.
> > What are your thoughts on this?

The swap allocator has gone through a complete rewrite. We need to
revisit whether the NUMA autobinding thing is still beneficial in the
new swap allocator. We need more data points. Personally I would like
to decouple the NUMA to the swap device. If the swap device needs more
sharding, we can do more sharding without NUMA nodes. Using NUMA nodes
is just one way of sharding. Should not be the only way to do
sharding. Coupling the swap device with NUMA nodes makes things really
complicated. It would need a lot of performance difference to justify
that kind of complexity.

> > Thank you again for your helpful feedback.
>
> Let me share my mental model in order to help forming the design.
>
> I find these per-cgroup swap priorities similar to cpuset -- instead of
> having a configured cpumask (bitmask) for each cgroup, you have
> weight-mask for individual swap devices (or distribution over the
> devices, I hope it's not too big deviation from priority ranking).

+1. The swap tiers I have in mind is very close to what you describe

> Then you have the hierarchy, so you need a method how to combine
> child+parent masks (or global/root) to obtain effective weight-mask (and
> effective ranking) for each cgroup.

Yes, swap tiers has a hierarchy module story as well. Will talk about
that in a later part of the email.

>
> Furthermore, there's the NUMA autobinding which adds another weight-mask
> to the game but this time it's not configured but it depends on "who is
> asking". (Tasks running on node N would have autobind shifted towards
> devices associated to node N. Is that how autobinding works?)

Again, I really wish the swap file selection decouples from the NUMA nodes.

> From the hierarchy point of view, you have to compound weight-masks in
> top-down preference (so that higher cgroups can override lower) and
> autobind weight-mask that is only conceivable at the very bottom
> (not a cgroup but depending on the task's NUMA placement).

I want to abandon weight adjusting, focus on opt in or out.

> There I see conflict between the ends a tad. I think the attempted
> reconciliation was to allow emptiness of a single slot in the

I think adjusting a single swap file to impact the relative order is backwa=
rds.

> weight-mask but it may not be practical for the compounding (that's why
> you came up with the four variants). So another option would be to allow
> whole weight-mask being empty (or uniform) so that it'd be identity in
> the compounding operation.
> The conflict exists also in the current non-percg priorities -- there
> are the global priorities and autobind priorities. IIUC, the global
> level either defines a weight (user prio) or it is empty (defer to NUMA
> autobinding).
>
> [I leveled rankings and weight-masks of devices but I left a loophole of
> how the empty slots in the latter would be converted to (and from)
> rankings. This e-mail is already too long.]

OK. I want to abandon the weight-adjustment approach. Here I outline
the swap tiers idea as follows. I can probably start a new thread for
that later.

1) No per cgroup swap priority adjustment. The swap file priority is
global to the system.
Per cgroup swap file ordering adjustment is bad from the LRU point of
view. We should make the swap file ordering matching to the swap
device service performance. Fast swap tier zram, zswap store hotter
data, slower tier hard drive store colder data.  SSD in between. It is
important to maintain the fast slow tier match to the hot cold LRU
ordering.

2) There is a simple mapping of global swap tier names into priority range
The name itself is customizable.
e.g. 100+ is the "compress_ram" tier. 50-99 is the "SSD" tier, 0-55 is
the "hdd" tier.
The detailed mechanization and API is TBD.
The end result is a simple tier name lookup will get the priority range.
By default all swap tiers are available for global usage without
cgroup. That matches the current global swap on behavior.

3) Each cgroup will have "swap.tiers" (name TBD) to opt in/out of the tier.
It is a list of tiers including the default tier who shall not be named.

Here are a few examples:
e.g. consider the following cgroup hierarchy a/b/c/d, a as the first
level cgroup.
a/swap.tiers: "- +compress_ram"
it means who shall not be named is set to opt out,  optin in
compress_ram only, no ssd, no hard.
Who shall not be named, if specified, has to be the first one listed
in the "swap.tiers".

a/b/swap.tiers: "+ssd"
For b cgroup, who shall not be named is not specified, the tier is
appended to the parent "a/swap.tiers". The effective "a/b/swap.tiers"
become "- +compress_ram +ssd"
a/b can use both zswap and ssd.

Every time the who shall not be named is changed, it can drop the
parent swap.tiers chain, starting from scratch.

a/b/c/swap.tiers: "-"

For c, it turns off all swap. The effective "a/b/c/swap.tiers" become
"- +compress_ram +ssd -" which simplify as "-", because the second "-"
overwrites all previous optin/optout results.
In other words, if the current cgroup does not specify the who shall
not be named, it will walk the parent chain until it does. The global
"/" for non cgroup is on.

a/b/c/d/swap.tiers: "- +hdd"
For d, only hdd swap, nothing else.

More example:
 "- +ssd +hdd -ssd" will simplify to: "- +hdd", which means hdd only.
 "+ -hdd": No hdd for you! Use everything else.

Let me know what you think about the above "swap.tiers"(name TBD) proposal.

Chris

