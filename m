Return-Path: <cgroups+bounces-6716-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A932A44D9C
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 21:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFDC18925B1
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 20:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97422211464;
	Tue, 25 Feb 2025 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTqj0hob"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6B20F068;
	Tue, 25 Feb 2025 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515458; cv=none; b=JhwgILq1TUNnw+7DBd29cobmwFRWUXFjNyTxw17du32EdWJrSfi4DmKCfrLUUTCZ1Fv2qpAViWfYHVcDweDdXgKsS+je9T8T2m26DsIRc6D7EEwb71xuEZ17/LxsZzHqhf3J9EC+RsN3EEWC0jOuHFm2OyJx+W/xQXHSYiCKMlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515458; c=relaxed/simple;
	bh=5lzorwQ9uVenvnTndGvYngI3rEucdxUuYqRALUMd8bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMo8ixIUlxMuQgzYMukV2hax7+JsQoBcLMiiYhUzS8kKlNMtzCCuuDe8VdQJ4Gw/oRzAjENfuEA88/Aal+MAv4AW9vxhTRAqkns9bMamHvTD1YKLZbbDLBazYnBqDpOIMEtH0r9PceijYpo8HHZ9I2TBQMYmnWE/eFW7x2gFW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTqj0hob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4A6C4CEDD;
	Tue, 25 Feb 2025 20:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740515457;
	bh=5lzorwQ9uVenvnTndGvYngI3rEucdxUuYqRALUMd8bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTqj0hob6dfdeoU2tltWFbGA1wrb4LVWI8L7U3AtI73FrdSqEvUGcbuA8pwlN0X0u
	 bCwts15U8rPWqryXGt0L04NtdT2hWKU7LjZTc1SVkw4WYUDhn91S7bfXYuqNZS3L97
	 O9F3Iv2pzpYwzw/fcJYfFnat5adjR4b7bWonXgRcpfbKfpEzhg8U8wYsTJBTuhm/ne
	 7A7zIgPFVWGWOzTQmJ5FEfsFThnMXQIukm1Cc/Emsl9Tf6D41ucbhJ/ptsvCycxjj2
	 eiDoSihUMCINecsBdc+8J4b6nbLm3MOXTw/Nau9HjfytRE4faVMzgsz/pqSKVE8bex
	 rr48MRdPoOVtA==
Date: Tue, 25 Feb 2025 10:30:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, josef@toxicpanda.com, axboe@kernel.dk,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 1/2] blk-throttle: cleanup throtl_extend_slice()
Message-ID: <Z74ogC_stfgF3kQY@slm.duckdns.org>
References: <20250222092823.210318-1-yukuai1@huaweicloud.com>
 <20250222092823.210318-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222092823.210318-2-yukuai1@huaweicloud.com>

On Sat, Feb 22, 2025 at 05:28:22PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Merge time_before() from caller into throtl_extend_slice() to make code
> cleaner.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

