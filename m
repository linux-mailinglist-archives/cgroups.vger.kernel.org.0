Return-Path: <cgroups+bounces-4677-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F85F969BAD
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2024 13:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EB31F253A3
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2024 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EB41A42AC;
	Tue,  3 Sep 2024 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XGQoIKKf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023A1A0BE3
	for <cgroups@vger.kernel.org>; Tue,  3 Sep 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362780; cv=none; b=bClgY/bDzRS5qt/N43j+HrqT55eEFkhnYt+38MWEZ1nF2I++QiL+96JvZdzE0fmPvZlN+PrBhyuxgEA46DHtqkIoWE2a3CsBNehvHYmJd82FAF4Quu0wgHVl787ojOy6vPcbMLen2HMhzc5SaCgoZd4CdsfeTAvJHX3f6u9NOws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362780; c=relaxed/simple;
	bh=HioyF7CphXw2djUdjiB8dJOBbmN3QasqwjCYhXrU9J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYSVFDBl0hFx4WeRiNQaT1Shfm7xTbWqxLK7GvHg5iIE8MqtKbXTJj2H1ogS0G6hRo+klj9IljvL7dHBos+JVNPLClbnh1ZIz/slGiK0HcFh5+dj54GKeFMhV1S57NX1B2Qjp4jJB6nu6fFBLUp7u8mcoWdQYTrcnSV8JoUagsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=XGQoIKKf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bb8cf8abeso41309175e9.2
        for <cgroups@vger.kernel.org>; Tue, 03 Sep 2024 04:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1725362776; x=1725967576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLLeWTwbX/xTIxk+Rn8jsU6To4jWTFIzV2bqBZrgyUc=;
        b=XGQoIKKfLYCXP5CXpsXBFWvjWhtsME3ik4iWNt0+91SDShbawXeEy7EeMvgP89792j
         kAGJ8XInlaimU8xDELzqTBQXeRSH8J7E5+WuDPsM/KyB1VohK5MTqNVzeHkM2SOgJ1Xc
         YrnoNGaLm4DOKPIo9Ixc41/Hz5EugS7EDYwLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725362776; x=1725967576;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLLeWTwbX/xTIxk+Rn8jsU6To4jWTFIzV2bqBZrgyUc=;
        b=NljV54jKlgTklIjEaLQVCrCRKiV3TWz/ZDCxWBfikr450FVpLX7y2FHNQWR+g32yT4
         0m8bqrfpTN0eDS1baCZUuEpIzczkqmE9pBou1Ia4RLO2OjyfH2F3DxG4CV3qLWVhpoLM
         b9cgFv6wW1LWMC8mfV7yT71TPzqIQFZcWVudMCYD+oKoSV9QbpT3qVnka+HwLn7Bkb83
         7acT4C5KnOOvyO7NKJpEWOvvq3iI3LfXdlX+S98wa8XlMcVrieKPX/gRmCVj/mlVj7qb
         Wr2QRnRYEcT1jIU9sAaKIOe/HwU1d0rJ04BlRklM+j0d9JUwHmBmiJDk8z0X9cD6R3pO
         OI5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXybWXUwUJ6dvDwMEumbV4eLmxL0NUt9BBuxW4b2k3/foBTtqtJfRtrovuaToLxSkFfY4qHUQeV@vger.kernel.org
X-Gm-Message-State: AOJu0YxtZlL/uFNcJitJoH04O6956E787C715EHUFi4TO+HR4NnfbFlp
	w8jW6KQc2OyFgU2S4tPt9jOpP1z/klE5lpG/yZLRPFfex4kpSBN76y4+T3IGg2A=
X-Google-Smtp-Source: AGHT+IESCiMwP2SuSjoVXX0mhaqNgaV6E3i+EFUvd5vCE5X1q+TteWYrbPgpsTvZp8bAB8dEU70+VQ==
X-Received: by 2002:a05:600c:4f87:b0:426:5dde:627a with SMTP id 5b1f17b1804b1-42c8de9de20mr3408135e9.23.1725362776029;
        Tue, 03 Sep 2024 04:26:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374cee38722sm4231655f8f.112.2024.09.03.04.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 04:26:15 -0700 (PDT)
