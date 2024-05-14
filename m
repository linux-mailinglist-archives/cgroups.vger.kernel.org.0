Return-Path: <cgroups+bounces-2882-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E368C589C
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 17:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3391C21AB9
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 15:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A188417F37A;
	Tue, 14 May 2024 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K0X5DxtQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1701417EB8A
	for <cgroups@vger.kernel.org>; Tue, 14 May 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700082; cv=none; b=p9wjdF1XCHrXEI84fE0CxfDf5SjcBRtaA6Yn/E0MBQdibW4R6j+mZv9OY1SVsjvIIRQCBcYjqbsT1Q/lek7VuQOEiayM6T2KyIIpjCRBstKmOzlxMnrjnRnawlVOJdUDqbT9IrkfAQ8zzayLO8ljzzXY/4o6P6PfR47Sprc6F6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700082; c=relaxed/simple;
	bh=QvFgEf6xCAOsIIFnMgua9Q/0LKwMRZ/d2SkAe4fO65c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfrZucLgR8mq4W+YAL2ID9BTyYbpZZl667jLl89OzHGIOIApSLqYeuNuKN0VR+XkB2MzOFO5LjxEK2uaKsRXlPO673J/H7wt6s4bPmjt8ES03HZGKzIUjHiibwqkaSnsg2XbgXHRZHZm4Gpdn5J0ubcMVpLrfBSZ4CdE2UcUop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K0X5DxtQ; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 May 2024 08:21:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715700078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zp/ZA/wPWSCpzR8DINVVcEwRJoZy8bTPv9U2MBOhkyM=;
	b=K0X5DxtQL08E3oWIAIjNc7psXoKc+nD1muSUTmbD3yU+iapQASGca7tK62/pJP0vxHnc3j
	LkzuW8GdiYHx6wnaWlp2rcVRQUWBqMaa3u6Pa/o032bgDTD4FGzqZfUFQgW3Qq53VXO8v4
	Yp5K7cKvGuKlIniFkjWCvWLSPbJeSIc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, hannes@cmpxchg.org,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] memcg: don't handle event_list for v2 when
 offlining
Message-ID: <ZkOBaNffNi4rmR8h@P9FQF9L96D>
References: <20240514131106.1326323-1-xiujianfeng@huawei.com>
 <ZkNwthw5vJrnQSLL@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkNwthw5vJrnQSLL@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Tue, May 14, 2024 at 04:09:58PM +0200, Michal Hocko wrote:
> On Tue 14-05-24 13:11:06, Xiu Jianfeng wrote:
> > The event_list for memcg is only valid for v1 and not used for v2,
> > so it's unnessesary to handle event_list for v2.
> 
> You are right but the code as is works just fine. The list will be
> empty. It is true that we do not need to take event_list_lock lock but
> nobody should be using this lock anyway. Also the offline callback is
> not particularly hot path. So why do we want to change the code?

+1 to that.

Plus this code will be moved to a separate function in mm/memcontrol-v1.c
and luckily can be compiled out entirely for users who don't need the
cgroup v1 support.

Thanks!

