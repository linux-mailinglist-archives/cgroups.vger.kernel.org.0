Return-Path: <cgroups+bounces-11834-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D75BDC4FB7C
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 21:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9330E18C0013
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 20:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997CB2E62A6;
	Tue, 11 Nov 2025 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jss3F8/I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwQicVeu"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE933D6D3
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762893365; cv=none; b=gh2yQTfAf4/3M1NYY5b4nWvezp5ZyZoDfzDzLQ8Udi4y7UaWevciYVPBFCNJQihu1QjBWbXmc2mXPZONQ24UXdpyLbiUu5SVuXGDkFQ9d5o1Vhsgg2Bvg5tKfigSWsuJIlXfW8oXvEgfjr7SfwIa82hXBl0lBLFqjB/brOPesGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762893365; c=relaxed/simple;
	bh=/sctv5rhusyXEffbkQLx2PoylbyIn3anAeqxSkeXO/Y=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lf8MWiZBpdNXG4zbb/hmbPzAyPl4MaylQkdf+HG5lf6tU/C/txX6SNY/UHn8keQV/2+eTizDXK3BoPtGPek1r66t78cBgB8ibk0nAVZ8BFYJCwJie1BSClX6RZhcy8uyKqo1hKZ07awZh/f0cXcyIp2yXz31FaZvhZcSZyddk3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jss3F8/I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwQicVeu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762893361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmCjT8+RKuIKK6LhjKXvotcpZamLjJoCMEYtCkqqZWc=;
	b=Jss3F8/Igg58Vs4jhhg18AgLCQsajTAZIaxZCX7VOa34MvAA8vsUZ8a5437+RpxhCxCIWx
	QpO8YVLdT79Llp5Lvm4dEZH2EWW7F10VOWGNTHm6Ji8u0dIvatKLZFrkqlQ4n51xiFzcMR
	78QiylG6LZc6uCYPt9r+wg2xIqtvc7o=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-Zw0IffhfPW28BucNBTAazA-1; Tue, 11 Nov 2025 15:36:00 -0500
X-MC-Unique: Zw0IffhfPW28BucNBTAazA-1
X-Mimecast-MFC-AGG-ID: Zw0IffhfPW28BucNBTAazA_1762893359
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edae6297a2so5038871cf.3
        for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 12:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762893359; x=1763498159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YmCjT8+RKuIKK6LhjKXvotcpZamLjJoCMEYtCkqqZWc=;
        b=iwQicVeuEnENl3z+ZPSeCkoposb7Er0/W5FtAMx9WkOIWA97hUaAI4gD9n7UVFScU/
         8KBxVgpFiHEuGITV3GsBInvqscnfEgy01+QPlFBzWBiJkO2e+sYvjE1I86+7QvdQUGn/
         oUwGO1oLkCTNqhhpbiaIH8VL7LLLfyafGV/MhMcTqxYQP+s7rWC8+4AJSwT18LNyvtLb
         ND7KtDrObdHM9tRbXuiQYUVqKjN8pK+57RXzidOKigpLFfwtCqhQz1Mp7ndV2fKQMtQd
         /rcKxt+phQS+CwS1CNb6sqcvmUhe4Ga/aHvZJa9ntfpeqceMXWc7yol8FHPEFYHKogLM
         YkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762893359; x=1763498159;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmCjT8+RKuIKK6LhjKXvotcpZamLjJoCMEYtCkqqZWc=;
        b=RGVvLqXhmBIDKeU7SP23gkhR2Vau/dHqxqbZC51sMQ8fKKRMK5KGwbuOKdFhk9kT5w
         1lnLbFrkNpUiPFb9y3seoYD2feT13x1SLNusdaj7C9YmPwrF81+8IPnNYtgFvdHts86T
         czcrfFaMNsSr0d/vUEoP5fTCxLFbIfkIXfdtYjTX8xLAR9iAP9+MdjfUJN5Fu6StAt0Y
         v/ekYdk+cnyuqKYcSJbBsZkNtAoYoSZWe+uhFmYAw+nSeR07G57hsqh+0cGkbicC4VG7
         VzUsfKbEW+SwXStMB61Xf/q35lwpR97nYj8mh6Htengkyemk75pVU80pVf2gictDINCs
         fpMg==
X-Forwarded-Encrypted: i=1; AJvYcCWRD1QR0BXZimu7oGjt186hT+x5Mdc9gmyOIL5/OC6U9rKjMDENvF6WF52I/1zLlq9ntf9BespH@vger.kernel.org
X-Gm-Message-State: AOJu0YzPsEiI6fzsOewH5kR9wOoK+JivJmIR2gJNALjozM9zopRiqGgs
	2f4Ru172WWoCr18vs1XRYXpkDf9v8/+X2rjLorV/z3Uk53NQP8oMDw27zLHHeTJRU2yZ/M0L+cu
	oIjSKy8cT19+NukY4jPzTZyF+hd1SzSn8B7jPWF1Gcd0f9edAIobj8KHm6AM=
