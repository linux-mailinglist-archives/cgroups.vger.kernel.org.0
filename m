Return-Path: <cgroups+bounces-9273-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E810B2C074
	for <lists+cgroups@lfdr.de>; Tue, 19 Aug 2025 13:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715AC1BA6CB5
	for <lists+cgroups@lfdr.de>; Tue, 19 Aug 2025 11:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C9B32A3D5;
	Tue, 19 Aug 2025 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQG59jPR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF4322C66
	for <cgroups@vger.kernel.org>; Tue, 19 Aug 2025 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602942; cv=none; b=d+uTE2EqfrVO+1XhAndFNEOr+yqwvP91JLRBWllP6swcjuCOqVTMZ9gnnMCksrNlpV0aYc58wwWi5Rk4ifOyGoHhmT4/KA02YkRKXTdjHFjlid3hxVh3hC9FDG6Vg8TbblXFH8QQNMrZiJpqYsljZ6A7k/C2s/+HnpjObeCAhAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602942; c=relaxed/simple;
	bh=yN/tqf88Q58Z6H9EMyDAffkiYLu52FY0x2WiMpB40Og=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MIFIlXLglEZOvQnqgTtf0ObM4AXe7jVC3Gzbhr8Oqx+PzcLncf2tdVOeqCgvjWKAJvhuBdIwATcWTzLTSABsEco3NnLyx9Jug5bMPzUWv2gLjaSqxbi+WT66GQ/yTFRt1P2wOqTPjQamaTFrdfIYst6hYpAZ/LZBk1zUYNZ5LfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQG59jPR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755602940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yN/tqf88Q58Z6H9EMyDAffkiYLu52FY0x2WiMpB40Og=;
	b=SQG59jPR2S4dYhax/LT4mBwDAZHaGkoN/5ouXgXPi2o3jzvGeD4PFWQo3iUsB4fszOpYMc
	kAFtOszUxCX6n53SJ8hSZQpSRMojnCKpLTtaSN7Uc1B/8+bzhJU4Rt9W+NKq5/1qJsrzjh
	KNZ8Rmk1iXvB9cq2wcIfJHP4VVROo58=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-s-1tW0lENRmZFwIGJmbQsw-1; Tue, 19 Aug 2025 07:28:58 -0400
X-MC-Unique: s-1tW0lENRmZFwIGJmbQsw-1
X-Mimecast-MFC-AGG-ID: s-1tW0lENRmZFwIGJmbQsw_1755602938
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b1292b00cfso32876491cf.3
        for <cgroups@vger.kernel.org>; Tue, 19 Aug 2025 04:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755602938; x=1756207738;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yN/tqf88Q58Z6H9EMyDAffkiYLu52FY0x2WiMpB40Og=;
        b=m5xyBFyIi5BvXLyrJFJ0bYBGRSmB5MIYmRE/optyYnUmDTDBZjuNBw2x4hV6R85rry
         dVM6UMPlUUjGTtNnIpfZcuYG7dpKS4mF67Ce4IVYvNRBYQJtvucFMteab7Z645tXqi9R
         2/43Ai8mpQthbhzxjzG/ZMKgv6tP8Fr/+NqENF2z6U+p9iK2Qy5h6n2D31u79D8Me9O/
         TZSF/OhHTCommNpqTj4graigzcErJ4ddyMvgOC/dKK62bgDVRadJl9LfsNZLD3dbWyqS
         IHvqDJf/joE6K4w8AVI1HYcQ9HpbO93aUyi7DlD4CyjyxRZm6DsjrOo8e/H/s6ZQ9JyW
         n/lQ==
X-Gm-Message-State: AOJu0YzSAQOh3Kyn5udpI1QsPQ43cOlaHXLG8lvgNjrflfRnYuekiz71
	Jzsy6CKwwOnw+nue8U14G47G/hGu6CANgEjcg/KMZXq5Ki78eBxMzcsDgyY98mNA31JtWpHeL0B
	YqTeV8NB77C9PGPNnxKI14YIkpaIhtXuwXxJSLqcDG+JvJJI3YrNPH8BNkfw=
