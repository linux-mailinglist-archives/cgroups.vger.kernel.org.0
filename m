Return-Path: <cgroups+bounces-5063-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C577D993FB8
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 09:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842172867B3
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 07:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC74B1DF960;
	Tue,  8 Oct 2024 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="beukEH7X"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00514A0B8;
	Tue,  8 Oct 2024 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368954; cv=none; b=a2RyPfNDNqHJDNfbGoc2LctTfFDuiY7AmxeOJdKWteIdPr/UWsGw58b7881KzPXUR1jIqBlWESKEB51INu77OB3M6Y6CpOytg5fGD4GN+4ne0UWCer43opFy7+GfaAbnnobOEoz+LquUbz1Xe7OFQ1mTSxn82bvi3rR6b6sV9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368954; c=relaxed/simple;
	bh=BWGakp8jbxH9ePVwnsRB+ePsR8jJQenV0Mc/y8WuZCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT2P5q1RbUQ/YZ89lvZ3+i5uaDht+FcIcuNHXaZNVCBTo8s2oZ+oiLPewx+7n5Yosqvkh3m+/F58rvqG1T8JDWv7wMRrSu3/dT5ck9QfS5fjP3SCnMU6LAsZxWv2QWjCDZFBNWzbKgpcB98yiiv5lZhNh3yYRrGGcl6WUVFnSj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=beukEH7X; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BWGakp8jbxH9ePVwnsRB+ePsR8jJQenV0Mc/y8WuZCo=; b=beukEH7XjFhBT5Mspc90DShBuH
	wt63I8GQ9F5lWs7LnpWsRNBkhPTKgdICUahANeCxnKuCpOKOGgJ36NVgW5yzssUAI2IAyuMSwy/2Y
	BcZhr2lYT2mxiXSjbsB2S+KYW1/jMjhkGgGGFtzi0GAL1MFRqVDh0EtucortqGJivdXJhSye/0CLR
	FBnq4quaci6po31FGFzo0+x66XyBSimSzfFhPvSi1ycBd8Tt1gdhMRAFsyo8krqfolMgfy6tDMn9w
	plePAodPK3TU3ItfYz9HAM9jUfkyAx1vcYS03QmCz0PuKtdQpHizmU55OvaF19MZw4TUr96PLGrX4
	Wn8tTOMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3iZ-00000004eyP-2ork;
	Tue, 08 Oct 2024 06:29:11 +0000
Date: Mon, 7 Oct 2024 23:29:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>,
	axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 1/5] blk-cgroup: add a new helper blkg_print_dev_name()
Message-ID: <ZwTRN4RPKjRIgMAF@infradead.org>
References: <20240930085302.1558217-1-yukuai1@huaweicloud.com>
 <20240930085302.1558217-2-yukuai1@huaweicloud.com>
 <Zvrb0DXhtVHT2lfa@slm.duckdns.org>
 <ce2b9ed1-cf74-1d50-a72a-23733c0d1db0@huaweicloud.com>
 <ZwS8lwQ_fN2HY93p@infradead.org>
 <8aab9d5d-ed45-dc38-085b-e6ed67d0b3c6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aab9d5d-ed45-dc38-085b-e6ed67d0b3c6@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 08, 2024 at 02:24:45PM +0800, Yu Kuai wrote:
> Yes, but this name is not major and minor(for example, sda instead of
> 8:0), Tejun was probably talking about major and minor name field.

Yes, I don't really want to add that as it is a horrible user interface.


