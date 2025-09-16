Return-Path: <cgroups+bounces-10154-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B730B58DE7
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 07:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A513B9246
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 05:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560202C0268;
	Tue, 16 Sep 2025 05:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjYxjFMp"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA6450FE
	for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 05:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758000549; cv=none; b=cIveM3mzwTqYAvRpvPpGk1okbVD3YuowMOnR8W5w9eVElpwk30XxQLaKzAKglO+zWskAY7YG4mQYLyGtmiw/cOuHGMurbwFFP467V3nr4i4cxvdfsugr2K6ohXLlL+iBYAFEp6IUBIBLPqB5FT1G0BZeNu2UmeOVVzL4zXwj04g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758000549; c=relaxed/simple;
	bh=BKHUIrqFsuvwuTWnQKw5vJZ5u30AF4W8i4vNBpyVBWw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bi/2Bl7RhDplQtuw7tk+FqLWitU5aZsaUJm6wwEOUJMa1P2Ec9jDF6uWTq78w5KYepEOz0bkCWdgi47UUeT6iujei51qjohgBfKEwl1CGOnqZUJWiFCrLdaKhXiHCg4/IJpArnSjdLbqOii71hu2jrTpqDBaDIz0uu03n3dhKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjYxjFMp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758000546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKHUIrqFsuvwuTWnQKw5vJZ5u30AF4W8i4vNBpyVBWw=;
	b=PjYxjFMp/ZndKHQM0tmEEyQrLJ4JlSSHK+PXSth7AwDLlCbIXV/ATvXTBKpHP0N4puMPmY
	n/UdB9eivGhEDy5XsVwjk7u8tiU+Zre7pVWuKQFIR4XFW1qGhKWVwS18ldTmzdYItdVnh3
	Ak9foyUyhtoiqgQsnbs/ypW49lcEMEQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-OpCzcgO-PwOYGgnCo5ks4Q-1; Tue, 16 Sep 2025 01:29:05 -0400
X-MC-Unique: OpCzcgO-PwOYGgnCo5ks4Q-1
X-Mimecast-MFC-AGG-ID: OpCzcgO-PwOYGgnCo5ks4Q_1758000544
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45e037fd142so41222215e9.3
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 22:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758000544; x=1758605344;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BKHUIrqFsuvwuTWnQKw5vJZ5u30AF4W8i4vNBpyVBWw=;
        b=ZnPsNkKYw0/Hz8BJZye955sDUl6WrLDQw4P/juOMvdP1U6w1qa2H+f6AQ20m9D/dZm
         rG3f5y+BeQAThZd033GppQXXGwrIY3ysQcr/keX3K0YfOnF61VHfg0EBeucgWvZE28L4
         RblpsSwk15cImnPvGF61up0vOTadPFGD8L5D5fCWcirA46FHD4WF8LyTXcwdRcYxINCa
         acw+jmnCDdePAdN77Lme4AjjICztH6tTxgldQtHq7l8a5k1zCKfInI6afG8uOC56CkpX
         3QirrAmrjHLAKffzS8i8KhdI/K+tW/8oRHECXlX8R4ZCLb2rEgTdIf4z5MxRXXjuaFYX
         qcYg==
X-Forwarded-Encrypted: i=1; AJvYcCU5AMYD63e0fU3dGryGoxBngzjepjj+Uu+IUXb3Q05Y9ozehwYlDBSn+1QTbzbQ01vfF5uL40BA@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCLWMkvaqH95x3TaFEuy5cOX6FCQPxTHub6OC4XRipdGjLRJi
	gy1+kJ77EyFhe0RL06wIuT0RuIwYlNqGXMEmnQ+4WmgUw3qvMJiOzv5G+eP/jUBZDEi3lVo9Wp2
	jOOLvp3g/dGt06fVUhlXFox1Y8mg/PXEf/LeOaCjrbPE8GX0B3o30VlMmuxY=
