Return-Path: <cgroups+bounces-11061-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B86C00ACA
	for <lists+cgroups@lfdr.de>; Thu, 23 Oct 2025 13:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BED8A4E3C60
	for <lists+cgroups@lfdr.de>; Thu, 23 Oct 2025 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE577309F1F;
	Thu, 23 Oct 2025 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Re47UxRs"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098B93016F4;
	Thu, 23 Oct 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218317; cv=none; b=Ps70vj1bhAXkH74CjA4lYL34teDI8i8AJc8U7ON6Q6KLGcooWYfCFVjfE2h4UQxxf5ZBtDkgXEH1sKZUQdprf+lbA/Gkljt03S9N9307yukhtTxvu86UrfW1Bu0vmp/C99Yv3Jp1lwXc+ieZReWD7ZzI61zC4Ant3mBBalOiP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218317; c=relaxed/simple;
	bh=9CvpWdqvzaj/P0ENgX97mYxkfRxYCC4erNvZIUPuT2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQLxYJ2dVdilAK7GWI2GLVXXHrPSPuPle1O/0IKGx1ePbs7QnScuwPYybXOgDXxr+G9noZRyNbiUaGgqKuC/9ffhH8vkuxiFtgRzMNXJ9nVP8YcbagKzhTTg2UAdsFEEy7c0sleY/DbCXeRtvV2OspWYZx4wQLCGMw3Pa2XTEws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Re47UxRs; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=50CHd5Ukql2vTyZKQhH/988FqE+7up8mg+CD2up+Zus=; b=Re47UxRsfzq7vqoGEGRlmwscbL
	AaqRdwtSzIsbrk0fJv3lBY3Vpyvrsicmx3QvUcC/uzwfviExSIiJxTaJnrlADTqGs0d19wWvs7Xvf
	278vzIf7ziz1Fc1eVumo59jed6YQeevKEQpSAGaE8ougDb8aLyTFANfcVgCP/SyirfpcpEVE7aeJC
	kYRHYNe6G/8rZWXRppOA53OpJ6z8Ni7FjYg6m2+lEYhZwzzuMYrfMd+ISQZg9CMwIYQcJQN0tqrJd
	QtHgtajgk0UavtZq+wH7qPIevWoPE32K0fx/S1Q1vDGG5TWVbZYP3UbjIl13wn2FC50aJReyw6Ew6
	vk4HELkA==;
Received: from [90.242.12.242] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vBtKk-00DaUJ-2L; Thu, 23 Oct 2025 13:18:18 +0200
Message-ID: <a3c7b8f7-0f2c-4e0c-a55d-3e4433f795db@igalia.com>
Date: Thu, 23 Oct 2025 12:18:16 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 00/21] DRM scheduling cgroup controller
To: Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, intel-xe@lists.freedesktop.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Leo Liu <Leo.Liu@amd.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Matthew Brost <matthew.brost@intel.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>, Philipp Stanner <phasta@kernel.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Rob Clark <robdclark@gmail.com>, Tejun Heo <tj@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alistair Popple
 <apopple@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqunf@netflix.com>,
 =?UTF-8?B?R3LDqWdvaXJlIFDDqWFu?= <gpean@netflix.com>
References: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
 <DD5CCG4MIODH.1718JI1Z7GH8T@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <DD5CCG4MIODH.1718JI1Z7GH8T@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 29/09/2025 15:07, Danilo Krummrich wrote:
> On Wed Sep 3, 2025 at 5:23 PM CEST, Tvrtko Ursulin wrote:
>> This is another respin of this old work^1 which since v7 is a total rewrite and
>> completely changes how the control is done.
> 
> I only got some of the patches of the series, can you please send all of them
> for subsequent submissions? You may also want to consider resending if you're
> not getting a lot of feedback due to that. :)

There is so many cc across the series that I am reluctant to copy 
everyone on all patches. So I count on people being subscribed to 
mailing lists and being able to look into the archives if all else fails.

Regarding the luke warm response here is short video showing it in action:

https://people.igalia.com/tursulin/drm_cgroup.mp4

Please ignore the typos made in the video commentary but I would say it 
is worth a watch.

Lets see if that helps to paint a picture to people on what this can do. 
With some minimum imagination different use cases are obvious as well. 
For example start a compute job in the background with the UI still 
being responsive.
>> On the userspace interface side of things it is the same as before. We have
>> drm.weight as an interface, taking integers from 1 to 10000, the same as CPU and
>> IO cgroup controllers.
> 
> In general, I think it would be good to get GPU vendors to speak up to what kind
> of interfaces they're heading to with firmware schedulers and potential firmware
> APIs to control scheduling; especially given that this will be a uAPI.
> 
> (Adding a couple of folks to Cc.)
> 
> Having that said, I think the basic drm.weight interface is fine and should work
> in any case; i.e. with the existing DRM GPU scheduler in both modes, the
> upcoming DRM Jobqueue efforts and should be generic enough to work with
> potential firmware interfaces we may see in the future.Yes, basic drm.weight should not be controversial at all.

For all drivers which use the DRM scheduler in the 1:N mode it is 
trivial to wire the support up once the "fair" DRM scheduler lands. 
Trivial because scheduling weight is directly compatible with virtual 
GPU time accounting fair scheduler implements. This series has an 
example how to do it for amdgpu and many other simple drivers could do 
it exactly like with a few lines of boilerplate code.

For some 1:1 firmware scheduling drivers, like xe for example, patch 
series also includes a sketch on how it could make use drm.weight by 
giving firmware a hint what is the most important, and what is least 
important. In practice that is also usable for some use cases. (In fact 
the demo video above was made with xe! Results with amdgpu are pretty 
similar but I hit some snags with screen recording on that device.)

Possibly the main problem causing the luke warm response, as far as I 
understood during the XDC last month, is what to do about the drivers 
where seemingly neither approach can be implemented.

Like nouveau for example. Thinking seems to be it couldn't be wired up. 
I don't know that driver nor hardware (firmware) so I cannot say.

To satisfy that concern one idea I had is that perhaps I could expose a 
new control file like drm.weight_supported or something, which could 
have a semantics along the lines of:

  + - all active client/drivers in the cgroup support the feature
  ? - a mix of supported and unsupported
  - - none support the drm.weight feature

That would give visibility to the "Why is this thing not doing anything 
on my system?" question. Then over time solutions on how to support even 
those problematic drivers with closed firmware could be found. There 
will certainly be motivation not to be the one with worse user experience.

Regards,

Tvrtko


