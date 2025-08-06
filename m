Return-Path: <cgroups+bounces-8998-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B29B1C6E2
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 15:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A81247AE7F1
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CE528C005;
	Wed,  6 Aug 2025 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNrJr/jn"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B628B7EB
	for <cgroups@vger.kernel.org>; Wed,  6 Aug 2025 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754487424; cv=none; b=Y9TRKXh9w2YmT/HZTfKKiO7r2x3+WFldsCcPGU4OjpwxLIuTUfuEWfd9Y7uXVM+sIzdJmVMiBSzEH1PlUojn8wAcJnZHI5KpeN7XGXuloO6rKP/bdDrSdyPLSjMo9fBXDPB5z27ZSQ6vWNRdNIse8GrvKRBZwVY9xcmsVzlpL/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754487424; c=relaxed/simple;
	bh=Gc+IHMqrg3k+CPCG49IwYaeLndJ1W+ZmMsLAIRORBGM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OSKHg9c0pqG5w8To87RqptORnZpvkgmJoEzs00108EB3HjFpsR7Gsmx/RcC1Pxx3qfAPwMI25Ng33yECfuS/K6ElqWORrGwmvTDv6C1pl7O/AYyGyA2+z7m8iKFWMZZgqcLFB3OWblv4OhxuMyq8va6hoKRa2Hz1QlWx7tUXT3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNrJr/jn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754487422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elGlcnQvj0g4w9uftbmc4mXIt8a4vHLbXoDJDQwevpE=;
	b=PNrJr/jnX4HUs65+RzviEDpVPoEar9Mkm3cocOKIyHJL8QWwpCx7/KB+i1wakM7DJUg3Cf
	DooO9ZOFpOiKjVBlma6e1BbNTQPDjK859nNQ/JiqZMkxzuUivUogDJ7o1dRRJAhDyOTSC0
	9i6wantK9asWehhqTehRiTmc8Le16ks=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-pNBbeO1jN9m6ffkfydN09A-1; Wed, 06 Aug 2025 09:37:00 -0400
X-MC-Unique: pNBbeO1jN9m6ffkfydN09A-1
X-Mimecast-MFC-AGG-ID: pNBbeO1jN9m6ffkfydN09A_1754487420
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e7ffcbce80so607092585a.3
        for <cgroups@vger.kernel.org>; Wed, 06 Aug 2025 06:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754487420; x=1755092220;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elGlcnQvj0g4w9uftbmc4mXIt8a4vHLbXoDJDQwevpE=;
        b=svDAeh0rZ7MkkR4iaVR+U6p2tQbEu9xlWnatrYCXOw7+ro+b6caJ0s+IemFG40H6Lg
         BEhxMWQtUWjoi8TZF+FVfOXBDRy9QzzA8xUAWPNuHf5UxdwNVVIAZ2ZwFHAjGTRbJjVB
         Un5VQvWMUvXk3Rnmmrr3j04mVjjtCA6ivZhCeS1MertWoB/Q0HxXXU8zCMqRzwAxJzKk
         FaufAoju8dENm/7gwlEDn0JCmo28Ew26hA3T5IeeiE5kCIkEXaE9v3v9Ihag6i+140X2
         dr2juWjKUWyFkrf6bv4uvOgjVSl1HpqUfhuDFzOK9xR/IbuihPaFAx+luE6WuPZLEeti
         lsDw==
X-Forwarded-Encrypted: i=1; AJvYcCXX+gVquMYbCEQO+WQM4pBByZzHQnkiahPbiohkykrP4VQeei2QInRR9m4Z47ABOQNGcP96K1sW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3mzYiw53vywxPnkb9JrmGaYuX9W0MxNy3PommMjXEdVd8QpkH
	kSXw41CgDs+cFw9bJxhgpuAuS9GDVtd/YMqb6NObzl2+E/676Rh8NvCf+kc7rcuzsDRcAScGyi2
	4+iRT3gsQ/qaFPt2eTji7ZM+BTS7/A2JQurcFeM4pte9Lh3xo8idqM6t32PI=
