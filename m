Return-Path: <cgroups+bounces-5008-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA97198CFC6
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 11:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FCA28872E
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 09:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E537199231;
	Wed,  2 Oct 2024 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="086sgpH4"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13182198826;
	Wed,  2 Oct 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859897; cv=none; b=GQ0a2Y57zMZ4Bmsa8vvO0T+H225zlZy/KgcLjtnR4mikebnDsHO3bVcUFNVnpz+jsnI65ZgVHCF7KZZfs1K7+SfO+W20CA09GUTlz0qRh8V5l3xA9TrVKZBOJUzReb1AIbPs6dhZK+lUdN+hhDGpTctQfLOlSfkFc8yvEnOpeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859897; c=relaxed/simple;
	bh=3L7o9w3ZnQ/XValc0MmlvvaVYAa1ifTnz4Mj6awX2tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXET3tQJBv3rJGk4oE2J6s8UwerI+s93I1A9RReC1AwgfTa+81tW7L3hCmsWcbRr99gLdoLGjwkj+hc4vsHAmlVijY4mNB7ex9OE9VhY7LVQlFryDWo7kB/y13sySrjbJCPOzZe/aGAcqBF8oxwpnFQoo0+ix5lE6myufUDDggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=086sgpH4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3L7o9w3ZnQ/XValc0MmlvvaVYAa1ifTnz4Mj6awX2tU=; b=086sgpH45lqOLGq/hnIvGnN6a5
	J4oQei/b7/CZsaDjr/iLeRaDTxxAmdct5jVhVAUgDrwWmrTeHVn4r2czFL8a+y0zMf9DxYj+zo3Qv
	iByYQNSUAXBZn7BhmrgTsF4Upy/foXeNL0BBJvAZM2GDBfdOBfZWRV5UCdPEnMBf2dJLU4DeOs1Bt
	mkHj0wnLfEdPkxUye8BUjxG5GDYKyXJpP9tOm5a9U+7RvKnfC0V93kCxvE4Je4SwP7oW4PT0AVdL/
	DrDvnJpGUJSlLxizKqkQQgezsnMM3oPsrDOcLu3WbKOJT76Tkmk9Z6SLVQbZY0yrp9VIwQg2XOkoc
	jo9Itq2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svvHy-00000005GJH-189J;
	Wed, 02 Oct 2024 09:04:54 +0000
Date: Wed, 2 Oct 2024 02:04:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] blk_iocost: remove some dupicate irq disable/enables
Message-ID: <Zv0MtvYFTHlff_zT@infradead.org>
References: <d6cc543a-e354-4500-b47b-aa7f9afa30de@stanley.mountain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6cc543a-e354-4500-b47b-aa7f9afa30de@stanley.mountain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

s/dupicate/duplicate/ in the subject.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


