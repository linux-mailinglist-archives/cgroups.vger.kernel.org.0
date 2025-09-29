Return-Path: <cgroups+bounces-10492-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AFBBA97A4
	for <lists+cgroups@lfdr.de>; Mon, 29 Sep 2025 16:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD8516728B
	for <lists+cgroups@lfdr.de>; Mon, 29 Sep 2025 14:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E183074AB;
	Mon, 29 Sep 2025 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIwCs6nE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B534BA3B;
	Mon, 29 Sep 2025 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154846; cv=none; b=o51T/obC1H4tYEi1AB1a79nBDCe8ISeM4WsgmMpHl2VQW2UNUm56GRaFIvXAv8cvaWpyedXcpiUyQY3Jw3DQ9daRJSv4GtMOH7tJ623hdYSmr3BRMbG1KSGG7Ljk5xIY6BYbC94muDIK/0D0edEHLP8elyISWi+tLraQ+75ZiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154846; c=relaxed/simple;
	bh=BKY6d1yBc/lroKagYCaSuXxxZ2I6xVz7xuOdW9gGVog=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Uc4R8JDvM+8fbzgzQveiQR8c0MccrWjMIr8wasY4CT8+1mMx/o0ZnlhqaUWDwpeFooMsKLL10QSm75ZrXrxVwjcpTftVWA3PW9C+fKe5xwP3UAj8HwaKAQI9HMkb1syVxEtvwRUY7mqE4Cye83GvVK9NrG1LeYp8WCNICpFUXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIwCs6nE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39D5C4CEF4;
	Mon, 29 Sep 2025 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759154846;
	bh=BKY6d1yBc/lroKagYCaSuXxxZ2I6xVz7xuOdW9gGVog=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=VIwCs6nERrhW0nxOSUX19uKaSbWaPiA57FLkrY/4Uprkq5LgrHoiUivCfaZvPlDJb
	 i6KLN/dKDKpt1NR2uxgGrDR52CIUwIHMg23DAcNlGqdewpdtJ70FJNG6vguN5c0uqv
	 nZXAhALVBgh98eaVa0iqjXEivUiyt33u0EBXa0WBUTXuKPWVYVyzjfZ9M0LVem7OQo
	 AEEPO53AterwJzs/a9z5iozTdGXW9hC5C2TJZP7d2vbXGRMDMCg6jLfr24uZafLKzw
	 nS5iP9sVWdC/gpZ6Qm187pNyhz6baXQw04PzSAY31gKs37HoOgNmPLp4Ijx6IsJwhb
	 y4VzpOZRGf51w==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Sep 2025 16:07:18 +0200
Message-Id: <DD5CCG4MIODH.1718JI1Z7GH8T@kernel.org>
Subject: Re: [RFC v8 00/21] DRM scheduling cgroup controller
Cc: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 <kernel-dev@igalia.com>, <intel-xe@lists.freedesktop.org>,
 <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Leo Liu"
 <Leo.Liu@amd.com>, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 "Matthew Brost" <matthew.brost@intel.com>, =?utf-8?q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, =?utf-8?q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>, "Philipp Stanner" <phasta@kernel.org>,
 "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>, "Rob
 Clark" <robdclark@gmail.com>, "Tejun Heo" <tj@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "John Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Alex Deucher"
 <alexander.deucher@amd.com>, "Lucas De Marchi" <lucas.demarchi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, "Rob Herring" <robh@kernel.org>, "Steven
 Price" <steven.price@arm.com>, "Liviu Dudau" <liviu.dudau@arm.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Boqun Feng" <boqunf@netflix.com>,
 =?utf-8?q?Gr=C3=A9goire_P=C3=A9an?= <gpean@netflix.com>
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
In-Reply-To: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>

On Wed Sep 3, 2025 at 5:23 PM CEST, Tvrtko Ursulin wrote:
> This is another respin of this old work^1 which since v7 is a total rewri=
te and
> completely changes how the control is done.

I only got some of the patches of the series, can you please send all of th=
em
for subsequent submissions? You may also want to consider resending if you'=
re
not getting a lot of feedback due to that. :)

> On the userspace interface side of things it is the same as before. We ha=
ve
> drm.weight as an interface, taking integers from 1 to 10000, the same as =
CPU and
> IO cgroup controllers.

In general, I think it would be good to get GPU vendors to speak up to what=
 kind
of interfaces they're heading to with firmware schedulers and potential fir=
mware
APIs to control scheduling; especially given that this will be a uAPI.

(Adding a couple of folks to Cc.)

Having that said, I think the basic drm.weight interface is fine and should=
 work
in any case; i.e. with the existing DRM GPU scheduler in both modes, the
upcoming DRM Jobqueue efforts and should be generic enough to work with
potential firmware interfaces we may see in the future.

Philipp should be talking about the DRM Jobqueue component at XDC (probably=
 just
in this moment).

--

Some more thoughts on the DRM Jobqueue and scheduling:

The idea behind the DRM Jobqueue is to be, as the name suggests, a componen=
t
that receives jobs from userspace, handles the dependencies (i.e. dma fence=
s),
and executes the job, e.g. by writing to a firmware managed software ring.

It basically does what the GPU scheduler does in 1:1 entity-scheduler mode,
just without all the additional complexity of moving job ownership from one
component to another (i.e. from entity to scheduler, etc.).

With just that, there is no scheduling outside the GPU's firmware scheduler=
 of
course. However, additional scheduler capabilities, e.g. to support hardwar=
e
rings, or manage firmware schedulers that only support a limited number of
software rings (like some Mali GPUs), can be layered on top of that:

In contrast to the existing GPU scheduler, the idea would be to keep lettin=
g the
DRM Jobqueue handle jobs submitted by userspace from end to end (i.e. let t=
he
push to the hardware (or software) ring buffer), but have an additional
component, whose only purpose is to orchestrate the DRM Jobqueues, by manag=
ing
when they are allowed to push to a ring and which ring they should push to.

This way we get rid of one of the issue that the existing GPU scheduler mov=
es
job ownership between components of different lifetimes (entity and schedul=
er),
which is one of the fundamental hassles to deal with.

