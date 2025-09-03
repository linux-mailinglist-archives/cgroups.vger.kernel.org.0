Return-Path: <cgroups+bounces-9649-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A373B42186
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D481894322
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363CB303CAF;
	Wed,  3 Sep 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j3ILKQ2O"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02DD302CB3;
	Wed,  3 Sep 2025 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906121; cv=none; b=fTqsq0NzHQBPMEr9pt9uJNVo4QgarXV1uCJkL0d228SP3EeW9CMFv6CYp2Ue4pVhnVPRijVqxTsCEnNMxD5qNZWOUEu104CEME8bW3lXf02rtB9Rr3wzge7ZdEQOCB8tKR+jYy8pEboScq9BPsYVrpIh/aHRq/UrFXRYZ8DNz6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906121; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ler/VgjWdtxy+0POlKdngu3Tp/5lc42aEbjfU48U94qg+eTnzwslRvuV7os1hDRZyNYQqesxfJC14WaMfvqi8ThKuxmlzHdaBRa7/EuLFS4ji1OVfQFEIaYR42M8a3F68DZpWUM1A/cW77WTTNNM2wrvbKb85SHy2CwEoOBJ6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j3ILKQ2O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=j3ILKQ2OVWZeJ1i8asN1lQc0Dk
	Fk42rOxdMEKieJJ72Ai/Y9lYkTntpBFJuxu720ihM3mMiJgjRYzkqn7Q/DZp+ugwVJpff4FCLbcQM
	LWyUo97Garfo8H/tOcQaxN+5hhHDZzrPxZsKHNMSQyiSY2lThvDYLAOYgxQO6zvj/cR4RFeAanZEJ
	nsVlo66Jl1bZb7bHQS8Zl220J5fpW4/CevBierLjzvBkiq3RqgxN90HIlP/WHrwQtHlPG2zkS+qyb
	CU+Y4y6M7DTUtVAKjfBlasDBsg/jkwL38KWlRlPsL/2IYO9HmM+lRagD4+B80WcEldyJ3nYbiGkUl
	VKZ1BRDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utnXQ-00000006b2N-3jeC;
	Wed, 03 Sep 2025 13:28:36 +0000
Date: Wed, 3 Sep 2025 06:28:36 -0700
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
Subject: Re: [PATCH RFC v3 05/15] block: factor out a helper
 bio_submit_split_bioset()
Message-ID: <aLhChOpaxEZe6wC_@infradead.org>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-6-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901033220.42982-6-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


