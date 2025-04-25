Return-Path: <cgroups+bounces-7836-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A579A9CCC4
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 17:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3807166EA5
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 15:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16F727FD79;
	Fri, 25 Apr 2025 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+5OHTsY"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3843279785
	for <cgroups@vger.kernel.org>; Fri, 25 Apr 2025 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594578; cv=none; b=iHFF9fyr6HddatGaDmmWiQhsEPXej64vFBLSt3H4VndViNUgQR80Ol0jZoHqTlb4HYR+hHO1qyx7dB2Ilyhbw/aM9uVrsLsO70B292rInabxwfrE6VjluFN44MWqbY1LP5UDeZw5Q+plXr1qB5GfyoPQG6/apFQm5/VOOeqNDzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594578; c=relaxed/simple;
	bh=pProaOAcY22PUYh6aXXhX0tcj+PiRJFj37d/6nPGIUY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Jb8EL6svyjsVDRJbwqCHoLhpfY8+oR7qTH/kwoIPIHeFIHWlY07ja02e3hA9BzEjNvN14TELf+mYbS1dB8vo7tRpIOWnx9S17d1YstdPxCGyoUKUDOz1kQddNpB5sJaneYgpRweYEd1OQs1h4MYjd0MqTdFoU9cqjFeN8NzNJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+5OHTsY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745594574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pProaOAcY22PUYh6aXXhX0tcj+PiRJFj37d/6nPGIUY=;
	b=L+5OHTsYhzxJQI9Jph7t+sSLvwmKy+JmepnpNVRGyY5PiFmfETIt4jA9RJnEZvPoZF6Dmf
	dukktU5uoFOQb2XK5FFH2u69GrLQR+Rq/MmLuhhDVNe0zinoSSIMiaZ4WKMQYFB+NRuZi6
	V66yn510lZug2b5hbH96p/fN/FqMnIY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-JuXFLLbmN0-uOXrU897IfQ-1; Fri, 25 Apr 2025 11:22:53 -0400
X-MC-Unique: JuXFLLbmN0-uOXrU897IfQ-1
X-Mimecast-MFC-AGG-ID: JuXFLLbmN0-uOXrU897IfQ_1745594573
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5cd0f8961so480710385a.1
        for <cgroups@vger.kernel.org>; Fri, 25 Apr 2025 08:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745594573; x=1746199373;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pProaOAcY22PUYh6aXXhX0tcj+PiRJFj37d/6nPGIUY=;
        b=iutTdDNiUJE60I6wvZer9UliBJbG7/7L83untM4ZAzhHeFcciakU/5NiEY/M9e3k3t
         +zmtVBOcP4rJBR0bZncF8X4UbsKFCezjIb2DsncePo1ccQLD/i7Mt5BEdyMik9PtuaW0
         eslCBN+VhT3ylAel6WDfptJhsMxECVZvStatR/9mWZqpZeMUK/LVmzTsr3zfnsqJBe74
         ld+iz/ISwGSUW4K/7mlGAEo7szfwb8l62jNjaGABqYlVIV33CtqrShSlMXIcMtt4QbUd
         KYcubCaJQFIWOhlFkVhY+A27g2OaHcI1ya0OQ9sqAD92IuYR3ymsNMD/1EDGlmbFX7Bw
         SMmg==
X-Forwarded-Encrypted: i=1; AJvYcCU8fdlHdxXb5w6OtQxDeypNG5NtRjdvfklrpBycxYiiD4COJXDZc8QniSmxS6y4dO8z22S2GS+I@vger.kernel.org
X-Gm-Message-State: AOJu0YzysfjJKPNaLbX7DG/nSm5phI0UU5K5Bq/Crk9g7ZBUkfcV3gzx
	bl/sXCawJry6lsCBZ0kTPvyQklkh9ruwZUp+RPSnN7Vw9wRgVY1/g2DLhqgTLg2iZJ7LnpPRv1z
	HuqCVLwGNEPz4LaHySiVxr2Zay83Jw+DeP3d0Bqaqdn2w/jg5baQdzgE=
