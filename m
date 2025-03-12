Return-Path: <cgroups+bounces-7015-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0050A5DE7B
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 14:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16BE7AC808
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 13:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1024A07E;
	Wed, 12 Mar 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwAVtQqk"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7A9241678
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787727; cv=none; b=jlUs6LAcRYi7mnnhI4g9LiGsiYDuOvHRRNwd8ZS3syLckAcVZErscrWNMSBHc9cTgSzoDmBuq3FxZejDtZMFt3c2HNT7SHImpn8qN0+6codPpfTgB8TISFRn/ugtJp2bQKivhN//ARrFrdqNqMD9/omSrbq5e3smP4QT7aLJr6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787727; c=relaxed/simple;
	bh=waGX/WbcYLhodDWdtv3u8VXnMMJPTcIh3lEekoxXXw8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hxix9+VI+rOXMu4Wgvl6L0Tx6be92+uiV+C5x2KTl+iezOE9GWXO8KaDFyogrRb8NuHpu/6UGjIJDduHK28orW5WLAHDjhqan8GwsUgVFd3scGSPko5tS8iooSoka2R6akIDC8nQlv7CrzUX2sgm1CPeR4s1JitfLqj3H7YJ4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwAVtQqk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741787725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=beEL7oKIoj4c6NMjJCD6NPtHJyw6jjIiKvhBkjkgQJI=;
	b=IwAVtQqkAJaD1+xcVZzNyPmpcW/g8V2dJpVb/y50SwFj8QdD9i+2MASxY0oMl4bjaQBlM1
	e9nAYBDM9ZYxriDlA6Zm/bepckO6bc3G7Dn5ZBxvVI3e1n0Ld6wYDd1fc7TvnKI0fz0h+R
	I/EOE9fBa0epXwBGYFTX+YxFg3rpsn0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-Im7EZl_lNyikpYfI0hHuIA-1; Wed, 12 Mar 2025 09:55:22 -0400
X-MC-Unique: Im7EZl_lNyikpYfI0hHuIA-1
X-Mimecast-MFC-AGG-ID: Im7EZl_lNyikpYfI0hHuIA_1741787722
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e91f6bb296so57658836d6.1
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 06:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741787722; x=1742392522;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beEL7oKIoj4c6NMjJCD6NPtHJyw6jjIiKvhBkjkgQJI=;
        b=mdXqKE29acT0+Gjf2zZ3ga1FZgmzSETGz05pQb7G8IVxbNGVQcM7gXa9ctEvSlqghj
         GHMEHdEG1PEDJwbgOXa3XV6yVaPAPm4qEnBkmDUma/qBeU1T2It9uEfhYaXMpnBYjqfd
         MTtPQLaBUHGhM57nksfCETyDJWE6jg5L1gkCiuQlUznYzelkXYSCrk1W5t3rLvHPSZ7M
         kq/El4qhApKKaBrypEhi6b+5JtFiTTn/2Og8D0B4IaGPtaYnkCGbaHME+0dx0JpkbO60
         2Ai9sE5hgtuNnLOBCwVvefGlLws1G0sCrp9cZ38vFMOxZdEgvOhU6T/2hbA9qELcAD+9
         YwOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/ctvMSmZrxGmFJidiQZcj17rmxTMo2Sv24xgFE/uWDYfAl6Bl0DCYonss4IcucA00qBghGzCn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxie11dCxqpG0hndEzVli1Eh21UrDYhdAcGw9B/Vv1G7jcbLgoo
	/t0zbOdS6jDkS73XBpk1t10+Z/QhRMToTTHqxf8q26SJVMUGv3PIJlBEBDMBBVA6yq7voHf2mLc
	5rJFcLelfwrK7SnKKnqIDPaeetKz/sh5dGf0/e5FucSvZLWx+9Uoc0Hg=
