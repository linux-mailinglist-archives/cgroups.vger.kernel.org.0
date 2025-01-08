Return-Path: <cgroups+bounces-6075-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7E4A065BB
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 21:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BED11889F7B
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 20:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5C71FF7B5;
	Wed,  8 Jan 2025 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFrWACCV"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735FF200B8B
	for <cgroups@vger.kernel.org>; Wed,  8 Jan 2025 20:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736366687; cv=none; b=aaa+C+qVhUUIo3rFlmDLjaUZ8/YJpNzd6WT2bNOi/CU/1MdkVsrYEzlMUEdzBE0aizi3sSAnVwlTVR+aPqpi43iEBSouv/8qs3vCaSzr62Bbnx2cceB9W3pQFjIPBy0fsthDu29Pa/df7PYsqwWCvQxyniRsAY/qlqtcdumA3dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736366687; c=relaxed/simple;
	bh=uioaBABlI1Y3YsPccxMx5GXCh0jYBczL+G6Ua36VJXE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XKRSJfWuF0X3wQjgTU9q0IZY6IzCUAEcFFfqzg4AV7gUkpcKOgTkMt5EiNVQ9eYW000fnk1DbtobNd3DmsooLlj6wiO54UF2z7W86JvBXpqIHas9xYojnjFvfCmFOyc77fCw4UaBrXhDmCtqNll4l+VCGv55I8vGMVnlSU+2SS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFrWACCV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736366684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uioaBABlI1Y3YsPccxMx5GXCh0jYBczL+G6Ua36VJXE=;
	b=HFrWACCVjKDJtI1kGOOsD33rDGqHs0LeiuSQt1E8kYkbWdOim8fh0Gjsl8goDAZMnlSYh4
	usLi9/wgbmJ/MfOasVZFhUIhyi2UdfU/ubX6BK+TV//IfBtcKdz2clN2xV4hXGPICJFEBf
	kR9ssY/jci4dth4G8s06yMousGrS2IY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Lc-skWcdM0KqSwzg9nyo7A-1; Wed, 08 Jan 2025 15:04:43 -0500
X-MC-Unique: Lc-skWcdM0KqSwzg9nyo7A-1
X-Mimecast-MFC-AGG-ID: Lc-skWcdM0KqSwzg9nyo7A
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-467b0b0aed4so2429291cf.2
        for <cgroups@vger.kernel.org>; Wed, 08 Jan 2025 12:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736366682; x=1736971482;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uioaBABlI1Y3YsPccxMx5GXCh0jYBczL+G6Ua36VJXE=;
        b=FIkIOtCXeMtE93Cb6HVAedQQKUMUc56zGFrT8l5GBpLXb/gon5AqugYdzgkkBCGmZL
         D2/D5Vr8ai2J8y4qATU1QhBYKMZbW7sAJWnIPQsryvFI4ewksmlFrrr0Ivz6dDHueTfO
         d/wVbOg23gIQ60miF/jebagt2u6jKQlQVmOv4eyEY/syYKqmU4rtU4tBA6MCBmeIQcgD
         qHNqdWFpDqXISaIRUHk0bsfwDmlFHmz0ERMIR4W4cxgRsKeHEqJIa4HftCI3hqBqgBxb
         0YZfap8qqzdttbR7OGSXwgwxcNeDcvxc7oKWMbHfLXOuY+8g1BLM0j1QFBO1rfbYDGZ7
         PQ9g==
X-Forwarded-Encrypted: i=1; AJvYcCVClu2DqQ8BFtO9K019qAJxScRq0Q+4IC9rSnXYsejjUFfDbkasRnQx+O8M3q+N/wfDxIaqs3WC@vger.kernel.org
X-Gm-Message-State: AOJu0Yze7RgXGmOqqr5RUW60L1HMAI3g/X1XoyqEmUmw3urH+r8tfVIO
	BS1IpOrC4n7WP5m9aGKZOZ3Wr9480uvWRta2pHRfmVG61zHTTZA1l+pnl8NdcBLEL23/mgRuzlH
	u7cy1sheZDtbRmuQN8vZOCzv5dE8HCi+UoVuHyt0DpQRhaVicPq7N0cs=
X-Gm-Gg: ASbGncv8VjLmSv8X2lNducAFy2wAqNGoY5EHvCrF8QQeEQCBFiSOugwQhDyupr+gKq7
	y4ivuDduvQIk3LsHJVv3PEKmZXZyhheQuhvDa2UbKezpykRXddoeQYlPiVAyxhA2GZUnQTRWq96
	mGOOPr7xdafibJ1MV2nXRVl9V6FESgEXwViVT1GQ+uFDxyad9FiFUK2FvFBpZpS4vQTdVJgMCQr
	LlOJvBqaqUfJcx5m3EG9Eh1VSrSVzBGmET91BREmyOSDYSprhe7m/BcCNujQaAOIBjLG2YKzPZ6
	10N9gsdPwzwJ7UdkmWx2ecEE
X-Received: by 2002:a05:622a:52:b0:467:56a2:b05c with SMTP id d75a77b69052e-46c70fc798cmr64190691cf.10.1736366682528;
        Wed, 08 Jan 2025 12:04:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhlyrEM4ncsrau4Yz19SHcTCzLoUSujwsFhKWauBAdtNIRN8zUG2FBdu/AitlwrituaO7w4Q==
X-Received: by 2002:a05:622a:52:b0:467:56a2:b05c with SMTP id d75a77b69052e-46c70fc798cmr64190221cf.10.1736366682109;
        Wed, 08 Jan 2025 12:04:42 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e653f52sm199069491cf.16.2025.01.08.12.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 12:04:41 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6fb6d82f-a321-4b29-9fd6-60f7a8758233@redhat.com>
Date: Wed, 8 Jan 2025 15:04:39 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: remove kernfs active break
To: Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org,
 mkoutny@suse.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250106081904.721655-1-chenridong@huaweicloud.com>
 <Z36th2ni0q32gsUE@slm.duckdns.org>
 <c40d5b49-1955-42ee-b95c-37ed580e9933@redhat.com>
 <Z37TiId4rFkwc0Mc@slm.duckdns.org>
 <625d03cd-302f-41b1-9502-dfd25eb677e1@redhat.com>
 <Z37ZVyx_PI6cHwZ7@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <Z37ZVyx_PI6cHwZ7@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/8/25 3:00 PM, Tejun Heo wrote:
> Hello,
>
> On Wed, Jan 08, 2025 at 02:50:19PM -0500, Waiman Long wrote:
> ...
>> It is not the strict ordering that I am worrying about. It is all about the
>> possibility of hitting some race conditions.
>>
>> I am thinking of a scenario where a cpuset loses all its CPUs in hotunplug
>> and then restored by adding other CPUs. There is chance that the css will be
>> operated on concurrently by the auto-transfer task and another task moving
>> new task to the css. I am not sure if that will be a problem or not. Anyway,
>> it is very rare that we will be in such a situation.
> Hmm... I might be missing something but cgroup_transfer_tasks() is fully
> synchronized against migrations. I don't see anything dangerous there.
>
> Thanks.

I probably misread some of the code. Then it is not an issue anymore.

Thanks,
Longman


