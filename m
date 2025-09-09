Return-Path: <cgroups+bounces-9822-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB3AB4A4C9
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 10:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E4C447420
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAEA246763;
	Tue,  9 Sep 2025 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yKSQkfyE"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FE20D4FC;
	Tue,  9 Sep 2025 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405670; cv=none; b=ZpYY+tm+VeJ9r5rSED5my3jTL1+U45zr/0QWfXSGa9i/aRZYVxtS7jppKxfmVeXlbwmA71jCpWYRjOeFWH/pe7mKP2EohTYMcGOiksGsa4RU90nHqTwJ8Bit9UAECVu/vUywMOkhiP6cYg/R1ClOjXW57oP82Nl0fM579lDBd9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405670; c=relaxed/simple;
	bh=EM7g5wQ8fW7+he2LJKsIzPtqcBIM2uy1fIV9sNGtehc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVzhr7FuBVkz+JAgPVV9jpalWHYD6KiyYxdzHZ9VN+XK4QDUlPgPbyYk7Rc6cUDC5HL0tzBy9mMLxFgItbbEvU+exv9nDUP7505O52BXvNOpxTCnvOurCpXWTX8P9pHFSp/Z/2AdduoVisNKe6kgGR8NJykMHgCMBgn1kzZvXIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yKSQkfyE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nadgP3VyOVxX73jJDVD3IvP6PRvvkpXlmdJWcr2qsW8=; b=yKSQkfyErQiqySdhEbarWXxQOo
	wkppLhccN0ZFFODB3i+FP6xdD+IxQm7I8AphGkSxltwXhi8lKZ0KdtNSuYfJV1IFixsINc+4Zdv7h
	UYzK2oipXAzngxcXdCsAte9R/XGbM8fOsNlluJudPJofPeXhJFnJeaIFfdmS0V8ttCsejUZhwZrTw
	ARBemUCWc99wf1hLiZ1+K5Z8lCiVkaUOc3BssfDVzrj1/h5Y5e1+tQX3mlH/sQlm+UNKqXlilm693
	A3SMjFswOZ/HHLTJFHQxLoC4yAiFntF2wrGdPPVTw/vtlQFEpzgtQq/JEEtRF7UbphX8aPVlWnOU9
	NL6amujA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtUd-00000005UgC-20qP;
	Tue, 09 Sep 2025 08:14:23 +0000
Date: Tue, 9 Sep 2025 01:14:23 -0700
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
Subject: Re: [PATCH for-6.18/block 09/16] md/raid10: add a new r10bio flag
 R10BIO_Returned
Message-ID: <aL_h3_K15VzUD7RS@infradead.org>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-10-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905070643.2533483-10-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 05, 2025 at 03:06:36PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The new helper bio_submit_split_bioset() can failed the orginal bio on
> split errors, prepare to handle this case in raid_end_bio_io().
> 
> The flag name is refer to the r1bio flag name.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