X-Gm-Gg: ASbGncuZK6yX+eQFeAvJf8Uc9WQDda6ZyVX0DYd/U7tLrgjfpfPk5K9pm2uUsoILEOA
	TLXc2NTo+VAXnlZi8YdZ3vI09L3JQHqCbbctGeHmmZWpGyKHLXSzgCfeNdDIl4QrKnaU9F34NWN
	BH8wC0ZDoOkiZn2+KXAjX+TSg9mmfwTb2HyXjhnNEaRNRFjz++N0npnkmmQUcwWb6Pgulobey6z
	MVzfu8v/MxaLz4ucLOxuky+NFDIkv4mbZR7EPb7PJglRSo/xerZ3Y2fNaelMHWk1DAcRp2UiuTL
	XEBvOS3K2xot0ZJUN3unOw5MrSM8QicsVT3OsiiJuc2XL0WjK+AqAIPRnw==
X-Received: by 2002:a05:620a:319a:b0:7c7:a63c:319a with SMTP id af79cd13be357-7c9606b05a4mr434229585a.9.1745594572983;
        Fri, 25 Apr 2025 08:22:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6em+X09lALI/H5J1BXx46XSb5pfUcEyWkE5OIrodgaIGgquVEvwQi2aqd6SqAbIBWR3hbaA==
X-Received: by 2002:a05:620a:319a:b0:7c7:a63c:319a with SMTP id af79cd13be357-7c9606b05a4mr434224385a.9.1745594572413;
        Fri, 25 Apr 2025 08:22:52 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cbca1fsm228970585a.36.2025.04.25.08.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 08:22:51 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8a85a074-d4fe-404e-9438-131963a51051@redhat.com>
Date: Fri, 25 Apr 2025 11:22:50 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup null pointer dereference
To: hch <hch@lst.de>, Waiman Long <llong@redhat.com>
Cc: Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com>
 <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com>
 <642a7d6f-9d8b-4204-bc81-4d8e0179715d@redhat.com>
 <BY5PR04MB68493FB61BF28B5268815381BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <20250425145450.GA12664@lst.de>
 <3fef1073-3a7e-45ab-8448-a144d5fb6a73@redhat.com>
 <20250425151140.GA14859@lst.de>
Content-Language: en-US
In-Reply-To: <20250425151140.GA14859@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/25/25 11:11 AM, hch wrote:
> On Fri, Apr 25, 2025 at 11:04:58AM -0400, Waiman Long wrote:
>> On 4/25/25 10:54 AM, hch wrote:
>>> On Fri, Apr 25, 2025 at 02:22:31AM +0000, Kamaljit Singh wrote:
>>>>> It should also be in v6.15-rc1 branch but is missing in the nvme branch
>>>>> that you are using. So you need to use a more updated nvme, when
>>>>> available, to avoid this problem.
>>>>>
>>>> Thank you for finding that commit. I'll look for it.
>>>>
>>>> Christoph, Sagi, Keith, Others,
>>>> Can this commit be merged into the nvme-6.15 branch please?
>>> What commit?
>>>
>> commit 7d6c63c31914 ("cgroup: rstat: call cgroup_rstat_updated_list with
>> cgroup_rstat_lock")
> I don't see how that is relevant for the nvme tree?
>
The nvme-6.15-2025-04-10 branch used by Kmaljit includes some v6.15
commits like the cgroup commit 093c8812de2d3 ("cgroup: rstat:
Cleanup flushing functions and locking") but not its fix commit
7d6c63c31914 ("cgroup: rstat: call cgroup_rstat_updated_list with
cgroup_rstat_lock"). That can cause system crash in some cases. That
problem will be resolved if nvme is rebased on top of v6.15-rc1 or
later as the fix commit will be included.

Cheers,
Longman


