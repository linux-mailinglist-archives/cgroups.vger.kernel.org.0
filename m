Return-Path: <cgroups+bounces-9750-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F733B464EA
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 22:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFBB3AA3E6
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 20:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF782D7DDB;
	Fri,  5 Sep 2025 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AOi2WPPz"
X-Original-To: cgroups@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEB619343B;
	Fri,  5 Sep 2025 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105307; cv=none; b=b6GLc+r+UKX4yDP2XvhX2uX5BuOZarnVoBreY36KLkc/fUYIzneISHi6NHU7V3zRQ01IO5ZvhQfHHchr64DRDfjhrQnvGY11pY0ojHYJ4huLldbNcTa5esZIY3JL6U/rd5KIj2cYcVFYr8TyIhNV70s9FgngxLQ8n3QbbgwgGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105307; c=relaxed/simple;
	bh=44uvmig9ym8iOHN535kYgAyKCMaS/oh+VxAcE/r/Vv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZeF1br6lII0SaQz1YwhajFazHMqRssXp1pxx6dB9IIJMD4zWZq+/dp/2vdnEP4x0YyTsquG1a7FYRlUAH0yHZVE0/9ZDRazw0dotI1iNkaE52ghFXjwplckEGZMFd8NxZq2OtElEPQeNPodB/1yhrg6Za3TbtfZdOu8BVNChsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AOi2WPPz; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cJT2d3XlYzlvWhB;
	Fri,  5 Sep 2025 20:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1757105294; x=1759697295; bh=44uvmig9ym8iOHN535kYgAyK
	CMaS/oh+VxAcE/r/Vv0=; b=AOi2WPPzVXV53iQostNFX+iGOmvm8O96IglmO2oO
	GBS7VDqikhXKDd/dLct93XP+ogDTAOPFUBqhzOaiWxvXjKqwdhWgdJQZYroCRH94
	YiDPa/qoaYHvKGhmsC9xvy2tJob2qJW4fPurjWNToSE8ccLfPqUtgFsgB+i8Sdqf
	6MFrzR6ls2Y5kXnN9nrtiyWQ/NNdFg846rxQasxNWte2E4NA+zCEtw8Ld8rZ1nrG
	DPbhW25JqlXWR80zXv5kPokf8TihWcrv/dS39urq5NEc2tkK0RowTZ04K6jubjns
	C/zcYVQrqQRns7zJOdDIuQEwn988vNIgXw8MRUbp1terZQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QBygoKKez0P2; Fri,  5 Sep 2025 20:48:14 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cJT253rHtzlgqV6;
	Fri,  5 Sep 2025 20:47:56 +0000 (UTC)
Message-ID: <b1776167-e8fc-43c4-aefc-bd9c5940477d@acm.org>
Date: Fri, 5 Sep 2025 13:47:55 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 06/16] block: factor out a helper
 bio_submit_split_bioset()
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org, yukuai3@huawei.com,
 satyat@google.com, ebiggers@google.com, kmo@daterainc.com,
 akpm@linux-foundation.org, neil@brown.name
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-7-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250905070643.2533483-7-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/25 12:06 AM, Yu Kuai wrote:
> No functional changes are intended, some drivers like mdraid will split
> bio by internal processing, prepare to unify bio split codes.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


