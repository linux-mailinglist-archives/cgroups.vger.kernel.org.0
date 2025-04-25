Return-Path: <cgroups+bounces-7819-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EB1A9BC5D
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 03:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CAB9A3055
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 01:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29383F9FB;
	Fri, 25 Apr 2025 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ngokn9Hq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA2F76026
	for <cgroups@vger.kernel.org>; Fri, 25 Apr 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745544795; cv=none; b=hAgE+XF0J65ONArZ4A3lv+isPiPBaLp2slwUsnbstUmh/8+GDayqfA/uvIhfO1cxV6IS0WgpDIbcpH6lMv/kdNslYTlA9aCoiTSnzTghlO7unMTd+w3Bk96lOtCjwOZIxEirQzr0e3z4KtqSxjvOXhv27U9GH8kmbMprWWAa55s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745544795; c=relaxed/simple;
	bh=BbUwCVnE5Tc1gzYszd7fjhvdn+1SNnyFMsCZIyRtbhM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VysqnWyiyqgmWYKyiHcJZFnE+XtcsZGh5C/4N3RBuPvGNszL9OBr0IHSyOZ/mXWaKdYDmqVdsx8P/f7Xe1OjslkTjZEFgi2EMNo0Be7495QduBG9gEfbSFsdGJqpRUvl6mcHmgv3DFilLdyL8iKbA2x2bOJ7YNx/QLLNZSYAOQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ngokn9Hq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745544792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcSXw+s5+3IcDt4ycVWOHEvd84hZVwK8heBLaI0+unM=;
	b=Ngokn9HqHHmfelS29Rxie7CLwmJwdlkerLA+D7mj+cVjs+AA4TxjUgnSYP3X5g8Zw1gtnK
	cL8Ga2ZGdR2Su7tVKejOwuU43yv46jvasEnt7VXCm+eAYZ7YGwFX3h7EMjsu9eafoEWxWj
	kUohoGD8keh6wxv+AYcpOJYO1v/jp0w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-o32ulnOVMuWEIv1qUmXt2g-1; Thu, 24 Apr 2025 21:33:11 -0400
X-MC-Unique: o32ulnOVMuWEIv1qUmXt2g-1
X-Mimecast-MFC-AGG-ID: o32ulnOVMuWEIv1qUmXt2g_1745544790
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8ec18a29aso18194326d6.2
        for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 18:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745544790; x=1746149590;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcSXw+s5+3IcDt4ycVWOHEvd84hZVwK8heBLaI0+unM=;
        b=N+AiyE7aBpEv77X8FwAsLK+7ZlcyZ1ehDQpjEESSdUbGv8S6vCsveZSHGS3NE1OYIg
         iqxuMXQAaTeR/QCuqQt8I+dNaAasTB1y0FwDoOBCVd1JU0hHYMPhj0nvDQ9PzfhXFO2c
         mUM/42Gm69N+95N9ypOZWSER/C5mFF6lPDyx2T1/6vvKljE3H7eGGTc5OksRJFlVymhA
         7QVLaK7U/50iY20qRQzDz/6cCMg9MJS6MFlysSv5nU3NPk0Mn81FO4jx0Gzqp6dSDl6H
         nT6xHdrw5EQzjGKbj6OuptuOZ2lftaXHpXOdTP9l2TLpEsHXF9vucfgVL+gvib9PHIlM
         xsrA==
X-Forwarded-Encrypted: i=1; AJvYcCUI7nUJ1h4wcq2ZJdn01966joyOG2nCdwwkb6/03JlxjkwPkgLjfyJaA3g0m03dlxZ/hXnKnHqz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/JyOB/K1kCtZcDEuwnlwMx/CPIPJcHd6hr/JJWBNYfJh2t+tV
	8USSlduZsPro7k6Cjn3Yz3zbUnBnr3KTyqJ5AyuYmDs8p+JBLk6kqPDO074gZmwSMLcdHqf3Yv6
	DVR2DXOGsWg4pOYvo+E5Y0Seh8tQD2+dxYKJCSw1t817fMRE7nHxcwcE=
