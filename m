Return-Path: <cgroups+bounces-4698-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF7196C51B
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 19:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283E21F2879F
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 17:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9DA1E133D;
	Wed,  4 Sep 2024 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Otv2TYlt"
X-Original-To: cgroups@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59E5EE8D;
	Wed,  4 Sep 2024 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470244; cv=none; b=nADQnODREbexdtZY4xJChyan3M65lxTJwY5L2jE/uAh6dPin+/J4hEpnsX05PGtUItDemphIaGwY1pWwBRauAe1cb6KZfhOTLa7fE7+QKPixrQrsNbKDYnudMbOTfEilyDfistCbwpPDoyIiIXq/EgHilYL/ehAxaCmhOUhuuVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470244; c=relaxed/simple;
	bh=LRXV9Q0dFTBf2mdXNPCxnch8TO71ErFZVKpeSFu/W8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOju7PpuZO5yzdq0GPAoYA/xpoxaJrZfNupVZknocjeDFTnMTjcYh5L1+B/tGN72KyQQTCpM1fHzCEJyi/bZ7hHYni7Cpzg8oV9avci4u2jTly8MWKz19ckhKfKOMpn6iZhbsClzPi5qPjZ/FJ10swq8tyzsPGhJ2a/2Be6UQMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Otv2TYlt; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WzTh24Qq1z6ClY8n;
	Wed,  4 Sep 2024 17:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725470237; x=1728062238; bh=LRXV9Q0dFTBf2mdXNPCxnch8
	TO71ErFZVKpeSFu/W8I=; b=Otv2TYltZtmCvIltxmhaan4a2MKRFpvHBoG/3BJc
	xcjmyBfDUb9+RaVft5CkyZ/HUVtpTHbUZYaMjbaykJCkOp67XSh4lzl31ENHf/0e
	I7m9ajBIUDUFsrbyExUMivRLXmeucohh/NJUIgxsK4ukuHai2NjpkOMnvUZPwlL/
	wYzwj3qeMOJBH8CCY4eUofU6y9gxATARcjNXcR9FhgdncHnPGkyiSOBazcp+/BUj
	Tt3owaaJ8Oze1BtVWjzacMbRQMEqX7X3ukmQ2Vv1Y4+1LcVCh0kAiwipLVgCjWG/
	2ZK4tCmhPrADRg+t+TnkFzfPB5Xn1mp/O6g8ZvyyMTE/Mw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NOWhUI4Vb90D; Wed,  4 Sep 2024 17:17:17 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WzTgs5MbBz6ClbJB;
	Wed,  4 Sep 2024 17:17:13 +0000 (UTC)
Message-ID: <db586849-a7d6-44b2-96d0-113629f8d8f9@acm.org>
Date: Wed, 4 Sep 2024 10:17:11 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.12 0/4] block, bfq: fix corner cases related to bfqq
 merging
To: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
 jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, paolo.valente@unimore.it,
 mauro.andreolini@unimore.it, avanzini.arianna@gmail.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
 <2ee05037-fb4f-4697-958b-46f0ae7d9cdd@kernel.dk>
 <c2a6d239-aa96-f767-9767-9e9ea929b014@huaweicloud.com>
 <b5b0e655-fb17-4967-9104-4386710ee8db@acm.org>
 <80732d0d-e1a6-8b5e-791d-7c8a8091159a@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <80732d0d-e1a6-8b5e-791d-7c8a8091159a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 9/3/24 7:45 PM, Yu Kuai wrote:
> =E5=9C=A8 2024/09/04 10:28, Bart Van Assche =E5=86=99=E9=81=93:
>> On 9/3/24 6:32 PM, Yu Kuai wrote:
>>> We do have customers are using bfq in downstream kernels, and we are
>>> still running lots of test for bfq.
>>
>> It may take less time to add any missing functionality to another I/O
>> scheduler rather than to keep maintaining BFQ.
>>
>> If Android device vendors would stop using BFQ, my job would become
>> easier.
>=20
> I'm confused now, I think keep maintaining BFQ won't stop you from
> adding new functionality to another scheduler, right? Is this something
> that all scheduler have to support?

As long as the BFQ I/O scheduler does not get deprecated, there will be
Android device vendors that select it for their devices. BFQ bug reports
are either sent to one of my colleagues or to myself.

For Android devices that use UFS storage, we noticed that the
mq-deadline scheduler is good enough. The device boot time is shorter
and I'm not aware of any significant differences in application startup
time.

Thanks,

Bart.


