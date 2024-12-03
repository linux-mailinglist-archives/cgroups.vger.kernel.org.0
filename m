Return-Path: <cgroups+bounces-5747-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C449E2A76
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 19:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AEA166CE7
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 18:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF871FC7F0;
	Tue,  3 Dec 2024 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMujLNoO"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880101FC0FD
	for <cgroups@vger.kernel.org>; Tue,  3 Dec 2024 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249468; cv=none; b=qtQDGy2pFHaR1ISvWTsJ53Ig/iKwBQhmyXyC9bEpcOKSKvrX2ltRx6MzSv3dKc4UC9rlPDdQeyh38otYZn6QaiBhh3UvVjORDeqTQzDZUJJh2Jhr6/HOepdT4sdGSe+uh6drI+E+lsDY2RBPXi5/AWe1xStPizu3GUS7Ssp45sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249468; c=relaxed/simple;
	bh=k3VzcsYJANMAGGk69XkEJ1vmKo5QHfC/+lJZ4baayBQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fx/siZlSgwTOUZ+Gcf7NsSyQtQ6umRsyKXX1Tw5J+V7KQ8RkMzaYiG0c53RaBJOdNXYCKkE5tbYrygtnj3Oi+Vl5IvDNKan24rcc6h2UhHgEuFBfkyZzbs29QaoMz9o300MXLPpvuA/r06fT0MWrSHOvBAkye557LYaGN+qdXSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMujLNoO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733249465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNRcjw/KekyabOo7RK4b+13ZweRHEdK3B7dyQF8BEAk=;
	b=OMujLNoOg67IFOJP3ajh+w8QByokAI7xPmcH8crcxGc7mMsisHkXAMcXOCIblXOjCpV9it
	7wxauyhU65UeM3UHVA/VjoLNP8rTHJ+WB3iQHhVwoxcYYJJuD8krMLDs8u2G/Q6kJJYyL5
	nyzibXD7MrxbCa7pDzHbtqG3ev/GMVM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-r4-cXU2TNyOef7V8pYPcRA-1; Tue, 03 Dec 2024 13:11:04 -0500
X-MC-Unique: r4-cXU2TNyOef7V8pYPcRA-1
X-Mimecast-MFC-AGG-ID: r4-cXU2TNyOef7V8pYPcRA
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d886eb8e6dso69074946d6.2
        for <cgroups@vger.kernel.org>; Tue, 03 Dec 2024 10:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733249464; x=1733854264;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNRcjw/KekyabOo7RK4b+13ZweRHEdK3B7dyQF8BEAk=;
        b=NZULjNqG47nyRvpPC30ZVKO0zkjnJvzXKyAlvrYSqub1oObqaHDvymMXbSiDw1bqls
         J4X305Lu3PRV9iqAPsoYt430vtmFoOfIv2KInfLzKs64epMK79g5FbQi4zFDg2EbiXI3
         AmsVwc49H/8JsMPKx2WtDDVGmf6wQfRAwrhe1jK57bZbsZJJkpiZSKQTm/eb21d3cEDE
         EnPlqMCsul3A/xU7wuzKKXrP8CBj0dSMTjQsk286ZQNPS/DaNj22IChI1AGXKoa3M3yl
         p55UfVb6cIsP05XvJNbfHUGsfvOutzLowOEhbEdH/qBpU7/uIYv+cHR1szSI0m9vwxCs
         CpEg==
X-Forwarded-Encrypted: i=1; AJvYcCXtvhQz53hM36hJTDGZh2/I6kiCUXfAUGhK3wlmDcnPggEV0a5S8LE61bzeRPHH7kNhxEt7oSDt@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkxWcue/HoNhMZ0ejSmP7cagfn7tg6IMM1cE8ilqcLDUZnKdb
	LXlWFVmEyLTh4QGO2fB1OEoauB2KSEREupR4ewp88tv3Qi8++BwBnFcfn6nDSzpEnmle8oXNqmI
	91wSS6rgKvfJ/NGCvbRm7be4XitPE3p7wDHgH/KAyUAOVixb+CVIXixY=
X-Gm-Gg: ASbGncshUYohAwxsDHFUn+MfzLZHBhPBJw8tcC/6Mv4yqY0zoxnQnlNLAWElIkXYR8d
	JygcBpoxRPNIiNKc4bnfbwy7Wf1MLA5MGEI0Nbokh13pjeHSV5ml9vkvgPcz7UvWLG3u0gnGHKW
	0wbhH4emsJfY3Yt+CwLj6RM6PBZPtI4RZfFViprAMOPYgjA4YkH6sSaIsMbaoHd45pG0z8pbmbG
	RUbGvpdIrhpoC05nUUvBSLwNZuy/o3ZCJ6CGKQOF97/t7rTSbBtMJ2Op2T0Mz408+zP0Wu7BVsI
	ivthdsOY09xXoDNXSQ==
X-Received: by 2002:a05:6214:2683:b0:6d4:27fd:a99d with SMTP id 6a1803df08f44-6d8b736bf12mr55393966d6.19.1733249463828;
        Tue, 03 Dec 2024 10:11:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHItFz5pbgu6NiS3RK7eDf2oYnjAmEEXaSpaC5Xaf8OxQN0zjiZG2K1X0Qdl+wi3VOAPQfNrQ==
X-Received: by 2002:a05:6214:2683:b0:6d4:27fd:a99d with SMTP id 6a1803df08f44-6d8b736bf12mr55391666d6.19.1733249461923;
        Tue, 03 Dec 2024 10:11:01 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d88c634940sm47830456d6.130.2024.12.03.10.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 10:11:01 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6f31fcdd-82d3-4d37-a730-607ad7ada260@redhat.com>
Date: Tue, 3 Dec 2024 13:10:59 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Remove stale text
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Waiman Long <llong@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241203095414.164750-2-costa.shul@redhat.com>
 <8a50e837-a1a0-4636-802b-4573c3779aca@redhat.com>
 <hjyhaosr2c5dsldlgzzsqedxzy3xd2e74ibtpxguz6ymbzqu2g@zs436iuhlnll>
Content-Language: en-US
In-Reply-To: <hjyhaosr2c5dsldlgzzsqedxzy3xd2e74ibtpxguz6ymbzqu2g@zs436iuhlnll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/3/24 12:21 PM, Michal Koutný wrote:
> On Tue, Dec 03, 2024 at 10:43:26AM GMT, Waiman Long <llong@redhat.com> wrote:
>> Thank for noticing the stale comment. There is actually no task's cpuset
>> pointer anymore.
> Yeah, that likely evolved into task_struct.cgroup css_set pointer. The
> "guidelines" for it are in sched.h/task_struct comments + comments for
> struct cgroup_subsys_state.
> Also, users may need css_get()/css_put() if they needs subsys state for
> longer. (This info isn't actually cpuset specific.)

Yes, that is likely the case though I didn't trace back the git log to 
figure out its exact evolution. Anyway, these information are optional 
as it is not cpuset specific.

Cheers,
Longman


