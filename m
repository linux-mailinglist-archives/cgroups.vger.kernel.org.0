Return-Path: <cgroups+bounces-9631-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FADB40D4C
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 20:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEBC48852F
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340B5270EC3;
	Tue,  2 Sep 2025 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4gVUdoY"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583EA214210
	for <cgroups@vger.kernel.org>; Tue,  2 Sep 2025 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838834; cv=none; b=BMqDrgX3Nm86FGbBXcxXBw2Tch2VeSq2BuiCbk1SenQR3Tq0Z+pkkDzMB+ithcp9p1PuKClqY9pwo36cUllzw263dsuYODYk87NBCni9/snnAGdJs5OYp9KfuyAlseeJymLzwZEaDZ55yKhcmvYDMQ6iM1cdpqLayzp9M4OvQuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838834; c=relaxed/simple;
	bh=niHNVvGTbLrHGUofLzXOJQKNA7lJyWtdS3IisPCmbPE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YvAp7n74qG54PEd2ykiFzAiVEVAyv+RFmRAhUhMe0B+Y8iVhXqJCcsPFi7bVSCsoNbgTQzvsW98bS3HIolBTeRPqpTamIrbowuNaVXPZs/ZFqwHFVnf+Q8s6kLNjr405EoijZ0AzCapCRHzxmIx7TOXRdwRUrHmBRcBnpNIPB9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4gVUdoY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756838831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mL5Iuf1X4+usrTx5fIL5N9qPxoTLIij37cao5pmfb98=;
	b=N4gVUdoYiRD16YVfuMkgKE/3oALpGe1gSR4dnGJHQtUa4CEJgi4DLC4cQQaGCM+SFF4dlg
	NjqPSrI9XVK5CGyOVS1z8tb5ROpwjWTVTLWQUvEGsmgM3oyOSAOS98JBOg07dPyhBP8WnH
	jQp2SKC58zF3wBbvoljwBI6dZD7USPU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-i4gPaWR8OgypJOi0AFchTg-1; Tue, 02 Sep 2025 14:47:10 -0400
X-MC-Unique: i4gPaWR8OgypJOi0AFchTg-1
X-Mimecast-MFC-AGG-ID: i4gPaWR8OgypJOi0AFchTg_1756838829
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70dfcc58976so88493776d6.2
        for <cgroups@vger.kernel.org>; Tue, 02 Sep 2025 11:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756838829; x=1757443629;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mL5Iuf1X4+usrTx5fIL5N9qPxoTLIij37cao5pmfb98=;
        b=rVPfVMsggTAniiekIpjdA9uR37bTw+dGRIYvOpsqxvQjm+zPIiWqESASpC++xXLICL
         E/9nQZO/oHxkcrbuLZR2l27Ph87qiTiaaWfpvq8vy0On5/g2I8KBQd7kerSgwEfZXLh2
         6tcIxImXa0i+wsoRoOnekMOU/awlTgkWUFXQiy19N6iZ+kz4OTG357X921k9TLUfuw8A
         N2jNAgRZ/sIdAeGIfPOk6+ljmgQouvNouUcF0hHmnp2PWiNEMsOqCTePxJr3pskIXzGI
         5DubCN2smLp59QaMnJDVBhsCXx1C2GBKFGZ1hDqzs3WUhDTLSdZm9EUEO23s3aryWHpV
         EbTQ==
X-Gm-Message-State: AOJu0YzDHpM03XA6N8i2+PRVM5IMe6Q7yBmgXbdxvdo50CPdTMRxkBMr
	e5bshWsJegz9pXLs0enmE1BxEcZsCbUWQcNbIXxkrHszOw9BdvUUYuVnu/IhZzCYb1mDvmis0rl
	5kb6mGNwSqUHjAysYuuziZ0/coBcBozvjrIYvvSyv8IAARa/o0NdgylvK5uw=
X-Gm-Gg: ASbGnctW/oKXp2KXuyJrEmlWt5HN3ZvuchQ78FB6iGxBNUllPjVRInmrBNTRlx1r8x8
	+VhJ3mXq24iwkRceKseEsfHJgpPkWsrr9ezuUy/8Xqhimmg22UV13haT5OxOMA26cKhvNqF8Kwq
	9tXwwfoShQpIWAb9uo/Ee5i/Sa2SlRAl+stYtWeqFCufuVm4MllrFUIYHFsmyXYTgfK8Yfq86E0
	obFhWshvd30nmcLjMsGemzuP5F7bWxHNzkGfiJ1VQ/CHK1HXlH08Mma8N1hMmtx3/H/ednBFMEZ
	SoaAw7RWdJNRsyPSh76y4Rf32GdqCSJozxZHQIsfubUd6j2Mfh5CLaf0QLYmKMRCnuAIc456hfY
	PbDiHOTmt9Q==
X-Received: by 2002:a05:6214:21cb:b0:70f:a719:5666 with SMTP id 6a1803df08f44-70fac92194bmr129841836d6.61.1756838829451;
        Tue, 02 Sep 2025 11:47:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsXDCqrxLSsW18GhRFLcFTT86tc4vo6hE4zeQhE6MFMmYRH8/ZI2p1iYn7Y10qN43gJ30zqg==
X-Received: by 2002:a05:6214:21cb:b0:70f:a719:5666 with SMTP id 6a1803df08f44-70fac92194bmr129841426d6.61.1756838828872;
        Tue, 02 Sep 2025 11:47:08 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720add668bdsm15895626d6.33.2025.09.02.11.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 11:47:08 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <530b6d8f-8987-4fd7-9add-eed0a823b411@redhat.com>
Date: Tue, 2 Sep 2025 14:47:07 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250805: ampere: WARNING: kernel/cgroup/cpuset.c:1352 at
 remote_partition_disable
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Cgroups <cgroups@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 kamalesh.babulal@oracle.com
References: <CA+G9fYtktEOzRWohqWpsGegS2PAcYh7qrzAr=jWCxfUMEvVKfQ@mail.gmail.com>
 <hyqcffknmjwjuogoe4ynubs3adk47t2iw4urnpjscdgjjivqz7@b5ue6csrs2qt>
 <CA+G9fYvA=945et87Q=_c6b-TWjSBxy4H-X9iNsb1_Pj9GCXUaw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+G9fYvA=945et87Q=_c6b-TWjSBxy4H-X9iNsb1_Pj9GCXUaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/2/25 6:58 AM, Naresh Kamboju wrote:
> On Tue, 26 Aug 2025 at 19:56, Michal Koutný <mkoutny@suse.com> wrote:
>> Hi.
>>
>> On Thu, Aug 07, 2025 at 01:57:34PM +0530, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>> Regressions noticed intermittently on AmpereOne while running selftest
>>> cgroup testing
>>> with Linux next-20250805 and earlier seen on next-20250722 tag also.
>>>
>>> Regression Analysis:
>>> - New regression? Yes
>>> - Reproducibility? Intermittent
>>>
>>> First seen on the next-20250722 and after next-20250805.
>> Naresh, can you determine also the last good revision? That would be
>> ideal to have some endpoints for bisection. (To look for any interacting
>> changes that Waiman was getting at.)
> Michal,
> Since this was an intermittent issue, I do not have a good end point
> of the bisection.
>
> As I repeat,
> First seen on the next-20250722 and after next-20250805
> and not seen after this.

If this problem hasn't been seen again after next-20250805, it is 
probably caused by a bug in one of the new commits that has since been 
fixed. We are not going to look further into this until it is reproduced 
again.

Cheers,
Longman


