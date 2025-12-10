Return-Path: <cgroups+bounces-12325-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC66ECB379C
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 17:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ADB53134443
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4972F30EF9F;
	Wed, 10 Dec 2025 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="tn0WCHd/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF1430E849
	for <cgroups@vger.kernel.org>; Wed, 10 Dec 2025 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765384098; cv=none; b=HpLN8AzcEyPSApe3IsIWts1UflTRlvUPjZFsYS/jRwmtQa9qwQ3dhvVnZlxKLMfhDuGhQ5THnjivrG10ecC3GEMCAQ//0jrqJ9pYplI5e/DyGiMfO4ZeVFlnaIwKEpmX8AEez0OE7VF0C8eUgmOL2doS/tgLO8acP8TfddMcfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765384098; c=relaxed/simple;
	bh=lhToF7e0fRAXi9Z7TcyYwjvbI0fSr7lwBHcyINz2/Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9bgC9zmuFmgC0O3yS1XtjGYhUh765EfliAiTUM89KGLwDvuoQ1RBRaVsNqg/jRAZ5qtnYy2zjynJyyyV3RQWL9HBdqWfgj63tHzcHwYkz792sTn5hk3KKIgr/hqHqR+LH4qBABtDcds0YeYTH5clETmv8aHBqwmQCrr3bPOEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=tn0WCHd/; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ee05b2b1beso62378241cf.2
        for <cgroups@vger.kernel.org>; Wed, 10 Dec 2025 08:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1765384095; x=1765988895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7st3SloIc7ayJq36pfh8REUWXYhW/DKTGg4/6o2J1q0=;
        b=tn0WCHd/PK5NYzdJeEz9iBAqhoxl5PYBKuiOMZWPjatH9QtSwB0Wtg6v0zdWpNCBuq
         8T9RtqDoGqLVYeSiKPay8/kiQbpbtsJFepNuphUGKy+deaiBsIBuertF0UaRELyKAW3h
         hUTNtpfg1MggNPlMXETEUSVbv99I1G0I0RCUWaRUD4MmLKC9bpNKQRtPCIEhOiJLcBl9
         Opa4xeasn2Sp6M3kfZWgSRL1dDTWVWNq0aCskmrKuMZ9lfXJTdNIAyfcM8yUHVSoceTd
         czThB095RI52M9dQgzlLpl55Mn2+62Ntu1DQh2LWCbQN6N0j0oNaX5Og3FQKWpwweEPu
         M/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765384095; x=1765988895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7st3SloIc7ayJq36pfh8REUWXYhW/DKTGg4/6o2J1q0=;
        b=QTC/sbREcrvjg2++BgpbXJHAaLfOp2LRh8mOSJKef2hXvX5Wc9bhkL7+64GBicZMtl
         FQCvUcIm4Ky7MpdUnRS6pJMoND6iJJtQCBl4gVrM5mzT8rjt8PiKIWinvf7kbEjU/r0r
         A9oXwe36Lb9YQeHlYzgtYjknF4t2QvTvBbN5SVMMyWaNT5T2ngKwRwI8DJEDNKGxUxK3
         kWmC21JHta0DAl2NLDIuR+Tb867sHb5DPDugmvDOF0RPOQNVm/uRXQ5fiDr06vfqMPze
         KlCJTPt0vjpvt59PgTLNvv/ENPb6YN21fAktc/YuzRVXHiwz0jhPlj9O/LrSgfu35CdI
         GoZw==
X-Forwarded-Encrypted: i=1; AJvYcCUGQzHvHicupjl4VG+hVnT24YzrYBB75U1T+kBK5cuUD/ZCMK0YSzVYNkDucAa7bM2SgOCLtxfH@vger.kernel.org
X-Gm-Message-State: AOJu0YyRf1cPXRytHot9KVi9SxXsWx58rVHiWTrhb8bbUJxvOcPEQXqW
	9wkqeXvlbLXEmtTFHJYnzMOStHxILI8skt51zo2KpAuWX29artKTa9Yh7VWgxvay3BI=
X-Gm-Gg: ASbGncsyqxYSQ9HoPZd04ofeKAPueqd3PD2UCSR+P2Nq7QJ/u3+FnKGIORgda8c2iWV
	N3T2DTAypyM2pqR3mtHtdodMKWu7Vph8KEz+k/yqR/dItMj8Q9c9Aw2TU/0oPT87U/yIdL1nv42
	BA5yjX9EUB7/38iFNcPfJ8yzTmNuDw3ThlETeQMs52PeHzgT3HAsBFLMw3Qt+WzDCz/uSCQ2K5I
	1zky2sFPs5ZjQ2VOkIdR7yqS7TNjiYnUJxiv1anv6VdjhwJ3ZB2T+hj4OVAOGpVUN4eWto+TYY5
	yWXsNkDoqpac7qCqJFfy5R2qXpqk4vsHLMN4AQ+vN4mCLnrn6baajpiIppBkIX/BMtn/YtuD/T+
	q45N6UvIhDC0ea6Yh50QAewJpPJwiClJg1qEmQrHWMj/kCAvLr4NPpxyMCT6DV+kPTlHOOAe+SY
	EGubzhXrI+NA==
X-Google-Smtp-Source: AGHT+IG64O7TTyjxLTZ38fgOeBLjdeYNrZLY4n0ybWUVjcABTD3EdxQBSK+822vTZP3xcEIfpC6UqA==
X-Received: by 2002:a05:622a:14:b0:4ed:6177:dfa1 with SMTP id d75a77b69052e-4f1b19487b9mr39447421cf.0.1765384095434;
        Wed, 10 Dec 2025 08:28:15 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f0276b0351sm119233251cf.8.2025.12.10.08.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 08:28:14 -0800 (PST)
Date: Wed, 10 Dec 2025 11:28:13 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com
Subject: Re: [PATCH -next v2 1/2] memcg: move mem_cgroup_usage memcontrol-v1.c
Message-ID: <20251210162813.GA643576@cmpxchg.org>
References: <20251210071142.2043478-1-chenridong@huaweicloud.com>
 <20251210071142.2043478-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210071142.2043478-2-chenridong@huaweicloud.com>

On Wed, Dec 10, 2025 at 07:11:41AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Currently, mem_cgroup_usage is only used for v1, just move it to
> memcontrol-v1.c
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

