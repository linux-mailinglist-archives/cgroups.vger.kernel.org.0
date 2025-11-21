Return-Path: <cgroups+bounces-12148-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF27C77513
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 06:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5EEC3592CD
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 05:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074192EC096;
	Fri, 21 Nov 2025 05:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/QTNldg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2/w7jO6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6EC2DCF47
	for <cgroups@vger.kernel.org>; Fri, 21 Nov 2025 05:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763701674; cv=none; b=I8Vu9UCnIYe3bI18ClSYc3DnhPkTx9g/gBWFBRLCFST4CShsLtWXn4x6TUVgqeS7dhy6euj8EFaAAQqe9WNZDYwgAbndvl7EwjdWXZBfbvNSxLA8mDusXPom0N4n1VFpc4C9gqYHZM9mtc+/hBFt7M2+zrQpBiypDde77XNgP/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763701674; c=relaxed/simple;
	bh=M4bU509Hi6y2iIef1Lo4i4r8kXSDq0QpDONxBWI0zYw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RWTINjXqx5HflU3y826AEZb69NOxQbdzhDUXpEuOHbev2MJc222UOhoMcPQaiw32MDnmfBKA0r6jLfC5eIWsNP3lWoWI8RPqoRN6eG65rY+ZCt2qsLJepagVmed0M1/YunQCrxtl+nnhzOTWDkZgOJ9vwnHcfcQNpUsPb5ixTm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/QTNldg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2/w7jO6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763701672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcqfPS7j13ZWD60dTrmDCM5p8py9aMO8JCZOetUJcKQ=;
	b=G/QTNldgPKdVTb3y4m+FvCk86Zl98LyNrTt/hw+QMC+I5aOoOiA2dDf8Ixneltb1APfOkt
	RrlNXuXCC4ecEiFT3KLz1fi1YTwqgN6OfyvZ0VQbL9CtIodyYdMj4p2yqErGkhQOcbODU2
	trA8wIXWuJCvkOjjdq+677+q8mHICcU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-hW_w_NXCPviMuReLdgLkQg-1; Fri, 21 Nov 2025 00:07:50 -0500
X-MC-Unique: hW_w_NXCPviMuReLdgLkQg-1
X-Mimecast-MFC-AGG-ID: hW_w_NXCPviMuReLdgLkQg_1763701670
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b245c49d0cso475239985a.3
        for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 21:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763701670; x=1764306470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xcqfPS7j13ZWD60dTrmDCM5p8py9aMO8JCZOetUJcKQ=;
        b=G2/w7jO6SxFsI878f7R3sLbULszbMTiKY8URWV0yQUrA63YLBNwiIsV8dnvFfUE82r
         OMqsJlb61ET/gZWCmbODzF4G1wjzyB6tPGIrPVsEUzLdP8PjOkHdNrXhN7zgcP5+eb+g
         9t0bSz5obIT1aDPECtbBSyN4QlFtU+DrV4/F8DaU3UZ/ykh/lrsxGen7TplJRAq4qrGf
         JaV3Oo5Y+SANmDscgZ6EczmhLSWdtnT1RNuC8yDZVBqTH6NAGqttte+G7SQ7Y6imLRYz
         pCHFPhbfdbpfzTaF3l7eNuH5IFgjP+GVBlHA+1DfwJc49OQqsDGpH/ztY1Etom3v82Vo
         94PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763701670; x=1764306470;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcqfPS7j13ZWD60dTrmDCM5p8py9aMO8JCZOetUJcKQ=;
        b=s3CZfVqD9mVtHrmiKXrl8ZbaVYbPChFZFqrLMmgooSjXj+7yhUjnza9G8dPv7B1gMT
         JodA10Oi1UnqEaROAcxmtl/0gfSQW9xTe1U45yfhmBiVoiA672/CpS5ItagRDoMAiWYq
         ruiwvmN8epoUnNew4ulOxbRVaKFXtFaVU8rvlEB8K3pEdhz6nWphiKWoWoaFdNNcFpPL
         a5cgSyHGXxNNysmYJpzqf2sxPgW2hd6pOK6lSVRaxI+5DD20vbkrQZDFKQC7bXwlPNgT
         GHUTFdonN4R6Xbrgc1d8TZHGEOsaXQvIf2K5rK558aaMmEGcLA1SrPZHQRukQ9NSKrDR
         37VA==
