Return-Path: <cgroups+bounces-9378-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBA2B33D56
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 12:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295561615B0
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 10:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A187F2E03F1;
	Mon, 25 Aug 2025 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BYu5yuMy"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6A82DCF4C;
	Mon, 25 Aug 2025 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119431; cv=none; b=gMs1gWmsA8t1GC3j8Rj0sfuPC4ey7PvJM2E49IiVccKa9SfVgcsHsbpUU2kKyTsJkcw20hKr3iv4CpMpJXCDBeOHSJe4rV8SQ0+NGJjaCFeJ7j7TcZ2d5To3iSpTIcHh9cYIDskIMpJ3Ma5+o/jScmHA3lG3n5BWkbFoKyFqqxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119431; c=relaxed/simple;
	bh=OXqy2LJIGjVYA6SY3U2r+xZ8WOR5fGbiTHONxkH1oho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cH6hEPITMmgYx02Hxf9mG08ORIkIqZmv9yTU5+A2fNI+LP3EBjY7IPLJQ8u4oR6nUl24U0Uad7FIDwM+Dgf8tG0uRYAswK0n8bXoQQcsFzKol/a6IMZFhM+b+8aSDswc313wlX1HU11mdvNRBkrdvLCpA7UWwRiVy45gDrHpKNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BYu5yuMy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2qA9jdP8BwB/1cS6nlayILuCmiMKAoxVnSGxT5pzqRk=; b=BYu5yuMy/sZLZEZ8WnjBCF3EGJ
	Rz+W1eNZGfulv2bQsn6EvGt3q1DW1vYqDfJqOmcb0nijlSZ6OsBH2kBYNpelZPgavmXMEvDQnsMwP
	JBAwNAGN5Wg2zu5bdhRAjFjgzrFWMqxy7T20k0c4OtLcbAn5HS8ARwXlD0v/w4rFyZytOolsF1e/s
	PBPNbejOQlB5q04kcIAmBue5RQc5Ya3RLP8q/ac0WbvNVWAFzPbDVb43Px2WEkAl7C8Ov7P0YzPHy
	/+ITNYh+zWqSUspRWnq9bkxj0qIs1gDLMM+fAVfoO+I8JRA2O1+ji+Jg/VStQF317DSuQR27nBBk+
	gCut8TTQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqUsq-00000007grj-2uzx;
	Mon, 25 Aug 2025 10:57:04 +0000
Date: Mon, 25 Aug 2025 03:57:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, colyli@kernel.org, hare@suse.de, tieren@fnnas.com,
	axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
	song@kernel.org, yukuai3@huawei.com, akpm@linux-foundation.org,
	neil@brown.name, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH RFC 2/7] md/raid0: convert raid0_handle_discard() to use
 bio_submit_split()
Message-ID: <aKxBgNQXphpa1BNt@infradead.org>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825093700.3731633-3-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 25, 2025 at 05:36:55PM +0800, Yu Kuai wrote:
> +		bio = bio_submit_split(bio,
> +				zone->zone_end - bio->bi_iter.bi_sector,
> +				&mddev->bio_set);

Do you know why raid0 and linear use mddev->bio_set for splitting
instead of their own split bio_sets like raid1/10/5?  Is this safe?

Otherwise this looks nice.

