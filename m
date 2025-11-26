Return-Path: <cgroups+bounces-12210-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D765C88A1F
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 09:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 847B74E241A
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 08:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46574315760;
	Wed, 26 Nov 2025 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GmyXSOU3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42218285071
	for <cgroups@vger.kernel.org>; Wed, 26 Nov 2025 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764145762; cv=none; b=V2lg7udCX0s8mugYt/lCgQ/MypueiLEEhnzgixvls+JAUxU2yTADIW+IJA36W7XEwoA+G/n/j5AVpocMg5iq2cEgNuVyAsFugPgOzREE5/1hD7kdIKjhRgF0TRALZ1k7X8pH/erZt+qNQBVGxo29myLguFFMwxlr7nljfnQYdhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764145762; c=relaxed/simple;
	bh=KmE6Igx4ArlklYpCUhW2nfSXXQpiVHQ/XePwfChAx2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQc7OfA2PbaKp5saB5s7g6r4I/eWk4TLQ+zLcOC1xkw/2UOw59GPXqIZxQfeqStdfBqvUEIgBVGT+dNsdPNDvI7maE0Nk0R4XJ1anith6rHZJPXS9kiyw0drw+DF7OA8PyL6zXeSqmqH6DJzTWs20ePHD0Sk7HliM0gD/OEE/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GmyXSOU3; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ee13dc0c52so52216401cf.2
        for <cgroups@vger.kernel.org>; Wed, 26 Nov 2025 00:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1764145759; x=1764750559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LpTPqSNb5/1LIA5hUrs72gqy0nx3RKk/281zC2fbaaY=;
        b=GmyXSOU3a7ZwoWhtW6Heu2r0e8UiyJjsHXq9uNhwcI8f9w7gHXKQ/WB9j+b4kPZejd
         1UDWBTbd379HWbCU6UT2NNLsq/X1qK5OpP5TaRClURpOYQwFB/Esis3AtcVaQtX3RO7Y
         ZilMpdWI0mjjqqsJd+FF8hVt3a3OUu3pq/fi4sVWe4YJOUNBgt2oi98nSsNuNV4ZfV4g
         5PRgx51YIo8LvPe7M+EuT78U2kzEuaon8UqVtEfScaDCnkyxg2bpvZmucryCCF+wyZST
         9dNcZflrzpXveW8GkvL1OxYzjaclt9iF/V/+CgBNwACd0NlJ77eVV/UxZgjd2pG5jMO8
         9p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764145759; x=1764750559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpTPqSNb5/1LIA5hUrs72gqy0nx3RKk/281zC2fbaaY=;
        b=Eb3/61uek1C56NRQwHIT4sNLH/1DA3xz6HDXgQlnqu7/lbcyW7FU/GZmxEbWppfwMA
         9tSgVe7HwKG7J9D/sBYG6SsllLf1fAtN1nh5VtHLiHQHAEakPZZkewJWlurYhsSt7NEE
         iTPtN+w6JAtaNpmBnYhhi4IWbwOBspaSbShW7QJizaB7BkTKC7XlEq9KxtRLBla+Xn/P
         hOih/puuEhg8//pcQGWMAmJW2d5st4O/uwJHkvYLbetftD9EYsMllCvlKbWE0Pqn57iH
         WjLMchjhzlVfzCUVIuAa+OLP0ib8sKxTedmFWV7M4TrRhJe8abAjrU3BEwq+h8OiTBG3
         F8aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfrb0fZ5zcEw/g/QdtaVUSoxNz8nbkUa+7hwrMyVQeGoz383WKL67F6YGwB6A7EuGh0CVBUBSY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6t+Hm3dbYF2DYabL0WgxGf4RxTCDYY9kZ2LBrmviMAerEFS7I
	Q0TUTZjmQlboSLT1GBugfkn1ohBS7whJEMAMepeXYJbYLEYPG+SR4avI/WQXNq9xEJc=
X-Gm-Gg: ASbGncsfBs4CueBxRPoF2LpwUJ6UPxMChxB0lr9xcEjdzkNpErwVCijtUp+a+mkhU/B
	dVAQY/cAWUtMmB/R5Jg5HJmtJVUyNFmio64TVg30M0FUCIzFsyK3K0V5XrQwG0VeWwbwLCY6SpV
	1VlQXXqaT9SOkvsKWU/pikbSwELziQyXiXAxn+xxyg/PODQl/VA5zrRvjX5Q6gkqHkW2u3Qw4RD
	ikAssFP+ur6kQM/JSRTYQV5fq5+N1kO+ZjiFTYQXn4HJBIm6aHn2rWNJf2Qfz9bKji4QVZXQJwv
	XxHivRJHW53eiUEtHuGnE8hFUXSMPSBEYk2KvTfPU63Ie4sqPxAFlGv0tgJcL2Pa8JWcNIqgN0b
	8ZWolEI3+bAPADALHH44i2eYaMgTlBF2o+c74IIQLGlidI5GCfUN21XYHakFxEzXSyOwUdLTnIy
	6kHjgmME+5iudux3xTZEH6Vul8JQVDtFGvSqXDrXZx09MJn49k09bs3icXQJsPnvwY4rnSeQ==
