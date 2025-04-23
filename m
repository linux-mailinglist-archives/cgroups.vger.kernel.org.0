Return-Path: <cgroups+bounces-7759-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 441CCA99AAE
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 23:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410693A9F24
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 21:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8954024466A;
	Wed, 23 Apr 2025 21:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9s9UYiR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0321FF26
	for <cgroups@vger.kernel.org>; Wed, 23 Apr 2025 21:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745443572; cv=none; b=ZG+JHzumAqJrOGCkvdj7lwqgPsvcttTtuYxZ2FkJkEEJShthOy2/HQ06muRoy6bw1IU8eQLirlzqrbIqROnwuMc6/UWoEhJt4MuYcSePBO2ZTEOcajIExLJOS3jJaYfZn9cT6parcCUC7de8SBQEdpiFlsUgMZDRqhvTYhm1WvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745443572; c=relaxed/simple;
	bh=JIAataaF3MAC5dfiIOHAE9jhxPO9qEIVVLyurNzbufk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pldhJPU0wJowbP/az4qgRDRYye35eMNQioVLqf/Cb7QAcKWhJAkpPZ8Ao+qy9cQ6Wit/YJwqDky/4PfRgNHI1WkiD5Mz1PjHOi5KT9qckB3ZUGvLaeL0F9CjY4Qsxg2vqjklzYcnJo9aaJfndgRHuGJgSyGNGEMTcADFtHBySJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9s9UYiR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745443569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aU4NFciLR4UCyMwqNbOWtp1Qy37FjSg/5JGcNCTMQtY=;
	b=F9s9UYiRbOLfhW9Kwhsv76TeWe4A1+TefuoYoWQCqO6tLFqSBhVDTa3g0xjKleGMvXd9zf
	e7w5Ay0iqhWnVTt7l9Ymho0FbV3i80kJ38+MiXyoSx2LPPlYi2dyNu+sLrj6JPMJxV+swM
	+y/D/humE9oLPRbKUIVG6nnFphkY3S8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-uvn8K2Z6O0-Ov8q22vx3Yg-1; Wed, 23 Apr 2025 17:26:07 -0400
X-MC-Unique: uvn8K2Z6O0-Ov8q22vx3Yg-1
X-Mimecast-MFC-AGG-ID: uvn8K2Z6O0-Ov8q22vx3Yg_1745443567
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c793d573b2so55146085a.1
        for <cgroups@vger.kernel.org>; Wed, 23 Apr 2025 14:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745443567; x=1746048367;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aU4NFciLR4UCyMwqNbOWtp1Qy37FjSg/5JGcNCTMQtY=;
        b=EchEBdB7E8TE9X1+rL/dPM6RY2HhAJrxx24ncj2a59bMcWAe4RKe4wVMonsM54Xrur
         azKgd3Fq1T8Ng4RhoFYCUwEgRX+okKtXHJb9tfzvqZs6BVBiktqChKDtNfRt1Jf5Pz7E
         W4cirKR8D+3uvUdvWUk+qKDYFWMYPtkPIsxdU9Mx4LFADqcuKO3w9PSPA0XxmygXeaTs
         1O1ZcSbH2Ma2+kqneo4NrWi9VADdavo7e56I0jqh1FP7IPME2ESioeBpJo18W2GzIVwM
         dVhzx2oFw4UNJtrhZVglUw/Mob47V7DCxL9kyZSWsX93/8lfu9jElGeu2WiVPczkku3d
         uZjw==
X-Forwarded-Encrypted: i=1; AJvYcCUN5IT8SL2ZEXs1MrYyXGWJrgtwTFMtKZ49DLI7oFhXylP6oqo6Y5srE+Edhu7sM6EfQ0HyAk2l@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIQW90kQmxaKESp9jYs4dbMU4r8GzLIoCgmCY1XKZyurygZLY
	qOjw9B/HaTlt2vp/K9N3W+PM6t2VkMNsb9gow5iHjDOpSiEAKRGYOdd4kegCVaxqbVlmJA+b3aq
	naf0Rsto8h3JLXGE9TA8ePE7v94TrimVyCkQJ39vX2DkIy1RG/2SuUgo=
X-Gm-Gg: ASbGncsj168t6d+d6Rr/CjuCTJTz+2RWn9LtRsRdtOOHhAe2XqYnfvuXa8L+JlJoKtX
	sWKMYtgrLNdI5mKgvapMGTSy4BdjjlqFMlJqsBH1TW4Ed5Zw4z/ru6YFGgYPzfOMsvVW422Cl3X
	yQo3aJpFFj3/h9exm8Vo9rHPDBT2wRZcPe3LV7o23sgYLXafLok3xD943CKTsEHoZkkgQwTBddJ
	/EY5yqlhCzZNzXynhDF+EDrFGcnvge5o7c2eDTNIC5GssDOPmYmz8URjOUvo1mJrOWMQ5l13+qP
	NqBgNDb2Vyoi+Jfh95/7/ID0JLC0OCu64dtGvOzqB8avSz85JggZtnQRXQ==
X-Received: by 2002:a05:620a:199f:b0:7c5:46e4:480b with SMTP id af79cd13be357-7c956eda80amr54939485a.22.1745443567266;
        Wed, 23 Apr 2025 14:26:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8haqQUDBHoe6I7z1HOjPMMGHldKnDbmOSgGYPeTOaPgqtmaNKn/a8LPm4WITMwLxPdPWBbw==
X-Received: by 2002:a05:620a:199f:b0:7c5:46e4:480b with SMTP id af79cd13be357-7c956eda80amr54937985a.22.1745443567003;
        Wed, 23 Apr 2025 14:26:07 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a70768sm731509485a.23.2025.04.23.14.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 14:26:06 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com>
Date: Wed, 23 Apr 2025 17:26:04 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup null pointer dereference
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/23/25 1:30 PM, Kamaljit Singh wrote:
> Hello,
>
> While running IOs to an nvme fabrics target we're hitting this null pointer which causes
> CPU hard lockups and NMI. Before the lockups, the Medusa IOs ran successfully for ~23 hours.
>
> I did not find any panics listing nvme or block driver calls.
>
> RIP: 0010:cgroup_rstat_flush+0x1d0/0x750
> points to rstat.c, cgroup_rstat_push_children(), line 162 under second while() to the following code.
>
> 160                 /* updated_next is parent cgroup terminated */
> 161                 while (child != parent) {
> 162                         child->rstat_flush_next = head;
> 163                         head = child;
> 164                         crstatc = cgroup_rstat_cpu(child, cpu);
> 165                         grandchild = crstatc->updated_children;
>
> In my test env I've added a null check to 'child' and re-running the long-term test.
> I'm wondering if this patch is sufficient to address any underlying issue or is just a band-aid.
> Please share any known patches or suggestions.
>               -          while (child != parent) {
>               +         while (child && child != parent) {

Child can become NULL only if the updated_next list isn't parent 
terminated. This should not happen. A warning is needed if it really 
happens. I will take a further look to see if there is a bug somewhere.

Cheers,
Longman


