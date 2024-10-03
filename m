Return-Path: <cgroups+bounces-5034-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC9D98F8F0
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 23:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7199F1C21C19
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 21:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761E01B85FA;
	Thu,  3 Oct 2024 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syMmYGBc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13B6A33F;
	Thu,  3 Oct 2024 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991047; cv=none; b=Bm5cRSTm7o2QtxmkYJ3yqYY96bzIrUmj61RhDwZKV9eC9EbfB9eCnPhFQ/gP4M5YcQKb6jatHQz0iUlCYDoCUAXcmaTb0gjSfJDx2cJMlKXN3nYwrQIvsnk/0zRU+fKvVc4CIJK8lrGvLn1ORJx80YC6fpi2Uh/hUr085oGUL2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991047; c=relaxed/simple;
	bh=kakrEADgGfwb+crJK1f9BO1JQPIodE1JT+klBW1nQDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1/y69359IAP2xquJj8jCJnWbGlOEtWHDwobUMD6boCQwxThU+uida0d0I0OZz2aJvWIFh8YQWhG7Zq6Zh0w56kwjOwzaCL02bMgeiSlSSScZJgV55vJM6pZya7uFbuAqZ6JprI1Zx4ir+qAX4GdaM6ivwibksk3wqm+77W6Ufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syMmYGBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860DAC4CEC5;
	Thu,  3 Oct 2024 21:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727991045;
	bh=kakrEADgGfwb+crJK1f9BO1JQPIodE1JT+klBW1nQDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syMmYGBc8278Fi5fZMuGoSb0+QSDyVF5vklFfXHH0+RwIEfjyK5N9uCe9AtXAL+kJ
	 JdQiRl+BNbjALIP3HDXbMyVcsesYxyD3CFJo9OTEVLQJsOLCACI8Ji9ichvhcosv9W
	 emH/RNR/I0G2xm3K40KT0QgNb6YsmQvnO2/kn+D3nwgKWTDy6owiCqtivQPavIDbar
	 my9qLJAIUyoG4f/oSBajUE8ZA3ZPnXaAaVz9PO7T1eVjFKB3FmtGfPh08YRkJE4LEs
	 iGZN2vRi41/YWiVUaXmCDkDyEnfchATmgOaxftzM7Byt/KXCn5a/DL5iWG+XBNrfKV
	 VAhpdfF9k29AQ==
Date: Thu, 3 Oct 2024 11:30:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Waiman Long <longman@redhat.com>, Yu Kuai <yukuai3@huawei.com>,
	Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
Message-ID: <Zv8NBM4mOVoMoBQS@slm.duckdns.org>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
 <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>
 <925f3337-cf9b-4dc1-87ea-f1e63168fbc4@stanley.mountain>
 <df1cc7cb-bac6-4ec2-b148-0260654cc59a@redhat.com>
 <3083c357-9684-45d3-a9c7-2cd2912275a1@stanley.mountain>
 <fe7ce685-f7e3-4963-a0d3-b992354ea1d8@kernel.dk>
 <68f3e5f8-895e-416b-88cf-284a263bd954@stanley.mountain>
 <c26e5b36-d369-4353-a5a8-9c9b381ce239@kernel.dk>
 <Zv8LAaeuJQkvscWF@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv8LAaeuJQkvscWF@slm.duckdns.org>

On Thu, Oct 03, 2024 at 11:22:09AM -1000, Tejun Heo wrote:
> Yeah, that should be spin_lock_irq() for consistency but at the same time it
> doesn't look like anything is actually grabbing that lock (or blkcg->lock
> nesting outside of it) from an IRQ context, so no actual deadlock scenario
> exists and lockdep doesn't trigger.

Oh, wait, it's not that. blkg_conf_prep() implies queue_lock, so the IRQ is
disabled around it and adding _irq will trigger lockdep.

Thanks.

-- 
tejun

