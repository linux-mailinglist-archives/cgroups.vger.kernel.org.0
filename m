Return-Path: <cgroups+bounces-9647-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA58B42179
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00C27C22FD
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 13:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C663C3074BE;
	Wed,  3 Sep 2025 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VaNpdRgu"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AF83043DC;
	Wed,  3 Sep 2025 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906002; cv=none; b=NHdLYwPHBP2RUtuxQQeA/3A/pausyr6q+MhpCdWxmfK4W8XR0z/pstWXPlMRloZrYmD/gFu8aLxk7UISl0g1w+8hvn9EMRzE5vCPDZyBJcVJGDcA0Regh3g+k8lFBkNRy6jC+Nw60OJVJ7L/ttC7Z0Yr1K4H1D2Lhj9RCOaI0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906002; c=relaxed/simple;
	bh=WzKhkg6wj51VApZdJLGlIeJTh4MO+VSFpoqYa/qo3z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwjHLnmocJ0cBRC3r3VS3xi/iqXsBohzub12coFWqoH6o43h/b+66qCo5cTcxhqaSyGbH9e8aDvEsFR3MdgAJPL1oNZN8bVYcKt2t4yi+prQoAT5MvTjJALyK5oFR/fZgfoVjherSwtM3E1wqfMkOfDfoaurK7TXBRqx07lAj7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VaNpdRgu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r66Q8tZUJREUEJdjgy3ysaRf3HoXdNh2Fq1uKM15iPI=; b=VaNpdRgu1qUJIoe8f6XRaV21vn
	62CyVrdWHyz1Gj9xIddCX+vYgODOgucqEh+HSel8KewYQs0NWGF9Y8XwdtO3+fS/xrSA2dIaj8KFC
	f7I+WYOlnim3P7j0ohnxwC5TIcfqY7yuA+L884/1XKLVu2pljkJuLC8D7oS1bR9e+mBrpdBcuiJiD
	CwxWo83107puQj3979CJBFwUtnL4yR5s67vEHRp3QlfT5wRlad5qMbKo+tChml3UOwGr555F6Srbt
	IUele6ZIpNNS+G6G6Lk+V6qogoQjnoqrSjD3vlSbAFrsCTsJjgoIafu72VQHzY5O1eUeNMr/OqzYa
	nTm+Cf/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utnVU-00000006afJ-1Z0J;
	Wed, 03 Sep 2025 13:26:36 +0000
Date: Wed, 3 Sep 2025 06:26:36 -0700
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
Subject: Re: [PATCH RFC v3 04/15] blk-crypto: fix missing processing for
 split bio
Message-ID: <aLhCDCHPPFp1i78j@infradead.org>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-5-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901033220.42982-5-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 01, 2025 at 11:32:09AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> 1) trace_block_split() is missing and blktrace can't catch split events;
> 2) blkcg_bio_issue_init() is missing, and io-latency will not work
>    correctly for split bio.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


