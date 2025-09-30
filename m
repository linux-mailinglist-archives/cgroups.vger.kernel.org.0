Return-Path: <cgroups+bounces-10494-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7FCBAC463
	for <lists+cgroups@lfdr.de>; Tue, 30 Sep 2025 11:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB87E480B01
	for <lists+cgroups@lfdr.de>; Tue, 30 Sep 2025 09:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493012DA773;
	Tue, 30 Sep 2025 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbQpW5nG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04706217736;
	Tue, 30 Sep 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759224511; cv=none; b=Ps0kUPk6AsZCV1bkSAcDMUpLP2KEOSy2ljJkiGFqoKOWeXPREuqfmLKgsoCIIOrIkDQFLozeOnnZqaQBvQcDrqOH+X+Dz9GrSCB3kHqYJCNraN3rHqwJqTKLNotSluxSIS0Z5ZM1sc3WHrcLDVUloJo2EgReYMpKZd0BZVp45ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759224511; c=relaxed/simple;
	bh=C6w4ZmlTMv92jOsQegmpG3XRXTZg//un+z3Jc2P4C+s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=o+UuHapkXYZI3RXGKzsdTX5DaFE0weJWYfKyD/QYeIi8ure3XXmsfxq8969DlRgS6Q0Wtx38t23I/HG9ufN/o+LqKIOozbRd062vxGz8DWC5B5UxHpxwPmvTdM9HBLBKEsi/fqAQEsMvVr4DEaTy05BRV4+oJapM7aD8eXt2YWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbQpW5nG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EFDC4CEF0;
	Tue, 30 Sep 2025 09:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759224510;
	bh=C6w4ZmlTMv92jOsQegmpG3XRXTZg//un+z3Jc2P4C+s=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=RbQpW5nGZ2LiLVocNwDZgoJjp+iIyaiDkjcGtWyK76uyCkzleUUCkGKbjwtGltOVK
	 I4cD0EUDecrwo4hz9pN6kCsB7j0It2KXsuobUt0+Do20dcMsoK8zwVj7eid3Ac2ARU
	 NrQjSJKEBWvAHxgHmxInxSxXz3zVSCQYeQr853UAqf5r33GmMUqRqex+Z96KP1CQFh
	 CFzXa+QAqd29zb9dl4/NhCsmC4LYATo7djmad8vL6BiOYZOXGpjhYj/0lMVhVtaqB4
	 odcTpIpsmIxyCAjfuvk4jfsQ3yJwIK1gKNnm0tYTOAKKIej/MKqQE9TqTlgSKeqHRX
	 Wl4pfgUJ1du6A==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Sep 2025 11:28:21 +0200
Message-Id: <DD611F6QHQHM.1KNMI58HDKCZ5@kernel.org>
Subject: Re: DRM Jobqueue design (was "[RFC v8 00/21] DRM scheduling cgroup
 controller")
Cc: <phasta@kernel.org>, "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 <kernel-dev@igalia.com>, <intel-xe@lists.freedesktop.org>,
 <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Leo Liu"
 <Leo.Liu@amd.com>, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 "Matthew Brost" <matthew.brost@intel.com>, =?utf-8?q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, =?utf-8?q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>, "Pierre-Eric Pelloux-Prayer"
 <pierre-eric.pelloux-prayer@amd.com>, "Rob Clark" <robdclark@gmail.com>,
 "Tejun Heo" <tj@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Alex Deucher" <alexander.deucher@amd.com>,
 "Lucas De Marchi" <lucas.demarchi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, "Rob Herring" <robh@kernel.org>, "Steven
 Price" <steven.price@arm.com>, "Liviu Dudau" <liviu.dudau@arm.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Boqun Feng" <boqunf@netflix.com>,
 =?utf-8?q?Gr=C3=A9goire_P=C3=A9an?= <gpean@netflix.com>, "Simona Vetter"
 <simona@ffwll.ch>, <airlied@gmail.com>
To: "Philipp Stanner" <phasta@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
 <DD5CCG4MIODH.1718JI1Z7GH8T@kernel.org>
 <4453e5989b38e99588efd53af674b69016b2c420.camel@mailbox.org>
In-Reply-To: <4453e5989b38e99588efd53af674b69016b2c420.camel@mailbox.org>

On Tue Sep 30, 2025 at 11:00 AM CEST, Philipp Stanner wrote:
> +Cc Sima, Dave
>
> On Mon, 2025-09-29 at 16:07 +0200, Danilo Krummrich wrote:
>> On Wed Sep 3, 2025 at 5:23 PM CEST, Tvrtko Ursulin wrote:
>> > This is another respin of this old work^1 which since v7 is a total re=
write and
>> > completely changes how the control is done.
>>=20
>> I only got some of the patches of the series, can you please send all of=
 them
>> for subsequent submissions? You may also want to consider resending if y=
ou're
>> not getting a lot of feedback due to that. :)
>>=20
>> > On the userspace interface side of things it is the same as before. We=
 have
