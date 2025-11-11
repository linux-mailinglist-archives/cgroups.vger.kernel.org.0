Return-Path: <cgroups+bounces-11824-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD91C4F85E
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 19:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEAB18978B8
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AF02D193F;
	Tue, 11 Nov 2025 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NRm7sPR+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F8B2D0610
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887596; cv=none; b=S/9b0OJLO1/fwO7HNxnK466wvD1NoR4UG28MgOxdDVxvaZ1hPzBL1pIdYACYcUJ7dVsZtYVx1v6lRkuYQxdiTqAFCMqKHdX0k2Oc4Gvc2h5+aGtKbyrtKHv0Z8qPfGuI4iVmSfl9xhHjPpRBdZW0v4R1BxXf8jMcSsHydJuUs9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887596; c=relaxed/simple;
	bh=UMnEps90lDVVxQpCV0D0SupS08uIJn0CtLAQpVuX40E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kYOjeoTcv4hHKygVyvi/Reh/Kyk+dyk9IMiXeZ5KmlNinaranCi1FHPYWuz4/kcdl776iURn1qjPUb//62RZ1SSdKnmJKknB/tcfH70Ox6nMyKat0jwmsxqNcSVcpMzVnuAdjydl5zXkvf/KJj2lBvtzIKar2XYwp1RVo+54Gc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NRm7sPR+; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762887593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMnEps90lDVVxQpCV0D0SupS08uIJn0CtLAQpVuX40E=;
	b=NRm7sPR+NTC4j8oIQHpvopN6jNVoYW/ZMofwhUSzPQEo1Ux3CnCGioBiEM+9C6Q+Kdfh9c
	nrz1kfBvONTID8CAT+XGPRraT244HZrAO3hkwarmn1Tx3IOOutvqhPzYEGQlHQNVhlucOX
	KrIgBZbSrNylk/B/CLMxMDEOJICoQ9Y=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  Harry Yoo <harry.yoo@oracle.com>,  Qi Zheng
 <qi.zheng@linux.dev>,  Vlastimil Babka <vbabka@suse.cz>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 4/4] memcg: remove __lruvec_stat_mod_folio
In-Reply-To: <20251110232008.1352063-5-shakeel.butt@linux.dev> (Shakeel Butt's
	message of "Mon, 10 Nov 2025 15:20:08 -0800")
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
	<20251110232008.1352063-5-shakeel.butt@linux.dev>
Date: Tue, 11 Nov 2025 10:59:39 -0800
Message-ID: <877bvws8dg.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> The __lruvec_stat_mod_folio is already safe against irqs, so there is no
> need to have a separate interface (i.e. lruvec_stat_mod_folio) which
> wraps calls to it with irq disabling and reenabling. Let's rename
> __lruvec_stat_mod_folio to lruvec_stat_mod_folio.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

