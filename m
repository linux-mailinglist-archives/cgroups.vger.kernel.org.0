Return-Path: <cgroups+bounces-11838-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B114C4FEED
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 22:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E20DE4E4EB0
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 21:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20AF2F12DA;
	Tue, 11 Nov 2025 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJwjbxE7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA2E2E62A6;
	Tue, 11 Nov 2025 21:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762898209; cv=none; b=Y0+U3CJDEodIjJz+aB/qOj6mBD0a4J8p4k8mornIpYN2CcuKzH6dv3b/b0Ik7ZVxT8g5blY5dKyfddulFZzP4EKDTR5AdqSwxXl/BRosg/5xpJoOR3trf9pPGICm/0W84cCXUSXPfiOKEvCeKngVnBW3WOYyhnO7Hq2UBuQpa4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762898209; c=relaxed/simple;
	bh=vJISqXmUpxdT8lzBBFifnwbiXA3DbYb/vXl20mNAF+k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=dlMEl0PxX93jReYn4kylNFtGD2+u6zRb1CLBDGygsb1d/l6cwD+tB6HdHb9t0biTYvk4l2wKXvBw2D5k7oJdQCQdGuuNDCfREmrbCe+6trbz9gvhOwSAGemXcxGqccKfC+LhrvgJ3UhDwQRVwOakemfTEWrsWqCezBnOnYFjks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJwjbxE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B07C113D0;
	Tue, 11 Nov 2025 21:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762898207;
	bh=vJISqXmUpxdT8lzBBFifnwbiXA3DbYb/vXl20mNAF+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fJwjbxE73e+tClrzkaoJKbRzYE0GulCDV0hEeeE39hG4WvCij49c6o0IYW3GbrobU
	 QutEiKcE3G1DA7MM9c/MgYa1moLtUZbgY8rhdU8q/m5Ds2exOB4FI3qr1lCSXZwCAC
	 p7ouFhUMlQ9S13nZVFD4UHleRMJ3pjy4jmyKzRbtCgKEViuTFKEBBifR8x7PGHnWYP
	 klT9DpLs/GtxZ+iswVend1Z45UnyYrvzNjReZvFmSOR76kJX6DRdjHmwr+5ZjqbxCC
	 E6zUSL7P+2MDLbNNQObIxah+Hnnqvoq5sBl2UJSra8xnpijdW8Xl2fItQJjA0D1rzr
	 AHUXRULMJmRQw==
Date: Tue, 11 Nov 2025 11:56:46 -1000
Message-ID: <577a9947ccf6c62018a4619226426346@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next v2 0/3] cpuset: code cleanups
In-Reply-To: <20251111132429.950343-1-chenridong@huaweicloud.com>
References: <20251111132429.950343-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

> Chen Ridong (3):
>   cpuset: simplify node setting on error
>   cpuset: remove global remote_children list
>   cpuset: remove need_rebuild_sched_domains

Applied 1-3 to cgroup/for-6.19.

Thanks.

--
tejun

