Return-Path: <cgroups+bounces-11407-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB30C1D6E9
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 22:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC9CB34CCBA
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 21:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315B531986C;
	Wed, 29 Oct 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZNlulKx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84DB31961C;
	Wed, 29 Oct 2025 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773233; cv=none; b=CRKxxiTGwIr/TFa/u5EY5IpVzyAuwJtXws3nqw3lDVZi3yhbXbzCLqcQe8GuP1AggbDJt5iweDCCqqjjCYoISWgYG2qlzlvQ3nP0O2xooSOciyOOqYWHWMCTRgFmQRryktDquI9zrc/tJkQ2DR2QS7NYwnBWVEj2LPy4PrGpP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773233; c=relaxed/simple;
	bh=HUtp628QjLPxNtYlW6oWnca/Nvl543Rpcqb9fbnFXSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTZUTwcMM3NSGcZnARjUHGuw251mwWW0eTuSiAK/DhnJRqLyeCRiUI6sPDXPtWsjdapK+KPvNskSk29nKPhTQM6u9x2xL5K2hiJv0rURvgUigi4GReRttBNy/oiY2tf5cs68Tdk0IKt4BIZvl+4+isv0xLnhWajVoEoxy44ZzI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZNlulKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F36C4CEF8;
	Wed, 29 Oct 2025 21:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761773231;
	bh=HUtp628QjLPxNtYlW6oWnca/Nvl543Rpcqb9fbnFXSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZNlulKxj9Ol8N/shr8+sMau99BQNL9iublLIN5KxFadpOi4pfDDtShOiNFmSgTYu
	 zQyz6X+f/w3w1aXroA275pzp+exbTd+E3LMhJH3Ya1RUi7gFxYMHEoho54bXtNKHMG
	 tlAg/gBxtFAtVsw2exc5ISynGzdNNuekCQqa90G9r2YBWqLPZGquiDONgA4XmAXML0
	 hsVnDLmw5GOrA2JRKrPybUYshcUFq6Wcb8jEm7Xq3zeigf38bdmLxXxTmfIfDn5qUx
	 gwKzISPh7Pm2a9kv+AAYWsH1oarD5XJNSH8f7G13mKUo0w9kWg0oMaa9rmmP6SFb6R
	 7DXVDVm0yDP3A==
Date: Wed, 29 Oct 2025 11:27:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops
 to cgroups
Message-ID: <aQKGrqAf2iKZQD_q@slm.duckdns.org>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev>
 <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev>
 <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>

Hello,

On Wed, Oct 29, 2025 at 02:18:00PM -0700, Song Liu wrote:
...
> How about we pass a pointer to mem_cgroup (and/or related pointers)
> to all the callbacks in the struct_ops? AFAICT, in-kernel _ops structures like
> struct file_operations and struct tcp_congestion_ops use this method. And
> we can actually implement struct tcp_congestion_ops in BPF. With the
> struct tcp_congestion_ops model, the struct_ops map and the struct_ops
> link are both shared among multiple instances (sockets).
> 
> With this model, the system admin with root access can load a bunch of
> available oom handlers, and users in their container can pick a preferred
> oom handler for the sub cgroup. AFAICT, the users in the container can
> pick the proper OOM handler without CAP_BPF. Does this sound useful
> for some cases?

Doesn't that assume that the programs are more or less stateless? Wouldn't
oom handlers want to track historical information, running averages, which
process expanded the most and so on?

Thanks.

-- 
tejun