X-Gm-Gg: ASbGncvdRopWLpyBlvJRDg+HkCxNZgKkP3OLHXNvQ9A8t0+gAn4yXrVBomADch12zrf
	timxN4Qpgge9tAgcS8ltmTCPZU/yzGQ0t8PhcZDb4mjZZAhjV4GS4LkBHxHMivVJlNb2RfFVHSK
	HxWOI1LU/KS88K5eY3L4suGk2LwYsLxjWVXsbowJQGiq2OlNrddecJd92h5QDh5K/V5sMmbvF/0
	rirSIWa6VVX06s6oL1rEGBrWtdm2gkSUg5OB+KB5U8U9Vh68fpTgXeyApqjK6kdfgJOi5udBKPS
	5+cDu5/nzKL2JCeztt7nMZLusOxFGpz31v6MFmLOwtg7mOWCDgJF0GiZnWPccH5u73nm6XfeM3J
	sPxeHprTz5A==
X-Received: by 2002:a05:620a:4316:b0:7e3:47a7:7718 with SMTP id af79cd13be357-7e816735c9cmr352192585a.45.1754487420246;
        Wed, 06 Aug 2025 06:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKziNy56SkxoHcLkoEhaK4DW7+o5pZx1xAKBwM2VojshAjuVYUDLpMn+yr9X7ggtNFjGv0LQ==
X-Received: by 2002:a05:620a:4316:b0:7e3:47a7:7718 with SMTP id af79cd13be357-7e816735c9cmr352185285a.45.1754487419608;
        Wed, 06 Aug 2025 06:36:59 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5cd509sm823143285a.40.2025.08.06.06.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 06:36:59 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <eff82d2e-4030-4780-abb5-cc5ad4e91acb@redhat.com>
Date: Wed, 6 Aug 2025 09:36:58 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: Remove unused css_put_many().
To: Julian Sun <sunjunchao2870@gmail.com>, cgroups@vger.kernel.org
Cc: tj@kernel.org, hannes@cmpxchg.org, Julian Sun <sunjunchao@bytedance.com>
References: <20250806080457.3308817-1-sunjunchao@bytedance.com>
Content-Language: en-US
In-Reply-To: <20250806080457.3308817-1-sunjunchao@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/25 4:04 AM, Julian Sun wrote:
> Remove css_put_many() as it's never called by any function.

It isn't currently used doesn't mean that it will not be used in the 
future. We have css_get_many() that is used in memcontrol.c. For 
symmetry, we should have a corresponding css_put_many(). Also there is 
little cost in keeping this little helper function around.

Cheers,
Longman

>
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> ---
>   include/linux/cgroup.h        |  1 -
>   include/linux/cgroup_refcnt.h | 15 ---------------
>   2 files changed, 16 deletions(-)
>
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index b18fb5fcb38e..2e232eb8c897 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -322,7 +322,6 @@ void css_get_many(struct cgroup_subsys_state *css, unsigned int n);
>   bool css_tryget(struct cgroup_subsys_state *css);
>   bool css_tryget_online(struct cgroup_subsys_state *css);
>   void css_put(struct cgroup_subsys_state *css);
> -void css_put_many(struct cgroup_subsys_state *css, unsigned int n);
>   #else
>   #define CGROUP_REF_FN_ATTRS	static inline
>   #define CGROUP_REF_EXPORT(fn)
> diff --git a/include/linux/cgroup_refcnt.h b/include/linux/cgroup_refcnt.h
> index 2eea0a69ecfc..1cede70a928c 100644
> --- a/include/linux/cgroup_refcnt.h
> +++ b/include/linux/cgroup_refcnt.h
> @@ -79,18 +79,3 @@ void css_put(struct cgroup_subsys_state *css)
>   		percpu_ref_put(&css->refcnt);
>   }
>   CGROUP_REF_EXPORT(css_put)
> -
> -/**
> - * css_put_many - put css references
> - * @css: target css
> - * @n: number of references to put
> - *
> - * Put references obtained via css_get() and css_tryget_online().
> - */
> -CGROUP_REF_FN_ATTRS
> -void css_put_many(struct cgroup_subsys_state *css, unsigned int n)
> -{
> -	if (!(css->flags & CSS_NO_REF))
> -		percpu_ref_put_many(&css->refcnt, n);
> -}
> -CGROUP_REF_EXPORT(css_put_many)


