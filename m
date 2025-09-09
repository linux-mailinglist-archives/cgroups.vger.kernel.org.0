Return-Path: <cgroups+bounces-9826-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA14AB4A4DD
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 10:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E4AA7B1C80
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6418246BA9;
	Tue,  9 Sep 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OMxiD4dW"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A5F22E406;
	Tue,  9 Sep 2025 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405726; cv=none; b=g2MOECoQyHzc82dnWfdi+H1M6gu6gq/8gBxMbsXA0DeG9crn0mkX2RrzxekVwitjksoVMyuIdfHkyobseYJnUMNvQN3ldG+QMTG/OEmAAAtIT2LLvErqybjYFR9KLnBK5z06F6yp0CRo56bwj6sFeA0XomjcX9jqKDw2LTxU++w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405726; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQulrLv6QPUtCA9P/ocwKQzrg+lhz+JjMiu7zfNiukceK683tVYpqfgECNSK5yb1iWCjic3WRardlslWztbDYTdNkLMK/ghWdVWNMMUUpcUouM3P4TYttdEcKxtbLj4YYtt7A65ejlIWM1Yn2KFTPbyJ9Qqred7ZIuTVgxKZh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OMxiD4dW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=OMxiD4dWaMiqxeinnS7ajB9OqZ
	YrZ2LTAMwlYnU+qo/OVft5b0ISRhEdT+D2NJJoPo9Sqh0mj5wcjVtQP8lJUn9cSb5Ksrs67pGAwRQ
	iA5L8VNsF7VtclQputTgL1yfsmYye6fwQ8UjAaDht45HgOzIjt3KRke9U1QCqRloEYLQ6vnTA3tyD
	0ZacaBNHcr6PDEN7ecrr7DvGW4Cy2iLG+eo6s/RFlp4MWmFG8jyvKBYE9Hrgqo9VkwAzxiWlpuarR
	0f7cBSQfmWns7rUu4XKa6ktGylxDV/71OPTIzdxiXncHBoy2MNfDvuop9KZrcN3UmTgwZkvur2ioP
	zbZ/Fycw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtVY-00000005V7U-2aXl;
	Tue, 09 Sep 2025 08:15:20 +0000
Date: Tue, 9 Sep 2025 01:15:20 -0700
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
Subject: Re: [PATCH for-6.18/block 13/16] blk-crypto: convert to use
 bio_submit_split_bioset()
Message-ID: <aL_iGNL-bUg42Ovf@infradead.org>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-14-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905070643.2533483-14-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


