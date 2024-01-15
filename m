Return-Path: <cgroups+bounces-1144-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 286D082D379
	for <lists+cgroups@lfdr.de>; Mon, 15 Jan 2024 04:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4F31F212C2
	for <lists+cgroups@lfdr.de>; Mon, 15 Jan 2024 03:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B24F186A;
	Mon, 15 Jan 2024 03:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="slhUawWM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F43C0E
	for <cgroups@vger.kernel.org>; Mon, 15 Jan 2024 03:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705290470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jebd+RGWzko/y8FJ3W/lxOQ7i1Zx7P/IYA5CYH3wh8g=;
	b=slhUawWM/XeAvkFI+of/hbQzf2zkzJ1SARvvrkZE1ajUQIylE0cA4z56b7vMm9xAmoJPGJ
	RT3EogmQTpXxplO3Bel3n0GzjukOP5kXhjS1x6lFKaCQNqIjCTGp6mJ/1Tx2OpTIe91EwI
	xoHwdkAw3TQUYx6xgSW2QXPbRoHngIk=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 4/4] memcg: Use a folio in get_mctgt_type_thp
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240111181219.3462852-5-willy@infradead.org>
Date: Mon, 15 Jan 2024 11:47:05 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeelb@google.com>,
 cgroups@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <20100114-DAD7-456D-9054-A8523AC070F6@linux.dev>
References: <20240111181219.3462852-1-willy@infradead.org>
 <20240111181219.3462852-5-willy@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Migadu-Flow: FLOW_OUT



> On Jan 12, 2024, at 02:12, Matthew Wilcox (Oracle) =
<willy@infradead.org> wrote:
>=20
> Replace five calls to compound_head() with one.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


