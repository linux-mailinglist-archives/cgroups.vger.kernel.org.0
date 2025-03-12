Return-Path: <cgroups+bounces-7009-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC41A5DE0A
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 14:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 682977AD7E2
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 13:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E4C2459C2;
	Wed, 12 Mar 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVsB1ifP"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AEA22ACD1
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786343; cv=none; b=YcV7JG+Zyp8Kdy0PRf6709MDN6hdMFEfksZqVsQEcAsG3LBnJdqccRX8TTosZtedKiVA/VHeh2kRRHgXeLEP9hJLFkdZgXr+jrq2xzkoplN8TwE/8VB+ad/FeHGhV5z024AZ46mydeHBa3VBTKDJKZB94z2oUNbzPdUFT8+HvtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786343; c=relaxed/simple;
	bh=1cWixh968plrgs9DFJw4Oq3vwwUksg0Laamhx8PZPYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HcpCvjSLjXyRmdl7ESbCVSI0FsFbh0XF8FcLGEFkDKYPtopaGJh//OCa8DSswg1+HRPkz+E5Jd5Lkun9pwN42K/brgupWwkHwhSAxfLxiBSWSO1aoaGOpQC9l8dwPQ+zzQeNWnaRyIwt0X/hL6SFt2fLpS9TkK1mGoLb84uRE8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVsB1ifP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1cWixh968plrgs9DFJw4Oq3vwwUksg0Laamhx8PZPYE=;
	b=BVsB1ifPieZAin16caQQ1iJFWiMoscfDnZ5yPC0QCMCimyN0x+pZotUQCAs35F9uKkV5fW
	aWVxEVK3RydYHFfGG7DIj7CWcjZ0+BxAAJnu2U/koHQ34bJxLzLXc/neF84D5EWKoLTgQQ
	ozf+iS+1i/7S+XPrbrcicFrnqcU/Un8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-hkB_ls94MOuTjW1IGlnjKw-1; Wed, 12 Mar 2025 09:32:19 -0400
X-MC-Unique: hkB_ls94MOuTjW1IGlnjKw-1
X-Mimecast-MFC-AGG-ID: hkB_ls94MOuTjW1IGlnjKw_1741786338
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912539665cso408780f8f.1
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 06:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786338; x=1742391138;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cWixh968plrgs9DFJw4Oq3vwwUksg0Laamhx8PZPYE=;
        b=KkIePCf2hO2HnUs6y+nwYcZi7ovvGvQV2aXweXiUdY4KbrcRvE3x2lGjA+6p7MwV59
         SQIkM+RVM0ccMKra/4kL6jNlbqH9chttKM68XT/r/YNkoyrVCaiuUHxc8HdSLKfR3J2P
         Clj3A4zAawXfWNIhJyz1en0EtEQuUNldpwhpVrwRscxrvSGUTvK/8L5J4Z2tKZ9+YtEm
         cAquxBI1/3CUU9rFoQyGh0JdUJbO/v8ZZyD2HxuI/mWL4zrWeCfSxLowRJAWDM3GcCjr
         fyMcrm5ddDLvS/THt/k8mw+QLQ5K8wjvk/AG/g3KzR4f+9CIB+vF/VXA8VFQb13Kx0Zh
         Nptg==
X-Forwarded-Encrypted: i=1; AJvYcCU1vDuvxXx4lqdDoBymxnsFP7w422Kygcrwzww7JRLbgn+Rv54c8VS6IVNzerFIiRb7oj7N6Ds4@vger.kernel.org
X-Gm-Message-State: AOJu0YycdrIKtOM46WUfgEUf08EXbDKTFGPIljVC7mn+6nqKrxgTM6Rj
	WCnq2FTOU2rkUVtJMnmYezo9RxhMFvXe9A5ekQbYTUqRmn1ynGkgIqjx54uZiYIikbUa6GUqy7r
	IHEhMt489YC2TAzMyJryvvou5lB5iB+OmxarIw4oXiEBprcDMjEArNA4=
X-Gm-Gg: ASbGncu9YzprYuKWbLl/nBVj4lQPxIrf3LLhaWHvrvQ4GWhE8xCu20WiF2f4Y475GyV
	15PLzStBDDPlDjjczpcFTIaE4KZnDwqLQ0VKWDKm6jLpe5oXaqpcV7QYt1LD5pr7KO+Yq8dMv9z
	YjQ3arCmlIVIcnta6QtCchGXaIS5XRhw6z0FEz/MWuiErtceSLlywdbAo12EtrvjYXTeRl8+IwG
	Y6HDieyQNORfUmQUVSc8XXVur+fYC4WjFfoK/yH5kuqUcpJAhtu7wpSqjzSBshcVTnOr2rVbZwW
	GvflfMsyF7tBaLUEKGJAz3WbDf9Grdo/mCV8IG6O0y8h7LqLBhgWNM5+fmr6GnX/cTW4yfkcloP
	f
X-Received: by 2002:a05:6000:2aa:b0:391:2884:9dfa with SMTP id ffacd0b85a97d-3926c8857cfmr8359702f8f.13.1741786338148;
        Wed, 12 Mar 2025 06:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAs3oOT7v6n4w2AauMkyMccFBCDAzBZ2SKWm8b0JnBgGqKoxB79FBQoR9xC12OHr9ON8VKQw==
X-Received: by 2002:a05:6000:2aa:b0:391:2884:9dfa with SMTP id ffacd0b85a97d-3926c8857cfmr8359660f8f.13.1741786337746;
        Wed, 12 Mar 2025 06:32:17 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-394bdd9fc74sm1360766f8f.64.2025.03.12.06.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:32:17 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Waiman Long
 <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef
 <qyousef@layalina.io>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it, Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 2/8] sched/topology: Wrappers for sched_domains_mutex
In-Reply-To: <Z86xzGyT3av5dh1p@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86xzGyT3av5dh1p@jlelli-thinkpadt14gen4.remote.csb>
Date: Wed, 12 Mar 2025 14:32:16 +0100
Message-ID: <xhsmhplimpe73.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/03/25 10:33, Juri Lelli wrote:
> Create wrappers for sched_domains_mutex so that it can transparently be
> used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
> do.
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> Tested-by: Waiman Long <longman@redhat.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


