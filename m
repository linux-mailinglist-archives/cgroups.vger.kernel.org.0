Return-Path: <cgroups+bounces-9489-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 897F2B3C309
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 21:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4971888E09
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 19:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF323C50F;
	Fri, 29 Aug 2025 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIi+gRIn"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8551E1DF2
	for <cgroups@vger.kernel.org>; Fri, 29 Aug 2025 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495780; cv=none; b=KS0A/YpiHHlkTqihvEEM8dX4s92BsxOS7USOoCXVAm1N/hfwA95tzr4qHopFr/is5qFf6o5aMsMqlKypDfd12PvPY/vY8frGTjggCCK9gwha77goXOKtkqjZVpMsWtcN9OZo4LT31NTz/1ug9ctKc2+1BgUG7uTgyUPunGSLv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495780; c=relaxed/simple;
	bh=iKxaVraoESaD2AWDvePT1ytVuxHP6kmx08/S1xYPATE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ubvp6kw+Hx0iFoGG1jewZW29b8P/jgpXaoV1RdhHNrft+ZHR4RlYFwVSfimPu6F1ekR+EQRCeU8jn3gHeosl6j+6KDLCgDlWdQktVZ+phogFIsz+PA74mr3iptaEuw+2dxXf2XP1FPZoYe2KwKAFABXaiKU69yEmS7VRuXK0wAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MIi+gRIn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756495777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ih3Z33J4/DFJic2bWxlA8iLEPjEmBgPscUOkXmjcxCw=;
	b=MIi+gRInK2XObtC/IiVg6gHf9ERXRQWWaMHRQ6uGV0qMLzjbaGsT2/dHwhPztjas7RaVQM
	j3Z9+v70ZagQyfg/m1T7I3jImURaamds2PzosmoMtfpO6APqEVMVVstjj68o9iINRHzbny
	tucb71W1UKqt8DAqYoG0PDYLT6Bdwlg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-TKkjhAHzM_CnQVzpXcHDMg-1; Fri, 29 Aug 2025 15:29:35 -0400
X-MC-Unique: TKkjhAHzM_CnQVzpXcHDMg-1
X-Mimecast-MFC-AGG-ID: TKkjhAHzM_CnQVzpXcHDMg_1756495775
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70f9ef271a4so16521146d6.0
        for <cgroups@vger.kernel.org>; Fri, 29 Aug 2025 12:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756495774; x=1757100574;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ih3Z33J4/DFJic2bWxlA8iLEPjEmBgPscUOkXmjcxCw=;
        b=Eh21c/STTdvsBX44ug69Vcv/7Dlbf81ILOgbr4VLjQFNgcAQe5m4t7sXqP32qjPxT/
         ZsZVBkPrvtAi8IpV4fyeWJbuevGlPUZsEkaRHFHOpNCh+aMLJ6H4MlkzTvgxJMOC/VuE
         eQKXGSoDdhvp44zd1SqduLOe4cY2i6qck1Iou6yKA0hzNXd0mCtijJNPmiEyVRX10NSc
         gMfjOwB9BryXGqT7+2qIJAb1DAh8hwtObGt+9zoXto5ROMrvZ96f23I0LsNb5CCfwi5c
         hIc8hMF27onKmkcxAaIb7U0vWhha55Bom61vx1PBAD6on5sVn1L+tj9xXyBbCy01WnZM
         0GVA==
X-Gm-Message-State: AOJu0Yx50QN0nAbwrQsyOKaYwM/HZySw1yo2L+xK77dDhPR4nDrCckmX
	oNruRApHfyFPL0cN+jynRdX0K9dT+LdslMnvgf5og5mliFg5tJ6667YwCv/xj3d9W64EGqzTwDC
	UVJjyAkdK1YQsbRU936D5BwFbGYUqD7PNPfrVl4eIGMyXTVSQGGO9nfEs/K+Z8mWY6PE=
X-Gm-Gg: ASbGncu9dRHr587NbF8K4bAazqEdgnnVEQyK4iL0/MVVWmIXepG6XLFRESQkC6KzTEq
	0iFCHxLhKq0iHcwuORDpiAZrqam61QAQkoI44FRL7sUr7g+pgk9+NKkwIhvJUJ1h1wEKl6fkqrs
	/Uqukmuuhbf9qMXC0sKxnZwOYRRvLWfRnRPASJ2xcr1B432aBIYsN6V3RxGa+tyZXCbhozgJ3zn
	+exjQNB4f7bwrqGwAkPdrIofK+s2rETetMrZ+BcQMzri1P8rdVbvvyvvZiF3BDaGjej8zhmTtpe
	RcxDcUSXuXCRV97jd7qYcAFOFFbO0axnwTkFwprGIRXuAe+capGZp/3e+nSehsFZIvKJ3f62Qiu
	9vsVvhxvt8A==
X-Received: by 2002:a05:6214:1d2c:b0:70d:ff3a:f986 with SMTP id 6a1803df08f44-70dff3afee3mr55211346d6.13.1756495773809;
        Fri, 29 Aug 2025 12:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBDKVwwFPBvRUkBnugQcMU8CagCVbesKVDDj2wyOnC3IvZmD4TMscDpJdqzJF1bJznls9vFg==
X-Received: by 2002:a05:6214:1d2c:b0:70d:ff3a:f986 with SMTP id 6a1803df08f44-70dff3afee3mr55211086d6.13.1756495773364;
        Fri, 29 Aug 2025 12:29:33 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e624cfd32sm21802186d6.47.2025.08.29.12.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 12:29:32 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <be3275f5-a825-42bd-bf36-3d92387d0b50@redhat.com>
Date: Fri, 29 Aug 2025 15:29:32 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 06/11] cpuset: introduce cpus_excl_conflict and
 mems_excl_conflict helpers
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-7-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250828125631.1978176-7-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/28/25 8:56 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> This patch adds cpus_excl_conflict() and mems_excl_conflict() helper
> functions to improve code readability and maintainability. The exclusive
> conflict checking follows these rules:
>
> 1. If either cpuset has the 'exclusive' flag set, their user_xcpus must
>     not have any overlap.
> 2. If both cpusets are non-exclusive, their 'cpuset.cpus.exclusive' values
>     must not intersect.
Do you mean "both cpusets are exclusive"?
> 3. The 'cpuset.cpus' of one cpuset must not form a subset of another
>     cpuset's 'cpuset.cpus.exclusive'.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 62 ++++++++++++++++++++++--------------------
>   1 file changed, 32 insertions(+), 30 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 5dd1e9552000..5cfc53fe717c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -584,6 +584,35 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>   	return true;
>   }
>   
> +static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
> +{
> +	/* One is exclusive, they must be exclusive */
The comment is hard to understand. Basically, if one cpuset has 
exclusive flag set (a v1 feature), they must be exclusive wrt each other.
> +	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
> +		return !cpusets_are_exclusive(cs1, cs2);
> +
> +	/* Exclusive_cpus can not have intersects*/
Grammatical mistake, better wording - "exclusive_cpus cannot intersect"
> +	if (cpumask_intersects(cs1->exclusive_cpus, cs2->exclusive_cpus))
> +		return true;
> +
> +	/* One cpus_allowed can not be a subset of another's cpuset.effective_cpus */
"cpus_allowed of one cpuset cannot be a subset of another cpuset's 
exclusive_cpus"
> +	if (!cpumask_empty(cs1->cpus_allowed) &&
> +	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
> +		return true;
> +
> +	if (!cpumask_empty(cs2->cpus_allowed) &&
> +	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
> +		return true;
> +
> +	return false;
> +}
> +
Cheers,
Longman


