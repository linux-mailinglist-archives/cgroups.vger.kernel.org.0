Return-Path: <cgroups+bounces-12047-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D9FC661DC
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 21:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55A49345365
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 20:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CDA340298;
	Mon, 17 Nov 2025 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKpk+ct+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="p2rYetMs"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0201DF73A
	for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763411844; cv=none; b=b2BB4Q488r8zrM+B8fDl3iZdgjABS7stXyVCaDaf+eZIMw8vXYmGGTew16Hje4+vcxaSMRVQcgqPcURY4Z8BoFRQ5/eYcHhZRp65iBQgOQ0U6yrGvlvZdH5EvW9Glj6D0+Q4Kkn+DesGwomgFmh2XyoP+ySS3d0HqXj9hYzBuzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763411844; c=relaxed/simple;
	bh=SmPR+A59MooYRc2WJidnDJCDD3wZZK2HbZ/vnM2OMwo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QYsO1567dn+V31ZHPQ3FXhlNlCiK/eRzs/2E17gsUYT2iDV2D/xQrSFSmpBEEpo7Om6MUPw6wHK2uEEgoPtm53tjpNIuiBBxkGReihc8eTQNvITLiDUOWait17x7zawzqKhl9XqhD3IlNIuCjJY+QX65SnFMBOcTOxnF2zOCu6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKpk+ct+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p2rYetMs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763411842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NH+JjbVFS4evMnwZjaAY2ijL6D93KhWvJesUB02vD9U=;
	b=SKpk+ct++Sl6yVxCe/mnTFsrPDxLFbgJt9Rn24CuXeSSV6lG7AaVtDYYFPp/H5hh0EVzIq
	PHKzoTvhN+Eoghbm4+vvDPM+UEq8Fg+WXBrV8V/SzqniZGN1yXs1ME67nLtHG3YEFXrbnw
	QDXaXbf+ac2LbJaGPiO3itqvyhQF2z0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-hknkttgNM9Wd_9YDTRvvFw-1; Mon, 17 Nov 2025 15:37:20 -0500
X-MC-Unique: hknkttgNM9Wd_9YDTRvvFw-1
X-Mimecast-MFC-AGG-ID: hknkttgNM9Wd_9YDTRvvFw_1763411840
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8823f71756dso64379066d6.3
        for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 12:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763411840; x=1764016640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NH+JjbVFS4evMnwZjaAY2ijL6D93KhWvJesUB02vD9U=;
        b=p2rYetMsI9iu5LY/aflJHZME2Ueb2rsolz/ywTVeKVIu1cq4PXyELw2q9SKb6nZ6Jz
         nnLNCcD5O5adtIxRjrakd4c8Q7n2XtNajKKU4O+nYGLgdpNqnpc0Av3rbut5Eoc8qSOG
         1AjujrCBmD7uTjYgyUCoTOoDKVI9Mn2OKQPME1oHYz0l0YQ7QynF4E0cHMHC8mouFRtZ
         ++VSC4w6XdZf0yS/O+M9ttXVHhzRgBDgw4BfGoNu2yHpmP5Lq/LBFZ+bpfCfl2beNQIo
         NgFFjvrhVZ3pMiCbFhWoTmUXZutyt6vWc9E7E0Z2Zl9g2kZzgx/4t8tucry63864HzNl
         b4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763411840; x=1764016640;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NH+JjbVFS4evMnwZjaAY2ijL6D93KhWvJesUB02vD9U=;
        b=uaBaIm939Ln0MWqjzwFfzAqVSw0qAhot7MqhnSe5LI1c2lUjBMpQOjsCVgo7x8H91k
         juQlrVfECiT3O2+SeNphIW1kbAPpNfqFRTUNf4Yc0nf9Ej43vaThO0wPlbVOQ3W26T4l
         5gjqgj6rbQ+YOM7mMQ4c9fzVYePz6bH31SJeZvGB65AecnD8G4cCZVIc8HJSFKPbI5Hc
         utZiMWh62YuboOSVWQZ+7LWfEkzZ7OAwcBj/11JTD7zRT8gTVGxcAEhFUq0ARnQZ+6d2
         zCXklT7Bo42tZCIiqFvYiw+6kn/JW8AghpqeZvesG+CkzxBn9reRsRs4m04tTbfT7XD1
         FsGg==
