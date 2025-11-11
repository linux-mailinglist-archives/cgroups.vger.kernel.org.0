Return-Path: <cgroups+bounces-11835-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73BBC4FBC1
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 21:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33863B323B
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 20:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4C3329E7E;
	Tue, 11 Nov 2025 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBufCgjA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIxybuA3"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE4133D6CB
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762893854; cv=none; b=ne08G6oWum++VtEP78fBv6XcEfS7xjKJI2OFhFHfMwL3BvP5IMf49r3ayrceaN0nXRCECu63hoyUJCytvU7gMIPX38B2YIVgkJYbbzKCyHxjJTl+xkBF5SC/zm2YJiLrZa3jln7IV95+6wxPDYAcVFUxm4W4oLi/ZDuDM2wxZP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762893854; c=relaxed/simple;
	bh=KXktgaFtHxbgxAtA3SwBBXkwSUqJQm9IFU9cuHXEKpQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n0aARKfe/QHJRA1Q2FriN6AbPYykXDV7ImHz6LtmijufYYCLEy59OWuWD2nzKD7pKWy62BkdmQqgy8VvlroZ7ctWxhdt8sEL2OXMATkRJHHIkvveBAjOuEaJMLkQl9akLZI8ay0zB0/h0vq3ZWUDTdQA96cdjV0M4o+mkZGz0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBufCgjA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIxybuA3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762893851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AouMFoYtS/g71aagKlLU9Deonq3urwuQMJX7R1T1Afc=;
	b=OBufCgjAiPdpFy77mMWSt7drfV9KIUfRyr33ww7za69cdtM3FndbifYiMUlKTpnGZkuYM+
	FfGP5b6+ev8VX4ZnNGJL18phs2ZejB2hno0NuIaMrxFHGTwy6FyJ1zwgLfUFeBDRO/+Le5
	xPxwZD0SPGwLP3h+iXf0ksNAQ3vMgb8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-gTkF3apHN7uxivkJouqDNQ-1; Tue, 11 Nov 2025 15:44:10 -0500
X-MC-Unique: gTkF3apHN7uxivkJouqDNQ-1
X-Mimecast-MFC-AGG-ID: gTkF3apHN7uxivkJouqDNQ_1762893850
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edd678b2a3so2062471cf.2
        for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 12:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762893850; x=1763498650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AouMFoYtS/g71aagKlLU9Deonq3urwuQMJX7R1T1Afc=;
        b=JIxybuA3xFJtVQqFi0/OXPZL+3Bt6dLVYM+WH94ey+/Gi1Ax+S9vGi8Hzf+NxcK7V/
         n41Ru0iiZgAdX9ZHNMOolqQwm7wuoORg0WrK2ImSTBbBC6B48uEn3RUGwSlHuc11lGkn
         ebFlqScy158Kdq7COoUZuQJuh380/DZJNCWVqkpaRDHFzQffcvMkUY+f0cky+IxMgE0M
         LjEkh7yv4Ow0UiiF0fitDpYPv4xrutp9auCf4ew08kRW2ALXRqjGWMKYmbt3UuPKChUR
         bZm/U1RShntXPagB/ax9PC21+uv+y+yXstwzASx0LeMDkJOT0qjqeL52QDVPBNFaFzP2
         HnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762893850; x=1763498650;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AouMFoYtS/g71aagKlLU9Deonq3urwuQMJX7R1T1Afc=;
        b=kxsJldLNCBsHV35IcOFCehsWnn0ylKgrkqId4e3ooBht9Ma5SmkOCesB1d3OHAVjik
         +cNOcr9GmmXsxxd8uKL8QYS2qzK8d9x2A0dinZL/cuskGdOpeU078Br6QnYkYQc9aXaM
         EIjLD+i1aE56TF0ZF+sMDiXhxrzsv6M2ASlv7pnEVtvrWS/Xp9XozBQRsvuemF4VW310
         PKWUZgW4rgUnWqMA+UHOvgvlSBolKZUTE5V7o+fKJGabFR8DXK8CDW3dun388eIAfe5L
         n81AtR+oX7B7if2vAm3FDYQ7genxoQBfAZqjsGDQQ3vr1xcWLB9Md0mNTZGXa/nE0PqF
         wLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU926d8xAhBmfYFtAalP5NrqZb0y+nuDuLZRzmc65ClYwFjlA6WCJKoCEqBI18DKDyJTo0s4MDA@vger.kernel.org
