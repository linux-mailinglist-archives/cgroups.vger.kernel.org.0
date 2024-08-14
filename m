Return-Path: <cgroups+bounces-4266-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8A795243C
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 22:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930711C21975
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 20:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C411C9EC4;
	Wed, 14 Aug 2024 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LO88hM3L"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA991C3F0E
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668530; cv=none; b=cnMPHpY1tbhS1vP34iKECdXh6zhvawGI91YPqFycUghiNE19EAO3b3fhnys/pLiD6ZPyUlSaK1w91GvYxA1OLvrAqaNQYepcyWmqteu7i0B0OClqbuILDQl9MSvar8zn/AntTj82sjw1xnqkYfW5UXGTJ+QwQKnAoUDtIjBvrqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668530; c=relaxed/simple;
	bh=Bh66MDLuw1yvnch9iVnkCZn0n83o3MMWU2nFRyqitdY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UJOXEe4bqmNj3D8dHUexK+IBv0Epd4c9VOMfX/lyl2X/EVq1EAxNDfCRc+f6AHHdYmTfkydF86A/QgJsPEA3ZI3tgurLtRGpfT5XOW5p4KgWZehTcTL/nwQuHdH5zs2f5sl418uKSpdORF3qSRS67QGQVbnvR9x2x4Nc9BQ8jg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LO88hM3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8358C116B1;
	Wed, 14 Aug 2024 20:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723668529;
	bh=Bh66MDLuw1yvnch9iVnkCZn0n83o3MMWU2nFRyqitdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LO88hM3LOhPz6SYYPmi5fqPdVR1I1E9cOYrwECbZOtmhIxkng83sLvLrc/1b661lC
	 YsD5e6FpNHZLJeHqZPaF8LpZCDKNQSoxPCwDMC4bNpsl3EIOhhoxNQPLagRhja4oPK
	 DaYoO+7VrpxgQIXhj7M8lm/oHJapqQCEhRPhKgs4=
Date: Wed, 14 Aug 2024 13:48:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Cc: David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, mhocko@kernel.org, nehagholkar@meta.com,
 abhishekd@meta.com, hannes@cmpxchg.org
Subject: Re: [PATCH] mm,memcg: provide per-cgroup counters for NUMA
 balancing operations
Message-Id: <20240814134848.1c9d59bb03a524f8462eda3f@linux-foundation.org>
In-Reply-To: <ZrqRXtVAkbC-q9SP@localhost.localhost>
References: <20240809212115.59291-1-kaiyang2@cs.cmu.edu>
	<e34a841c-c4c6-30fd-ca20-312c84654c34@google.com>
	<ZrqRXtVAkbC-q9SP@localhost.localhost>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 22:49:02 +0000 Kaiyang Zhao <kaiyang2@cs.cmu.edu> wrote:

> On Sun, Aug 11, 2024 at 01:16:53PM -0700, David Rientjes wrote:
> > Hi Kaiyang, have you considered per-memcg control over NUMA balancing 
> > operations as well?
> > 
> > Wondering if that's the direction that you're heading in, because it would 
> > be very useful to be able to control NUMA balancing at memcg granularity 
> > on multi-tenant systems.
> > 
> > I mentioned this at LSF/MM/BPF this year.  If people believe this is out 
> > of scope for memcg, that would be good feedback as well.
> 
> Yes that's exactly where we are heading -- per-cgroup control of NUMA
> balancing operations in the context of memory tiering with CXL memory,
> by extending the concept of memory.low and memory.high. The use case is
> enabling a fair share of top tier memory across containers.
> 
> I'm collaborating with Meta on this, and we already have an implementation
> and some experiments done. The patches will go out soon. If others have 
> thoughts on this, please chime in.

I think it's helpful to capture such broad-brush where-this-is-heading
info in the changelogs.  For reviewers and for posterity.

In fact, any reviewer question should be treated as a bug report
against the changelog!  Questions mean that information was missing.

I'll grab v3 now, but please feel free to send along any changelog
additions which come to mind.

