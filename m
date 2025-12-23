Return-Path: <cgroups+bounces-12601-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E91FCD83BB
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 07:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90365300CD90
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 06:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AC817A303;
	Tue, 23 Dec 2025 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1Qc8C7Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tsd/VeyI"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDB52882A7
	for <cgroups@vger.kernel.org>; Tue, 23 Dec 2025 06:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766469993; cv=none; b=KdQnZROxigC14q59w6yONGHiT/sae9zmcOVTNK0TJ3QADp16PMXeonDtTOMIG8ao3W5uHwPtpWk4zq47PLKT+d9ETz/S54CHFlRZtksl8Dc4qdHtlgixdmmlY9QWl0N9oSID6Me6mnm1Nlo9jwU431vo8CC9d5IUckJmW5Vbp/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766469993; c=relaxed/simple;
	bh=sl4V/2oRNdodTxAs9PY8rQJ9ubzl71UrJgKTFRdnGMA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nz8RLeYh9FbOKcUCo0j7wNAtQUO4CTDDBaxXjYI3AYmNP1hWgZdA65L0q9tBXmJLq1yVaU74iWkN2fd+uKvU6jOqFoDubNzoDGBzX3OqQCXKdobqNbu2ng0DbkWiWtPLOKwTSF2hdguxQp53ipWKJdcZxxPeV2ql5wY1cCutn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U1Qc8C7Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tsd/VeyI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766469990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVGvbZ5j1OxNqws5ggwS2VhooZHiFDZC9rqYB5ZeCxw=;
	b=U1Qc8C7QtDbr7l33/0WY/Wenoke850eiHLaLO8QXyPx0LP8+KuWY1qF9jLRg+lYlrGn8r6
	QUAmeyDZkRaqHJ4Iq/01AXnTRz2s/ytWtTbOsh96G+EeqXEPrpuKpT919p1ll7dZTuy8iz
	i+yz31lCLzf1Ja9PkYBwcrz8hdBxeog=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-v-zuFy1eObuDBBqBdSEqmw-1; Tue, 23 Dec 2025 01:06:27 -0500
X-MC-Unique: v-zuFy1eObuDBBqBdSEqmw-1
X-Mimecast-MFC-AGG-ID: v-zuFy1eObuDBBqBdSEqmw_1766469987
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed7591799eso114612201cf.0
        for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 22:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766469987; x=1767074787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NVGvbZ5j1OxNqws5ggwS2VhooZHiFDZC9rqYB5ZeCxw=;
        b=Tsd/VeyIs1J1Z9SK1xppPeJ0+1LQ6LehqUtMOsyUrZ21gK1jxeGAxmKjDbO8e2tI09
         j3v4XPNFrWD347vLrHR3EEXpaj8vP/p4xuEb3TVz7nLpk75AU8v1aEcAK0aO11FjyGhk
         B/SpSD2XJ72L3RNW4sL7eug4SBcfEsHfSFCB6IlAI04JeCOnfeLK20ecHqKTgkyyrl5Q
         XWt5YQOmxVF/2YS5aSNjxFv90b+M+r08+1f4tPvEx5jL46837p3q2SKg/Rzv1+jP3Y0R
         NwzWxrSBgbBQwc4/ncH4WcY3SBWo7xzITpjsu6qI57y99JLQPm777yncYdbmvWKXIVr4
         NIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766469987; x=1767074787;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVGvbZ5j1OxNqws5ggwS2VhooZHiFDZC9rqYB5ZeCxw=;
        b=PnVx91HGPxlAgtwBcQ+SeWf/FhyFTccBZJJYYVOQt/da8i19WcXmvc9Gfjp/+V/5a4
         agmFNZ4tigcpWOOUOzcAPZ3tk6wygonRIZOUL2aEj2GR++2MzLF4Ud19PdhXY51SNDc7
         eDtOQqF0/KiZpXnm6VNIy/EDwSAk0B4xhB183edRrawaWLVqBYNzdaL7EWphafjzwgiY
         KX/iuoD0OqPw5OItsSRSVA8rS/bRYt/2x35GjUjs5xIf6tpO/X/tiutOqsF8uQ92/oWx
         9/cgMimg3M19NHgHkXl/74OHskN1H8aQCbB3dM4pLx70LLF2/P9XurMPQDqr47F201ZB
         mmgA==
