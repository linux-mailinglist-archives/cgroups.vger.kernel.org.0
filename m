Return-Path: <cgroups+bounces-13074-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE9CD13BF9
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 16:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3C413019873
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 15:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07D52F39DE;
	Mon, 12 Jan 2026 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IYbYov2W"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8CB2F5A25
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231584; cv=none; b=tOrvCprhbW8Qs2ml5rYmH4d0PkpipOelqu+gvCpOKMNMrgf7SyG/DBp+PXsOvIzV3CYAiRql6UF+zKbeXIe2JLJNWC42HSD9KC0a/0ANzQjyJLKDwnlSnMtdiG/WlZFCByCMTjsfID9yzTcp4eT0kuvZp40OMqAXJ8KDU0ih2/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231584; c=relaxed/simple;
	bh=EULRbDh2eWrxKTzxeqVj7dyOdGXNsrU4bT7mvwNID8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJyTr69OOOfwKQaxOXyDeqH71bTatDlDYMVCeFD0Q+YPFS+PqxMJLweCQvGcrHChBzsmATr6M4T8rtcYQEOcZeAukvntZZK+llSVDmxf6gTXhImYCKwIGNU3il8+TghBmNZqeh+6Fv007c7u2ZS1eenuBwbWAv8hUaFOI+Fscuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IYbYov2W; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8b2a4b6876fso1004720885a.3
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 07:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768231579; x=1768836379; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=57UuhljdncFCr/JytocOWEZRWmlPR6Nv3ccaWVm2VXI=;
        b=IYbYov2W9czkLWI6VyMzlenE6G8F92zW/RL6fC79g8xfvBcwtysPEjGuxKdft9iGWt
         tPc4NFzIep1NbXA3rC5KnCqzwbz93sfzLwFimFf82zEBPuJDW18oNGlnG11+SJylEfha
         ek8hwl2288dHGcvZQIiwTGuuVJnrRzLfXZBOS/OOpkGQc/EwI+slj+Crm9PdFvSEGJ+W
         IhdbfwBt2T/r+E7mMyvlfXrbedq+H6dIzsQDT2yfCXXvUdpVtZbg1VzBt4o8bUJ/YCZ4
         vlHA+WkSbs6rb0PYrAJRtA7JepyDZCMgLLek3WRknkhaGnE5n5XC+PTwfc96/ckeR0lS
         4F+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768231579; x=1768836379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57UuhljdncFCr/JytocOWEZRWmlPR6Nv3ccaWVm2VXI=;
        b=KV7vBCVEnjceCBwiVPUuxPLR0d8FjXlwT+9PLm5UNLLQEF7f+0hHwGID4GZdwW5PpK
         WTAQ6v8OtS7JicL7O8xB/QwHkEGBAVxaEvE4zkWF4ZBKPc7DMRKw8CR5iRHZEcNB3+Vs
         f43QDIFq2C+mfjEnsVv69WVWC8ri/rC1zNFBKs7CQ0AZ04ERtEVHDdGrPi5eIpl39xLV
         w75cjhXpfndThWYIoGiTj8RGWUnQv5Gl7F3U2uA2Vp9Yj6GXaMFw8uJ6PjwI3vO+FxV8
         IdL8kmUMR0XFC+u3JchDOi+BPB+4WOoTAf+Pul99mP6NKPfEsqxT0eWv/Df2v2D+j3g/
         FMjg==
X-Forwarded-Encrypted: i=1; AJvYcCWEBMXYmQF4Gn6uLK05o+Gk8J+mvDue47GeIw7LCoMoWcqEWcvmWxFJIV5o7ZUSU2QBRrV5FZ/3@vger.kernel.org
X-Gm-Message-State: AOJu0YwwF5WNTi/KLLC6O+WDpUIUNtlwo/tAl4ekjSpExrNwqNUGO1Uu
	O+42eH7D1nt9C0dWrv8lz4yeelLlPpSNcs55PGZ3DgHc2WwF05z1y3p0fbfb2cwNlHY=
X-Gm-Gg: AY/fxX5943ZHStbn/R9EsNQvqIjdUEDNCUBsrIYjX3ltcMkeyku+ckQvHAaH475eBNt
	BlDWOXO/GEXhmVk7kqPbantqzcMO0jHTVacP/Ajr/X/hKDX8//H4ria1642ibgjXhOFf2nHxW7l
	xMXZGDrRmg4AqdMsg+R0B+a15h9SJjj/xhm6gXz9SkiSHKjmFd4oVV4Gy7aKddvJaNraGjZ14rH
	HIvPBWbciSr9ZhAd5sXzzK1gbqe6PjuEs2HeYpsFqMgpPY5KqDSRgZQaQNXF4W6Wb4Y5mEeGoGq
	lc4kqpY9CG1eckjfQbZmEGkK20HDK7vWYP/CPtWfdb9MdREWgp4ha7QyjejloxHJ9/5PrJWTUGE
	ZmBXzf6HyrdH8Qd7O/p4qGEkUzvcdIOmHZe7rYHWFkCMhADBBok+w/+iY/BLoXClAEVKyPkIMGk
	TVZa+/4D/uUJxwBs8sfcR85E71qySE4hRgj0w0N5RPkV3rIZTSq7Pr0qxQ+7bGCpbgK3grX2qMl
	40AKjTl
