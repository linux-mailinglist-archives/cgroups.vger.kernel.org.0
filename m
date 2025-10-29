Return-Path: <cgroups+bounces-11404-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3016C1D394
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 21:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF90188469B
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 20:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8508B31691B;
	Wed, 29 Oct 2025 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrC5gWSU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2782773F0;
	Wed, 29 Oct 2025 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770201; cv=none; b=QvmnMQ6e5o5UnZxCFMB2wSEPJBncuBYr0ffTbwpLWre2XTSRnwoMRpIP9NagsMlM7XaUJ2boREPDXnp1u+5cVnf/vAD8ra6X8WY3rUpitjiLVizlmqrx/XZE1lMipqupJM7vj6PA8CTyOogiGUtEROg2Msb4Rl9sK38SZ2R5wZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770201; c=relaxed/simple;
	bh=iOgHS+eZEE/s/+7/l6K7Sr/3V+3Pj70ijnv3Cvpoook=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwTNo8Cu/OgZv6mCQo3VgmgqF4NFBjzYxlgxL1TbIwSTEfnWTXRBJoxtdvkorsQoSMU/EmrA3B4aEm/of9RJ5zPDiZLE+GHrv/+5ovKnAahwuQNTdXH4E9oShKturquOkHRV12uv5GmvcyA/pr6yy9AZLP8fkRDUdY1WW3fjCT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrC5gWSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19A6C4CEF7;
	Wed, 29 Oct 2025 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761770201;
	bh=iOgHS+eZEE/s/+7/l6K7Sr/3V+3Pj70ijnv3Cvpoook=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrC5gWSUJMcUvoYLDXbfHIwK1tb2VBfHwJxQHwh7TzSL5xh8sdvcpQx06xLCpGTzD
	 6QQbbuzI+A/83Qlo+5BQGNuXpAkQyO09qgmnhxbREexwqrM9/pbeWYilD3XQafjfXD
	 HLxEIloCvEhH93/Qn0m2ZleVlXUNdrWWQldZwdOuIPMn2PXL+rj2ACGEwkcb3AhzfC
	 8VL8fzNYLHsdvEe95oaGzi6RelBNNgGhKSWy70B1SDCA6SFjt2zL0ax7ezldRCYICq
	 v5gj8faxK3Pe1LhmNADlsWAcETHsfwvDKTaSu7gFesptWU5Y/ZMOVqtl5nwTqZCsqJ
	 P7/gghhtBrsOw==
Date: Wed, 29 Oct 2025 10:36:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops
 to cgroups
Message-ID: <aQJ61wC0mvzc7qIU@slm.duckdns.org>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev>
 <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldkte9pr.fsf@linux.dev>

On Wed, Oct 29, 2025 at 01:25:52PM -0700, Roman Gushchin wrote:
> > BTW, for sched_ext sub-sched support, I'm just adding cgroup_id to
> > struct_ops, which seems to work fine. It'd be nice to align on the same
> > approach. What are the benefits of doing this through fd?
> 
> Then you can attach a single struct ops to multiple cgroups (or Idk
> sockets or processes or some other objects in the future).
> And IMO it's just a more generic solution.

I'm not very convinced that sharing a single struct_ops instance across
multiple cgroups would be all that useful. If you map this to normal
userspace programs, a given struct_ops instance is package of code and all
the global data (maps). ie. it's not like running the same program multiple
times against different targets. It's more akin to running a single program
instance which can handle multiple targets.

Maybe that's useful in some cases, but that program would have to explicitly
distinguish the cgroups that it's attached to. I have a hard time imagining
use cases where a single struct_ops has to service multiple disjoint cgroups
in the hierarchy and it ends up stepping outside of the usual operation
model of cgroups - commonality being expressed through the hierarchical
structure.

Thanks.

-- 
tejun