X-Forwarded-Encrypted: i=1; AJvYcCVJE7q7L6C+V5moeRHOJLZo1JFPE7TRXC2a0/KILQZMOKfXXTP+O+MX+UNkAKQluNfHrWksmtVJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8dcPAdohXHjumutjCEuKZpyp8zTEE4hCIJhSXKlNEL2Jg3DNU
	PeebkBfcZ/gf/jKgeCAU/smvs/K6h2b6Vp6sUGRROmvjFnF3HQjG7FL79pIO8L7GZb2wha+yCh9
	GaVIaIesNaoOKyrsn9JRiELymejGszE2oydr6nKaxk7PCF2cJDOfBZ9oH/Xw=
X-Gm-Gg: ASbGncuTPA6VIpZ1YFuJA7CmELMjOQ9cn6c71EoShIqV3YS5cJoFJGHqFcVlvUYhNRC
	V4cbf2oD5JGKF0hvuf/ctabAlmQwhWGzvUEtUZSwoUMmVyOEUr/aFY2ETjFrHn280gy4EzSmGR5
	xrLiQ1DDYlj3erRk9Gy9FekXvr1doCERMIJ4ccf3vHYziSh/fvA2kuhc5exJ217PinNqjWRrjyq
	ebHamXnNHfYQ8cGNQSpG/l54D3j1hiCRje0da+nL6sFSxMGIHuLwHYMgGh5ncv5ZHrsgP1A0DBH
	voWy57cTZ4RjUXrqIjPN3vNGzK1hHqn6QNQsiDjva/XgQcL3Rs1VT7ySsT74L5pH9DkGVRfd3AX
	afDFenyc1M0LuKoi8PtsFywF1vwc845Kj6jzpR9B1zNAHwA==
X-Received: by 2002:a05:6214:c65:b0:882:4dec:42b9 with SMTP id 6a1803df08f44-882925f280amr200935266d6.26.1763411840284;
        Mon, 17 Nov 2025 12:37:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFBq9DDNquaCKU7McYtmHMkXKL2oozerHAJiNvFCEr30jW86RIcnuOYpR+b7DJwQSQmAjbcg==
X-Received: by 2002:a05:6214:c65:b0:882:4dec:42b9 with SMTP id 6a1803df08f44-882925f280amr200934896d6.26.1763411839858;
        Mon, 17 Nov 2025 12:37:19 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828652c882sm101791536d6.32.2025.11.17.12.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 12:37:19 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <97ec2e86-cb4f-4467-8930-d390519f12a6@redhat.com>
Date: Mon, 17 Nov 2025 15:37:17 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 1/2] cgroup/cpuset: Introduce
 cpuset_cpus_allowed_locked()
To: Pingfan Liu <piliu@redhat.com>, cgroups@vger.kernel.org
Cc: Chen Ridong <chenridong@huaweicloud.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20251117092732.16419-1-piliu@redhat.com>
 <20251117092732.16419-2-piliu@redhat.com>
Content-Language: en-US
In-Reply-To: <20251117092732.16419-2-piliu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/17/25 4:27 AM, Pingfan Liu wrote:
> cpuset_cpus_allowed() uses a reader lock that is sleepable under RT,
> which means it cannot be called inside raw_spin_lock_t context.
>
> Introduce a new cpuset_cpus_allowed_locked() helper that performs the
> same function as cpuset_cpus_allowed() except that the caller must have
> acquired the cpuset_mutex so that no further locking will be needed.
>
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: "Michal Koutný" <mkoutny@suse.com>
> Cc: linux-kernel@vger.kernel.org
> To: cgroups@vger.kernel.org
> ---
>   include/linux/cpuset.h |  1 +
>   kernel/cgroup/cpuset.c | 51 +++++++++++++++++++++++++++++-------------
>   2 files changed, 37 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 2ddb256187b51..e057a3123791e 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -75,6 +75,7 @@ extern void dec_dl_tasks_cs(struct task_struct *task);
>   extern void cpuset_lock(void);
>   extern void cpuset_unlock(void);
>   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
> +extern void cpuset_cpus_allowed_locked(struct task_struct *p, struct cpumask *mask);
>   extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
>   extern bool cpuset_cpu_is_isolated(int cpu);
>   extern nodemask_t cpuset_mems_allowed(struct task_struct *p);

Ah, the following code should be added to to !CONFIG_CPUSETS section 
after cpuset_cpus_allowed().

#define cpuset_cpus_allowed_locked(p, m)  cpuset_cpus_allowed(p, m)

Or you can add another inline function that just calls 
cpuset_cpus_allowed().

Cheers,
Longman


