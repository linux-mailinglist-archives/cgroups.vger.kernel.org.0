Return-Path: <cgroups+bounces-8917-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E904AB141B5
	for <lists+cgroups@lfdr.de>; Mon, 28 Jul 2025 20:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC323B2102
	for <lists+cgroups@lfdr.de>; Mon, 28 Jul 2025 18:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BED821D3D2;
	Mon, 28 Jul 2025 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3fxexxl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77C21C9E4;
	Mon, 28 Jul 2025 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725901; cv=none; b=IHj3uUl+jyp4Y2bo79CDXDIYyQWWO1BSL7SdDEQqWSz4QyTg6K43bt2vMI+cWXw7zNSuWB+bWTn/XDc9HLPV4Z52ErKcDo4meMDue2Q/XxsjGc7hncSKJRafU42u5wyjsTbjiVqGxpd5cgNwZ1+heTNVrB9THqLFsSyeSnjYHVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725901; c=relaxed/simple;
	bh=w1OQrTJmA8C4NEg2qWQxvEgjjxDw8811byNBODffSqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hx3DAPY4ytqU2KLhqc8wHyQ6K6/wXv1KzowuBwMezaaK1k/09h3dIvUyOlW6fVSt1tkkebJIZk2jHeZv8glATB87b1K0hNQbKtUixTKrIZG9HcsrQOkvnNiIBqP9cPnEVQL1jg3ZWpKYIun/SRo0Dv2zKuQ2RYHnqJphZMyk7R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3fxexxl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235e1d710d8so62602105ad.1;
        Mon, 28 Jul 2025 11:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753725899; x=1754330699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUYQ1ZFDYBuoDjqv+dOB0rUJcu4m65RTBlE/1yKAKBU=;
        b=g3fxexxls1FZ+azOWGatofj8yERYF2S38sVjYO+LrBqKIVTX0G3iju2x4JeV16VsQ/
         rmNqTf+bVZzokFFy6pTE1C0itJzQHAt9DBFTw9eqAefew0kjKNEvr5QtLQIpMflunY+y
         J9dLLwB/LmLcBmJH1KRWGgPq6XmrGGkrmyvwSjZTZRr3rt7EnaQbFLXlHtDW09rAiMiL
         ThyfXxt3uqA+Mb6IxfO3f3bDx4Zaj5jYaIQd1I8L/HVh24MHMzhXwmh/AtdEi/S570hS
         XJ3Ms6cAi4PdrkvHnMCTfN9564wkCr4M5pdr4J3buVWhCBEQ+tx49vHBF9+C3gWAKFYI
         U3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725899; x=1754330699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUYQ1ZFDYBuoDjqv+dOB0rUJcu4m65RTBlE/1yKAKBU=;
        b=NzAjhh2vG2lABZDiEr9dar5rXQy5IJvexDg3u/Gzv4819YpLifrSwyjF5AgMTSQw4m
         zT2yyVVED2Yv2tfD2qUZ5/SOo+WfPh9ww7jNH36kpPwBXGvylFyF6qhf8Scf+9ITpAE1
         XLSPSJBSqYqgrNHxkuk3wGmK7mAP5j8OEwbsmFEGFwE3TmFH+KiiKKZq59n1pQ/ezl8E
         lGNXJ2r29qHWUPxvQx/dM3vRPklJQVbDlA79BKXzym0xjUhi2SB2aH4tpG2zVDtg5zLw
         OgBVX2EHwH5rD75Fe1zXeOohxhLLlkP93TgYqqqBMEZOWSAmI35YAnrbQBKyZmAelFQq
         GchQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUQiUmT5Lbra6lW9R33fSMRbWv7Qu/IzUY1d83DEbxoj1ObJCjN6rwfVoQ1L+tH48IVsafh+31@vger.kernel.org, AJvYcCUs0vyCbxXOlvL699O+VqO6PLanN6kod3gM4sjTGdO9qCdoC2tlj52vkIkW8KmXftFK+xGFYTyNdDfXheKj@vger.kernel.org
