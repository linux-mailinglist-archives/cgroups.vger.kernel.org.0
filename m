Return-Path: <cgroups+bounces-3507-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B0B924D5F
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 03:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A6B1C21F6F
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 01:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383C01C2E;
	Wed,  3 Jul 2024 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2kiz0HQT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F82107;
	Wed,  3 Jul 2024 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719971933; cv=none; b=BNR0/2X3vO27pNZB8k3/5mOsG4k4SAgUOxfpNH05+M8U4KYt1RNUj9r9e5Dw3qy/iwu8fjeL5TlISuGgIsq65g8z1oua58jZT4IY6kPI4zTl/jRRrkj6f8Q0Du/YeWcFPE/0Q69qdP606S57+N5bM4/QdSXJ1JunS8sc1+JnZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719971933; c=relaxed/simple;
	bh=XPORJfxOHShwH0PseKqVETj1J3w9jE2nCdeIejt76UE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g5DwH+5uQxkJ29Wi6LKWk9kkGmnOaJ4OECAuavnUAE3vipWpLxjQ+6iKyvHLDkjILgMcScMiAkX+ESQ68HBAgACg5yqPlFeVJOlQx5WBOEWL6mqYCgeoRkCy+M60eSxaC6n3Ef55DJ7lGgYvnpVladDBKBKK74zt9qNJ+8MOIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2kiz0HQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9CFC116B1;
	Wed,  3 Jul 2024 01:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719971932;
	bh=XPORJfxOHShwH0PseKqVETj1J3w9jE2nCdeIejt76UE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2kiz0HQTXId7rdsgWmMGYACtREFWL4DSuxTFxS5MGRYTBil9axKXk5VRDd+XhHRpd
	 gVHBRYvYirr1NvNlc5D8Ps241ESAJaPgRr/jxMr79sNEKcqXBgBCJpfhO4XebnFcVe
	 yVu1QB66l4xYa+LM9t/ZMoD9XBvyT9xt46nbOSgE=
Date: Tue, 2 Jul 2024 18:58:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
 <corbet@lwn.net>, <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH -next] mm/hugetlb_cgroup: introduce peak and rsvd.peak
 to v2
Message-Id: <20240702185851.e85a742f3391857781368f6c@linux-foundation.org>
In-Reply-To: <20240702125728.2743143-1-xiujianfeng@huawei.com>
References: <20240702125728.2743143-1-xiujianfeng@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 12:57:28 +0000 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:

> Introduce peak and rsvd.peak to v2 to show the historical maximum
> usage of resources, as in some scenarios it is necessary to configure
> the value of max/rsvd.max based on the peak usage of resources.

"in some scenarios it is necessary" is not a strong statement.  It
would be helpful to fully describe these scenarios so that others can
better understand the value of this change.


