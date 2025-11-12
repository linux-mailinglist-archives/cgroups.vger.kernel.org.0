Return-Path: <cgroups+bounces-11891-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BECDC54691
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 21:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 054D7344C81
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 20:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5142C08BD;
	Wed, 12 Nov 2025 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFZ3FYC5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kw0RuamT"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F38320C023
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978703; cv=none; b=YvNkuJJsiQjBw59lW3ACc5AIe+PlazI/BMWDlay4GqkBQpEL7hm7ONvl3ACuGNf6m8rO6c+gaGpqLxGZjdcAtPXqrseuN5N8rqvNthdslFqYxOplPmbw4Q+mGDU1gUdFfk/JdWlrqOWo1b3Aq8VDm49YuBfVxqiTrdIVLI6yRJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978703; c=relaxed/simple;
	bh=R0NjxuliBgbPkUjoVxV/GQwermGfgOh84UIqfogg6Q8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E8aBXsDYt5Tn+rl4BuNQ/XOyNVR3XuBtQNVgPKETB+A13U0GTPb/Of8QwHDc8FKtPEYytqGsZANCQKUVWdnvAoBGeffp9G8tqko+jI7eoZOjlJHDqv/8W3nyODpK6XKcKSBHS9iSuWQeYZrgBx9B9m5KacQKouwinG7/oXx9muc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFZ3FYC5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kw0RuamT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762978700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PiNpCdZq1yfcHhaQQsyCMfmIiO/UkkDH35120jYscgA=;
	b=FFZ3FYC5qavt5e8M+3fFUB5OIjOjx0625oa4fPSX0wg1kg6x6K9KPSYd8TCPwCbpgdJwVU
	Gsk7HLe/prhDJfXskXl0nKTzehVTS/OZFQ5sAe0Ra2+wzwifl7QEyADXgsZgJMTqV/YtOi
	CXuDZjWM2H6GwFNL28PDZhhRWJb6Tg8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-2wlYWy_VNQS-yi3AL2rXJQ-1; Wed, 12 Nov 2025 15:18:19 -0500
X-MC-Unique: 2wlYWy_VNQS-yi3AL2rXJQ-1
X-Mimecast-MFC-AGG-ID: 2wlYWy_VNQS-yi3AL2rXJQ_1762978699
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed782d4c7dso726481cf.2
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 12:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762978699; x=1763583499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PiNpCdZq1yfcHhaQQsyCMfmIiO/UkkDH35120jYscgA=;
        b=kw0RuamT9bR7PKCMVEk5oSxaxHTjhr1O320Swyjo3YvNmpY62gflAZzhay0NJgxb5Q
         yPi2IO+kmwF4UiMex9moU/L9XDgZI8Pysp4QeMUt9p5QQWF+mXbW4YM6lgGJqY50cLYo
         nrRj4EoRsEmQLKm9isxeKc/DOX41+5qYWOYUr5+lamp/EEwAQmNH7VSoMOCzW/l3JUC0
         mlgv8iCYjJJkxeSusnaUqtWRk53s/QHe9NwJLo/J2I57wWljW4Jlt2nWMptKDU2PPoU0
         qhZuzpzKodePbY4LYeT/drm/OilrSE29hNiJ3JMc5Lpe3h5VyjLAWfHDAPiLtCKRE6N0
         R75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978699; x=1763583499;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiNpCdZq1yfcHhaQQsyCMfmIiO/UkkDH35120jYscgA=;
        b=qmTt0rEJe34hLjA8canxmIknFZV9Vwae3ek8ayqthk5h7/Fx3/jfut7H85qS2nkMBr
         is+6uQmP++o6pYlHLRyRViO0vULWckLeRUll98A9tN5jN+d1dITGoWT42L6PX8BKgOhf
         qpMgRIkjaCzwrZJBN0zKaHsuMFhO+BAnBnSnNBVDLr1aULY5gKFKt5yIvrR/Z7RwQRB0
         AbolvV+FIeZU5V1TNnwkRhNUjFIQU7i+8Add0VBsqKZQGllC7sd5u9vlx5HXT6ESh4nN
         HZHcjQz60IYnoEKQesWqmHwkAlqQPzmVS8sDoAD8/5J6xmUE21sDemdrbi82EWpSrZ4N
         KGdg==
