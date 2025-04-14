Return-Path: <cgroups+bounces-7528-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDD5A88C3D
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 21:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABF517C173
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 19:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD19E28B518;
	Mon, 14 Apr 2025 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KON0hFk6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9271289359
	for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744658711; cv=none; b=toP3Ucw57xnN+Sqlsf3qflOlpknRgcUHVnCu/6wZPVV1JS3ay4LQ6m0PrWeC/hFOYdbvvZ/qWoDlTHrVlb3arfUCr3QnD0QOhN2ZjUYpXO7CTyc31q3DpsSEq52yEjc1zQM88J2Dd8Mtk3QKEY6GBBuyklHjn0s2kmPwXdMSfcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744658711; c=relaxed/simple;
	bh=mSGv8XayopqXzqyv01axofeX1lhLmDHqL5JMVx2mR48=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EgbzcMPNQw/tPr2n29ej/q8YKgrYcLR+jQY3JRDcVXqXI07RIcH4tF/aauZ1H2U3pmzvqlSipkU25NBEQSZ0WMh2Un+reN0i8xeZjUmoeChJ7hR2x4Plgr5N/iXwbZKjAHkPOXStN92bCQEILsWgRmgDTyi0nqk5zSP7XjeAZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KON0hFk6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744658708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0oKbr4kKS2qbRj/Sg6H3NOkvDBAaqSfhBlFVEGNmFs=;
	b=KON0hFk64d/he1pRrlRkBh+JDBPeSY8yt///JSS5ZSuA4h0oNBvVjZZ87BEdXXSognchNa
	K2AhLsyW4C+36y2pOr6fXwdkuodQJi8mXg4sd5olo8F/I0z661M/HcvY6kTWRcbNwAiBc5
	JGf0rqryhKJW5LbU48Vu5KClGvwxvaU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-amw0ZPDOOxGB0xHYhjS8DA-1; Mon, 14 Apr 2025 15:25:07 -0400
X-MC-Unique: amw0ZPDOOxGB0xHYhjS8DA-1
X-Mimecast-MFC-AGG-ID: amw0ZPDOOxGB0xHYhjS8DA_1744658706
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-851a991cf8bso468997339f.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 12:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744658706; x=1745263506;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0oKbr4kKS2qbRj/Sg6H3NOkvDBAaqSfhBlFVEGNmFs=;
        b=VQezZBbvF4WhW/h3cAS0RcFCNPLe5I91IvA3/3FTytDTC7CMowZifWn25uPfGRws+w
         gCBZ1fvUCTJekpVrbBFjYsBbywwl/w6Gre1GiCOdRHrM/0kRgvpGUSJ51sDT4B2JbmeL
         2nDgiwDAlwIX19a6mKAMDHsJigbmdvjSL08wOVeNkAJVvR2Yclh9KEn7EtYWSCbcecl6
         iwMCLBTjonLLOAzJ+3wqxdO+JMQUH0ao8C+fZM2RBWAIlZpcqef+BOQXjFTC2397ZKjA
         Zx663aZXfm5boW9DDNHEMFhSRd8ECz5E4tTzeo67n8vYX9N3gIK4rLHU4WG8hObfiIW1
         eYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgeFGr7vQwFRm6o3ZKcF77l02h91KPA8p/XEPLlTxbMdjnHcI6YzbAxyI+g4QlZZAccn5efl1q@vger.kernel.org
X-Gm-Message-State: AOJu0YyjsPQL0FiFMpCvH35JaZqep3LZnr22oaWr1f7MxbaeBbYQE9Wo
	2m4e1s4+J2suw6PY9Te7Ehsne/8UOM6T8SHI+3eMbw7XSbEaqXz0qlYS539pVjT6JMNXuHkq9uQ
	1Ib8kqpRpL55OZ7+TSneh6yD5v6rAZghn2VemCHjKWzLjuPeGdtbNnHc=
X-Gm-Gg: ASbGncvAi2/+VpC1IxQ9WEjd65hBjEnzY97rDhnMchQ643a5fm6dQP1xOWerM4Vmp58
	Q1fnNbrBeKfgkUMg9zyM9AVdJne+MjYPslJiIfR3j3ByGLdLHrKgFbulLLofZtGF6nOF02Xay/o
	6L1XQ03TT9PFruQtKId1vMqr8QvNxSY8TJzl8J2meRgBoL/npSdof8JeTG3IlKep6GLzAUaexqh
	qtwwXPaqFD+xRVhWIU2OJwiw1r6gaFXrTrCiJuW6gAkMM9e7BWKjxuqWvZZFLga0LPP1PCzPyx3
	HwVmE4w2GmQ+h4UCLb2UWbRo4qBR48RrFOfk3F0BxDgtgDWFhXDxPcf32A==
