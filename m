Return-Path: <cgroups+bounces-11933-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32912C58DE8
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 17:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A3B95628C5
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5370359704;
	Thu, 13 Nov 2025 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="et/RNcfO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlCiSuLk"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52DE3596FF
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051748; cv=none; b=TYgTzVWQ1DEVhpq33/WwqECN5IbKh3eNh3n1Vncc31zeQpqfiApnfrpU3n0ViKRmBnJIKVSIFMRhS8VUdIKxcDpphSjFWmKLJHvKWUDPM4awhQndC5gCI+RXr98ayj3PC3Op0A5mt5htqKzBpjytjw7quRmaAi+4pKeJn7Cer4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051748; c=relaxed/simple;
	bh=eji/SSOdXF8gy4QaZiEYeuMQSUOPDcJ453Mxlf4rTC0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F0WioqU1tkwBco0arZ5UUrzfNLvggbndP/0Skwd4SQDJdXqIK4LU1xDGS/nJoEAIfnGvBXtxTmS0w0ugApFSVQ+c+zxfpYSaZ4uGyIFsl8r6/Kqp5jbIKLP9bLQ96IjHEdHUL3KlX6rfXf871kFQ1DeOxrPOUqXe+/fpTwKOaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=et/RNcfO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlCiSuLk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763051745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OT3IZeq6xh+hTw96O3g7ZfztMQ4cq03lu+gFuSu+QgM=;
	b=et/RNcfO2AlURiHs5hGIgcgc6B1Ft+XLu528/ApNORm/OpwhUSG5bLupkVT69YcyxgOE17
	THN5356SBYcvckbPnW1IXMjjdKOMaPQpWQUsvNgAre7VAy4gvSUCDIWUuYdhJI6pwsw8rI
	rVj+iAepvWbsaW7d0UDnD6dBAz7hnW8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-4jFP7IFwPt2Gh6QLTfX2ow-1; Thu, 13 Nov 2025 11:35:44 -0500
X-MC-Unique: 4jFP7IFwPt2Gh6QLTfX2ow-1
X-Mimecast-MFC-AGG-ID: 4jFP7IFwPt2Gh6QLTfX2ow_1763051744
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed5f5a2948so24831981cf.2
        for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 08:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763051744; x=1763656544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OT3IZeq6xh+hTw96O3g7ZfztMQ4cq03lu+gFuSu+QgM=;
        b=OlCiSuLkZ4GA70g7C0pMk6Y3wzClq5qH3aKPjDhDnvn7O/oYQoccEUEwkm62ngc64e
         RIJeXG68jBmS0vt1r1Xa11lUrdL8SwiSp6JJidK52qRfbY/3Bd1Ra5s6kCAGl+ztCE1I
         +UqOxEZDpsWCbVdkwGksVsANdQ6Hy1mIwN8lm1hFfGZdeEp5I7IfyfNJK3l3JsNW22QX
         nICwwmTlc1wNvN2H4c7Bx26tx3cgVwQUL5alfZQVTS/TX+6Pnw0hK2qV8vLLGoVXbxut
         npNVKNEK/ci3Tn/iFegM9r2f+dG9EVvFb1m0BJvZMhN3vCNENsYvI9fhVWH55FVYSrmx
         V/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051744; x=1763656544;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OT3IZeq6xh+hTw96O3g7ZfztMQ4cq03lu+gFuSu+QgM=;
        b=FHWgM1J+BdHUWsocL13YZGS0VHUBS8Gkz5sZcoLjp/7TJyOja+FmkTV1mO6flcZTME
         lD3xLT2RWy0QsO7+rqqOStTyd4ychWo9Y7hb3xf+iMctG5gSPeBM020afnPXFj+xplND
         9HANMNjH6Qv5kN0OldwPT2vAu4QHpUTD6/kz7OD9r65JNEwf5rZFqfY05XifWQSgL4tU
         4yGBGA0NUBqaFVHxl/HgVhtya6rBwH5EFVC7n+sr+8DEzcnJKu4/b3Zsk2wGESh16BpA
         z/eW4rk9+exDMYO0MU9L61qsGIibg47lZN05/J6qTqaKSQccSWnx/ZbClYM0EgBVBUM9
         l0oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJSyPhJxZB92xckrCdyhHP77+3iIai7yO3AW3bgQPy76vT/72H0d/5+jxMQd+D8PPmg9N00xNh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo1K/y/Rg51pfC+SDswm4nwqO+78VNA7WDcJ0WCs6Ra+U7Ums2
	Y0BWbvYPgYjFUpaWbAmRTwWa3VyfRSh3djzULfJuUvRGfbk36mBj9qCKw48grPwt6oft2oAO8mx
	UBf2n11wim5FQ/0Jw7gXcOVDCH++wU7XdP/DLzfqG9ErhboFOazjNGuYmMYQ=
