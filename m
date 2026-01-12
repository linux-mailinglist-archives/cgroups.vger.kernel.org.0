Return-Path: <cgroups+bounces-13088-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B756D14662
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 18:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71BDF3009846
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 17:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AEE37E310;
	Mon, 12 Jan 2026 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hSSKPtJp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4B137E2EE
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239412; cv=none; b=NM+PuHRd4KPoHdzLwS3QnahzxImiZQXUrhoMKS1eXw1F9P4GrG8BD99nFXrz4mSr0ugQ0pZ3Zbr2hQztoIRPpAfLJE81vzJfGeqcF2okFn5pS2avwI++yjw8ilGM5BuYI5qLFjl5IMJpe+um3TN3/1WvaYTuB8ikBzkRYf6Gi9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239412; c=relaxed/simple;
	bh=QzyYc3RXX8zVo3g9H6ehLJVIhE0FG7hrH0ndqq+y8qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJ7rXItJWz3vWJ0fK7BVS5OUAKNplsA3Sua0WWaFgqZ4gUUy0WO9FtzDhdIiIaT3qFY+92OboaAME2I26pz2q/hsBRV9hs6D7YGCGfl/abJKQgrOZ2CdmQkzOxMBDg0msmITowcKIiKYwzRf9NGI/oqjTALD1ZnwPY1MkbgBbzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hSSKPtJp; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4f4cd02f915so49302011cf.1
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 09:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768239410; x=1768844210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIrzuD3V8mK4XZdD49Fp4+4pZSOoDd5AA8lqEVpgoJQ=;
        b=hSSKPtJpm9XKpKmlVkiF9I0Ekq5ZXgr3bjDAtmrluR0I3ebjJAnobvxmSHzbqhiGvU
         qYWTXJnsUHCT+s44nF6TPX4gCMPtgGLF2ZlwUKnIOnQHdpYFkhEAmCdSjeaqTswY3n3a
         RkVuDw0e/47RJTRSsNdkURc17KTDpzO9XL5SWbPGsjb0HiDv2pJs32VIes/uCq4M2awm
         SbqLYEJ/ns/jzCoXpjcgev9zUZIDfqM9+eICIyCPDJj0RF7TiIk1cLHpZLJr/RKg7Wjq
         Q1P5HJyLDXi6n8stxt/1HBWzdgKUNIrxAk5tBZZs2mcvhw7jnMJYzPoX7DqqKMpgrJ+j
         ttXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239410; x=1768844210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIrzuD3V8mK4XZdD49Fp4+4pZSOoDd5AA8lqEVpgoJQ=;
        b=v8QqUvQuVTU+cmW2x9eD/wPVeJJAoJpvC9CyPPBR/tlX0dT2aGwRBgGQxfGFgAF/oK
         AXAYhAlvYA1pNXqJs3aQIGSzcDc3lCZrQ1X3fw4leh3zDEDXl5LXdv7wTVn1MHVsWtJV
         NktAtdq9B4tiYAwPL6EvJ6zPmCVct+RmINp+//NsHxAKELn8q0MUy3JnSVSQPZFjaOAP
         Xhbj36f1dwkNXg9jZ3ZOxqDyVso0IMuFoUQkdbg+TTWy4v2JZ3Y+iQPqaU40WhbCNbLA
         PXXrqQTsY1W5Vv1FB5eYyf1hnc/1ilH/JRa6deYw3x4tViiqzF1t+j/F4HGjMFxQ1h0G
         7YWA==
X-Forwarded-Encrypted: i=1; AJvYcCU92PCQcv2NQvk2ODOWfhvMjmWN1cShst1hlfR85qtBSxUod8ou55LNi/Sg7nHI4DN1Ft8g5P5d@vger.kernel.org
X-Gm-Message-State: AOJu0YzsvvLj/rODYn6OlD3uBeKIwStgk8WwAXPpuViAI18AvhIqg8WY
	lqJ9e0yulD/ZwVm8FPuyIba13CcDK0hIEnMVTUpC5SMj4NTe5QybTJKWtxET/ywGzME=
X-Gm-Gg: AY/fxX4TGlK822dBhrylTymnIxhhhUAaCQYKOtSOFL7gU64tmxutxLNWKaX/1JA8gka
	5O18HKjlfDpanDRqXPvlpQqQ1tE5m9nNyhdCM1D0b3340x1z8jS10qnb9a/Q9UV6Zui4lqSgWro
	oH84esg2vxK42vseYJOZKfJXFG9nkW3EBHrhkUJmJ7ULa4N78X+vmoPP1N/2SnoaLGsrtFgFGd7
	rp9sY2T3TIGJMmbw5g4ccfz0hFmQ4tvJMem/hgioUM1tfd2i5laB/APJBdCjVwvqnUXwCX4Og8g
	1N8zlPa0LnVFlPrNIzwm0JsnAewyBApA2X9uOSTUwozRrErg/6rH9NYpve7EAkdkKputqB3Eatp
	eyKHBFzCl21A89dSvZ69mzjWXU7p5W4/utkXmXxgHbXSRH/4XtnyAnW2X2TbgtJc3Vq3awRXbru
	Cduf4WT9iyxuEyo509+lkgWqghUY9PjAHQN7QxUd/8fe+2fqmVkcvoNh2MtefOtJFmSvUZcg==