X-Gm-Gg: ASbGncufMDllNu/CKEdtF+nuwp3GnwRj+0qA6jrwTSLo1IhYXg3YEX+wH+8EVvraWr1
	4DDtzHdfD6wNXMDeWWcbbF3X4ydPt4ZBLYi6mSAJdUNKXY2FegC3/7tJCznTwPrsB3dl9fguXIq
	6juI/ky9r7HIeMCUR075w479Y+nCVom6Edmkj+zTtLNpqcjnT040mBocKHK+HpSSRgHgquGKER8
	A5fctqo22QWTb1nuEDonYZ4Z5f3UIcxcEW6T8+LFO+CuL3SGQdwzsaAd4YL57c9CUOgA5TDta0l
	L49wDECL13WclDa/T3T8PNPHxr48iF7KyhkRDoY/Somr/ZHo5qLGl5GoXDTilQ3gYb6nT8xykBq
	8HLGSO6sv0KE8zASvVtMAsjrYJ3JInvbKP/ngFxKRGdmD4Q==
X-Received: by 2002:a05:622a:20a:b0:4ed:6746:5c3d with SMTP id d75a77b69052e-4eddbc6ab24mr10773991cf.16.1762893359497;
        Tue, 11 Nov 2025 12:35:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBXBwITu8SOdi23m/v1WrAfxj+dAXOJmYX5gcaOHvQFNT+Gbkj5jipIUCqTWyw9/fEMZFKMA==
X-Received: by 2002:a05:622a:20a:b0:4ed:6746:5c3d with SMTP id d75a77b69052e-4eddbc6ab24mr10773611cf.16.1762893359117;
        Tue, 11 Nov 2025 12:35:59 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a85ede1sm51844285a.19.2025.11.11.12.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:35:58 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a4e61aa0-5c1f-490e-9cae-5e478ba809ee@redhat.com>
Date: Tue, 11 Nov 2025 15:35:57 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] cpuset: Treat tasks in attaching process as
 populated
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Waiman Long <llong@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251111132632.950430-1-chenridong@huaweicloud.com>
 <dpo6yfx7tb6b3vgayxnqgxwighrl7ds6teaatii5us2a6dqmnw@ioipae3evzo4>
 <fed9367d-19bd-4df0-b59d-8cb5a624ef34@redhat.com>
 <sebxxc2px767l447xr7cmkvlsewvdiazp7ksee3u2hlqaka522@egghgtj4oowf>
Content-Language: en-US
In-Reply-To: <sebxxc2px767l447xr7cmkvlsewvdiazp7ksee3u2hlqaka522@egghgtj4oowf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/25 2:25 PM, Michal Koutný wrote:
> On Tue, Nov 11, 2025 at 10:16:33AM -0500, Waiman Long <llong@redhat.com> wrote:
>> For internal helper like this one, we may not really need that as
>> almost all the code in cpuset.c are within either a cpuset_mutex or
>> callback_lock critical sections. So I am fine with or without it.
> OK, cpuset_mutex and callback_lock are close but cgroup_is_populated()
> that caught my eye would also need cgroup_mutex otherwise "the result
> can only be used as a hint" (quote from cgroup.h).
>
> Or is it safe to assume that cpuset_mutex inside cpuset_attach() is
> sufficient to always (incl. exits) ensure stability of
> cgroup_is_populated() result?
>
> Anyway, I'd find some clarifications in the commit message or the
> surrounding code about this helpful. (Judgment call, whether with a
> lockdep macro. My opinion is -- why not.)

For attach_in_progress, it is protected by the cpuset_mutex. So it may 
make sense to add a lockdep_assert_held() for that.

You are right that there are problems WRT the stability of 
cgroup_is_populated() value.

I think "cgrp->nr_populated_csets + cs->attach_in_progress" should be 
almost stable for the cgroup itself with cpuset_mutex, but there can be 
a small timing window after cpuset_attach(), but before the stat is 
updated where the sum is 0, but there are actually tasks in the cgroup.

For "cgrp->nr_populated_domain_children + 
cgrp->nr_populated_threaded_children", it also has the problem that the 
sum can be 0 but there are attach_in_progress set in one or more of the 
child cgroups. So even with this patch, we can't guarantee 100% that 
there can be no task in the partition even if it has empty 
effective_cpus. It is only a problem for nested local partitions though 
as remote partitions are not allowed to exhaust all the CPUs from root 
cgroup.

We should probably document that limitation to warn users if they try to 
create nested local partitions where the parent partition root of the 
child partitions has empty effective_cpus.

Cheers,
Longman