X-Gm-Gg: ASbGncsCJCqpofE1xUZm88ZAKCkIy9fgddJ+z8X1NEgyD0Rp2pxnWbAQZh8nwOEAJJJ
	zRo1frI7mapSJXEKoU2EF03OEQDfGiwOwJ9WaQLP3l3NhKsKxS5YPvAf4ZeW2Zg5V6ZnbkuLNRr
	A+zU0+W+/ShrvUVc3RmyABes76PZwvCtO4itk/lzNcrMnvvPyIU9Rd8AVz/5BL3zmgYoyo9jESH
	F8n//S7I4VoqOIPJssui20OK7xMIN78+bezVicpnmbq32dmLYPgmfOA699HVdY4CNdCZFQkdADJ
	bXS3T9EcC/NOdjwGHAGLKO6JaYPKwmi1psOPZjr8JUehEDLA2rRm/VjzS1bY4Ro9cA5z86HduKa
	rc4c0HEN5JGZMOGmZTv1yjCh0
X-Received: by 2002:a05:622a:1928:b0:4b1:dd3:e39c with SMTP id d75a77b69052e-4b286f2e04bmr20483001cf.63.1755602938115;
        Tue, 19 Aug 2025 04:28:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPZBzGDST7GlM+XQKmde0ePwa1UT5EmiwV5BKA+4YIL0w5B15B4PBW2ZtFZBedOpfvVu+fsQ==
X-Received: by 2002:a05:622a:1928:b0:4b1:dd3:e39c with SMTP id d75a77b69052e-4b286f2e04bmr20482811cf.63.1755602937732;
        Tue, 19 Aug 2025 04:28:57 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc5a17csm66426751cf.13.2025.08.19.04.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:28:56 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Xin Zhao <jackzxcui1989@163.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, will@kernel.org, boqun.feng@gmail.com,
 longman@redhat.com, bigeasy@linutronix.de, clrkwllms@kernel.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched/cgroup: Lock optimize for cgroup cpu throttle
In-Reply-To: <20250811160454.884224-1-jackzxcui1989@163.com>
References: <20250811160454.884224-1-jackzxcui1989@163.com>
Date: Tue, 19 Aug 2025 13:28:52 +0200
Message-ID: <xhsmhzfbvh7nv.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 12/08/25 00:04, Xin Zhao wrote:
> On Mon, 2025-08-11 at 22:18 +0800, Sebastian wrote:
>
>> Yeah, please have a look at:
>> https://lore.kernel.org/lkml/20250715071658.267-1-ziqianlu@bytedance.com/
>
>
> Dear Valentin,
>
> In addition to the information in my previous response to Sebastian, I would
> like to add the following point as a reason for my self-recommendation (to
> explore my patch for solving the cgroup performance issue in RT-Linux):
> RT-Linux is a system that places a high emphasis on real-time performance.
> The fact that regular tasks are also included in cgroup groups and throttled
> suggests that they are relatively low-priority tasks that are not expected to
> interfere with high-priority tasks. Therefore, is it not a bit too late to
> impose limits only after returning to user mode?

Throttling is purely a CFS construct, and does not affect RT or DL
tasks (outside of the lock contention issues we're trying to fix :-)). If
an RT or DL task needs to run, it'll just preempt the CFS tasks, it won't
wait for any throttle or other mechanism.

> Furthermore, when a throttled
> task is awakened from S or D state, according to the logic of "imposing limits
> after returning to user mode," it could cause that low-priority task to wake
> up associated low-priority tasks one after another, leading to a sudden
> increase in running time, which contradicts the relatively precise CPU usage
> targets typically required in RT-Linux systems.

I would again say that's not a problem since those tasks are CFS.

> Additionally, I believe there are still many areas for improvement in my patch,
> and I hope to bring it to the community to gather suggestions from experts to
> see if there are areas for iterative improvement.
>
>
> Thanks
> Xin Zhao