>> > drm.weight as an interface, taking integers from 1 to 10000, the same =
as CPU and
>> > IO cgroup controllers.
>>=20
>> In general, I think it would be good to get GPU vendors to speak up to w=
hat kind
>> of interfaces they're heading to with firmware schedulers and potential =
firmware
>> APIs to control scheduling; especially given that this will be a uAPI.
>>=20
>> (Adding a couple of folks to Cc.)
>>=20
>> Having that said, I think the basic drm.weight interface is fine and sho=
uld work
>> in any case; i.e. with the existing DRM GPU scheduler in both modes, the
>> upcoming DRM Jobqueue efforts and should be generic enough to work with
>> potential firmware interfaces we may see in the future.
>>=20
>> Philipp should be talking about the DRM Jobqueue component at XDC (proba=
bly just
>> in this moment).
>>=20
>> --
>>=20
>> Some more thoughts on the DRM Jobqueue and scheduling:
>>=20
>> The idea behind the DRM Jobqueue is to be, as the name suggests, a compo=
nent
>> that receives jobs from userspace, handles the dependencies (i.e. dma fe=
nces),
>> and executes the job, e.g. by writing to a firmware managed software rin=
g.
>>=20
>> It basically does what the GPU scheduler does in 1:1 entity-scheduler mo=
de,
>> just without all the additional complexity of moving job ownership from =
one
>> component to another (i.e. from entity to scheduler, etc.).
>>=20
>> With just that, there is no scheduling outside the GPU's firmware schedu=
ler of
>> course. However, additional scheduler capabilities, e.g. to support hard=
ware
>> rings, or manage firmware schedulers that only support a limited number =
of
>> software rings (like some Mali GPUs), can be layered on top of that:
>>=20
>> In contrast to the existing GPU scheduler, the idea would be to keep let=
ting the
>> DRM Jobqueue handle jobs submitted by userspace from end to end (i.e. le=
t the
>> push to the hardware (or software) ring buffer), but have an additional
>> component, whose only purpose is to orchestrate the DRM Jobqueues, by ma=
naging
>> when they are allowed to push to a ring and which ring they should push =
to.
>>=20
>> This way we get rid of one of the issue that the existing GPU scheduler =
moves
>> job ownership between components of different lifetimes (entity and sche=
duler),
>> which is one of the fundamental hassles to deal with.
>
>
> So just a few minutes ago I had a long chat with Sima.
>
> Sima (and I, too, I think) thinks that the very few GPUs that have a
> reasonably low limit of firmware rings should just resource-limit
> userspace users once the limit of firmware rings is reached.

The main purpose of the design I described is not to cover Mali GPUs, which=
,
eventually, will get rid of this limitation anyways. It's just that it simp=
ly
falls out of the approach to support hardware rings on top of the Jobqueue.=
 So,
why not take advantage of that and instead ask userspace to implement yet
another scheduler?

Besides that, it entirely discards the possibility from taking the firmware
scheduler decisions and the software scheduler decisions into consideration=
 from
a single source, i.e. the kernel driver. Mixing it up between userspace and
kernel seems very messy. Probably that's also why Panthor went down this ro=
ad?

> Basically like with VRAM.
>
> Apparently Sima had suggested that to Panthor in the past? But Panthor
> still seems to have implemented yet another scheduler mechanism on top
> of the 1:1 entity-scheduler drm_sched setup?
>
> @Boris: Why was that done?
>
> So far I tend to prefer Sima's proposal because I'm currently very
> unsure how we could deal with shared firmware rings =E2=80=93 because the=
n we'd
> need to resubmit jobs, and the currently intended Rust ownership model
> would then be at danger, because the Jobqueue would need a:
> pending_list.

How is the ownership model at danger? The Jobqueue will always be the owner=
 of a
job no matter when and to which ring it submits to (by the instruction of t=
he
orchestrator layered on top of it).

> So we'd be running danger of redesigning drm_sched, whereas with Sima's
> idea there'd never be a scheduler anywhere anymore anyways.

Except for GPUs that stick to exposing hardware rings (or have limitations
similar to Mali). Clearly, the trend goes into the direction of firmware
schedulers, but I think eventually we will need some software scheduler sol=
ution
on top of the Jobqueue if we don't want to stick with the existing GPU sche=
duler
forever (which I very much prefer).

