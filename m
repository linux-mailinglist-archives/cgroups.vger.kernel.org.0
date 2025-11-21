Return-Path: <cgroups+bounces-12159-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C364FC7A9DB
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 16:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C06844E9D33
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3153321C6;
	Fri, 21 Nov 2025 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZtZrkbg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdkMS+8/"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD3333450
	for <cgroups@vger.kernel.org>; Fri, 21 Nov 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740074; cv=none; b=M0jxVdbjw0QpaQnB+rxie1+6+w3JWLrU6TAsmd2j0PgmoQa4aM6j4xlgMqRp+KUwIMm/c0/Cb9pAhO82zLbj7tyQkWOUNX0b+o2YfzCXpnIZTk2ng1TCZXt/Pj1el3xEe683M+shRpodtaESi+4xPg9Ou/7evz0eovwkxF+yIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740074; c=relaxed/simple;
	bh=1wEaqFGx2DAZ8HZKwv7x8vg2ak+ntgM8SK6KYb0tLL4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P6cIV/tIBd9ijKOm+xu6z+01tXUcWcVkV3Hx7HCWdtLy0gS82gpAKwQB/CITHprF3jwR124SDoZzLO57UgjxPngSod2+IquM1S1/ddnLoi3J+txTZ8q1qyQv8F+eYPo3LZOxMiHOoFQ3UJBjuiDFtKkLvQbOnHBZsSjMKg2jRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZtZrkbg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VdkMS+8/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763740071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa3qKwfnivOIPXFNgSUhQ9fpoABoHPo2Ebm876qZAu4=;
	b=BZtZrkbgX0FYxq77puZ0jmaGp81WVzYUfEynqyiogaVApvAl8fFecG/99nEpM6wwICqnKb
	qEtdrSuz3T6tZ2wov3+RAi30n9ErB5z6IGB83pxULvZznDAJgCqkpkIlzA+REDtkShDn9I
	aSVsrvZG5pzUn52H/KB9VOlrHiiVVH8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-QvSkSRlOOXiaEkkIUaxM-A-1; Fri, 21 Nov 2025 10:47:50 -0500
X-MC-Unique: QvSkSRlOOXiaEkkIUaxM-A-1
X-Mimecast-MFC-AGG-ID: QvSkSRlOOXiaEkkIUaxM-A_1763740070
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-880444afa2cso29415616d6.1
        for <cgroups@vger.kernel.org>; Fri, 21 Nov 2025 07:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763740069; x=1764344869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fa3qKwfnivOIPXFNgSUhQ9fpoABoHPo2Ebm876qZAu4=;
        b=VdkMS+8/y/K8qdtc7ElHLvXsVqAseAEkY/FCVDrxgCTXgWlxYB7NYwIkYm2xMTCeCT
         YEeUX+Z/w0IJatNmWRI1QSWUDpVppzPqqEsD3K+mAjVSvGjbj+vGxTCwMFGh/AVJUwV3
         k1dRvwh0m0Ub4Zdni9q8Hhz7p4vNyuZKRsdzqOyJG1f5MDQqeqtFAFR7Qx13P9DJ/XJO
         jnnOgdOUFplDDj3+m8FQNXubB5m+wnjaHN6uxGclZPeWHQGovZVwmQbQOU0IXulo3HQZ
         xhlk6z/gmaIeIyVA1NPDSbhlOaupxRjqKJy/JnEBrT/bFtz/ZbTLfVwSbHX4A0HhtVQQ
         uvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763740069; x=1764344869;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa3qKwfnivOIPXFNgSUhQ9fpoABoHPo2Ebm876qZAu4=;
        b=W+SLV8nEyv66Wh2U3ftRQmDCxCNaLan/fZdKWnBWUVXbWsMJXwQkJTCDWcKuPrOMUH
         P1hR9KSLdCVQ0ffEEXuXSObwZc6cDawVeVA+v4TZ/v7eEDd1SQH97eOAqaB1PScjWmlC
         FZsxMuMdQbqSzIxBCbWK2vBbj17lMu+b3vPN1vRr3CoOy67+44lqOPviQ9ttqfs9sLpc
         cXi3xMYR+g1RcObsjPL+PlzkR/tPmMir4ym9t1x/CPmhXTlP8OkbbuYDhHLEvbUixsPM
         FzYdradHPPttq67vxidyFKBaCfZcQnLK0q4f+g+FndKvvYDVvED3cGGFVhrYO4j6fubR
         JQjA==
