Return-Path: <cgroups+bounces-4013-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A0942295
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 00:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E850A286AA2
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 22:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9143018E02B;
	Tue, 30 Jul 2024 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSZI4ZLV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33B31AA3C3;
	Tue, 30 Jul 2024 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722377690; cv=none; b=EYcqOzUVTxU1nYAWaJLlbrwUdVzTgNVx3o7dcFhjTUcti15gWIewiEfZyVdb3PxWepjC0ch3jPQ3AZBz4ysnRC91dCNxkoVAyvGMz2uSIi7K0cTXwenPWg0d3dXVMOyQDWQ22NC74BdHdJoo7jaVzZMdy2Pwvhsxb3iSZ9/e+Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722377690; c=relaxed/simple;
	bh=E+b8ujX7bguvXqf7N/m1AXx3cZLbyhJGYmSw/0+EpMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naS3zzKGAXhJ+wvWWroZ/6Q8hVgWZFWsBrGPi3sNiQ+eTtN+sxe5rJ0DYOUeCbHbG6gtVcwOTSdS4IoAW4vwpBBOhNh6VlhIWsi2xQJCIkgx8yjjb7jXi3w0YUIHIEcLmClVzUCuBAOJ6BRvqTrxuiMSCDak2cWqMPuMA4lgxZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSZI4ZLV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a211a272c2so243797a12.1;
        Tue, 30 Jul 2024 15:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722377688; x=1722982488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B16lMJLjZ5QFXnHsYRnPAdBRJBP0j3bpJT50otO42ys=;
        b=iSZI4ZLVsfxarWb3VuPw0Fo9oDRF1AcZKZv6l9KhfofKOV6jRtQB64NTx06JE1hTYk
         mi5jU3r2vLrII/jZG2eDiWbYg0JtOyJGck+LJ1tIC06wQNv8wKXxib8ziNPkOfjkfGCU
         I995oHtvNVtuczjnUGkwb0fXI1HdTkBQmACHsgBiyIHzFvYvzHCPkEW8AfZfZsMaHjRG
         wkplHLD49IlfN2aNBAd1dsoials17BL9Ju46PobOkcpuQnJnwyWlNHZ0GVRpEBk2+ZcR
         5YaGz+kDEThO9UZdBIdeIiWvE3VuiJtt8ovBB950k9TExme3o/Uk6jr0Zsf1ibQcM/P/
         cHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722377688; x=1722982488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B16lMJLjZ5QFXnHsYRnPAdBRJBP0j3bpJT50otO42ys=;
        b=vmw5JaXRAfNKe+H8Oj8eh1gcT3jxLq4LvmWCVaSWvkDZIY3evr3iSxCsGOQFpLCY7u
         58WodlOxl+9D2jp+hXivX+fC1+llDbyqAK8HUjGU8NmouZqEBsI91vBvM3cYk2VZPgB1
         io3N2pEWKiFp4UngLSZ2eR0+hBKdrrevR6BJhIr0MT/zCwQF688yIKP6Av8++A4w74pq
         NPyEVqqpTOw29FG2fqyD4+DlXmKIpvLlKDAhBpBkRzEwDUEgY/b1x8gWugXLt0aDoLQY
         PK6fExHYM2S14Sgz/AvFKTutqaO5hk3/4oIBbkFk9EvMuNtTD6Kuk1JgQ9mMQohv2edc
         ph9A==
X-Forwarded-Encrypted: i=1; AJvYcCXjH/T2GzRwzrLr0Fh1VDOpsmawE0JocgaNK/2AIn672YtZinqhcxYYdPOJcUYGxyuaHIv0ptBr2zzin4+OJO9tyi6RHmaww62nty2kybDxnC+tl9a4BaXaxMEEtNg34VwEZb7a4g==
X-Gm-Message-State: AOJu0YzMKy/csivqTC88jD1gE9YyslUvjyQFIehmoiUjFeCLa6+rsTHb
	nWOyDDySTXBsjMPvn1ZEwwc51RyEoVrdNgtRMa4EFb2MYegi/mD3aGO6NQ==
X-Google-Smtp-Source: AGHT+IG4IyJ2Elz3UMtMYa6q3gbGa5OSCP0Rj+jQeEKoAxYQnM2nJVEy9jsdUMTA5CeuWMSYLsXk+Q==
X-Received: by 2002:a17:90b:17c6:b0:2c8:5055:e24f with SMTP id 98e67ed59e1d1-2cfcaab41dfmr5408192a91.2.1722377687948;
        Tue, 30 Jul 2024 15:14:47 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28e376ecsm11088302a91.47.2024.07.30.15.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:14:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 12:14:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	xiujianfeng@huawei.com
Subject: Re: [PATCH v2 -next] cgroup/pids: Avoid spurious event notification
Message-ID: <Zqll1sNJB4qQc0s2@slm.duckdns.org>
References: <20240730032920.3690263-1-xiujianfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730032920.3690263-1-xiujianfeng@huaweicloud.com>

On Tue, Jul 30, 2024 at 03:29:20AM +0000, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> Currently when a process in a group forks and fails due to it's
> parent's max restriction, all the cgroups from 'pids_forking' to root
> will generate event notifications but only the cgroups from
> 'pids_over_limit' to root will increase the counter of PIDCG_MAX.
> 
> Consider this scenario: there are 4 groups A, B, C,and D, the
> relationships are as follows, and user is watching on C.pids.events.
> 
> root->A->B->C->D
> 
> When a process in D forks and fails due to B.max restriction, the
> user will get a spurious event notification because when he wakes up
> and reads C.pids.events, he will find that the content has not changed.
> 
> To address this issue, only the cgroups from 'pids_over_limit' to root
> will have their PIDCG_MAX counters increased and event notifications
> generated.
> 
> Fixes: 385a635cacfe ("cgroup/pids: Make event counters hierarchical")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.12.

Note that spurious events are explicitly allowed. Anyone watching an events
file should keep track of the reported values to detect actual events.

Thanks.

-- 
tejun

