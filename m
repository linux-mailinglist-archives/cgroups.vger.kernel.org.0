Return-Path: <cgroups+bounces-6443-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15287A29F65
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2025 04:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C9F1887A1B
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2025 03:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C702382D98;
	Thu,  6 Feb 2025 03:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXpXFF+7"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED98346BF
	for <cgroups@vger.kernel.org>; Thu,  6 Feb 2025 03:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738812852; cv=none; b=j6WyngRoznlUR5iLrrarKy5OyxhO2zE1JxI398RQwofdzPo+27G6zTMReqODrNspye/ep3lHe1OrU1KWV0252E4eMulhZ3R6As1XfWLNNLTUP96yNCPWH4OyjC+C4hWPuppYeTLng4mOqgs950iyw+71LXuiLGvxoJoQ+icKqR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738812852; c=relaxed/simple;
	bh=0nkvwMag2wJlVpE7+t0H3S/cgoMv4VnZVdqj5ePnD4I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UjxuC0UNDOl92D6+Tm5go/dCQF7rtQIJZ8OVdU1uvmXAFK5CR71KhliNMOrHwYnPf9lqx04IOaU+uC0cW1U7Ry5wTyHkAYIXGUbX0oUr5Aji0fjXmHHU17lqN7bQSp06wAxI7hKtIb/BzmgDyyNdpb50zB6daUUMz7P/Gu+Li5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXpXFF+7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738812849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgnCO7mXfPIiEEPBciloYom0SGtjBExbfCvcW+zqXLg=;
	b=HXpXFF+7d8tfFG+blJQWxcoca/BtPcxyEFeixLyp6MCdPsGw1xml9mOzMifse2mxYXnMxk
	QqRmqIgoUIfSTMsaR05e9LgZ68aYOfCOjEO5nPv7ehmP+HE7qUc0tkugFSCWpqrkfUW6b/
	ErH83kLgPNfILeJ1faZ8/7qWR72sSrs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-cAgDKGXxNnuFRozgeQxvHg-1; Wed, 05 Feb 2025 22:34:08 -0500
X-MC-Unique: cAgDKGXxNnuFRozgeQxvHg-1
X-Mimecast-MFC-AGG-ID: cAgDKGXxNnuFRozgeQxvHg
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6e1c50ef1so61323785a.2
        for <cgroups@vger.kernel.org>; Wed, 05 Feb 2025 19:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738812848; x=1739417648;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgnCO7mXfPIiEEPBciloYom0SGtjBExbfCvcW+zqXLg=;
        b=attguDZYSnOTRUabTgrxEu9cv0vlhbpLeVphin/dEx+iLx2XcFdyB1yMavP9at/OSL
         LyyzIEkymE8RWAtxykvaCJfkppyd6EpwFlN1ZlhoykphZwoOrxe2V6R6nfIyklKMi99/
         glZMaEQ509kdE38EwjBcVaiJTdoVdZ1UnoO3RRZqRK/4C+M9vUkwgSb3+laX5iAqwbBv
         gAwRODRy0nukNzYSjGC1LJ6RubdcgXB3okq2fGJ9ZJNsFvenk78lRTnCtlNPOZkGTgnG
         uJwXfJQ8RGxqugCwfoGqFvsaeQV88iOWqG2+8JO0E/kv/VpHmfhNAxTdcthMiaR63suL
         bv3w==
X-Forwarded-Encrypted: i=1; AJvYcCUhUX9l6UHe1x36mhg0B8I5tojDqy0jBiEzSYm4IanIGBGGfJ+B6HCe/szBbfKh4jK3LixATSIh@vger.kernel.org
X-Gm-Message-State: AOJu0YxqXdE0aTyQ54iyen+XThxYDYlapAgzB4PaUCOV6xBwhC5lwcxv
	hiSmvCJjAiJoS38v0Gm8tI1T5S5U5x5oJtmW3Q0Se3SOb6PsvhzPc3DBirNtA4cvfJ11d5GVlZe
	GreC6p9jIkJkQhcFE6ywPOQd9EXQbgu+Sbf1Myv2kKtLAAsZ/3DBT08Q=