X-Gm-Gg: ASbGncslKrSjQgv3EgJO8rm6N5GN3HBKUkUI+VBPY3BCx4tmD9mLWUbs+s1ynuNfk/h
	d/icCihJNmJ/SOvxLDtdHrGcUhC/MrWhv2+hS9w4Z1ifFJ3g/isq1+IKeZ1bY9pGlg4D7FUBN6X
	hqh9tMqnLKdBQczs+BdGblxUhD6wYXNEe3KuAFeakuR+AMWqM7LUN9MH7zHXI1qGhok9HfQcwNl
	vmxO0H+oJzeJ9Pwhubv8DItag0LaL5ghqmSjUcS06dfK7UYkOH5KvWMMjDa9iSMTQDcTWPIAAkV
	H9lvEwvRsA6Fda7qgX3Y7KwyKFq9TC1wX2PSAHk2P/Ye7NJObF12sRCRqdTbBA==
X-Received: by 2002:a05:6214:2a8a:b0:6d8:b3a7:75a5 with SMTP id 6a1803df08f44-6ea3a6a652cmr90592596d6.42.1741787722399;
        Wed, 12 Mar 2025 06:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcHl07t33fQl/ulieOA+NEsEZUKtE90Y0FLOq+2nBxlUUr7PD4+hO+Dx0rMwUoCKeYdoMyow==
X-Received: by 2002:a05:6214:2a8a:b0:6d8:b3a7:75a5 with SMTP id 6a1803df08f44-6ea3a6a652cmr90592256d6.42.1741787722078;
        Wed, 12 Mar 2025 06:55:22 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f71709b9sm84932156d6.115.2025.03.12.06.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 06:55:21 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d38df868-bc65-4186-8ce4-12d8f37a16b5@redhat.com>
Date: Wed, 12 Mar 2025 09:55:20 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
To: Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
 <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
 <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
 <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
 <Z9Alq55RpuFqWT--@jlelli-thinkpadt14gen4.remote.csb>
 <be2c47b8-a5e4-4591-ac4d-3cbc92e2ce5d@redhat.com>
 <e6731145-5290-41f8-aafb-1d0f1bcc385a@arm.com>
 <7fb20de6-46a6-4e87-932e-dfc915fff3dc@redhat.com>
 <724e00ea-eb27-46f1-acc3-465c04ffc84d@arm.com>
 <Z9FdWZsiI9riBImL@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <Z9FdWZsiI9riBImL@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 6:09 AM, Juri Lelli wrote:
> On 12/03/25 10:53, Dietmar Eggemann wrote:
>> On 11/03/2025 15:51, Waiman Long wrote:
> ...
>
>>> You are right. cpuhp_tasks_frozen will be set in the suspend/resume
>>> case. In that case, we do need to add a cpuset helper to acquire the
>>> cpuset_mutex. A test patch as follows (no testing done yet):
> ...
>
>> This seems to work.
> Thanks for testing!
>
> Waiman, how do you like to proceed. Separate patch (in this case can you
> please send me that with changelog etc.) or incorporate your changes
> into my original patch and possibly, if you like, add Co-authored-by?
I think it will be better to merge into a single patch to avoid having a 
broken patch. It is up to you if you want me as a co-author. I don't 
really mind.
>
>> But what about a !CONFIG_CPUSETS build. In this case we won't have
>> this DL accounting update during suspend/resume since
>> dl_rebuild_rd_accounting() is empty.
> I unfortunately very much suspect !CPUSETS accounting is broken. But if
> that is indeed the case, it has been broken for a while. :(
Without CONFIG_CPUSETS, there will be one and only one global sched 
domain. Will this still be a problem?
>
> Will need to double check that, but I would probably do it later on
> separated from this set that at least seems to cure the most common
> cases. What do people think?

I am not aware of any distros without setting CONFIG_CPUSETS. So it is 
mostly a theoretical problem if there is one. So I would recommend going 
ahead with the current patch series instead of spending more time 
investigating this issue.

Cheers,
Longman


