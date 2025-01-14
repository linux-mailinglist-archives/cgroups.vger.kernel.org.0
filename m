Return-Path: <cgroups+bounces-6149-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BD7A11048
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 19:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D8C3A7CEB
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA46C1D54E2;
	Tue, 14 Jan 2025 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XvPwGzWr"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95271D5145
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879814; cv=none; b=B/71x5ZvOAp8RyCtXyQaSpYPA9Tb9StOKViJWXlAHzgf0gyXBUG5h60faEMW9iiQacLqaLaV9UiH7FMTTCuYuUnSrm/2We0X2+Jxj4GPlrf5Xe7dv7JBxRfsNVRt/fPFEuI/NEYAA/rDpSZFVuUT/k2ZIkuZkDRExlZuEyCgYRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879814; c=relaxed/simple;
	bh=wPHRZaduRVqwWv4nVVwBLgTRIqkz159S1ZWE88XAsQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwSqw7BFaw8/K/oHx0YgODAwxmjurv9TA818gZYy/+S1PXiQOqaoyM3RkJSn4pNLGWqYQqbk7gj2J6WmWCZDRg2ksDJThD2k+uCnO64PY0C2JMvAhc2dmxzOhZMMvVgIqDX9AV46nObS0Ink9TPBIO/NeEFxc2Si9UmW87eFhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XvPwGzWr; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 Jan 2025 18:36:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736879801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNc6ZJbNvBmR24gaQ6bLlskI7Y73QqE//LKMVd8ndpc=;
	b=XvPwGzWrPQLcHR6Q0Dp0enNPAQaLMYV9PLf7z17Zg2dNTmlV7zHbQJvOuy/1T8rpBikd21
	SoXxILQoTck6+z5W2vpOf01xJRRUqhNOKLzRl6/359hpwsWMrwY6ndvlV3K/s2qljRGTP2
	Yh0t1qsrFj24scdpS9yn6RjP1BVBooY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
	yosryahmed@google.com, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH -v2 next 1/4] memcg: use OFP_PEAK_UNSET instead of -1
Message-ID: <Z4ausluonm369vEx@google.com>
References: <20250114122519.1404275-1-chenridong@huaweicloud.com>
 <20250114122519.1404275-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114122519.1404275-2-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 14, 2025 at 12:25:16PM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The 'OFP_PEAK_UNSET' has been defined, use it instead of '-1'.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> Acked-by: David Finkel <davidf@vimeo.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

