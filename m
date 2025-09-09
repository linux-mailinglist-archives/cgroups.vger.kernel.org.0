Return-Path: <cgroups+bounces-9819-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D6FB4A4BA
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 10:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB1C7AF50E
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B572459FF;
	Tue,  9 Sep 2025 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="An7RgtnJ"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1E27453;
	Tue,  9 Sep 2025 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405592; cv=none; b=i7/8VRaaJeXJyVIuhjDd1abr2XS7U2utjHkY9wfFS+ITKPQVZm4/MSK8KIImfkoYqZnVmj606yZysZgqrGIDDhNJn2A8jOPSa5qqEeVMgPpoSfkDrmQykNDt69ZEuku3wrfE1OZRhziXxAKtNWtrm67BC7LfttGTTShQ8fVIhos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405592; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC4ckIZg3Y7zqDHkU6w3fin34696P7unTqhjnkVHo7fml0d+gmKBfDZ+hdcK4hCrWAUYfYXJBpaImm45jrQwRHdurd+SIKXnyROgoMOSqJ64hWZKpc/fStSV08YCJeW1Y0tW+nAkfBymex51XzQY8KbRqrMUB+DFhlPUhwNKUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=An7RgtnJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=An7RgtnJbRFqyhthEq/HrNBNzq
	uTKryfOhLO6404GO0swJNwSNKQMPgOcbVL8D1qIQb0+Jl/m5zTNRxmOfP8MnoiQXzkboLAGbSQ14M
	bXIYfxwdLU9zE2h0CE2aTwHCBbTeDuo/lCh+b+ADefweS1sy1Ix8DBM3B/n942KFvwSJn4MhxuU/T
	g6IIttprquXQsc7GHpwyqQhQ4/K7Ljxtg4ZFrVg5qEzZC9nGJSTzgnAdF5An2jq9kWpiRYJOKIiHf
	6FUpc8LWFo/uhRZmBIoWnnAcDMxQVbQv0NjfYHhWVCsft/1DDRyul+TQfgKOcIxJtbbwushdSUClX
	tI8rvFoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtTN-00000005U2d-3LcC;
	Tue, 09 Sep 2025 08:13:05 +0000
Date: Tue, 9 Sep 2025 01:13:05 -0700
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
Subject: Re: [PATCH for-6.18/block 05/16] blk-crypto: fix missing blktrace
 bio split events
Message-ID: <aL_hkULiFLIKrBA0@infradead.org>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-6-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905070643.2533483-6-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

