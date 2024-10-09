Return-Path: <cgroups+bounces-5077-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84284996479
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 11:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60061C216C8
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDB41898EA;
	Wed,  9 Oct 2024 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="boitkIsU"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A1D137C2A;
	Wed,  9 Oct 2024 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464999; cv=none; b=a3mWVbduqIiThQ4E1LPaPq/gkL2gQGAQMPHhRlxsx2abRuzaVOLBVYk/OezbZ3QsjMVurmhbNEX/dLkj/9WaR61tjjnCp+XfZAJWC6XgH7Wtsfwr0dh23BMvxNBnHNCxZWR1nVEvVD/e7teVySBiucY8qVnnFH6pYJo0LFdFc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464999; c=relaxed/simple;
	bh=UYYX84jQ+gv/2uzA96eLKpa+x32MLyAZ5N+5Ip7be8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+QPRV1ci1AS7ip/IMPUD5K5VB2MCFk7SWiNj22nfzMeUjdg6rS1uR6smLh4DZb0icuAnFbJEDtJq4QAXDPVGxJA5A6tsSfxicFHybAJfqJYzl8uBiiqEbu0OuXwhkwQASH5TErwpW+mldY+Jq18Y8C08JqObyCQAw+WR9GU6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=boitkIsU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UYYX84jQ+gv/2uzA96eLKpa+x32MLyAZ5N+5Ip7be8A=; b=boitkIsUkMJz/rUPnC/ys1JRQx
	PZlTqMxHMb0B56NDC1et5dMlkBOEPzw6bYoWCrvk1vNA53HW+O27sHSrE131cMyzw4/UWtkmQp4GM
	0X2vf09y2omwzS6roEefLTZGa9gDRTKKovzolAj144KRQ/QkL01VuKLGmAd0x+5Pbmw9qJ80DY4YO
	+42+XU89CjQF0tgSyh2fs2crRLc6xESjUPqhSRkdqQT9ybqhmLGWoe02Lv0f+6/EL9MkTV2zJbQr2
	D/NR/8lUb9rqAV5C5aHzLKacFAjhi/+ab4bOGspfn4f2n8TzIKsjV1esBfzVTwswGZI3AI9eqNYBG
	XwwlKsqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1syShb-00000008bs3-137p;
	Wed, 09 Oct 2024 09:09:51 +0000
Date: Wed, 9 Oct 2024 02:09:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: xavier_qy@163.com, longman@redhat.com, lizefan.x@bytedance.com,
	tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	akpm@linux-foundation.org, jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Enhance union-find with KUnit tests and
 optimization improvements
Message-ID: <ZwZIXxQLyJUL_nOW@infradead.org>
References: <20241007152833.2282199-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007152833.2282199-1-visitorckw@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 07, 2024 at 11:28:27PM +0800, Kuan-Wei Chiu wrote:
> This patch series adds KUnit tests for the union-find implementation
> and optimizes the path compression in the uf_find() function to achieve
> a lower tree height and improved efficiency. Additionally, it modifies
> uf_union() to return a boolean value indicating whether a merge
> occurred, enhancing the process of calculating the number of groups in
> the cgroup cpuset.

Given that this fairly special union find code is obly used in the
cpuset code, please move the code there rather adding more exports.
Even as-is it is bloating every kernel build even without cgroups
for no good reason.


