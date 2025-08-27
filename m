Return-Path: <cgroups+bounces-9439-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA66B37BC5
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 09:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AA936100C
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 07:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC31E31771E;
	Wed, 27 Aug 2025 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JZ4/k2a3"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B152E1723;
	Wed, 27 Aug 2025 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756279927; cv=none; b=EzMA8A1bEdB/qW6Zfx1/6+/OyOgTu1dvO3H13utfk5MgJBQE1NlnfHN9c7smyVrE7ZzV/osXHftZ0MQe67H8YAGDA+ewx2RNCUtazxaeAx+p0POqSFTAjgWzuR4tuWA4kMOhFAY1JkLSG5MK5nPwswtDf3hewGdL3ctDyUI6MXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756279927; c=relaxed/simple;
	bh=m60YP2l0OQVjwwUvCpC26uRwuFUQ8d+ffT/0DA5nFwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CndKMZIandrtw6IlfhgGGdvXF9qqdU32Ht+KDp4gEphEZli/uVK4g8pS+a+2Wr5y9ggjkBQtWrLSB+8VlD19T4aaawviznyjdw+zwE1yqjdiU5DSOTaKnG7ZJTgkFqeH9UJQKHzUNtprnkSUXbtWuSP9s7KyN4HSczH65iqib5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JZ4/k2a3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/U7TDdgVS0XTpH2wrHd6NGuad3QpZ7xAtceEl+MVTEg=; b=JZ4/k2a3nNOadUbaZYE/D0bAu6
	mKeQBdWkdOBG+Gqmz49R058h9vKZZsKvN2ablsyK/nrxN4SPF8rTbQHOYsYpVKmQS1RUJNSiwZ5z7
	3u73+tNJTPsX1CwUJL1gYDote7d1TGUN26gRD30d5/eVdXf7djjgNJs3/XuheiquBQkaOny0cNdkv
	H0QRKRP0n+0SkwYZ/NhBshQW8y3JM1EAyr6CXNW2RKDG6xv58EWk+M0kUjYABjy59AabK2R/xYrcP
	n8TW0EfEWpmvAoR3y82jwq8sFf/N5EK21ZRuPZCPb4aCJP0hPDWg3zK73fZuUi/C7UdxY9R91yE6P
	YoJvugYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urAdS-0000000EQpI-3YHJ;
	Wed, 27 Aug 2025 07:31:58 +0000
Date: Wed, 27 Aug 2025 00:31:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: anthony <antmbox@youngman.org.uk>
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
	Christoph Hellwig <hch@infradead.org>, colyli@kernel.org,
	hare@suse.de, tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com, song@kernel.org, akpm@linux-foundation.org,
	neil@brown.name, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com,
	John Garry <john.g.garry@oracle.com>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC 4/7] md/raid10: convert read/write to use
 bio_submit_split()
Message-ID: <aK60bmotWLT50qt5@infradead.org>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-5-yukuai1@huaweicloud.com>
 <aKxCJT6ul_WC94-x@infradead.org>
 <6c6b183a-bce7-b01c-8749-6e0b5a078384@huaweicloud.com>
 <aK1ocfvjLrIR_Xf2@infradead.org>
 <fe595b6a-8653-d1aa-0ae3-af559107ac5d@huaweicloud.com>
 <835fe512-4cff-4130-8b67-d30b91d95099@youngman.org.uk>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <835fe512-4cff-4130-8b67-d30b91d95099@youngman.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 26, 2025 at 06:35:10PM +0100, anthony wrote:
> On 26/08/2025 10:14, Yu Kuai wrote:
> > > Umm, that's actually a red flag.  If a device guarantees atomic behavior
> > > it can't just fail it.  So I think REQ_ATOMIC should be disallowed
> > > for md raid with bad block tracking.
> > > 
> > 
> > I agree that do not look good, however, John explained while adding this
> > that user should retry and fallback without REQ_ATOMIC to make things
> > work as usual.
> 
> Whether a device promises atomic write is orthogonal to whether that write
> succeeds - it could fail for a whole host of reasons, so why can't "this is
> too big to be atomic" just be another reason for failing?

Too big to be atomic is a valid failure reason.  But the limit needs
to be documented in the queue limits beforehand.


