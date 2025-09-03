Return-Path: <cgroups+bounces-9645-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE010B42153
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF17A3A3FCF
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 13:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB192FFDF1;
	Wed,  3 Sep 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1ljqJOp6"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E430100A;
	Wed,  3 Sep 2025 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905904; cv=none; b=FWE5cadLmMRfEyrF2ITxVQ/7u220S+C4YVBfVhL4JqoXrvwYF0+HfsOg6L0O2cHr88nh7Kh8XiPbu6r4TQvqa97dTng+p9q60D2sTbviuTjV9r+vrDXV/W7QeJOhKWWj1aexjHbA2X14PtSk1ocw/T2UZTr1b39iMisj53IDBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905904; c=relaxed/simple;
	bh=WQy6A2m14bZTaCnfpbHbWsWEwhHaXRlYumD2DeXhS+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWJwdjx64YKq+ZjYzp5uAFCm6F26WU+2VUZ/jLf0UPxYdMuy/KjLSwMCgEclJvcJj/2dq4nisDMm5DxkNiS+EtPZS0/4Iel/Cm7539o+mmINDn2lRD07M+phRfgFwsi7Q307xhIXdvaVvuyv38QWIMAabIJrtzDYyo2EaSqsvKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1ljqJOp6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c+xjcWrDx5YfjZk0fGi1iLB4j9l4JUDYT0itb/NW72c=; b=1ljqJOp6A2Gl3FyJpIUu0X7YIC
	/ueXzhtOodMTfGFB2QbXG5RcnszxpWzDhspd5QrHfHffyZHKdCcV59W0zEGYzCiwOJWhgd8LrEIaM
	SRjriR0k8j2+HFM4YX+AJzcJKxxyMUWxx3aE+wcAjF/EQfniD+6E74i4Breond6MqnIDTDS+yplju
	2oWzaWRlWh6WFg5jiK998M+685qfhdbb/wbuVW8s5MtbvI9HaDDcj8dnXaoJBL4YyH81x9I8UXNkL
	LpnZOtthl5u66haweQZRsRlVjwZOCklDzHhIKXbg+OKaWlUeBcIH2J8J4AhP/aUpxfGxVXl+tFnn8
	q5bPX64Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utnTt-00000006aJP-3d1P;
	Wed, 03 Sep 2025 13:24:57 +0000
Date: Wed, 3 Sep 2025 06:24:57 -0700
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
Subject: Re: [PATCH RFC v3 02/15] block: add QUEUE_FLAG_BIO_ISSUE
Message-ID: <aLhBqTrbUWVK4OKy@infradead.org>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901033220.42982-3-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 01, 2025 at 11:32:07AM +0800, Yu Kuai wrote:
>  static inline void blkcg_bio_issue_init(struct bio *bio)
>  {
> -	bio->issue_time_ns = blk_time_get_ns();
> +	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> +
> +	if (test_bit(QUEUE_FLAG_BIO_ISSUE, &q->queue_flags))
> +		bio->issue_time_ns = blk_time_get_ns();
>  }

Given that this is called on a bio and called from generic code
and not blk-mq, the flag should in the gendisk and not the queue.


