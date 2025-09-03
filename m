Return-Path: <cgroups+bounces-9677-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBCFB4274F
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 18:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9C81BC38EF
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 16:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2565031354F;
	Wed,  3 Sep 2025 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3y5MkkL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13EF239562;
	Wed,  3 Sep 2025 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918417; cv=none; b=sg4d4tXoSzRPz0grXfgdK2YK3L8KOJNR9ATDlMWCieqaRNvq/Sp8Z6M4GZk/xmM5xMIWQ/F67TGjLuwlXpSgZrBWL6vyDzmu6uxpYsFyvLzS/6AeYH86+PPVXelq1CjU0Y07wndssJpWBwFkhkD3aj6uPx2Sw4iGieS9ORutIDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918417; c=relaxed/simple;
	bh=F4UICW0+whfKFfSpa5zuMSqm0DVzQoL0Yu1hWvbm1jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJDFY5NIBoOp4y64Pt+EHate6xw2YZ0BkniDivJPiyxv6ge2Rm9frioGg3ylAGUVSzUNwrxIz6NTzoIWqBkuREiEEZNwnF5tI/7qo4tBtTs7hcIqW+WP1nGXLYksSHbfHVkHWk9VT+47J8WhRTLBBTT0EIHLEhDlGaohnrKPnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3y5MkkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21044C4CEF0;
	Wed,  3 Sep 2025 16:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756918417;
	bh=F4UICW0+whfKFfSpa5zuMSqm0DVzQoL0Yu1hWvbm1jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3y5MkkLnE1mJfxy2umMQ4UT5u3eIR8qoMXeihN4NpF2J37VcLFMWacqokO5TFeAS
	 9Wi/b69ViPdBrlb74hOWkll8y+zwNz1HVanAy9RRhztpPBrMfAilZqCBUFlGTK7BvG
	 YxqoP1vaBmR9FdGQNwM/wN+M3ykK7BvD2VxBE4I+LDzadS9hJXcBN3AXPYDNjgHKJo
	 amFcclv20hYnMgA0zy+5kAsB1gRnyaD6s/TrhLnz7sE6hrYlHlx5DPQlqtV1LkOp/a
	 atmxDEX4USr0yRpuCZmPJ4X+yu3t60cXb+yxRzwgdQif78cjqcdjEeNrlkboXJOrV6
	 suQIPhv5jCSxQ==
Date: Wed, 3 Sep 2025 06:53:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Yi Tao <escape@linux.alibaba.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
Message-ID: <aLhykIPSGV1k_OG0@slm.duckdns.org>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>

Hello,

On Wed, Sep 03, 2025 at 07:11:07PM +0800, Yi Tao wrote:
> As computer hardware advances, modern systems are typically equipped
> with many CPU cores and large amounts of memory, enabling the deployment
> of numerous applications. On such systems, container creation and
> deletion become frequent operations, making cgroup process migration no
> longer a cold path. This leads to noticeable contention with common
> process operations such as fork, exec, and exit.

If you use CLONE_INTO_CGROUP, cgroup migration doesn't just become cold. It
disappears completely and CLONE_INTO_CGROUP doesn't need any global locks
from cgroup side. Are there reasons why you can't use CLONE_INTO_CGROUP?

Thanks.

-- 
tejun

