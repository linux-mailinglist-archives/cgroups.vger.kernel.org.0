Return-Path: <cgroups+bounces-8424-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B994ACCADE
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 18:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A98174A22
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454523D29C;
	Tue,  3 Jun 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8q3AieH"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C73372605
	for <cgroups@vger.kernel.org>; Tue,  3 Jun 2025 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966446; cv=none; b=GQ7tjGP4LU6L4h8vASMfTqgVY/TbpmyN8TbcCnElt7wBXAYoLXN/GzW6icDSwbxJoMBVvT40NSpfRGRQn42Yy9AZIVNWxCMdbQqoDZxGim6+xuOKmPtH4t9WYA8yvZmPy2chABilBDGsrOX4ItAhT2nYx7wUouxrzQEFeaX4l9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966446; c=relaxed/simple;
	bh=LwikQnd4kY/l2HC04fd0aJDXqyM8NbE8MR+VnfBiwPA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Oq82XUubVRlGbzf7YNiH5v9TBDpmPIkqQKlJJ8LQ6om0jMQtsT8SNbeI7MPbYjgvHaFFG4CYSlUuFd8A1dvZDeP9qccoInaoVyPTvLQ+wvrq6d6jVTN68aKpXedhRrokVypKIk7+zwnyzl/FiAM55YsLNPxRZ7TQgmAKV4hroqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8q3AieH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748966443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MLjRagl6AMKFVVOCSkMlOIgXvGzRvhYyu3bWH5FnVWI=;
	b=Y8q3AieHYMebLW26rNhy0CNeRnjEksjfdNeXxd5/ymjPhN1zcO+ZPssJuMIZP2H1MEB661
	+Sv7jXNWqxoabHatAIzxxlsZNXd+5XA8VPWnqUiEiYz/FmDuR5Uq2XnQ5/Aw3gA2Zzc6wl
	NxLnDkruZMof6TTHnLG/fexcXVJpn28=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-bm6rFsRtPCuDyvKky8tfpw-1; Tue, 03 Jun 2025 12:00:42 -0400
X-MC-Unique: bm6rFsRtPCuDyvKky8tfpw-1
X-Mimecast-MFC-AGG-ID: bm6rFsRtPCuDyvKky8tfpw_1748966438
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a38007c7bdso118685531cf.3
        for <cgroups@vger.kernel.org>; Tue, 03 Jun 2025 09:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748966438; x=1749571238;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MLjRagl6AMKFVVOCSkMlOIgXvGzRvhYyu3bWH5FnVWI=;
        b=UwmuieDF7UsnGM72SUXc6whq8TcWoMs9lvobeMtUFfIntjne0T3PUF+3l6fq1ikyBK
         IEOccKF+7CqN5O/RRxk1GWI3sToQHLBz1dlOW52Uc4mB332Mbo1XCfgq1VV5Ingg6eFG
         83KP/oU+s87yMshl1mdCUlHlzHhsLeVtFwZebJvX7TNadWhewaVoOZ6hRzt64wvWot7x
         NMPggiwHNqVDrLXPJyB/jxnrjfXwPMX6IYB7HNV3flY6wG9JMcmjCMsDVQ7gMS5uAG1W
         L9atkKmMJaNjb1TvrQh8tQx8rfK3nLHlR5TIpCU2b3lab3cknbN9HiNO/eeQGYT7sIII
         V2iw==
X-Forwarded-Encrypted: i=1; AJvYcCUdu4Je73I3QVHzvkrHb5r3lzPCFLUrHI+cYhfyHiSiI8sMxsh2AW5sL6CAfoftzSyHXiOlu0IC@vger.kernel.org
X-Gm-Message-State: AOJu0YxyuQR++t7EdnzZENc/K6FaVIFTokO3ikwzU0XvXv6q8hj+1rXA
	lh/Nuytb86vj3pH/TyF+6sibXaKMsO1PDCsWmALn11OMAa9gRNrAdej9AerdNfm6kii8KQ1cNM3
	I1kSj/aIJnlZVFga4q3k4U5d2dZq5O6YWdy9NBwLNCNJWzotqU4yfwGEi7tg=
