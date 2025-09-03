Return-Path: <cgroups+bounces-9650-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08826B42196
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8947188CD66
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 13:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D013043D7;
	Wed,  3 Sep 2025 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yhpysHxo"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184E7301462;
	Wed,  3 Sep 2025 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906199; cv=none; b=ZmIXS4YKZ59DQbxrArd6cMqgElciHsRhEtx3+GySMm6+o3nchG8iwClUNxuOhWdzMFzh2FfPdxK95z8zZXIwdzoKSaTSwn0O2XamXX1d9yATW2O0NVCpRRWOiUUys9YqEPEk+PK6lN/KNAuT3mSfkllfR7nkg5qWiYOWVFiNmfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906199; c=relaxed/simple;
	bh=a2fv2XQ9vSVqUNR/QGt2Uan+kijIwcAy1xdzunQPQTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnbgSbZigW8IKzZRP1yNnAZVGhulatZPZthXfcCq6dCU+cshIoxQxDfGnD1ovhJkrdCuMntDGewkgfKXasa5w9WPM3e1DhJzC7kLlK1AWwM7M2cC8zvXxLAGUVZZ6AGBowmN37H07FoRLz2J2P5ETJcgfLiJK1bWT3jQhGHRgk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yhpysHxo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=62KQdkkYcXg1+qoM4xY7Xc0/ELwfHro7HEFzv1eaTGE=; b=yhpysHxol/CJSiLkAMnfK20O35
	740v6Fcbl5MfLWrHS32KC3bpQglvoAJJeFu5gLf16v/2lodUrbHQ73ECgeDWegEmaeXVciowKiwGg
	T8bpiF4fzmOBQoOElOhpPFwbcGajQLAoyFM+IV7zRElVmF3KvXp6dGGSz6dCW1OYp1nHccb1rNkn1
	/fAbxnpaAu8x4ldbM1Uql+f5v3u1qgx6wuDi3wCRl6C7SL3ucZuoKwp+Eu76fxvM+xXQqO5u7MBDh
	JClMymwTsl/oT48t/RMo+fVWE5zelW38wiigP3UUt5pPV5AnOdqI9EH9ktp6a5BNHTF8o47CzZmr0
	C/5WnvOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utnYg-00000006bI6-3XtD;
	Wed, 03 Sep 2025 13:29:54 +0000
Date: Wed, 3 Sep 2025 06:29:54 -0700
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
Subject: Re: [PATCH RFC v3 06/15] md/raid0: convert raid0_handle_discard() to
 use bio_submit_split_bioset()
Message-ID: <aLhC0uPbWfTGa1Dl@infradead.org>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-7-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901033220.42982-7-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 01, 2025 at 11:32:11AM +0800, Yu Kuai wrote:
> +		bio = bio_submit_split_bioset(
> +				bio, zone->zone_end - bio->bi_iter.bi_sector,
> +				&mddev->bio_set);

Nit: this would be a bit more readable as:

		bio = bio_submit_split_bioset(bio,
				zone->zone_end - bio->bi_iter.bi_sector,
				&mddev->bio_set);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

