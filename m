Return-Path: <cgroups+bounces-2974-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B898CB047
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 16:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C85E2B2458F
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 14:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E0212F593;
	Tue, 21 May 2024 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iSz1DDyy"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C9312F367
	for <cgroups@vger.kernel.org>; Tue, 21 May 2024 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301303; cv=none; b=A6+RcRmIgH5hV6xVjaJai/qCMWhrmX5KYPmbXgclgbxchj9wyfsJJyOtzZf4H412hoX/eXG2r4w6voKV1lIQvY3YLMrIlSgYp+9peQeqCPggHUZEw7xGXmLeZ7cgIjXFyTX2pERoLgV1DB+Fh7UXomOqoaBVUYBEYryDN9ABAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301303; c=relaxed/simple;
	bh=lAkN652G06UW4KF1PcA55e1MeAsg1wdLyiq7MU5GMQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLUq9qmoeYoyKgOXD2u4ZHUVGeGZYYDuzh7cTbh5wsFZi2ART103FKbK2u9SmwgAlap+ehUF5V7IBfrBA5mrulo4w+Aw0SsxYQ+4vnfR6zkkKZRhNbPm+10XAebdaFS/2HyTAUiN/JkklL7gCQVLFk7Hq78XtncmyKDx0jMJVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iSz1DDyy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lAkN652G06UW4KF1PcA55e1MeAsg1wdLyiq7MU5GMQY=; b=iSz1DDyyUd9Uor57eB+dKVosVF
	iLNMmL7QIa8JjhzRU0M1fYpoMRFinqovr6O530r5kFxCbf3K0r/tiYh9NsFTt/j9Kp4udt4U/4ZU4
	V6kOhLE2g2iGNmhsYlrzCZ5C5rvCXMvs0cNMYv0Rk00zZVNC7qx+npYfJPFK8i47/5t3BoM2qxgJK
	2PrrHGtCrGkv1OvZJ4Jp4QKCc4wmH9866helJmyQK6xI/W7EuuSseKJuR8+ohECJ9UeNjibz7JAlZ
	5+KbyaqPJ7hjNCnuPPtWviYkylPKkcLwJEsz3X9rARw559M0Xu7nW6wQEkkQU8Iidmvt+R+4v8dLX
	qwCbDrqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9QMw-0000000HGAD-2n5L;
	Tue, 21 May 2024 14:21:34 +0000
Date: Tue, 21 May 2024 15:21:34 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: remove page_memcg()
Message-ID: <Zkyt7vOQykukTTXc@casper.infradead.org>
References: <20240521131556.142176-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521131556.142176-1-wangkefeng.wang@huawei.com>

On Tue, May 21, 2024 at 09:15:56PM +0800, Kefeng Wang wrote:
> -/* Test requires a stable page->memcg binding, see page_memcg() */
> +/* Test requires a stable page->memcg binding, see folio_memcg() */

folio->memcg, not page->memcg

