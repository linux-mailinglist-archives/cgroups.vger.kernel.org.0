Return-Path: <cgroups+bounces-13117-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DA4D164B0
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 03:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D95023009215
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 02:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42062459FD;
	Tue, 13 Jan 2026 02:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZPBxRXty"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520BA1D5CEA
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768271671; cv=none; b=GYYvGMRFCIg61IUrFgTg7ccx80cV2v/rT+HdF78EsNxIKx6wY/htADXx8XSwv2YWpVf+Mg/P3WnjyQKnJBIjIyPwWv7TcoCmG6RpV0F8+a4hEesWXdpi3dX1ldJrQWz+omX76adGcC4igHY9u1GxONrcrmRChmxfit2uelkrNDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768271671; c=relaxed/simple;
	bh=sxQCMm6mAGIBD+A7pDuUkbis6/FGOFvMfEkmgMsKIKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSmpXZGtRcZPcDJrDuAvuSaUVLge1DGZCdT3qm6nlOKH3wsp0RUhxNqUPOwzebhYNaCGTgbkWnTVejtHeEgGdOX0A05D4TiMS3mg5q6K2AJTsSKleyzgRwFxSMkmHggWGulTWQH7dnpJf2nXfV2oZHg1aB1aY3x5dkWR5VrI/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZPBxRXty; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7c47ff99-4626-46ec-b2f1-f236cdc4ced1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768271658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmDNvAhPPmik490ESD8CzA1I44hk4voNy+X8J7EwDSo=;
	b=ZPBxRXtyvVg2YawHBu1UG2LM5GYlhA3Xo5UMZW3n9gtBBiBxgk0mGy7IFTl1xwiZTrSMD2
	rzpf9kUUqFcVDU8u0xmXyQAW8JVBZS1yWNr8JSsCBEqTdo0wM5aZDOlKetLTLpWK5G7r/v
	IWQKBT1o1IHQnlxlXdmp5OyqoP33M6U=
Date: Tue, 13 Jan 2026 10:34:08 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
To: Michal Hocko <mhocko@suse.com>
Cc: hannes@cmpxchg.org, hughd@google.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <aWUDXtsdnk0gFueK@tiehlicka>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aWUDXtsdnk0gFueK@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Michal,

On 1/12/26 10:21 PM, Michal Hocko wrote:
> I can see that Johannes, Shakeel and others have done a review and also
> suggested some minor improvements/modifications. Are you planning to

Yes. I'm working on them (mainly non-hierarchical stats issue reported
by Yosry Ahmed).

> consolidate those and repost anytime soon?

I'm testing it locally and will try to release v3 this week.

Thanks,
Qi

> 
> Thanks


