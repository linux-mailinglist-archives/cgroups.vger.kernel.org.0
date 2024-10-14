Return-Path: <cgroups+bounces-5110-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF2299BF85
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 07:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DE71C216CB
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 05:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D8413C690;
	Mon, 14 Oct 2024 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Kg1ZjbQ"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89584A2F;
	Mon, 14 Oct 2024 05:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885351; cv=none; b=SI9oong5ODbDO8VbbXfdX4NNtD/yWaNCuFwW26uIC5AA0hHnsfH9H8+iHMhZdXOoDZK9RBg/GLHcjy8InuS4TtNXIQbF2sySuDqjC+X033FBVXnyuUUWVmfooSGEWiobaSekXmbvKNX3Mi4ezwMFwAMi/EKSkI6cVRTotGBhB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885351; c=relaxed/simple;
	bh=R73XglLBTODkUcUDXOPBGo1pDlnhmgyx3VPUbbJTNw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i699JKZCGlOpNsHvaVB2JWZEL2hJrCNrfLsnbY9pY6Kf9o+1Xv6Ia/oSF/wxRY5E7fy5N7iT9kT9bq5YSCqvH/cY44hx3Jb9DAZBtnkhW8S/PB1/iOudRnk/n6QIXl4zOZnYETpknXq7Nbk8TSziU++lGpqyU6NXnVRA/1aoYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0Kg1ZjbQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R73XglLBTODkUcUDXOPBGo1pDlnhmgyx3VPUbbJTNw8=; b=0Kg1ZjbQdYrGPe0e6wBGlszoEq
	b0jukYasX90uH7i52GFM/gXLdplD7pnN3dat/YP00xsxMNTIPedzzidlWCWJ0mwPmpKpm+4abcf3Y
	Zv2GMn+tcpzpP7SQuylXyxlQuRGOIEbS5z+uemvxADSXXfFToWcvRaE2TJI76dXJg1+djCz/DkRCz
	vSm0qoj31kLSaXhFnIwpmH99QF9lEHJ9C1SkYc6Crq5aJAkDa8Cx+C5fM2MGJwm3Vx/Y6hhC0mN4h
	WgEWCEJu79SkWJ6LAXoJosQ7lM3nKv7PuIEslR17JoVSObEeLI3Yy1UoEuO2l+ua89zEGqQ3g8uFo
	V247bkqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0E3R-00000003o96-1pjy;
	Mon, 14 Oct 2024 05:55:41 +0000
Date: Sun, 13 Oct 2024 22:55:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: akpm@linux-foundation.org, hch@infradead.org, llong@redhat.com,
	xavier_qy@163.com, lizefan.x@bytedance.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] lib/Makefile: Make union-find compilation conditional
 on CONFIG_CPUSETS
Message-ID: <ZwyyXei54M7ZPF_Q@infradead.org>
References: <ZweggYOQtt5OUgHJ@infradead.org>
 <20241011141214.87096-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011141214.87096-1-visitorckw@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 11, 2024 at 10:12:14PM +0800, Kuan-Wei Chiu wrote:
> Currently, cpuset is the only user of the union-find implementation.
> Compiling union-find in all configurations unnecessarily increases the
> code size when building the kernel without cgroup support. Modify the
> build system to compile union-find only when CONFIG_CPUSETS is enabled.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


