Return-Path: <cgroups+bounces-7868-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3D8A9F50A
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E611A80807
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD412309A3;
	Mon, 28 Apr 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZTuE5ba1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08157184524
	for <cgroups@vger.kernel.org>; Mon, 28 Apr 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856031; cv=none; b=TB1zbbYL58o9nbIT665NhFCJVZCuJGaxaNi7mG5eKgC2ar8o95qX5larDVzbC/YrXaodsfPOCwMnKMN/bF03VmICjOsDXUktOVyP95vLg831YK18Kzz7G576NcgMdsrniEcGfYqhaNZ82ToaplEm/662X1t9i/NKR+fsWbnJPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856031; c=relaxed/simple;
	bh=Lkp3DFpM/08XDHCUfGAUxNdCmhsRrnO/mdnrUbVlqoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8NoihzH7Qr8WJspnt/Zx/udc64FKoJS8sfOlBPvPbTe0Z+zKR0rYh/JzpDWiZg+EbDalW1iavweRevTOHqc991X9Ei02Gtq4zQ7C7AkL5PqIteV2Y6wm8XR9zSh9T/dIShxzsHaIsJJCySZp3uNBpXZpirW6a3rofzCsv6m+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ZTuE5ba1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so7767616a12.0
        for <cgroups@vger.kernel.org>; Mon, 28 Apr 2025 09:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1745856027; x=1746460827; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ju0m/te+QHiEcI4eXrGOD7HxlePKof8EZ1iR5gDsFoA=;
        b=ZTuE5ba1ShG6TUMeGJqZVybkYC5JogbDXhWRUS1XrBm/YK9zRzuIMIwiNVsOrQHoGO
         050jXDvVTF/nawDQ9yEZGnWuk35i4u5fCtZ22gDwbClRbV8K0r4BB+2anIm9sMEZhGMz
         IKcLMM7cvg+2aXgBAY5AxFe40ficUiYubiM8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745856027; x=1746460827;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ju0m/te+QHiEcI4eXrGOD7HxlePKof8EZ1iR5gDsFoA=;
        b=WpyGijl3o5UCrGZjG9nQ2RAlCai4ZkW3EWq+VmRZH/NevuAl9JjdAadZzXosu2NXA7
         zvk52GYmQ5yuLzrktjAFVJcd07l7tcrxttUv5ZsDWVo6YEW6eEMo3q2wdn5S+WpdDSk0
         7QEnQ9uogKEGmJ/XRU3Lur1ua7kVwuaGGm+5QfTGCQNao3aFaU8g7DAcD8r2kRdf50wf
         846nJzLyqzWp3/kmyi9Cx5nCZTbvGRkpCJgJw6msfPjDso+RsB/2ZHnCwTM/KNWHANK2
         OeI94gzTXHTYZt0eGGT/CRsLSh75IrhNyzH93uXM8dYRMUiNjMOKD+cQx2KM+nfM8tuw
         Y3GA==
X-Forwarded-Encrypted: i=1; AJvYcCX/AUzv/LKykSKqvZDzYTh+OfzJKhwIQMzgRrZOSx3EAf893GHpA1xM2d1uRtq/GfiGdY1k7rNb@vger.kernel.org
X-Gm-Message-State: AOJu0YyWdblJBw8USp35sge2e19RfX0JS4Mq5YoirgLvCaEL146Rci99
	V0Cnv4NEH8/ucChvBw9GHudr0ldM44Aizezcyuu4ioT8ebEA0wA8voRy53Kixk8=
X-Gm-Gg: ASbGncufIkyWsGG8IIRe1LVvEoDNTSdjifrQpbQ1s2x2n0nbA2pYqMg8oG833ALkk88
	X8zLUbXSRG+fuD3N+r1XvdsMiB6SuImHP+Jco8/CDs+mNQ7V0dsjo0IrqpC4d+QTU0xYYv5fadb
	NsNU2PVyNFF2tb8s6rGZ8VdqPAL7Cz7PsAKmTZo7/atqv9gvagePu5X/pQL1JkveAn0kQB9IXvF
	DbHlhDRrlY2duhKC/MqOJIAa+VU+qipF7tIp/nWcgeLc6TUcBDxKmj1XzXCpot0W5zR4Cf2NQxb
	I7Y3S8f8ezFbLre0nl8zYpEZ+d93Lo8H9i4zdu4g90+6Vs6bWxAq
X-Google-Smtp-Source: AGHT+IGobhrNlPW8PAYgax+LM4vV2hUFDS1mN92blyYJKuh5RqZBSLMeJEn91SiPcJWgZJR9F0eutQ==
X-Received: by 2002:a17:907:971f:b0:acb:5ae1:f6b8 with SMTP id a640c23a62f3a-ace848c0465mr950005366b.7.1745856026876;
        Mon, 28 Apr 2025 09:00:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecfb35bsm646493866b.100.2025.04.28.09.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 09:00:26 -0700 (PDT)
