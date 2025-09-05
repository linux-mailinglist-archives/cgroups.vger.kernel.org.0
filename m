Return-Path: <cgroups+bounces-9752-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5697B464F3
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 22:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695BA3AEF40
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 20:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CD82DAFBB;
	Fri,  5 Sep 2025 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="z6H3E/I/"
X-Original-To: cgroups@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275A19343B;
	Fri,  5 Sep 2025 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105382; cv=none; b=XkqR6X36asLRCBV9ZFhBs1GwSniHazxgdJ71zMQZhbKyvSMnYH6r24yDvBvA7nlx4I+yB0GU25otQU85TxaetZlF0LXtA1EP0WA1CJBXamAIgr1Id5qF2K/yS/unfqq2Azgxouc33IKTY1gVkXaOQQSJZ5sgxJSbA/sDegGAGz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105382; c=relaxed/simple;
	bh=MePEapUuYxcddgHNIeSyE+IBcezpQwz6cFFLJ8PxzEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyJ6YZ5OELmuwxE6GcspYwfjjfWEQAXGMHCQ/7uyk2/0iU+N6erSzIVUT2AFiPgdXCYcp/aS308PYN7HqbdD537XYgce3RuUondLRbHdlXm+WIxTz7ZOiJW9c1ERV8I3D13pf2Sjkszvn9DqRfEKEBXyyZSjfITx6F67ad1nkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=z6H3E/I/; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cJT434xF9zm0yV9;
	Fri,  5 Sep 2025 20:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1757105368; x=1759697369; bh=MePEapUuYxcddgHNIeSyE+IB
	cezpQwz6cFFLJ8PxzEI=; b=z6H3E/I/shpdpH75wdYzvFjMCz5LOj/bv61HfciY
	5cWsX4DXF/XKN+Y+ktpL1Ok0v8aCidm0R/tsjl15OfD13ujJTb2VfQrrJZ7kx5X2
	OxNyWIkIuLeuIhqer2W/p8XPNuyRP0N7gkEZGoDtYofvU5zFMAQsiBDy8KRyEHH3
	MST3ys55O/ccVPi1hqQNKZUYhd8p4qx0zaNYxN/pip20NsP2V30X5pzFlsRHxpHA
	AtOdOS6Mqff/WAZfKM0gUl5uS5I0hX7xZIzeCZ/2si1P2rFKovZOJVw3CdTk1wlk
	sd7cUn0lQz644lCgacRijmgkULQHvFAChzN2uq+SUNQYGA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id etR1yIYbfEql; Fri,  5 Sep 2025 20:49:28 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cJT3T57xmzm0yV5;
	Fri,  5 Sep 2025 20:49:08 +0000 (UTC)
Message-ID: <e4f749f6-3d89-4342-b896-8f32a55907ec@acm.org>
Date: Fri, 5 Sep 2025 13:49:08 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 07/16] md/raid0: convert
 raid0_handle_discard() to use bio_submit_split_bioset()
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org, yukuai3@huawei.com,
 satyat@google.com, ebiggers@google.com, kmo@daterainc.com,
 akpm@linux-foundation.org, neil@brown.name
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-8-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250905070643.2533483-8-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/25 12:06 AM, Yu Kuai wrote:
> Unify bio split code, and prepare to fix disordered split IO

fix disordered split IO -> fix reordering of split IO



