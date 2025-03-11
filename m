Return-Path: <cgroups+bounces-6982-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE163A5C534
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 16:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB6D169258
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAD525E805;
	Tue, 11 Mar 2025 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBWHYq0U"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447841C3BEB
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705828; cv=none; b=CzdEurDNzs8y4oBen0NFBUsQygxZAbDDHsE7hgbicnFwJFwhhmc3ZiU3gTuNuul7I5NxlN+SxnreKk6QmjwZ+zehO3PWpYebUKaa6RuihE5O3Leg04co6qivdy5SrCLjSKbgi60cIAg3ephJ2EAieg/v7eXbd/fwSTYbEPUlgDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705828; c=relaxed/simple;
	bh=6xUFOUJbj+bIkDKDzKhMcdc7H38Tyf5InLjfqu2UsAg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XNKd2aDsWyoIVvYqG2v27SR34M3RilsAFt2/+0oxMB+83J2Ka7phZ54YZOFMBJtH0OTQUtcG3sJEUpL80NFiZWH6qs4fA3/nfjZT/XXiWwsVVcFyghws9tVrO6vlcGUwrfVdueKW7nb13zk1Hp7ScNJBQfSzPpm14wVLvSfclKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBWHYq0U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741705826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IG++bO0r6VtJdGQv/NPOpw3HuEvvlwn3OEQA9ottqtk=;
	b=PBWHYq0UM3vBe+N7cFsnkFXl+aIBc9rVNBhnDcGQRQVs4eWpa6IVhDsAatGLnRAWBnuZD2
	+c8TWz1FU0vE5SrwkAxGKuIQ2rhmszJsXkN6KP2ln6ERvxjcdsdg0MEwMWCVgWAfjMohMF
	aFcC26g0KuX6n/V4p77N97qp9HTBMDo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-dVvyzGCpObW7jKwi1n_8uQ-1; Tue, 11 Mar 2025 11:10:25 -0400
X-MC-Unique: dVvyzGCpObW7jKwi1n_8uQ-1
X-Mimecast-MFC-AGG-ID: dVvyzGCpObW7jKwi1n_8uQ_1741705824
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c54e9f6e00so428392185a.0
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 08:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705824; x=1742310624;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IG++bO0r6VtJdGQv/NPOpw3HuEvvlwn3OEQA9ottqtk=;
        b=pAEJZJhvIWjnapW40lu5u8R240aJm3XZ2ueNnKAmbhmQWVhQ3ZgmQX9BQu7pc+wt5L
         cEL0KILRhWcwFm8TH1dtzxo9VHw6sKswepK1+NivGLP8FncB0vvfBnDEAKHvXWJv/jZX
         i/W6CYqm7ZSH8akyiEacOdG7sVN1rXqpIcpS7xMU3Gz/rEBPoNphtJ3HAHtmFr9WiSML
         a64mko8fOPhuT/mrzDwfklbWiLix5PlM/ruzP4rlf8Y/ulIBNtVUEacb5MhjsN2XludQ
         eoUS3YfBWkrIN9MYQw80+D+JEG0W8t34Lwjvr8zVd3AGBhXlKzuIO36KhZk8qFwoPYTQ
         bFDA==
X-Forwarded-Encrypted: i=1; AJvYcCUwwHMZlCIaicJzT4dvGOUzNirG3Ij2cSaKYVrHThVqvxP0v90LlKXtnQC0M6dsbavWTYGZnexn@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqk89EzbJyKhXyvxvpJ82ZJEB11DJlBrpx9ynY8oN92N9J+CXP
	jt6mTEXC1WfEPWfX8Lit2YaU+LkiBynMg2aqg1bchqdEBrDcLMlg5STlegpErAjovVdomkXtL9K
	uGWYifdJnZrld61BGf5YK+NLkaaGPgVzUgnjCozkwOkJprsUJm5GjCnM=
X-Gm-Gg: ASbGncvcb16udJPXhWLo11FdCHdBi8pte85hPKGYnBg97Xrv/WBKHt7J36Ac2GASI01
	T0hx1JznUqE22RqXRvRPHARUS+2EYfvRvwjybJYNdqYMEPk3uknuJLHfMhO7XsJMwqqyW744Mnh
	ZVolQEIqT27UqPFRdeCXGDqkrjB/QzQntR16sb1u8d3BsHwIE94ErG+GhUR0sA54Ntfy4oAPZEG
	TRBpbVosgvQTmsFFqCajdvo42OyCKjtuIksH1CWAyUidr1Gd+0dffCz6vVCCf/MsR+S24JhQ6LL
	2kfSa7t9B7LYNCqQ+h8/j7hS8SoMdsnDYYDJHMmuUaLZ5WsdnqnpussEy2HvaA==
X-Received: by 2002:a05:620a:8399:b0:7c5:4147:bd2 with SMTP id af79cd13be357-7c55eee86famr538354585a.15.1741705824576;
        Tue, 11 Mar 2025 08:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG+YTrdakBVNbURXSBwemJBviHEvSKu6PP1aPXAK59tAzIZqh/c6bXA7okUTbxXTNZ7MHeLw==
X-Received: by 2002:a05:620a:8399:b0:7c5:4147:bd2 with SMTP id af79cd13be357-7c55eee86famr538351085a.15.1741705824291;
        Tue, 11 Mar 2025 08:10:24 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c54c54f384sm415455385a.115.2025.03.11.08.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:10:23 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9d8dd342-4c88-4d4c-96c2-d6fa489a2de1@redhat.com>
Date: Tue, 11 Mar 2025 11:10:23 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] RFC cgroup/cpuset-v1: Add deprecation messages
 to sched_relax_domain_level
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250311123640.530377-1-mkoutny@suse.com>
 <20250311123640.530377-8-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250311123640.530377-8-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/11/25 8:36 AM, Michal Koutný wrote:
> This is not a properly hierarchical resource, it might be better
> implemented based on a sched_attr.
>
> Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 7c37fabcf0ba8..5516df307d520 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -175,6 +175,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
>   
>   	switch (type) {
>   	case FILE_SCHED_RELAX_DOMAIN_LEVEL:
> +		pr_info_once("cpuset.%s is deprecated\n", cft->name);
>   		retval = update_relax_domain_level(cs, val);
>   		break;
>   	default:


