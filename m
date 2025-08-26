Return-Path: <cgroups+bounces-9407-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F10B35626
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 09:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81274681EB1
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 07:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684FE2F60B3;
	Tue, 26 Aug 2025 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJPYCkI1"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379227E7EC;
	Tue, 26 Aug 2025 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756194870; cv=none; b=jnOrVV1j4tLm+HxUznqN1yXxBDY8v7sspD1D1WtWJwTTfhhQcTnUs1VS+rxpBMiDbGV42ASLAA7+7aU53ntEXkEqbXHY8PizxajjJhYS49cneLpUuryFPeKiCnKD0+IrK+CHdjgIsCBwTVzRlQ9b2JLz0FLny3auPcMp11nFJdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756194870; c=relaxed/simple;
	bh=tPZ5eO8+915S84l1cBlowqpFwI9FLfn+yVU6PoYNhJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQc/LspBIt2uf9xoLfqjKzsOH/mWMmgsRH94oc5zJjVtoFWcpFTfTK+6e4r8wCIzh7RtokqdeCIJllug5a1JR5jWmNTX6eix9EL0J+lvrMJQmCakUmkzX1wAQGDPPWbgBIRokaccLhdI4ToLKdNIiAiOeRcZ8pu2+GVR5nAGFro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XJPYCkI1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ZhRBEmozLyGOB9uB9XvPxf7VcUxvlYe4L+OsgeA0lLs=; b=XJPYCkI101c/29XbH5mbcZpUeX
	aFp1lBXSb5ASbAzG2L9sXB6p3ZDYAWJY6CHAIyyhrEP3N+DTfdegs8+nDa2i43bvKMe8oFTPcxsxv
	QlGh0QcX8TOzRUl1TJbygH2T3s9tqCONsh7GxfjRmrYEp4F4x1YoGIirtLUIh8QR/6J4L8Bu1GYjN
	uva6R1mVjluouXJYS03GTl/lYuzAvhEBqpRm1bvHJ8zp4Q5g60Sd152twiTi0WlunHW+Cj8KJ8wtv
	t2vYni9RcwNKgsqYz1VQgdYZfwmBooQFkNTPJqaqyuNq5Iap8D+TFC0j+6yA06hASv++KtyT+lbW4
	typ/SOGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqoVZ-0000000AuhZ-2JWd;
	Tue, 26 Aug 2025 07:54:21 +0000
Date: Tue, 26 Aug 2025 00:54:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, colyli@kernel.org, hare@suse.de,
	tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com, song@kernel.org, akpm@linux-foundation.org,
	neil@brown.name, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC 2/7] md/raid0: convert raid0_handle_discard() to use
 bio_submit_split()
Message-ID: <aK1oLSppbXNELKCX@infradead.org>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-3-yukuai1@huaweicloud.com>
 <aKxBgNQXphpa1BNt@infradead.org>
 <2984b719-f555-7588-fa2a-1f78d2691e8a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2984b719-f555-7588-fa2a-1f78d2691e8a@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 26, 2025 at 09:08:33AM +0800, Yu Kuai wrote:
> 在 2025/08/25 18:57, Christoph Hellwig 写道:
> > On Mon, Aug 25, 2025 at 05:36:55PM +0800, Yu Kuai wrote:
> > > +		bio = bio_submit_split(bio,
> > > +				zone->zone_end - bio->bi_iter.bi_sector,
> > > +				&mddev->bio_set);
> > 
> > Do you know why raid0 and linear use mddev->bio_set for splitting
> > instead of their own split bio_sets like raid1/10/5?  Is this safe?
> > 
> 
> I think it's not safe, as mddev->bio_split pool size is just 2, reuse
> this pool to split multiple times before submitting will need greate
> pool size to make this work.
> 
> By the way, do you think it's better to increate disk->bio_split pool
> size to 4 and convert all mdraid internal split to use disk->bio_split
> directly?

I don't really know where that magic number 4 or even the current number
comes from, but I think Jens might be amenable to a small increase with a
good explanation.


