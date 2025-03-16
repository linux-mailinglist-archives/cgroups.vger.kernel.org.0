Return-Path: <cgroups+bounces-7095-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8979A6337B
	for <lists+cgroups@lfdr.de>; Sun, 16 Mar 2025 04:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FD73B0E2E
	for <lists+cgroups@lfdr.de>; Sun, 16 Mar 2025 03:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EA3131E49;
	Sun, 16 Mar 2025 03:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IxhMmR7P"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48042AE9A;
	Sun, 16 Mar 2025 03:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097481; cv=none; b=YydLOV4ShYZ9pefYMfP4I2nKtM8oL0qe+qNVYBQxPyVVXnCdmnzJDVqDH91nEfJiCkS2vtuVSAoMeTxK9V8AqKb0P9ajAxV4qUvoUVPoLpn6hk8OycjNPDMVYMG4MTVjuPeQ0CkLeCBq1VnniU3G0TskLkN0kAZQW/Gn/fOldXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097481; c=relaxed/simple;
	bh=9FGAGyH1LQtzxfMA7xgcYqIxmi2gZlRJ+AD9AfajveY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sjuY7pTWFYv9dRpzFgD5kaiDSp+lEoEBxAnrJdLaldsA+47enVtLbl7NFMIHF5rRsEjVUNCGxC5Jx2MaNEEiboXnkPMvBwG1agL+uRV+raoU47wBFrPG6ep8s0xXk+z+kMs0Rgxq4ZOQtCBD4+ihiPaLoH1SHX8kk+FcbsfTX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IxhMmR7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED42C4CEDD;
	Sun, 16 Mar 2025 03:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742097481;
	bh=9FGAGyH1LQtzxfMA7xgcYqIxmi2gZlRJ+AD9AfajveY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IxhMmR7Pjglyh5HkeMOcVf8apu8/nF7EdVW8Cxpnv4SAAtW2l6N53sXuhJnhTtSCT
	 Kh0X7xTw149zzQ9JY1nveMUeR9IvIRF4iOCjw+950g8xDHLyCImdOWxTmVGX57U8Dv
	 DyQzCL+Rw2epAYaxwjcKCqcym24hLCANDKnGKk0g=
Date: Sat, 15 Mar 2025 20:57:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song
 <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Meta kernel team
 <kernel-team@meta.com>
Subject: Re: [PATCH 0/9] memcg: cleanup per-cpu stock
Message-Id: <20250315205759.c9f9cdfc2c20467e4106c41a@linux-foundation.org>
In-Reply-To: <20250315174930.1769599-1-shakeel.butt@linux.dev>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Mar 2025 10:49:21 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> 
> This is a cleanup series which is trying to simplify the memcg per-cpu
> stock code, particularly it tries to remove unnecessary dependencies on
> local_lock of per-cpu memcg stock. The eight patch from Vlastimil
> optimizes the charge path by combining the charging and accounting.
> 
> This series is based on next-20250314 plus two following patches:
> 
> Link: https://lore.kernel.org/all/20250312222552.3284173-1-shakeel.butt@linux.dev/
> Link: https://lore.kernel.org/all/20250313054812.2185900-1-shakeel.butt@linux.dev/

Unfortunately the bpf tree has been making changes in the same area of
memcontrol.c.  01d37228d331 ("memcg: Use trylock to access memcg
stock_lock.")

Sigh.  We're at -rc7 and I don't think it's worth working around that
for a cleanup series.  So I'm inclined to just defer this series until
the next -rc cycle.

If BPF merges reasonably early in the next merge window then please
promptly send this along and I should be able to squeak it into
6.15-rc1.