X-Forwarded-Encrypted: i=1; AJvYcCUY4nQ6VDyFzJ9c4dO5LDeG2YjjrCK3/VuvxCeJFXD+wXfuk0nDNP86g+a75zOuOC6U3RDbKw6a@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8KkipT1QfEMiXAruywYEMuih8DkBn4nVik60N+jHc6qbMHyLx
	CdozxUnDFkSR1m/MBALdz1XHE9g3qqB6GFnaK+QK7nZTY4e+Cm7tBfrcVKEa/M0/2/5AUC1usX8
	sJNFK18Bb2L01ydMg7lCMTYWGLXf9odEJD0bXA3oBIEqXVWsj1jdvjsP5lPqzIblnux4=
X-Gm-Gg: ASbGnctJBkFc5vehr7TleW0XIxsERiwj1IDq2t9BwZYb2t9plgJLt6tVWOFPJGYMeky
	LWD8m2begDoEt1ZQTKZtyk+5bVngT0i0bLs3N9poy7MMQziF/2JwPDOeZD3j46pz8w4qBfKLDow
	Km+YKcGjuVNdTvdXfZpGwTZjBD6uuCTgVheR24YeJM1R0pcgo/MEhj90ZvI1omkppKZaXb7SShx
	iFv1fmMbWNUgt3NQWQZ0Ro9QfTrz0+lr9LgOMqTuz5A9it1rlTEPW5nO/dtGIijxVBJaE+FJbAD
	vFwPIu8ZWNm2r827w9ucxTrKBdJr2zpEA+JRWEx9Kxa/CrKG7gJZX+Mwtw2N8YHJ2dhvREVHnK1
	kKnuQ+qWWdP67QNBNaCi/LjAh0Lop4XsAxqdnzY7rj4vbX24Whzo7vIwM
X-Received: by 2002:a05:6214:4a88:b0:880:4ed1:ce3b with SMTP id 6a1803df08f44-8847c4d28eamr41404956d6.12.1763740069325;
        Fri, 21 Nov 2025 07:47:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUm/tL/TnU/6Byd6uQQSTP7PVavDYfah8RaBnivWn0Bd07mUj/63wgq3viDLKR2+Z3mUP8nQ==
X-Received: by 2002:a05:6214:4a88:b0:880:4ed1:ce3b with SMTP id 6a1803df08f44-8847c4d28eamr41404376d6.12.1763740068812;
        Fri, 21 Nov 2025 07:47:48 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e59ec1dsm41997836d6.50.2025.11.21.07.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 07:47:48 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0bcbe776-de46-42eb-8d98-e4067052b1df@redhat.com>
Date: Fri, 21 Nov 2025 10:47:47 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup: Add preemption protection to
 css_rstat_updated()
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Waiman Long <llong@redhat.com>,
 cgroups@vger.kernel.org
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org
References: <20251121040655.89584-1-jiayuan.chen@linux.dev>
 <6cd2dc59-e647-411f-ba3e-2a741487abb8@redhat.com>
 <305559b6e8249a31ccbe1fe77fd3a3c041872c4b@linux.dev>
Content-Language: en-US
In-Reply-To: <305559b6e8249a31ccbe1fe77fd3a3c041872c4b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/21/25 1:21 AM, Jiayuan Chen wrote:
> November 21, 2025 at 13:07, "Waiman Long" <llong@redhat.com mailto:llong@redhat.com?to=%22Waiman%20Long%22%20%3Cllong%40redhat.com%3E > wrote:
>
>
>> On 11/20/25 11:06 PM, Jiayuan Chen wrote:
>>
>>> BPF programs do not disable preemption, they only disable migration.
>>>   Therefore, when running the cgroup_hierarchical_stats selftest, a
>>>   warning [1] is generated.
>>>
>>>   The css_rstat_updated() function is lockless and reentrant. However,
>>>   as Tejun pointed out [2], preemption-related considerations need to
>>>   be considered. Since css_rstat_updated() can be called from BPF where
>>>   preemption is not disabled by its framework and it has already been
>>>   exposed as a kfunc to BPF programs, introducing a new kfunc like bpf_xx
>>>   will break existing uses. Thus, we directly make css_rstat_updated()
>>>   preempt-safe here.
>>>
>> My understand of Tejun's comment is to add bpf_preempt_disable() and bpf_preempt_enable() calls around the css_rstat_updated() call in the bpf program defined in tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c instead of adding that in the css_rstat_updated() function itself. But I may be wrong.
>>
>> Cheers, Longman
>>
> If that's really the case, then I'd rather add a new wrapper kfunc for BPF
> to replace css_rstat_updated(). Otherwise, whether it gets triggered would
> depend entirely on users behavior.
>
> Right now, this WARNING is showing up in all BPF selftests. Although it's not
> treated as an error that fails the tests,it's visible in the action runs:
> https://github.com/kernel-patches/bpf/actions

All the existing callers of css_rstat_updated() except the bpf selftest 
has preemption disabled. So it doesn't make sense to impose a cost 
(though small) on kernel code that are in production kernel in order to 
make a selftest pass with no change.

Cheers,
Longman

>


