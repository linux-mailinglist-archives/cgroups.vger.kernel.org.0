Return-Path: <cgroups+bounces-11300-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCD6C16807
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 19:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327B71C20B3C
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 18:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A23D34DCF9;
	Tue, 28 Oct 2025 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkXPJs4s"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD529B793;
	Tue, 28 Oct 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676525; cv=none; b=ZsSGfNi01iQ3ar5aFfXYXHLkd26k9cMrpAqvYkhlmrsqjyTZ8Cd0fSlVzxzcbEPyIikk0Bhh/IEixEoXL0MMAPXhf1LagSRsffGI436M5fggOr4RQRUbsKjIkGVQleO4MthUhf2uXAf9Y5ve7jOJxEgUlOPflsZWiY8mo/pmHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676525; c=relaxed/simple;
	bh=3UXcs294ueg+A3S/kQ6Q1+2MpVpVfHJWY6pMkZKx6dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1xmz+XmkYg8m8EC6Omcz50TgYHhnBI8H62hiGLctKIhDQaNByNoGZRbIX4zjrTCpLBPErL6ztwMp8DCZB3mTXz0HUWqDR+d5hCxDkQQO2JhSTUkZ9IdMSq4km7iMV9S3kF3FODPs69s0ASvNBam+PhfiaoPhkGc3Axat975WqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkXPJs4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D9BC4CEE7;
	Tue, 28 Oct 2025 18:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761676525;
	bh=3UXcs294ueg+A3S/kQ6Q1+2MpVpVfHJWY6pMkZKx6dU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkXPJs4sEEStJ7xMb9Lw05H78+Tq98eFF3dp/5EIhMxVw5bC0VmVS7kDVqdn9YQ8G
	 go8ovk54Xd5MkhILdC1Py/3syiXhRYBuPTUTWyoESIZBV5Cx+dCBN5z0x/pM6ir5Mj
	 +uadQz2fg1HM0rdHBLzv/EP0q8gBoiDN9ZZ4DUl+/otcqJWh4w5YJ/2b3Z3Bpxmx+g
	 w933E8ZFI+ovX7wmOXRWafB1iwb12qgsbxLECnywJ/f6G16rTrmb4JKN94J3ull9ag
	 aVl/MvLP16BxNChdQH5i1fX9ZlQxayd6lzjU5G/UBpn+Xc+7+o/xILIhZqTOcthIeQ
	 HvuNmMrJaMfBA==
Date: Tue, 28 Oct 2025 08:35:24 -1000
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
Subject: Re: [PATCH v2 20/23] sched: psi: implement bpf_psi struct ops
Message-ID: <aQEM7LXpZdOpsgvU@slm.duckdns.org>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-10-roman.gushchin@linux.dev>
 <aQD_-a8oWHfRKcrX@slm.duckdns.org>
 <877bweswvo.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bweswvo.fsf@linux.dev>

Hello,

On Tue, Oct 28, 2025 at 11:29:31AM -0700, Roman Gushchin wrote:
> > Here, too, I wonder whether it's necessary to build a hard-coded
> > infrastructure to hook into PSI's triggers. psi_avgs_work() is what triggers
> > these events and it's not that hot. Wouldn't a fexit attachment to that
> > function that reads the updated values be enough? We can also easily add a
> > TP there if a more structured access is desirable.
> 
> Idk, it would require re-implementing parts of the kernel PSI trigger code
> in BPF, without clear benefits.
> 
> Handling PSI in BPF might be quite useful outside of the OOM handling,
> e.g. it can be used for scheduling decisions, networking throttling,
> memory tiering, etc. So maybe I'm biased (and I'm obviously am here), but
> I'm not too concerned about adding infrastructure which won't be used.
> 
> But I understand your point. I personally feel that the added complexity of
> the infrastructure makes writing and maintaining BPF PSI programs
> simpler, but I'm open to other opinions here.

Yeah, I mean, I'm not necessarily against adding infrastructure if the need
is justified - ie. it enables new things which isn't reasonably feasible
otherwise. However, it's also a good idea to start small, iterate and build
up. It's always easier to add new things than to remove stuff which is
already out there. Wouldn't it make more sense to add the minimum mechanism,
see how things develop and add what's identified as missing in the process?

Thanks.

-- 
tejun

