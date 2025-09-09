Return-Path: <cgroups+bounces-9828-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F66AB4A4EA
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 10:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA76447BCA
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6130B23C38C;
	Tue,  9 Sep 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GutQqp4U"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09914A21;
	Tue,  9 Sep 2025 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405794; cv=none; b=lgn2d9OfHQT2YOU93OchdCAbuc3i9pphtETd10bx2zLEQYCmUYCgKhzICXkg9/mATIn+1bzQK/AoWXBFQcbYljNqGykcbwBTryrd+Ablv0R7SpJqn2hlHcaroXE+zarRlbzSpb5FYeeTUFKUqO4IP/djakPLfZrrpYrPHN56w2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405794; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTXfkBwxW8Co9kBWUSAzxpS0lsKZ7NEvwYTI4bhjeH8t0tt9wE9x+zCPz0aVVevYQ7oYYsTec7QXYeQAO98IGMrGrnZO3mzQ9kyeAreHzNO26pEYZGdRftLAtICApVltBEk78+xRavnOiI0uZaGwKvonwsf9+0eCOWmDiWYd7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GutQqp4U; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=GutQqp4Uwxyu5H+4U5R28LRgYY
	pAGZwRz8oGWYeyvzm/ZWn+prPO0x40eXT5G/aopMuHlJGn7hQM94BNT579qlqmmr44k7MdCdLr49z
	EJz1cggHQyjaSCkPPPR2BEplBSS+HLuVkp/QUaUltiBqiY/C+lK7+TjW6CDDQ0yeuBnq0szAHhasc
	1uB2xIrl9OG7VM4tRKoKzyTO587HXETRZaGddet0JPKxEKsiyczwgurPT6G7nIxTo/hBD6AlcY1dt
	MA+k3UGFgjtKRkcgVPizSteS1D0cBJdgOLzVpNFsgU6LBeC9C+l1t6Uj7OppiJppm5xJ7ObAFqLqs
	3N95fKIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtWf-00000005Vca-030s;
	Tue, 09 Sep 2025 08:16:29 +0000
Date: Tue, 9 Sep 2025 01:16:28 -0700
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
Subject: Re: [PATCH for-6.18/block 15/16] block: fix reordered IO in the case
 recursive split
Message-ID: <aL_iXDY5RxGEkEXq@infradead.org>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-16-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905070643.2533483-16-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