X-Gm-Message-State: AOJu0Yw4kv7gp12X0efkBdAojpgyLW+dcdH5KwUQxMQ3XjtzL5yhTiEn
	16fTDRXiDGy9m3ubKAdb28keo+3BUB9E29K7if4h3Im6Ab/sZVMFXZnFFAbjZekZpjk1T0pywh8
	VrqPtz5vM4GoeZBX5U4y6avv5NI3G/Gz0LWxR/5+0ifEi0Y2IUfiJgGo/yvE=
X-Gm-Gg: AY/fxX7abCtS7sPJLRE9Wv7OqSNiArGtd8x3lX+u9bHULq9Hoix9gM1xPc4b2x5/b+E
	XfBFaBnb+LjDavJpXYuA1BtYS2mE2pOOmMO20PplTCvgZbnYchqFYkdODHnMPLPy0918MG2Hbuv
	9KQooT79xuif5WkgxRw1brbfvtvLDoNo2kuETt5NR7XNmQ5h+irwuGW1B7mquraxcWjkMeTaeOe
	9DhhblhYvmaGj53L34ktY9ij5VDBqb5kxohzUi1ewiImHUGdy4A04Kzb9W8GNzxDcJvqFYNLIEv
	1G4uruAejWBQVnzYCt1jrcKgm4tVdwj6GGr94rcqy/pPX35jqpG91JvsG45OHHb6gHEfheRKczK
	opCct9hGMHhShEv5NgoPzFXZt+VQmIWPZZF4DtXm/tFolN3A1J6XfyuKa
X-Received: by 2002:a05:622a:a0f:b0:4ed:df82:ca30 with SMTP id d75a77b69052e-4f4abcf745fmr198847651cf.13.1766469987023;
        Mon, 22 Dec 2025 22:06:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCMfOsKUa5N018MI5LZZx8dMOGlI0cQB0E2XsbXSJT4z6FAwrnsjhkILQxH+78hEJJC6ntow==
X-Received: by 2002:a05:622a:a0f:b0:4ed:df82:ca30 with SMTP id d75a77b69052e-4f4abcf745fmr198847521cf.13.1766469986697;
        Mon, 22 Dec 2025 22:06:26 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997ae49esm104579866d6.28.2025.12.22.22.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 22:06:26 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <52b109f4-18b1-48ae-97ff-795328bfa5a0@redhat.com>
Date: Tue, 23 Dec 2025 01:06:24 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PING][PATCH v6] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict
To: Sun Shaojie <sunshaojie@kylinos.cn>, llong@redhat.com
Cc: cgroups@vger.kernel.org, chenridong@huaweicloud.com, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mkoutny@suse.com, shuah@kernel.org, tj@kernel.org
References: <20251201093806.107157-1-sunshaojie@kylinos.cn>
 <20251217094530.1448665-1-sunshaojie@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20251217094530.1448665-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 4:45 AM, Sun Shaojie wrote:
> Hi, Longman,
>   
> Just a friendly ping regarding the patch "[PATCH v6] cpuset: Avoid
> invalidating sibling partitions on cpuset.cpus conflict" sent on
> [Mon,  1 Dec 2025 17:38:06 +0800].
> Link: https://lore.kernel.org/cgroups/20251201093806.107157-1-sunshaojie@kylinos.cn/
>
> Could you please take a look when you have a moment? We'd appreciate any
> initial feedback or suggestions you might have.
>
> Thank you again for your time and consideration.

I am sorry that I am late in reviewing your patch. I was busy in the 
last few weeks. Now I will try to review your patch later this week.

Cheers,
Longman