Date: Tue, 3 Sep 2024 13:26:13 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 2/6] drm/cgroup: Add memory accounting DRM cgroup
Message-ID: <ZtbyVQtK3gy2a0Ve@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20240627154754.74828-3-maarten.lankhorst@linux.intel.com>
 <20240627-paper-vicugna-of-fantasy-c549ed@houat>
 <6cb7c074-55cb-4825-9f80-5cf07bbd6745@linux.intel.com>
 <20240628-romantic-emerald-snake-7b26ca@houat>
 <70289c58-7947-4347-8600-658821a730b0@linux.intel.com>
 <40ef0eed-c514-4ec1-9486-2967f23824be@ursulin.net>
 <ZrIeuLi88jqbQ0FH@phenom.ffwll.local>
 <20240806-gharial-of-abstract-reverence-aad6ea@houat>
 <ZrJAnbLcj_dU47ZO@phenom.ffwll.local>
 <20240903-resilient-quiet-oxpecker-d57d7a@houat>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-resilient-quiet-oxpecker-d57d7a@houat>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Tue, Sep 03, 2024 at 10:53:17AM +0200, Maxime Ripard wrote:
> On Tue, Aug 06, 2024 at 05:26:21PM GMT, Daniel Vetter wrote:
> > On Tue, Aug 06, 2024 at 04:09:43PM +0200, Maxime Ripard wrote:
> > > On Tue, Aug 06, 2024 at 03:01:44PM GMT, Daniel Vetter wrote:
> > > > On Mon, Jul 01, 2024 at 06:01:41PM +0100, Tvrtko Ursulin wrote:
> > > > > 
> > > > > On 01/07/2024 10:25, Maarten Lankhorst wrote:
> > > > > > Den 2024-06-28 kl. 16:04, skrev Maxime Ripard:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > On Thu, Jun 27, 2024 at 09:22:56PM GMT, Maarten Lankhorst wrote:
> > > > > > > > Den 2024-06-27 kl. 19:16, skrev Maxime Ripard:
> > > > > > > > > Hi,
> > > > > > > > > 
> > > > > > > > > Thanks for working on this!
> > > > > > > > > 
> > > > > > > > > On Thu, Jun 27, 2024 at 05:47:21PM GMT, Maarten Lankhorst wrote:
> > > > > > > > > > The initial version was based roughly on the rdma and misc cgroup
> > > > > > > > > > controllers, with a lot of the accounting code borrowed from rdma.
> > > > > > > > > > 
> > > > > > > > > > The current version is a complete rewrite with page counter; it uses
> > > > > > > > > > the same min/low/max semantics as the memory cgroup as a result.
> > > > > > > > > > 
> > > > > > > > > > There's a small mismatch as TTM uses u64, and page_counter long pages.
> > > > > > > > > > In practice it's not a problem. 32-bits systems don't really come with
> > > > > > > > > > > =4GB cards and as long as we're consistently wrong with units, it's
> > > > > > > > > > fine. The device page size may not be in the same units as kernel page
> > > > > > > > > > size, and each region might also have a different page size (VRAM vs GART
> > > > > > > > > > for example).
> > > > > > > > > > 
> > > > > > > > > > The interface is simple:
> > > > > > > > > > - populate drmcgroup_device->regions[..] name and size for each active
> > > > > > > > > >     region, set num_regions accordingly.
> > > > > > > > > > - Call drm(m)cg_register_device()
> > > > > > > > > > - Use drmcg_try_charge to check if you can allocate a chunk of memory,
> > > > > > > > > >     use drmcg_uncharge when freeing it. This may return an error code,
> > > > > > > > > >     or -EAGAIN when the cgroup limit is reached. In that case a reference
> > > > > > > > > >     to the limiting pool is returned.
> > > > > > > > > > - The limiting cs can be used as compare function for
> > > > > > > > > >     drmcs_evict_valuable.
> > > > > > > > > > - After having evicted enough, drop reference to limiting cs with
> > > > > > > > > >     drmcs_pool_put.
> > > > > > > > > > 
> > > > > > > > > > This API allows you to limit device resources with cgroups.
> > > > > > > > > > You can see the supported cards in /sys/fs/cgroup/drm.capacity
> > > > > > > > > > You need to echo +drm to cgroup.subtree_control, and then you can
> > > > > > > > > > partition memory.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Maarten Lankhorst<maarten.lankhorst@linux.intel.com>
> > > > > > > > > > Co-developed-by: Friedrich Vock<friedrich.vock@gmx.de>
> > > > > > > > > I'm sorry, I should have wrote minutes on the discussion we had with TJ
> > > > > > > > > and Tvrtko the other day.
> > > > > > > > > 
> > > > > > > > > We're all very interested in making this happen, but doing a "DRM"
> > > > > > > > > cgroup doesn't look like the right path to us.
> > > > > > > > > 
> > > > > > > > > Indeed, we have a significant number of drivers that won't have a
> > > > > > > > > dedicated memory but will depend on DMA allocations one way or the
> > > > > > > > > other, and those pools are shared between multiple frameworks (DRM,
> > > > > > > > > V4L2, DMA-Buf Heaps, at least).
> > > > > > > > > 
> > > > > > > > > This was also pointed out by Sima some time ago here:
> > > > > > > > > https://lore.kernel.org/amd-gfx/YCVOl8%2F87bqRSQei@phenom.ffwll.local/
> > > > > > > > > 
> > > > > > > > > So we'll want that cgroup subsystem to be cross-framework. We settled on
> > > > > > > > > a "device" cgroup during the discussion, but I'm sure we'll have plenty
> > > > > > > > > of bikeshedding.
> > > > > > > > > 
> > > > > > > > > The other thing we agreed on, based on the feedback TJ got on the last
> > > > > > > > > iterations of his series was to go for memcg for drivers not using DMA
> > > > > > > > > allocations.
> > > > > > > > > 
> > > > > > > > > It's the part where I expect some discussion there too :)
> > > > > > > > > 
> > > > > > > > > So we went back to a previous version of TJ's work, and I've started to
> > > > > > > > > work on:
> > > > > > > > > 
> > > > > > > > >     - Integration of the cgroup in the GEM DMA and GEM VRAM helpers (this
> > > > > > > > >       works on tidss right now)
> > > > > > > > > 
> > > > > > > > >     - Integration of all heaps into that cgroup but the system one
> > > > > > > > >       (working on this at the moment)
> > > > > > > > 
> > > > > > > > Should be similar to what I have then. I think you could use my work to
> > > > > > > > continue it.
> > > > > > > > 
> > > > > > > > I made nothing DRM specific except the name, if you renamed it the device
> > > > > > > > resource management cgroup and changed the init function signature to take a
> > > > > > > > name instead of a drm pointer, nothing would change. This is exactly what
> > > > > > > > I'm hoping to accomplish, including reserving memory.
> > > > > > > 
> > > > > > > I've started to work on rebasing my current work onto your series today,
> > > > > > > and I'm not entirely sure how what I described would best fit. Let's
> > > > > > > assume we have two KMS device, one using shmem, one using DMA
> > > > > > > allocations, two heaps, one using the page allocator, the other using
> > > > > > > CMA, and one v4l2 device using dma allocations.
> > > > > > > 
> > > > > > > So we would have one KMS device and one heap using the page allocator,
> > > > > > > and one KMS device, one heap, and one v4l2 driver using the DMA
> > > > > > > allocator.
> > > > > > > 
> > > > > > > Would these make different cgroup devices, or different cgroup regions?
> > > > > > 
> > > > > > Each driver would register a device, whatever feels most logical for that device I suppose.
> > > > > > 
> > > > > > My guess is that a prefix would also be nice here, so register a device with name of drm/$name or v4l2/$name, heap/$name. I didn't give it much thought and we're still experimenting, so just try something. :)
> > > > > > 
> > > > > > There's no limit to amount of devices, I only fixed amount of pools to match TTM, but even that could be increased arbitrarily. I just don't think there is a point in doing so.
> > > > > 
> > > > > Do we need a plan for top level controls which do not include region names?
> > > > > If the latter will be driver specific then I am thinking of ease of
> > > > > configuring it all from the outside. Especially considering that one cgroup
> > > > > can have multiple devices in it.
> > > > > 
> > > > > Second question is about double accounting for shmem backed objects. I think
> > > > > they will be seen, for drivers which allocate backing store at buffer
> > > > > objects creation time, under the cgroup of process doing the creation, in
> > > > > the existing memory controller. Right?
> > > > 
> > > > We currently don't set __GFP_ACCOUNT respectively use GFP_KERNEL_ACCOUNT,
> > > > so no. Unless someone allocates them with GFP_USER ...
> > > > 
> > > > > Is there a chance to exclude those from there and only have them in this new
> > > > > controller? Or would the opposite be a better choice? That is, not see those
> > > > > in the device memory controller but only in the existing one.
> > > > 
> > > > I missed this, so jumping in super late. I think guidance from Tejun was
> > > > to go the other way around: Exclude allocations from normal system
> > > > memory from device cgroups and instead make sure it's tracked in the
> > > > existing memcg.
> > > > 
> > > > Which might mean we need memcg shrinkers and the assorted pain ...
> > > > 
> > > > Also I don't think we ever reached some agreement on where things like cma
> > > > allocations should be accounted for in this case.
> > > 
> > > Yeah, but that's the thing, memcg probably won't cut it for CMA. Because
> > > if you pull the thread, that means that dma-heaps also have to register
> > > their buffers into memcg too, even if it's backed by something else than
> > > RAM.
> > 
> > For cma I'm kinda leaning towards "both". If you don't have a special cma
> > cgroup and just memcg, you can exhaust the cma easily. But if the cma
> > allocations also aren't tracked in memcg, you have a blind spot there,
> > which isn't great.
> 
> I think one of earlier comment from Tejun was that we don't want to
> double-account memory, but I guess your point is that we should double
> account if we allocate CMA buffers from the main CMA allocator, and not
> if we're allocating from a secondary one?

