Return-Path: <cgroups+bounces-10053-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3DDB55ABF
	for <lists+cgroups@lfdr.de>; Sat, 13 Sep 2025 02:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196461C82240
	for <lists+cgroups@lfdr.de>; Sat, 13 Sep 2025 00:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528107E105;
	Sat, 13 Sep 2025 00:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8ABFCOY"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8A22BAF7
	for <cgroups@vger.kernel.org>; Sat, 13 Sep 2025 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723621; cv=none; b=gxgdywdzmSOjcY9/zSRQ2FgMERbQTZPMrePBKInj8N1eAHLLD4nDQTmHsNxgVUde3KIKfbZ1I+P+SeQ1C2BzWUuzacQOpfJauifMYRizvfJ4X+oeasCq1/UvuXvC0Y0r/kbxh2BVneB5TB/MBXy8DX7mCE0HArfWWKoP3tFYrT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723621; c=relaxed/simple;
	bh=6ixjMQGo+mF9rxxhZunX9VzR5bs0JXrtOuI72NkTM98=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kxXILtg0SS/xOjKv9BUeJ2OJR/jchAtkway9ZDB8FettvS2EjiURwJfER6MIDCfHLOkppiZ3xeWrsmmhTrbFRlU+Sp1x6x8/Yr24M4ZXYqbuDC5P9WoQykjjXT/J2F/OZzsLwauqEstlfHLlfE5NYL1j/c2uSj847m9zWOyTj7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8ABFCOY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757723617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncBfGy8EE17qYCVshxa8cc5ygoQQollWUOgPghVnN+8=;
	b=Y8ABFCOYGvmtliMGHQf+AXFx8kh07GGSmtGIbQ78d+T2Lcis3vOb2XAhVxtev7SyJURlCS
	JfZw1CRRwO8rpbKf/bLP1H/8GNRtYJrpfmGJ4oNvQVtlo3sjz4JAEvUki/mKIGVDR9jLDO
	rJeVuhvLxEyxyR/fniR/S8i1vfy6Lys=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-PdqhIPvlP7W8HLVNKlZACQ-1; Fri, 12 Sep 2025 20:33:35 -0400
X-MC-Unique: PdqhIPvlP7W8HLVNKlZACQ-1
X-Mimecast-MFC-AGG-ID: PdqhIPvlP7W8HLVNKlZACQ_1757723614
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f75c17a3so62885061cf.3
        for <cgroups@vger.kernel.org>; Fri, 12 Sep 2025 17:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757723614; x=1758328414;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncBfGy8EE17qYCVshxa8cc5ygoQQollWUOgPghVnN+8=;
        b=DYvmKehKiybVGWUGyTHRLnzh6e1HgYKv2il8lzYbW8+Ca/3GNppbSPgoDXRFAiOCAn
         SJkebZPr09TnNsLlpgRGLdG5hM+6EvvpqS1129N4cbrHZ9YN9DuCV6FKb3/wNVvJgHs5
         t1twPtDGhbJQ7PSV5hKG8F7Bg+ARokutZQDxbGbJpvGwkK/WsfM7P+4nVlqYEwKJpF7Q
         uCdSK1o3pg1N28xqo7viU8D8P639DYR5eaTHoN/dOg5TFZ/3ovpMWup6Vx2pD0ZKMJEf
         wgcujym8u4TTnJUg0gYZ28r6VrruzEfVGBFzkfBy7XZOu1JX/ER6sA6cBV/DuBehhW1N
         5klQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqkEZ5snA4+xYjiRJ7JUv7QKozfqeRZpICpiwF6mfPWmeDxbtfveoTjlFmUxBD5ZyBrObYxoEJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxmG4t3MgQ8k5WASavDoHHeSfjwOjbqW/+yQVkYaPFVWwWcC4h/
	D/jx86B6IToF7rbM7bl1omg3cVPv0dHFWsKNDSK2fYS56sc4rGuz/qz0BTng/2ufs6AthktpRUM
	QfAzke/iR/YxqpkAcoSYQssdn4EE6IXN5ctGcycz1+Vm1SPzKB2bZCraYlO0=
X-Gm-Gg: ASbGnctzMwmcbtKtlEQaaXOqFnxvqsE0R3SNicburbrn9afGhQdYKfJ3YM88/PiBKZN
	WzH/DxloPc/zBgRBKAQ5Oehzp9VRYKLgC/oSdBEbZZFVPrF04HLeodl8l0e/cji19WlTTh3ddVM
	P69kRRD7d37nGtvOi4fgcB2O4l/a4JEK/Eofn1HPudO5XcByes89dpr8EcqxLGiD7OjtKbVjIkP
	VRmBOoyyrxZEq6cG3Dgy/vn2JM+N2Qt3wO5AQE6H+O8kEWTBa4gLyInGCvBweK0yQlmyNmP2DmH
	oR+EVakC4Yy5s7tO3gjNWPY9x0w3K4vISuI38whgEvETUSwf2V8ocjTcIOpBhEeacXZieKFH55G
	L3WI3jOy5tw==
X-Received: by 2002:a05:622a:1a05:b0:4b6:2f52:5342 with SMTP id d75a77b69052e-4b77d1ab3a1mr68076311cf.79.1757723614310;
        Fri, 12 Sep 2025 17:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRq8wbBNQnbSCZtG/tvewoa9dvMcBJkb7MXthP0yviRVZ6G/ctSPGgxUCMnelFEMNwo4BLAw==
X-Received: by 2002:a05:622a:1a05:b0:4b6:2f52:5342 with SMTP id d75a77b69052e-4b77d1ab3a1mr68076091cf.79.1757723613947;
        Fri, 12 Sep 2025 17:33:33 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639b99de1sm31462791cf.8.2025.09.12.17.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:33:33 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9d06c0d5-e20c-4069-adca-68a2c4cf6f4f@redhat.com>
Date: Fri, 12 Sep 2025 20:33:31 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock
 critical sections
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <llong@redhat.com>
Cc: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-nfs@vger.kernel.org, linux-aio@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org,
 cgroups@vger.kernel.org, pengdonglin <pengdonglin@xiaomi.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
 <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
 <20250912213531.7-YeRBeD@linutronix.de>
Content-Language: en-US
In-Reply-To: <20250912213531.7-YeRBeD@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 5:35 PM, Sebastian Andrzej Siewior wrote:
> On 2025-09-12 17:13:09 [-0400], Waiman Long wrote:
>> On 9/12/25 2:50 AM, pengdonglin wrote:
>>> From: pengdonglin <pengdonglin@xiaomi.com>
>>>
>>> When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations implicitly
>>> disable preemption, which provides RCU read-side protection. When
>>> CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
>>> manage RCU read-side critical sections.
>> I have some doubt about your claim that disabling preemption provides RCU
>> read-side protection. It is true for some flavors but probably not all. I do
>> know that disabling interrupt will provide RCU read-side protection. So for
>> spin_lock_irq*() calls, that is valid. I am not sure about spin_lock_bh(),
>> maybe it applies there too. we need some RCU people to confirm.
> The claim is valid since Paul merged the three flavours we had. Before
> that preempt_disable() (and disabling irqs) would match
> rcu_read_lock_sched(). rcu_read_lock() and rcu_read_lock_bh() were
> different in terms of grace period and clean up.
> So _now_ we could remove it if it makes things easier.

Thanks for the clarification.

In this case, I think the patch description should mention the commit 
that unify the 3 RCU flavors to make sure that this patch won't be 
accidentally backport'ed to an older kernel without the necessary 
prerequisite commit(s).

Cheers,
Longman


