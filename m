Return-Path: <cgroups+bounces-12194-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D982C85954
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 15:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89EB54ECC52
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 14:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5434B326934;
	Tue, 25 Nov 2025 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7flF5GI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4rnzlyC"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823B31618F
	for <cgroups@vger.kernel.org>; Tue, 25 Nov 2025 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082402; cv=none; b=W/W2DcgCTil0o6uK4ENUVXRv6kx6Ti96VGSv7vUY3ZMSdGrj/47D3x2lhqYiou8h1AdVYxBJzQ94F5WWOjg7v9m+Bey+Vx8gpldd7jO3NaMsk9tT6P8rW0hHWsSaQTHLQaCkn12lHC0mMMVKh+1JK8zc74g2Ly4H2uyX5wVP3nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082402; c=relaxed/simple;
	bh=0PCRbeaHX0YVZV/g2SjyMCT/hVNmfl8Nd/U1OMU7jHY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CyUDUjSYxTuqGNiQoQy7l5oq6wmRqJ4a8LsJ5Lkr+nMpKo5J/rZGsO6xMe5KTOOpllGdp1Ly/Nm2TgAE3ljaTZrVbSkWQSX0h4HFHMW9E/dJ2JElGxfHMlroGiO//ojzwGbks9isvoblNUaXjeZ9x5JcQ6p77y62qlRkLKCdoVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7flF5GI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4rnzlyC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764082399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2epyRn5CwN0iu3xVKn0E3TSNJ1e4isWHAP/IDzSewc=;
	b=D7flF5GIS/FeAaS9Lie+KhyR+bMUecAkZZ+7yEcuZFi7FtlqKUdNHoBVq344vKzrv5JAPz
	wbE2UgQ8lUujrXcPgwPxR5u5YPBR4XA2U8XInw453cADOFOcdJmwALyCDg7HVQxBkJ9rMA
	WAKJuryL6U9/iOhpJCJ/3SmzpoH9Lrw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-mHcrA3jWONKkS7zCjQ77_w-1; Tue, 25 Nov 2025 09:53:16 -0500
X-MC-Unique: mHcrA3jWONKkS7zCjQ77_w-1
X-Mimecast-MFC-AGG-ID: mHcrA3jWONKkS7zCjQ77_w_1764082396
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2e4b78e35so1284205985a.0
        for <cgroups@vger.kernel.org>; Tue, 25 Nov 2025 06:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764082395; x=1764687195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h2epyRn5CwN0iu3xVKn0E3TSNJ1e4isWHAP/IDzSewc=;
        b=g4rnzlyCrTJ7aYYhKnHfzGZONH6ai1SmUOVjSRX9xU2K+E9PFXi4VGiAjQqmrQngU3
         PEMYadIqRG+oMyQCn0u0TeTMaZdoInfmLd4oEWu51hXSfPiy/sZKRCCJV12myVKolH6E
         FVXNQhXm19kM1Gxbn952m/Igm4KRx/J64e5wF5RVQmuaNIvmcXW13UngWMdkrjAqT+d3
         lMtGYPEL8jg7bEuA4DURe28TyNPCC2Q39LQtbC4rU0ptaROVp7QWuW2C/Frzf7duHbfn
         QMJUSvNJblbdbySh3ixlHQvlvkPtsna0SVps/zUB+K71i/E0RodUV2HByXg+vqw60lBE
         7VBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764082395; x=1764687195;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2epyRn5CwN0iu3xVKn0E3TSNJ1e4isWHAP/IDzSewc=;
        b=cYy3Jbqxv/P7M43QyCfWmuTlpaZsj9yk8ind6qjkCx1rZ2c6eWZv7f7lyJJLi6hZdV
         EVQm/vBv57jxyS9X4ujy0dLWHbFBxLv4ffB+9AhWKmyhHZwR2fXYQOxNnz5m9tK1ifOu
         5t1H0yVVtLL24l30WA6agmATJ3zwag9RyWqgkQT3hzRvEh2iwsuyp2bmBgpR1qHhLkhv
         Dp9Qsw+xR0qyHoJyArVRMQ6atyWLkjiIydAg5+nnTQqP9C5DpGnD7Dton11jUQBvTsbB
         waNUjJ0BvZQzqt89WHxvLDNRX/4V9xXJ/7dSysQtdM7sIAVzb0KEeC2OG5H8tZI1CObz
         6+uA==