X-Gm-Message-State: AOJu0YxEmpH13Ptd6IQtih13q8ohQrPPXQOSQJw5LFYbv4xwOoAt043d
	erHJYdwczZ4u1YBoYXApc4VMM1gmzuJ5KM0wIRqpu+UzW0caVzoGrmKKRRtB1lIJlwGP+xJpr7Z
	r3j9L7RIy0ZGXNQoGsWsYgtA9Gu6yio9so80JiSBU14mgJR7MyNtKusGy7uc=
X-Gm-Gg: ASbGnct/O6UkWAdRnmJFDQ8EWQG3LXMy3Dkiln/Gr00g58uPi0yFlb6PaTTBFAUVrtt
	ZYRUIfq6rRSPnuGePxrnV9UT/FxTY1JXvnsLCaq73+GB+vGFT66TLm4L1RkvlNO/6r1PnDRRg70
	xDflOBrL/FViavxUu9FdsFgygd1dWqnXPMqiVWzv2dl9R4xZG9YDp1RlnrFQX5LV7aF75znZcyZ
	GMxwjGAgJUUmqan75Wc4OJ7ScuIEuGNtOQhAWrwEb2xIZdq+wMLGk2f6TLHcXbwGICjj3frg/LW
	mAax1Zs9gHLCFyqyT3SCC/SHPb/1Dtfn8ncYhLvZ3iYrsE1pFksHT3PjYAiKO21tX7GVeCIqa/R
	+IZUvgyAAtxg1zQagGfGxxuWgxaLNobAPWsL0jyh/pbPasw==
X-Received: by 2002:a05:622a:54e:b0:4ec:f34f:f7f6 with SMTP id d75a77b69052e-4eddbe34594mr55363521cf.64.1762978698907;
        Wed, 12 Nov 2025 12:18:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfJnTBGSA2/ZdUe+2Kwow914SDODXO/M57MSGE/+FIMwjvG6SblDsSpzNVwFL52eipuYAbVw==
X-Received: by 2002:a05:622a:54e:b0:4ec:f34f:f7f6 with SMTP id d75a77b69052e-4eddbe34594mr55363141cf.64.1762978698461;
        Wed, 12 Nov 2025 12:18:18 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede87e2a78sm14921cf.22.2025.11.12.12.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:18:18 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3c449d75-2a44-4acc-b3f6-0b2c261db1bd@redhat.com>
Date: Wed, 12 Nov 2025 15:18:16 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 02/22] cpuset: add early empty cpumask check in
 partition_xcpus_add/del
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-3-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251025064844.495525-3-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/25/25 2:48 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Add a check for an empty cpumask at the start of partition_xcpus_add()
> and partition_xcpus_del(). This allows the functions to return early,
> avoiding unnecessary computation when there is no work to be done.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6af4d80b53c4..3ba9ca4e8f5e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1345,6 +1345,9 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
>   
>   	WARN_ON_ONCE(new_prs < 0);
>   	lockdep_assert_held(&callback_lock);
> +	if (cpumask_empty(xcpus))
> +		return false;
> +
>   	if (!parent)
>   		parent = &top_cpuset;
>   
> @@ -1377,6 +1380,9 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>   
>   	WARN_ON_ONCE(old_prs < 0);
>   	lockdep_assert_held(&callback_lock);
> +	if (cpumask_empty(xcpus))
> +		return false;
> +
>   	if (!parent)
>   		parent = &top_cpuset;
>   

partition_xcpus_add() and partition_xcpus_del() are supposed to be 
called only when action is really needed. The empty xcpus check should 
be done earlier to avoid calling them in the first  place. So unless you 
are planning to change the logic that they will always be called even if 
action is not really needed. If so, you have to state in the commit log.

Cheers,
Longman


