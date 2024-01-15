Return-Path: <cgroups+bounces-1146-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B624182D37D
	for <lists+cgroups@lfdr.de>; Mon, 15 Jan 2024 04:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E81B1C20AB5
	for <lists+cgroups@lfdr.de>; Mon, 15 Jan 2024 03:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452F41874;
	Mon, 15 Jan 2024 03:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LzoUNv4L"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A701842
	for <cgroups@vger.kernel.org>; Mon, 15 Jan 2024 03:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705290581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pdqooBRNRG8xhD7RtuZdDMFytmkOMTAPnRjl9s6aRY=;
	b=LzoUNv4L8rCprnbUopJFyobK8/ugRm07sdEUX69Ib6+d4KxGe2oSndYFlZlWC972/1uVPl
	jyW2FTEoUN1tmFoLXNLWG5mbUBcSOlkvhdZTEUEIaVf7duqDYfLfGLNhwYYItny7OknaDY
	RbVmamsIg5Iy6sGiE+zVVkhJHVd8/Po=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 2/4] memcg: Return the folio in union mc_target
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240111181219.3462852-3-willy@infradead.org>
Date: Mon, 15 Jan 2024 11:49:09 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeelb@google.com>,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB0449C5-B0D0-46B4-BF5F-DD32378ED047@linux.dev>
References: <20240111181219.3462852-1-willy@infradead.org>
 <20240111181219.3462852-3-willy@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Migadu-Flow: FLOW_OUT



> On Jan 12, 2024, at 02:12, Matthew Wilcox (Oracle) =
<willy@infradead.org> wrote:
>=20
> All users of target.page convert it to the folio, so we can just =
return
> the folio directly and save a few calls to compound_head().
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