Date: Mon, 28 Apr 2025 18:00:24 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	tj@kernel.org, cgroups@vger.kernel.org
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration
Message-ID: <aA-mGO547zETZpFK@phenom.ffwll.local>
References: <20250423214321.100440-1-airlied@gmail.com>
 <4bac662a-228e-4739-b627-5d81df3d4842@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bac662a-228e-4739-b627-5d81df3d4842@amd.com>
X-Operating-System: Linux phenom 6.12.17-amd64 

On Mon, Apr 28, 2025 at 12:43:30PM +0200, Christian König wrote:
> On 4/23/25 23:37, Dave Airlie wrote:
> > Hey,
> > 
> > I've been tasked to look into this, and I'm going start from hopeless
> > naivety and see how far I can get. This is an initial attempt to hook
> > TTM system memory allocations into memcg and account for them.
> 
> Yeah, this looks mostly like what we had already discussed.
> 
> > 
> > It does:
> > 1. Adds memcg GPU statistic,
> > 2. Adds TTM memcg pointer for drivers to set on their user object
> > allocation paths
> > 3. Adds a singular path where we account for memory in TTM on cached
> > non-pooled non-dma allocations. Cached memory allocations used to be
> > pooled but we dropped that a while back which makes them the best target
> > to start attacking this from.
> 
> I think that should go into the resource like the existing dmem approach
> instead. That allows drivers to control the accounting through the
> placement which is far less error prone than the context.
> 
> It would also completely avoid the pooled vs unpooled problematic.
> 
> 
> > 4. It only accounts for memory that is allocated directly from a userspace
> > TTM operation (like page faults or validation). It *doesn't* account for
> > memory allocated in eviction paths due to device memory pressure.
> 
> Yeah, that's something I totally agree on.
> 
> But the major show stopper is still accounting to memcg will break
> existing userspace. E.g. display servers can get attacked with a deny of
> service with that.
> 
> The feature would need to be behind a module option or not account
> allocations for DRM masters or something like that.

The trouble is that support is very uneven, and it will be even more
uneven going forward. Especially if we then also add in SoC drivers, which
have all kinds of fun between system memory, cma, carveout and userptr all
being differently accounted for.

Which means I think we need two pieces here:

1. opt-in enabling, or things break

2. some way to figure out whether what userspace expects in term of
enforcement matches what the kernel actually does

Without two we'll never manage to get this beyond the initial demo stage I
fear, and we'll have a really hard time rolling out the various pieces to
various drivers.

But I have no idea what this should look like at all unfortuantely. Best I
can come up with is a set of flags of what kind of enforcement the kernel
does, and every time we add something new we set a new flag. And if the
flags userspace or the modoption opt-in sets don't match what the kernel
supports, you get a fallback to no enforcment.

But a module option flag approach doesn't cover at all per-driver or
per-device changes. I think for that we need the kernel to provide enough
information to userspace in sysfs, which userspace then needs to use to
set/update cgroup limits to fit whatever use-case it case. Or maybe a
per-device opt-in flag set.

Also I think the only fallback we can realistically provide is "no
enforcement", and that would technically be a regression every time we add
a new enforcement feature and hence another opt-in flag. And see below
with just the eviction example, I think there's plenty of really tricky
areas where we will just never get to the end state in one step, because
it's too much work and too hard to get right from the first attempt.

I think once we have a decent opt-in/forward-compatible strategy for
cgroups gpu features, adding not-entirely-complete solutions to get this
moving is the right thing to do.

> > This seems to work for me here on my hacked up tests systems at least, I
> > can see the GPU stats moving and they look sane.
> > 
> > Future work:
> > Account for pooled non-cached
> > Account for pooled dma allocations (no idea how that looks)
> > Figure out if accounting for eviction is possible, and what it might look
> > like.
> 
> T.J. suggested to account but don't limit the evictions and I think that
> should work.

I think this will need a ladder of implementations, where we slowly get to
a full featured place. Maybe something like:

1. Don't account evicted buffers. Pretty obvious gap if you're on a dgpu,
but entirely fine with an igpu without stolen memory.

2. Account, but don't enforce any limits on evictions. This could already
get funny if then system memory allocations start failing for random
reasons due to memory pressure from other processes.

3. Probably at this point we need a memcg aware shrinker in ttm drivers
that want to go further.

4. Start enforcing limits even on eviction.

I probably missed a few steps, like about enforcing dmem limits. And
memory pin limits also tie into this all in interesting ways (both for
system and device memory).

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

