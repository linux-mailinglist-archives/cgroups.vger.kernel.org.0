Return-Path: <cgroups+bounces-3225-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F057190C477
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 09:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED211F22366
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 07:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4DE13793E;
	Tue, 18 Jun 2024 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3VPL7Qs5"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C27918E1D;
	Tue, 18 Jun 2024 07:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718694768; cv=none; b=J+WnbHtBZw7pFlwJ781GX90sCddCktsfQg02xBKyDvPzxl5CgzIEfAeeVNOynGxBmEc2+meMArrqPT2Fat8MfrMXeEFDemzD+CuxnJVdPB9S3qbp/eTmmJ7V/7M9JFi+fdfpaTTHMW8bqGP065f9p5/H/4oTrt735WKmf366yiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718694768; c=relaxed/simple;
	bh=84oEK2la+pdCXveM9q7mxMs8TSyM+0IrFfvfjlJkk+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNIB7Z6h1ITlZ6qUiG1mTKRK/cg/B/sOchYi4TRntpMpjKZc7XNHHWdnCGuX4/A69VS0GHcA4BIVMILLCAtA+f4xZicEM6FJAJjrxy6Wwqaz+YIQRTjsofFUrETimYiE2N3GS2NAN++4m/qCQG+gyoss7DrTDazo/omxS7U5InQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3VPL7Qs5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SwIPm3HHHScXvzwW2YP/gyc4Q7ZKgoG76gRHm9Uog4I=; b=3VPL7Qs5nBb8dYE+xNNk3EILPn
	W9BVxnOriB/n/KMSny7rhUHQrV6I3/1PyIqyVcxSuMt2Q16ClbgX01J2QVda3Zz7V8VNKipvBUO1p
	uRh8lWRTB4C2Paea8e8S5HGG6jpT94k9z/NPBKt6EW/0sI+rCnSJSRbQLyx/dgv4HDE/G/wqeQbw0
	pp1jO3kR084W244w+UOob9LruPvOfC7V/rZIRO4NfQEy2cosdkVClRPWxPtIHoUpmSR09x5Mztajq
	4IRtKqIO7mIuwIjtQvTZz5GveM322Ci/GppSIoNZOs/oy/BOO9eS92wD1yy1YZwfHudMqlYuoBpZS
	ZCV1Tq0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJT1D-0000000Dv6s-1VfH;
	Tue, 18 Jun 2024 07:12:39 +0000
Date: Tue, 18 Jun 2024 00:12:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, tj@kernel.org, gregkh@linuxfoundation.org,
	bvanassche@acm.org, hch@infradead.org, josef@toxicpanda.com,
	lizefan.x@bytedance.com, hannes@cmpxchg.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 0/7] blk-iocost: support to build iocost as kernel
 module
Message-ID: <ZnEzZ0Xslaxfm-it@infradead.org>
References: <20240618031751.3470464-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618031751.3470464-1-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 18, 2024 at 11:17:44AM +0800, Yu Kuai wrote:
> The motivation is that iocost is not used widely in our production, and
> some customers don't want to increase kernel size to enable iocost that
> they will never use, and it'll be painful to maintain a new downstream
> kernel. Hence it'll be beneficially to build iocost as kernel module:
> 
> - Kernel Size and Resource Usage, modules are loaded only when their
> specific functionality is required.
> 
> - Flexibility and Maintainability, allows for dynamic loading and unloading
> of modules at runtime without the need to recompile and restart the kernel,
> for example we can just replace blk-iocost.ko to fix iocost CVE in our
> production environment.

Given the amount of new exports and infrastructure it adds this still
feels like a bad tradeoff.


