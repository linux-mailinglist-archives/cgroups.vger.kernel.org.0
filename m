Return-Path: <cgroups+bounces-9654-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DB4B421DF
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACCD16F8B4
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 13:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9045C308F36;
	Wed,  3 Sep 2025 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aCoM+M/i"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EC72FF160;
	Wed,  3 Sep 2025 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906485; cv=none; b=p1N0XsIm2z/x33LI/8VaXdZFwShgG3rH31A7MnPQ/1LvwLZqz5ZcKGQ8gjDeUVkVHTf6BohSDhfq5iW9dXJpw4uAGy41mSJY5uZoujKqGkij83VEMBxwLpfyuRgl53bEpUuMjxiLH591z71RwEMy+1VUmzYn4QKiIHyaNikkftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906485; c=relaxed/simple;
	bh=7F6XOAzUhsDHmCI3/SCs3uVB95vrfC3f7t3UxCYkuGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oS+KCGYYDR9S47JUQ9hcgNXc7rB8AVm+EyZ0AxQZl0Nt4FMtagy4Krmp5YGWuHQGRLsh+gylKOmJuiQ0gNHUVc5Y953ccTl8Ul+1QHShvyt4p0nnxxEe2Yy0jmS/RRXnUSJKKL2Iv1FxU/HW/Vky2gfw5W5h50kV7nNLkuwjGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aCoM+M/i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c/WRtC4WLl4+ChMSM11wBey1MNP5VSLO7LDcCYVKt0w=; b=aCoM+M/ixXSp6SCJUeLc1q1KwC
	qnHd1CCJ4h+LcjUib+boUGHt5vi1QaXfY5NOTB3uRTJt20/lJVHeCIG6S7nSWOXHhdwE1PlSchAk0
	ZQnyygZQntkUqXk8QlDKeafE2whZgfpza9IeLt5hKoP8z21tEGG0cilsHjqAyeCkjYsYLtJXjNIqp
	MI/6Xq86k0nvXXVCzNQYOUyL74MpGOmWyVrzAhBh6qer1nKKpvMps3qw1aUoP+G6IsYLzR7cq/xl3
	iQV9Usd4YSieGqh5+tkFI7L5U7B8WtoHQuMJIz4qgtL5G8swZxeJqHQdesjQwXIUW4Z432UltvVhj
	GDYHLaHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utndJ-00000006c6S-16b2;
	Wed, 03 Sep 2025 13:34:41 +0000
Date: Wed, 3 Sep 2025 06:34:41 -0700
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
Subject: Re: [PATCH RFC v3 14/15] block: fix disordered IO in the case
 recursive split
Message-ID: <aLhD8Vi-UwnwK93L@infradead.org>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-15-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901033220.42982-15-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Btw disordered IO sounds a bit odd to me.  I'm not a native english
sepaker, but in the past we've used the term "I/O reordering" for
issues like this.

> +		if (split && !bdev_is_zoned(bio->bi_bdev))

Why are zoned devices special cased here?


