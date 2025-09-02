Return-Path: <cgroups+bounces-9625-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 713CDB40B9A
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 19:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418001B6416F
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 17:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C152DE1E3;
	Tue,  2 Sep 2025 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7emYfrv"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32322DC34E
	for <cgroups@vger.kernel.org>; Tue,  2 Sep 2025 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832771; cv=none; b=pRz+0ICTJ15HXS9ZXX3kcWdM8MVUWRsDlkp+0d24UvyWwcMd7tAHuMWMPfm+b6PqiCZSbXarRg5s52aj4TAVEL6aXDrWwqiO0Y2AlwIWziUGBkBgv2UOFqX2tiFj5PAsUQZUBuEn8YjboVVzCIXeme/64sIo9Cy7HbPcjnjx6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832771; c=relaxed/simple;
	bh=wlZH8lhbscxC9THCQ4kinck0ZuzPLO1Tm5yhuN/XkRU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KJbV0g+KVuZ4grVk9247ASpcoSMRGZVdgW27UCDg1xGKc2h/WPepOn7DqLqVfeTCBV7xk+6ouYy3rdbalNxyQwVvRMFCI99VvX9lQtpKIpHCRsQTyx4xVuPj2QU6l45iHGFQ9hbnSqn5B9+r7Z2VUKkbavVqo+/u6st8RjQuyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7emYfrv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756832769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHu4aCUA0D1nulKzC9Dqv0LHGBHTxw2XXtYWx9Xi0Pk=;
	b=Y7emYfrvd+Z6Ak1ZzcZkvEJ+PFt2WOB8/5zTkOPfMBod7v3Kzpfj97pc+ywcabJrGnaY8Z
	LgiMHY/Mh9fuXk9/VTMmoI2O9UBPwvMIYshHlgncNpHHGVhtQ6eezDd+46oamt2uNmcwJ2
	UGTdbGEONOW1TOvlx1Ztk6QELmA3gwY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-wh8Z4_WPNiCh0uXnblO-Rg-1; Tue, 02 Sep 2025 13:06:07 -0400
X-MC-Unique: wh8Z4_WPNiCh0uXnblO-Rg-1
X-Mimecast-MFC-AGG-ID: wh8Z4_WPNiCh0uXnblO-Rg_1756832767
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-72108a28f05so24922456d6.3
        for <cgroups@vger.kernel.org>; Tue, 02 Sep 2025 10:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756832767; x=1757437567;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHu4aCUA0D1nulKzC9Dqv0LHGBHTxw2XXtYWx9Xi0Pk=;
        b=mCX7UPaD3IuoVNl95iigfHWl8yQlkeAlXJaWkpN4+5MAh9nHh4KVq9d0j/pvYAAPac
         4NvsEUCE/0uFR1sREderpxgrmJi2OO35ihWeYajxAWPaGE1L+nH0Li31IZ2kRMWO/NJg
         xS+UbVJdSLGy/D1ZIQwYHSZS0VuL2m/OpKMcETlC1T+3nce2PMnHtuqyNc2foCOrptjd
         w61sXLOs1M5zgo2oAq0yz1rAo7qahwZqCgfQqQO3+FwE/msDQCQR8vu7J4LHR5i/tE1Z
         HNYkZoCSq9fVwZqfz1PB0ttcrB9M1G2INcgKkcMnK3DXEebztdYqg+sKSXx7ScWey84r
         FgOA==
X-Gm-Message-State: AOJu0Yw7jYv5yYdIfXmvGhWJQ0GlgUZg1A6TdYpJasYrR983QvVHZ1fU
	h+kIU49kv+zBU0FZjtE4JcrY4pXhw0R42L2JvB/Yke5sHUPkW3WiHjxLWVMQ21GvsvMSjQldl5p
	WGKawgDIQaKFtOq4etwroKP7ukglBRX3L03EJslAF8l/A7SSv99ABNHbeoUY=
X-Gm-Gg: ASbGncsMzuyUrri6xPHB7nsHCJ/TULvY3YLzCQBWRA0wea0DpI6+KucB5rDpl84PxCR
	+64W2d454lnGFniahp7ATF7opeYeQFs266OOPeh9bP06K/kiLC3PyqjsdLYGY2P/pqTCdo9EmU2
	mIIAX5PW/qrIHRhUZC2dalc75qzaB+A+D+EJfQVV7xBAIFUKdEPBXiJytG0YwQNcRLMT6/RYmcf
	FCahmf42gvVnxTD4Bv0wAQ1xF/lhzcJrxkSrpgnaM78KjT0G7ArA0yReGOMR6onx/z0/hZOptZb
	Xf4ewFMWVG3WMM/tlQ4mqYdjijoTxJvUxGqKez1Z63m8WwGU8Tnd5T+YrPN1mIHqoMNWoRRPJjW
	yewLto55sKA==
X-Received: by 2002:a05:6214:21e8:b0:722:2301:324 with SMTP id 6a1803df08f44-722230112a1mr12129276d6.23.1756832766898;
        Tue, 02 Sep 2025 10:06:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1pydDCKXIedyuxkEgwpPTsJFeOHTh1mDJMxMHZOWHQTWsHU1k0rC0R+/XBlYtwjeZ8QWeuw==
X-Received: by 2002:a05:6214:21e8:b0:722:2301:324 with SMTP id 6a1803df08f44-722230112a1mr12128756d6.23.1756832766297;
        Tue, 02 Sep 2025 10:06:06 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16de30sm15073986d6.7.2025.09.02.10.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:06:05 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ef0e91b7-be44-4d5d-a556-240709c80fcb@redhat.com>
Date: Tue, 2 Sep 2025 13:06:04 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuset: prevent freeing unallocated cpumask in hotplug
 handling
To: Ashay Jaiswal <quic_ashayj@quicinc.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 12:26 AM, Ashay Jaiswal wrote:
> In cpuset hotplug handling, temporary cpumasks are allocated only when
> running under cgroup v2. The current code unconditionally frees these
> masks, which can lead to a crash on cgroup v1 case.
>
> Free the temporary cpumasks only when they were actually allocated.
>
> Fixes: 4b842da276a8 ("cpuset: Make CPU hotplug work with partition")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashay Jaiswal <quic_ashayj@quicinc.com>
> ---
>   kernel/cgroup/cpuset.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a78ccd11ce9b43c2e8b0e2c454a8ee845ebdc808..a4f908024f3c0a22628a32f8a5b0ae96c7dccbb9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4019,7 +4019,8 @@ static void cpuset_handle_hotplug(void)
>   	if (force_sd_rebuild)
>   		rebuild_sched_domains_cpuslocked();
>   
> -	free_tmpmasks(ptmp);
> +	if (on_dfl && ptmp)
> +		free_tmpmasks(ptmp);
>   }
>   
>   void cpuset_update_active_cpus(void)

The patch that introduces the bug is actually commit 5806b3d05165 
("cpuset: decouple tmpmasks and cpumasks freeing in cgroup") which 
removes the NULL check. The on_dfl check is not necessary and I would 
suggest adding the NULL check in free_tmpmasks().

Cheers,
Longman



