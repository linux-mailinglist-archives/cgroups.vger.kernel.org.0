Return-Path: <cgroups+bounces-9827-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B845EB4A4E5
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 10:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3BA4E11D2
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0C523B62C;
	Tue,  9 Sep 2025 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PY7JIC+j"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5978C9C;
	Tue,  9 Sep 2025 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405778; cv=none; b=rrgbPI1XvrkI2QABQgZeJ/Ii42ErFgFHNy82rZIwYZ6GOQ6BDRPszVOTEAt2bjboycxcZrY3t5rAwsIbSf1hqtG81lu/2fVQLNL1rGPxZmDoKtZW6MOjjjaJ9XgAD+uUb5raHr+6ucqaPeEmQ9pXn+6k/24wC8NQ5lbuMpn3F3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405778; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSuU01Gi1YATWt9UhJtYF1y+YZHSW5cDOFqGc3BisolAyG7M1hYj2V8x4faoBz0wIo9BkTtilgMalN4aSuHoNeQ+VRSMwKQlhReSv37A8v/POAxzqj5lClmL2cfeS1411jeNff4vJmHmiv3UEEKa48TDUIB5QMSp2Ka6H0dJvkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PY7JIC+j; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=PY7JIC+jS4oAv3ngf6BCCyysTu
	5eA080QE9TDNotTocW/uXc2/lEEoHLRSQW2PHPkjDrOeGYchEwHO+oQF/NcQ+6FWzvlm1uwmGYjzj
	NDu6xKjEx5Yw2Kd0RfDVW8jQaS7M6RkajHw/jnpkRvewxqI1ua4H1QobWI4gTOkxpNfIhWFCJlXRk
	mkuFZiWWxGSZ8qsJHb3Df3ExvcM86DKJ/bdBd3dzDMgIsh9FI/ALj1UgSsjePSXiQ064lQaqhbFu7
	q6JkEItYw5joRD2ouiG1MEWQt2tIVyfXCVGhTR6vETC+7HzgSxKBFf6qQTEcuZqG1v6/5AubW5CDR
	k/D8PWYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtWM-00000005VUN-3sSF;
	Tue, 09 Sep 2025 08:16:11 +0000
Date: Tue, 9 Sep 2025 01:16:10 -0700
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
Subject: Re: [PATCH for-6.18/block 14/16] block: skip unnecessary checks for
 split bio
Message-ID: <aL_iSrvx2WC6rauE@infradead.org>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-15-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905070643.2533483-15-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


