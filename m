Return-Path: <cgroups+bounces-9381-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F00CBB33D74
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 13:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EED1A819A8
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 11:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3CF2E1F1E;
	Mon, 25 Aug 2025 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R52hH+bG"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C322E1EEA;
	Mon, 25 Aug 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119632; cv=none; b=ge5dcKPY5UxYe/4xUwVY9Oc0aSjDRQRdhbPQi4IaHGBqOd9gpHxHSp1mKbLoCO4f60gPzyuxuL3IMPErwWCPbC++507gmphSAOD+X4fdUU78YpvWD/x609FoDFZYyksKlkYeit15iQsEVGtYrEORyGwxcJLvVthuAJSfAq2uaGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119632; c=relaxed/simple;
	bh=0JOiEMMP+4qZSrwfL3YwTud6MnyV2CuIEZy2cIYmWBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlDomlPnEeWYTlObVZYCGh6B3Y8pHqsQtNOH11Iwxhl/cCcz9mOeuzH40L6ZYbbdI6AJLic8osifW51dQE2D/tY7+YoDY2Aix0QPInGH87T3BEID+O0r7RF75MHNZ2j1O2bKRFkU9ZZLp5ScNrZQe83UfozoG6pZ9/OijXzrLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R52hH+bG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AbdUbi0Jjsjqq2ptVWuB5Viq4EQ21sLXsIHKP6qNVk0=; b=R52hH+bG8RO6TgAX5tx8ce6ptR
	4i+phQOG0sg1a5HRFsOxIXAENA4NZW8nIE4Yasze4qQk7wjM5TSymzjUBWYMU7C45J+8MtqVSs4Xp
	Y+S0nJOx/jcOAiI54cRzgHtH8W+ItbaB/LRw0dgDyVUlSwGvLw+if7m7mC/sN1axt8YYf4h4VwWi2
	97vt9b0fGaxBvau3r5wkYb40gd3lqwdxSJG1c6qn9akvFr0YI5/Ft/2kASwt4ivnC2G5UDG09tKyY
	eKOCDaFqezrJXbxdqqHnfdl8+eT/ULDXWtvqIF67+926xtCDtVPR9+vnnDMjKkkzlATwfWEKBPVFN
	26Bg1fFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqUw6-00000007hSJ-1kMm;
	Mon, 25 Aug 2025 11:00:26 +0000
Date: Mon, 25 Aug 2025 04:00:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, colyli@kernel.org, hare@suse.de, tieren@fnnas.com,
	axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
	song@kernel.org, yukuai3@huawei.com, akpm@linux-foundation.org,
	neil@brown.name, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH RFC 5/7] md/raid5: convert to use bio_submit_split()
Message-ID: <aKxCStAJPOI3LdtG@infradead.org>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-6-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825093700.3731633-6-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 25, 2025 at 05:36:58PM +0800, Yu Kuai wrote:
> +		raid_bio = bio_submit_split(raid_bio, sectors,
> +					    &conf->bio_split);
> +		if (!raid_bio)
> +			return NULL;
> +
> +		raid_bio->bi_opf &= ~REQ_NOMERGE;

It almost feels as if md wants a little helper that wraps
bio_submit_split and also clears REQ_NOMERGE?


