Return-Path: <cgroups+bounces-5089-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B42A997237
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 18:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F241DB23124
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011A81E1A29;
	Wed,  9 Oct 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g76m+Nrd"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE6D1E1C15;
	Wed,  9 Oct 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492268; cv=none; b=esgqRpjhmD7QC8CrWvoi0FmI2QSSezwM1i0gzyXjnCgj1YOved4BMDO9FTtpzcAucGl11cXCXkTXEKtrB3AcwCWtrgV7zBblySfcazMx2vtLLeGfCkO0+4IC6npnnauW4A5gHmMX9pZnHdTrijsia7LZOclGjQJ+ctWq9k1V/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492268; c=relaxed/simple;
	bh=G2+jRbQspWwKdb+4Qze0UlJoaO50fcpAkKdefyDP0RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fdn3+K3Nfy0s8BctYWB+F7Y119DWPq7bNVryZ0ZBDYA1KAfle1mwUDqtmTYV6Jr+inbqT7sUQiZ6s9VvzGrlOxMKaEewsxXF9Oqsm0gUhVpSdKeBRzuUZwvFL0heBpmYvcm64lhCuUayDxmaCvWgWrozXE3/xjQMo7arpgSAgu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g76m+Nrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED49C4CED9;
	Wed,  9 Oct 2024 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728492268;
	bh=G2+jRbQspWwKdb+4Qze0UlJoaO50fcpAkKdefyDP0RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g76m+NrdT1GZ7DAakDSWRX5BfmV/oJXbZj/QguP6+JDzHkKMDIPShV1HagQ4oFkv3
	 yPYrPFaOtrNKcHSadGnMhjEdns8lR5964He+JFQJnQ7OcEYZ0MvkSRbovf9kjC/ORs
	 cTfBmT10WyeJLf4NNeYW//KrKeBcPW9IWopSg53ikd7G9Tt1C2zIPk5qJUBJm6y6wj
	 dSBs+s/DaDgmqZ3JwIQrLWRGZMhhoon36vu8V172tIZ+GvQWNMTB9NVg/1In/c2CQ8
	 hTstklidvJjFClY57ku2ajEL17HAQ66Fm4ZftRL1MGqKWiS5OT0oVajKpPNXXxohxi
	 XhfSKZ62/mQDg==
Date: Wed, 9 Oct 2024 06:44:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: akpm@linux-foundation.org, hch@infradead.org, llong@redhat.com,
	xavier_qy@163.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	mkoutny@suse.com, jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] lib/Makefile: Make union-find compilation conditional on
 CONFIG_CPUSETS
Message-ID: <Zway6wlr1m-6eQgQ@slm.duckdns.org>
References: <20241009154022.2432662-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009154022.2432662-1-visitorckw@gmail.com>

On Wed, Oct 09, 2024 at 11:40:22PM +0800, Kuan-Wei Chiu wrote:
> Currently, cpuset is the only user of the union-find implementation.
> Compiling union-find in all configurations unnecessarily increases the
> code size when building the kernel without cgroup support. Modify the
> build system to compile union-find only when CONFIG_CPUSETS is enabled.
> 
> Link: https://lore.kernel.org/lkml/1ccd6411-5002-4574-bb8e-3e64bba6a757@redhat.com/
> Suggested-by: Waiman Long <llong@redhat.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Andrew, can you please pick up this one?

Thanks.

-- 
tejun

