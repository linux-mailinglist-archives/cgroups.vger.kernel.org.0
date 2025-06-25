Return-Path: <cgroups+bounces-8631-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92315AE92BE
	for <lists+cgroups@lfdr.de>; Thu, 26 Jun 2025 01:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B198B1885919
	for <lists+cgroups@lfdr.de>; Wed, 25 Jun 2025 23:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F182D3ED5;
	Wed, 25 Jun 2025 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8W44OG9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8108D2D9799;
	Wed, 25 Jun 2025 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750894211; cv=none; b=VyvnoSTTWHfRxVq+yu/OJ5CXfl0AzSjVrb5kS2v6Vla40mAHjuJzXsybwhMDH9nRz7BjWbFYssL2euMUjYd4PcWUUvluDAYO/W6u3mPyTLn65aTNOwqpgW7ZMudRu5byNC2Fin9CJDDyseswK7sSteHJFvbXONvH4xWSmXHugwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750894211; c=relaxed/simple;
	bh=Cyk1TBnxxpgcg8zPDHyXMCBT5SKpZHjDWYtGzReT2Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIxPz2lb6otdVSoFI5Ye908tb0zVruTbey3a+EPcvVz3+mgXt7fzQt9LJhR314vF7RUNlDzlY4MUfLA0NbbWFBb6YHCn5QjXhzxvESm6+vSW7FlT/CdRFWRLlHLHgzZccsAP+Hz5tNZw8qBQNPfJiSG4yJOz70BtxPD5Yn9q9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8W44OG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940F0C4CEEA;
	Wed, 25 Jun 2025 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750894210;
	bh=Cyk1TBnxxpgcg8zPDHyXMCBT5SKpZHjDWYtGzReT2Fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q8W44OG9Zxk+iRf2iL0uZTpQ5YU73OTrSL1Or/3pXwEda2IFgwjxJFopob6oZiI4q
	 Y7rLX3KiryMkojo8ZKh9dPdXQEmMJe425DPAefw7BSGWShM+tN6WNj7cZVZ4Rb76iw
	 AP85u2yIhipTJGgLOKpEei3M/1oz/O/mjKyktNy4SqUD3LoJ+8dN7TfcfRbGWj+zh4
	 SypYRJzgwuQ701ajDicqMVThQ8T1Kq3QbIjkzodHQ4qns2U13MNhGAayusDcGe5ud1
	 hGbqV7ZUFL95a8/hkj44A5+M1i//O7NDIPqDjxuMbwL5nXyXEV3PyNBStVg9rDJGkC
	 nHAXDi+47rN6g==
Date: Wed, 25 Jun 2025 16:30:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
 andrew@lunn.ch, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4.1] rds: Expose feature parameters via sysfs
 (and ELF)
Message-ID: <20250625163009.7b3a9ae1@kernel.org>
In-Reply-To: <20250623155305.3075686-2-konrad.wilk@oracle.com>
References: <20250623155305.3075686-1-konrad.wilk@oracle.com>
	<20250623155305.3075686-2-konrad.wilk@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 11:51:36 -0400 Konrad Rzeszutek Wilk wrote:
> With the value of 'supported' in them. In the future this value
> could change to say 'deprecated' or have other values (for example
> different versions) or can be runtime changed.

I'm curious how this theoretical 'deprecated' value would work
in context of uAPI which can never regress..

> The choice to use sysfs and this particular way is modeled on the
> filesystems usage exposing their features.
> 
> Alternative solution such as exposing one file ('features') with
> each feature enumerated (which cgroup does) is a bit limited in
> that it does not provide means to provide extra content in the future
> for each feature. For example if one of the features had three
> modes and one wanted to set a particular one at runtime - that
> does not exist in cgroup (albeit it can be implemented but it would
> be quite hectic to have just one single attribute).
> 
> Another solution of using an ioctl to expose a bitmask has the
> disadvantage of being less flexible in the future and while it can
> have a bit of supported/unsupported, it is not clear how one would
> change modes or expose versions. It is most certainly feasible
> but it can get seriously complex fast.
> 
> As such this mechanism offers the basic support we require
> now and offers the flexibility for the future.
> 
> Lastly, we also utilize the ELF note macro to expose these via
> so that applications that have not yet initialized RDS transport
> can inspect the kernel module to see if they have the appropiate
> support and choose an alternative protocol if they wish so.

Looks like this paragraph had a line starting with #, presumably
talking about the ELF note and it got eaten by git? Please fix.


FWIW to me this series has a strong whiff of "we have an OOT module
which has much more functionality and want to support a degraded /
upstream-only mode in the user space stack". I'm probably over-
-interpreting, and you could argue this will help you make real
use of the upstream RDS. I OTOH would argue that it's a technical
solution to a non-technical problem of not giving upstreaming 
sufficient priority; I'd prefer to see code flowing upstream _first_ 
and then worry about compatibility.

$ git log --oneline --since='6 months ago' -- net/rds/ 
433dce0692a0 rds: Correct spelling
6e307a873d30 rds: Correct endian annotation of port and addr assignments
5bccdc51f90c replace strncpy with strscpy_pad
c50d295c37f2 rds: Use nested-BH locking for rds_page_remainder
0af5928f358c rds: Acquire per-CPU pointer within BH disabled section
aaaaa6639cf5 rds: Disable only bottom halves in rds_page_remainder_alloc()
357660d7596b Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
5c70eb5c593d net: better track kernel sockets lifetime
c451715d78e3 net/rds: Replace deprecated strncpy() with strscpy_pad()
7f5611cbc487 rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy
$

IOW applying this patch is a bit of a leap of faith that RDS
upstreaming will restart. I don't have anything against the patch
per se, but neither do I have much faith in this. So if v5 is taking 
a long time to get applied it will be because its waiting for DaveM or
Paolo to take it.

