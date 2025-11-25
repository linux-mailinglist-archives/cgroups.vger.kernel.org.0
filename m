Return-Path: <cgroups+bounces-12188-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD3FC83EEA
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 09:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECDC3AC720
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 08:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FCD2DC32C;
	Tue, 25 Nov 2025 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvOBX0oy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLSgs6N1"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123CF2D7DF2
	for <cgroups@vger.kernel.org>; Tue, 25 Nov 2025 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764058472; cv=none; b=g3yVYJw9ihL3TR6u0WfkKdhrK4wMYNGVKZ9FLIXPDjM9oLSNWTEYpDrnkjI2VXnUj2MZ90lkC3v8gQubvDST1d1RvtBTSnvXKhr/kuo9l26uHQb/vVgvgmTwGcKDOJVVBYa/ZjL5wzW2ma3E6uUZwU6+wiiWtuaFoyh63MPDJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764058472; c=relaxed/simple;
	bh=fmN/vdr9QLuZJCO3el8NZ/Pjg96Cn+Jgj/6mfw8tAcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQSQAcRwDe2UaNi4BnZ9Jf2/wcQuRJOoVqaHF3PAnx6lO4urNks4CwEnEAjr2ormwfM7ZBJLqIPdYiX6PSdEz7r4FxjVjVSKN/4Or9MiJ8rq2nrdhDO51WynuMZrfH3pfN62AKv9kqOk/16dGr2vX1TIrSg8JZ5rNARgwhnnm6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AvOBX0oy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLSgs6N1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764058470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tR5DmES8uSbD2+GMBFdE4pP0OP1DcgWP/wlgWinI09I=;
	b=AvOBX0oyocil0xdjtOaM9MwSrAfo2WTQ9EcpzvmiXDjQXb3PE/VZKdQbbGku2JfzvtM/Hh
	jF9WK4aB4rcq0GcknTSnsU9V3qkkqn2gTRj53thlDhA7tdwmOzWT+yp3fx2v92WzX2nPS7
	6f7ZoPk03/NrPxGCH8tVqhGXxNo5uJg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-OoP2INNFP3O-yJem4jFZMQ-1; Tue, 25 Nov 2025 03:14:27 -0500
X-MC-Unique: OoP2INNFP3O-yJem4jFZMQ-1
X-Mimecast-MFC-AGG-ID: OoP2INNFP3O-yJem4jFZMQ_1764058467
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429cbd8299cso2491583f8f.1
        for <cgroups@vger.kernel.org>; Tue, 25 Nov 2025 00:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764058466; x=1764663266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tR5DmES8uSbD2+GMBFdE4pP0OP1DcgWP/wlgWinI09I=;
        b=fLSgs6N1er49fZEZFkOve+fkL4aQgLEYUiKyznmzKBQl2C0wx0HgJRB9bfoAHZmY1w
         bEviCr7ns4XcsrpWe4Y839DtBaJ8CvEDADm+einsCNokVCTMm4xpnIptclCRWLUZzRcp
         c3pyVOn5W+5dxg+TwyrNd82ZOxGA6FI2URVt84WKMRhdqIKBmSM9CftNCh8DpUzujqpw
         Ec4fuThPs1k0jqwAP71NIS32mpS7Af2451qvtnRh+k6+fWWRha5I0FezBStJbmE7428Q
         Km66LEqd+ygRTtwS+Orzn8NlJamZj04YSxWeBvXelJP1Xk8EFsn+iudR92vRRXRfm12N
         od1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764058466; x=1764663266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tR5DmES8uSbD2+GMBFdE4pP0OP1DcgWP/wlgWinI09I=;
        b=YlmH1/RUjITocLCs97v5AT7AY6YxrqLa5rbVnYXk2ftTgYVfVYIUV1gyIs0JMp7DOL
         4HkBicUiePIl2hKgZLMDfFspSlV0cy9yUXunFR2IrwAVBl0j6+BcdXPVrEXsCHOfDsfl
         JA0hMuVaubYdCdI9MdzlItK0/jtbTcnWRX2dMEtEPOqhX/9beaEUgX9YA8Z2nIb9wSMA
         LHNuG5oc2aga67Dh2wzdrcLLlPGBCPC46FycWZmNceR7VXxy4QH7XLBKZieqcl0nK9Iv
         V6uOASNZpeGP8UUXvicdtkH2HsbpiLlg8YbDfvfPa270c/p9UXKUS+6Ak99jeBvkwtu3
         1+tw==
