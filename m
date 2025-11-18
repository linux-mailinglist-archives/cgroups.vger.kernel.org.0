Return-Path: <cgroups+bounces-12068-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A291C6AF64
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 18:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D202D2BBBF
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 17:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075302367BA;
	Tue, 18 Nov 2025 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mqc95FiG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j11W5T6H"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53E36C0B4
	for <cgroups@vger.kernel.org>; Tue, 18 Nov 2025 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763486968; cv=none; b=Sh2hNRJT7wBDgVOrQTEH61i1719zDqAlHMgQaVnxNB4ApRCL8XeBhQHW2D393xGx6rbX6ejc1qws6EcSeNRLzfw71kFgluFo9za6SwrdXPhF83VeTQkPcSpXHQSCIs4HYkkXN25I1GPktzG3dL4YmgwsYaW2fOLzCy53k03oQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763486968; c=relaxed/simple;
	bh=YKmhI7o+scdJHKMJ/f+RpwSryCRDaqT3/AhmGntMDLo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UiWKmNwjufykRD7WlYiRod9vlDc8LG02AKYEB2qxWWAfBbxVGzZ1+p1WMyGCBhcEEZcx42aqUhlzgEYTzH5R9z/wqrRlgl4DmUmLS/XWff0z9LtJT5NtxTbQMpV9uXNvoatIngKB088ByqVljQAjJR7sDXdEsaS7X/+lCnmJRuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mqc95FiG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j11W5T6H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763486965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVa5BnVZ3EHTJgHrN94BQfuYBWPdJMUr1ZPRfgRQjkU=;
	b=Mqc95FiG53RcQy1DxqWHuX0Y+JDeeLYMVeWH5j7f3QRDyeSL3O13mk0NoA8Zm662aYKIEe
	g73S5YXME4AbN71SOMiIFb9oCqP5m3tqxUaPFbElIAjT3fU/3r9c8enO496/pg5acHAANc
	GPGxsh+wKTHpZKImGHLRs7PErJGgUSc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-8j8hnDwHM_CpyjIZfB_ZHQ-1; Tue, 18 Nov 2025 12:29:24 -0500
X-MC-Unique: 8j8hnDwHM_CpyjIZfB_ZHQ-1
X-Mimecast-MFC-AGG-ID: 8j8hnDwHM_CpyjIZfB_ZHQ_1763486964
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b245c49d0cso669121685a.3
        for <cgroups@vger.kernel.org>; Tue, 18 Nov 2025 09:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763486964; x=1764091764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yVa5BnVZ3EHTJgHrN94BQfuYBWPdJMUr1ZPRfgRQjkU=;
        b=j11W5T6H+3cf578loD/lq27k/29I/kaCuIZxfxvVx5Pz3O3Vq9BVO6TvXXjf6TngWK
         WskqGApWkMM73naDhrjoNG9JVu1u8DnZcL/defBSJck8vKfnW0oDdc7sh5MqXa/kwYO1
         M9jitASRUOXVKRop+0DvPY4TLZNjhLXeaNXmeT3R1/0DwEQUnPyG+BGd7q8JNUCXe4ef
         9NOqGbcX6AYse+UxqOVHZhniFiKlWkORnPT3Zg0DTZkh2B5yQes+mL0XeNNbcOetokEW
         uvgrv/uFQ29Zd3kzpyDMa8UBcSVaoqo3JZC9bZxrREypSzpkcDmVC+rPMxGkbCnSnRxJ
         roDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763486964; x=1764091764;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVa5BnVZ3EHTJgHrN94BQfuYBWPdJMUr1ZPRfgRQjkU=;
        b=xFT62r5fA8bQoqn8yutOCOZJvE/vkVqwAweni4zkpGLDUclQr1RqM6jAhrKDuJSHv5
         d0e9ABlB/LGJN+iT3IicWc/UQUYCtV+EgjYVKn4Tuk8Aak8npAqKy52WjajPiqC/+DZK
         +F+qNwO7kCB/dWYeJBe/g20cLiKsNEcEVfOR5BEeuK5dQtBwTLtaaH0tvQTLiy7+uoAo
         PHBp70vgu+6vk18P2n9go24dmkpTvTfHRj4LOZMMBDNfXq4nTKr5VlE9+QqSTlA1yMim
         nTIACf7HftqFIy+k0fcjf6m8ZXM3cwdsZK6SBBIJBDZZtuxKDvgKNSAGaBs1JxcnbC3H
         lxTA==
