Return-Path: <cgroups+bounces-6281-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCD6A1BD13
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 20:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E967A1FCC
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 19:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8342248BF;
	Fri, 24 Jan 2025 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qzC8UQZV"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E4314A630
	for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748659; cv=none; b=TGvW+v7j/0G3ViEoHlO1buv93TfUVHjRNr6Xm21YoXfh1zPRj3jCblVBZP2VZ3HmPo6qr4rQ+SN/m44eJyDvRpXBqslh5lzmJw8VEBeknZrKblcxZlcxzN7QrySN/YFb7aFcvmGYhuKOnrRiYUP2WFrT6rGfERW7L+l19JnrGyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748659; c=relaxed/simple;
	bh=Ahx03qgJkhw2STjYI2XDQTa39IVlyYJ70dWWeil8oUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zqh6wY7mC0XT7WOWGuQhvjp/psbxW9D8fcFTSWfA0prDhiTJV4PDw09eJGku5YWOxP4wNx1Yycjml2ZuqUVfh4TIwlLwTsIy9iDxlFThTUeuyd/qXE1LPbLH+HPXFZ8iItIToFE4sL2UGDv9BzPuWvQ4TiSPGkUTB/HUUheWMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qzC8UQZV; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 24 Jan 2025 11:57:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737748649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zileG0hXQskDrKYttZ/vCg6eRsso6N3/emAqFgFulqg=;
	b=qzC8UQZVxGE2dxC3aH6QcXWLXS1hwaeskSrF2CBh7aUTZZT6uORaC+bBDfJpVTRuack61K
	12u2I3kvdTHWDojp/2agKRdjCq43CImCcsB9g2bRqulhkEDBCfSA63lhTltOTL30SPNLv9
	acNgmLMdD4QXlhoaKkkBiw02bb2pH5g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	davidf@vimeo.com, vbabka@suse.cz, mkoutny@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com
Subject: Re: [PATCH -v4 next 4/4] memcg: add CONFIG_MEMCG_V1 for 'local'
 functions
Message-ID: <fevn2zmc5emc2banxr6o6eagn42yfhk7f2sadbfdpz65r3swr7@dhzeynw5kcdm>
References: <20250124073514.2375622-1-chenridong@huaweicloud.com>
 <20250124073514.2375622-5-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124073514.2375622-5-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 24, 2025 at 07:35:14AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Add CONFIG_MEMCG_V1 for the 'local' functions, which are only used in
> memcg v1, so that they won't be built for v2.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

