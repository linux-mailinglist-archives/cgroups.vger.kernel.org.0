Return-Path: <cgroups+bounces-11821-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE69C4F84C
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 19:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A803E1896050
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 18:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6393E2C325A;
	Tue, 11 Nov 2025 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rHob7y7U"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084A2C3248
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887513; cv=none; b=aptupP2t29UpylLJXUc8LdUCjPv5BgftZ/MHFRgFI+BEP4WJenrBjIC1fOe7azJ2v6zbhUXfsQdn/qbmThuSQXWo1BQSVk2jzCdNu5funGws+jdJLobWgTEOHq1/YCO+XJoVi0zXIVZSgc6//+6yLRpyImRIw6P43NBTBdincw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887513; c=relaxed/simple;
	bh=Kx+FXBuhKKRAGKrr5/plFPqCKumMeNYYYtkhE4HBypE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SPOiWyO931HCUZt0zfeJydbasn1plFPpC4keyTWvd4k6stEH2pHBcZyks7RAJqrrcrZSKqLXoR/jwQVDAigB4pv5Cz3NNV88rBs4VMsSQ++bthxmF9rPaEoUdG7/ky6pM5CB98WPP851+8CX8Bnw2aVtQ9XYhuC/bQ5NRz7507s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rHob7y7U; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762887495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kx+FXBuhKKRAGKrr5/plFPqCKumMeNYYYtkhE4HBypE=;
	b=rHob7y7UWymH1inhA1ByOYabtPCUkfecfAjIaljlgEHiACDBJFHtSRnSanQ5oSsgZ5Z1fH
	z8kMqD4pdBecZSRUvP+pOZ00ZD+9iEjeQ8tA9GB2z/gu5UR5HxNvSKYl0XRxAuNjm27kt4
	d/V9G4AruJodXnPdobBbAcDYHa4jikc=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  Harry Yoo <harry.yoo@oracle.com>,  Qi Zheng
 <qi.zheng@linux.dev>,  Vlastimil Babka <vbabka@suse.cz>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 1/4] memcg: use mod_node_page_state to update stats
In-Reply-To: <20251110232008.1352063-2-shakeel.butt@linux.dev> (Shakeel Butt's
	message of "Mon, 10 Nov 2025 15:20:05 -0800")
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
	<20251110232008.1352063-2-shakeel.butt@linux.dev>
Date: Tue, 11 Nov 2025 10:58:08 -0800
Message-ID: <87zf8ss8fz.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> The memcg stats are safe against irq (and nmi) context and thus does not
> require disabling irqs. However some code paths for memcg stats also
> update the node level stats and use irq unsafe interface and thus
> require the users to disable irqs. However node level stats, on
> architectures with HAVE_CMPXCHG_LOCAL (all major ones), has interface
> which does not require irq disabling. Let's move memcg stats code to
> start using that interface for node level stats.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

