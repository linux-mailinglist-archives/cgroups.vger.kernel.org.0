Return-Path: <cgroups+bounces-11899-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB18DC54E3C
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 01:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497953B5215
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 00:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45A23BB40;
	Thu, 13 Nov 2025 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8J9T8qt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDigx1TB"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B3B35CBC1
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992959; cv=none; b=D3nZ5WW64ECEdVoElTTesurb4l3aE5Kvw0/i03ElidlutLihpqzm/UNErzKA2nQ7gKWQCz6lZMJ2nYlerFMTJG8Ac1daC5/YqP6upGskx5CxdM5Qku90g6hZu1VDXhxFL8GsKVaHPYrqv8Oc4A5z0BEaUv34wzBkmi3/M0J5VUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992959; c=relaxed/simple;
	bh=1uQgCaKZj2tGULsNrZstj+l1JrpS7Lk/ujXpQ4zaIXo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ExkaM82RGBY8/iazMXTnO/9unK4OAMslm7Sx4D3fj4BiKkHPGNTAx7n+gDl/yM/7YfNUiRnqL+spxeeteGBVjFfgt4ic4xsi4eorJRRiwJoES6OzqeY/JtOeNasG+3E8YFXMraJ7g3FY1l1OY967BTpaVqqxBW+kJ6mJpU9uViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8J9T8qt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDigx1TB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762992957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1uQgCaKZj2tGULsNrZstj+l1JrpS7Lk/ujXpQ4zaIXo=;
	b=K8J9T8qtJbax0gCgWIG9mQvbfK6XahZZ5NFZrXdy2/4VhjZss9wFV0iYapPZFrA5gTi3ba
	LgcB/gotF9jSAXhXdplWVJu82PDZakAajXdxKlbhYYNMXByRx0QdfaEOk0gkbrRokMlySD
	SH+Oz7zU6qorvA253AUNZhr7MxK/xy0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-1c3jbIKfOH2ui8CGIg0WRA-1; Wed, 12 Nov 2025 19:15:55 -0500
X-MC-Unique: 1c3jbIKfOH2ui8CGIg0WRA-1
X-Mimecast-MFC-AGG-ID: 1c3jbIKfOH2ui8CGIg0WRA_1762992955
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88051c72070so5880066d6.1
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 16:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762992955; x=1763597755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1uQgCaKZj2tGULsNrZstj+l1JrpS7Lk/ujXpQ4zaIXo=;
        b=TDigx1TBZ9R9yU6DyT0vmJ9Wn6x2XlLQp+u6/sOz3+HfVYZblp8hpl5e3/WG3Vpi45
         TzeCxNF/Aj7wCWcs2xfl275nJCPnsVjeQZJA5SmpPC1agJ8Pbjfbsi6y5CZo25pFsuPt
         kBZjz/LJejyWgZgw4iMRlvw0y3ErxE/w0yrHvClHIc8un7TJ/fvC5u/c/Z9+5Jp/Mwm4
         9vpJKLRjbm8oh8HqQ7tlhHAXEtw4tu9XsJqrUaWfw8khScNIr2rqRNvliyOyi+YBJv5f
         ifoDwlu02sBaB9R/SVWkgjP5T3MNgl3zxxxr7hcZ/qW7oPoLAVyXG7hPzW/xrfeR25zG
         YADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762992955; x=1763597755;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1uQgCaKZj2tGULsNrZstj+l1JrpS7Lk/ujXpQ4zaIXo=;
        b=imJPQYMi5Nw9Q0fTyAKyNl9p0dFkmdqCDfxYvZauMobC9jeUGLWcOlFQkzwzKgUPfb
         51sBqzcXxWgMpkQT+GPcm6hNt0n8DzRw4m9nxn/xsMrzAEQ1zfCSJP+r6t0cl0KHL4ZK
         Bh/uXb16M5ArmfmZ+BZUM1QpF2fTPQ3RPlgJNn18RJQQ9nuz0x2ErPFmWlrxY2RtF6U1
         8rIRNhDpTAnZMb0IvCgEpMw7MZ48weoLE1vsvIUYwWl3o4s4IdC5u+8X0jQWdg0WYMMR
         k5E4YynhLnToi4tr9qq0N0LSqsF8Ua15jSQy2b0Imw0tRI8ruD5I9nyhQKfVbK5Ase9V
         INEA==
X-Gm-Message-State: AOJu0YxZWeKe59urpfTJKNx6FdZNUUSmLK5HQNtdJNuWFowqpbkUlddL
	FZHU7JZv6YROIX1itpYswH8iXdqg+sV8cS/dC63TTy0C2jhftfn/80RjY5wxLqwkQU5/R+N8KTJ
	X4nvSKv3TVGtZud2tEUaT4UD9OH6eHC3x/AvDJ+gGmrQzPZbRgWmBPv+DY8E=
X-Gm-Gg: ASbGncu0bek2gosUOQZcp3XF8LP222AEU9vWiBjaR1aBZo/L3KAx20GiHMamU7il40b
	aHfLgUezn9hkr6pNwPt5rp3k6H46x1XNM84/LaZ39FM3LtzKLlLs/51DGXW2Xbh/yxbh4Nr6q5d
	RALbYHfqSUXJzJ6KoQKvZOfqClXE/knvKIYlJIFjlS+NsIsBq0Sm9as1xIlGsH4daCV6weSTLvQ
	0NtXePmeEkJeWzmKYB+4UFtBiMg24rcaZJVPbyHtJPwBcI2WI2quYLAxq8QVBPfJYJHAZ/Y4AMp
	10zExB+k0Tpv9kgo0tFssAf+LhiC4l1CNaHfoCsFMd/c3NSIfJGdGKjONyxyMiRCdYw8f2L2XsO
	BTA50rlCn2sMULkYiojNM0a0EVYUP6ftsmDJZNuaxucuKgA==
X-Received: by 2002:a05:6214:19ec:b0:882:437d:2831 with SMTP id 6a1803df08f44-882719e69c4mr76020676d6.34.1762992955116;
        Wed, 12 Nov 2025 16:15:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ/5laODbRLTtMJ6oFMsJihehWBShOjFK/xe+7cmHL2bQLklCsUIp4BkQW6kgEel0W5IC9fg==
X-Received: by 2002:a05:6214:19ec:b0:882:437d:2831 with SMTP id 6a1803df08f44-882719e69c4mr76020406d6.34.1762992954768;
        Wed, 12 Nov 2025 16:15:54 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828655e55bsm1573796d6.43.2025.11.12.16.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 16:15:54 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <52aa0b5d-cc4c-4072-a590-9944fff4bce0@redhat.com>
Date: Wed, 12 Nov 2025 19:15:53 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 12/22] cpuset: introduce
 local_partition_invalidate()
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-13-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251025064844.495525-13-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/25/25 2:48 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Build on the partition_disable() infrastructure introduced in the previous
> patch to handle local partition invalidation.
>
> The local_partition_invalidate() function factors out the local partition
> invalidation logic from update_parent_effective_cpumask(), which delegates
> to partition_disable() to complete the invalidation process.
>
> Additionally, correct the transition logic in cpuset_hotplug_update_tasks()
> when determining whether to transition an invalid partition root, the check
> should be based on non-empty user_cpus rather than non-empty

"user_xcpus"

Cheers,
Longman


