Return-Path: <cgroups+bounces-9748-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4413BB464DE
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 22:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3441C84BDF
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 20:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F782E8893;
	Fri,  5 Sep 2025 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RyUxivph"
X-Original-To: cgroups@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80A2E1755;
	Fri,  5 Sep 2025 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105118; cv=none; b=bDGi+w38JHxO0BSvSZbjis4TJ79fPQtIuyf/bUojbNw1UlkDrx+TfEv8JG4kBcSppakd+OBy+QGEyo+eiT+ZmhTZ57wMGeco5VEFXqYa7zMzdJTZ6RpRmEykIchGjIJ6YmzSkMx+n8gJtRLlOv8Sjmc3iNEc/QWu+Ce1gB53K0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105118; c=relaxed/simple;
	bh=yGqSDSETg0D9smLQAvT9y8KGHzU9JxSmB0xeu3ZXYvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGvD3w+ZJatBeCb1V3HRrg1dXVdhFgPv+22w+oZ4OJkb9B3LA4+RGqB0WNORXhC1nCPpG52xwXEvuWaATMEngvmIBg4qiQeGE8ko025oFzyJp67S03KRhn3qqF2DdO4i8a3XLgt3X1i8fZPN0DDJPo2tZbdE2yEVK9fkFycYAj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RyUxivph; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cJSyt4TgBzm0jvQ;
	Fri,  5 Sep 2025 20:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1757105100; x=1759697101; bh=6C+msqSYnF4/0BdNNlLbNvrG
	xVbkMF9a9jeXiu/yWY0=; b=RyUxivph3oqydNPn4qCChxMtfmVnkfl8E4Jc+XY9
	L4K4puS8kc48cAu3t4ByZUlP+LyRO6adRPDRI0Az9G637v3evCSTwd6/xOKIXq0Q
	uE6NJoX405VfS9EOzvdE5y91ipNgmr2DGIG1X+LQuufKIdd9BIAMDNK9fw+dXbnu
	m/oOn1nX2UmX/M8DhGP8KH8dNZ8XY0ZNCdhbBIQXOLMEZpKxSj/0SZkSzmvLbo22
	SsiJVhMMqpi3jW2RViZTJ1v9gQGtW3SRmADNXHPMY4m5voondgxQ1UxZSVoz51Q6
	UabUlPYuBRSrX78mYoVRv+xhvxgVR6bOlRS8ocVFz1bAAw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pOaAMcCzSUux; Fri,  5 Sep 2025 20:45:00 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cJSyM60zszm0yNS;
	Fri,  5 Sep 2025 20:44:42 +0000 (UTC)
Message-ID: <143ea81e-60bf-4bbe-bbe2-579545d84f65@acm.org>
Date: Fri, 5 Sep 2025 13:44:41 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 04/16] md: fix mssing blktrace bio split
 events
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org, yukuai3@huawei.com,
 satyat@google.com, ebiggers@google.com, kmo@daterainc.com,
 akpm@linux-foundation.org, neil@brown.name
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-5-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250905070643.2533483-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/5/25 12:06 AM, Yu Kuai wrote:
> If bio is split by internal handling like chunksize or badblocks, the
> corresponding trace_block_split() is missing, resulting in blktrace
> inability to catch BIO split events and making it harder to analyze the
> BIO sequence.

The bio splitting code in block/blk-crypto-fallback.c doesn't call
trace_block_split() either but maybe that code falls outside the scope 
of this patch?

Thanks,

Bart.