X-Gm-Gg: ASbGncsEFwOAngBK1TD4WWkzIoMQyBiXdjnCRATUu7pNHydB7ajKa0wdkCeWpVDzR+B
	BZZXKUXz2/Mr1CTy8uNIjIFvT3qKK4S2L7bwyAmz6F/TUNbyZxAGcbZCnwHuOYzRXESnPCxExvM
	xLPRegw+7QDc11UdahuWmAlICDWXMYP94KptXpsNvovYccpkDKT0UfopXbAcHpywPFg1MaXErYL
	wipkPDdbU3c6vM3sa1t95nTBMcH5MnBW7RZ9O0bZYUGVF9W46/r7GwFk1HPyxib5+uYPx5bCBSg
	Yb8JNq7alxasvxgcxhdfTnA7mQ4W38tFPyLbXuAOzQcuEiSMXyz0YIyKlHCQu74tyOEVRHAuHh2
	h5gdGWBAiq37ld6Y4eiQSOjy1Rvr+lFQkdvtKFU03XTZYPQ==
X-Received: by 2002:ac8:5a8e:0:b0:4eb:a82b:bc2e with SMTP id d75a77b69052e-4edf211b77amr3265371cf.58.1763051743724;
        Thu, 13 Nov 2025 08:35:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQFpx7ltJXzQEzs/abe+1AxOqVQWZvjF0Ua76N5ThbYdIc+i95x5FX7vaZTJCOKsnBikyGYQ==
X-Received: by 2002:ac8:5a8e:0:b0:4eb:a82b:bc2e with SMTP id d75a77b69052e-4edf211b77amr3264811cf.58.1763051743138;
        Thu, 13 Nov 2025 08:35:43 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede87eed39sm14709671cf.24.2025.11.13.08.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 08:35:42 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <da750417-948c-4968-bdb3-9fd267fb9c10@redhat.com>
Date: Thu, 13 Nov 2025 11:35:41 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH] cgroup/cpuset: Make callback_lock a
 raw_spinlock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Chen Ridong <chenridong@huawei.com>,
 Pingfan Liu <piliu@redhat.com>, Juri Lelli <juri.lelli@redhat.com>
References: <20251112035759.1162541-1-longman@redhat.com>
 <20251112085124.O5dlZ8Og@linutronix.de>
 <318f1024-ba7a-4d88-aac5-af9040c31021@redhat.com>
 <20251113075356.Ix4N-p8X@linutronix.de>
Content-Language: en-US
In-Reply-To: <20251113075356.Ix4N-p8X@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/25 2:53 AM, Sebastian Andrzej Siewior wrote:
> On 2025-11-12 13:21:12 [-0500], Waiman Long wrote:
>> On 11/12/25 3:51 AM, Sebastian Andrzej Siewior wrote:
>>> On 2025-11-11 22:57:59 [-0500], Waiman Long wrote:
>>>> The callback_lock is a spinlock_t which is acquired either to read
>>>> a stable set of cpu or node masks or to modify those masks when
>>>> cpuset_mutex is also acquired. Sometime it may need to go up the
>>>> cgroup hierarchy while holding the lock to find the right set of masks
>>>> to use. Assuming that the depth of the cgroup hierarch is finite and
>>>> typically small, the lock hold time should be limited.
>>> We can't assume that, can we?
>> We can theoretically create a cgroup hierarchy with many levels, but no sane
>> users will actually do that. If this is a concern to you, I can certainly
>> drop this patch.
> Someone will think this is sane and will wonder. We usually don't impose
> limits but make sure things are preemptible so it does not matter.
>
>>>> Some externally callable cpuset APIs like cpuset_cpus_allowed() and
>>> cpuset_cpus_allowed() has three callers in kernel/sched/ and all use
>>> GFP_KERNEL shortly before invoking the function in question.
>> The current callers of these APIs are fine. What I am talking is about new
>> callers that may want to call them when holding a raw_spinlock_t.
> No, please don't proactive do these changes like this which are not
> fixes because something was/ is broken.

I posted this patch as a response to my review of Pingfan Liu's deadline 
scheduler patch as it need to call cpuset_cpus_allowed() to get a proper 
cpumask. However, there is an alternative way to solve this problem, so 
I am dropping this patch now. In the future, if there is a better use 
case that needs this change, I will push this patch again.

Thanks,
Longman


