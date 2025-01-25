Return-Path: <cgroups+bounces-6316-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8D0A1C04F
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 02:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B6A166F40
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 01:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109041EF099;
	Sat, 25 Jan 2025 01:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MGywh6KE"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192EA1F0E50
	for <cgroups@vger.kernel.org>; Sat, 25 Jan 2025 01:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768897; cv=none; b=h5FjG3FvLg/9it4NlOamAINQ8EA6duZZbiT9IkxzE+eTEHDkmRVm6VcDedcDORxfH+o7z2UrBWnCZtpdspbByBpw6+zGN1cC6F9Mg4gl1ewj2SN2TdC9OO+Hp9Mlp01G+83i+WV//a6yG4A+CXbrftV6144yZDio+l1p7LJvci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768897; c=relaxed/simple;
	bh=XAQDRqXh0D6Nvcwhqo+s/BNVkskS/f0J0PS5FcBxnOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4ww64ASnOSxXp7GSl1UWMi7Zrqgjmg+kJy23V6S7/ppVuvr9ijTBgF4bYojTG1z8xANp0z7dXKwXo02X/PStG5/dnZBi7+HyErAhc9T+Wu53XTKz86l75IKQlO6KpxXv3ReBle5LhjjQTHfhduHSh/2KAWAw86gE4SZiCfSszU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MGywh6KE; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 25 Jan 2025 01:34:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737768894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tP0/o2PO7Vlf1ziXPu1JIk4Vi0ELHenKxZqooG+MQKc=;
	b=MGywh6KEB/cvFLSpSvInQFwTVWPF+jnJvJVLpBXoKbePVMksitrAppoZFl/xuSQyw6Ee2Q
	ZlcUFkBVzug4O9Cg3RL0dHtDxwUdm5FK/jnYr5IOr+mmjF5NByE/oTfhtju5aDkA0Z8XVv
	RXwFX6rQNYpka+6OlwGzZ5qpxeaTYXY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
	yosryahmed@google.com, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH -v4 next 2/4] memcg: call the free function when
 allocation of pn fails
Message-ID: <Z5Q_teZnwEjx_knF@google.com>
References: <20250124073514.2375622-1-chenridong@huaweicloud.com>
 <20250124073514.2375622-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250124073514.2375622-3-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 24, 2025 at 07:35:12AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The 'free_mem_cgroup_per_node_info' function is used to free
> the 'mem_cgroup_per_node' struct. Using 'pn' as the input for the
> free_mem_cgroup_per_node_info function will be much clearer.
> Call 'free_mem_cgroup_per_node_info' when 'alloc_mem_cgroup_per_node_info'
> fails, to free 'pn' as a whole, which makes the code more cohesive.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