X-Google-Smtp-Source: AGHT+IFIkZj0kkQefVdB6/+qxt7dAorkKD4y+wc4fxceCP23QaEoHwxiHll6IFZYaJtBeI5hcZkdtA==
X-Received: by 2002:a05:622a:1b8c:b0:4ec:f6d5:ee46 with SMTP id d75a77b69052e-4ffb4af497fmr238029601cf.78.1768239410022;
        Mon, 12 Jan 2026 09:36:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d39230sm131000681cf.6.2026.01.12.09.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:36:49 -0800 (PST)
Date: Mon, 12 Jan 2026 12:36:15 -0500
From: Gregory Price <gourry@gourry.net>
To: Yury Norov <ynorov@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, rientjes@google.com,
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, yosry.ahmed@linux.dev, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 0/8] mm,numa: N_PRIVATE node isolation for
 device-managed memory
Message-ID: <aWUxD6yPyCbUVjlw@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <6604d787-1744-4acf-80c0-e428fee1677e@nvidia.com>
 <aWUHAboKw28XepWr@gourry-fedora-PF4VCD3F>
 <aWUs8Fx2CG07F81e@yury>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWUs8Fx2CG07F81e@yury>

On Mon, Jan 12, 2026 at 12:18:40PM -0500, Yury Norov wrote:
> On Mon, Jan 12, 2026 at 09:36:49AM -0500, Gregory Price wrote:
> > 
> > Dan Williams convinced me to go with N_PRIVATE, but this is really a
> > bikeshed topic
> 
> No it's not. To me (OK, an almost random reader in this discussion),
> N_PRIVATE is a pretty confusing name. It doesn't answer the question:
> private what? N_PRIVATE_MEMORY is better in that department, isn't?
> 
> But taking into account isolcpus, maybe N_ISOLMEM?
>
> > - we could call it N_BOBERT until we find consensus.
> 
> Please give it the right name well describing the scope and purpose of
> the new restriction policy before moving forward.
>  

"The right name" is a matter of opinion, of which there will be many.

It's been through 3 naming cycles already:

Protected -> SPM -> Private

It'll probably go through 3 more.

I originally named v3 N_PRIVATE_MEMORY, but Dan convinced me to drop to
N_PRIVATE.  We can always %s/N_PRIVATE/N_PRIVATE_MEMORY.

> > > >   enum private_memtype {
> > > >       NODE_MEM_NOTYPE,      /* No type assigned (invalid state) */
> > > >       NODE_MEM_ZSWAP,       /* Swap compression target */
> > > >       NODE_MEM_COMPRESSED,  /* General compressed RAM */
> > > >       NODE_MEM_ACCELERATOR, /* Accelerator-attached memory */
> > > >       NODE_MEM_DEMOTE_ONLY, /* Memory-tier demotion target only */
> > > >       NODE_MAX_MEMTYPE,
> > > >   };
> > > > 
> > > > These types serve as policy hints for subsystems:
> > > > 
> > > 
> > > Do these nodes have fallback(s)? Are these nodes prone to OOM when memory is exhausted
> > > in one class of N_PRIVATE node(s)?
> > > 
> > 
> > Right now, these nodes do not have fallbacks, and even if they did the
> > use of __GFP_THISNODE would prevent this.  That's intended.
> > 
> > In theory you could have nodes of similar types fall back to each other,
> > but that feels like increased complexity for questionable value.  The
> > service requested __GFP_THISNODE should be aware that it needs to manage
> > fallback.
> 
> Yeah, and most GFP_THISNODE users also pass GFP_NOWARN, which makes it
> looking more like an emergency feature. Maybe add a symmetric GFP_PRIVATE
> flag that would allow for more flexibility, and highlight the intention
> better?
> 

I originally added __GFP_SPM_NODE (v2 - equivalient to your suggestion)
and it was requested I try to use __GFP_THISNODE at LPC 2025 in December.

v3 makes this attempt.

This is good feedback to suggest maybe that's not the best and maybe we
should keep __GFP_SPM_NODE -> __GFP_PRIVATE

> > > What about page cache allocation form these nodes? Since default allocations
> > > never use them, a file system would need to do additional work to allocate
> > > on them, if there was ever a desire to use them. 
> > 
> > Yes, in-fact that is the intent.  Anything requesting memory from these
> > nodes would need to be aware of how to manage them.
> > 
> > Similar to ZONE_DEVICE memory - which is wholly unmanaged by the page
> 
> This is quite opposite to what you are saying in the motivation
> section:
> 
>   Several emerging memory technologies require kernel memory management
>   services but should not be used for general allocations
> 
> So, is it completely unmanaged node, or only general allocation isolated?
> 

Sorry, that wording is definitely confusing. I should have said "can
make use of kernel memory management services".

It's an unmanaged node from the perspecting of any existing user (no
existing core service user is exposed to this memory).  But this really
means that it's general-allocation-isolated.

ZONE_DEVICE is an unmanaged zone on a node, while this memory would be
onlined in ZONE_MOVABLE or below (i.e. it otherwise looks like normal
memory, just it can't be allocated).  In theory, we could re-use
ZONE_DEVICE for this, but that's probably a few more RFCs away.

I'm still trying to refine the language around this, thanks for pointing
this out.

~Gregory

