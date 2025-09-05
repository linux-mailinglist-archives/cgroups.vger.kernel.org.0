Return-Path: <cgroups+bounces-9754-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6ADB464FE
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 22:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D841CC053F
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 20:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D682E03EE;
	Fri,  5 Sep 2025 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xqGhZ52O"
X-Original-To: cgroups@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1712701B1;
	Fri,  5 Sep 2025 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105531; cv=none; b=d/ehArb5UbVjIuOErjEJ7gNbRg8Rg+r0y001T7ub/AzM8qdNEkwiORzvdl3ptR2jBQJysCogJmDN1wNHQvsZe37x+odbhgg8kCDv/7NtUb9+4EZizKux1pTJuWlzl/FJlrYG3PT0JInJBgl+sjFIY3fpUht9EiDS8E+NlWB1DE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105531; c=relaxed/simple;
	bh=MH1dvyQhbZ2LyJE/U6It+nD9aHTBaDz3j2nrAemnVVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3EofPR663cSJB14WXNAfRlj1eW8YaeMaj5CTOBN0WeW7L9ZFB4hmGC4YCNexnTooxJOKh9aU3LgcE7Rc8OQ4XkfLKoKOX0ILtB0raVYFZ/+lrz/GPkx77kNncfNdokRlvq1einQazUzh20x8WqzlLehb/zDj7EPrgfCXsubnQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xqGhZ52O; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cJT6w6wP3zlgqVX;
	Fri,  5 Sep 2025 20:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1757105518; x=1759697519; bh=MH1dvyQhbZ2LyJE/U6It+nD9
	aHTBaDz3j2nrAemnVVQ=; b=xqGhZ52Oxws0e5yTr9AwYeFfTbfAr6OXhksk7Ch4
	98kZbzstJbkX4Wijp8d8hUi4T3hGCjO0AGrDMwU+vYJb2RqySBb46ayVh0nd6UnM
	z/kX3VYi7994z2GEFhgBeSmttJjf9iNkl3eygaQ5tI2nx2Uym7XH3EjYeLkYLnpu
	RhRLqUKLMcPC+JPj30z+5O/ZAoNBzhRWM7H+WYQZHaeZfhO1LzE7z6miJ9+l9wJF
	22ZPGF0CmdsM3Jiu3b4sXpr105JEM1U8zrMTQAWZIJd2fvbQqlnYi+t4oGNUFODk
	lQfILXKcnJYmjS4B81np9Npz8ru4toSr2MB7+XcOD5xVaQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GMK5kSaFDd5J; Fri,  5 Sep 2025 20:51:58 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cJT6P3DbwzlgqVS;
	Fri,  5 Sep 2025 20:51:39 +0000 (UTC)
Message-ID: <a7ad5eb2-d64c-4d45-817a-f590100ab970@acm.org>
Date: Fri, 5 Sep 2025 13:51:38 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 15/16] block: fix reordered IO in the case
 recursive split
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org, yukuai3@huawei.com,
 satyat@google.com, ebiggers@google.com, kmo@daterainc.com,
 akpm@linux-foundation.org, neil@brown.name
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-16-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250905070643.2533483-16-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/25 12:06 AM, Yu Kuai wrote:
> Currently, split bio will be chained to original bio, and original bio
> will be resubmitted to the tail of current->bio_list, waiting for
> split bio to be issued. However, if split bio get split again, the IO
> order will be messed up. This problem, on the one hand, will cause
> performance degradation, especially for mdraid will large IO size; on
> the other hand, will cause write errors for zoned block devices[1].

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


