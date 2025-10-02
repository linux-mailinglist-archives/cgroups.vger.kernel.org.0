Return-Path: <cgroups+bounces-10525-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF77BB4D9A
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 20:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829DB1C59EC
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 18:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68C7273D8F;
	Thu,  2 Oct 2025 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHFAjvFj"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A35223C4E3
	for <cgroups@vger.kernel.org>; Thu,  2 Oct 2025 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428682; cv=none; b=poxzKoTed86VSOzJsU+bEln9mwxBfVT4tzoTSdOVXIL01gad4kCFpJ1635rcMkCYJoxxa9/17zrcoyW9gJGTKRszCjQM3OVyx8u4VHxW2GWZDRAXdcKyKy4yFa4M7AdYD4+fMJkA4o2bschynTGJXXzym+iPA7tbFCrGNESEeDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428682; c=relaxed/simple;
	bh=/fvxDLX84RKzAlvxArYSUTdKHENkU+Sgw+KMtcjlpjY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aOjKx5ZU3Bru5sRSOrCXV8qjXMQZfuGM5OgqI4/vq+urmPjr6OD2qFGtyQaJBMuL/Vm7N4S4vc7oD4b89QBX41XD376RP/VleMS0Bm6bhcPr4Jf/HggKngJkLHnz8KdFcrmvtXuzHwV/EcjB6xjFGQA6yNWrr5IQTiNnOi5Xg1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHFAjvFj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759428680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/3VL778qVsrEG14dD8aS214ANjne650qKPHxRnv2Ro=;
	b=PHFAjvFjKPfxhFCD+eevoziXVk/bdibO7tsQIN7YXdC0JfistsStAZcexIXTgc/PvoYSp/
	TTtZnLgeXktp52AXgGNKDF2Sw4ULT/lsOE7fyw2UF3+nb2ZIMKmKP3yBzKdn6A4XfVoCjj
	GkKxVvaTJM9Gjd6ffQKP6qrKDjqMScU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-0v39wAvaMU-LS_G9CLv2bg-1; Thu, 02 Oct 2025 14:11:19 -0400
X-MC-Unique: 0v39wAvaMU-LS_G9CLv2bg-1
X-Mimecast-MFC-AGG-ID: 0v39wAvaMU-LS_G9CLv2bg_1759428677
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4df60ea7a1bso27678511cf.2
        for <cgroups@vger.kernel.org>; Thu, 02 Oct 2025 11:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759428677; x=1760033477;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/3VL778qVsrEG14dD8aS214ANjne650qKPHxRnv2Ro=;
        b=qG4R/Bm2TqfAYzvRHqD5PAp11ZZPyYQQoHK8VsyjupJ1aEmrp3nnI/NOGo6PkHof+M
         1L96SVEHmDLeY4TjqY3uKRARn7Q4dPH1ogGgA159Li3VygvzRediXpgIA7DkdJs9B68S
         2lmjOYgEUQMMcnH+Nr7emXJV+HI2AWrJetSn6Z+s5gHAz788V57KTf8dqZ+SuRjHVBIk
         qcaZc9x2LMH6L5v2724BSugRoykoHzYPipPhQGpZ8LGD9/c5sKP/lVAxwUEqHh+vrZji
         7nYovRM3gpPO4XMUlr0ZmK7mONfGfzYnW9Ca3dN6efMd/+Tzeca2RAqPJq6JjXz8HBP8
         UOCw==
X-Forwarded-Encrypted: i=1; AJvYcCXRiGnKcO1lhLXWynX9uqMFHPICw1lzIPh2xJ7n4DD5t1IvUfuictloUAM/bXyXHJIwjeJiHKoy@vger.kernel.org
X-Gm-Message-State: AOJu0YxwDqe1uLRTuznxadfw/RA/V7Z3KfwGQ2ux383nzcpi2xB4t34N
	iYTkud4SI+XMegPBnQoYzmZhIOgXjAzgzpD+UtpsEUW7uw8rZlrYJnmqjMgBwLDMJlDcFpVC2j/
	0gnruOOFhM8OStYu7puBgLvVqwiJoDF71hEFUidSdfsJ+g9fHQzkhBkPATu8=
X-Gm-Gg: ASbGnct39XAoBFUODCrUaBNCsgbPW6Kc+FPoFDXuRtsC1lOpLdveKGhOhpOEX8UR49n
	SEES2dZuHQ+OgGQW2U1qROnW6mspAbYvmnH7XfBJkK3OgZXvJRGWsSkXATEBQqZ5VYN8xDISBQW
	VmT398pwYGNNGq5X2i6br8UdTTJz9iEuu7mnNgy2zf4uIBMLtHzjA4UYt7CAS4SX6gbCMnQq0Ir
	qOYo5bzoxGWjvs0SqLgMahs08m2y0lX/qhzB/shGW3P2//z3o+n/h8QtEZ+R0hF8tHkG1BL0iQj
	Smk9KNxOlEP3NyX3/YyZyxGthUXlw6i0UxajD1gx4fQl1Zmii70IxzWP5uSMjkDDdVPVoeqLZTD
	XPqis5ykYFIGzMRMV
X-Received: by 2002:a05:622a:10f:b0:4d9:639:e9dc with SMTP id d75a77b69052e-4e576b4284fmr2889491cf.84.1759428673195;
        Thu, 02 Oct 2025 11:11:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpHLebwTF+3zLjEhXcm32FCiH8vMxE8GhuGHPClGlQ0YCiWQfMAgRAXQwNuIBsGTlPpdPySQ==
X-Received: by 2002:a05:622a:10f:b0:4d9:639:e9dc with SMTP id d75a77b69052e-4e576b4284fmr2888991cf.84.1759428672621;
        Thu, 02 Oct 2025 11:11:12 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777979704csm239935585a.50.2025.10.02.11.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 11:11:12 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <db316092-85c0-4cb6-9f85-5528a0bb7d65@redhat.com>
Date: Thu, 2 Oct 2025 14:11:10 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Tiffany Yang <ynaffit@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
References: <20251002052215.1433055-1-kuniyu@google.com>
 <5k5g5hlc4pz4cafreojc5qtmp364ev3zxkmahwk4yx7c25fm67@gdxsaj5mwy2j>
Content-Language: en-US
In-Reply-To: <5k5g5hlc4pz4cafreojc5qtmp364ev3zxkmahwk4yx7c25fm67@gdxsaj5mwy2j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/2/25 4:28 AM, Michal Koutný wrote:
> Hello.
>
> Thanks for looking into this Kuniyuki.
>
> On Thu, Oct 02, 2025 at 05:22:07AM +0000, Kuniyuki Iwashima <kuniyu@google.com> wrote:
>> The writer side is under spin_lock_irq(), but the section is still
>> preemptible with CONFIG_PREEMPT_RT=y.
> I see similar construction in other places, e.g.
> 	mems_allowed_seq in set_mems_allowed
> 	period_seqcount in ioc_start_period
> 	pidmap_lock_seq in alloc_pid/pidfs_add_pid
> (where their outer lock becomes preemptible on PREEMPT_RT.)
>
>> Let's wrap the section with preempt_{disable,enable}_nested().
> Is it better to wrap them all (for CONFIG_PREEMPT_RT=y) or should they
> become seqlock_t on CONFIG_PREEMPT_RT=y?

Changing it to seqlock_t will introduce another lock that need to be 
handled. Alternatively, we can use seqcount_spinlock_t for freeze_seq 
for the current case and associate css_set_lock with the sequence count 
in seqcount_spinlock_init(). That should properly handle the case for 
PREEMPT_RT kernel.

Cheers,
Longman


