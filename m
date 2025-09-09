Return-Path: <cgroups+bounces-9823-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B88B4A4CE
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 10:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1152541654
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619AE247281;
	Tue,  9 Sep 2025 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MFJdDkEk"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E096024467E;
	Tue,  9 Sep 2025 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405685; cv=none; b=hiy5ezhZdhmiE82C1ex5HpzRrI8HOSor1NqeT1AAiglPfAG3kuLF6xfVy0dQYDsMxCxmByql8UpF/tjqkO+ysADQIruplutPWN3s971YBpsgJm0hKrmXbuSN75D40CIE4T9p+YAM/mrmG1IX5LFpqMDD801EJMMMzkh7UGiUggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405685; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJuc3rYnEtqF1qWSGe/EOLboUf4jiwjI9TbyM0NBg04mAqWheyErLUqE2QeiXHBGzTA6lXnbez1B0MwIlHllIAHbQJYNqUQVm3JegB8yYA/sxSEu1HoyFu9smfdmxyMbkLsHDzSJBQb7p1ovjASANvrKiH7lxz/90vij+fQFHjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MFJdDkEk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=MFJdDkEkK4avBClfqdAbWibssr
	9t++8rWgMJ4XzgQinESidFFFpjFfMK0ZmDEqjAgw8YrZIxknlSJeX7CmuEs4SX0rY6Gp+GxYHlUXS
	F0ldpYgQbjh2MNR/QfgDnnFOxUQryZ+Okc+cNExDhVtS0syTtRPX+9ByiGfmwhYsiEi+dEFaxexTu
	dD63Rpl9kHovGMvZOC82I9ZxaWHiY8E0PSTEECK98K+TDm7MkthSe2X7/210VymeVX3YFl+y+BlFp
	iOaujsg3neyqA6H7Hvat8e+1E27oBk6FxO4+WGsL8xVra0SoADEUJkrr5HF/ISrGwWJGnNGht7NK8
	W4nHR9tw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtUt-00000005Unh-1Sxq;
	Tue, 09 Sep 2025 08:14:39 +0000
Date: Tue, 9 Sep 2025 01:14:39 -0700
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
Subject: Re: [PATCH for-6.18/block 10/16] md/raid10: convert read/write to
 use bio_submit_split_bioset()
Message-ID: <aL_h7_LdaFH84ly5@infradead.org>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-11-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905070643.2533483-11-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