X-Google-Smtp-Source: AGHT+IF7YU4wyH5DCnIa1xHNwfOTUxRN3Z3UmWPqqY8/JzoeuGL9L4VducxuPGVH8SICTsnA4+h6Uw==
X-Received: by 2002:a05:620a:318a:b0:8b4:ebbe:ae04 with SMTP id af79cd13be357-8c3893a5c0bmr2745515485a.35.1768231579175;
        Mon, 12 Jan 2026 07:26:19 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f5439cbsm1508794985a.55.2026.01.12.07.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:26:18 -0800 (PST)
Date: Mon, 12 Jan 2026 10:25:44 -0500
From: Gregory Price <gourry@gourry.net>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	ziy@nvidia.com, david@kernel.org, lorenzo.stoakes@oracle.com,
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
Subject: Re: [RFC PATCH v3 5/8] Documentation/admin-guide/cgroups: update
 docs for mems_allowed
Message-ID: <aWUSeFzxouq2vwg8@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-6-gourry@gourry.net>
 <o6eky3g4jyvtc2cy6lk7rjc6or6tcvwbhdarrlpn4geuibvrul@65fygkf6vg44>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o6eky3g4jyvtc2cy6lk7rjc6or6tcvwbhdarrlpn4geuibvrul@65fygkf6vg44>

On Mon, Jan 12, 2026 at 03:30:26PM +0100, Michal Koutný wrote:
> Hello.
> 
> On Thu, Jan 08, 2026 at 03:37:52PM -0500, Gregory Price <gourry@gourry.net> wrote:
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -2530,8 +2530,11 @@ Cpuset Interface Files
> >  	cpuset-enabled cgroups.
> >  
> >  	It lists the onlined memory nodes that are actually granted to
> > -	this cgroup by its parent. These memory nodes are allowed to
> > -	be used by tasks within the current cgroup.
> > +	this cgroup by its parent.  This includes both regular SystemRAM
> > +	nodes (N_MEMORY) and Private Nodes (N_PRIVATE) that provide
> > +	device-specific memory not intended for general consumption.
> > +	Tasks within this cgroup may access Private Nodes using explicit
> > +	__GFP_THISNODE allocations if the node is in this mask.
> 
> Notice that these files are exposed for userspace. Hence I'm not sure
> they'd be able to ask for allocations like this (or even need to know
> about this implementation detail).
>

Fair, I can drop this, the intent is actually to limit user-space
knowledge of this at all.

> >  
> >  	If "cpuset.mems" is empty, it shows all the memory nodes from the
> >  	parent cgroup that will be available to be used by this cgroup.
> > @@ -2541,6 +2544,25 @@ Cpuset Interface Files
> >  
> >  	Its value will be affected by memory nodes hotplug events.
> >  
> > +  cpuset.mems.sysram
> > +	A read-only multiple values file which exists on all
> > +	cpuset-enabled cgroups.
> > +
> > +	It lists the SystemRAM nodes (N_MEMORY) that are available for
> > +	general memory allocation by tasks within this cgroup.  This is
> > +	a subset of "cpuset.mems.effective" that excludes Private Nodes.
> > +
> > +	Normal page allocations are restricted to nodes in this mask.
> > +	The kernel page allocator, slab allocator, and compaction only
> > +	consider SystemRAM nodes when allocating memory for tasks.
> > +
> > +	Private Nodes are excluded from this mask because their memory
> > +	is managed by device drivers for specific purposes (e.g., CXL
> > +	compressed memory, accelerator memory) and should not be used
> > +	for general allocations.
> 
> So I wonder whether the N_PRIVATE nodes should be included in
> cpuset.mems[.effective] at all.

I think it makes the control path easier (both more intuitive and easier
to write in the cpuset code), but I can take another look at this.

Although omitting them from .effective i think prevents the user from
controlling whether their memory ends up on that node. 

i.e. the user might be aware that they have compressed memory on node N,
and they have a cgroup that they don't want on node N - not having it
included in mems.allowed / mems.effective means they can't control this.

> (It resembles CPU isolation to me a bit ~ cpuset.cpus.isolated.)
> Maybe you only want to expose it on the root cpuset cg and inverted like
> cpuset.mems.private?
>

Hm, I had not considered adding the separate mask for .private as
opposed to sysram.

If all we actually need to change is the allowed() callback to check an
additional nodemask, that might end up cleaner.

Thank you, I'll take another look at this piece.

~Gregory

