Return-Path: <cgroups+bounces-5052-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016209932F1
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294A31C22C26
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 16:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519D71DA0F1;
	Mon,  7 Oct 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P26n9Z5k"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC581D9340;
	Mon,  7 Oct 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317952; cv=none; b=tm63O736YXDZ+Zv6ofiol9qAm761ScMwFnSQUgM5TIUn4kfzN67z7+9X7PhY/vhUFHfSjL0gVk/2KnXO71EdVlTamudSK9l4HUmjxTxtFMQvX0dM2Zjo+7BBAbzwiIA3fq3nigWHR0JFz7LUDJHFCLNbItvpBpfB4YspB6cFRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317952; c=relaxed/simple;
	bh=NrAkcYLTsFz87IPK8hXk5IbfZ+UIzG6k6DHqUvqeC9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBAoA4fTiLDaN3eoAShpnmFKr6J+t6jI/sN9xml6anK4m6uqLSYagvkIeWGPuOYg9rRGMzOJqTvxzf1v3geF7qxca7tvho2Dz/GlxyC608ViIkNx0qafOTlKZDvu8BAOM5UIDxELaZSJgLqEp10wNMsxr2pagqFrvORzQ6LwRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P26n9Z5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670A3C4CEC6;
	Mon,  7 Oct 2024 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728317951;
	bh=NrAkcYLTsFz87IPK8hXk5IbfZ+UIzG6k6DHqUvqeC9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P26n9Z5k+72lF0TA2eTuwjDxsMFBB/v5kwJ30spSp/vyjeqfuBW08ChVbKQm+JWqx
	 chAxziGT7noZfZ9NRL7XKSHV60gW7oUhexJl09FOE/H04tBgvTpE0s8yxIqFwMccf/
	 H1gajmxLUz4AKeI7JZmNffktY0GJENjhbUxc8YGvLrhpMy+dhTuUSAP82KdD3iV9lx
	 fAcik/yPZTq4pLLA3uofcNVLIUMvoK9M5gYmIjYqUzlPSpK32EwUvusjdTRjznrpkW
	 qFikZa9hSq2TN4Nqng9VF7SoqhkewTh+dWFvFw/rmeabzdo9cc4u3CgVlJGAjWJhhp
	 mG9C3ZDoKBmPg==
Date: Mon, 7 Oct 2024 06:19:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: xavier_qy@163.com, longman@redhat.com, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, mkoutny@suse.com, akpm@linux-foundation.org,
	jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Enhance union-find with KUnit tests and
 optimization improvements
Message-ID: <ZwQJ_hQENEE7uj0q@slm.duckdns.org>
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

Hello,

On Mon, Oct 07, 2024 at 11:28:27PM +0800, Kuan-Wei Chiu wrote:
> This patch series adds KUnit tests for the union-find implementation
> and optimizes the path compression in the uf_find() function to achieve
> a lower tree height and improved efficiency. Additionally, it modifies
> uf_union() to return a boolean value indicating whether a merge
> occurred, enhancing the process of calculating the number of groups in
> the cgroup cpuset.

I'm not necessarily against the patchset but this probably is becoming too
much polishing for something which is only used by cpuset in a pretty cold
path. It probably would be a good idea to concentrate on finding more use
cases.

Thanks.

-- 
tejun