X-Gm-Message-State: AOJu0Yxt8vNRyXuwMmV11b460TUgMe7UluWbFguQEzQOs6jCc8gtcu6c
	x20Lb+UzfNsncr6a0uMz9RNMjMF0qSvxp58MAZR7GlkaC6L+3/bcdO9xCCuW2xBrQrSGWYk7xTr
	kO4013noUaJJBPMDXeAzmtBdk2PDevM3dH9SEsM0FjnehT3JEovnLFymVkeE=
X-Gm-Gg: ASbGnctIU3cTbcqjR1I3JCMd+s/jLL37logMO0cr7C/paHmNgrSKmn+gW35UKEMVUQ+
	RiaC2n74dmoeb28FnCLrkM0TxyHgtdkub+1yPhg+9bgY3SQyMpPUFzN1BAehdimi0h3WiW/A8Gt
	vXlKFfjNHxPdbob2sPOZ/kpg8LtzStUTS5S8313iVJEe/CvY0gZHg9wjpL09X4IpWpaBgeku31r
	TeK7Kp7P4B+ZKReBw/A1QKUipUJ6RDYm+hFLhOGoIn5X9yo5/zDHoIREXVn8qDfpwNPMRUQfjTJ
	nLhVNUNd7r5KPDs90eQVQw4iY2Ft/RFYzEpgaHQh2f88+mywzLDlWuAiloVP33wVoQuvwDQWpMW
	hvhdDry7O61OyhYycyUbF9cBkhYudKEonE1eZAi51yy6XgEWeZIH9KyemxpT+68Yk7ftgEw==
X-Received: by 2002:a05:600c:1d1d:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-477c1161c38mr144139695e9.34.1764058466497;
        Tue, 25 Nov 2025 00:14:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmrT84+mqhTpfJITjeshDWtLmxrNwW0PAPjTjsebdsTEH9UudCMFb6FabwP2Teag5fZjBJYg==
X-Received: by 2002:a05:600c:1d1d:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-477c1161c38mr144139435e9.34.1764058466096;
        Tue, 25 Nov 2025 00:14:26 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-2-99-207-158.as13285.net. [2.99.207.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf355933sm244081065e9.2.2025.11.25.00.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 00:14:25 -0800 (PST)
Date: Tue, 25 Nov 2025 08:14:23 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCHv2 0/2] sched/deadline: Fix potential race in
 dl_add_task_root_domain()
Message-ID: <aSVlX5Rk1y2FuThP@jlelli-thinkpadt14gen4.remote.csb>
References: <20251119095525.12019-3-piliu@redhat.com>
 <20251125032630.8746-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125032630.8746-1-piliu@redhat.com>

Hi,

On 25/11/25 11:26, Pingfan Liu wrote:
> These two patches address the issue reported by Juri [1] (thanks!).
> 
> The first removes an unnecessary comment, the second is the actual fix.
> 
> @Tejun, while these could be squashed together, I kept them separate to
> maintain the one-patch-one-purpose rule. let me know if you'd like me to
> resend these in a different format, or feel free to adjust as needed.
> 
> [1]: https://lore.kernel.org/lkml/aSBjm3mN_uIy64nz@jlelli-thinkpadt14gen4.remote.csb
> 
> Pingfan Liu (2):
>   sched/deadline: Remove unnecessary comment in
>     dl_add_task_root_domain()
>   sched/deadline: Fix potential race in dl_add_task_root_domain()
> 
>  kernel/sched/deadline.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

For both

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
Juri


