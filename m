Return-Path: <cgroups+bounces-13159-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50939D1969A
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 15:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39FB53017C47
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 14:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E626287516;
	Tue, 13 Jan 2026 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nxRwG7nR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D332857EE
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314138; cv=none; b=H10w3/mFTTrRGaI5MI4AacDuYxMrW5VRxdDXG65lXnXNYq9AulbBfdGrkKZ8bVzFl5fUZ7vMgy4z1x245ynHGSmdywIqac9tqwANMVI4hyUGsqMUdsZH/HwVKYgqrMzxbHkjnkipg0VhyRFWVotsM4e+EdVyldzhBYGWoArlQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314138; c=relaxed/simple;
	bh=eGYf2Wx7+bxI9fnoEdaKbM+ix0y39iZXCpZ7Kf2dgqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rmc/nOrv70W6mjMmyvrs/FDp+hNJ8W3Tx3Gi/hAPoxz0ktRHZweH49DEvWGXY+tca4hjQ7whbpT3XETQ0CLXAwuHfB8QQWnCuVkZMAmaTvqhc0KA+08qTkFvz4k8qNqqnUQOQEQywkzrIMF9nrBByynFpnlSYGgkS++m77XeLy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nxRwG7nR; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88fcc71dbf4so47901396d6.2
        for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 06:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768314136; x=1768918936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4O37FQr+LOdMRqQ+TweaC2/Sd4OM2JtWu1rpX/F7Rk=;
        b=nxRwG7nRohedhtQXF/V6ET8r6E1hCKNpxlzftno1dvf+aoyTKgKLEYFzotdFeaS82j
         PF36RsbR9oCEBJ+Aifu/nMLKi92wqbSQLnLLXOg5k4/I3+y9ylsJqOsnxVrfBTXSPhhA
         a2Twusxuh6BCFzYh33Se9RWnDujRooZp51B5TRm8ti6koUW+ItEDiMvrUSeqaww1fb7g
         4vHvS+jZhJTia75hPeLrHZ025L0uWyeEzdeunVnF6lKaIb2WysxZfrbb9fjPPp49REjv
         zcH+mqYHu6lxocF+QYu0G+BkjBun6GwlthswaI19nEGuSJHyNpztiK9m+0cGVwNDRV0n
         DWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768314136; x=1768918936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4O37FQr+LOdMRqQ+TweaC2/Sd4OM2JtWu1rpX/F7Rk=;
        b=XSGV77sxQJmzTOSaEoA7fZnrI/ZhIQP36/04eKmk6PhYeIunhAZ8/4XjffZAcsc8B2
         +coINDt+5KkbdFnbzjZ9JiG9lekd9x6TDRF19WyTq/9xwKwy+YWPbqIMmye9LcTkxhfm
         V0eljeknsErp22tIqqpa7CZqH++gsPmi2ayYuffUnEQOblSwzsIfX42bJCMVo+9cuqLo
         2ZSRLciTVMQV2PgpLTfbHZOOVugbaRoZ4QMjy33sGJkA1qjdqCiIW9IF7LqWBvLX/0OX
         Jirbqi3a1TesemNKAGAJ5773Q/8Mn9zcOZl/ByTCTQHEkwaMBVQ/08IHJYC8uzi7hUkH
         9y7w==
X-Forwarded-Encrypted: i=1; AJvYcCWbWFgToQeegklpRogUw/+0lYBrpDWQC36WsiM//i82ZGP9GfXcY0bYeaLNJAexXGRAW/DVnSbF@vger.kernel.org
X-Gm-Message-State: AOJu0YyM9FLDXqgQz7vjC3M/2myjGbxP+QczKlnQuq78REOXW4h9U/e+
	L+2Os8XgcQ/7H7I+H4hR8oyUYspqxPnEdo9+ic/AtPbzxcobs+gODgVY4+/Z9AFMBqU=
X-Gm-Gg: AY/fxX6OsFP5ubHv5QmnUVEsg64UqqNXCjwkOYRrF6VTgxOGNoIrUiDrCmwZv3+50z6
	a46fE+dwDsxzaMjuul6TTMVd+KBVXJeV2ABVwps2y9VYzWe7BDS3Qyftp/VMZ/Eth9rQG6UKIKq
	zCyOnO03Ll7MchvorRwOpTBacfFJEb6QPfs6yupvZeWsGXNpltzu8bXiRRhy9JWfiS2sAqFFJMS
	va7ZY3yhyPh4UYNiqN27FxlSw8cmRK1XDMTfguhLwGsZ4eWmrZ7mOfhs5HEs3AwwcdoevExG7M3
	v03DJjJX963MZDF0nuS35156zLCK8Th3OziwVkCJp9v2If2NUzSH36eL1D3DXt7Xu65BzZO8LTS
	c6MyXQKX9SzcwuZB2rWwIW3y64Js9xTKm3KXcKEByk2ae5YLTrNaaIYFwKe0Re2xB1EC2omnTly
	r7VL5vhrDXe5APiYLF+JdYYYOEplYWrVp0vZbPZ+2nx/5R4cglms+3nWP447GhJbHHKIUeZQ==
