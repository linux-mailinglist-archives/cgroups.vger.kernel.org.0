Return-Path: <cgroups+bounces-5074-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A29995719
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 20:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31227B21B63
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 18:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA38212D19;
	Tue,  8 Oct 2024 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ne3EUR/R"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D11CFEA8;
	Tue,  8 Oct 2024 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413310; cv=none; b=DVj2cOmOQ/4SxFPnwC6EZ8XCLhGYY+/kK0hgRBlsnRfoGrQz9FFMbhvi4cTy0OixID466znmCKUTwiSdZSsTB33jaUwLKhZ7H1sCx4cU6VGWLG5X9mBJgzog4HtVcBVFCVCNavbYLWHHDZbQXCcZKn+EWNDA7jsE90fhivDcx7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413310; c=relaxed/simple;
	bh=KIUSnI4bSjcC/9tgO6G4ppN7X16GdeAUZEfsTxG69kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8BtpXs1k6wwtNY4U6wD3WthmZTXusXINJeWI7MzoIGFXdPnj+vzYLAYBmPJPE+Ndef+XPGZJ19IUfFZu7wpiDgBimA7eiwHGjF5R6UTxMoNsh1pzQHYJpA3jcoSPVOhq+3jf2NEzNu7Hy09yHBaxEciUXISX5slWigVRErR5Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ne3EUR/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A74C4CEC7;
	Tue,  8 Oct 2024 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728413310;
	bh=KIUSnI4bSjcC/9tgO6G4ppN7X16GdeAUZEfsTxG69kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ne3EUR/RDYkQ6ZyWe7NpbgdY+rg23oRfmSg2W53zWCNY7CI90SbzJnN3Zvu/pwjTc
	 MQViC91SnsgYq5UFcLQ6nWUR3uz1G8c9N3PWQbZi7np1ET1kxv91rn/8MLuZ9yRMrG
	 u9vXiR6elqC7Q/FLDWzH0XcDkPSQ2UosqCxqTgk4Py71fQnJcDugxgv/dm3fInC79A
	 8Q1i7apDtLPkRNrJiSh5aQKeM8chfTHvvfz6+0c5CfI/4mCpjhyS9g34QclHUacq1B
	 fIjaYZh7CLd/ShVqRmfV6FwS3njidge1m7Nix2qBnjwjGkL35E+TkUFvW206z9sSGB
	 mOE+V5JZqJS3g==
Date: Tue, 8 Oct 2024 08:48:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, mkoutny@suse.com, bpf@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenridong@huawei.com
Subject: Re: [PATCH v6 3/3] workqueue: Adjust WQ_MAX_ACTIVE from 512 to 2048
Message-ID: <ZwV-fOLWGbFcrF4f@slm.duckdns.org>
References: <20241008112458.49387-1-chenridong@huaweicloud.com>
 <20241008112458.49387-4-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008112458.49387-4-chenridong@huaweicloud.com>

On Tue, Oct 08, 2024 at 11:24:58AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> WQ_MAX_ACTIVE is currently set to 512, which was established approximately
> 15 yeas ago. However, with the significant increase in machine sizes and
> capabilities, the previous limit of 256 concurrent tasks is no longer
> sufficient. Therefore, we propose to increase WQ_MAX_ACTIVE to 2048.
> and WQ_DFL_ACTIVE is 1024 now.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Applied 2-3 to wq/for-6.13.

Thanks.

-- 
tejun

