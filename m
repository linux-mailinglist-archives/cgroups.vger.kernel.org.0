Return-Path: <cgroups+bounces-5286-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F9F9B1B5D
	for <lists+cgroups@lfdr.de>; Sun, 27 Oct 2024 01:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED481F21B44
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 23:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1751D86C4;
	Sat, 26 Oct 2024 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yk6cmSEL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2EB67E;
	Sat, 26 Oct 2024 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729984348; cv=none; b=WLHZ/ebN4FOohkagUIbN+Z3vOacwyFNII9ZQiagsd39h4cRIiAtmANAVOEamq4lu3iMWqJsIxKhHQHsuIZVFt7ZxmTvLqfFYbcQJGLHmzwVsBFHFQB6VDR/2PXVpyvwecEkESJEkWAI292O0WApQrxFQonW49p0CIeKCG6tYVE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729984348; c=relaxed/simple;
	bh=+OlQxkESBOx+ICfUACsJI13rWm9BKFIpOHxESElZsNw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jnSVLoz+CNfEdxDn5vUzQ9RD8OeyIpEQ/NbXomJY8yz/Z1+YszhlVstuGaI60vgS2JMOgMRsfBevTaYaXhljCM8XoGuJ7X4BcS3XkJHfgWWPj/0GGhkKjMSGq5h8ACmEGTbKH6OOcIo4GNVcY/ORv4xtt7IOFo6WiHnBdew52lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yk6cmSEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E32AC4CEC6;
	Sat, 26 Oct 2024 23:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729984347;
	bh=+OlQxkESBOx+ICfUACsJI13rWm9BKFIpOHxESElZsNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yk6cmSEL4+4f/peOBANCoOT0mIjHW2ib7h4rZm2hx4zrImH01M4W9VGnsJYz8793J
	 t72ZsR1w98DVs0lVb+Wxe6nLtPQ1+WSBSxx06cEQO0pf4cI2A/wAqXDvz/GWf5kWQF
	 i6v2KcxYxJDGznnJgN74C4Js7GFZW3YJUWQ7kuyc=
Date: Sat, 26 Oct 2024 16:12:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
Subject: Re: [PATCH -next] memcg: factor out mem_cgroup_stat_aggregate()
Message-Id: <20241026161226.baba18b5aaa91d806209a9da@linux-foundation.org>
In-Reply-To: <20241026093407.310955-1-xiujianfeng@huaweicloud.com>
References: <20241026093407.310955-1-xiujianfeng@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 09:34:07 +0000 Xiu Jianfeng <xiujianfeng@huaweicloud.com> wrote:

> Currently mem_cgroup_css_rstat_flush() is used to flush the per-CPU
> statistics from a specified CPU into the global statistics of the
> memcg. It processes three kinds of data in three for loops using exactly
> the same method. Therefore, the for loop can be factored out and may
> make the code more clean.

Thanks, I guess that's better.  I'll queue it for testing and shall
await input from others who work on this code.


