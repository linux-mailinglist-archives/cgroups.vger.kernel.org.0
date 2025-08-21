Return-Path: <cgroups+bounces-9304-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBA1B2F6F1
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 13:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81971C841E1
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B5230F531;
	Thu, 21 Aug 2025 11:42:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D112FDC42;
	Thu, 21 Aug 2025 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776522; cv=none; b=ff7phaGI1PJEQxIn3UGnU9ZQI9zY3fT9BuzM1nIDMJ2/6W7gLeK5BBP9Nz6LioUpm6PHk1C80gUZdSVDG/224i1muyaAndywfqdFG4PSmTXX8uKhnWgh3L7ML9FQeOn5UzGTUY/IeNs25xMGm7NVNdtseLeSKfKQGmPM1ULIL6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776522; c=relaxed/simple;
	bh=H34/94ehslK+27BO22zg2h9Na/d+pekW0gfjYNpPCjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8V0/ZhdgaF0hE75FTr4Qi6+aMzUdxKkJWahv/aBKaZ6h5BQecjeybBehc8LGD3enHVMcK1JDmw6brkT1OEztRtNU91bKkOL98DO+eOJop+7gUJ1Y/dxIZhpKRotmE8OWkJhNWM6bpSFsBpl9Ejo36rPt8pnHznpk1rCr01asMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Message-ID: <533447a9-098a-4509-9014-631af83e0e5a@lankhorst.se>
Date: Thu, 21 Aug 2025 13:41:49 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] drm/xe: Add DRM_XE_GEM_CREATE_FLAG_PINNED flag and
 implementation
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?=27Michal_Koutn=C3=BD=27?=
 <mkoutny@suse.com>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "'Liam R . Howlett'" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Michal Hocko <mhocko@suse.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20250819114932.597600-5-dev@lankhorst.se>
 <20250819114932.597600-8-dev@lankhorst.se>
 <a781f7781a9bf510c3707a5c9a235e1dab785617.camel@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <a781f7781a9bf510c3707a5c9a235e1dab785617.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey,

Den 2025-08-19 kl. 18:22, skrev Thomas Hellström:
> Hi, Maarten,
> 
> On Tue, 2025-08-19 at 13:49 +0200, Maarten Lankhorst wrote:
>> Add an option to pin memory through the science of cgroup accounting.
>> A bo will be pinned for its entire lifetime, and this allows buffers
>> that are pinned for dma-buf export without requiring the pinning to
>> be
>> done at the dma-buf layer for all devices.
>>
>> For now only implement VRAM pinning. Dave Airlie has a series to
>> implement
>> memcg accounting for the GPU but that is not ready yet.
> 
> Previous discussions around this have favoured a UAPI where we pin a
> gpu-vm range, with a pin at mapping time, or dma-buf pin time where
> required, this allows for dynamic pinning and unpinning, and would
> avoid having separate pinning interfaces for bos and userptr.
> 
> In particular if we don't know at bo creation time which buffer objects
> will be exported with a method requiring pinning, how would UMD deduce
> what buffer objects to pin?
> 
> Thanks,
> Thomas
> For discussion purposes, it seems compute preferred pinning at allocation time,
so I wanted to propose that solution since it's easiest to implement.

I will change it for the next version, but I'm very interested in feedback
on the adjustments I made in cgroups. Those are the ones that will have the
most impact, and changes how effective min/low is calculated when memory
pinned is involved.

Kind regards,
~Maarten