X-Gm-Gg: ASbGncsdHYgj+ZjZ2H9Sury0bsAMPZ3emuOtWssoWxAICde0Kh6fOZGSyi9fmAJKWNU
	CpUpv/iB1kqREg3MUedMqqwDfBwEBpG5o6ZqpBdRnLjAS8O/2C1iWBZNrJqjM1/Bf/0VMRXIwDg
	2WWSbMqGudjXa91D/1HDgS9f4WuV5mJlo/+iPsN6/9fsRC6cPh10u8HjOR86KSIyh8j2xQcz4GG
	nGv4axGNw9bW/7wXyyOeioM4ckfInt+agvwsldHlKAtj7qgLR/sc3qdUP5J7/coVgZ3FpiHPjhI
	B1XFI+aXgmJQwQJVmWaTpZa4pFtoWcA/Jdny
X-Received: by 2002:a05:600c:ac4:b0:45b:7aae:7a92 with SMTP id 5b1f17b1804b1-45f211f6a79mr84634815e9.21.1758000543718;
        Mon, 15 Sep 2025 22:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzLzcxfLcqGiZREnvnjRs8fUJKZdnoz2ZmiZpt7eoK0q6w1p4bhVVaML4i8MFbXJZn3wIKGA==
X-Received: by 2002:a05:600c:ac4:b0:45b:7aae:7a92 with SMTP id 5b1f17b1804b1-45f211f6a79mr84634625e9.21.1758000543353;
        Mon, 15 Sep 2025 22:29:03 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.132.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45edd9f75d1sm184329185e9.17.2025.09.15.22.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 22:29:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 05:29:00 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Message-ID: <59a5840f-2754-4478-8c4d-ffca02b1ecf1@redhat.com>
In-Reply-To: <aMh8Oq6El_xV9Ls4@thinkpad2024>
References: <20250915145920.140180-11-gmonaco@redhat.com> <20250915145920.140180-20-gmonaco@redhat.com> <aMh8Oq6El_xV9Ls4@thinkpad2024>
Subject: Re: [PATCH v12 9/9] timers: Exclude isolated cpus from timer
 migration
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <59a5840f-2754-4478-8c4d-ffca02b1ecf1@redhat.com>

2025-09-15T20:51:21Z John B. Wyatt IV <jwyatt@redhat.com>:

> On Mon, Sep 15, 2025 at 04:59:30PM +0200, Gabriele Monaco wrote:
>
> Your patchset continues to pass when applied against v6.17-rc4-rt3 on a
> preview of RHEL 10.2.
>
> rtla osnoise top -c 1 -e sched:sched_switch -s 20 -T 1 -t -d 30m -q
>
> duration:=C2=A0=C2=A0 0 00:30:00 | time is in us
> CPU Period=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Runtime=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Noise=C2=A0 % CPU Aval=C2=A0=C2=A0 Max Noise=C2=A0=
=C2=A0 Max Single=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HW=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NMI=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S=
oftirq=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thread
> =C2=A0 1 #1799=C2=A0=C2=A0=C2=A0=C2=A0 1799000001=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 3351316=C2=A0=C2=A0=C2=A0 99.81371=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 2336=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 400=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1799011=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 23795
>
>> This effect was noticed on a 128 cores machine running oslat on the
>> isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
>> and the CPU with lowest count in a timer migration hierarchy (here 1
>> and 65) appears as always active and continuously pulls global timers,
>> from the housekeeping CPUs. This ends up moving driver work (e.g.
>> delayed work) to isolated CPUs and causes latency spikes:
>>
>
> If you do another version; you may want to amend the cover letter to incl=
ude
> this affect can be noticed with a machine with as few as 20cores/40thread=
s
> with isocpus set to: 1-9,11-39 with rtla-osnoise-top
>
> Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
> Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>
>

Thanks John for testing again, I'll mention your results with the next vers=
ion.

Cheers,
Gabriele


