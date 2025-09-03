Return-Path: <cgroups+bounces-9651-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3BDB421A7
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674E31BC16C0
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 13:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B18308F0E;
	Wed,  3 Sep 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gS7kuiol"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957953019A0;
	Wed,  3 Sep 2025 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906244; cv=none; b=ou0YpZVgw2rrOulbRBORoJngAEsTJewH5r3tjNxTvqPvqBiMYCVGxcaGHvTMKRhX7R+FO8nlknevF/EEFlmprHVmS4OLlThmcCDQQDwm5Zmh/Qzzh/eqxuJLvl8NnC9wLw553aRAoKhbCtmAdu86LY+rFLLlvpVBIEEPegho3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906244; c=relaxed/simple;
	bh=wGFJpuDLXBDSNxlaem/dm8xD4yRQnrnRGiBf9IS35KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0cn6ix+9oKeA7mqrRRMj/9v7anafCrWeIx4njUR+FGpjmXC4Y5+fKDkSJCZ/itb7AK4zaZRikB+hDqIC2sqatMiitg2PMHJzNb33gXQPIi94cuJqmygWDZ3MHhlGszBweWjc3zqAyRbOxTnN0iqfTEDdY8LaNQWfdQ5CvGyoBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gS7kuiol; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pdex0BRxsprSivfgXIEPMlp39Od3yQe0ryu0092OL/g=; b=gS7kuiol4GkS1y+LINdkDD5P49
	Ht8Lov6Bkaxh7Z7mIr6sSze3s0uAbp+katD9+tUgBUjfVVMMte5e82W9DQy8Nl6AvfQ8F18WYRRVo
	VrKJpD8vXUSQgbWpkARNesWVL2eIIk97fVgKHpbEKxrsQgapTGVCVm7ygi/vAcA16kr09rF+1CkwV
	+7+hxoLEMxy9vLAE771KOXG+1YkHVd/1LzBBNbikPTlaCpjdHJl529Ngyp/FdW9JFHPT0OUUR4RUd
	/o/hQn8QbChDiF+4iR3CnzZ00pLRIcHn8wJeBnZscpd97mB7TIEW7jB03O7CkHPuwSmMvRRnviQe8
	6MW34d+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utnZP-00000006bRJ-3mHE;
	Wed, 03 Sep 2025 13:30:39 +0000
Date: Wed, 3 Sep 2025 06:30:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, hch@infradead.org,
	colyli@kernel.org, hare@suse.de, tieren@fnnas.com, axboe@kernel.dk,
	tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
	kmo@daterainc.com, satyat@google.com, ebiggers@google.com,
	neil@brown.name, akpm@linux-foundation.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-raid@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC v3 07/15] md/raid1: convert to use
 bio_submit_split_bioset()
Message-ID: <aLhC_1kvyiBgiCXn@infradead.org>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-8-yukuai1@huaweicloud.com>
 <9b9b78cd-06aa-407d-a224-a5903752599f@kernel.org>
 <4c823b51-f623-9a65-6d38-cfa874857eb2@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c823b51-f623-9a65-6d38-cfa874857eb2@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 01, 2025 at 04:03:22PM +0800, Yu Kuai wrote:
> With this change:
> 1) bio_submit_split_bioset() already fail the bio will split error;
> 2) set R1BIO_Returned;
> 3) raid_end_bio_io() check R1BIO_Returned is set and do nothing with the
> bio;
> 
> And the same with raid10 in patch 8,9;
> 
> Perhaps I'll emphasize there is no function changes and explain a bit.

Please spell the above in the commit log.  Or do the flag changes
separately so that it is even more clear.


