Return-Path: <cgroups+bounces-1145-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9924D82D37C
	for <lists+cgroups@lfdr.de>; Mon, 15 Jan 2024 04:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B157A281573
	for <lists+cgroups@lfdr.de>; Mon, 15 Jan 2024 03:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4AE1874;
	Mon, 15 Jan 2024 03:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CyfHwlke"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72FB1842
	for <cgroups@vger.kernel.org>; Mon, 15 Jan 2024 03:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705290544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTemb/S8RbpIYK+jm7rNjBIvuW0Uveef0ozh45+P1zM=;
	b=CyfHwlke+1eTV0dpB6WDoWiWvfZVnJFe9tfx+GQWa36PG7+EU5Mq1dgtkMXyIUFLIi8te3
	Gno59f13pXVTcwypIe5HFuG/eILpagvHwBF7BwPBZgou+nl/u9av/7jhhGbZ31uZ4VnuIj
	ONJTPSrYvQv60251FXz53WqvIBheYKk=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 3/4] memcg: Use a folio in get_mctgt_type
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240111181219.3462852-4-willy@infradead.org>
Date: Mon, 15 Jan 2024 11:48:26 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeelb@google.com>,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E888839-71E2-404E-8DC1-7C59DD25A405@linux.dev>
References: <20240111181219.3462852-1-willy@infradead.org>
 <20240111181219.3462852-4-willy@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Migadu-Flow: FLOW_OUT



> On Jan 12, 2024, at 02:12, Matthew Wilcox (Oracle) =
<willy@infradead.org> wrote:
>=20
> Replace seven calls to compound_head() with one.  We still use the
> page as page_mapped() is different from folio_mapped().
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


