Return-Path: <cgroups+bounces-9818-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AABFB4A4B6
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 10:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C09446D54
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEFD2459DC;
	Tue,  9 Sep 2025 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aX6pHaqa"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABF027453;
	Tue,  9 Sep 2025 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405574; cv=none; b=eD2q/bjc+9ByC9yjQro9tE3fsTKHuEtMku3NPPeTrP/BN+JaRVnTKqFcTFsxelulb8ogWp50FV/Ri+1fazQpwOqMkMB/Ej6jN0w7OaIzE0T2R8oHZPYZ3RSEuwlfF5LlUYGpuoxG8UBcmn7+wdm966JP6IhXrz3wj+HpxErD2tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405574; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPMP/4oGIUpht0jozryTsmnFx9vghq/MzfvL9+rF9n3tmijbR3TmsxyzI9S0tOy3yLhyiOYfY7dGkGojuZF6QbdkXoOhoo+Elq3U+e8IcP82YtqFW+IELTDPH8Ca5jLGj4Pw5UDhicU/RJ/7+ayTdkH/QV4yCjnCZDj5dqj0Acw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aX6pHaqa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=aX6pHaqamRDrsMfIc9LeKDwohj
	dgYE//UcZt6WvTKoxtkpD9swLZN2v/UoVbmG2u/gECNFhmziRLIJqsP1P0IWYDvmItB3hy0dbZAP6
	z4qjxuRL2Hp7F/Cp4Nqnhd1VAObq0oc3VnDuEpY/uaS2/dMzw79mwu/bRp/IeHnEHEOtxXssk2/P3
	CYeNeRr7NFesbUGbqHx69v3qH95RtPzAGtdCKBVVF9j7TovyLb+/HjKf3tALVAj2/QoLFuSykko+j
	oCHh2fbdT/8ra4nOTgzfxS8tFJoTjLOxHUoJkWjZ0ihnzLrSwr9q58KELj2oCR2rYc//hJchjMI6o
	IYTCzo/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtT6-00000005TxW-2ePK;
	Tue, 09 Sep 2025 08:12:48 +0000
Date: Tue, 9 Sep 2025 01:12:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, colyli@kernel.org, hare@suse.de, dlemoal@kernel.org,
	tieren@fnnas.com, bvanassche@acm.org, axboe@kernel.dk,
	tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
	yukuai3@huawei.com, satyat@google.com, ebiggers@google.com,
	kmo@daterainc.com, akpm@linux-foundation.org, neil@brown.name,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-raid@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH for-6.18/block 04/16] md: fix mssing blktrace bio split
 events
Message-ID: <aL_hgBwI4EyOWx6r@infradead.org>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-5-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905070643.2533483-5-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

