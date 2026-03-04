Return-Path: <cgroups+bounces-14603-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOXhMWc6qGkTqgAAu9opvQ
	(envelope-from <cgroups+bounces-14603-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 14:57:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E09200D64
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 14:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84F2E302DE73
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 13:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B343A451A;
	Wed,  4 Mar 2026 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI7kGLW6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C78F3A2571;
	Wed,  4 Mar 2026 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632664; cv=none; b=gq+gxYRLHgXhjeRSKaSFo7Xv7vdJDQH/YiToN0kvHV/fON6xKZEmHjHZdpFxjQzoZ4kHvljeysHIys0mGNP56OtqTsk3sMaXP5YoWK0WQ0x9/ehUMypC5+CZ3CL6Xn+uYVfUMKWvecFf4LA8jZ90AeyQbyCchx6zFOHChyCrTeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632664; c=relaxed/simple;
	bh=tZZuIEusYI76qWLnqmMDQyqADb7WG9IIxpS6xVk0MYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUcta7il3pSj5Yu+os4UOgraLKKWDO4YRaeIqp6Nt+a6EAkojPAVQ54Qa625nLnIcDxnnMwXPGCbXhlPeZPcfwfkV+4wjKnPKjc8W3r4lGsjRl6BIiczy4T9JReWk5LdZJj88E1YFLLRFJqcxaJKmKPO+qV2/Nd9gw2rQgx11u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI7kGLW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB621C2BC87;
	Wed,  4 Mar 2026 13:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772632664;
	bh=tZZuIEusYI76qWLnqmMDQyqADb7WG9IIxpS6xVk0MYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eI7kGLW6p2qz7YeQq9jRS6ux5dX6FDMxNBlt+HCSugVKAMTcB4CZ2soKv9SXFrHpC
	 EzgvgvgACH1JTm8mZ5hOXRtdfExzbNQt7yG1djSmjlzNfB2troiv54PANRTbCkpIdx
	 GAUaa//rOSI1tLobgOYu+a+9GQsPBdo+V4h7Ebs/wtJuQ4o9VD9kG0JbRHbwaY0Wzo
	 fzj7T/hMkxgD4+JC8vrk3Aef7WU2ZzsWYa/QL3q3mZCw+NtssDKwqEJZdY6GS3o7M+
	 YGZv13EGK0AITi57Itei8kiZRUurRuy/G76ecfRq91stnmbUOnxZ6NVCgkeuwTBX4w
	 ZC0/ZUgSFNkhw==
Date: Wed, 4 Mar 2026 13:57:41 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, bhe@redhat.com, usamaarif642@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 update 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
Message-ID: <vfmyb3pp2gatdrqa2uimw44pxioreo7zc373zn7buvdfzhejew@ndhaa4yl3bvh>
References: <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
 <20260228072556.31793-1-qi.zheng@linux.dev>
 <CAO9r8zNYFvNnz_oTu10kPBYL6=1ZewKUMRYcMmcMdSqbro_miA@mail.gmail.com>
 <de1476aa-20a3-420e-9cd7-9238efd3c85f@linux.dev>
 <46bgg2vwqvmex7wtk2fkvf454tqgaychb7l4odnnrx7svci5ha@vy4b4ophm763>
 <22cca07c-49e0-42e8-b937-7b1c7c51e78d@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22cca07c-49e0-42e8-b937-7b1c7c51e78d@linux.dev>
X-Rspamd-Queue-Id: 49E09200D64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14603-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 03:56:42PM +0800, Qi Zheng wrote:
> 
> 
> On 3/3/26 10:56 PM, Yosry Ahmed wrote:
> > On Tue, Mar 03, 2026 at 11:08:56AM +0800, Qi Zheng wrote:
> > > Hi Yosry,
> > [..]
> > > > 
> > > > I don't think we should end up with two copies of
> > > > __mod_memcg_state/mod_memcg_state() and
> > > > __mod_memcg_lruvec_state/mod_memcg_lruvec_state(). I meant to refactor
> > > > mod_memcg_state() to call __mod_memcg_state(), where the latter does
> > > > not call get_non_dying_memcg_{start/end}(). Same for
> > > > mod_memcg_lruvec_state().
> > > 
> > > Okay, like the following? But this would require modifications to
> > > [PATCH v5 31/32]. If there are no problems, I will send the updated
> > > patch to [PATCH v5 29/32] and [PATCH v5 31/32].
> > 
> > I cannot apply the diff, seems a bit corrupted.
> > 
> > But ideally, instead of a @reparent argument, we just have
> > __mod_memcg_lruvec_state() and __mod_memcg_state() do the work without
> > getting parent of dead memcgs, and then mod_memcg_lruvec_state() and
> > mod_memcg_state() just call them after get_non_dying_memcg_start().
> > 
> > What about this (untested), it should apply on top of 'mm: memcontrol:
> > eliminate the problem of dying memory cgroup for LRU folios' in mm-new,
> > so maybe it needs to be broken down across different patches:
> > 
> 
> I applied  and tested it, so the final updated patches is as follows,
> If there are no problems, I will send out the official patches.

If I am not mistaken, Andrew prefers fixups to what he already has in
mm-new (Andrew, please correct me if I am wrong).

