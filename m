Return-Path: <cgroups+bounces-6175-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A00BA1305D
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 01:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935273A58E9
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 00:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D68BA34;
	Thu, 16 Jan 2025 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DduMg2gO"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ED6C139
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 00:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736988985; cv=none; b=f7CyRN+R21hyZ90xxxY4nf2cEpXxf6tgabPZtMr9ko27q5iYu7chRHtKBeX7UG7sMNWcPAM0mwdVpQlHpyfGUfwxUspPrilu2AAvlhV+VVr5aQYWfp7PpH9D7R1yq5RAQpRqmGY1MXyYK0Shdiko+CcjxGRCkrQ5qUyuJSPfcCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736988985; c=relaxed/simple;
	bh=lv6SjQESWLfJH9o8RtXD03zqZ0IsE/qa8bv9Boy39AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKCfcR8XXGwxbBXTzGuYH7Hu+2Nvjd3fpeQ85hrW7b76ihCg5njQ3HefqrbAsRorRGEINsb5nrJ12gAXzLOLjXB9QlBjPjG4aiPmOgi6zNvPC2TkPvLNuQ3v0ZeDt+4HvO7VPtPclZCS9aOFwzhBQQQvQKpyO04Dggaa9dj41fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DduMg2gO; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Jan 2025 16:56:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736988976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c0fr6r8MUsI0nHPdDxu06E4MP3JDa3AjRp+9l8fNOgE=;
	b=DduMg2gOeN2sR5oNGesL/PyCptFbPXG1M7Pgl5w1kzqdoIgVCNL6tJWak76nI0/qi+99oI
	JAQJiyVYNOsEm5NsJybMGEeXQ/xeiRSkiA1Q8cZjLAPLyCA/7xWUrb6hrSSf8kAJ82zgBA
	8rIKor0ABSGXEGKUKU74ju4ThbbjtSA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	davidf@vimeo.com, vbabka@suse.cz, mkoutny@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com
Subject: Re: [PATCH -v2 next 3/4] memcg: factor out the replace_stock_objcg
 function
Message-ID: <csaohmlolvyw45vo4gchrwkitlte4zdzkp4ij4hz4qt4nt4lff@iu2h6ccp2nla>
References: <20250114122519.1404275-1-chenridong@huaweicloud.com>
 <20250114122519.1404275-4-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114122519.1404275-4-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 14, 2025 at 12:25:18PM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Factor out the 'replace_stock_objcg' function to make the code more
> cohesive.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

