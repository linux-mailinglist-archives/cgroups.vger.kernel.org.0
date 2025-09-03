Return-Path: <cgroups+bounces-9652-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11791B421AB
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BE11BC27A3
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789413054C7;
	Wed,  3 Sep 2025 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XHyxhw02"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092D22F3C39;
	Wed,  3 Sep 2025 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906277; cv=none; b=g8NzpA9cE0dnHZRwGQZp1bElSm+D0iljaina4gvNwEOpNYtk8n4fsPOIrbhSecJxFoABgyRFT1BHdGnWugWjVyJmafCQAa5UcdMRVKSyBhpr4RD/A7k4vv8iNP2OiW0iAhRIgQG6lZs9U6HCvJeuxJ7qBEFjQKx2BnbyynkQ+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906277; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE6EYSQPQEOGVqZzmAjj5IZNBsi9oRhUjSYbKWTqULBWxqtvEavBxzkvU6Tmce+Be2veDOZAMbEtqm2n594TaQQMrjgct1Nj2Gwct7hXVX8ATnMdGBWZanrxcVBuJz5vnbRhsBRrCvJ3eHP2KjqgEjtxHl0O61n9p8uZcOGOqZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XHyxhw02; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=XHyxhw02c/aSjHi6EHDama47dE
	WU0TbQHHkaEkpLjYpFEviS2/OplMJfl3BOWZwAI2RbL8uKpQ7WxQyEolPgJQI0S58C2Sc1YZ+aDmD
	Wm2xPuhfH00qVY+zv0gBF1Y+sJN60+WjaDOl3ifdph0sNs2sJCAi/5fXV7I9jtJjPSwJT2ZPClD0x
	WETyxvc8LEyZ45v8Ramb1J9Tyrob4Yi40AOImnIOpJYLwr1jBfDDZoU2IxAFglL64b9HWklsqH+lB
	ChCB2Wuh26psqj7kjgqOtwq+zybdCMITj2WhuT9ysiwlK7O//0o+ccqZeWRPdp53KdjOw27Xazt2t
	uGGVVZew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utnZw-00000006bVi-1XUH;
	Wed, 03 Sep 2025 13:31:12 +0000
Date: Wed, 3 Sep 2025 06:31:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, colyli@kernel.org, hare@suse.de, dlemoal@kernel.org,
	tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com, song@kernel.org, kmo@daterainc.com,
	satyat@google.com, ebiggers@google.com, neil@brown.name,
	akpm@linux-foundation.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH RFC v3 12/15] blk-crypto: convert to use
 bio_submit_split_bioset()
Message-ID: <aLhDIFhlQllyUh8l@infradead.org>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-13-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901033220.42982-13-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