Maybe we need to discuss this with Tejun again, but with CMA the issue is
that it's both CMA and normal memory you get through alloc_pages(). So I
think this is one of the cases where we do have to double account, because
it really is two things in one.

My argument is that we should absolutely track it in the memcg, because if
CMA isn't accounted there you can use that to allocate more system memory
than the memcg allows you to. This is because CMA allocates require that
we move any system memory alloations out of there, so if they happen they
do create memory pressure, and should result in the memcg-aware shrinkers
kicking in if we go over the limits.

But we cannot exclusive rely on the memcg, because CMA is a subset of all
system memory, so if you set the memcg limit to reasonable manage CMA, you
don't have anything left for normal application memory usage at all. Which
doesn't work. Therefore I think there must be a limit for both, with the
CMA limit necessary being smaller than the memcg limit.

And I think we should do that for all CMA regions, with each CMA region
being tracked separately, with their own limit of how much you're allowed
to allocate in each if there's more than one. Otherwise if it's a total
limit and you have a display and a separate camera CMA, then applications
that have a limit for display+camera use-case might exhaust one CMA
completely if they can allocate their entire limit there. It's kinda like
multiple dgpu, if you only set a VRAM limit in total, with the idea that
e.g. 2 applications each get half of vram of 2 gpus. Then one application could
completely one gpu, preventing the other app from using it. Which defeats
the point of account and resource limits.

Note that for shmem allocations I concure nowadays with Tejun, we really
don't want to double account that because it all boils down to
alloc_pages, whether it's a gem bo or application memory that's mmapped.

Maybe CMA is special enought that we really want to track that in the
memcg itself, as a special limit, and not in some kind of disconnected
device cgroup limit?

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