X-Forwarded-Encrypted: i=1; AJvYcCUeSJfIx79d0MdyLGBE9pOsY0tORs7ioM1UAl8AlRjuY6zmALNKV3LsfRqVqeZazdUfWb0+e27J@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGtWz5p+liIf+b91WyaaskKGTWgxjNoL7lWZmWrvTp5AiO6eD
	V7Xa+fqKycM+BzYRBUbXC+VkRMGTPQ6oZAx0zt5RBluqutVA6vVjsIf6iebjo97M22PGZb3ZtQb
	lpXP1rJ28Xe92akjAM1sOSflnpsIX+LqqTEUo7vIOVH+D2h+VUOt4qrYLGz4=
X-Gm-Gg: ASbGncvlb2SBinppa+WTLP8XXhFgsJpHy6E8m0y/1lM+g+mUDqs5mOn86hRFJB8fB95
	oBzzs3FiZ1NCnl/6B7cvBNUw/ZDfR0lecprqTF6ADBjbd5tBMJRCChCrgyNqB4BCQJnJtsaiMS7
	dbPK4s8AaFKbJ3xbhVOFSeP+3e1uji/T8CXla7iZ8foBrm2YxWVk8Mqro6cre+viHCYMTw+V8hh
	PwMxGc+X5v89xVis+D49LaAtFv7lzJi+7GnnZusRoRSjURh8KaAnULqKpSxybWhV9Ubfnc0wq2I
	5F7VlvA8coLRFzM+Mve1FYNoa9Mam7Ae/jXjUjEYYMOJKQGKdxgdttrJYcGfspS1bcIBUMFxA6e
	izWMJuDY9cyLZrse5wW6h1uOqTZKnjByxFVJFdBaCgyBe7Q==
X-Received: by 2002:a05:620a:c45:b0:8b2:598d:6e66 with SMTP id af79cd13be357-8b2c315f85fmr2312976485a.22.1763486964076;
        Tue, 18 Nov 2025 09:29:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8J/SUZRQqMqaNw9a9uz+hjUMaFAfe4/6AOMNOMDjsWDqqDNlvwnorp8G9NpYSW9J2X8ZJ1A==
X-Received: by 2002:a05:620a:c45:b0:8b2:598d:6e66 with SMTP id af79cd13be357-8b2c315f85fmr2312973385a.22.1763486963652;
        Tue, 18 Nov 2025 09:29:23 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2dec1a53csm772737785a.25.2025.11.18.09.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 09:29:23 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <13bfb066-dc00-43a7-a84b-e70df62173bd@redhat.com>
Date: Tue, 18 Nov 2025 12:29:22 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] genirq: Fix IRQ threads affinity VS cpuset isolated
 partitions
To: Thomas Gleixner <tglx@linutronix.de>, Waiman Long <llong@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Marco Crivellari <marco.crivellari@suse.com>, cgroups@vger.kernel.org
References: <20251118143052.68778-1-frederic@kernel.org>
 <20251118143052.68778-2-frederic@kernel.org>
 <f7794481-5a43-478e-99f2-ae6c45eccaa9@redhat.com> <87h5urmez6.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87h5urmez6.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/18/25 12:23 PM, Thomas Gleixner wrote:
> On Tue, Nov 18 2025 at 11:27, Waiman Long wrote:
>>> +static inline void irq_thread_set_affinity(struct task_struct *t,
>>> +					   struct irq_desc *desc)
>>> +{
>>> +	kthread_bind_mask(t, irq_data_get_effective_affinity_mask(&desc->irq_data));
>>> +}
>> According to irq_thread_check_affinity(), accessing the cpumask returned
>> from irq_data_get_effective_affinity_mask(&desc->irq_data) requires
>> taking desc->lock to ensure its stability. Do we need something similar
>> here? Other than that, it looks good to me.
> That's during interrupt setup so it should be stable (famous last words)

Thanks for the clarification. We should probably add a comment to 
mention that.

Cheers,
Longman


