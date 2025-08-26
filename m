Return-Path: <cgroups+bounces-9428-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84968B36CEC
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 17:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97735856B4
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE263568E8;
	Tue, 26 Aug 2025 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZJB+zO5"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DE33568E0
	for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219424; cv=none; b=K8/Gbk8b2VRGKfiH3KYDkYsGogtdov5l/JlLoxUL3yKgXgJe9yAyBgL8d147CcuygNjtR99UXVPrmAQj8kVz23ICAFIxkjemYZrXAAO3WSe39u0phTO1lcX9uyfcbzDktuld6a4CQ+WDrFjfUd7E7Z9jwsx3m+oU2siAe+IUVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219424; c=relaxed/simple;
	bh=5xvA4A4sgKS9ictVP+tnhYzYMcbVWmgS6Vw/z+3/2nI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nrM3bQszvcZ7KRRr0toG9eyqcqCJeJqqvh48QhSywUBezuqZgJaKAgs8KmNJNKGEZc0ncHJN3UY+X2IfWzxlgZROVOEQAlnW0yfvFM4vaZRGiVdMPbJ9V3guCkPJhY/z+N622jt+eSNxJ3zxhHGQ+sqqcrRsJAhGSSvM4RCzFp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZJB+zO5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756219421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HkBjaNU+NpnDK0GDK6clzm40xuPZBAWbvCjCCSMs5H0=;
	b=ZZJB+zO5ayexC8sqSwtHCNcC1fUTPtlZsxcT2CUhc3VuFThbEGzmF9xpq1ZWR0pys+lyoP
	ZXeDZoWt3TxKERxvoDIKYK0M5zcarj8jN8axxVc4GVwdPaBRJQJhOm9mSkHki8j3HmTjQS
	2yxYphLX/uE0oGGZTDySHbKfeO+CMO8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-mNGcfHusOTegwNsai7WwmA-1; Tue, 26 Aug 2025 10:43:40 -0400
X-MC-Unique: mNGcfHusOTegwNsai7WwmA-1
X-Mimecast-MFC-AGG-ID: mNGcfHusOTegwNsai7WwmA_1756219420
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-71d603c7e05so83388457b3.1
        for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 07:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756219419; x=1756824219;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HkBjaNU+NpnDK0GDK6clzm40xuPZBAWbvCjCCSMs5H0=;
        b=dfreulXHujTs2AXl5FRlLiBP3b4Ektx4TihCaJnstSWJD2+aLgJ/g+JiuaVJX7dOmK
         r467KDtZec1JfTnalNCyt/NS5s3XxsY51L4vZ5O2Tgmchri5G/nFzUdWhFal/gw2Belv
         XP/wp/swIEObbNszp2sXVoDuBfKySM5rsB8XXKlyXdDp7NDq+dUh5lBHizsArQh7tv3N
         Bpnuy2pUgPnpbKlzgL6Z2Ls2bG/R0eMEM+o/KUX3tlosFVsS30hKJxPbKUzKQ2UjLUKv
         lPacIADdsbnIYp3ML36vTijAAC84gFQQ0tk/HZr1nolmkoPWtgSRrKSmDf5CFLsNPid8
         dR8g==
X-Forwarded-Encrypted: i=1; AJvYcCW2J877NC8ZkHCNj8Pr8nZJLUPJyKH7oGyT/9PH/j+UAfsNPsnCck4x3e2iCisxFSMooP2Pnf0F@vger.kernel.org
X-Gm-Message-State: AOJu0YxoeRC/DO5iEWo71MtUc1wY32KWtkLfApVs/1tQw5SlnX4MF5tr
	iR5J6aLkfBidcDmEap3NkwYoJury2yReD8OsRDLoRI2FOW/n5bsgUGr1f++4kFRrtU1iexyvwib
	oFo+zXKUBuENfgV35wGHUycr+dmi5dgc65Kp9LxkBEFgp8HrXn+EPBRBlDO0=
X-Gm-Gg: ASbGncsuDRjiHmo2KBEKNcrOm2LR5H5cCwnrP5qLYaL0gssjUxSFlgQGhEm3ewwUfMf
	PF9TOGyTHxbZCRLO31XrpFnBGFEYRRLiVp7vnE1OKpQZAmlqPsWuJxKNLCjk3eAAZ70DfLU6egj
	AkMwYvGd/D5Ffehhm7Prtar7M+48Y/zuFWFSzGKUDyCcaeHC0r7Mq1PBbCTB+1CWTWyRYjUmCSn
	C1kLr0Ng/0+/Yu3V1x6/fuYPs7FNbejZEGv32AeprbzAM0R7X0ie42vbKGBVSlWCY/fodzdTJ7r
	rsextvxJERd3ij7jsjOPQgeELwt+mIl0f2zc6an2wQMIk4ZsRCiSWgFaYU0RhiqqUnhizJTkh6z
	MFbxsjSopGA==
X-Received: by 2002:a05:690c:46c7:b0:71f:aedf:62fc with SMTP id 00721157ae682-71fdc2b057amr188985107b3.11.1756219419462;
        Tue, 26 Aug 2025 07:43:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFklRoRi92zFusopF7c5fEu8QmP+NWTlDmpZD6iSMVLh/Me94lbTnvZn4DNh394CUTPBh070w==
X-Received: by 2002:a05:690c:46c7:b0:71f:aedf:62fc with SMTP id 00721157ae682-71fdc2b057amr188984537b3.11.1756219418884;
        Tue, 26 Aug 2025 07:43:38 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18fc8f4sm24672997b3.77.2025.08.26.07.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 07:43:37 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <312f3e07-0eb9-4bdf-b5bd-24c84ef5fcc1@redhat.com>
Date: Tue, 26 Aug 2025 10:43:35 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v5 3/3] cpuset: add helpers for cpus read and
 cpuset_mutex locks
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20250825032352.1703602-1-chenridong@huaweicloud.com>
 <20250825032352.1703602-4-chenridong@huaweicloud.com>
 <luegqrbloxpshm6niwre2ys3onurhttd5i3dudxbh4xzszo6bo@vqqxdtgrxxsm>
Content-Language: en-US
In-Reply-To: <luegqrbloxpshm6niwre2ys3onurhttd5i3dudxbh4xzszo6bo@vqqxdtgrxxsm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/26/25 10:23 AM, Michal Koutný wrote:
> (I wrote this yesterday before merging but I'm still sending it to give
> my opinion ;-))
>
> On Mon, Aug 25, 2025 at 03:23:52AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> cpuset: add helpers for cpus_read_lock and cpuset_mutex locks.
>>
>> Replace repetitive locking patterns with new helpers:
>> - cpuset_full_lock()
>> - cpuset_full_unlock()
> I don't see many precedents elsewhere in the kernel for such naming
> (like _lock and _full_lock()). Wouldn't it be more illustrative to have
> cpuset_read_lock() and cpuset_write_lock()? (As I'm looking at current
> users and your accompanying comments which could be substituted with
> the more conventional naming.)
Good naming is always an issue. Using cpuset_read_lock/cpuset_write_lock 
will be more confusing as the current locking scheme is exclusive.
> (Also if you decide going this direction, please mention commit
> 111cd11bbc548 ("sched/cpuset: Bring back cpuset_mutex") in the message
> so that it doesn't tempt to do further changes.)
>
>
>> This makes the code cleaner and ensures consistent lock ordering.
> Lock guards anyone? (When you're touching this and seeking clean code.)

Yes, I guess we can use lock guards here. You are welcome to send a 
patch to do that.

Cheers,
Longman


>
> Thanks,
> Michal