X-Gm-Gg: ASbGncsmH6+etEAI4k5WPpQvi1VyEHqC2JFpy0JvQL6Z8BbuE0hv+0bcKmmQ172uuHz
	3HDTb0iaVxUYG6A+JEtMN3NdIu/16J+rqBKyMlIiS6uvwiyYe+Ni6ZHJ16vt6yR0vaNnJdF1Scm
	m4ewRl11bhcF7tB/SdW1Xv3s/QwnwL19lqD7TR8d09cr4BgpqeRRfZwXx8xQ1Ydfryu6qHfH5lO
	sjE7C7+dntsnCNw6qeUu4s8mM7jvmunaQ5g/FWBMFoUN4SxaGhWHMS8WcDMSAm+0nx72sJJUFc/
	/ZwEasIVBL1rQsyfI/8BvTxd9T4NGBHUcMcwkfaA5WXlcVDfG+H6sECeyg==
X-Received: by 2002:a05:622a:2307:b0:4a3:800d:2a8d with SMTP id d75a77b69052e-4a4aed7b83fmr231758821cf.52.1748966438239;
        Tue, 03 Jun 2025 09:00:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyNPlYI9vv9aBoaciBPavw0ylOELOzAGIXwsphdlhsbgeTU4HmYtbe5S6CfG3haCA6LskpDQ==
X-Received: by 2002:a05:622a:2307:b0:4a3:800d:2a8d with SMTP id d75a77b69052e-4a4aed7b83fmr231758041cf.52.1748966437730;
        Tue, 03 Jun 2025 09:00:37 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435a81f24sm75276101cf.75.2025.06.03.09.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 09:00:37 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0a90b2f6-78f4-45e7-bc10-e625f984a757@redhat.com>
Date: Tue, 3 Jun 2025 12:00:35 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: Drop sock_cgroup_classid() dummy implementation
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250603154528.807949-1-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250603154528.807949-1-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/3/25 11:45 AM, Michal Koutný wrote:
> The semantic of returning 0 is unclear when !CONFIG_CGROUP_NET_CLASSID.
> Since there are no callers of sock_cgroup_classid() with that config
> anymore we can undefine the helper at all and enforce all (future)
> callers to handle cases when !CONFIG_CGROUP_NET_CLASSID.

That statement is correct with the current upstream kernel.

Reviewed-by: Waiman Long <longman@redhat.com>

> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> Link: https://lore.kernel.org/r/Z_52r_v9-3JUzDT7@calendula/
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
>   include/linux/cgroup-defs.h | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index e61687d5e496d..cd7f093e34cd7 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -898,14 +898,12 @@ static inline u16 sock_cgroup_prioidx(const struct sock_cgroup_data *skcd)
>   #endif
>   }
>   
> +#ifdef CONFIG_CGROUP_NET_CLASSID
>   static inline u32 sock_cgroup_classid(const struct sock_cgroup_data *skcd)
>   {
> -#ifdef CONFIG_CGROUP_NET_CLASSID
>   	return READ_ONCE(skcd->classid);
> -#else
> -	return 0;
> -#endif
>   }
> +#endif
>   
>   static inline void sock_cgroup_set_prioidx(struct sock_cgroup_data *skcd,
>   					   u16 prioidx)
> @@ -915,13 +913,13 @@ static inline void sock_cgroup_set_prioidx(struct sock_cgroup_data *skcd,
>   #endif
>   }
>   
> +#ifdef CONFIG_CGROUP_NET_CLASSID
>   static inline void sock_cgroup_set_classid(struct sock_cgroup_data *skcd,
>   					   u32 classid)
>   {
> -#ifdef CONFIG_CGROUP_NET_CLASSID
>   	WRITE_ONCE(skcd->classid, classid);
> -#endif
>   }
> +#endif
>   
>   #else	/* CONFIG_SOCK_CGROUP_DATA */
>   
>
> base-commit: cd2e103d57e5615f9bb027d772f93b9efd567224