X-Gm-Message-State: AOJu0YwIVCFtF863RKqYXd0rh7NmNChTpGzHw2pOpYZXrfA6YM0Abfbr
	7LaQ1Fuu1BA0dV2WoIhFyg7JC3hEt/r0JPHaChXjob6clsCl76YDYD+6
X-Gm-Gg: ASbGnctaHOXOCzMWz9AU/CxjxiIKka4y6KdKm9+Z0FbXe9zUWF/HariLJ1mc77fnMom
	dChqs7j6wcOzn5z6p1Py230n/d02/s3pn52cz/47gZ8yepMN9Y6rT0DHsjgCiVMoaPfR4rRo9df
	uIAn4JBtp70P5TAi54iyMUp6dYZngFFuGlgFG+Q8bRfT5vAi1QeyWaR0hGLcML0nAVODveewSl2
	tKmf/7WxLzrM159QI08PpIXaA8QcSwVsDbPHKp+8xG9CnIaTGWKTp987JnV7/oysEWhojAouO9N
	hjXqSKGndVzlSqhwjB0/gGY/lvpsDhV1EZEjFe4kPGE1YDepywKJ/xdo36s1s0XOG9YHOCkn0wj
	VB7y6W2qYvNNC3sO/7gtJzlKGCZ+/zuk=
X-Google-Smtp-Source: AGHT+IFhHKqqYoKk/2yXsIUVz0lyQgFAn1bzu8xKSf0pTJYN7fDyKkP70fpbe1MD/lO/8YhkX/NTrg==
X-Received: by 2002:a17:902:f792:b0:240:636c:df91 with SMTP id d9443c01a7336-240636ce294mr9126985ad.34.1753725898673;
        Mon, 28 Jul 2025 11:04:58 -0700 (PDT)
Received: from [192.168.1.190] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2400e95ca6fsm33554265ad.213.2025.07.28.11.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 11:04:58 -0700 (PDT)
Message-ID: <e8156c36-48f3-4983-8a2e-5a5a4444a473@gmail.com>
Date: Mon, 28 Jul 2025 11:04:56 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5 cgroup/for-6.16-fixes] harden css_create() for safe
 placement of call to css_rstat_init()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250722014030.297537-1-inwardvessel@gmail.com>
 <cughucmlrkwe3unwwmtx3yrqyrqwsedrbh2ck5feqs6cr36j3z@fhrnw6nfnyte>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <cughucmlrkwe3unwwmtx3yrqyrqwsedrbh2ck5feqs6cr36j3z@fhrnw6nfnyte>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for taking a look Michal.

On 7/25/25 10:23 AM, Michal Koutný wrote:
> Hi.
>
> On Mon, Jul 21, 2025 at 06:40:25PM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
> ...
>
> Thanks for the instructive summary!
>
>> If any of the three goto jumps are taken, async cleanup will begin and
>> css_rstat_exit() will be invoked. But since css_rstat_init() would not have
>> succeeded, the warning will eventually be reached.
> First thought is why not simply add a flag that'd guide whether
> css_rstat_exit() has work to do.
I did consider adding an "initialized" flag to the css but since there 
can be multiple css's per
cgroup it felt like it would be adding overhead. So I went the path of 
getting the call
sequence right. I'm open to feedback on this, though.
>
> This is meant as a fix, so it should have some metadata, I'd consider this one:
> Fixes: 5da3bfa029d68 ("cgroup: use separate rstat trees for each subsystem")
>
> (that's when css_rstat_init was moved to css_create)
>
> and likely this
> Reported-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com
>
> (Sorry for being such a bureaucrat.)
No problem, I overlooked that.
> It's most appropriate in your 4/5 but do you think it'd be possible to
> reshuffle the series to put the fix in front (to ease it for stable
> kernels) and refactorings after?
Let me give that a try. As it is right now, patches 1-3 are pre-reqs for 
4. I can try to get the
actual fix to the front and then add patches to additionally make 
nicer/refactor.

