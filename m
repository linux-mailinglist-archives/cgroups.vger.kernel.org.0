Return-Path: <cgroups+bounces-1213-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FD5838707
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 06:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E4B1F24776
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 05:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7CB525B;
	Tue, 23 Jan 2024 05:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqSXp1iC"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B14C6C
	for <cgroups@vger.kernel.org>; Tue, 23 Jan 2024 05:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705989060; cv=none; b=PepOukIqBX13QCBmdEgIfbcKWXzsy+zfldh/XlUFBMd4JvpWHbS09jWtZXCZ2g0Ij3zskeiNOJX0bV43b9gymnp1Kd8MOiK4dII2C15gixzJRM6oI5psrKRIlah1Qqb9Mdfm2V6Uxf+yp3iiWmmKBnBfm5i/e/IoAhPyLLru4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705989060; c=relaxed/simple;
	bh=uUGqYPWkqLqAuYLajkHeoiaksi8vyt5EtObg/cfEv0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFJal/IKWS51iEcGUwOlr6HBNdL0i9AaFGJni/MURaYWaeM/P1wg93oyV57RVcGC3CC0EaDulnRwx2o8PUDV0lB9CcoM8MpwQCKa1ylGvgRpB0Zw+wVszKKrViH4mO453dmorkHJoTF7mMxwnotN8TdGM1yHyO/68Pdq427znss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqSXp1iC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705989057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+rMK0KBBnQyaHb54gBf8clNL10ejkmGqcBgOHn7Pt4=;
	b=CqSXp1iCdSiNyjaubxzTh/Pgj+kOn2Vq7JlrhewGX/NrkqrteyRlp4kXK/yKdhc6eFlZXB
	mlLOnvnqaQrihRSFlbbm7saVO6gsikZ2fGthj9oJrK9FgnoCLBwXnj+n/Bvt6PjURu/vEN
	q9+pU3sWUdfCAD89gZpStPEJQuf0iOY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-JHn3VzyfMY6lUkIpG0Vk8Q-1; Tue, 23 Jan 2024 00:50:48 -0500
X-MC-Unique: JHn3VzyfMY6lUkIpG0Vk8Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9386885A588;
	Tue, 23 Jan 2024 05:50:46 +0000 (UTC)
Received: from [10.22.8.107] (unknown [10.22.8.107])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D71B9492BC6;
	Tue, 23 Jan 2024 05:50:40 +0000 (UTC)
Message-ID: <8075b1d2-1260-4f1d-a757-dc991d95710c@redhat.com>
Date: Mon, 22 Jan 2024 21:50:40 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] cgroup/cpuset: Support RCU_NOCB on isolated
 partitions
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Frederic Weisbecker <frederic@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
 Ryan Phillips <rphillips@redhat.com>, Brent Rowsell <browsell@redhat.com>,
 Peter Hunt <pehunt@redhat.com>, Cestmir Kalina <ckalina@redhat.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Alex Gladkov <agladkov@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Phil Auld <pauld@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Costa Shulyupin <cshulyup@redhat.com>
References: <20240117163511.88173-1-longman@redhat.com>
 <bql5g22ovp2dm33llmq5oxpmuuhysvdyppj7j6xvrm643xuniv@pkqrwvmqzneh>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <bql5g22ovp2dm33llmq5oxpmuuhysvdyppj7j6xvrm643xuniv@pkqrwvmqzneh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9


On 1/22/24 10:07, Michal Koutný wrote:
> Hello Waiman.
>
> On Wed, Jan 17, 2024 at 11:35:03AM -0500, Waiman Long <longman@redhat.com> wrote:
>> This patch series is based on the RFC patch from Frederic [1]. Instead
>> of offering RCU_NOCB as a separate option, it is now lumped into a
>> root-only cpuset.cpus.isolation_full flag that will enable all the
>> additional CPU isolation capabilities available for isolated partitions
>> if set. RCU_NOCB is just the first one to this party. Additional dynamic
>> CPU isolation capabilities will be added in the future.
> IIUC this is similar to what I suggested back in the day and you didn't
> consider it [1]. Do I read this right that you've changed your mind?

I didn't said that we were not going to do this at the time. It's just 
that more evaluation will need to be done before we are going to do 
this. I was also looking to see if there were use cases where such 
capabilities were needed. Now I am aware that such use cases do exist 
and we should start looking into it.

>
> (It's fine if you did, I'm only asking to follow the heading of cpuset
> controller.)

OK, the title of the cover-letter may be too specific. I will make it 
more general in the next version.

Cheers,
Longman


