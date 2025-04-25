Return-Path: <cgroups+bounces-7834-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D815AA9CC5A
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 17:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4FD67BC2B0
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EFF25D211;
	Fri, 25 Apr 2025 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwPmLbTX"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96AC25C6FB
	for <cgroups@vger.kernel.org>; Fri, 25 Apr 2025 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593505; cv=none; b=TgWx6KmUODJU4oTpTsDjaKwFZ21odEAzj2sMkEGYN/OKY8tH6o0vP8AZKkIuu6gQAuHcvWzoLFye8Z+TuYRE46KQJO93IMxBwivEl8rxR6TZVLVP+AHW2V7GgZF1y1OHkwF5OsAra1UJOapYsyUNPVIjaY/YMmhSksGqNnOz4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593505; c=relaxed/simple;
	bh=Tm5q5MYJruhkNGjbbrmAT7rJ+JNee1e1hq6INizAKwI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jyNhR/EgFqLDOa5mrzEbnylWZxFbBxmNJzSyYe+tInFu1ZJFyBTmkklQ+UtY6AUdB+XtROjGTBxvcgP6f0oTsA7i6aqX3MYyMN4mw2PPQdJU2k+1emDBpbFMvKjJILpMZU1X5BpLdVSTh86RX5ihYga1CRfym2ninZPGIFZhw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwPmLbTX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745593502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOF7MEdJZfeltW9hyPd1aEthrbud5eZtYdTNBpurl7U=;
	b=ZwPmLbTXJhw8I9aHb43VT8EBxcA8rUe/iVHl1shZL31kuvKHjFPjVRYuhGN5VtdVNwyYfe
	kgnnRsV8thTBbQQCBV40hZmyM4UiityVlT2aJQ/k06wkUjzoJW1FLM40YR8bY5gy6046yO
	giNYGYH6aUm4+uUH4ZRi5N1sgBWxPmk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-5acgWw0VOEezbtQt8E9Sig-1; Fri, 25 Apr 2025 11:05:01 -0400
X-MC-Unique: 5acgWw0VOEezbtQt8E9Sig-1
X-Mimecast-MFC-AGG-ID: 5acgWw0VOEezbtQt8E9Sig_1745593501
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0b0cf53f3so349573585a.2
        for <cgroups@vger.kernel.org>; Fri, 25 Apr 2025 08:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745593501; x=1746198301;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOF7MEdJZfeltW9hyPd1aEthrbud5eZtYdTNBpurl7U=;
        b=IG0h15mxdLGzrXX+0p2TkeipZZ5GT9VNUtyXrRY/atQ76oT0ElL/djOYsYRYVKUfy6
         MhGYlZEl6C1iOEY5qrFkfaJEMGQj/GcjohmTOJMw2Bx3KBEcYIn/rlBWP1i+9Xx+Jyfk
         rbypU95ISSbJvXg9evqlB9BBmxdsrnnxmbgxjBK5jfzXG2NcyhumXEDYRUrC6iaicCI0
         Itmr7OGdcUuGjvwqhpGFBDl4AYjAN4aFAWLyaXPzkcFjLEGy255C8molZCYgq7pPKV6o
         itKmMXKHa5G45wrw44pP+ZPyOxFNUHfNLDY6BjtvutwXPrj3xkuc3bHi0eUzX6aAmbiH
         HrsA==
X-Forwarded-Encrypted: i=1; AJvYcCUBnkEXVy0Gjgsb3M1GtFujL8yjXBLF0LWoPe+e0xmktddC9lQsDuVzr7GKRX/lMMCk7XTwpT2z@vger.kernel.org
X-Gm-Message-State: AOJu0YxDe2LzghsFlG+/K40i3IGmbte5NfWWxsajktqcimbOw1lf1tZL
	M4oslrMxNdvIMYuIZI+kkm7KU6zoSRkUc3bscKuhfKYiYc9GkRUs6kK2lMIaOJLv/JuY9kd8Pkf
	DidT4wWVR5z3NTfXZtahh8TtVZA+wxpYFik+/Fw7/pLqbkZC7QIiFMakJXmcji4E=
X-Gm-Gg: ASbGnctfzmrs9F4mWEH+6y0ayeITlQB2qdb1bo1EWv/dBbGiJvGdEEf7Qs307izE71V
	r5xZZ3mwuWbCGa3aHPI8yEVYfRwZluO5lIHgB2tZR0On2wVafVET6krys/j6FoS281B/HZ64aHr
	WuQuHTjUV+24V+6e98YVhN3sKICGUHPuPVNGzKSi2lc4OPr4xEBVVXCU4jJl3yNwvSXvJ1PB8/I
	o3zEbJJ1I6+524WMnEwe7xUmTl2IOLx+nm7X05qwiMaiy2wOd0URBI3Xin3Bea1SdAhFuZI8ICg
	9fxH+8DDE6DErkkhQtF7codIRkuVozriVBI4n5DEKYM+2Sd1V08OyQiX7w==
X-Received: by 2002:a05:620a:45a7:b0:7c9:2787:7a75 with SMTP id af79cd13be357-7c96071a2a9mr416811985a.30.1745593500702;
        Fri, 25 Apr 2025 08:05:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoVO/RlBmRwhTSBxGq+umqayLGF87nDdoCgXkyU71i0ZoeZaGSM6HAOq8f+P1CncBaPECQ9w==
X-Received: by 2002:a05:620a:45a7:b0:7c9:2787:7a75 with SMTP id af79cd13be357-7c96071a2a9mr416806685a.30.1745593500279;
        Fri, 25 Apr 2025 08:05:00 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d86c6dsm227016985a.71.2025.04.25.08.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 08:04:59 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3fef1073-3a7e-45ab-8448-a144d5fb6a73@redhat.com>
Date: Fri, 25 Apr 2025 11:04:58 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup null pointer dereference
To: hch <hch@lst.de>, Kamaljit Singh <Kamaljit.Singh1@wdc.com>
Cc: Waiman Long <llong@redhat.com>,
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
Content-Language: en-US
In-Reply-To: <20250425145450.GA12664@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/25/25 10:54 AM, hch wrote:
> On Fri, Apr 25, 2025 at 02:22:31AM +0000, Kamaljit Singh wrote:
>>> It should also be in v6.15-rc1 branch but is missing in the nvme branch
>>> that you are using. So you need to use a more updated nvme, when
>>> available, to avoid this problem.
>>>
>> Thank you for finding that commit. I'll look for it.
>>
>> Christoph, Sagi, Keith, Others,
>> Can this commit be merged into the nvme-6.15 branch please?
> What commit?
>
commit 7d6c63c31914 ("cgroup: rstat: call cgroup_rstat_updated_list with 
cgroup_rstat_lock")

Cheers,
Longman