X-Gm-Gg: ASbGncu44DxS7mVjilOHgsQ3KNTfCNNwLZqmdL4zw3g5XojYv1TB8BQOYEF+vXmQrxG
	4mlY6t771pmg8cAL7r3EY7R+1V9rBYLsrZ2+l+F2ykGw9mU9DZXZJ8Llp/5VmBqItDkA+O1Gw2I
	XRFBpEPtcGw3EfpE1GQyjgTRyPUZB83do1XgrMiRLuWLkHXx70bDArdqxL87zGTMx5Q/C/egkuW
	RJkAW5UAAip5iIUGtOy49Nn20oXshIN8YqfjIWOFEEjH1toXwyLlPIRRRLWTX4W5nJrgrWgAjMH
	hUi2ojaU4zP73kUVaCctUUYkE+HtAmY8bJycPcAzJCnZGfsE4mBQK8coxw==
X-Received: by 2002:a05:6214:509d:b0:6f4:c21b:cd6a with SMTP id 6a1803df08f44-6f4cb9bf08bmr12494606d6.18.1745544790700;
        Thu, 24 Apr 2025 18:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKObHEDSD0uhwvqx0FfjX6CMdc6GExMF71Kip+fcZML4+LupklZTjnnCP6brVsoSZep1xQvQ==
X-Received: by 2002:a05:6214:509d:b0:6f4:c21b:cd6a with SMTP id 6a1803df08f44-6f4cb9bf08bmr12494386d6.18.1745544790425;
        Thu, 24 Apr 2025 18:33:10 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0938399sm16447456d6.40.2025.04.24.18.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 18:33:09 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com>
Date: Thu, 24 Apr 2025 21:33:08 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup null pointer dereference
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>, Waiman Long <llong@redhat.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com>
 <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/24/25 8:53 PM, Kamaljit Singh wrote:
> Hi Waiman,
>
>> On 4/23/25 1:30 PM, Kamaljit Singh wrote:
>>> Hello,
>>>
>>> While running IOs to an nvme fabrics target we're hitting this null pointer which causes
>>> CPU hard lockups and NMI. Before the lockups, the Medusa IOs ran successfully for ~23 hours.
>>>
>>> I did not find any panics listing nvme or block driver calls.
>>>
>>> RIP: 0010:cgroup_rstat_flush+0x1d0/0x750
>>> points to rstat.c, cgroup_rstat_push_children(), line 162 under second while() to the following code.
>>>
>>> 160                 /* updated_next is parent cgroup terminated */
>>> 161                 while (child != parent) {
>>> 162                         child->rstat_flush_next = head;
>>> 163                         head = child;
>>> 164                         crstatc = cgroup_rstat_cpu(child, cpu);
>>> 165                         grandchild = crstatc->updated_children;
>>>
>>> In my test env I've added a null check to 'child' and re-running the long-term test.
>>> I'm wondering if this patch is sufficient to address any underlying issue or is just a band-aid.
>>> Please share any known patches or suggestions.
>>>                -          while (child != parent) {
>>>                +         while (child && child != parent) {
>> Child can become NULL only if the updated_next list isn't parent
>> terminated. This should not happen. A warning is needed if it really
>> happens. I will take a further look to see if there is a bug somewhere.
> My test re-ran for 36+ hours without any CPU lockups or NMI. This patch seems to have helped.
>
I now see what is wrong. The cgroup_rstat_push_children() function is 
supposed to be called with cgroup_rstat_lock held, but commit 
093c8812de2d3 ("cgroup: rstat: Cleanup flushing functions and locking") 
changes that. Hence racing can corrupt the list. I will work on a patch 
to fix that regression.

Cheers,
Longman