X-Google-Smtp-Source: AGHT+IHuUv0EzqPvaVNL3leGpr9lqb8F9vUc6VmdQSLEZ6njqgrsaluCQ4pnfGmE+DrmYi9rZ0TzBg==
X-Received: by 2002:ac8:7c4c:0:b0:4ed:e40c:872d with SMTP id d75a77b69052e-4ee58b12a27mr235496851cf.59.1764145758923;
        Wed, 26 Nov 2025 00:29:18 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee4cbc3c81sm113574331cf.16.2025.11.26.00.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:29:17 -0800 (PST)
Date: Wed, 26 Nov 2025 03:29:14 -0500
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-mm@kvack.org, kernel-team@meta.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, kees@kernel.org, muchun.song@linux.dev,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	rientjes@google.com, jackmanb@google.com, cl@gentwo.org,
	harry.yoo@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com, rrichter@amd.com,
	ming.li@zohomail.com, usamaarif642@gmail.com, brauner@kernel.org,
	oleg@redhat.com, namcao@linutronix.de, escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: Re: [RFC LPC2026 PATCH v2 00/11] Specific Purpose Memory NUMA Nodes
Message-ID: <aSa6Wik2lZiULBsg@gourry-fedora-PF4VCD3F>
References: <20251112192936.2574429-1-gourry@gourry.net>
 <48078454-f441-4699-9c50-db93783f00fd@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48078454-f441-4699-9c50-db93783f00fd@nvidia.com>

On Wed, Nov 26, 2025 at 02:23:23PM +1100, Balbir Singh wrote:
> On 11/13/25 06:29, Gregory Price wrote:
> > This is a code RFC for discussion related to
> > 
> > "Mempolicy is dead, long live memory policy!"
> > https://lpc.events/event/19/contributions/2143/
> > 
> 
> :)
> 
> I am trying to read through your series, but in the past I tried
> https://lwn.net/Articles/720380/
> 

This is very interesting, I gave the whole RFC a read and it seems you
were working from the same conclusion ~8 years ago - that NUMA just
plainly "Feels like the correct abstraction".

First, thank you, the read-through here filled in some holes regarding
HMM-CDM for me.  If you have developed any other recent opinions on the
use of HMM-CDM vs NUMA-CDM, your experience is most welcome.


Some observations:

1) You implemented what amounts to N_SPM_NODES 

   - I find it funny we separately came to the same conclusion. I had
     not seen your series while researching this, that should be an
     instructive history lesson for readers.

   - N_SPM_NODES probably dictates some kind of input from ACPI table
     extension, drivers input (like my MHP flag), or kernel configs
     (build/init) to make sense.

   - I discussed in my note to David that this is probably the right
     way to go about doing it. I think N_MEMORY can still be set, if
     a new global-default-node policy is created.

   - cpuset/global sysram_nodes masks in this set are that policy.


2) You bring up the concept of NUMA node attributes

   - I have privately discussed this concept with MM folks, but had
     not come around to formalize this.  It seems a natural extension.

   - I wasn't sure whether such a thing would end up in memory-tiers.c
     or somehow abstracted otherwise.  We definitely do not want node
     attributes to imply infinite N_XXXXX masks.


3) You attacked the problem from the zone iteration mechanism as the
   primary allocation filter - while I used cpusets and basically
   implemented a new in-kernel policy (sysram_nodes)

   - I chose not to take that route (omitting these nodes from N_MEMORY)
     precisely because it would require making changes all over the
     kernel for components that may want to use the memory which
     leverage N_MEMORY for zone iteration.

   - Instead, I can see either per-component policies (reclaim->nodes)
     or a global policy that covers all of those components (similar to
     my sysram_nodes).  Drivers would then be responsible to register
     their hotplugged memory nodes with those components accordingly.

   - My mechanism requires a GFP flag to punch a hole in the isolation,
     while yours depends on the fact that page_alloc uses N_MEMORY if
     nodemask is not provided.  I can see an argument for going that
     route instead of the sysram_nodes policy, but I also understand
     why removing them from N_MEMORY causes issues (how do you opt these
     nodes into core services like kswapd and such).

     Interesting discussions to be had.


4)   Many commenters tried pushing mempolicy as the place to do this.
     We both independently came to the conclusion that 

   - mempolicy is at best an insufficient mechanism for isolation due
     to the way the rest of the system is designed (cpusets, zones)

   - at worst, actually harmful because it leads kernel developers to
     believe users view mempolicy APIs as reasonable. They don't.
     In my experience it's viewed as:
         - too complicated (SW doesn't want to know about HW)
         - useless (it's not even respected by reclaim)
         - actively harmful (it makes your code less portable)
	 - "The only thing we have"

Your RFC has the same concerns expressed that I have seen over past
few years in Device-Memory development groups... except that the general
consensus was (in 2017) that these devices were not commodity hardware
the kernel needs a general abstraction (NUMA) to support.

"Push the complexity to userland" (mempolicy), and
"Make the driver manage it." (hmm/zone_device)

Have been the prevailing opinions as a result.

From where I sit, this depends on the assumption that anyone using such
systems is presumed to be sophisticated and empowered enough to accept
that complexity.  This is just quite bluntly no longer the case.

GPUs, unified memory, and coherent interconnects have all become
commodity hardware in the data center, and the "users" here are
infrastructure-as-a-service folks that want these systems to be
some definition of fungible.

~Gregory

