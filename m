Return-Path: <cgroups+bounces-9408-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 200B9B3562C
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 09:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405711896E0D
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 07:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19852F531C;
	Tue, 26 Aug 2025 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nz+YHcC+"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA24169AD2;
	Tue, 26 Aug 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756194933; cv=none; b=GyzYPtNF9a47eS6aRLklFGIv2Wjtolgt0Lr0jpABt8VXLbC8qEW6is/VJbVjKtQeplv4T2nRrw6el5eJQnM4RaY8PG862TA6N0A7r+sunMwDklgrq8mqjrlL374YFLW4yvZaO1xn6oCZOBcYWn7J5ghG+oDwY/TXL5a3f25Sehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756194933; c=relaxed/simple;
	bh=wfH1zH+sABESaIWh2dvk/IeWsPFgh6tp9Y1Duo70drs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZaXAVfIdMpq2EEOOS9EdzKJ5CqyE2x3gYZgs7A6qTIBGcwD83eKc84//GUN+RIF2125JJg+3TN4F6hyVR8WAU0CvqAqo08wtn9BFhZY8gSOxtGk1IwHsByHM2PD30MhEK+073RZ1n2Zl0xBoYCzjsqilfhEvCB5oQ+125q0i/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nz+YHcC+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OFoUcJOT21t+LiEq9ePVMnuYiFxBXStxMKl6ABraIBo=; b=nz+YHcC+Vl2lnCa4c73qZhoEK3
	lDnDPSFMGnMHYMX1K3G9yCmEccEMeONVhb9m4TcowdXlBW7vWQ9GoTe4kqQ6FbGR+M/gSJ7oWe/sa
	8S1r4TOG4ifF18tY8eZwuxq6eY3G8+3ekklyONkES3faD11saDaLzjp6+R3sOtbU+X1T4BW/nD8SI
	nm1fhwwfAsaAwMyGwsZpSpnYy97UoxtiunCMkehZX46LA0jQt5+DaH+bei38On9dr3OG/AGBpZHsD
	PC99gjRKIxAhs4+ZhUPjBsL+6XA+C+hS8m0gkOzzMYjHj+b63bGd8J4g9noSk48JEs3aLz7XyU8AX
	k5AMdo+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqoWf-0000000Auyt-1T3g;
	Tue, 26 Aug 2025 07:55:29 +0000
Date: Tue, 26 Aug 2025 00:55:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, colyli@kernel.org, hare@suse.de,
	tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com, song@kernel.org, akpm@linux-foundation.org,
	neil@brown.name, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH RFC 4/7] md/raid10: convert read/write to use
 bio_submit_split()
Message-ID: <aK1ocfvjLrIR_Xf2@infradead.org>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-5-yukuai1@huaweicloud.com>
 <aKxCJT6ul_WC94-x@infradead.org>
 <6c6b183a-bce7-b01c-8749-6e0b5a078384@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c6b183a-bce7-b01c-8749-6e0b5a078384@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 26, 2025 at 09:13:41AM +0800, Yu Kuai wrote:
> > The NULL return should only happen for REQ_NOWAIT here, so maybe
> > give R10BIO_Returned a more descriptive name?  Also please document
> > the flag in the header.
> 
> And also atomic write here, if bio has to split due to badblocks here.
> The flag is refer to raid1. I can add cocument for both raid1 and raid10
> in this case.

Umm, that's actually a red flag.  If a device guarantees atomic behavior
it can't just fail it.  So I think REQ_ATOMIC should be disallowed
for md raid with bad block tracking.

> 