X-Google-Smtp-Source: AGHT+IFjEUG/kkt8lULhTKW8EjcJ76aqeW9gt0lwSGT7fyOizprTUn0Us5awKcQHUHtWfOIUP8T8rQ==
X-Received: by 2002:a05:6214:5090:b0:888:8187:1547 with SMTP id 6a1803df08f44-890842a23b8mr315841516d6.48.1768314135363;
        Tue, 13 Jan 2026 06:22:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772681desm157803516d6.51.2026.01.13.06.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:22:14 -0800 (PST)
Date: Tue, 13 Jan 2026 09:21:41 -0500
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: dan.j.williams@intel.com, Yury Norov <ynorov@nvidia.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, longman@redhat.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, corbet@lwn.net,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
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
Message-ID: <aWZU9YZLmpX7wxbb@gourry-fedora-PF4VCD3F>
References: <aWUHAboKw28XepWr@gourry-fedora-PF4VCD3F>
 <aWUs8Fx2CG07F81e@yury>
 <696566a1e228d_2071810076@dwillia2-mobl4.notmuch>
 <e635e534-5aa6-485a-bd5c-7a0bc69f14f2@nvidia.com>
 <696571507b075_20718100d4@dwillia2-mobl4.notmuch>
 <966ce77a-c055-4ab8-9c40-d02de7b67895@nvidia.com>
 <aWWGZVsY84D7YNu1@gourry-fedora-PF4VCD3F>
 <69659d418650a_207181009a@dwillia2-mobl4.notmuch>
 <aWWuU8xphCP_g6KI@gourry-fedora-PF4VCD3F>
 <91015dcc-6164-4728-a512-1486333d7275@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91015dcc-6164-4728-a512-1486333d7275@nvidia.com>

On Tue, Jan 13, 2026 at 02:24:40PM +1100, Balbir Singh wrote:
> On 1/13/26 12:30, Gregory Price wrote:
> > On Mon, Jan 12, 2026 at 05:17:53PM -0800, dan.j.williams@intel.com wrote:
> >>
> >> I think what Balbir is saying is that the _PUBLIC is implied and can be
> >> omitted. It is true that N_MEMORY[_PUBLIC] already indicates multi-zone
> >> support. So N_MEMORY_PRIVATE makes sense to me as something that it is
> >> distinct from N_{HIGH,NORMAL}_MEMORY which are subsets of N_MEMORY.
> >> Distinct to prompt "go read the documentation to figure out why this
> >> thing looks not like the others".
> > 
> > Ah, ack.  Will update for v4 once i give some thought to the compression
> > stuff and the cgroups notes.
> > 
> > I would love if the ZONE_DEVICE folks could also chime in on whether the
> > callback structures for pgmap and hmm might be re-usable here, but might
> > take a few more versions to get the attention of everyone.
> > 
> 
> I see ZONE_DEVICE as a parallel construct to N_MEMORY_PRIVATE. ZONE_DEVICE
> is memory managed by devices and already isolated from the allocator. Do you
> see a need for both? I do see the need for migration between the two, but
> I suspect you want to have ZONE_DEVICE as a valid zone inside of N_MEMORY_PRIVATE?
> 

I see N_MEMORY_PRIVATE replacing some ZONE_DEVICE patterns.

N_MEMORY_PRIVATE essentially means some driver controls how allocation
occurs, and some components of mm/ can be enlightened to allow certain
types of N_MEMORY_PRIVATE nodes to be used directly (e.g. DEMOTE_ONLY
nodes could be used by vmscan.c but not by page_alloc.c as a fallback
node).

But you could totally have a driver hotplug an N_PRIVATE node and not
register the NID anywhere.  In that case the driver would allow
allocation either via something like

fd = open("/dev/my_driver_file", ...);
buf = mmap(fd, ...);
buf[0] = 0x0;
/* Fault into driver, driver allocates w/ __GFP flag for private node */

or just some ioctl()

ioctl(fd, ALLOC_SOME_MEMORY, ...);

The driver wouldn't have to reimplement allocator logic, and could
register its own set of callbacks to manage how the memory is allowed to
be mapped into page tables and such (my understanding is hmm.c already
has some of this control, that could be re-used - and pgmap exists for
ZONE_DEVICE, this could be re-used in some way).

~Gregory

