Return-Path: <cgroups+bounces-11413-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF9AC1D9F6
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 23:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09DAE4E2777
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 22:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5719C2E1F00;
	Wed, 29 Oct 2025 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNSYdcVI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC9B1F4617;
	Wed, 29 Oct 2025 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778406; cv=none; b=JVkxcwcsOWY11dcPnChh3FDYpHZ7lcUKrFxMYYD0GFIAHsaI6IgjvEtwHKnORjFc5jdhq+FqedYLj31JoBGhpIHTmdSqo7Lur/qtJHAnhsO2sQcoPa0XcVFJMKH6+SDbcUW6gh6F5GfeaEBQ4/ZvT5h5eaJnhsm2Hpm9sHdCDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778406; c=relaxed/simple;
	bh=yggvcjk/2WC81qOKt/PWdb/tjbxgvfTjTX2rpHVXUJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF7Je91oLv80LkJDQL4nrfRCAgPHElE4z5ijrJcJj5PI4G2BB2en56xRSCqBGPbgv8S6RRcB/GFmcuQQmDXOonp7ysv1Pv7LKaBGoWkCbLHH9zeMVMxkP/0SoZ/rRd2vst/K+lr4R1B1XmgjrWfWgqR0NbRqokrHtq1r0VtUn2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNSYdcVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631A7C4CEF7;
	Wed, 29 Oct 2025 22:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761778405;
	bh=yggvcjk/2WC81qOKt/PWdb/tjbxgvfTjTX2rpHVXUJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vNSYdcVIlQppVl9XK6Hmux4x204Rz0Mjmv+zw+0fcgfwr2x5GT4uX2JIaJmKiL//X
	 +aVu/bx794bAn1J5gyNKRxxVz0q+8aZp9uL5cv8EqLQOy8Lyt/hP6VcqQBR/FvyaY/
	 /QeBzY8X2r50hITutJxTZGLKOmj5UHqgcGJXQu1/XGEaqCUzqPwlFf7hYBuQgTOnvI
	 36PMZHtc6/ylag+OHYh+k+JFW56ct0PXqZZzkrq9q1+pn8B5JxaHI58umNFDsW2n2V
	 wOBsUqUMv5PrXWZdrlXBAU1YQZC0UIRB+gnQWHO5sJEmr/2Sxzfw9OChifWcsUkMGI
	 9D4KgdYDIKG4Q==
Date: Wed, 29 Oct 2025 12:53:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Song Liu <song@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm <linux-mm@kvack.org>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops
 to cgroups
Message-ID: <aQKa5L345s-vBJR1@slm.duckdns.org>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev>
 <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev>
 <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
 <871pmle5ng.fsf@linux.dev>
 <CAADnVQJ+4a97bp26BOpD5A9LOzfJ+XxyNt4bdG8n7jaO6+nV3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ+4a97bp26BOpD5A9LOzfJ+XxyNt4bdG8n7jaO6+nV3Q@mail.gmail.com>

Hello,

On Wed, Oct 29, 2025 at 03:43:39PM -0700, Alexei Starovoitov wrote:
...
> I think the general bpf philosophy that load and attach are two
> separate steps. For struct-ops it's almost there, but not quite.
> struct-ops shouldn't be an exception.
> The bpf infra should be able to load a set of progs (aka struct-ops)
> and attach it with a link to different entities. Like cgroups.
> I think sched-ext should do that too. Even if there is no use case
> today for the same sched-ext in two different cgroups.

I'm not sure it's just that there's no use case.

- How would recursion work with private stacks? Aren't those attached to
  each BPF program?

- Wouldn't that also complicate attributing kfunc calls to the handle
  instance? If there is one struct_ops per cgroup, the oom kill kfunc can
  look that up and then verify that the struct_ops has authority over the
  target process. Multiple attachments can work too but that'd require
  iterating all attachments, right?

Thanks.

-- 
tejun

