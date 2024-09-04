Return-Path: <cgroups+bounces-4684-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7E096AE92
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 04:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC734B23F04
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 02:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2434B3F9D5;
	Wed,  4 Sep 2024 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sz6yBN84"
X-Original-To: cgroups@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF91443D;
	Wed,  4 Sep 2024 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725416932; cv=none; b=pwYUzrvF9/+1Xis+xsTbXI+Oh7qkse4tmYJ2QB3escDRh6Suxw5/lhGZ9f4BWeSbE1pn4+pxVyTxdvEBKpFfhVaOhtsNVzo09kaRMbBGLkvbT4IMJarHDy+PeNtJ2W1CzrNhBT08Ng+DfmkDpUUcQE2eWopnP04VuxA26lMXUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725416932; c=relaxed/simple;
	bh=qdT2t2Fh9wwW5di1GdgWy0N/m4zZU4E2brtOKXqJf0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZxAe9QJ+HwFKYkWrdIKLUgvy7cm63DuzrFzOMtqfBGps5k3nc5TOFMv2iW0x2KOuwFUIk6wlvM8obBjXWoiZL/v28VmazLJRTsZ0rkIWWs6qptzHlJ+2+JILAvdJmAM0B8dS+bjf7Uvelk6YU6WbFGKNZH6d/qt3iLvlv0CIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sz6yBN84; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Wz5yp3k5KzlgTWR;
	Wed,  4 Sep 2024 02:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725416927; x=1728008928; bh=qdT2t2Fh9wwW5di1GdgWy0N/
	m4zZU4E2brtOKXqJf0I=; b=sz6yBN84vV6Wz6VnnnubSfMr9ZvarqGglN/3TPVo
	qiju0AftR9KK2cHdwSmlZaITxKawLBPGBUb4x9q3yv5mbEs02smqB26co2MsOKR5
	droWAATfmhP6RthQwe365eL8FBB9vk51Cjae5Z/Z1o0yUDJISRoqqQU0axgV3pzL
	IoecpCIDKsvQNWFcWIN7jJMLuoi+/KJDWt7eSuLIpkxqkg/racA5X+NO+0ae47V2
	GUbj4GAkd6a8HvGp9omwRM0k7OQzt4AaI+UbEL4GlyymHouXYNAYyG1h84ue9IZ3
	d7yU9L54DSMoQU5/YrODMN2ZTXmmkgWt7yBsn6jCV/5RPg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ps6vhR84Oy8n; Wed,  4 Sep 2024 02:28:47 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Wz5yh58hLzlgTWP;
	Wed,  4 Sep 2024 02:28:44 +0000 (UTC)
Message-ID: <b5b0e655-fb17-4967-9104-4386710ee8db@acm.org>
Date: Tue, 3 Sep 2024 19:28:42 -0700
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c2a6d239-aa96-f767-9767-9e9ea929b014@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 6:32 PM, Yu Kuai wrote:
> We do have customers are using bfq in downstream kernels, and we are
> still running lots of test for bfq.

It may take less time to add any missing functionality to another I/O
scheduler rather than to keep maintaining BFQ.

If Android device vendors would stop using BFQ, my job would become
easier.

Thanks,

Bart.

