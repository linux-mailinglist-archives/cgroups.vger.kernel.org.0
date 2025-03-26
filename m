Return-Path: <cgroups+bounces-7233-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A21D1A70E40
	for <lists+cgroups@lfdr.de>; Wed, 26 Mar 2025 01:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22BA67A511A
	for <lists+cgroups@lfdr.de>; Wed, 26 Mar 2025 00:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B02E57D;
	Wed, 26 Mar 2025 00:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tDIEaqtt"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D0E567
	for <cgroups@vger.kernel.org>; Wed, 26 Mar 2025 00:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742949570; cv=none; b=MoOf8gBgzs+ERWLFD4fAqDfQGb0x+NqsErYZOCO9UC9viiPAYrha/uq2F/3JC2ZXY2jUNv2pPyXyaLUaGpU3e9INQ4lE9zFYwSZsJrkNPfuEI25cr/CLWZCiXmfzpNemyLqi5HRjcZ8/ShduYxl1hKpIRz39Of4Kpxa1xO7WQlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742949570; c=relaxed/simple;
	bh=Q+fPjoCmv+8JmkwR0XKz6pVKjzFPb7BaF7VcLCNAy4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrONiaDeAzjpple35paEJ0uAKFNgqgXZi5I6+I7njWF5qgUSrrAmCYMHSU3umIm7e6N1UFKzYFYoxSB7je81Xh/yjf+hvw+2S6RglgyoQWLfdYUTugm5HnKxpCI/ipiWk1Jnsq3CR4U64LD8/GypeqHWE+qfM5lXjBi9lEPxt+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tDIEaqtt; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Mar 2025 00:39:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742949565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXDsuUboUc9RfyZTHpq+3wvJeMIPLr7k4uMKT3isc6Y=;
	b=tDIEaqttG3JzQ0Prbn8Kzaa3pFLWvahGEMYTw51my6eIU1nHy+XdKNx3LY1j3Dp4sRjfxG
	h1/la0YVQ/etrcTE2yeJjOlUi/MGrGEgMdbvyy/KmkFVjvT0XfASCPZwg1ds127GlGICbf
	ve72A+GgqLu4OFDzNGjwbUidzhvokxg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, tj@kernel.org,
	shakeel.butt@linux.dev, hannes@cmpxchg.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/4 v3] cgroup: use separate rstat api for bpf programs
Message-ID: <Z-NMtwBPXSLEu0xk@google.com>
References: <20250319222150.71813-1-inwardvessel@gmail.com>
 <20250319222150.71813-2-inwardvessel@gmail.com>
 <4akwk5uurrhqo4mb7rxijnwsgy35sotygnr5ugvp7xvwyofwn2@v6jx3qzq66ln>
 <11a80d4a-9776-4a43-8c61-5cc1ad4abbc7@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11a80d4a-9776-4a43-8c61-5cc1ad4abbc7@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 25, 2025 at 11:03:26AM -0700, JP Kobryn wrote:
> On 3/24/25 10:47 AM, Michal Koutný wrote:
> > On Wed, Mar 19, 2025 at 03:21:47PM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
> > > The rstat updated/flush API functions are exported as kfuncs so bpf
> > > programs can make the same calls that in-kernel code can. Split these API
> > > functions into separate in-kernel and bpf versions. Function signatures
> > > remain unchanged. The kfuncs are named with the prefix "bpf_". This
> > > non-functional change allows for future commits which will modify the
> > > signature of the in-kernel API without impacting bpf call sites. The
> > > implementations of the kfuncs serve as adapters to the in-kernel API.
> > 
> > This made me look up
> > https://docs.kernel.org/bpf/kfuncs.html#bpf-kfunc-lifecycle-expectations
> > 
> > The series reworks existing kfuncs anyway, is it necessary to have the
> > bpf_ versions? The semantics is changed too from base+all subsystems
> > flush to only base flush (bpf_rstat_flush()).
> 
> This patch was done based on some conversation in v2 around what to do
> with the kfuncs (bottom of [0]). It's true the kfunc API deviates from
> flush-specific-subsystem approach. Dropping this patch is fine by me and
> I assume it would be ok with Yosry (based on comments at end of [0]),
> but I'll wait and see if he has any input.

Yeah I am okay with dropping this as well.

> 
> [0] https://lore.kernel.org/all/Z8IIxUdRpqxZyIHO@google.com/