X-Forwarded-Encrypted: i=1; AJvYcCU0jOmuXGPa/00C7/GQmEJXwMIr4IE0FavymuJOd6zDejM3rpDEKnEHQZWdASn6BAbHoyQ86zgL@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpsAStOROU6zTUw43HcFcstOBkjjQXtBAIvyCsLxo/KWJ53mq
	mAw1gAfmakN1rVC0fxNH856qhqXpydwp5YWoSoq7uySXesc3o5wqlhmHXKRPeMmsNCNU4IiKD8X
	6fvD/pPtlLoMErtq2yazcZtcR+/32u3ONWjbDcqn+AF/9x2luuUj7uQmyZUk=
X-Gm-Gg: ASbGncuMW8aA6sphd6a3O9MIDbZitdZWe4DQCSViNzhv5mvBwq5lLitK7rZdcDldyz9
	UvWJe89x4wcgDd+eB1oprQjoASdV+zZ+61vo3n5TaCiI5VBKB5U5odE5Qe9nXUbtmYBY/NmXaj5
	FzzkaJfsin2I2gRAHFbG+SgprX5j/oH5yn9Bd6jVLobHtCb+TuqK2M5l08ZVA+9DeyqNYzL0hL6
	r8OZrHxiU1S88nniHOKooy6A/wbWZy1pYzp/EilfrSv0ei2ErWvoWAFnNst09eNEop8p3Mxp8At
	cKxVTL2VFeV9mc6czY00qw3TnsNJOecXVwErl3s4vrZ471GC8QdHZYk4uE7SyJmxkc2HXL5t6PH
	vUxOD6sTA7IiXX+ktDd9bc7EHW59IE0U9d775fIjqGQiPYqnDufLiSYYL
X-Received: by 2002:a05:620a:4405:b0:8b2:dd0a:8814 with SMTP id af79cd13be357-8b33d4afe3amr76000285a.85.1763701669779;
        Thu, 20 Nov 2025 21:07:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkAfEpATpg8tPvpQs+GS3hfE/hz9o5RS1C26qAzB+yAMLs90YO077Oj9VUdwtsb57bM+n7Zw==
X-Received: by 2002:a05:620a:4405:b0:8b2:dd0a:8814 with SMTP id af79cd13be357-8b33d4afe3amr75998785a.85.1763701669281;
        Thu, 20 Nov 2025 21:07:49 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295deaf8sm297373485a.44.2025.11.20.21.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 21:07:48 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6cd2dc59-e647-411f-ba3e-2a741487abb8@redhat.com>
Date: Fri, 21 Nov 2025 00:07:47 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup: Add preemption protection to
 css_rstat_updated()
To: Jiayuan Chen <jiayuan.chen@linux.dev>, cgroups@vger.kernel.org
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org
References: <20251121040655.89584-1-jiayuan.chen@linux.dev>
Content-Language: en-US
In-Reply-To: <20251121040655.89584-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/25 11:06 PM, Jiayuan Chen wrote:
> BPF programs do not disable preemption, they only disable migration.
> Therefore, when running the cgroup_hierarchical_stats selftest, a
> warning [1] is generated.
>
> The css_rstat_updated() function is lockless and reentrant. However,
> as Tejun pointed out [2], preemption-related considerations need to
> be considered. Since css_rstat_updated() can be called from BPF where
> preemption is not disabled by its framework and it has already been
> exposed as a kfunc to BPF programs, introducing a new kfunc like bpf_xx
> will break existing uses. Thus, we directly make css_rstat_updated()
> preempt-safe here.

My understand of Tejun's comment is to add bpf_preempt_disable() and 
bpf_preempt_enable() calls around the css_rstat_updated() call in the 
bpf program defined in 
tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c 
instead of adding that in the css_rstat_updated() function itself. But I 
may be wrong.

Cheers, Longman


