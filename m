Return-Path: <cgroups+bounces-4774-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E62D97212A
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 19:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB0C0B23E43
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 17:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ABF189BA6;
	Mon,  9 Sep 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fEvNWv72"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9A17A924
	for <cgroups@vger.kernel.org>; Mon,  9 Sep 2024 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903359; cv=none; b=DmvVjegLLw9SUnwrVZ660tKqZXQQs6DmQJebBKag5CK18zIb5C/PgoLf4kBUJru4zaj6JpxzfN3S92aMU7PprpYHVSgEwa5eEgc+sz1Ja8e3b8PnAAJkBPJYCGnKviolpH4Ldy9VFFmpBNMkcMM8YQWBZ4EYRkPifp8rIcFb3ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903359; c=relaxed/simple;
	bh=9aw8PX64D6pSR+Ia9H9ANt7478SV+HKrI2YmwF/5mhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPVML4xRjZvjB+d4LvVkBeQxePCZxh75C5gYOkQitZ+rRHdjlB+OoEf9jls7dAlvLU3Rv5FHz3ijyFi/CPwO/rPtQLq2YkSfzV/RN3AXjDy1Gx2xkXT7WPMokP58tORng0lBX6Atw4R5lzpy9ChDH1qH1EqOU2eEbQyVkGKLUdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fEvNWv72; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 9 Sep 2024 10:35:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725903353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmKGYO/dpVEt+1a6FmkaafuRmzIOS9aVPE12GwYuRE4=;
	b=fEvNWv72S5tUhzNe5wF1JK4/WPod8FcE1f8TVrEx0SOovu43xmmBOPRZ3zfUmhcqm5a1Yl
	8tpbYrLKAvarjZPqv6f5fbSbduXmlhZg6ZQSHHMM2iuJimAItIXQHPT4EzmJfzaCsWRi88
	9FpH3+8srxHeTsH2u/fSM6UbbNoW6jE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH 1/4] memcg: Cleanup with !CONFIG_MEMCG_V1
Message-ID: <qbx65gqigbmohnrmrdi2bx3mfl7posce4salvuoaqsm2y4kyz6@lb62sbxapqqp>
References: <20240909163223.3693529-1-mkoutny@suse.com>
 <20240909163223.3693529-2-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240909163223.3693529-2-mkoutny@suse.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 09, 2024 at 06:32:20PM GMT, Michal Koutný wrote:
> Extern declarations have no definitions with !CONFIG_MEMCG_V1 and no
> users, drop them altogether.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


