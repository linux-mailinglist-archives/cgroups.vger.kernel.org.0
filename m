Return-Path: <cgroups+bounces-11186-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6779C0C169
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 08:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BD6534B0DD
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 07:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1230F2DCF58;
	Mon, 27 Oct 2025 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nsoHJ+bM"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D9B2DC781;
	Mon, 27 Oct 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549594; cv=none; b=mZJq53aWOYT/H3vRz9+jlwYq2sC/fSeFjMC6o8oqLpC02+RgbSdU1ZXnG9VXwV2lSSIOacXetpcjCX6NlxD1HwcPh7vc2JinUopkjOH20Jt3Ci4mNf3C3aghcPIQGepnQkBvrHC8h6rMo4X2p1QJiOoDsawoIulFahZk5ggsAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549594; c=relaxed/simple;
	bh=8isuxF9+HzRUnIUyZzMqC3A83K198wXQsRPVcNAqodI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAGCVqgn8hJkVTlMX+OGn5btZIHFS5rmWH34VAuC/wIaq2C4WIVEZ2JzvDuvopMeZti3srZOwe6nlHfRchjAr18CAfdNwBiXI+lpKf4vSxRmCeue1fiVxNezysKiPAK2V33IVgij/AgTcbhKWxOFCCrGj92NW0sN99yKtScJdIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nsoHJ+bM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8isuxF9+HzRUnIUyZzMqC3A83K198wXQsRPVcNAqodI=; b=nsoHJ+bMFDWRK1YdVtaeNJLZlg
	lMQj6nDziNAYiIIJjXjAWxv0KOKwn9qrbaddNSZG1Me15w/QvFOt6EwSR6SV52SR4vCLRfIuHgBkp
	njxEA5htbhv3qQviL2/KGKqHHYIvMOESrkfHMFZoZys05vQqhIoo2RnZdrZyHMpYc/PrSDIvE7LUK
	RkAGFAWSL4OxQbZr2PzZQK6Ym+PbNjyoE+aMtKuK9eRqPJoCVHA6e6NTzp3DgA/H4QsS/ujl+C65A
	l3SOUoFbtjk/aL9jZgGIgeqeBAsG7q/AcuHqhLYODV1C2PeISGtyGxejeZr7/COVMnSAy33Rwwz3F
	91qQSEwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDHWB-0000000DGf5-0Gt8;
	Mon, 27 Oct 2025 07:19:51 +0000
Date: Mon, 27 Oct 2025 00:19:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: manually uninline __memcg_memory_event
Message-ID: <aP8dF8y5uB7qwIUd@infradead.org>
References: <20251021234425.1885471-1-shakeel.butt@linux.dev>
 <aPorFhxQc7K5iLZc@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPorFhxQc7K5iLZc@tiehlicka>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 23, 2025 at 03:18:14PM +0200, Michal Hocko wrote:
> As the only user is in tree should we make that EXPORT_SYMBOL_GPL
> instead?

Yes.