X-Received: by 2002:a5e:de42:0:b0:85e:16e9:5e8d with SMTP id ca18e2360f4ac-861b1903fecmr65512239f.7.1744658706487;
        Mon, 14 Apr 2025 12:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE24mqzq/9JMt9xaqFo8zuLdM4dyfEF/N/Li2nupDLceIwyojLaqOylmpm30VyJDGcNLVELxw==
X-Received: by 2002:a5e:de42:0:b0:85e:16e9:5e8d with SMTP id ca18e2360f4ac-861b1903fecmr65510239f.7.1744658706176;
        Mon, 14 Apr 2025 12:25:06 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505d1873bsm2721724173.48.2025.04.14.12.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 12:25:05 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <45f38b98-43e0-4d0a-9106-f8b537f59a17@redhat.com>
Date: Mon, 14 Apr 2025 15:25:03 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KASAN: slab-use-after-free Read in cgroup_rstat_flush
To: tj <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ffhgfv <xnxc22xnxc22@qq.com>, hannes <hannes@cmpxchg.org>,
 cgroups <cgroups@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <tencent_084EDA1878C098FFB951DC70F6FFCC896408@qq.com>
 <djupj4qfnd2izxhtzkmmhx6bfmnn3462dqi45qwbmdj46twart@424eqzhhh2s3>
 <Z_1JBt3RMATxnDgL@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <Z_1JBt3RMATxnDgL@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/14/25 1:42 PM, tj wrote:
> On Mon, Apr 14, 2025 at 07:40:04PM +0200, Michal Koutný wrote:
>> Hello.
>>
>> On Mon, Apr 07, 2025 at 07:59:58AM -0400, ffhgfv <xnxc22xnxc22@qq.com> wrote:
>>> Hello, I found a bug titled "   KASAN: slab-use-after-free Read in cgroup_rstat_flush " with modified syzkaller in the Linux6.14.
>>> If you fix this issue, please add the following tag to the commit:  Reported-by: Jianzhou Zhao <xnxc22xnxc22@qq.com>,    xingwei lee <xrivendell7@gmail.com>,Penglei Jiang <superman.xpt@gmail.com>
>>> I use the same kernel as syzbot instance upstream: f6e0150b2003fb2b9265028a618aa1732b3edc8f
>>> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&amp;x=da4b04ae798b7ef6
>>> compiler: gcc version 11.4.0
>>>
>>> Unfortunately, we do not have a repro.
>> Thanks for sharing the report.
>>
>>> ------------[ cut here ]-----------------------------------------
>>>   TITLE:  KASAN: slab-use-after-free Read in cgroup_rstat_flush
>>> ==================================================================
>>> bridge_slave_0: left allmulticast mode
>>> bridge_slave_0: left promiscuous mode
>>> bridge0: port 1(bridge_slave_0) entered disabled state
>>> ==================================================================
>>> BUG: KASAN: slab-use-after-free in cgroup_rstat_cpu kernel/cgroup/rstat.c:19 [inline]
>>> BUG: KASAN: slab-use-after-free in cgroup_base_stat_flush kernel/cgroup/rstat.c:422 [inline]
>>> BUG: KASAN: slab-use-after-free in cgroup_rstat_flush+0x16ce/0x2180 kernel/cgroup/rstat.c:328
>> I read this like the struct cgroup is gone when the code try flushing
>> its respective stats (its ->rstat_cpu more precisely).
>>
>> Namely,
>> 	__mem_cgroup_flush_stats
>> 		cgroup_rstat_flush(memcg->css.cgroup);
>> this reference is taken at cgroup creation in init_and_link_css()
>> and released only in css_free_rwork_fn().
> Maybe another casualty of the bug fixed by a22b3d54de94 ("cgroup/cpuset: Fix
> race between newly created partition and dying one")?

You mean the rcu_read_lock isn't held for the entire flushing operation 
so that the cgroup structure itself may have been freed near the end. Right?

Cheers,
Longman

>
> Thanks.
>


