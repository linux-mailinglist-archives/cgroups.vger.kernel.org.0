Return-Path: <cgroups+bounces-9572-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E707B3E6B7
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 16:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D693E1724C4
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A934F340D88;
	Mon,  1 Sep 2025 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Dcza+BEj"
X-Original-To: cgroups@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46722566DD;
	Mon,  1 Sep 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735828; cv=none; b=oC041ExlFyBLY5wTq7Ii9M6Ixa74z54gvixAnOtx4kTgpqjkP2Nr5IqQ8uVGmoPvI5BefCWLOrE8b9SeXjifXLntKMM898QIjwE9oykhdo2J9b6YUMnEJlWKLELSDEMeykN+O6sX8eaY2uthtSrWOzzMVHH/FwVQzh7BIJpwHeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735828; c=relaxed/simple;
	bh=ukmJhcp35iYjnuU4kZ8d63qh1MDKc2DFJ9CwL8UCjhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paByNYNcHN7EV5uZOxG2pOpbOUBF6pIDsOfXN6Pzu7p7Ib23U4ZzTrTGcwh+aCRa9wr4/IPtXpC8ZKixEVFLFIMgNwshlnmni/Lvfc4P342XWm4hiVw2TBMbccn695CaTTVeYAm8GPYb31B8/gizKyQwkVXswNQ1x5gw0E8V/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Dcza+BEj; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cFrPF54wNzm0yQ1;
	Mon,  1 Sep 2025 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1756735815; x=1759327816; bh=ukmJhcp35iYjnuU4kZ8d63qh
	1MDKc2DFJ9CwL8UCjhU=; b=Dcza+BEjnfTsBp0x0rCZIXnyJ9Qpw6lxNkPGmQWg
	C+oGMmS4YpkI8aHXFzU4aBV+8Gx81ktCpkmPi7bOsLlvI3uQPfhmEclEH58adCEC
	AW/lQS4yTHldmZfyaGIiaA0BASjHn0kkmzTEdqkYqgGIWxiHMuQ39ZGvYyt1Amoh
	K72gR1OdQW5IhMTbIfz22c7yvav5QSn6fF0OwkmC+Yfkaib0Wbo8wXnMpjapziMn
	wtCcXm12ukCUCAgIz28GLHxCNwQbFPmtop1bcsFbkV1TTFKbFAAtDdOdtwiD190L
	tj7AVJG03fV5bWqqPsW3QuARxtsBawv4rpBesquIXUumsA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cnSL9S05D3Az; Mon,  1 Sep 2025 14:10:15 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cFrNW30zbzm0ytb;
	Mon,  1 Sep 2025 14:09:46 +0000 (UTC)
Message-ID: <5b3a5bed-939f-4402-aafd-f7381cd46975@acm.org>
Date: Mon, 1 Sep 2025 07:09:43 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 00/15] block: fix disordered IO in the case
 recursive split
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org, kmo@daterainc.com,
 satyat@google.com, ebiggers@google.com, neil@brown.name,
 akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250901033220.42982-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/25 8:32 PM, Yu Kuai wrote:
> This set is just test for raid5 for now, see details in patch 9;

Does this mean that this patch series doesn't fix reordering caused by
recursive splitting for zoned block devices? A test case that triggers
an I/O error is available here:
https://lore.kernel.org/linux-block/a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org/

I have not yet had the time to review this patch series but plan to take
a look soon.

Thanks,

Bart.