X-Forwarded-Encrypted: i=1; AJvYcCWW4ZmT4sVSzB3y6jJXE0A3F3+FsSAwPGM0EoAc4c/usOqLiunbezbhFR2bCWY+KtLkuJRddCUv@vger.kernel.org
X-Gm-Message-State: AOJu0YzB+lLmB/TxE/h2ZZ6jOJi+JKn9q/n8lFS5th0uxhW2TK2TJ0E9
	MuK0AZtpr7XxHJKOZP+MsFyQb4HmLC1zyayAL/p/iuAWPubD9CNK+tyDyYNJIqOq7BNVO9eUOXC
	emNzkYDOXenBKm85mkCbsv1XoM5r0vbmefL5mKcK+9z2V6mvcA+z/DXAviGXzdSJ2iiw=
X-Gm-Gg: ASbGnctQJs8FsDL2hFB3/A8LVaBZXZYmhQbXTqIjMVjKDwS2qYBp6VHwtvZLUhkGbED
	sKGUgYp0zohZQSgoPE6SCSIqGKYiMYIOSNefWdlnZQsRzhlGsvj5Zvz7fP3VjqT8ijpFT6zvX/D
	yb3p3YqYpS8dE0cTXjic60+Zl3Ruv4C0OBFnWGzq2y6NNY1jdEm4WeJzoN1Z1mhZMooHoOTMhyg
	YqI6FXDpQ1f0rwTTNGQ4LCdBQR1zEA5kWaKs7sTXzVVZh+xXsqCrmUab8kiNB6qTivyoZXNPdrD
	Q9AbzVww+pV1uwcDtWg3C7vlMZkZ3pDYcaCeWtBE7OkdM6KMNszhx8bzZGwXlkMPjKUQAQfbeoE
	KSO8JU3XQUccWwclsfX5n1SOUe6Z/SNw21hDVbI1Row==
X-Received: by 2002:a05:620a:4090:b0:8b2:213a:e2e4 with SMTP id af79cd13be357-8b4ebdce632mr427148085a.84.1764082395341;
        Tue, 25 Nov 2025 06:53:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeYGHD2Sox4NZg+sCtE9ybtvcuFOKoLi4Z5L6L1LWMVy0ZzQmCDnKRTpWD14CwOrzCejoZpA==
X-Received: by 2002:a05:620a:4090:b0:8b2:213a:e2e4 with SMTP id af79cd13be357-8b4ebdce632mr427144785a.84.1764082394936;
        Tue, 25 Nov 2025 06:53:14 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db3e3sm1182631385a.43.2025.11.25.06.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 06:53:14 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <38babaf0-4e27-4e43-b165-55c28172a3e1@redhat.com>
Date: Tue, 25 Nov 2025 09:53:12 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/2] sched/deadline: Fix potential race in
 dl_add_task_root_domain()
To: Pingfan Liu <piliu@redhat.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20251119095525.12019-3-piliu@redhat.com>
 <20251125032630.8746-1-piliu@redhat.com>
Content-Language: en-US
In-Reply-To: <20251125032630.8746-1-piliu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/24/25 10:26 PM, Pingfan Liu wrote:
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
>    sched/deadline: Remove unnecessary comment in
>      dl_add_task_root_domain()
>    sched/deadline: Fix potential race in dl_add_task_root_domain()
>
>   kernel/sched/deadline.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
>
For the patch series,

Acked-by:  Waiman Long <longman@redhat.com>


