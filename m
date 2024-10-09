Return-Path: <cgroups+bounces-5087-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7B3997229
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 18:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1771C23F24
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384E81DF759;
	Wed,  9 Oct 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vttrs5KZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2C1C4631;
	Wed,  9 Oct 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492104; cv=none; b=cVl/YEXbRdV9PBoXHmxLUPP+yMN7fQW7KusORzAH5ynDgljHAFV5ArD+pGmfa+MTtbsPhktxeAqJNkii3BxLaki9NIFr6lTwNCUujBk733xwr0p5b2mavkU/2z8QGWYdxx5yJafPCEsAqg+9eswipgr4oPl9nbaM+8UUnOzH68s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492104; c=relaxed/simple;
	bh=/DG49ZE8Q+idHvWM4FgxgFRGf10ADFAGuGSYPUabRkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJbHDfdxmoepTNMBCWyVwmjCrzZYY/mnLNrCRK45OcuqpaaM6NWRDfdfGNkauFnWvLFpMCKHglgkwTqKa1+xIN24NQ63tO4HkeNd/TIm8NXPnMLZk/FIGYPSJbBkdncZlBndHpelDmKHu77rH3aZ3Dgca6yG1BEKNES3gCf53rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vttrs5KZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FE9C4CEC3;
	Wed,  9 Oct 2024 16:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728492103;
	bh=/DG49ZE8Q+idHvWM4FgxgFRGf10ADFAGuGSYPUabRkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vttrs5KZijoyf1OU5PgfEEZLZGlA1N4Odz1SyfRUcr+sZeLdCfxQpYHeZn9LEe3Cm
	 W7u1kXp81+pmr4Z2irbmzriJTjGpXw0jCdyzLKoSOdo8B2oKjnyP+o+E3rQpEoMGfz
	 dqEbrA4Aw9HyetDUtdN9H0iuUeDyHrCbu31ZDcU2wF7jyO4OgQk8+1qWVrb+QkOJl1
	 krQjFQ69h9eFUzwz4A1cKQ5WoARmS3lXh7Mv/DTv7Z6z6Cd7bDqkZDNfpE9kkdtj2G
	 G6/GRZYFu87uI6AeGkhFOn++vm4rp9QTg1jV8xk1nESVKM4ztGSa+jINcalf2MLsLT
	 U8UkIZ7l60nAQ==
Date: Wed, 9 Oct 2024 06:41:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, xavier_qy@163.com,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
	akpm@linux-foundation.org, jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Enhance union-find with KUnit tests and
 optimization improvements
Message-ID: <ZwayRgFsfgZglODN@slm.duckdns.org>
References: <20241007152833.2282199-1-visitorckw@gmail.com>
 <ZwZIXxQLyJUL_nOW@infradead.org>
 <ZwaPdSOMWQzuoPWU@visitorckw-System-Product-Name>
 <1ccd6411-5002-4574-bb8e-3e64bba6a757@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ccd6411-5002-4574-bb8e-3e64bba6a757@redhat.com>

On Wed, Oct 09, 2024 at 10:53:08AM -0400, Waiman Long wrote:
> The current union_find code is pretty small. Putting it there in lib allows
> it to be used by other kernel subsystems when needed. I believe it should
> stay in lib. If a slight increase in kernel size is a concern, we can update
> the Makefile to make its build depend on CONFIG_CPUSETS which can be taken
> out when it is being used by another kernel subsystem.

Yeah, let's CONFIG it for nwo and see whether there are more use cases. If
that doesn't happen, we can fold it back into cpuset.

Thanks.

-- 
tejun