X-Gm-Gg: ASbGncvBuzqyRV5pubFNOTB9rDPQYHJdVJ4QRLlSvinfH77LeeZoJNYBhAYGBRPc7Ml
	27mqGDUzUyltdBk/9D30upQ3Ec7fXvMY4RRypUnM7thMjdywZ1Dn4J22nu36lVDSfjo7CoFJ7bH
	ewxPg8ZiH8Al+cu2e8Tl0njv15AvZYCs/68aTj3TMD9ZX9xleKisN6T7ULbnDfk3ArlQAhOCke7
	4hw83JGGmHQD9KVF3t5Xs8pCer/CR/EG0yJy5uoJUA7+iyDMJ/lm3Jguzgl0iXPIkutO2UH9iA5
	TwynyaIZNih6rxR8FF1V7azsGHdwW2bd3K7jOY+iQCBKOEks
X-Received: by 2002:a05:620a:2901:b0:7b7:106a:1991 with SMTP id af79cd13be357-7c039f9810fmr663010485a.16.1738812848122;
        Wed, 05 Feb 2025 19:34:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6QZNT6c0eAJL+wJ+ah9660s9AYmQDkqqf8C6WgMi7hth+4A8aDxk2c+b1xsvcyPFePmHuEA==
X-Received: by 2002:a05:620a:2901:b0:7b7:106a:1991 with SMTP id af79cd13be357-7c039f9810fmr663007885a.16.1738812847841;
        Wed, 05 Feb 2025 19:34:07 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041dfb128sm20577385a.30.2025.02.05.19.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 19:34:07 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <be330e50-83c1-4128-8dae-b0caeea85453@redhat.com>
Date: Wed, 5 Feb 2025 22:34:04 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: A path forward to cleaning up dying cgroups?
To: Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, linux-mm@kvack.org,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Michal Hocko <mhocko@kernel.org>, Allen Pais <apais@linux.microsoft.com>,
 Yosry Ahmed <yosryahmed@google.com>
References: <Z6OkXXYDorPrBvEQ@hm-sls2>
 <ccd67fd2-268a-4e83-9491-e401fa57229c@linux.microsoft.com>
 <20250205180842.GC1183495@cmpxchg.org>
 <7nqk5crpp7wi65745uiqgpvlomy3cyg3oaimaoz4fg2h4mf7jp@zclymjsovknp>
 <91D2E468-B89A-4DD7-B1B0-B892FA4482E3@linux.dev>
Content-Language: en-US
In-Reply-To: <91D2E468-B89A-4DD7-B1B0-B892FA4482E3@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/25 10:30 PM, Muchun Song wrote:
>
>> On Feb 6, 2025, at 02:46, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>> On Wed, Feb 05, 2025 at 01:08:42PM -0500, Johannes Weiner wrote:
>>> On Wed, Feb 05, 2025 at 12:50:19PM -0500, Hamza Mahfooz wrote:
>>>> Cc: Shakeel Butt <shakeel.butt@linux.dev>
>>>>
>>>> On 2/5/25 12:48, Hamza Mahfooz wrote:
>>>>> I was just curious as to what the status of the issue described in [1]
>>>>> is. It appears that the last time someone took a stab at it was in [2].
>>> If memory serves, the sticking point was whether pages should indeed
>>> be reparented on cgroup death, or whether they could be moved
>>> arbitrarily to other cgroups that are still using them.
>>>
>>> It's a bit unfortunate, because the reparenting patches were tested
>>> and reviewed, and the arbitrary recharging was just an idea that
>>> ttbomk nobody seriously followed up on afterwards.
>>>
>>> We also recently removed the charge moving code from cgroup1, along
>>> with the subtle page access/locking/accounting rules it imposed on the
>>> rest of the MM. I'm doubtful there is much appetite in either camp for
>>> bringing this back.
>>>
>>> So I would still love to see Muchun's patches merged. They fix a
>>> seemingly universally experienced operational issue in memcg, and we
>>> shouldn't hold it up unless somebody actually posts alternative code.
>>>
>>> Thoughts?
>> I think the recharging (or whatever the alternative) can be a followup
>> to this. I agree this is a good change.
> I agree with you. We've been encountering dying memory issues for years
> on our servers. As Roman said, I need to refresh my patches. So I need
> some time for refreshing.

Glad to hear that. I have been waiting for a resolution of the dying 
memory cgroup problems for years :-)

Cheers,
Longman