X-Gm-Message-State: AOJu0YyFnakTQTXLizaE7ilYVnzWl8fbhME3R7lIHlJKj9Z5W4Kmo8WT
	6XZ8J3v9QIikVKCnuSP56kGsa/xA8fkV9Dcy+GAHGV0FGahJzwSb8Mes/jNPw4YJnQk9k0PP5h6
	rpC8nU3ZG18rCUMPW4BgWm4zH1Dxrju7KzM9HwKMCNg4V/kr3267WQcBAucs=
X-Gm-Gg: ASbGnctn6DEB+nM1KkaSE/ExC+ECd7KyedbTYnICNV876XlYGqdG3j9ekZhraZ1iwxH
	OVZA0VcsGcEKlrLW2pxppms2xoGAASAmw9LH3me7VMDpv9hEFd1FXyEI5+m2Yj+FheP5Lo7AZVC
	yOUDOwZDt64LLHRtijnme7apGOlg+Rbf9LsOczW7RhtR+xQ4Vqkc66QE3CcYapYQkPVGvJOOptb
	4WvVxD2RLBI3o2xiRAF6axI1XFhNHNC5chzcOfMmM8nBPQmG3bznLf9aSW523pmvtmqRbX7PYFF
	Dcsjt+JhkJk0c2vVraWUqWHnZhNmn7UFLYfNtwL4oITFofHho7JR7S5jUjCgfjf76nYSRU5eo1q
	XUnWXCqOPfI9Wm51/HKOzuMLZfF2GTIWxFbvV6eq7KOy3fA==
X-Received: by 2002:ac8:5f8f:0:b0:4ed:b83f:78a3 with SMTP id d75a77b69052e-4eddbd7785dmr8990291cf.47.1762893849847;
        Tue, 11 Nov 2025 12:44:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE61o27JhGsft3MQNQXeIYKNMG5x6jKVgyaMvlVyyB9523TiIR1DvWB2nD07G01lezcrWTZAQ==
X-Received: by 2002:ac8:5f8f:0:b0:4ed:b83f:78a3 with SMTP id d75a77b69052e-4eddbd7785dmr8989821cf.47.1762893849371;
        Tue, 11 Nov 2025 12:44:09 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4edb56e2173sm55990661cf.2.2025.11.11.12.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:44:08 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <061cdd9e-a70b-4d45-909a-6d50f4da8ef3@redhat.com>
Date: Tue, 11 Nov 2025 15:44:07 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
To: Michal Hocko <mhocko@suse.com>, Waiman Long <llong@redhat.com>
Cc: Leon Huang Fu <leon.huangfu@shopee.com>, linux-mm@kvack.org,
 tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 akpm@linux-foundation.org, joel.granados@kernel.org, jack@suse.cz,
 laoar.shao@gmail.com, mclapinski@google.com, kyle.meyer@hpe.com,
 corbet@lwn.net, lance.yang@linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20251110101948.19277-1-leon.huangfu@shopee.com>
 <9a9a2ede-af6e-413a-97a0-800993072b22@redhat.com>
 <aROS7yxDU6qFAWzp@tiehlicka>
Content-Language: en-US
In-Reply-To: <aROS7yxDU6qFAWzp@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/11/25 2:47 PM, Michal Hocko wrote:
> On Tue 11-11-25 14:10:28, Waiman Long wrote:
> [...]
>>> +static void memcg_flush_stats(struct mem_cgroup *memcg, bool force)
>>> +{
>>> +	if (mem_cgroup_disabled())
>>> +		return;
>>> +
>>> +	memcg = memcg ?: root_mem_cgroup;
>>> +	__mem_cgroup_flush_stats(memcg, force);
>>> +}
>> Shouldn't we impose a limit in term of how frequently this
>> memcg_flush_stats() function can be called like at most a few times per
> This effectivelly invalidates the primary purpose of the interface to
> provide a method to get as-fresh-as-possible value AFAICS.
>
>> second to prevent abuse from user space as stat flushing is expensive? We
>> should prevent some kind of user space DoS attack by using this new API if
>> we decide to implement it.
> What exactly would be an attack vector?

just repeatedly write a string to the new cgroup file. It will then call 
css_rstat_flush() repeatedly. It is not a real DoS attack, but it can 
still consume a lot of cpu time and slow down other tasks.

Cheers,
Longman


